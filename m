Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B963CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSyVd-000362-HN; Fri, 29 May 2026 10:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wSyVb-00035j-23
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:48:23 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wSyVZ-00027S-54
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:48:22 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-68707d88626so5948957a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780066099; cv=none;
 d=google.com; s=arc-20240605;
 b=Iq9XVSLldQnF+N8gPndWY+NirLZpmFOyrnSf1FhVjAmMP0xdgWyQz4NkCgau2T/oDd
 zMyTU96DkTa7ckNxxe5eeYX08fm0kX4y8I+1C3FvGIaii2nYXOlLbGnKpIrvuyz7VK3t
 j3xDbRiTASyJ4AOQypj7O2CE6cE3L/IeylHTzzpIaBSuY7hZTsa4v3MAp3CcZgG56VRd
 3RmAyP4jg8LMFvnOjyJ3hHgsohczfIYvad6gTWrkDCFs2jxYIdap26h88cTZCB/Z2oSI
 PKi7DaiYJTwVFtjwN+6XzhejCyrnuX2kVQiya2cnHe7x7tugBaIVbtiyNOMu6r8XfLLq
 h3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yCnXkKs1Yn4xQ0XT6UaYaRgOr65qNbKbef7MZurMV5M=;
 fh=NSN/rISujIMaMa5ecTHl46NHtOzv9U3pufdUkUP9aF8=;
 b=NOYNxyr5zjvS8OdHdT7YR1WNQa43l+W+wzpBbNBIQt+J/mxjnB/VuJPRwcx2IvJkYi
 gVM9BiCVNoy403a9SNbUN1P5QL1qa+WWatKdYEYPZyq80GNVpCr6Dm24lmKKhV04kYr3
 sJelyxqBlOD2Q27eirdv+up55q4HLFeI7/PV8T6UMHRnoVkxYhZk0tT/otKQJv1QVbtq
 bruOPfalXX6GhNiEzAJA67MNRIUuyvfy5vFuZfcSOHhBqscm8oHxzNkRiXF065zSy3N9
 qeKjByf7mL+XVnchxp5MwxvXBSJjEQegu4pqNwGrdb++dVGIQxCp3raK+Q6r+ohWvIj5
 HcDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780066099; x=1780670899; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCnXkKs1Yn4xQ0XT6UaYaRgOr65qNbKbef7MZurMV5M=;
 b=aBodhCEBAOEDT3idN6C9AHDuL8CtEsF/CYx7n8blZ9wl0/EreZedt4ejestzMpeqV5
 +agqhbhYzcyUHoUllQNfwHWez01ke9+wS6uAa/EnNRWyjnWnu85IBDH45tz96+rHokY4
 IrFsnhVYNEBezDMZO0Xwn39qVe6h2nl/JA9aw9M1dRdQ5ZbQNE2WX4DaK86PA7crCBet
 hG3V0vqZXsgFCShMVkLeCY7ZuqoR5+DWRBKnf+fsIv0vd9leZSrA07iJOgYBOTRo9NsD
 qfUIOE+qymS9c8OjtpzNYF5KGhTvxHKDOmUm5Vb2z/J4N7ANNCpwU7AzLjcFtoWtaE2J
 unrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780066099; x=1780670899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yCnXkKs1Yn4xQ0XT6UaYaRgOr65qNbKbef7MZurMV5M=;
 b=Zb6FTfTNC2ZCgMcfAWKtqNj085TX7xqwmPuDfVq/PgBqFTfS2efu+/izWzIv6emPhX
 t/e//9xSGT/sUsr9JcnvFhTymDb36g7JfIEeKqu59Bl9iOyUfKj7zlXvfj7CAEuTnNJt
 Rho7PSJ7MBKvl2gWDvA3KLWCUruzvw7VL8jjQ/OpsGC+6of4OCkNkRaid+DJiE8qDwt7
 necu2H2oGRBknPECUaFCDfy9ePY63OqhsazPkc4xpLYbdpsw3BTcDTVIoOGYix9dxAWb
 9yJH+g1qOUFr2YrfsAjTRZ0fuYIPbCbiXM4rid4VsWS6QP/R1Fmznhf45Px9vytmD974
 JOQw==
X-Gm-Message-State: AOJu0YxEWysD3uxa/fdJLjH/l/4i0nfmsN0mX5mX13yKl6ib4Y4Ua05F
 MTCaCWCQ7HpqO7UPqL/x7ti+2704lKCxaxx+tZYfCtA7/beot8dMs+d9WBIabBG+xg5CoOQasvT
 KO+60oiM1yZX4SV0vf46kjuOK9uqi0EU=
X-Gm-Gg: Acq92OGdyoTiPkkANDpWJHBvcijRpzj1BjgREh95JTcVLLhmN1VEd02qXWadLhNPYha
 TQ5bTdSrkKrEsaqvALKMAvTp16NNGGuuBCaDMwXeKETiDJjlfgrOXCRN2E+SrEUax3lnpX1nlPU
 B2I4zlGFOhWoMSNXbaLnSaFnZ2UJOuY7AXfKYAf+HluL+86nuDF5XP8WAhofnAAsgeY14v994Ae
 KgBbq0qRIiC76OtLs6zDn2VxBhL9f1rQK1cup0azz0oYSz/61pWWO3ukxrNe74R2XTbMz1qbh5Z
 FaZYgVWxOMzgGLA3Wkd6z25QPL0z+/dhqoUHTxG9qU8mJImZL2fG
X-Received: by 2002:a05:6402:3218:b0:684:44f:d859 with SMTP id
 4fb4d7f45d1cf-68c11066924mr1668569a12.3.1780066098922; Fri, 29 May 2026
 07:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260529002548.19293-1-deller@gmx.de>
 <20260529002548.19293-8-deller@gmx.de>
In-Reply-To: <20260529002548.19293-8-deller@gmx.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 29 May 2026 10:48:05 -0400
X-Gm-Features: AVHnY4I_Z3z4fcc62Dih3oJvK2_wq2Hm7OuQ3H4r5XLLxyzQ8efA6taB10tXSJ0
Message-ID: <CAJSP0QUTNjNR5BoNc1wDMEBFOAnfXEcwGUNqz2Y8h5+vW6PhpQ@mail.gmail.com>
Subject: Re: [PULL v2 07/10] linux-user: Implement finer grained madivse()
 syscall
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-s390x@nongnu.org, 
 Eric Farman <farman@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
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

On Thu, May 28, 2026 at 6:30=E2=80=AFPM Helge Deller <deller@gmx.de> wrote:
>
> Although most madvise() values are hints, some are important and are
> checked by userspace, especially by security-relevant applications like
> BoringSLL.  So, return -EINVAL for those functions which we don't emulate=
.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3489
> ---
>  linux-user/mmap.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index b4b7b3e5cc..50916c29a5 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -1282,7 +1282,7 @@ abi_long target_madvise(abi_ulong start, abi_ulong =
len_in, int advice)
>      case TARGET_MADV_KEEPONFORK:    /* parisc */
>          advice =3D MADV_KEEPONFORK;
>          break;
> -    /* we do not care about the other MADV_xxx values yet */
> +    /* all other MADV_xxx values are the same across architectures */
>      }
>
>      /*
> @@ -1307,6 +1307,19 @@ abi_long target_madvise(abi_ulong start, abi_ulong=
 len_in, int advice)
>       */
>      mmap_lock();
>      switch (advice) {
> +    case MADV_NORMAL:
> +    case MADV_RANDOM:
> +    case MADV_SEQUENTIAL:
> +    case MADV_WILLNEED:
> +    case MADV_DOFORK:
> +    case MADV_FREE:
> +    case MADV_COLD:
> +    case MADV_PAGEOUT:
> +        ret =3D 0; /* OK */
> +        break;
> +    case MADV_REMOVE:
> +        ret =3D -EOPNOTSUPP;
> +        break;
>      case MADV_DONTDUMP:
>          page_set_flags(start, start + len - 1, PAGE_DONTDUMP, 0);
>          break;
> @@ -1324,6 +1337,23 @@ abi_long target_madvise(abi_ulong start, abi_ulong=
 len_in, int advice)
>                  page_reset_target_data(start, start + len - 1);
>              }
>          }
> +        break;
> +    case MADV_DONTFORK:
> +    case MADV_MERGEABLE:
> +    case MADV_UNMERGEABLE:
> +    case MADV_HWPOISON:
> +    case MADV_HUGEPAGE:
> +    case MADV_NOHUGEPAGE:
> +    case MADV_COLLAPSE:

Hi Helge,
Please take a look at this CI failure:

../linux-user/mmap.c: In function =E2=80=98target_madvise=E2=80=99:
../linux-user/mmap.c:1347:10: error: =E2=80=98MADV_COLLAPSE=E2=80=99 undecl=
ared (first
use in this function); did you mean =E2=80=98MADV_COLD=E2=80=99?
1347 | case MADV_COLLAPSE:
| ^~~~~~~~~~~~~
| MADV_COLD

https://gitlab.com/qemu-project/qemu/-/jobs/14603037832

Thanks,
Stefan

> +    case MADV_POPULATE_READ:
> +    case MADV_POPULATE_WRITE:
> +    case -1:    /* BoringSSL uses -1 to check if the environment is brok=
en */
> +        ret =3D -EINVAL;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Unhandled madvise(%d) call.\n", advice=
);
> +        ret =3D -EINVAL; /* not yet known advise */
> +        break;
>      }
>      mmap_unlock();
>
> --
> 2.54.0
>
>

