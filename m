Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF63FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRtU-00066U-B4; Mon, 27 Apr 2026 15:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRtA-00056z-AH
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRt8-00086O-Rj
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c50C/fqcjt5STbS/kpqFqW5X5bJR7MmNwC/4fZ513P0=;
 b=jWAkRCV9iK9NlaR1XlZXLv4ozo+IET81sOkL4h3Nt8FFmcmNh7aYKbv8wDpt7vtJfIT/nF
 ujhtEI0kal+c+BQOoiOEJSd9UGpfJXjoD3oQ60DHWfaUeca25VHQlqK3A8YFHuPY4Uq4tv
 B2WDBtXVN7DtFMz+dUCElGutuOzYCD8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-LNYHKle_OKamkUrb1QlVLA-1; Mon,
 27 Apr 2026 15:44:58 -0400
X-MC-Unique: LNYHKle_OKamkUrb1QlVLA-1
X-Mimecast-MFC-AGG-ID: LNYHKle_OKamkUrb1QlVLA_1777319097
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA6B31800370; Mon, 27 Apr 2026 19:44:56 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5DA19196B8FB; Mon, 27 Apr 2026 19:44:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:24 +0400
Subject: [PATCH 25/41] scsi/pr-manager-helper: free path on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-25-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=767;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UiXn9NoTnAbA1lpC5ACGVlHyT0tT/S14loIvcqiqBV0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVQFo5/JdU7UJEeBDIXOPDepvW3z36FkcLa
 DxcwscRFqCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5YkxD/4h/of3wW9SvwaPUQDMFt/Ci44GRCwXOeFdRMH9mraL4rl0VURNIT41LyteFBPsmiVEVg7
 YtmHL+d141fDfq9btax3IhOVSNPdhk8LLtWcqEnCwrQ9SQ6ZkeNI08dn2CF/Gb0wjSKue7ePSPS
 fanh+8wRLszWu+BIoSjlnuwvHG2tz1QYRynsPRTnbBgWNyDQuOlhoqzQMfERPftHjwN3DSg3qg9
 mbAShRlpDjvOWstC1ta9nFiNptb8ni+tzfaajCqbANEOlh2Skt76r5/D9Eg4LV47cimrxgvqZjE
 08hzjL0zR1kT3D1vneQT594pJeo8EQ3zTiab69gQvCX/oSOh5T68AUVpWMosPBF8ocC2Mbl9ng6
 aOklbuGb684LHB0OT2qRQEWlZ+1586jBV0Sm2s6KyWcshK/IymiS4bRICFQ/v6cnx3alFvd33ud
 qVeAPOR2UNvufa7bmtDtGy42pkeCKm/z62rDWMvPFV9yXowy+XRCaMhmJCJ4jrWGD7sI8sAJBFM
 SUm1IZZP+Fg6SWWBWljCoCL41HLpKOAYcGny1bBcpj1G9ejVDvSAqcrTP9bDamUATHcbW93VCaW
 4Lyk1uzGARkwTSfLM+GM6WmY5GWZgKfhdTrGMgm1CZv2a0E0Z4+PgWH//nngE/JJ1MrzrCt3vje
 D4Kv51k+C/HN/rg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
2.53.0


