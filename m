Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCCAE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQxS-00047F-EW; Sat, 27 Dec 2025 04:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxO-00042B-6K
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxM-0007UT-Ll
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMfeC1qlGyQBU+oYdudT1wA8cDp85oJp5sp29r1hMGw=;
 b=X5C99Zr+cjAmANcDSBX9e/5xi/qHOEVTXuk9Z+G0pPqtSS4qoWhd92VX0tOKDrg5zPbmfX
 rou6tidbO5ttMvDIxIqRx3QXtIAbvrLLXyWaDs88Ygc4X2MygWXoMu8qN3y/I1rvrlXsvW
 U3kOwAUmR8Ebkbd+OJb+/YWtNxuArg0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-Xq9W42MgOr2b2o305_2TlA-1; Sat, 27 Dec 2025 04:51:26 -0500
X-MC-Unique: Xq9W42MgOr2b2o305_2TlA-1
X-Mimecast-MFC-AGG-ID: Xq9W42MgOr2b2o305_2TlA_1766829085
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430f57cd2caso7690434f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829084; x=1767433884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NMfeC1qlGyQBU+oYdudT1wA8cDp85oJp5sp29r1hMGw=;
 b=Flei8qsKhJOFSd1Nhzdo2s9rxBnDBFWDhDlPiCGVtiOe6+CGJT5oHGoy2pRoNBZkyF
 vOO701HllRR0N8Mt7H+yXE5XeFGzACUIiVl6QJvR3uijSycaEWloHutIOy/5uig0wEU8
 MJceTIF/B882An8x5dPBVWiKB36p/7xwNVzVBpCYzb9tTT/F1oUdi8qjqkVlnwIyip6N
 LYdKKLdNs/Y+ikn4Zc7/Zywt46ESnhfuNVtIe9hDe7tCvDv8zMsyCB+DV13/FiaBjom1
 JYznewkHK7oALEOFTC1cqNmplhdY5Vkm57psnDgaxZouQg7m4RdDmxHKLotTOaByUNbI
 t/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829084; x=1767433884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NMfeC1qlGyQBU+oYdudT1wA8cDp85oJp5sp29r1hMGw=;
 b=U6rYBQ7AOkTFAjQIpqOY+JFJCoqKful9zDPzeaQQ9iM6PU1LHWeJEy4rpX5VMOIN81
 fywpwCfEk5C87X6RR0g2lXIssem3qHdv5wxLutPHxRN8LXBLKvK66JTgb4Xd+N+eRx5C
 dDVJxt2pulKLSdRpOM40Yc5FunOU0xuxB4wv0oc4+Jo4/bv2pR1NZGbCQI7TYO8SUxR5
 qsrY6QKf7PvPm57y3mGE47E6yLRz5CSi4FS9HP6NBOh+DHPteMaZ/hByd0uDazl1Rond
 sQQWHfTPds9MjZOhxTYDWuTiJW4iUmRFMxlq45NkkK1PaksP7NcqZt4Ftj4Qg6X6aViG
 npOQ==
X-Gm-Message-State: AOJu0YzSrBsClnudr5DtrhCHHs8eVgY5dzBcQF8RWdo2AOOna0kM33rS
 tPhSxmoLsrXHuRBPGjUQSSTSeFQh3Tug8vK6OSwVMkChXRCINuWTl5VszcTTsBC963Pxs1lH0Y2
 cWossHDYo3dkf8AiNVKV5CfhBApoxlQMGyD8jGVKeCVeDC1s+qQg+8tnjTEoCC5yh8SoOqbhTv4
 ukg3oa/y2Amp3k/An8chRhntvv4GJREEBCIlDkEp6D
X-Gm-Gg: AY/fxX4WctT2DvZf/0+jegb9AaZkR0uS5r2q01nqEmzXs72e1BQDoZ1UYmBQaCZMujp
 2HaTi4eGW84HscNUmVxZ4l0BroDCz+Et11HCO/CksR7oXYWs1HkICcYzG9q4KVUvYe67CdHg2h3
 IB4D/kEgskbEYf0kDqmSIlFzruzFIEt9q7PnG3hZTL/trapV5fkMOiXv+ry18TtPM+Q8UDWUhdn
 M8x1gGoRRKI1esg7KC87xs4hEHH17p0jNqlPHKnLnIvwRg+4rM2Hx1KPsEjHmU/xtO4Rce4Q1Mx
 Uzf2/+VXzcYcXOk65hVxhDHWSXv1izu5/Q11qDFpIK0lDwVoVVNsOotj+lhCeXyA3Bk+9aeHiF+
 CcDaXIvi2lZfsyQzFHY6Fs0wrLs/7JujoEc1qByBci57N+2i1TerMKRZ4xOhEDZxsQKC2SAmpvy
 qeKByxZlL9wB8+R7I=
X-Received: by 2002:a5d:58e9:0:b0:432:5b81:480 with SMTP id
 ffacd0b85a97d-4325b810a80mr18706711f8f.24.1766829083870; 
 Sat, 27 Dec 2025 01:51:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd3Wt98qUIwz/sQy4OqXdV8R0vtPiYE39vdb56TeZqYjOLazBmxyoqQkgWex7kXwAciA1cHw==
X-Received: by 2002:a5d:58e9:0:b0:432:5b81:480 with SMTP id
 ffacd0b85a97d-4325b810a80mr18706693f8f.24.1766829083343; 
 Sat, 27 Dec 2025 01:51:23 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2beasm49032870f8f.33.2025.12.27.01.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 141/153] i386/cpu: Allow unsupported avx10_version with
 x-force-features
Date: Sat, 27 Dec 2025 10:47:46 +0100
Message-ID: <20251227094759.35658-67-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

The "force_features" ("x-force-features" property) forces setting
feature even if host doesn't support, but also reports the warning.

Given its function, it's useful for debug, so even if the AVX10
version is unsupported by host, force to set this AVX10 version if
x-force-features=on.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251215073743.4055227-7-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c460e3bec7c..f62bd48d4b0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9490,16 +9490,27 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
         uint8_t version = x86_cpu_get_host_avx10_version();
 
         if (version < env->avx10_version) {
-            if (prefix) {
-                warn_report("%s: avx10.%d. Adjust to avx10.%d",
-                            prefix, env->avx10_version, version);
-            }
             /*
-             * Discrete feature bits have been checked and filtered based on
-             * host support. So it's safe to change version without reverting
-             * other feature bits.
+             * With x-force-features=on, CPUID_7_1_EDX_AVX10 will not be masked
+             * off, so there's no need to zero avx10 version.
              */
-            env->avx10_version = version;
+            if (!cpu->force_features) {
+                if (prefix) {
+                    warn_report("%s: avx10.%d. Adjust to avx10.%d",
+                                prefix, env->avx10_version, version);
+                }
+                /*
+                 * Discrete feature bits have been checked and filtered based
+                 * on host support. So it's safe to change version without
+                 * reverting other feature bits.
+                 */
+                env->avx10_version = version;
+            } else {
+                if (prefix) {
+                    warn_report("%s: avx10.%d.",
+                                prefix, env->avx10_version);
+                }
+            }
             have_filtered_features = true;
         }
     } else if (env->avx10_version) {
-- 
2.52.0


