Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299EBE8FDD9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQx6-0002R1-7n; Sat, 27 Dec 2025 04:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwc-0001Sf-K4
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwY-0007NK-N8
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XfTcb5DkM47QaQaWUoerV2EwCv6n/G+WapDxLoIPaQo=;
 b=JQFqYVA9LXE/afoEpBopgaH+L5Eqr89DjZO7bJn7HKf2KWhHnUbXbBc+CxMTcFeuP+u+/G
 i6f6c4PNlx0bXtHVlDvQQ9F+exYZ9KxX+6emNjq1RRDhuvL2iJJtJ+ZNGpx/Snew9b9jt8
 5TB8f9Kg85wAhQQnzKHoVcuSYlj34ds=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-JSi9VhT_Nr67x3aw5jGzVg-1; Sat, 27 Dec 2025 04:50:28 -0500
X-MC-Unique: JSi9VhT_Nr67x3aw5jGzVg-1
X-Mimecast-MFC-AGG-ID: JSi9VhT_Nr67x3aw5jGzVg_1766829028
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430fdaba167so4122725f8f.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829027; x=1767433827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfTcb5DkM47QaQaWUoerV2EwCv6n/G+WapDxLoIPaQo=;
 b=m6OPlXfnU6wGR1qybhJAqqg6myHYsWBMfUrJMWrpLAEYGdYj+cMxuv6ga1ixzHOf99
 JXp2HXhthfdRIaLiW2qBuQA13GfZeKLq6hV+sdX3kvUgk6Fv0lUydBn2R1CLyY6PrOSI
 gv6TU6nEOiM96Y0XRMCZQ2WFtP2RR2uBqYW2yf4arJZLGCjF29fT4ZRqo3E6phWXF89w
 fe8WAhGKTTz7PMJxfuDiyNeoMTBDsBljltY/KtJACa3bNHhW2g4Rii/DeOJQQHowgmlo
 LXmXgSAup39PIt6De+kN7O6lIfleylAGcPT3fPd3ndg+WnzPLS43c+8ZjpeTuokgv5eV
 JDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829027; x=1767433827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XfTcb5DkM47QaQaWUoerV2EwCv6n/G+WapDxLoIPaQo=;
 b=WP23aEZmmrNGuEuAKxT8oQc0Q67v239FU+dGwhRhoMuY8VmNeFZ9n6M68grj575ndr
 TzUkqaFwEfbRKA6IEH24cXVvYc+SpfrtN+hQBp76BrpdQ8K8jO2vHjAiWA/rImsGWfM8
 65xoVJoSGMKM1fGfMLd2SB4UU6eygE4H6PwnN27t9zVzD5/O42CpurED7ysk27emKB3q
 a/gXbtahWuc1FaKGKw5AIO2M03ckF8W/V3sn3XwK12XS2AkNVBy42f4TGMyuXvogAJeH
 WpclqaPiwPc4tCZ19ovpvVf3lV53gcQirD6vBwzFrCNoY93iJ2s0xO8rdua2+eUIqWPT
 8z2Q==
X-Gm-Message-State: AOJu0Yzr8WRq5LZ4kHBoPPwVgzWSsiF7R5HXX3lq1jF9QLOV3H7c4dtE
 R42071iUkV1jnRWzRaiC27FwGwiyNEKkRVlWu5g6BgaD+KNThmcVGJkmqbEecj7xTc1SxDPWKRU
 TAth597q5wH2KN3T+oJz2KrnOF/3S7pFB5pPmjz24avGm1H8nPiiFG/nNYfgqBAdAbGhIhahe5Z
 KfIVWJtqY4aIOaKTBbzB/qr1w1qqahJDvJRNjEOpJl
X-Gm-Gg: AY/fxX6SgRBmSoB6+BWWaCWR92XqwguklsRGNBR2s4Kl2Wr9u4HCI8EkwDdpF9YwAkC
 dH6l36Rf9gwwjVeJ+nHUSFmy4xynCCqhEE3TQ4Pm+F6Xk2BFzJ/U8xyxYYnt2orWmWL0h97z2uD
 fgdqnyOwElPKpZT8y1d2PwbWkS923PHNk9qC9rBus8ksk0TWY2wOhv7XsF/MbN4IUMHR6nLhdoT
 DQwmWE79Rs3PeISLQHMVcria5QvkDVeZTo5PsUkZr0aAeq1AEtx++fe3eGADkWk4CJSZ20H0ws0
 6hIl6NKjxmgMQSTh3JeM19Y++SVKYujPNGdV3EewhwZJEf88vaTxG34q5CCm4m2vqp3xXaOzLBb
 fIw+WkSYmLJgDnlXumNxesDgj1vpwlGhjQBHNQSBESptSdKGWrfTFjL3aOmijg7VebGpXYVfdpn
 LPm6G3qAeo19OUUcQ=
X-Received: by 2002:a5d:5887:0:b0:431:3bd:3781 with SMTP id
 ffacd0b85a97d-4324e4f935bmr31095525f8f.37.1766829026583; 
 Sat, 27 Dec 2025 01:50:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYrl8cO+x5JXmJo+sTISWxRgHF5g9lJDGpWGrECTfWcTLZXttbEe8zX5Tx71JF0BLQn7vUbg==
X-Received: by 2002:a5d:5887:0:b0:431:3bd:3781 with SMTP id
 ffacd0b85a97d-4324e4f935bmr31095493f8f.37.1766829026130; 
 Sat, 27 Dec 2025 01:50:26 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b1bdsm49214662f8f.8.2025.12.27.01.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:50:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 126/153] target/i386/tcg: reuse gen_helper_fp_arith_ST0_FT0 for
 undocumented fcom/fcomp variants
Date: Sat, 27 Dec 2025 10:47:31 +0100
Message-ID: <20251227094759.35658-52-pbonzini@redhat.com>
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

For 0x32 hack the op to be fcomp; for the others there isn't even anything special
to do.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 32a371e2d99..cf5e2c158cb 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2777,10 +2777,18 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
                 break;
             }
             break;
+            /* map to fcomp; op & 7 == 2 would not pop  */
+            op = 0x03;
+            /* fallthrough */
         case 0x00 ... 0x07: /* fxxx st, sti */
+        case 0x22 ... 0x23: /* fcom2 and fcomp3, undocumented ops */
+        case 0x32: /* fcomp5, undocumented op */
             gen_helper_fmov_FT0_STN(tcg_env,
                                     tcg_constant_i32(opreg));
             gen_helper_fp_arith_ST0_FT0(op & 7);
+            if (op >= 0x30) {
+                gen_helper_fpop(tcg_env);
+            }
             break;
 
         case 0x20: case 0x21: case 0x24 ... 0x27: /* fxxx sti, st */
@@ -2790,16 +2798,6 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
                 gen_helper_fpop(tcg_env);
             }
             break;
-        case 0x22: /* fcom2, undocumented op */
-            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-            gen_helper_fcom_ST0_FT0(tcg_env);
-            break;
-        case 0x23: /* fcomp3, undocumented op */
-        case 0x32: /* fcomp5, undocumented op */
-            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-            gen_helper_fcom_ST0_FT0(tcg_env);
-            gen_helper_fpop(tcg_env);
-            break;
         case 0x15: /* da/5 */
             switch (rm) {
             case 1: /* fucompp */
-- 
2.52.0


