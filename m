Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0FCCD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrcp-0003bP-Is; Mon, 04 May 2026 07:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrci-0002oo-Oq
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrcg-00017T-AH
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OVmQ7IUeUk12NUknieiIH7qn0uIUvETj0FJeOsX0UJY=;
 b=RRJoRhCQ2KFJtS0JlzSajiMdUG+XIrInsYw1PDmCA2D1BOUC+//xDgHEu9GPXrHVPH1f+O
 5BFE3nagvCDKYOmsV3qdh6CNiTkTrXsscOCmeKeG/mnaPOML35NB8d63mxrhcnPNvyRfLs
 fw46pXSaME95O/QMJcNHhpKMPGtZRvU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-q3q6YFaFPZK3lQODvOpSYQ-1; Mon,
 04 May 2026 07:37:58 -0400
X-MC-Unique: q3q6YFaFPZK3lQODvOpSYQ-1
X-Mimecast-MFC-AGG-ID: q3q6YFaFPZK3lQODvOpSYQ_1777894677
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5C1E1800366; Mon,  4 May 2026 11:37:57 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A83530001A1; Mon,  4 May 2026 11:37:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:16 +0400
Subject: [PATCH v2 28/46] scsi/pr-manager-helper: free path on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-28-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=822;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xkwAcgxCLEsSnJnOju9M5/XFWfwI9OD8yYJlkmPakUQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRtBxrwfx1k+VMOrCEFbSOrmVFzEqHaC10fS
 LwU9SSBhNGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5UMID/9a1shVChUuSZSMsz7VxZhHohExTsONlnb4EwugLnhkPvTI3LEDgdaGCJIq+HZ2FyTp72K
 377a+hq+sjJSMgYtEJh7z2TpT/4u/S96KW86lXX0xwZRaQyY6jKCQ7++sDvAUzvxNAPn1rHRa72
 Y+elm1WTGj6fDQLULnMiJMRJJnshngHX2lx//ViIZYAoaEBXHvJOhzM/OlErlvpWpwX6UB3i/G5
 sAHWUQH0cu5UrQe+O5RA+jkl2aS/YuCeIi7495YULFYP+XREnphxupmDjsUR+JtVwdmsCn6Lym4
 SzAxOBV5DzvDciFNNvL3SAilH99Prb8xBHzVPTkx34PAywytZlLe7qPLz83QzGZp7xZjQvkcONM
 Sj3fWF+P1iK1DkSJpBK+sNBWbTsB/cS+HQyGqfN1AGkm8ggAhFq5xHVennHuC8JCJtWSw8DkwAH
 +Qk0VDwn6qQu1f1+WhI2KEL24CEibUIYdcfgZ9503VbAwBrce+i2sTiSAvknK1+RxObVCyDBzx2
 OiRKeRvDB+2+AUI1PXptA/fK/3ciWN3viWrD5dVUI6w35YDSB9QlZb+fmQya737b9+EnKaipzdR
 6jmKrdV6Mx/DiMMYH1BuDxS6h+wVDPtq46FThU6kLbaXdU4mIRqomkXUXbEhjkXsuRmRNCP80wT
 gsSBbw20hYN1yDg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

set_path allocates path via g_strdup, but
pr_manager_helper_instance_finalize did not free it.

Fixes: 9bad2a6b9d0a ("scsi: add persistent reservation manager using qemu-pr-helper")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scsi/pr-manager-helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index f6454cd80de..53432e6d606 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -284,6 +284,7 @@ static void pr_manager_helper_instance_finalize(Object *obj)
 {
     PRManagerHelper *pr_mgr = PR_MANAGER_HELPER(obj);
 
+    g_free(pr_mgr->path);
     object_unref(OBJECT(pr_mgr->ioc));
     qemu_mutex_destroy(&pr_mgr->lock);
 }

-- 
2.54.0


