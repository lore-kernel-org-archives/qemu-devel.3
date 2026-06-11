Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC940CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 13:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXf8O-0003p2-Df; Thu, 11 Jun 2026 09:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <molenoch@protonmail.com>)
 id 1wXasK-0000qN-R8
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:34:56 -0400
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <molenoch@protonmail.com>)
 id 1wXasJ-0001ry-0j
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1781166883; x=1781426083;
 bh=hDMz4oY8/6JWOeUudtWSE3ZzAJzjYviDYxC2DL/IFog=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=P5okgk1IZcYOAhJR1HMyB57gSZGO2zkyYwpKTWJ4hCjgOeRlkdzqBK7i5hb92q0RN
 KLsGzUdQBXu5lsrjVahIunXx0KdXvGn8aYrVt2ckobbldhqlzpuGHKcylsYx5DqnbL
 Blcj/jRJ4usn7dLVoVJ5nh/BQkbcWMOi8TGI3EmkrZJ0anHrehZy3DI4d3WgPxYwEz
 4WXfSSc9mJUSkji3KVSy269cOr2+sxuoVhgSDSHpdP0MuamlGlmWFPEXtFgyeR0ANo
 VjVDTUSSoyvkFWLY5OifXNhiLNct6WEqbWB39Cq6iQzm50MuwtMuRW+p0UgokORmtT
 5JEgm/Z/Y+ivA==
Date: Thu, 11 Jun 2026 08:34:36 +0000
To: qemu-devel@nongnu.org
From: Anastasiy <molenoch@protonmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anastasiy <molenoch@protonmail.com>
Subject: [PATCH] target/i386: raise #GP on reserved/unimplemented MSR access
 (RDMSR/WRMSR)
Message-ID: <20260611083422.52858-1-molenoch@protonmail.com>
Feedback-ID: 105841658:user:proton
X-Pm-Message-ID: 623c7cef2c31239149ba35d653e20013765a6921
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.206.169;
 envelope-from=molenoch@protonmail.com; helo=mail-05.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 11 Jun 2026 09:07:46 -0400
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

Three locations in helper_{rd,wr}msr() had '/* XXX: exception? */' placehol=
ders
that silently ignored accesses to reserved or unimplemented MSRs instead of
raising #GP(0) as required by the Intel SDM (Vol. 2D, order 334569):

- helper_wrmsr() default case after MCE bank range check
- helper_rdmsr() MSR_MTRRcap when CPUID_MTRR not set
- helper_rdmsr() default case after MCE bank range check

Replace the silent fallthroughs with raise_exception_err_ra(env, EXCP0D_GPF=
, 0, GETPC()).

Signed-off-by: Anastasiy <molenoch@protonmail.com>
---
 target/i386/tcg/system/misc_helper.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/system/misc_helper.c b/target/i386/tcg/system/=
misc_helper.c
index bb79d4e..e559d8f 100644
--- a/target/i386/tcg/system/misc_helper.c
+++ b/target/i386/tcg/system/misc_helper.c
@@ -318,8 +318,7 @@ void helper_wrmsr(CPUX86State *env)
             }
             break;
         }
-        /* XXX: exception? */
-        break;
+        goto error;
     }
     return;
 error:
@@ -442,8 +441,7 @@ void helper_rdmsr(CPUX86State *env)
             val =3D MSR_MTRRcap_VCNT | MSR_MTRRcap_FIXRANGE_SUPPORT |
                 MSR_MTRRcap_WC_SUPPORTED;
         } else {
-            /* XXX: exception? */
-            val =3D 0;
+            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
         }
         break;
     case MSR_MCG_CAP:
@@ -493,9 +491,7 @@ void helper_rdmsr(CPUX86State *env)
             val =3D env->mce_banks[offset];
             break;
         }
-        /* XXX: exception? */
-        val =3D 0;
-        break;
+        raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
     }
     env->regs[R_EAX] =3D (uint32_t)(val);
     env->regs[R_EDX] =3D (uint32_t)(val >> 32);
--=20
2.53.0



