Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B9EC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5z0-0004ys-M1; Thu, 20 Aug 2026 12:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yy-0004md-91
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yv-0005cR-4P
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDeGx4lsnD3gIC+ysZwu/5kmuhaNZCo/ri7XQJW4wwg=;
 b=J+bmFUOQW9jloBBLiyCnjHdhcqBxF8U9HbCMm9WTTe9iKXbltaAF+S8lsEQGcqqmSyWNkC
 8wJOeZ9Gzk08ldHZuIcQ67l0NsVDDA27qoTsNvPk3imGUNvN2MI6svyqC+AtB03slAMS9B
 LfPMoVYlFi1MHALYZTH5rxljozyuGK8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-cu1uWwVaPsCWWXcW6APkog-1; Thu, 20 Aug 2026 12:51:00 -0400
X-MC-Unique: cu1uWwVaPsCWWXcW6APkog-1
X-Mimecast-MFC-AGG-ID: cu1uWwVaPsCWWXcW6APkog_1787244660
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f83416551so82680f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244659; x=1787849459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iDeGx4lsnD3gIC+ysZwu/5kmuhaNZCo/ri7XQJW4wwg=;
 b=ckHj/LDn2xAe6BEhAAvIrtPNQ62V1qg/bN67dRo8xexP+JrpgdNG35qfVTa8wTH/gt
 oUnv+8lBN7Zjz57pHOf3FlpVkemXVTHZ2e0eOSixBiDv3bPe8mAGhAWfRUEl7rAAsU29
 Z3i8qu3d7FF8cbWnXjIZLawuhLHGi2+8TglwF0nXzdu6McrlSpbEOFxZhkEKusKChJgx
 dQ0qpMau82eU6Kh+WvCZyJV9w7vXuqYBCgl4Dl3ENJHq5SXs5CiWy/KWoP/vTuZPQWdO
 AwA8mgsoGFBzwjpC7YXwUSUSgtwo8X1rinzmBl0rh5GXMNn1PM3q5bwg+U6OqCCbg6L3
 ApeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244659; x=1787849459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iDeGx4lsnD3gIC+ysZwu/5kmuhaNZCo/ri7XQJW4wwg=;
 b=BE50WNhh3StqQWfg4sdEy4XHlWvb5COgGrwGiSqS7sBM/l8daoGS8KeAhtLb5I5rZs
 BRT36DA/MXbgdrdHL2qenF7RstPktMMVv86YckT/9kUwUCfjyS3u0t1ERG0cxMVd2g7o
 EQUqlWdgBvgYmvQNo+AQwJSQnpo5gdNhqn2ajxv+iRF6uMH+LRyEm26H76ZVlMJAV8lU
 lOtUHdHbrzaiVKvckJr5HlA8pqfU/AVRcEKW7vMnVVdOOoi7n80zGh1Vk4cdkLav2GdY
 Edcd6QgPDvg5Qzcc1rBbMhn8I5loqEhwMG1aHBYIonwrfaTxngKXO/o50EQooUOHaEuj
 k/rg==
X-Gm-Message-State: AOJu0YyVhvjE1DtwJIUWd8+8eMR1UhKEbZ+JqhRTw+NTVZYUmOfc3PFH
 H/atQ+xfNo/+Ode/0M0P5Rw5uhbjOvH+Alkf3VAVOvIQ/b5mIiaAFkM63ZhTvX1rNa3YC3YOs4c
 WBxSNVkgX2uTCBX5c+z31Q+aeVhRzMa3SFP+z8MLNqFbIS9kcBsX04pEc/9VXt/oZa3QDbmBkxA
 oCpQAeUkibf4s3Y2WrICh85v/u2G+ww45M62WUNCej
X-Gm-Gg: AR+sD10TUFN8DXLyBLBR6ZiDGrLmo1XXIQrnu8DE/l/lvYXkIoHOXAjmCd1/yTZFkIH
 sMGLCYfWd/RZvtdpvXfafP32gzZDCfgaaPATjSeOgd9hfA6ovX3RaHFWXF7JsGC0oojI1HzYmJ+
 AgUN7Z/8oiin4YvmrAfJBkE2IDlpG6EAE8gJjDNNLaOMJ0YOatNjjuiKMR1LqdF1eyNnWStyuv8
 SSZc0dPYeua74uZUWR6BJMfItgxyBihdifuqvYtPX3gfB8fM+ZSMSh5vSz38M6sv33FTzNkBW60
 vHKDTlHH/Z/9E2RspAwrtuejI/cQ4BV12idkHC0p9jdIPGKJo537Fi+AkpLi2B6YQ3cElB8TWXt
 jWLEOcEJenTAui5Jx99y3BgS/D9IHu3ie0hMdqZlv2zW0j8zyxxWrIGyaVzbXItXVN6Vu1t2o9Y
 yjNjA=
X-Received: by 2002:a05:600c:3556:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-499b8454819mr2870245e9.11.1787244659560; 
 Thu, 20 Aug 2026 09:50:59 -0700 (PDT)
X-Received: by 2002:a05:600c:3556:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-499b8454819mr2869265e9.11.1787244659055; 
 Thu, 20 Aug 2026 09:50:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499affa25acsm94802585e9.4.2026.08.20.09.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Naveen N Rao (AMD)" <naveen@kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PULL 20/53] target/i386: SEV: Generalize handling of
 SVM_SEV_FEAT_SNP_ACTIVE
Date: Thu, 20 Aug 2026 18:49:23 +0200
Message-ID: <20260820164957.1895963-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Naveen N Rao (AMD)" <naveen@kernel.org>

Align with IGVM files providing SEV features with
SVM_SEV_FEAT_SNP_ACTIVE set by setting the same when creating a
sev-snp-guest object.

Since KVM sets this feature itself, SVM_SEV_FEAT_SNP_ACTIVE is unset
before KVM_SEV_INIT2 ioctl is invoked. Move that out of IGVM-specific
section to common code.

While at it, convert the existing SVM_SEV_FEAT_SNP_ACTIVE definition to
use the BIT() macro for consistency with upcoming feature flags.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://lore.kernel.org/r/031de849edf2ae4eaa6e00df83b053605a3ecfea.1779281646.git.naveen@kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.h |  2 +-
 target/i386/sev.c | 24 +++++++++++++++++-------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index 4358df40e48..b84ca3ce0b6 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -46,7 +46,7 @@ bool sev_snp_enabled(void);
 #define SEV_SNP_POLICY_SMT      0x10000
 #define SEV_SNP_POLICY_DBG      0x80000
 
-#define SVM_SEV_FEAT_SNP_ACTIVE 1
+#define SVM_SEV_FEAT_SNP_ACTIVE     BIT(0)
 
 typedef struct SevKernelLoaderContext {
     char *setup_data;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index d7dcefc8ecf..7b03f534b10 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -324,6 +324,15 @@ sev_set_guest_state(SevCommonState *sev_common, SevState new_state)
     sev_common->state = new_state;
 }
 
+static void sev_set_feature(SevCommonState *sev_common, uint64_t feature, bool set)
+{
+    if (set) {
+        sev_common->sev_features |= feature;
+    } else {
+        sev_common->sev_features &= ~feature;
+    }
+}
+
 static void
 sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
                     size_t max_size)
@@ -1899,15 +1908,15 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
                     ->process(x86machine->igvm, machine, true, errp) == -1) {
                 return -1;
             }
-            /*
-             * KVM maintains a bitmask of allowed sev_features. This does not
-             * include SVM_SEV_FEAT_SNP_ACTIVE which is set accordingly by KVM
-             * itself. Therefore we need to clear this flag.
-             */
-            args.vmsa_features = sev_common->sev_features &
-                                 ~SVM_SEV_FEAT_SNP_ACTIVE;
         }
 
+        /*
+         * KVM maintains a bitmask of allowed sev_features. This does not
+         * include SVM_SEV_FEAT_SNP_ACTIVE which is set accordingly by KVM
+         * itself. Therefore we need to clear this flag.
+         */
+        args.vmsa_features = sev_common->sev_features & ~SVM_SEV_FEAT_SNP_ACTIVE;
+
         ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
         break;
     }
@@ -3211,6 +3220,7 @@ sev_snp_guest_instance_init(Object *obj)
 
     /* default init/start/finish params for kvm */
     sev_snp_guest->kvm_start_conf.policy = DEFAULT_SEV_SNP_POLICY;
+    sev_set_feature(SEV_COMMON(sev_snp_guest), SVM_SEV_FEAT_SNP_ACTIVE, true);
 }
 
 static void
-- 
2.55.0


