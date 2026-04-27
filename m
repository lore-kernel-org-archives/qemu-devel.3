Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A05CFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRtA-00050p-2S; Mon, 27 Apr 2026 15:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRt1-0004iI-44
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRsz-00083k-HF
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNI+7RuNgeguzRcMAnuOXHaYamCM21plVJM8ieUdN0Y=;
 b=CiNMw02K5jt9SApjpOYMK1YAfxDJ+WVcRmrvNeyRmRmV3pm9ycJHO4ZXWXeFHsXAzmBbJ+
 HeGIKwt2U94H2jIl7X5EuX8CK52wRsAiUlm8emShFSjAE33JEf6OTyp9So+gbTDUnccD2W
 vTRM1e7nH2VnL7LHUxSuifjhg+DbZnU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-EhEAy0_3OzW9-T40XtVfKQ-1; Mon,
 27 Apr 2026 15:44:51 -0400
X-MC-Unique: EhEAy0_3OzW9-T40XtVfKQ-1
X-Mimecast-MFC-AGG-ID: EhEAy0_3OzW9-T40XtVfKQ_1777319090
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97E7B195608F
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:44:50 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA951196B8FB; Mon, 27 Apr 2026 19:44:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:23 +0400
Subject: [PATCH 24/41] backends/igvm-cfg: free filename on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-24-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=624;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mwo7Gc8ngczrYSCsTlaVmEs9ndTwAzIJd46MK4vsgA0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVeSdX18imhdsbfAOwwyQ1PwuqS+VzC+C3k
 0FQfSvHdeGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5QPuD/kBzm4VTlQmfP0YtAtTUnTQyGhAro0LhfyngVJXxM1avfmQEN/mCeZUPM3dE9m/C0Ex36p
 ynNBbjGC7x5SbYPTxGvSpzaHrasuqk5CtOfoFl9pvGjtcxNDWfFlmUjjFNX+kuu4tFcizsnlm99
 ePrsB4po4ga68BsCcEEe47MdTpzqMEUWFNAYkCEdzPU/6DjNWltYWdxYAIlY1IlQFjhUqKr0ViP
 BldQ4X97Vh1YJNdHsmIFhf1v7DnAyTiG/oTHja/KelmqG1dLhH8Y/gCbP+9yboMX0XJ/wzV4rLW
 8LtwokNpA6B0Y5OXXtsk3ZLj/hK+Dze5HV92nivdtGDjqBLHwsi0NgD4S1rnsQzjrR5cl04Lo2I
 rNX7nN/lXWq5XbWI4QZJInoB/obdivrFklCpVXp4vhNqxoaVwASK1vefLch8TFhkLYSQOVWhCtD
 jdIlcsMQpUdS+ZG3WySXKklYGj4hYKLdosjkciTlPVRnTL7zJBcCXwNt0q+0V9Bfa/EdRXNUkEy
 R6NsCsTUNlfc2XoT3COHLpWFaAcQ4yTJJ0ko2klGkD6LSlW8b10X2Xve/ZNZVmva6B1hnsWRsxi
 DM9SfQqiMSYcUfEqKTnK6nWFfW0ywg94ikY+fP8jvafaxKE0MtGEpXl8QP/8FbI1MqU5Hu1XMJr
 yAG12J000lZSYXw==
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

set_igvm allocates filename via g_strdup, but igvm_cfg_finalize
did not free it.

Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/igvm-cfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index 64589ca34f2..e1f09855f66 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -108,4 +108,5 @@ static void igvm_cfg_finalize(Object *obj)
     if (igvm->file >= 0) {
         igvm_free(igvm->file);
     }
+    g_free(igvm->filename);
 }

-- 
2.53.0


