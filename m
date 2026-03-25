Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972A01075269
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 01:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5DL7-0006HC-RC; Tue, 24 Mar 2026 21:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5DL4-0006Gu-SB
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 21:47:18 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5DL0-00029s-Pw
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 21:47:17 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso2459499d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 18:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774403233; cv=none;
 d=google.com; s=arc-20240605;
 b=SgTYTNNw5GdHmxx6DAOqChff2U9gf8BkiMCF94GiRQr4ttB0zHz4WnyPm4Yw1DHxgu
 l6OKKVy6en7dJ5M50NrD1yWWMEnkpbx3U2hAOHMyp3pcGS7ZQ3MQons+hkpYAU6uVRDH
 9jOZx4cNWPdfddmlCQJRTUbrerl7WxyFMdwYGIp0XV3+po3ZFc+o7Cf8UFxEaGWAl+SG
 2DBWiWJ8mZT6NzArxAA3T4Tc3/T6w/Ly73WEHT6NVNnM+UHVXtaWTVpFdnX6HXl5hbVz
 T80yete4jOqTeKVi2ptIFN9WJkpQKG+A0+m+op5+cYDkp48CB8q1NqutG0hEPVdN22FQ
 eETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XtgQAEsFeaH5BIfsOhvs6yQb3PJg/V92ZdMYIpzywRU=;
 fh=04Aqt4bNN/xsjKQvKOyyozru0WPtRu+YUQhfE35VRn8=;
 b=DZDaZNyaEoZtK7YDGZiavDnAbMwpp9F83lBhOo3RywwZxTrpTWsoJCUp6i9ulxpKvB
 u2EdUY9tjm1SD7PVrZDAAYTt0xLRkUgWeGZBm3vyBBUrMJDWkEDj3u74hK8iH1ur+jg9
 02GyK4DE/Vquzis14NnotECD2fXCoaFnbdPYpbmdt+04LfCzQkC76OF2VaPJ5IiQB6f6
 JVOIy5lJDB9WRhop4zA6rmucHtx9k0Gg8wuCoLKaGoKjp+PHa3QDDOFxqb3gTFFHbv0K
 YriY/6VO8W8SvZQXgxT95SAIZHm//mUANsOT8IkoTeoyCowgN/9bTl0cRgiIWGNyRmek
 4NfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774403233; x=1775008033; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XtgQAEsFeaH5BIfsOhvs6yQb3PJg/V92ZdMYIpzywRU=;
 b=mT1LIQ+4QMqtt4QzTZfxKMDAJGUHmzu+rxXwh0tArEMOaJNABniUAPph+WhOoE9y/N
 GlIb3KD2LBix00cgsOVicTBkAxnZ5wQMkt37wcfvhX6xZEmC1ro+dEeHbIWzazXkS+Zh
 PJXciQkK69gDQ1OX/GwHSVBfri6aoZQCmC8POUgeUbO1e+W5+F16KO5J5l+hEj1jH8Je
 p9ijttwEla7sq1V3IEOh1lviFtmRb81IbReA68KkWfzyIJWs7XySL2dPldwg9YmnzdoW
 J1abS2qZPw7wmiHyAT4w/BKY6CxB14acEvomRG1aMpEWvnA3SVczesTd/Sn6vG1bVaWb
 ogmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774403233; x=1775008033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XtgQAEsFeaH5BIfsOhvs6yQb3PJg/V92ZdMYIpzywRU=;
 b=b/LF5+7A9v/D4O83+Ln0DfZAbRWKHWz99xXrqf7jzv9N75H/V75A3zSeEwAnAm+Uz5
 +mygF81aJVaO+ccvd/oYegMfb34MXWvzXuzAg8yF9uTOpBxdnh1XH9yGVBMvVjSsQJ0J
 L8fcBWNZe0mZMb63ibHUSGDV9dvmbEW70dtnzTDOdqmXTF/8rXVy/n8+XRDXU4VxG97k
 pP5/hIEkm9bSfA2c1YqfojJre5XJKB5zlkbLHkPKno/ixCZaS1br6YEqnqYQOrunvFJU
 4UzNAa34ehgfi+opwY72HlVixv6Dca5jPryIAf/gzGWgtwf2AichnSk8RVD1Ryf+KVzc
 kkoA==
X-Gm-Message-State: AOJu0Yy0Zy0hN1JB5GtQi2GS06kESNeRnrgWNoAjRXokpiEYzROOqKg8
 noqnz9ilOh0jeNICdGqRxLTn2IDstRrwpEbUhSl0FB7MPfb2urFS5741YZ8MymoXt97Rzjx6ol1
 6hLmMBvgwFs8m2rGgsglDRKfifyCXO8U=
X-Gm-Gg: ATEYQzyy4szoTco7XxXF01hGZVun1IAxp59ncrXYCO7EwY+kzXPEUcw/xxvxbym8KTd
 TCrM+5R67NQzPN5CmrJrscxoReQvp60/kHqIUduNRm6yNu79xn/ojDBNjsY0qLiUmgc7gOAK/qq
 wSSUzGWa5Ctb8/mTg9X7viA1WWsWJmMMZYnnImNaRR6sRNeWMBBoe8APPFJE8a8xnv0zgCIx9cv
 fDa/iJ/TER+YYi0+JZATBx4IjxMrLVkK523JcfRzhFA6fbvTl9ca9rZZugC9ryfCJA2ZzCBzJ3g
 lQhxe4YvRFknbTxYTcX89BJgKjSFf7fwSmRwCQ==
X-Received: by 2002:a05:690e:b83:b0:649:b31e:8f48 with SMTP id
 956f58d0204a3-64ee60acfa1mr1608509d50.22.1774403233171; Tue, 24 Mar 2026
 18:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260321004836.500390-1-npiggin@gmail.com>
 <20260321004836.500390-3-npiggin@gmail.com>
In-Reply-To: <20260321004836.500390-3-npiggin@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2026 11:46:45 +1000
X-Gm-Features: AQROBzCdTl1GA8eahmuJvMBz5Y5P3kh-1o-K6KvRxgVMZu1CUcKoAPA-JOegrHY
Message-ID: <CAKmqyKMifRr3bhRrApJEzRTi5UvHsr8TF7uOeOP-+nJL7fU6Ng@mail.gmail.com>
Subject: Re: [PATCH 2/3] linux-user: Fix unlock_user API usage
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=alistair23@gmail.com; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Mar 21, 2026 at 10:50=E2=80=AFAM Nicholas Piggin <npiggin@gmail.com=
> wrote:
>
> Fix errors in unlock_user() calls:
> - unlock_user() with len=3D1 instead of len=3Dwritten
> - unlock_user() with len=3D1 instead of len=3D0
> - unlock_user() with len=3D0 instead of len=3D1

Can you explain what the errors are and why this fixes them?

At least to me (I don't know the linux-user stuff very well) I don't
understand what is being fixed here

Alistair

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  linux-user/linuxload.c | 2 +-
>  linux-user/syscall.c   | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/linux-user/linuxload.c b/linux-user/linuxload.c
> index 85d700953e..79416a94c9 100644
> --- a/linux-user/linuxload.c
> +++ b/linux-user/linuxload.c
> @@ -19,7 +19,7 @@ abi_long memcpy_to_target(abi_ulong dest, const void *s=
rc, unsigned long len)
>          return -TARGET_EFAULT;
>      }
>      memcpy(host_ptr, src, len);
> -    unlock_user(host_ptr, dest, 1);
> +    unlock_user(host_ptr, dest, len);
>      return 0;
>  }
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 7832a1aba5..13b8bd9ed3 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2989,7 +2989,7 @@ get_timeout:
>              if (put_user_u32(lv, optlen)) {
>                  return -TARGET_EFAULT;
>              }
> -            unlock_user(results, optval_addr, 0);
> +            unlock_user(results, optval_addr, len);
>              break;
>          }
>  #endif /* LINUX_VERSION_CODE >=3D KERNEL_VERSION(4, 2, 0) */
> @@ -4006,7 +4006,7 @@ static inline abi_long host_to_target_semarray(int =
semid, abi_ulong target_addr,
>          __put_user((*host_array)[i], &array[i]);
>      }
>      g_free(*host_array);
> -    unlock_user(array, target_addr, 1);
> +    unlock_user(array, target_addr, nsems * sizeof(unsigned short));
>
>      return 0;
>  }
> @@ -7888,7 +7888,7 @@ static inline abi_long target_to_host_sigevent(stru=
ct sigevent *host_sevp,
>      host_sevp->sigev_notify =3D tswap32(target_sevp->sigev_notify);
>      host_sevp->sigev_notify_thread_id =3D tswap32(target_sevp->_sigev_un=
._tid);
>
> -    unlock_user_struct(target_sevp, target_addr, 1);
> +    unlock_user_struct(target_sevp, target_addr, 0);
>      return 0;
>  }
>
> --
> 2.51.0
>
>

