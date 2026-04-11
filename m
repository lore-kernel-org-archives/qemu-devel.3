Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F229F45A0B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 02:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBNmY-0006AI-Bs; Fri, 10 Apr 2026 22:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gyorgy.tamasi@gmail.com>)
 id 1wBNmW-0006A1-CW
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 22:09:09 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gyorgy.tamasi@gmail.com>)
 id 1wBNmT-00084F-O2
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 22:09:07 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5a3cee3a271so2562846e87.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775873342; cv=none;
 d=google.com; s=arc-20240605;
 b=VMp0WYw7qULBZwgZ844ioX9NP/bV26eOTL1PgpKgZItychLv5s2RGSeV943k6ZYSqG
 lWE0VHD/6JwoA39uaaOmuyquwMtblQtZzyKiySXRLQeTWL+wWgQoJNDqB424pxMftYeD
 Uthw4LG+Kke6o5z90E6cF19VR5KoFhJ6ZlqDEks1sDoKUVhlZz2pc2pnQAsUkkk7NU2P
 MtjwlxdZgkODvDU+jp+Q1AuqkI6xPrC5h+NWpB89YD9NKtA6uhcsMpykmglABspqpotK
 MZV3FGNQkM4AAMHng8ztRjDn5Kcdqs3w44fWrooZeuWWSBG4arG+ULNCZgkfYY7rkahD
 Sndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=emP0HUw1kmwMJB9K+bSDDHdQ82d2fvGcDIhF7rssWhI=;
 fh=cS4bk7BExldfdP+Pj39w1jWPjlqGv2d/xO67F7d3QG0=;
 b=TJ4N7j1oD3IxeICzr4S2BUDfsiz9wYEYMfKyLRrVYWsXx9fW/+04PDA7DjAZN0Jq9f
 qlGPyeNPO0ICaSr91YcWHqvxFG78ZgxqMVAKAYd3u6bmmWj3Ctk7NN8o+HjYusmaOoKf
 9lgUHOqTl7seqW3AtWE/AZNS6Ek4ggjWuGe+wFPoVulPAzCyvvoPH0PnI5A/R9DRlSuJ
 lRXadItJYuAMsSoTSRinUTKbOblB+OS8LP0/jD+hzJgcDFEltS956WiN0BEzMH+CZNr4
 lmwoBWqFYoeQ/4aSPLcbY+oThnU2F4j1+4ccEXgvIqxAwkCpDHulbRfOHRQXbtx1gi+Q
 lEKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775873342; x=1776478142; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emP0HUw1kmwMJB9K+bSDDHdQ82d2fvGcDIhF7rssWhI=;
 b=ThQ+8SrBSqlkSTZt5KrzbuoNx/RVfzcGImGWMfSYWhvXt3kItlz5EZndndiN1N/S/k
 LKZtgXOj+KAzUoVa7j7R8pgsqjH9n2AdZbvI6NkOV7MeNNdoLUPST4M9kHwd6s6Y8P5T
 mT9er/1DJ4/whfUNAOV6vksqlJW6zPi3nhlFybrRa23ebOlAYcOrix5MRBkIqKTxHgWO
 /LZioxocNoc0Ktmvjyj4yv0MjwU4gycZDeubeEmloJuQ33TRORX0+q6g2lGOpjTqCwMQ
 PQgeF/ERsyrfJyN87uz24QSS68C80Kjrb7Sr3uRlWCGiNd8bzeACbv0FdkKY5+bn6M2b
 eFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775873342; x=1776478142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=emP0HUw1kmwMJB9K+bSDDHdQ82d2fvGcDIhF7rssWhI=;
 b=X3upf1MZjQeUpnGjI/6CxxodVWhaMjPvY8GEdz5lQzSsToQtZ0ZOVyTwu5UXoc6UpH
 PT58n2CIrPV3c9TyBaU3eUv8Sf15+GDGuQ4ZTYbqeBlisTJUhg/ynZKSASTGT9M/DagD
 paEqH7g9zW7tIBLeBnu257+qjkDSiFiuU2r0CVlF1bu6MINKFfdzUxY1virhZA8lTLNr
 D17PympeO3iVYFps3A+J058SGqo/lmBIDkrAKCb+itvhkvHSAWoe7VbYXq9N13fONoNQ
 xoSn/NoMqtYptjwW0SojVYwPXEt8LXW7rQACO9rRxhspt+KMP2/raLZrZam4RuE+uudc
 AQTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9LBE9uYtWq+/QnaZzIfVUwoKBWsNq0lOwyFQVQiZlBQM2V1b9w6C+fsorcvcd3ajehr3UO0o929F1@nongnu.org
X-Gm-Message-State: AOJu0YxqK7fHSEPJIsKL7+9Xz8QsATg0l63NJ4nSKt08ONOtLAhgIkTx
 s1T+2Sl/XSmIWlkxOiXFW2+KS87YWBZ5GlVFnjyK6aJWKgTK8b3a82ZIGUjuVZ1fbDes3X1+afE
 MmOMrw7Uv7CX8gOWl5gFklpS0Y8tOoi8=
X-Gm-Gg: AeBDiesAlQI1vi4bYl7wqLn2fvGHzWk7G62yKKPFIyQUZCT8qluSJm2Li5SA9uenDSh
 VlL8zQd3P+TqOCOwk3EAxRl5K4S7Y8ZFkxHlJiEvOIopKBI5xbglWM6IULOLHDvRgZOwghmXRsM
 OWkCXT1Vd5j/VlnmoxJY0ZBs3bntZUdaS8UqmWrFfv68cujA+s4qxW1g9OuJI8q7ffvP45tEm4t
 5TFXzWN0d/sdCde9+AHHFXb7H1m6rtxQPtQOqsTh1e0TqGXC4gr2F5TyrwEm7LaacWJww1jL1NV
 R9jM6fa8qHoJ1AS+yBUUGfLlEx8hyygg3rr3pg8V
X-Received: by 2002:a05:6512:10d4:b0:5a2:cac3:5271 with SMTP id
 2adb3069b0e04-5a3efe8ebf4mr1773543e87.42.1775873342035; Fri, 10 Apr 2026
 19:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFsMJvCLRw2Q=4muDNG1Ojj3oL+UgTrVzpYM6VULRvdFxgR=KA@mail.gmail.com>
 <df1c484f-bc30-49d5-9928-de6e17dd2816@linaro.org>
 <CAFsMJvDWFmMx2t+9JXmBsWP+8r0XZDP+LRm6bN9k8wF5b6CSLQ@mail.gmail.com>
 <d56c0dd2-720a-2973-865d-c9d16b90b69f@loongson.cn>
In-Reply-To: <d56c0dd2-720a-2973-865d-c9d16b90b69f@loongson.cn>
From: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
Date: Sat, 11 Apr 2026 04:08:51 +0200
X-Gm-Features: AQROBzBGPSDs7LYhao9mqEwLs8FhyLBv5VNpA5_PUfJkaPVGrj_j10FoJKgRFs8
Message-ID: <CAFsMJvBKkLf=F=g=6H5_-FX4wJAzC6MhweoapqVTPx+7V9e9bw@mail.gmail.com>
Subject: Re: [PATCH] linux-user: fix usage of struct target_stat64 for
 TARGET_LOONGARCH64 in syscall_defs.h
To: gaosong <gaosong@loongson.cn>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, laurent@vivier.eu,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Huacai Chen <chenhuacai@kernel.org>, bibo mao <maobibo@loongson.cn>, 
 xianglai li <lixianglai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=gyorgy.tamasi@gmail.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

Thanks for the link of this separate Loongson-maintained 9.2-tcg-old
branch - intended for use specifically with ABI 1.0 code.

This separate branch still contains the same bug (in the context of
the glibc-2.28-7cdc44d5a1 env of Loongson's gcc 8.3.0 rc1.6 - where
fstatat syscall can be used by glibc, and it can trigger the usage of
the related erroneous data-conversion workflow based on  struct
target_stat64 with 4byte sec/nsec fields):

This changeset was the last mod of syscall_defs.h - but it still
incorrectly modifies the condition of struct target_stat64 usage:
(~ "Add Loongarch64 old ABI support")
https://github.com/loongson/qemu/commit/409f7717d6e3217cb8f497547bbe45c2e86=
4be99
(line 2006)
-----
-#if !defined(TARGET_RISCV64)
+#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
-----

This is the broader context in this 9.2-tcg-old original version:
Here the 2nd embedded "|| defined(TARGET_LOONGARCH64)" normally a
no-op: always true/false if the 1st "|| defined(TARGET_LOONGARCH64)"
is true/false.
-----
#elif defined(TARGET_OPENRISC) || defined(TARGET_NIOS2) \
        || defined(TARGET_RISCV) || defined(TARGET_HEXAGON) || \
        defined(TARGET_LOONGARCH64)
/* These are the asm-generic versions of the stat and stat64 structures */

#define TARGET_STAT_HAVE_NSEC
struct target_stat {
...
};

#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
#define TARGET_HAS_STRUCT_STAT64
struct target_stat64 {
...
};
#endif

#elif defined(TARGET_HPPA)
-----

The correct fix is the same here (~ disable the use of this struct
target_stat64 - instead of explicitly enabling it for
TARGET_LOONGARCH64 with the "|| defined(...)" part):
-----
~/qemu/qemu-9.2-tcg-old/linux-user$ diff -u syscall_defs.h.ori syscall_defs=
.h
--- syscall_defs.h.ori  2026-04-10 20:53:34.639034304 +0200
+++ syscall_defs.h      2026-04-10 20:55:12.219347804 +0200
@@ -2003,7 +2003,7 @@
     abi_uint __unused5;
 };

-#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
+#if !defined(TARGET_RISCV64) && !defined(TARGET_LOONGARCH64)
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
     abi_ullong st_dev;
-----

The same test-scenario of
https://gitlab.com/qemu-project/qemu/-/work_items/3371 can be used
[with the relevant gcc 8.3 rc1.6 & this qemu linux-user 9.2-tcg-old
toolset] to show exactly the same bad & good test results - without &
with this mod.

Just a personal experience based side-note on ABI1.0 compatibility
with mainline qemu (~10.2.2):
I'm working on porting a quite large code-base (a commercial OCR &
document conversion SDK) to LoongArch64 (for ABI1.0 and ABI2.0)...and
I'm trying to check correctness of my actual builds using the
regression-test package of this codebase. It runs quite complex
workflows of general CLI code. I accept that this is not a
comprehensive test with all of the edge cases or touching every
special areas (like signal handling) of compatibility of ABI1.0 and
mainline qemu, but...the ABI1.0 version of this test-code seems to be
able to run with mainline qemu-user 10.2.2.

Best regards,
-tgy

On Fri, Apr 10, 2026 at 11:37=E2=80=AFAM gaosong <gaosong@loongson.cn> wrot=
e:
>
> =E5=9C=A8 2026/4/9 =E4=B8=8B=E5=8D=888:14, Gyorgy Tamasi =E5=86=99=E9=81=
=93:
> > Tested-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
> >
> > Additional independent testing (bug + fix cases) is documented here -
> > see comments by sourav/@kishu279:
> > https://gitlab.com/qemu-project/qemu/-/work_items/3371
>
> Hi.
> Please note that QEMU is not compatible with ABI 1.0.
>
> If you absolutely must use ABI 1.0, the branch below is the version we us=
e.
> https://github.com/loongson/qemu/commits/9.2-tcg-old/
>
> However, this branch is quite far from the mainline.
> The QEMU mainline follows the kernel mainline, and
> I believe this is the case for other architectures as well.
>
> Thanks.
> Song Gao
> > On Wed, Apr 8, 2026 at 8:21=E2=80=AFPM Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> >> On 4/8/26 11:17 AM, Gyorgy Tamasi wrote:
> >>> In a 64bit LoongArch64 env (both TARGET_LOONGARCH and
> >>> TARGET_LOONGARCH64 are defined!) we can not use the struct
> >>> target_stat64 for data-transfer, since this struct target_stat64 is
> >>> defined for 32bit environments with its int-sized (4byte) st_*time
> >>> sec/nsec components.
> >>> The user side compiler headers of the LoongArch64 env uses long-sized
> >>> (8byte) st_*time sec/nsec components.
> >>>
> >>> (This is similar to the case of 32bit vs. 64bit RISCV: the original
> >>> code does not use struct target_stat64 in 64bit RISCV env, when both
> >>> TARGET_RISCV and TARGET_RISCV64 are defined.)
> >>>
> >>> This fix is important for LoongArch64 ABI1.0, where stat() is using a=
n
> >>> fstatat syscall with this struct target_stat64, if its usage is
> >>> enabled.
> >>> (In case of LoongArch64 ABI2.0 stat() uses statx syscall, where this
> >>> problematic struct target_stat64 is not used, struct statx is correct
> >>> in the LoongArch64 env.)
> >>> See also: https://gitlab.com/qemu-project/qemu/-/work_items/3371
> >>>
> >>> Signed-off-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
> >>> ---
> >>>    linux-user/syscall_defs.h | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>

