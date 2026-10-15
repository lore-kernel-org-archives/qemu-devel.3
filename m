Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C298CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ7v-0001I9-Rl; Thu, 15 Oct 2026 06:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ7d-0000fP-PU
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ7c-0008Ik-55
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYOBeP6bdutDj9DF92EjpNF+kD2umbGy4zv1Lan1Z8s=;
 b=HofBCImo3Rtnq34SEVCd2KCkSS8efOjF8I1xKYnxbkoZnOBY3X8APZojiaybX2Bv4WXO+T
 o2BouFGykbUyX4yQ9BC3bnkU6tOiLGux9jIwee11XLjnJ7yvLN6JMiP0sBgEMwEnTmDP1y
 Pd7B7a14bvS3yJYTmj/yTBZ1lBOTtg0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-ysIy0-pyNVKN3BKnL_Zjmg-1; Thu, 15 Oct 2026 10:55:32 +0000
X-MC-Unique: ysIy0-pyNVKN3BKnL_Zjmg-1
X-Mimecast-MFC-AGG-ID: ysIy0-pyNVKN3BKnL_Zjmg_1792061731
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48b01a74792so3400874f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792061731; x=1792666531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fYOBeP6bdutDj9DF92EjpNF+kD2umbGy4zv1Lan1Z8s=;
 b=SQ8jB8vwYlCuWA8YHJAeUySmDeqgQ3aeHyJZ1muyOvnR2DKSG5KaEnIBQK5ezO/M/B
 heQ/lcVyAzzm+GES02pDRGyqrjVI5xV64a4tDeZkGnaMPNQZ2BIWF8uHkSdT0K5bUvL4
 fBF7v2ySxNjn3kcyOW443JRZYEbj+ibtjVtKeER1oz6fJqbxljKlMdCfnECP9rwUh7zp
 OLbXOSZKcXo60s+efPizNT7O2I4DOPPqxnQCrWGTf5l0JrnOaCXEQR4y2xoWmhjdKS93
 C6Tg92pA9/6WOCCkXIDtBRveteh/3DH0nMOR/G/hUcH4qnZPdPiYhnA8LCt0JotAvGu+
 CENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061731; x=1792666531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fYOBeP6bdutDj9DF92EjpNF+kD2umbGy4zv1Lan1Z8s=;
 b=eUDO+Q+zIxg1segxkW71cgCLI/JRfvBrQaB63GVZ7T1GVU4NfH4eSrrfVA5GHRgS5A
 kNJJfWhg9FOR1h9CzdnlOHDDucoOvvgqthul2pzYNHWlHjqtjsz/945fslmBEstN/nui
 0/qd2EyegArisgwcRIK5/FaPDlOvjB47mL1iLOSvmoUtZoU/ule3nqXfbWo76e3/tsPi
 jKbt91fimJ5ANAwHvgFyMx8iJxHpAmViW9O2k6iNGugHkcC8hkb9O5bFDz5wNOZHBXnJ
 6FSWxg44Dbb61VPdUf9nZEqQz2+F/hpAPvLd83s9DnOfKW/ryIUA1a0voVz+53knyML+
 arzQ==
X-Gm-Message-State: AFq9FYLrastiUQ9ykMIH3Sqx40u2pEw4+sb01UsYcUNvQinEqiLH/wcM
 si5jgdv8ri6nYdvbLj6OmgKBZWdaRPIr5O4Tv0GRZ9uS3scUlcRSuIek88LzSJiaqbjLNPOigB+
 kS/Vy998FUqHb3kM8jvJrbHPY9n6SpwcvJSiUxax12R1RVe6vvNJyBEYmntfaQI1QSHBRemXVHL
 gDKTh6SITAxbfHJc08EWXOn6gApD653Qqb38tf2aNT
X-Gm-Gg: AYBFou3CannCAdbaqAKZnDJpJsh+oFoL9S10DSlbQXUsu635jHXLvl6hFqYEF7IW66G
 zkHuoTPj5P6CGTZU/GwhT6wCBi/5Mrt5b1EJDFiLf6c1OxEOF9Dugcz+qU6Aqi5HWyTJa9XS0mU
 BczXX91pxsFZFX+qxx77+avY/IO6Zv+G6PmKJWQrssT6L/jGs9Yj74ZrFr2Nv3oMwXMkmiJPDJ+
 zU6VDP+J4tqBNf5zIRFtjizZPmBVpo3Qgs3Lzeoko5Q4tsrSzQNxywq17r4lTTFByiq5zdSvhoA
 LYLfTgZmkon/U7sPevC80JNSIarv8aRziO87iHEFevAL+TV1a0HLaZRFHdFaqIuBte+ct8gB8Lq
 M1aWXSlQtLHz4RhXtkwdek8inZbKNHVumQNjL5E82GD9xldyW6iyz3uXCyhFC+mFE1YnKELx5mK
 HSYHBK
X-Received: by 2002:a05:600c:8b11:b0:4a1:ac85:9696 with SMTP id
 5b1f17b1804b1-4a1ac859a48mr157382725e9.17.1792061730894; 
 Thu, 15 Oct 2026 03:55:30 -0700 (PDT)
X-Received: by 2002:a05:600c:8b11:b0:4a1:ac85:9696 with SMTP id
 5b1f17b1804b1-4a1ac859a48mr157382325e9.17.1792061730390; 
 Thu, 15 Oct 2026 03:55:30 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd7319c6sm71903385e9.0.2026.10.15.03.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:55:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 12/13] scsi: use REGISTER AND IGNORE EXISTING KEY for robustness
Date: Thu, 15 Oct 2026 12:53:46 +0200
Message-ID: <20261015105347.827029-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015105347.827029-1-pbonzini@redhat.com>
References: <20261015105347.827029-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The regular REGISTER service action fails with RESERVATION CONFLICT when
the I_T nexus already has a key registered. While we don't expect a key
to be registered, it is fragile to rely on this. If there is a key
registered for some reason, live migration will fail when the
destination hits the RESERVATION CONFLICT error.

Use REGISTER AND IGNORE EXISTING KEY so that the command is likely to
succeed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Link: https://lore.kernel.org/r/20261013181752.1299456-9-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index e41e973aa92..e48fcb926f1 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -424,7 +424,8 @@ static void scsi_handle_persistent_reserve_out_reply(
     }
 }
 
-static bool scsi_generic_pr_register(SCSIDevice *s, uint64_t key, Error **errp)
+static bool scsi_generic_pr_register_ignore(SCSIDevice *s, uint64_t key,
+                                            Error **errp)
 {
     uint8_t cmd[10] = {};
     uint8_t buf[24] = {};
@@ -432,14 +433,15 @@ static bool scsi_generic_pr_register(SCSIDevice *s, uint64_t key, Error **errp)
     int ret;
 
     cmd[0] = PERSISTENT_RESERVE_OUT;
-    cmd[1] = PRO_REGISTER;
+    cmd[1] = PRO_REGISTER_AND_IGNORE_EXISTING_KEY;
     cmd[8] = sizeof(buf);
     memcpy(&buf[8], &key_be, sizeof(key_be));
 
     ret = scsi_SG_IO(s->conf.blk, SG_DXFER_TO_DEV, cmd, sizeof(cmd),
                      buf, sizeof(buf), s->io_timeout, errp);
     if (ret < 0) {
-        error_prepend(errp, "PERSISTENT RESERVE OUT with REGISTER: ");
+        error_prepend(errp, "PERSISTENT RESERVE OUT with "
+                      "REGISTER AND IGNORE EXISTING KEY: ");
         return false;
     }
     return true;
@@ -620,7 +622,7 @@ bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp)
         return true; /* no PR state, do nothing */
     }
 
-    if (!scsi_generic_pr_register(s, key, errp)) {
+    if (!scsi_generic_pr_register_ignore(s, key, errp)) {
         return false;
     }
 
@@ -647,7 +649,7 @@ bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp)
      * CONFLICT is expected if our registration remained in place.
      */
     if (resv_type == 0) {
-        scsi_generic_pr_register(s, key, NULL);
+        scsi_generic_pr_register_ignore(s, key, NULL);
     }
     return true;
 }
-- 
2.56.0


