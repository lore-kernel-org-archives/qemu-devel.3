Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9A3C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuRYa-0003cX-JF; Thu, 13 Aug 2026 05:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuRYY-0003cL-Ti
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuRYW-0002ZT-Tv
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786612615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiWDfU6uPEgC+fgvgen8wVKXJdQQXZZysDfCpGdA2FI=;
 b=hQBvExqiwrLdmp3bV+NVBnB6wQNUJIW+/9weFRtlPhpRZZUQr4uOajY4U9zUqOJ50UUFUf
 Nta7KDQr3MHqT91RDNABqe7KvP6Jrjah6h1AqBqK/Kqiiz1J8gLT4F9G6LTYAPnIWE07Ko
 sk9G+uUZd8ouOvk4zpd2OVyAxswElHc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-_26VbbEDNhygPEaCSdeW3g-1; Thu, 13 Aug 2026 05:16:53 -0400
X-MC-Unique: _26VbbEDNhygPEaCSdeW3g-1
X-Mimecast-MFC-AGG-ID: _26VbbEDNhygPEaCSdeW3g_1786612612
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbef1d25500so941284a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 02:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786612612; cv=none;
 d=google.com; s=arc-20260327;
 b=GBwyLJHcokXRWLfcC0d6jFRo1cdiyeAoxZ2y5m0LxtKO+T0o+CGjLpmps1wYLGobUC
 CT34+Kp2fABDN+cpDasIoc6hAs7NdzG8jtjHjvlECwiZIOXxSFts2T5AsXt/ZL98U55g
 1Dldegd4il2W03ADgrbxMj1wjw6AjJpTwq7dRMvzqQyk2Tfe5RexkC69rj73TERqwUvZ
 qjerLsG8ZWy1WuifS0DaawEvSsVPrVK+19jIL5PjaG3qFpwc4TzSnmZMZbHhPgc1DXZz
 aDC88a+iTpprkwuS55II9fC5C8e2JFQg8wZTWQOEFioclZ0IzH7gq/chuWMg6Z3CYmQn
 yKYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wiWDfU6uPEgC+fgvgen8wVKXJdQQXZZysDfCpGdA2FI=;
 fh=ESlRlQ8JBIWfZns+TLDWb5mz8uFJum+6nzCxTfKZheg=;
 b=aXheKY3k5tzA7aBhatWEkdD4NwWoDWvunDFMbUIDPWisDLQ7etWec4cZ83hnBWFrIW
 foBnXtpbOykWhHn+7hOWybKYFSXbxrdTr9YPJXV3QwNHnAo+mrgpDBp+PrPGKPhNcDkf
 UHee+6RrUFwF5r4fF1DXhANP7Tulowy/iEcX6LFgyjs+vjGpuDJao8fsPUtcoL5gWMpT
 ZtAo94Mr2NxaFzN+pY005p8IkWcLQ8SSMm54650rQcv3dg6aOXavrRcaN8Sp9MuqepOq
 wZ6zweZb45ojsna0WwfOJxTCNdnj4Hw0sXGMrN0fr2nxPMpOGsnxbEdjMojMqnou39fT
 BT9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786612612; x=1787217412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wiWDfU6uPEgC+fgvgen8wVKXJdQQXZZysDfCpGdA2FI=;
 b=Yen2x72Fw0bz2bcQ/w7NicoXX0J/C+4pGVkmjWL+BrIfIiz49ot/F641+wpgEhnCEm
 clbThNpyx3YvBOU/H379ux99qDRfPg509DhCbj8i9uDyJP+TjyM/Pm094kRTJLZim6MN
 BIwnrleulNTKVHPLczCDKCAEHE908ZjK3ArMzqzfbO1rjUxDXP+ZtfCxN3MOKCd+16vK
 Cugxt55xg/mH7L9RhLGV4xNjhH+PSIxrb7qCwrjbO3qcCNnEE1MEew7RjEEPWrc65epV
 VypazPxxOK2SzizsKWA3C7DPcF8GjyPWsKiAu5QPXvEW42S1ZdWdoPJw5cu3OF77j/kN
 tJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786612612; x=1787217412;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wiWDfU6uPEgC+fgvgen8wVKXJdQQXZZysDfCpGdA2FI=;
 b=FnHzHjKDAAMfOYJwAxR/0TSzoaQL3EYbOpTjjiq/4A0IARTgc+lpzdVnvt62bhkQbz
 0JkVUSV9wkImsYgmIoUmOPT8DmB5iSXMMWwGIAJamEsyW1f8jgHtfKTk0V/MSyLopAEO
 lbfNBASOy2pZlyhijxUEDgrPU2dyfEvhBQm7ZQ9OlNTymo7XhMSNBgWGhtHZ6ya1xEDO
 6iTLdiyZSVfRbQyCSHUgk1NJmJsqGaxc3TC1/TIbgQqZxZsAxmJcetgjQvIUXETJNtwz
 TGqP505dYY2euyPap+WZVSZrSOlGT6LGfHSBvjVuVGqCsfFwx8msqU4cWzyWF/vgwXJw
 2Aew==
X-Gm-Message-State: AOJu0Yw7cOAGoMSCFMz3fCoiv6cODfeZHCVCkf4EKt3Hd5BrSm5yAPKV
 pLi4adeqMPe/jLZCtMCDatrEgQQ3sDFEQykhHOGqLlpyGc2Z9L+V4Zl3kwnwO/PuSgnzKhkFo3l
 oe6WCCDeyt0T7eeUhx/a1oj+XtaxOV/+wc6ntQ9TChXsymqlpjc/ryEX1TcquFLFGjdHhh7PLty
 ZR87ylldG8WVBne1hz3dWrCn6mykhQDMw=
X-Gm-Gg: AR+sD13zU39RMDfIpsLCGKRCDr2Iga2BNmJEg2R5KJyrMzv2LwCrLSCamxbW7dJJovU
 S0P8RKi08P188R3MfOYYqyy2ezGQAXGnBUeBQFySuVKYi6S6R/Sgg80Zs1rs2Z8ggRgMY191+f6
 Ttx9pCrRt3kqw9M3wcPqACnJH1saA9W22efM75kaBJ9vdyYrhQOIKzXftmuh02fKni2iH/sSJTs
 hsjbskp8yaRA+XzsGHg3GRSYHvVqYwFLUpxtXrTEVj4IxbGQkFQL/Fdy3ZZ18ATkHRasgjiuQ4w
 gA==
X-Received: by 2002:a05:6a21:6da9:b0:3c4:2fe1:fa36 with SMTP id
 adf61e73a8af0-3cc554fbb04mr5185317637.36.1786612612414; 
 Thu, 13 Aug 2026 02:16:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:6da9:b0:3c4:2fe1:fa36 with SMTP id
 adf61e73a8af0-3cc554fbb04mr5185269637.36.1786612611910; Thu, 13 Aug 2026
 02:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
 <20260812211708.92824-18-philmd@oss.qualcomm.com>
 <178660214825.3552881.16834360265143429528.b4-review@b4>
 <50260678-269c-47c6-86c5-a148b6156bb9@oss.qualcomm.com>
In-Reply-To: <50260678-269c-47c6-86c5-a148b6156bb9@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Aug 2026 13:16:40 +0400
X-Gm-Features: AUfX_mwcvb0mnjMS-ULKs_c4Ft-PfnIbYeGZtKrn70sdSjbEq6fpLbhysT4j5ng
Message-ID: <CAMxuvaz56A1Eh5LxdxJnwD-+yZAXvgQ_chFZUYvBy6bggVeTEg@mail.gmail.com>
Subject: Re: [PATCH v3 17/23] monitor: Rename MonitorQMP @mon -> @qmon
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Thu, Aug 13, 2026 at 12:24=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 13/8/26 08:22, marcandre.lureau@redhat.com wrote:
> >> Mechanical change to sanitize using the following patterns:
> >>
> >>    MonitorQMP *qmon  (this patch)
> >>    MonitorHMP *hmon  (following one)
> >>    Monitor *mon
> >>
> >> Rename @mon (and @qmp_mon) as @qmon when the type is MonitorQMP.
> >
> > This patch and the following are conflicting quite directly with
> > the work I have for --disable-hmp.
> > (https://gitlab.com/marcandre.lureau/qemu/-/tree/no-hmp)
> >
> > Can we delay them?
>
> I was expecting something like that, sure, no problem.
> >
> > fwiw, I picked Monitor *mon, MonitorHMP *hmp. I didn't touch MonitorQMP=
*.
> >
>
> Are you OK I merge patches 1-16 (now all reviewed) in my next
> misc PR?

yes please, asap :)

> I'd like to put #19 and #22 also, which are both HMP and removing
> the "monitor/monitor-internal.h" use out of monitor/ is a good
> cleanup IMHO. If you agree do you mind reviewing them, then I'll
> update the thread mentioning the queued patches.

ok


