Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E3ECAC58F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLMs-0001TN-Po; Sat, 13 Sep 2025 04:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMl-00010e-FJ
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMh-0005EQ-Kx
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gxJgysm4LwVfPs3QtBRp3Oe8eEcJlz8X5Th6PWbDrkU=;
 b=ihH6JIIICv5k4jvMv9WqtTc3QoB+u/XOcgCj14L0IKdSOCxgjK6hB11c1ityk+mmC4c1k1
 mzKjPSadxPnLQCLGLtra02s8AfYEriHm3Re70+ZMW36aWZbodbtPDY63sofAKZpTYVgG6r
 bTyrnfGdDb8wOmPmhhvBoT+pP9f6Eaw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-k2Tx882jOfSG7HLtCYpUVg-1; Sat, 13 Sep 2025 04:12:09 -0400
X-MC-Unique: k2Tx882jOfSG7HLtCYpUVg-1
X-Mimecast-MFC-AGG-ID: k2Tx882jOfSG7HLtCYpUVg_1757751128
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3df9f185b82so1007539f8f.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751127; x=1758355927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gxJgysm4LwVfPs3QtBRp3Oe8eEcJlz8X5Th6PWbDrkU=;
 b=cJmjOyuFZCenOhMA4FFNF4zZqwtaa4Eugjgypf+cTMp3QcysbHR7UKalWPziBmvaZY
 7z/OIsTXImnIB5Tg4YMqiMNOFAi5/hxbxHD1zlp0bjL+QNUyBXxpTt7lVExGakCHDkEv
 S+AU3yZssumFvqSdr5vZdOxpVmS/lec78N1qcU7j8vnmJ0El1DYfOg4NJ554r1C1u2sz
 nslgiryb/IZHfUzz0zWS9fkRFwVgll81NmWK/FDZkT3G5piKLqb9kfieY5EmXBCK6Bjj
 j+2NOrBTHZ3iFHRINuskXK/7GZok5WGuHC/NUnDfYetp5TpVfQ5t4g5EictsJkxNXDD6
 FO4A==
X-Gm-Message-State: AOJu0YxDF+gikSXixDRqPWRvqch4YOTcff8A90zZC3PI29UDOvLLAve6
 LWRHsMN+UoRwITAnPeaBBmtfAw7wtQtZDo16mL6Avg6vi+nY5qekpQyR5fR8eYZzx8ub8T6jJkk
 KUw4WwoBVg5Qp2x/u0+TabrU6dQV2TMsSD90sN3bl+4JJXZOT0zoqXNgyJ64z/3zIyL1qV6jV4g
 C3Vgc5ZyOSbW96LcCva4WOAKnIn43v8AqcATHsUR/C
X-Gm-Gg: ASbGncsYKThPoKjGwaJ1/K+BdGjMMPzhDSnHaIWRBiZvhAWeRXbMEOeKbk718uEqDlp
 ruBuK36PjWeQ1mI48sFwRCrs+/ZZPWG29cmXv2jm2bAxebJOWWHZPDhqJvOX2U4Nc2aShxlsAoz
 ZUSp0/4CmB9EJaHIw8GoU3po7gJ3hqJOxw8/Glc6z3zoaoUzyuWShICRgwp/rVYivw/5vbu+pgB
 WMwBdoCsnyorc8XeOzTssiTc/804tvnE0GiG35MrCkjdNF9FJtin8e/9vAGrduEs+nIrW3FIVeA
 Sz38DxHTm6wDS9BV5dywij7wIFoogMfyMUkVQPNvfJC9oPVoX5INIrAd8/r0jhZ/D9SBVlAwoj7
 FlpYbHGiHL6Jt+zMKYHIBWD1wCmu0TELlOYMJaBKuoWM=
X-Received: by 2002:a05:6000:40db:b0:3e5:190b:b04e with SMTP id
 ffacd0b85a97d-3e765a140f0mr3626247f8f.37.1757751127315; 
 Sat, 13 Sep 2025 01:12:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE38kjpgKpyLh38ey7vU6pY6kl6eVmA+qDvMnKS9fdMyvVv+FLrbSA0MKRjkdfb25puvO4clA==
X-Received: by 2002:a05:6000:40db:b0:3e5:190b:b04e with SMTP id
 ffacd0b85a97d-3e765a140f0mr3626223f8f.37.1757751126797; 
 Sat, 13 Sep 2025 01:12:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e81dbf9acdsm2652297f8f.55.2025.09.13.01.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:12:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 51/61] rust: meson: remove unnecessary complication in device
 crates
Date: Sat, 13 Sep 2025 10:09:32 +0200
Message-ID: <20250913080943.11710-52-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It is not necessary anymore to explicitly list procedural macro crates
when doing the final link using rustc.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250908105005.2119297-33-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/meson.build | 3 ---
 rust/hw/timer/hpet/meson.build | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 628a5238702..ffdc8af53f1 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -44,8 +44,5 @@ _libpl011_rs = static_library(
 
 rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
   link_whole: [_libpl011_rs],
-  # Putting proc macro crates in `dependencies` is necessary for Meson to find
-  # them when compiling the root per-target static rust lib.
-  dependencies: [bilge_impl_rs, qemu_macros],
   variables: {'crate': 'pl011'},
 )])
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index b6bb9477f0c..bb64b96672e 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -16,8 +16,5 @@ _libhpet_rs = static_library(
 
 rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_dependency(
   link_whole: [_libhpet_rs],
-  # Putting proc macro crates in `dependencies` is necessary for Meson to find
-  # them when compiling the root per-target static rust lib.
-  dependencies: [qemu_macros],
   variables: {'crate': 'hpet'},
 )])
-- 
2.51.0


