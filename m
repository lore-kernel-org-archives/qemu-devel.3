Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C5AC5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yy-0004o0-Us; Thu, 20 Aug 2026 12:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yu-0004U4-Qd
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5ys-0005b2-TR
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=johAxnEead98P7nJRpW8CC1fh54YCcvqBd2m+8U/+pY=;
 b=X3XUm7wylQ5DwNk1dp05S//XyLvBYEoeCFZI6EkWH7lqMM+Oz5MOYoJZaVUauF2LXE/xGA
 peaScyalMXAHLViFa2yt1QJH56ViaHxoJfvXSy6R9qgt2wVDhEjKC+dbHx1IDjs7Gl60G5
 SrRPp0d2iUcX+Jstg8BT7VJtTTP7U/0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-xyyZKFJ8NR2A1NGPc7aGgA-1; Thu, 20 Aug 2026 12:51:04 -0400
X-MC-Unique: xyyZKFJ8NR2A1NGPc7aGgA-1
X-Mimecast-MFC-AGG-ID: xyyZKFJ8NR2A1NGPc7aGgA_1787244663
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f83999cceso96359f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244663; x=1787849463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=johAxnEead98P7nJRpW8CC1fh54YCcvqBd2m+8U/+pY=;
 b=m/AMvgMBk4Zs2dSRPPJA/dTbpcEmSfKpzKnBKRYyteU3SxxrUli5Vmcjl9wuqJRAIf
 ezSwXbZ9tRgJ2xYgBdDXDCGKjd0cwnAmlqpeuiQATqVvlhpId6mHrOYV6BIuVXij+xcD
 Pr5Yl98RgjPLYk9weEPcLEM9HI/+WlGaXlM+k1axU07+woDRBH7hmv78k9yevzzrir4y
 VBtOQFjp7+mwLp8kbVj1VbwWQuQhbyC8IeAowbbUMo06qWLrFF4QyqyplIHNSJeskki6
 83AxNLcK+HjYOYYmkA1qi4y/IAmkYbOeF31mvc9Uhoc8liixkqq3lAa2Et2B8ADyv+PQ
 WLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244663; x=1787849463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=johAxnEead98P7nJRpW8CC1fh54YCcvqBd2m+8U/+pY=;
 b=fSxSv+xidilAgRBc0iHGQzRMc3aVtpujUtszxlKV1LEQWrpckH9B4GfPjD1xuoRhf9
 E+HZSlJMx40fXZDOPCoBkyO3sz7ern0Drz1Xn1ftAXuCM0IZMBFCkCfHsjRWRFWtFZhu
 8cjcroRxtDA6hQ6hogGZy5uUSNKZMJQyqk4zwbjrJ2V2QZ1T0GczzfXZpFAR+AzDzp6t
 UGxMJUt6rB01atCjphwd3WZvipUzzdBCajeeShYRZYXzvXY8Mw/4jCm7UhdNe3CFZ2As
 5pnailQpeFjSv8F0xV60XSJV0J3fRN/+ySxIOaL2tbp73yQSUauaHq7etO/ZXJbRCUrG
 V8sw==
X-Gm-Message-State: AFuF++kLvx71Rhe0mp8Kd0ilSoE8PSOUc4CKxp48qdxDv/STp9rEdFS6
 +r53l/GF8cpintdQLAH37AEosL6p9Fe3Ee/1kqf2le/pyvC7ZulJJnwiiKzOfhvj5nv1MZeDmwD
 dG9J3c4gpT/OMaMYS6MFGMHZ4F6CalD0ZnextN8Na1hlzGjeU0HRQJuB/6eAtAJJmNXKd+SsxyB
 iGScQHOKdCZL0o58kxI3+YucTnyRxFZw/tHEPaFBPQ
X-Gm-Gg: AR+sD138WMaoo8vz8TP9ws1R2UIMS/z78WUm0echQE9n8CZm8yf8ux5ziR6wEiCh0+0
 +n0QRqMnFfFWXQtbmGZQjCWpqgdYhLzUoPpc3zF/G7nZNEHIXdKSoMhrWT/0o01JDfeSBpcka5S
 5AsU4iWqPxv3M9NAl+Nu4p50SeTlF2cMGsCetmersE0fxfGYhBwLTmkBdNU6LkSfOdacsKIoEWo
 17LhatQY+wQ8K4HgPFYbbahXc3FYn06rl3i7Nw54LimUyZEdyjz1TCakwhrUd8zGShqO70Ad5Dk
 jQsxEX7Mf+Lip8dS/Q4IqTtF+5/Qf8Qk+KnPil/0t9xIQIH0VgCkFEhYUefbvT1b5pfpXvnvqy1
 utVffPPcpzFvGBDnAfd7xpV3Pziofngkq9YfR9DepxGicU+GEd4uTSBKKzWfCyOL+wK9rfd78VW
 ggTxU=
X-Received: by 2002:a05:6000:2209:b0:481:573d:9d29 with SMTP id
 ffacd0b85a97d-482b1fdb100mr25099356f8f.14.1787244663268; 
 Thu, 20 Aug 2026 09:51:03 -0700 (PDT)
X-Received: by 2002:a05:6000:2209:b0:481:573d:9d29 with SMTP id
 ffacd0b85a97d-482b1fdb100mr25099293f8f.14.1787244662776; 
 Thu, 20 Aug 2026 09:51:02 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b7d4asm12123479f8f.21.2026.08.20.09.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Naveen N Rao (AMD)" <naveen@kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PULL 22/53] target/i386: SEV: Consolidate SEV feature validation to
 common init path
Date: Thu, 20 Aug 2026 18:49:25 +0200
Message-ID: <20260820164957.1895963-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: "Naveen N Rao (AMD)" <naveen@kernel.org>

Currently, check_sev_features() is called in multiple places when
processing IGVM files: both when processing the initial VMSA SEV
features from IGVM, as well as when validating the full contents of the
VMSA. Move this to a single point in sev_common_kvm_init() to simplify
the flow, as well as to re-use this function when VMSA SEV features are
being set without using IGVM files.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://lore.kernel.org/r/35449df94eb20c29923a7cd0e2742ddba605928c.1779281646.git.naveen@kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 093d29e7613..d8fb88d2b21 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -600,9 +600,6 @@ static int check_vmsa_supported(SevCommonState *sev_common, hwaddr gpa,
     vmsa_check.x87_fcw = 0;
     vmsa_check.mxcsr = 0;
 
-    if (check_sev_features(sev_common, vmsa_check.sev_features, errp) < 0) {
-        return -1;
-    }
     vmsa_check.sev_features = 0;
 
     if (!buffer_is_zero(&vmsa_check, sizeof(vmsa_check))) {
@@ -1920,6 +1917,10 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
             }
         }
 
+        if (check_sev_features(sev_common, sev_common->sev_features, errp) < 0) {
+            return -1;
+        }
+
         /*
          * KVM maintains a bitmask of allowed sev_features. This does not
          * include SVM_SEV_FEAT_SNP_ACTIVE which is set accordingly by KVM
@@ -2581,9 +2582,6 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
                            __func__);
                 return -1;
             }
-            if (check_sev_features(sev_common, sa->sev_features, errp) < 0) {
-                return -1;
-            }
             sev_common->sev_features = sa->sev_features;
         }
         return 0;
-- 
2.55.0


