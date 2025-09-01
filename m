Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2F9CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3LA-0006AH-LV; Mon, 01 Sep 2025 08:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut3L8-00068x-6u
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:08:50 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut3Kz-0005fO-OV
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:08:48 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-71d5fe46572so40139207b3.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 05:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756728516; x=1757333316; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yXtHdrl+QM2N27NEU5e38Higfy7JEGr4Xf5KI2gQIQI=;
 b=w1FRm/z3RRC2zxgYfvE5kktC0uc0ctsMadqBPGANzb2vSJwxyLGzG6WPQs832cmUFM
 495kBpQmiyVwW08+S1wTMB3erUVifkW8Ac5xWlNXicO1/0OwgK+co0QoN35e3ftFNEjJ
 dflJi9uHClcYKohOk4yn2jU7VEeo7kjW/oVMawsfbCWJ2SOuWcnL75+LCNeQvQMYzKNM
 bnfcRyX+6r2E8OB/T9aO9NcK0YdqFi0C9/2sskIGNdVC855LONiej0W0gMjR+80ITysk
 BKmTKwYKNHaMrDfO/vvFlwPya4UaFwZJTNMcHR/8CwllLJsKSZm7LPe+eQlfeCUpTYQQ
 K36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756728516; x=1757333316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yXtHdrl+QM2N27NEU5e38Higfy7JEGr4Xf5KI2gQIQI=;
 b=A8Vpoep9z4M22yvx+twfeFNGgafLz3OdWLyVIOb6JC1Bj0SqLoVjVV2QYMG8qsPJyk
 VvCzmnuXQI8M+QHHHo+VzSPZ7fcyisH7dSsEJeEQrxCrJ3XWpE/pXFwRm0iWZ23LbpFH
 4jRnYhN9OQsq2cH7+bSowIey0Tn7FZN5iREcZfrbb0rg7d8vHhqMVSY9M2rgMecxGL7X
 VwRSWvLqw7lMipjxXAl9ppHUI1eW+Qb3VhImwQJTReUx0RgpXHgoZaAZMuqRX8gzAXYy
 oYpLA8U2KDcYMwyf4t58TWSLpksnVCJtt1DwejNP3VcWNpmTrRSqAAbkfb6SBxh6MwSv
 agZg==
X-Gm-Message-State: AOJu0Yxiw7Gap5+cy/Cu62ocJ8ZkZLEsQ3I8y6QM+EajtfL6JvyI7Vvy
 IskgKU+2gC8pL+HLRHY95hG4kKLINzsD5gNtVlS5h7TimaWkvLutshQ0niYu3jAf2B2dj2vtYhT
 jquMuUbq/g1hC7yWQ4GYPRT4oWmsNmoboYci+1c6geA==
X-Gm-Gg: ASbGnctMiAv2bPQcyM+lGEmUX/Ki/9+3dRW69Ac8CfQSNouaTY4e05Zq5iAzZ2ufr63
 JgRUl8RCojon6feeGWidn04Ty7XWjtC5Z7zzTmanxpfqu4AnhNimm1on8ZRJ/LIhKOjfKpmoMwI
 O2Ap/V5AieK51hQpgKkkzNuZdbH9tQb2GXgtDy61PMn5N2xzh/Y+x8myV9Ur63SHqngmUidnp9C
 IYUYipefzPSfsKmoD0=
X-Google-Smtp-Source: AGHT+IEAW7MwRNeVhU6Ent9zh1gCTq4zHNcPr2UQMRsiFLxuUQpRMYHma2GJqWbSXL7HhFbM3ZQI6GosfAwvIz+p2GE=
X-Received: by 2002:a05:690c:61c6:b0:71f:9a36:d32f with SMTP id
 00721157ae682-7227653a540mr88021217b3.24.1756728515932; Mon, 01 Sep 2025
 05:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250811100823.94105-1-philmd@linaro.org>
In-Reply-To: <20250811100823.94105-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 13:08:24 +0100
X-Gm-Features: Ac12FXzswSowIaE7UkJ51uR3Rpniv-oDaw0SUfciDCJIyWVhvyLTgMRPBgjSNGc
Message-ID: <CAFEAcA_tW3UyUTcyFWP+bY15EO0DO3bcS9DLPuJYkdvEfFfVdA@mail.gmail.com>
Subject: Re: [PATCH] system/rtc: Silent overflow in qemu_timedate_diff()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 11 Aug 2025 at 11:08, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Per ctime(3) man-page:
>
>   A negative value for tm_isdst causes the mktime() function to
>   attempt to divine whether summer time is in effect for the
>   specified time.  The tm_isdst and tm_gmtoff members are forced
>   to zero by timegm().
>
>   The mktime() function returns the specified calendar time; if
>   the calendar time cannot be represented, it returns -1;
>
> Coverity reports (CID 1547724 Overflowed return value) the
> qemu_timedate_diff() method doesn't handle this error path.
>
> Since this method was added in commit f650305967f ("Unify RTCs
> that use host time, fix M48t59 alarm") in 2008, and there is no
> open issue related to it, keep ignoring this unlikely case, but
> add an assertion to make Coverity happy.
>
> Fixes: CID 1547724
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  system/rtc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/system/rtc.c b/system/rtc.c
> index 56951288c40..070b99fe6ad 100644
> --- a/system/rtc.c
> +++ b/system/rtc.c
> @@ -98,6 +98,7 @@ time_t qemu_timedate_diff(struct tm *tm)
>          struct tm tmp =3D *tm;
>          tmp.tm_isdst =3D -1; /* use timezone to figure it out */
>          seconds =3D mktime(&tmp);
> +        assert(seconds >=3D 0);
>          break;
>      }
>      default:

Generally the struct tm that we call this function
on is filled in using information from the guest.
So I think that a silly guest could probably program
a device in a way that causes us to call qemu_timedate_diff()
on an invalid time and make mktime() fail.

Also, if the device is programmable to a date earlier
than the Unix epoch, this will also make mktime() return
a negative number, e.g:

  tm_sec   =3D 0
  tm_min   =3D 0
  tm_hour  =3D 0
  tm_mday  =3D 1
  tm_mon   =3D 0
  tm_year  =3D 70
  tm_wday  =3D 0
  tm_yday  =3D 0
  tm_isdst =3D 0

(Jan 1st 1970) makes mktime return -3600.

The safe way to check for mktime() failure is to clear errno
before calling it and then check for it returning -1 and
setting errno.

I think that if we care about trying to handle errors here
(and plausibly we don't care enough to go to the effort)
we would want to:
 * update the API of this function to allow it to indicate
   failure (in some better way than raw mktime() so we
   don't have the "-1 is ambiguous" problem)
 * have all the callers handle an error in whatever way
   makes sense (which might be assert if they can guarantee
   the fields to be in-bounds, or might be something else,
   e.g. for mt48t59.c where it wants to set the alarm
   timer "alarm time out of range" should be handled as
   "don't set the timer" because the requested time will
   be either in the past or else so far in the future it
   will never arrive)

thanks
-- PMM

