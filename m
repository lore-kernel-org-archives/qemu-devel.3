Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039C7C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylFB-0005zJ-5K; Tue, 25 Aug 2026 03:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wylF8-0005z2-Po
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wylF6-0005mM-Ud
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787641602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hqvUiKilQMfCX5/BxjckAZvArqCilWtc9Gz/iC7qTsY=;
 b=d37jec6mGu2QN4KQwVwg/ZQE6MW5gm5zZS2WLNoXNbutYnxsNrQJv8v/YIM04I/eoDi5sa
 gvqokJiHc2Am4FQGUrwSwRuf0CKV+/q9QMH+xStg0/QrbuFgx9nQvMSzTLPySRVjbrZ1RJ
 7ca7vpeNj6zl2yixRnQAQHSSe88Fdks=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-uha2U0adPpGKS6nye1EGCA-1; Tue, 25 Aug 2026 03:06:40 -0400
X-MC-Unique: uha2U0adPpGKS6nye1EGCA-1
X-Mimecast-MFC-AGG-ID: uha2U0adPpGKS6nye1EGCA_1787641600
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbedf6e8a42so5362463a12.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 00:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787641600; cv=none;
 d=google.com; s=arc-20260327;
 b=PwjatmQFN3mINne7M0hBqNrfG6GxKaVL6BgX3gxOo+ko8JlQFVjHZ4WDoJ0AR2gy4Y
 Qi496XQMHxmnToJ5i2ydiD+DOkCg+8hZF0Y9kjUYDT65HGfhtBWLJbuFzfsqt7gpKtKY
 /plm/MjPOHSdzP4w3SjqzmTJKWGMz6CtLz+Ys3jMVzd0xxa7UQbCLnt1MWdc+Z6/JKWw
 cO9NH9H93N0ky1qw+BlHbjjQ8A4C0JGPd9WCayWUfOQDUezxJ6i82/6/IHIfwAwGUOvj
 UwmEDfWW0GYRIScNt5hcgtOVCYTCKFUxi+eps79bJzj+5tiy+xQIbpANhtM1bIA25v5b
 HSRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hqvUiKilQMfCX5/BxjckAZvArqCilWtc9Gz/iC7qTsY=;
 fh=clj/N3aH4K/xfvVAs99VTHE3zWNs21ViYr0khAbs26E=;
 b=HSSzOaaIfH0N/MpIY0oe1nNPKUFXObgna9ANi8ccvKPQnfREI7cSybxSOG/4UvUV2K
 hqJU0bMQSzks+NPFPDssFowpdjlcBFXabrYh+3qGr3aZg5FFVf0ueFDZhytDhYd2oFpu
 jFX/ez2JaGiByBmHKhfcozEdOQE841cmshcaELsAZcgegGlJz9Nti5BLiqqyGen5vCWc
 m341scoAsxiNgCaeHJpRNclQRVy3Eh4EeXlx6qvxHYuL6/zJBgUWL7KLr8tcje73+vRn
 rJAxEsLEb4fEClITRS+7OszT7wn5NbWsAnz06D0iu7YMxA9BRd/oCdHeZn8s8T6LLdsC
 z8Og==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787641600; x=1788246400; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hqvUiKilQMfCX5/BxjckAZvArqCilWtc9Gz/iC7qTsY=;
 b=INubuNvT0W9d0qgZ+78QcV/WEQqRQMjHfRmwhj4a+64PsJ6oM1kthr23wKpK0dUcqj
 Esa4yHT0mihKoAUP3DQoClWsFC0ijKgJk2vNroEJpjz9n0jV/FukeUoRH0zjpG96w6AG
 ZYd29UqAPzBVjPh5s2DQI/Kp/KdwIYkJIZnmOBlCoI57rZdRUGPVAUJSydlzmp4K2NaQ
 HjKGkqHGr5Xdb4HXJBiQMOH2wiivv7C15E+LtuRcEi4LleoGKav0lWBzbwACz8IW/6pv
 FhvXPhu9mWpTNFi2vWxAu5CrJsHbEVhu3pjA2kJ4iSvtyyzQXMryn+ohwofz4gj1NRyk
 rt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787641600; x=1788246400;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hqvUiKilQMfCX5/BxjckAZvArqCilWtc9Gz/iC7qTsY=;
 b=rcfpqLTkGIqkZHWltGXzNPaLz4pIhSm6RBB5IwPV2ccE1fNsxX4QXnMxOQm6XcNsoZ
 ZGiRF7q/XtcOcRUfOxI+KrhVpY/1f0Ssr8Ok1quItzoqw4mBrAxuQ27KLmMLCCTEeL7e
 WN22SfFvQyix/2s0XeHdgwFefYb1x15CMDzsA+N4nOQ4HpWDP4rGB0ydYHQSLAd9lz9O
 vl6upbbhZv9iAob3vGn5WWLwNhSZDSHmNy0Eu0MepScW4bJOCCLb2Nfw3j9z9C7Sz2tr
 bKj6YtzifV1JSCEvLLVcxi/F5LmABWkF+OspCS+Lx+KzbQWLPcSwDr8nL9A771jb6Ahh
 GpHA==
X-Gm-Message-State: AFuF++neC7pN+gMhDC/6BClqIP6ZrwzO0WjLXX10YCv3AY0e5w5X1HBe
 LeeWf0bvCKdMWcHb+coIL45zb4GQM/MonsdJV9o8ODe6YNgiJIgovzFQq+gJI77MkypZFHOkFrG
 xX6WjCYoQjkMRx9WqAhjq3YgQKCYLpMwvESAh+I3Ex7ma9nrY25WitrqO/bIvZlvrRFjj1G9IPe
 PcN8TD8Gf36NAUbvEr79Vf3q+E+F5kzVI=
X-Gm-Gg: AR+sD10C2KlMwOcXhkFulPkODDYOkmxsu8HyJWymNmjZlCyDBdgjewnbkKcBau11NsO
 /hNw7W1vq+OzTzPah1Jt+QTU6/elDkT8tdcoqH7wdrbZ8+1LU1Mm8aJRxF0wYXXrrCL+W4KcB/T
 z0BidBWJd7Pwvo6iEhGd8Me2qmgSs7/SA4bhLC5KYoUErJFx9n8oVsVN/YTwTCa8uzgq/D0QBW5
 z0MbiWCp30dgg2qvliN7gydXHPZk9aYssEW/DnUEONN8SP3O0sO/4T5QOU13QGU2FdWb+VLIKmC
 xQ==
X-Received: by 2002:a05:6a21:1644:b0:3bf:ba48:ca88 with SMTP id
 adf61e73a8af0-3cd3011c9e3mr65873417637.15.1787641599736; 
 Tue, 25 Aug 2026 00:06:39 -0700 (PDT)
X-Received: by 2002:a05:6a21:1644:b0:3bf:ba48:ca88 with SMTP id
 adf61e73a8af0-3cd3011c9e3mr65873284637.15.1787641599226; Tue, 25 Aug 2026
 00:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-35-e53fc35bc550@redhat.com>
 <aoxSYsbavuGtwCUO@redhat.com> <aoxS2YzUWsEEtUi3@redhat.com>
In-Reply-To: <aoxS2YzUWsEEtUi3@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 11:06:27 +0400
X-Gm-Features: AcwNN1Vp_JtKOhrKQlmCHr3kRMN7HkeTzxk_64dHmcI4s0UPyesoSj82Ow_l1c8
Message-ID: <CAMxuvazgV+u4XikaKuGWGHo3KqUWdUk1=somLYddqjBy7oEmPA@mail.gmail.com>
Subject: Re: [PATCH v3 35/49] error-report: switch to use monitor_cur_hmp()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi

On Mon, Aug 24, 2026 at 6:19=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Aug 24, 2026 at 03:17:06PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Sun, Aug 16, 2026 at 11:13:02PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > > Instead of passing a Monitor pointer through error_vprintf_mon() and
> > > error_printf_mon(), call monitor_cur_hmp() directly. This removes the
> > > monitor parameter from the internal helpers and the manual
> > > object_dynamic_cast() in vreport().
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  util/error-report.c | 72 +++++++++++++++++++++++++------------------=
----------
> > >  1 file changed, 34 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/util/error-report.c b/util/error-report.c
> > > index aaa15bc79827..70cbd174ffae 100644
> > > --- a/util/error-report.c
> > > +++ b/util/error-report.c
> > > @@ -30,34 +30,31 @@ bool error_with_guestname;
> > >  const char *error_guest_name;
> > >
> > >  /*
> > > - * Print to the current human monitor if we have one, else to stderr=
.
> > > + * Print to the current HMP monitor if we have one, else to stderr.
> > >   */
> > > -static int G_GNUC_PRINTF(2, 0)
> > > -error_vprintf_mon(Monitor *cur_mon, const char *fmt, va_list ap)
> > > +static int G_GNUC_PRINTF(1, 0)
> > > +error_vprintf_mon(const char *fmt, va_list ap)
> >
> > Please don't remove this 'cur_mon' parameter.
> >
> > >  {
> > > -    /*
> > > -     * This will return -1 if 'cur_mon' is NULL, or is QMP.
> > > -     * IOW this will only print if in HMP, otherwise we
> > > -     * fallback to stderr for QMP / no-monitor scenarios.
> > > -     */
> > > -    int ret =3D monitor_vprintf(cur_mon, fmt, ap);
> > > -    if (ret =3D=3D -1) {
> > > -        ret =3D vfprintf(stderr, fmt, ap);
> > > +    MonitorHMP *hmp =3D monitor_cur_hmp();
> >
> > This calls qemu_mutex_lock/unlock, which have trace points.
> > As a result if you have 'log' tracing enabled, error messages
> > will get trace point output splattered on top.
> >
> > We must fetch monitor_cur_hmp once only at the top of
> > vreport() and never query it again.
>
> See my previous fix for this problem in:
>
>   commit 2eb00abcfebc3fa0a7c2915d1d29fa8fe0b88379
>   Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>   Date:   Wed Sep 10 17:32:37 2025 +0100
>
>     util: fix interleaving of error & trace output
>
>

Ok, I will update the patch and adjust the doc comments.

thanks


