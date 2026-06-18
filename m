Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA4ACD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waEpI-0008Kc-JY; Thu, 18 Jun 2026 11:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waEpG-0008K0-U4
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:38:42 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waEpE-0004Jj-Gk
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:38:42 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-662b76dabfcso1334515d50.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 08:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781797119; cv=none;
 d=google.com; s=arc-20240605;
 b=fYXR4gSO4cgGwUQcSzUPMSvTBrC9kpcLlnNKzGQ0KeN5i7gifSeyoakE5zHtpryWQD
 El8XhPXGoWudMSUrdba8LCr7Z6Wc21/6FmpdfHDRjpp1iO7j1K7An4YEi8CRmTwsVfbu
 MJazip43xPQC6FYmq+d1u73u8DBuZ1lCIYUKSCJavbVVcQ20tkuLu8LZBc/jGogjI1Dc
 i/xsq44f2GgI2lsXbzkuNr3ZY0pFu2Hud5IXQ9JXFf1QQFGjwZWP5bRbmfTs2hSEGqDA
 0NVtMPTUGarJCi9O1B2JsD7nfTDJoMIjwn6t9jyYwybwUdju5KGe3sbxUDjif7lcFtmA
 y52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9r6GWu9tnVok8O/xO7CozCTdUwqRRYn8PN0yv4A406g=;
 fh=qYtLdM+oha5lWDFfnZWU0F7C4hsTltWBcoHDddWGUr8=;
 b=ihfWCw/m6ljaFmxLQmmEGlSApEX/pZKqFr+tAY7g5nRLitHxNvNJPlmUGL+MU/GiSG
 c7hFjE3t/0Y/u+26ETLJHAici0hhnZ7Mf/mcIeQa4T2dpLpPHCUjK8vmfy0jKEKAS0Nu
 BEX1Ygovp0gGQNxpy+eFdrkMtM3YOIALzXVztiWsjos4gpPej5kJ4d/MANe/QUWZQYRD
 98Mx12ntQnw2y8wjXoA7CAnXioib5YuN0/ZbxsFGJBSZIBnKV+19JDaRj/5xWTkj+Ft4
 O/5PfC+enVxRkvjEC/sZcKrgFYvSulWR0IeNWB95Tcik8WXFyTitXg857mC3aRNGvWvt
 cfng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781797119; x=1782401919; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9r6GWu9tnVok8O/xO7CozCTdUwqRRYn8PN0yv4A406g=;
 b=HWhYA28zfAkqWA9rSjsiO/z9nAvtt9oXuTCkoiOS2tLVotbb8e04cHkjmaMi3arkA7
 Sqk+A4vp5+cZsOWrQXSSP/8icmwdEemuJ8U9FgdwpVTp8lrTMrssy5g/K6nYCt48J17b
 nUaGNA8/tXe4FJgmzYpS/Np4uACdkvH+vkdpTXUku+Mq4DrKKRIi9+Ot2GyJwu4No17N
 TIe8XW9rsCtEEhWE+js5JUkq3mC/GIF4i0Q7n6BAWcL38We1rjtlxIxkcw6RfpHIR5LF
 Fv07exeYAdcHwRl3uxPHZRHobBbkbM/nx+EJ+Xtsn+7wv++KV9RNhUw3XrtMQGBAFY4m
 Lgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781797119; x=1782401919;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9r6GWu9tnVok8O/xO7CozCTdUwqRRYn8PN0yv4A406g=;
 b=bqGxzX7aYnONrH3kMqf/Rur9xhsGGTYRVs71xjRg1Vqtz6GnFr9AObR1QStvhKDGIB
 wTGZRU39Y7FOf9Cal9D8X02fnYkkuoOYlFRoipieZ6AS2IN4IFW066MbtxSxTs+V/+jU
 bAIPeIMcup7o5I5LvkR2Ry8txIs7aRanG+DjGfGgY/M2Rq7lHzjc5xTxAyQHT5KWUcfG
 PpVlP8ddi2q6PZCqT9AYFpl4iU5gilgbFFJQz4bMQvEBiXQPY7w2h7BMdtySt0e1JQ2S
 +yyp2GnSYc2VorJc4xQ1aGy4en3qsZpe+YIx9lfGkYYbEsr+S1fe94+awJ4PZfc9F1Ct
 R0Yw==
X-Gm-Message-State: AOJu0YxcOh0iyGkAPcNC4y+eUsweuLnaeejmskIWgAGWVjbp/jhZWEQi
 RUacgLEeTDDSFk/4AVLM4Oh2AdaJSSFNROzH0cnw8zwhqbU5f0FiG9PmGreBnGwBhHYaWCdR5Ke
 7wkKQ57ypuKrfPZskQ6xh7wlF8i/Dnzf+VQf47Ox6YuEkhJrWc65lQFY=
X-Gm-Gg: AfdE7cmYi1RMfOvOzw03xzJNXyJCvsiD+TGrz0h82O9nZCmRNMHAbDhH7oNkzZDZKXR
 eywTAMYlcFxzrUs+BmWkFRuNwyReCn7SbvOoVQ7RXiytR63b0qlYalbmobhT40YsInSz0Bf4SeZ
 DmlYMDD8VWGpCp5x9fdqDalsFz1EgoXK+Lc5V4EfTXtcJ4gX5Zfv/fyNSvbHuKCVufIW04XbTKB
 NcsnS75/huDC1i6KhjjKTMmhlLPwcZ3XQSdHs6OapMASMZZDvTHDca4XCey0WS/vcI/DUy497sP
 ZpXgTjya4hCN0XuZi7p4V//vi6SH0c30hhQbsKmBs0lsH6R2MHzDJoB/
X-Received: by 2002:a05:690e:4814:b0:662:e27b:5fa3 with SMTP id
 956f58d0204a3-662fc65af9fmr110870d50.1.1781797118791; Thu, 18 Jun 2026
 08:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
 <20260515104945.4145203-7-peter.maydell@linaro.org>
In-Reply-To: <20260515104945.4145203-7-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2026 16:38:27 +0100
X-Gm-Features: AVVi8CekwwE89gQWEGZLIK0eH52B9XHvuBj8THqDf9sjFThBEvQpElM3vZwVddE
Message-ID: <CAFEAcA8OraFxZ+S+892aKwBXG=Ycbb0btXK0zvHpbwz327KXqg@mail.gmail.com>
Subject: Re: [PULL 06/23] target/arm/hvf: Stop pre-allocating cpreg_vmstate
 arrays
To: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This change (now commit 06fd39e4) fixes a bug in a commit that
is in the 11.0.0 release. Unfortunately I forgot to mark it
as Cc: stable when committing it.

Could we cherry-pick 06fd39e4 into the 11.0.x stable branch,
please?

(This just got re-reported as
https://gitlab.com/qemu-project/qemu/-/work_items/3565 )

thanks
-- PMM


On Fri, 15 May 2026 at 11:49, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> From: "Scott J. Goldman" <scottjgo@gmail.com>
>
> Commit ab2ddc7b66 ("target/arm/machine: Use VMSTATE_VARRAY_INT32_ALLOC
> for cpreg arrays") moved cpreg_vmstate_indexes / cpreg_vmstate_values
> to be allocated by VMSTATE_VARRAY_INT32_ALLOC and added an assertion
> in cpu_pre_load() that they are NULL on entry. The same commit dropped
> the redundant g_renew()/array_len assignments from the kvm, whpx and
> helper.c cpu init paths, but the hvf cpu init path still pre-allocates
> them.
>
> The result is that loading a snapshot or migration stream into an HVF
> guest immediately aborts:
>
>     ERROR:target/arm/machine.c:1043:cpu_pre_load:
>         assertion failed: (!cpu->cpreg_vmstate_indexes)
>
> Drop the leftover cpreg_vmstate_indexes / cpreg_vmstate_values
> allocations and the cpreg_vmstate_array_len assignment from
> hvf_arch_init_vcpu(), matching what was already done for the other
> arm accelerators.
>
> Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/hvf/hvf.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 5a1718f7f9..9312607001 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1412,12 +1412,6 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>                                       sregs_match_len);
>      arm_cpu->cpreg_values =3D g_renew(uint64_t, arm_cpu->cpreg_values,
>                                      sregs_match_len);
> -    arm_cpu->cpreg_vmstate_indexes =3D g_renew(uint64_t,
> -                                             arm_cpu->cpreg_vmstate_inde=
xes,
> -                                             sregs_match_len);
> -    arm_cpu->cpreg_vmstate_values =3D g_renew(uint64_t,
> -                                            arm_cpu->cpreg_vmstate_value=
s,
> -                                            sregs_match_len);
>
>      memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t))=
;
>
> @@ -1462,7 +1456,6 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>          }
>      }
>      arm_cpu->cpreg_array_len =3D sregs_cnt;
> -    arm_cpu->cpreg_vmstate_array_len =3D sregs_cnt;
>
>      /* cpreg tuples must be in strictly ascending order */
>      qsort(arm_cpu->cpreg_indexes, sregs_cnt, sizeof(uint64_t), compare_u=
64);
> --
> 2.43.0

