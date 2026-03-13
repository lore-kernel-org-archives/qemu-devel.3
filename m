Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEACC106FD66
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 02:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0rtS-0006Ob-Nb; Thu, 12 Mar 2026 22:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@rail5.org>)
 id 1w0rtJ-0006OE-DX; Thu, 12 Mar 2026 22:04:42 -0400
Received: from layka.disroot.org ([178.21.23.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@rail5.org>)
 id 1w0rtH-0005Ru-Bo; Thu, 12 Mar 2026 22:04:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 590A626422;
 Fri, 13 Mar 2026 03:04:35 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4k0sGehwEejS; Fri, 13 Mar 2026 03:04:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rail5.org; s=mail;
 t=1773367474; bh=1tmBxD0eCD2oVG6SaWkLHYJqdTiWbe2PhMUCcnnfR7A=;
 h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References;
 b=DF5fQ0SQ0txLJYgtsiSRDDBS1hNsqwNi/FXIfanVhy751A4lJRvxSv04NT4RZSTum
 lidVTj/DNjAO8t3rvBK0sV5U0LjzaexXdlxhe2nAWggYLWuMaUItHiOJ0OK6tTGesX
 K8Z+IchXUJU00+0Ec++rrK9GuHxWyHggRhkd3Zb0/yDd3K0XcRxTcqJf3J7B9xdI6S
 MvI0W3d372ehOd91XMCG7wZDz75MY5XKaB5XVO4kO1aOpXq/7EDGuArPbtPey1rweR
 P6VMPayAp4fDbnKcXIh0QfyNVxFj2EwaUmqDTGInGsrkvXV8ZwdDslCjd1Hqo/nIdR
 5dmPzqOZFAVDg==
Message-ID: <36380340ce49dda41ef9d933f0d471bc520de797.camel@rail5.org>
Subject: Re: [PULL 1/2] target/loongarch: Preserve PTE permission bits in LDPTE
To: Michael Tokarev <mjt@tls.msk.ru>, Song Gao <gaosong@loongson.cn>, 
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bibo Mao <maobibo@loongson.cn>
Date: Fri, 13 Mar 2026 10:04:27 +0800
In-Reply-To: <3db74cf4-3676-4e18-96e8-61b91b17c316@tls.msk.ru>
References: <20260310114442.1025328-1-gaosong@loongson.cn>
 <20260310114442.1025328-2-gaosong@loongson.cn>
 <55df9b3d-702b-445b-972a-6671a1b9270e@tls.msk.ru>
 <e7fbf3677b84a53d44769b1711a69a1c52332c19.camel@rail5.org>
 <3db74cf4-3676-4e18-96e8-61b91b17c316@tls.msk.ru>
Autocrypt: addr=andrew@rail5.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
Received-SPF: pass client-ip=178.21.23.139; envelope-from=andrew@rail5.org;
 helo=layka.disroot.org
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  andrew@rail5.org
X-ACL-Warn: ,  "Andrew S. Rightenburg" <andrew@rail5.org>
From:  "Andrew S. Rightenburg" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 2026-03-11 at 13:30 +0300, Michael Tokarev wrote:
> Please take a look at https://gitlab.com/mjt0k/qemu/-/commits/staging-10.=
2
> -- hopefully my back-port makes sense.
>=20
> The same's for staging-10.1 and staging-10.0 (10.0 needed additional
> small tweak).
>=20

It makes sense to me, but 10.1 and 10.0 still have the recursive PNX bug. I=
've
included backported patches for those two down below

>=20
> Yeah the Fixes tag is obviously misleading.  What's the actual commit
> which introduced the issue, if it's easy to find? :)

It looks like the "mask the whole PTE" bug was introduced in d2cba6f7ce
("target/loongarch: Add other core instructions support") when LDPTE was ad=
ded
initially

Likewise I screwed up the 'Fixes:' tag for the other part of the patch as w=
ell.
The recursive PNX exception bug was actually introduced in f757a2cd69
("target/loongarch: Add LoongArch interrupt and exception handle")

Sorry about that. In any future patches I'll make sure to be more careful a=
bout
identifying the origin.

Thanks for having been so patient with me


---8<--- PATCH for staging-10.1 ---8<---
From caca7e3b52c369722eae921365613319596d9c81 Mon Sep 17 00:00:00 2001
From: "Andrew S. Rightenburg" <andrew@rail5.org>
Date: Fri, 13 Mar 2026 09:48:19 +0800
Subject: [PATCH] target/loongarch: Avoid recursive PNX exception on CSR_BAD=
I
 fetch

loongarch_cpu_do_interrupt() updates CSR_BADI by fetching the faulting
instruction.

For a PNX exception (instruction fetch prohibited by NX), fetching the
instruction at env->pc will fault with PNX again. This can lead to an
infinite exception loop.

Treat PNX like other instruction-fetch exceptions (PIF/ADEF) and do not
update CSR_BADI for it.

Backport of commit 67638dba.

Signed-off-by: Andrew S. Rightenburg <andrew@rail5.org>
---
 target/loongarch/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 266b0b97d0..b62d720258 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -198,6 +198,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
         }
         QEMU_FALLTHROUGH;
     case EXCCODE_PIF:
+    case EXCCODE_PNX:
     case EXCCODE_ADEF:
         cause =3D cs->exception_index;
         update_badinstr =3D 0;
@@ -218,7 +219,6 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     case EXCCODE_PIS:
     case EXCCODE_PME:
     case EXCCODE_PNR:
-    case EXCCODE_PNX:
     case EXCCODE_PPI:
         cause =3D cs->exception_index;
         break;
--=20
2.47.3


---8<--- end PATCH for staging-10.1 ---8<---


---8<--- PATCH for staging-10.0 ---8<---
From f2f1305d88d58743574d1da71f0fef4a60b65122 Mon Sep 17 00:00:00 2001
From: "Andrew S. Rightenburg" <andrew@rail5.org>
Date: Fri, 13 Mar 2026 09:48:19 +0800
Subject: [PATCH] target/loongarch: Avoid recursive PNX exception on CSR_BAD=
I
 fetch

loongarch_cpu_do_interrupt() updates CSR_BADI by fetching the faulting
instruction.

For a PNX exception (instruction fetch prohibited by NX), fetching the
instruction at env->pc will fault with PNX again. This can lead to an
infinite exception loop.

Treat PNX like other instruction-fetch exceptions (PIF/ADEF) and do not
update CSR_BADI for it.

Backport of commit 67638dba.

Signed-off-by: Andrew S. Rightenburg <andrew@rail5.org>
---
 target/loongarch/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 84b86da308..a5f6b7cdc5 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -197,6 +197,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
         }
         QEMU_FALLTHROUGH;
     case EXCCODE_PIF:
+    case EXCCODE_PNX:
     case EXCCODE_ADEF:
         cause =3D cs->exception_index;
         update_badinstr =3D 0;
@@ -217,7 +218,6 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     case EXCCODE_PIS:
     case EXCCODE_PME:
     case EXCCODE_PNR:
-    case EXCCODE_PNX:
     case EXCCODE_PPI:
         cause =3D cs->exception_index;
         break;
--=20
2.47.3


---8<--- end PATCH for staging-10.0 ---8<---

--=20
Regards,
Andrew S. Rightenburg

