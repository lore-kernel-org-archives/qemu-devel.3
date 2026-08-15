Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE2EC5CFC1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 23:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvNYI-0003Gf-KN; Sat, 15 Aug 2026 19:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wvNYE-0003G7-4m
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 19:12:30 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wvNYA-0007Cb-FF
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 19:12:29 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2d01663d816so19192115ad.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 16:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786835544; cv=none;
 d=google.com; s=arc-20260327;
 b=phyCyLPQVKEZHNwxlSrrqPu5l3R8xQi0W/3l5IySna8be3Kk1oIZa/4RoJ6V8RoUEH
 zfTt22UZn4hs4ZLkeV8uNCtQCR7TvfjKg1ts46odGze0LjVTBYohoZI8Ee6W9sOC2YQR
 a/IJR1bHVmr6sdMQVIA/BLyQb2cSMiqgWTDJoR39E9jA0XDg6V7SdTA1KBTCuzLzrfUz
 BYz5i706lFfOHVzH+dccb1Ub6PJ20Ao2HJjft2E49VU6yyu0ZFA2AVF3kzFrq7n/P8xQ
 OgsaNjbQF3Grpc/qfFmTFGV/58jqcc5GSpliaCOWyH+c3lhvbuprjrv//9LWN9FrKU9V
 015g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gXFetRX5mXcySIeSgSjr6Yy9ds0rVhf996YlmO9zgFw=;
 fh=tChWmEYzjNiE2nQuOWKQCmsYiesBT8hJmZNJMxAXoz0=;
 b=DJdH7+EqGTmpcDFOHtw1C9dWhWt3jhW8tII/dVUSrAehseOlVdNdN+wX4gmy/DA6g/
 PAd7HBlUprRq8j9n4vht70sCt4Pzm5H6d9xE+o43H+geQOq6HGBgCgmUlhOM+EQgQXJR
 19kCMHuibJWC5DqQcelY1UNXLGPZrwqU9o/jeCfwnXR8kGtt40Wfboq1/Is3pzQjC2SJ
 pUD6tNwfA2vsKDdaIaGx0GAs1jXL7q4dQcLpPH7iEIT7A8gwMYzR5KtFhe4yh7hQcybD
 Rjn9+Mr7D5ixnbTwUhHFD1xMQt7WiV8gUI5vDpqzwr7BXkeRLdKFp/ZGHbW53C5Yqpeq
 6S9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1786835544; x=1787440344;
 darn=nongnu.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gXFetRX5mXcySIeSgSjr6Yy9ds0rVhf996YlmO9zgFw=;
 b=P0ml0UAZ20kZJF0y8TfC9UsNP5p6QjefAi93EAfsiZJPIgBMA5KulFub09nrKo3+QC
 JKCRmhQVkIEF3xybl6D8r1zr7TRrXFqh6JrEH4hW78PZsgvngGzFa1DckF4d76bhEr3U
 YGkmw76FmAFMJPWgevT12CiekdXRnbZyV96ICZJNV9gVajw6D/aG9o7+AQV7fUC9H6DY
 F1hrK8DaeDkzflW9b36N6Mqm/+i5dZzdlmezqZDVlmNaQebPC276kn1vj/oGWnK8vlt/
 LAbknT03hTqddJUuZVg2CaetjVAz/fhXsyMiptLks66un5w3jKXIsHYPyWwSfXyVaEaS
 6ayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786835544; x=1787440344;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gXFetRX5mXcySIeSgSjr6Yy9ds0rVhf996YlmO9zgFw=;
 b=gP28laOVApFNNWyk88T1R/agj7Owgzfyk69GnQTR2g0JjoUhn0ICQvv0QHpPqMPdtM
 80d+uaQpNAXHK3Wtl3SAz8EPcOHsSbUK1qEPdoeggnPDs8zihDFg3khk2OeRxvflKnrk
 GLcEYsnTjMwGE5RAIl6dFIVUlljewGNTpxvyk7S8oGcvRRrQKShIsXq1Z7UisCq4VXGC
 ZhINaGOCwNlf1fuSULgQDj5293Dk5wkTleOWZWzmBVBFCTGaY+/yHswdJwFbI0pKXIPV
 XQZVt4HSYGTonoRaXZSpLHLaAspGR0NTulbvwPGk1W08J0dUVeGakzWqV1Eae8Qrs3QM
 JOBQ==
X-Gm-Message-State: AOJu0YyP39JkWelaMVDqF/dvNnoP6K7j5GCJijmOEK4tkDVHxhlakJiE
 G+BMmM9Rcl44zQxjR/fOWPkkc6/Y5yniTkhahvirC7U9uMk1WqFQ8QyjbqPbsNnNyx4HhcHH9ol
 lDl9j6ddwaj0NFn4ZNoNfMKyRTqyH2HqIooKDoCWpMw==
X-Gm-Gg: AR+sD11Xj52a+GUQ/eJzoNNA+Bep/zDcte9ouytow3mCwUs0hL8x5QqFn3TWRuFEuEZ
 9EJqpTRT+TCPJ/53aNary/45X40FgWcSk2Z2lxOau9T7Ir3BDhSOZZtRofE3r4dMvy1rPrnjTJ+
 iHLFw5ZtxUKMCQErmogomuN5IRGW4NGfRKdLpFmMFXPBI1R12chXlEC6S3c5yrzq+knXZCyy8RY
 n/IOMKDoQnHhPXg0XhPWOs6Bnnc6ls4kvhAqxcSC94MtMLbDvXatjHP2MtMRK8EX7yFoIhUmtjx
 uyueZBtFB2HEEw4Kj9tGabcdrRKnrmb0qIWLUJeG3ivb
X-Received: by 2002:a17:902:d592:b0:2c2:62ee:5a0d with SMTP id
 d9443c01a7336-2d3b0d5cec9mr187307545ad.14.1786835543787; Sat, 15 Aug 2026
 16:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-18-6c16fe448301@bsdimp.com>
 <efaa34ff-ffc2-4c70-b435-bd5d3d041b5c@oss.qualcomm.com>
In-Reply-To: <efaa34ff-ffc2-4c70-b435-bd5d3d041b5c@oss.qualcomm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 15 Aug 2026 17:12:12 -0600
X-Gm-Features: AUfX_mw8UCh6pMjVM6BPduMApAQr4xEagQPv9XaE9eg2UVktJhu1o-GpmFNs8LE
Message-ID: <CANCZdfpqwkUCLVmW3aQoHa1wuhSS6DKpRYf7k7mR1H98Cgax2g@mail.gmail.com>
Subject: Re: [PATCH v2 18/37] bsd-user: Add utimes, futimes, and ktimer
 functions to os-time.h
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Stacey Son <sson@freebsd.org>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000dc18f006591e11d2"
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--000000000000dc18f006591e11d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 5:38=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:

> On 5/18/2026 2:27 PM, Warner Losh wrote:
> > Add time-related system call shims: utimes, lutimes, futimes,
> > futimesat, ktimer_create, ktimer_delete, ktimer_settime, and
> > ktimer_gettime.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Mika=C3=ABl Urankar <mikael.urankar@gmail.com>
> > Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > Assisted-by: Claude Opus 4.6 (1M context)
> > ---
> >  bsd-user/freebsd/os-time.h | 210
> +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 210 insertions(+)
> >
> > diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
> > index 16b71e6234..05fa043442 100644
> > --- a/bsd-user/freebsd/os-time.h
> > +++ b/bsd-user/freebsd/os-time.h
> > @@ -217,5 +217,215 @@ static inline abi_long
> do_freebsd_ntp_gettime(abi_ulong target_ntv_addr)
> >  }
> >
> >
> > +/* utimes(2) */
> > +static inline abi_long do_freebsd_utimes(abi_long arg1, abi_long arg2)
> > +{
> > +    abi_long ret;
> > +    void *p;
> > +    struct timeval *tvp, tv[2];
> > +
> > +    if (arg2 !=3D 0) {
> > +        if (t2h_freebsd_timeval(&tv[0], arg2) ||
> > +                t2h_freebsd_timeval(&tv[1], arg2 +
> > +                        sizeof(struct target_freebsd_timeval))) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +        tvp =3D tv;
> > +    } else {
> > +        tvp =3D NULL;
> > +    }
> > +    p =3D lock_user_string(arg1);
> > +    if (p =3D=3D NULL) {
> > +        return -TARGET_EFAULT;
> > +    }
> > +    ret =3D get_errno(utimes(p, tvp));
> > +    unlock_user(p, arg1, 0);
> > +
> > +    return ret;
> > +}
> > +
> > +/* lutimes(2) */
> > +static inline abi_long do_freebsd_lutimes(abi_long arg1, abi_long arg2=
)
> > +{
> > +    abi_long ret;
> > +    void *p;
> > +    struct timeval *tvp, tv[2];
> > +
> > +    if (arg2 !=3D 0) {
> > +        if (t2h_freebsd_timeval(&tv[0], arg2) ||
> > +                t2h_freebsd_timeval(&tv[1], arg2 +
> > +                        sizeof(struct target_freebsd_timeval))) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +        tvp =3D tv;
> > +    } else {
> > +        tvp =3D NULL;
> > +    }
> > +    p =3D lock_user_string(arg1);
> > +    if (p =3D=3D NULL) {
> > +        return -TARGET_EFAULT;
> > +    }
> > +    ret =3D get_errno(lutimes(p, tvp));
> > +    unlock_user(p, arg1, 0);
> > +
> > +    return ret;
> > +}
> > +
> > +/* futimes(2) */
> > +static inline abi_long do_freebsd_futimes(abi_long arg1, abi_long arg2=
)
> > +{
> > +    struct timeval *tvp, tv[2];
> > +
> > +    if (arg2 !=3D 0) {
> > +        if (t2h_freebsd_timeval(&tv[0], arg2) ||
> > +                t2h_freebsd_timeval(&tv[1], arg2 +
> > +                        sizeof(struct target_freebsd_timeval))) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +        tvp =3D tv;
> > +    } else {
> > +        tvp =3D NULL;
> > +    }
> > +
> > +    return get_errno(futimes(arg1, tvp));
> > +}
> > +
> > +/* futimesat(2) */
> > +static inline abi_long do_freebsd_futimesat(abi_long arg1, abi_long
> arg2,
> > +        abi_long arg3)
> > +{
> > +    abi_long ret;
> > +    void *p;
> > +    struct timeval *tvp, tv[2];
> > +
> > +    if (arg3 !=3D 0) {
> > +        if (t2h_freebsd_timeval(&tv[0], arg3) ||
> > +                t2h_freebsd_timeval(&tv[1], arg3 +
> > +                        sizeof(struct target_freebsd_timeval))) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +        tvp =3D tv;
> > +    } else {
> > +        tvp =3D NULL;
> > +    }
> > +
> > +    p =3D lock_user_string(arg2);
> > +    if (p =3D=3D NULL) {
> > +        return -TARGET_EFAULT;
> > +    }
> > +    ret =3D get_errno(futimesat(arg1, p, tvp));
> > +    unlock_user(p, arg2, 0);
> > +
> > +    return ret;
> > +}
> > +
>
> The functions above are quite duplicated.
> We could factor the first part at least, setting tvp.
> The lock_user_string part can be replaced with LOCK_PATH.
>

This is a good suggestion. I hesitated to implement it when I last had time
to work
on bsd-user upstreaming. I've created
https://github.com/qemu-bsd-user/qemu-bsd-user/issues/65 since I'd like to
defer
changes here. There's no good regression tests for these functions and I'd
like
to do the refactoring when I have the time to focus on ensuring they
continue to
be correct. In all the rebasing, I've somehow created a hang that I can't
recreate
in a small test case sometime during the last several years. I'd like to
get what
we've been using upstreamed and then focus on improving the code.

Warner


> > +/* timer_create(2) */
> > +static inline abi_long do_freebsd_ktimer_create(abi_long arg1, abi_lon=
g
> arg2,
> > +        abi_long arg3)
> > +{
> > +    /* args: clockid_t clockid, struct sigevent *sevp, int *timerid */
> > +    abi_long ret;
> > +
> > +    struct sigevent host_sevp =3D { 0 }, *phost_sevp =3D NULL;
> > +
> > +    int clkid =3D arg1;
> > +    int timer_index =3D next_free_host_timer();
> > +
> > +    if (timer_index < 0) {
> > +        ret =3D -TARGET_EAGAIN;
> > +    } else {
> > +        int *phtimer =3D g_posix_timers  + timer_index;
> > +
> > +        if (arg2) {
> > +            phost_sevp =3D &host_sevp;
> > +            ret =3D target_to_host_sigevent(phost_sevp, arg2);
> > +            if (ret !=3D 0) {
> > +                return -TARGET_EFAULT;
> > +            }
> > +        }
> > +
> > +        ret =3D get_errno(__sys_ktimer_create(clkid, phost_sevp,
> phtimer));
> > +        if (ret) {
> > +            phtimer =3D NULL;
> > +        } else {
> > +            if (put_user(TIMER_MAGIC | timer_index, arg3, int)) {
> > +                ret =3D -TARGET_EFAULT;
> > +            }
> > +        }
> > +    }
> > +    return ret;
> > +}
> > +
> > +/* timer_delete(2) */
> > +static inline abi_long do_freebsd_ktimer_delete(abi_long arg1)
> > +{
> > +    /* args: int timerid */
> > +    abi_long ret;
> > +    int timerid =3D get_timer_id(arg1);
> > +
> > +    if (timerid < 0) {
> > +        ret =3D timerid;
> > +    } else {
> > +        int htimer =3D g_posix_timers[timerid];
> > +        ret =3D get_errno(__sys_ktimer_delete(htimer));
> > +        g_posix_timers[timerid] =3D 0;
> > +    }
> > +    return ret;
> > +}
> > +
> > +/* timer_settime(2) */
> > +static inline abi_long do_freebsd_ktimer_settime(abi_long arg1,
> abi_long arg2,
> > +        abi_long arg3, abi_long arg4)
> > +{
> > +    /*
> > +     * args: int timerid, int flags, const struct itimerspec *new_valu=
e,
> > +     * struct itimerspec * old_value
> > +     */
> > +    abi_long ret;
> > +    int timerid =3D get_timer_id(arg1);
> > +
> > +    if (timerid < 0) {
> > +        ret =3D timerid;
> > +    } else if (arg3 =3D=3D 0) {
> > +        ret =3D -TARGET_EINVAL;
> > +    } else {
> > +        int htimer =3D g_posix_timers[timerid];
> > +        struct itimerspec hspec_new =3D {{0},}, hspec_old =3D {{0},};
> > +
> > +        if (target_to_host_itimerspec(&hspec_new, arg3)) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +        ret =3D get_errno(
> > +            __sys_ktimer_settime(htimer, arg2, &hspec_new, &hspec_old)=
);
> > +        if (arg4 && host_to_target_itimerspec(arg4, &hspec_old)) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +    }
> > +    return ret;
> > +}
> > +
> > +/* timer_gettime(2) */
> > +static inline abi_long do_freebsd_ktimer_gettime(abi_long arg1,
> abi_long arg2)
> > +{
> > +    /* args: int timerid, struct itimerspec *curr_value */
> > +    abi_long ret;
> > +    int timerid =3D get_timer_id(arg1);
> > +
> > +    if (timerid < 0) {
> > +        ret =3D timerid;
> > +    } else if (!arg2) {
> > +        ret =3D -TARGET_EFAULT;
> > +    } else {
> > +        int htimer =3D g_posix_timers[timerid];
> > +        struct itimerspec hspec;
> > +        ret =3D get_errno(__sys_ktimer_gettime(htimer, &hspec));
> > +
> > +        if (host_to_target_itimerspec(arg2, &hspec)) {
> > +            ret =3D -TARGET_EFAULT;
> > +        }
> > +    }
> > +    return ret;
> > +}
> > +
> >
> >  #endif /* FREEBSD_OS_TIME_H */
> >
>
>

--000000000000dc18f006591e11d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 22,=
 2026 at 5:38=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bo=
uvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On 5/18/2026 2:27 =
PM, Warner Losh wrote:<br>
&gt; Add time-related system call shims: utimes, lutimes, futimes,<br>
&gt; futimesat, ktimer_create, ktimer_delete, ktimer_settime, and<br>
&gt; ktimer_gettime.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Mika=C3=ABl Urankar &lt;<a href=3D"mailto:mikael.uranka=
r@gmail.com" target=3D"_blank">mikael.urankar@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; Assisted-by: Claude Opus 4.6 (1M context)<br>
&gt; ---<br>
&gt;=C2=A0 bsd-user/freebsd/os-time.h | 210 +++++++++++++++++++++++++++++++=
++++++++++++++<br>
&gt;=C2=A0 1 file changed, 210 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h<b=
r>
&gt; index 16b71e6234..05fa043442 100644<br>
&gt; --- a/bsd-user/freebsd/os-time.h<br>
&gt; +++ b/bsd-user/freebsd/os-time.h<br>
&gt; @@ -217,5 +217,215 @@ static inline abi_long do_freebsd_ntp_gettime(ab=
i_ulong target_ntv_addr)<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; +/* utimes(2) */<br>
&gt; +static inline abi_long do_freebsd_utimes(abi_long arg1, abi_long arg2=
)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 void *p;<br>
&gt; +=C2=A0 =C2=A0 struct timeval *tvp, tv[2];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (arg2 !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (t2h_freebsd_timeval(&amp;tv[0], arg2)=
 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t2h_freebsd_t=
imeval(&amp;tv[1], arg2 +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 sizeof(struct target_freebsd_timeval))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tvp =3D tv;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tvp =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 p =3D lock_user_string(arg1);<br>
&gt; +=C2=A0 =C2=A0 if (p =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 ret =3D get_errno(utimes(p, tvp));<br>
&gt; +=C2=A0 =C2=A0 unlock_user(p, arg1, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* lutimes(2) */<br>
&gt; +static inline abi_long do_freebsd_lutimes(abi_long arg1, abi_long arg=
2)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 void *p;<br>
&gt; +=C2=A0 =C2=A0 struct timeval *tvp, tv[2];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (arg2 !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (t2h_freebsd_timeval(&amp;tv[0], arg2)=
 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t2h_freebsd_t=
imeval(&amp;tv[1], arg2 +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 sizeof(struct target_freebsd_timeval))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tvp =3D tv;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tvp =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 p =3D lock_user_string(arg1);<br>
&gt; +=C2=A0 =C2=A0 if (p =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 ret =3D get_errno(lutimes(p, tvp));<br>
&gt; +=C2=A0 =C2=A0 unlock_user(p, arg1, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* futimes(2) */<br>
&gt; +static inline abi_long do_freebsd_futimes(abi_long arg1, abi_long arg=
2)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct timeval *tvp, tv[2];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (arg2 !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (t2h_freebsd_timeval(&amp;tv[0], arg2)=
 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t2h_freebsd_t=
imeval(&amp;tv[1], arg2 +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 sizeof(struct target_freebsd_timeval))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tvp =3D tv;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tvp =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return get_errno(futimes(arg1, tvp));<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* futimesat(2) */<br>
&gt; +static inline abi_long do_freebsd_futimesat(abi_long arg1, abi_long a=
rg2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_long arg3)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 void *p;<br>
&gt; +=C2=A0 =C2=A0 struct timeval *tvp, tv[2];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (arg3 !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (t2h_freebsd_timeval(&amp;tv[0], arg3)=
 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t2h_freebsd_t=
imeval(&amp;tv[1], arg3 +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 sizeof(struct target_freebsd_timeval))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tvp =3D tv;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tvp =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 p =3D lock_user_string(arg2);<br>
&gt; +=C2=A0 =C2=A0 if (p =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 ret =3D get_errno(futimesat(arg1, p, tvp));<br>
&gt; +=C2=A0 =C2=A0 unlock_user(p, arg2, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
<br>
The functions above are quite duplicated.<br>
We could factor the first part at least, setting tvp.<br>
The lock_user_string part can be replaced with LOCK_PATH.<br></blockquote><=
div><br></div><div>This is a good suggestion. I hesitated to implement it w=
hen I last had time to work</div><div>on bsd-user upstreaming.=C2=A0<span s=
tyle=3D"background-color:transparent">I&#39;ve created</span></div><div><sp=
an style=3D"background-color:transparent"><a href=3D"https://github.com/qem=
u-bsd-user/qemu-bsd-user/issues/65">https://github.com/qemu-bsd-user/qemu-b=
sd-user/issues/65</a> since I&#39;d like to defer</span></div><div><span st=
yle=3D"background-color:transparent">changes=C2=A0</span><span style=3D"bac=
kground-color:transparent">here. There&#39;s no good regression tests for t=
hese functions and I&#39;d like</span></div><div><span style=3D"background-=
color:transparent">to do the refactoring when I have the time to focus on e=
nsuring they continue to</span></div><div><span style=3D"background-color:t=
ransparent">be correct. In all the rebasing, I&#39;ve somehow created a han=
g that I can&#39;t recreate</span></div><div><span style=3D"background-colo=
r:transparent">in a small test case sometime during the last several years.=
 I&#39;d like to get what</span></div><div><span style=3D"background-color:=
transparent">we&#39;ve been using upstreamed and then focus on improving th=
e code.</span></div><div><span style=3D"background-color:transparent"><br><=
/span></div><div><span style=3D"background-color:transparent">Warner</span>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +/* timer_create(2) */<br>
&gt; +static inline abi_long do_freebsd_ktimer_create(abi_long arg1, abi_lo=
ng arg2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_long arg3)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* args: clockid_t clockid, struct sigevent *sevp, int =
*timerid */<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 struct sigevent host_sevp =3D { 0 }, *phost_sevp =3D NU=
LL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 int clkid =3D arg1;<br>
&gt; +=C2=A0 =C2=A0 int timer_index =3D next_free_host_timer();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (timer_index &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -TARGET_EAGAIN;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int *phtimer =3D g_posix_timers=C2=A0 + t=
imer_index;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 phost_sevp =3D &amp;host_se=
vp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D target_to_host_sige=
vent(phost_sevp, arg2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGE=
T_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(__sys_ktimer_create(clk=
id, phost_sevp, phtimer));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 phtimer =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (put_user(TIMER_MAGIC | =
timer_index, arg3, int)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -TARG=
ET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* timer_delete(2) */<br>
&gt; +static inline abi_long do_freebsd_ktimer_delete(abi_long arg1)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* args: int timerid */<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 int timerid =3D get_timer_id(arg1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (timerid &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D timerid;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int htimer =3D g_posix_timers[timerid];<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(__sys_ktimer_delete(hti=
mer));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_posix_timers[timerid] =3D 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* timer_settime(2) */<br>
&gt; +static inline abi_long do_freebsd_ktimer_settime(abi_long arg1, abi_l=
ong arg2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_long arg3, abi_long arg4)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* args: int timerid, int flags, const struct itim=
erspec *new_value,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* struct itimerspec * old_value<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 int timerid =3D get_timer_id(arg1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (timerid &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D timerid;<br>
&gt; +=C2=A0 =C2=A0 } else if (arg3 =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -TARGET_EINVAL;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int htimer =3D g_posix_timers[timerid];<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct itimerspec hspec_new =3D {{0},}, h=
spec_old =3D {{0},};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (target_to_host_itimerspec(&amp;hspec_=
new, arg3)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __sys_ktimer_settime(htimer=
, arg2, &amp;hspec_new, &amp;hspec_old));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg4 &amp;&amp; host_to_target_itimer=
spec(arg4, &amp;hspec_old)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* timer_gettime(2) */<br>
&gt; +static inline abi_long do_freebsd_ktimer_gettime(abi_long arg1, abi_l=
ong arg2)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* args: int timerid, struct itimerspec *curr_value */<=
br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 int timerid =3D get_timer_id(arg1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (timerid &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D timerid;<br>
&gt; +=C2=A0 =C2=A0 } else if (!arg2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int htimer =3D g_posix_timers[timerid];<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct itimerspec hspec;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(__sys_ktimer_gettime(ht=
imer, &amp;hspec));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host_to_target_itimerspec(arg2, &amp;=
hspec)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #endif /* FREEBSD_OS_TIME_H */<br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000dc18f006591e11d2--

