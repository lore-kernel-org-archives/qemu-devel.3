Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E89C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 09:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDCR-0000O1-Ox; Mon, 13 Jul 2026 05:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjDCL-0000Lx-GZ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:43:37 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjDCK-000396-1J
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:43:37 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-664ce3000e6so2831762d50.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 02:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783935815; cv=none;
 d=google.com; s=arc-20260327;
 b=nzn9SDKwoQmx9eEkskFdh4A4PCFuqbkbVPz0ZYx9ryLNJ7KdanONUwsQKvCHOk5CN7
 DJ5vKH0Aiv0l1Mf3bxbz1HjbDASsPQw6vGmIlFDXYzlwvt7UTHkPQzGVbzWoLdwH4WTt
 iQXfkt2x2T78ZBVdRtCuKJvhyUzt7q0IjhGPhkh5xZZs+Ne3lmV7UYU4W0bNJSNknzMI
 r46Dr0v2aVnx18DxL/8O0IquNYwwRyqbEo7RGRPnieWNBSq9cyffEe4Vbmt4ATHPIzWK
 2TfAw0Ag78lolrvB4lKPaOtLaqe1eK16T43YvNtybUrd+E+Qf+9jf4ZYafr34gW3AMlZ
 w66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vFtGvgLS19/Qe5KFs3oSzMCJS2MF91MVGVg+0hALwyE=;
 fh=56a+Y8tG+YxKAFxOna2v4CZJWV92x/DWXGaEICSsUpg=;
 b=ju4/gpk8e2TunjcXeHRhc0U0DvTAohrRPamLFb52A282D7ROf+zuVB3Vo+L5qfs4UQ
 Rn1+8GsWfWrpmwHPyHCW5FQ2JqA1JQptK87kAGVza3bmckvB2MmqPmYSDZJVM0RHg81/
 dnPlaqTqOAol3sNvWZOl1ke3PJBGcPFoPzzbZ5vminfalqhUUV18sYvloi5YCii/Sx1g
 0JdvTpGkhFeeoPGcszlIzEszW/FLK9WCQv9FgwQHZpzNWOIl/zmfJTrdGq3tQAY6kezC
 xQFidqCNDyf37yuAFOCuB9OURVqe/+PL1jjufRHSnXIpt7xHA/uwq+5UG+c4rPtwDVaR
 l9Fw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783935815; x=1784540615; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vFtGvgLS19/Qe5KFs3oSzMCJS2MF91MVGVg+0hALwyE=;
 b=GtoSWhnDtooJ1lt4RpPj9pVKR+XpJAuhxpm/LTw2MdCpcqfvv7kMPTVcuuhGgO8vN1
 +P+2llBeggjfBet1zAfp0pYXaAYIAE3r4BT/9PR1lL6qbvzylIxdwxqX57JVpiT7Oqt0
 vraq2mSY9BJnolkKGb63CTuCc1muH44ygIEgpCw/NgFyuVRIzcXI3PR+3nczWIXnEfve
 AXlREJZVWrxSHuMRpa4YEbx2Ch6lnxYuaDyUiPmEulld4qukSd3RXBs2z4t3wsb6ziWA
 bbdkb/WUy3fCtPOhY362DaRU2HAm8+Jjuvjm/pZ72uENgqnFJZ6PLMMW3pfKJookZ5rC
 MxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783935815; x=1784540615;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vFtGvgLS19/Qe5KFs3oSzMCJS2MF91MVGVg+0hALwyE=;
 b=Ik+i7jbmSQ7bnC9P/MM0YfPcxj25+JFq/vEp4bt3orTemntpGUhuWXIDWq3BGqxqEa
 Y2Vq0e2bYjioi8zGLXcOs3W/V+oT+mv5zBtEAdE9IciOgkttFexFYRpSlP5uZXZqTagc
 wdMAdqAG4VL6F5uxg8DHeDnHajU/IDi+y2UjbWXepxx8aSq6+a9LEQpthNBF31lUqiuv
 Q4Cbn1Bq02/WwFskP6DMC8pKVngB4DqLTuYNdaN5lJrSk7cf30DYdAHB6zuTqoV8DjFo
 mFrEgnRPw7n8ACZSWWPw9iZWEq0Gn7dTh/e77LfHrqZW3/6NQYYVAU+2xO1SMNSnplC2
 zXww==
X-Gm-Message-State: AOJu0YxzRR5E3btSw6MsdITlhMXKnhZtdU5KCUuoPucCqpAMKTrBKgeB
 SSOiYr8iFx4j93VJTkuBJ+k68vdzqYMcgpECoKQ47tNJvy/4LjVpBVGSnKnewduF6AN3vpn722v
 yGmXdOU0L2Ozew7N0iyvtbKN/ZULBY6CF3YZso4HCpg==
X-Gm-Gg: AfdE7cmk9Ib8MVq1aHRBXM4INXEE+O6/2sk1rRmceGWMmsdx3BLBIjFGUYHdIUMqGWD
 MyGpWIHAtnadLUAi74FK9cppfAsHDU0uo9B33jxBvMT8PUmtQq9mMn8rwYfN+4gtjsZIQZAIOWE
 0JClRkW4icRFes3Rgze3FsId01p0+fnPc8hJ2wjHnzPi/xYmT/bBhzemjJO9nvGID2tesDY7hle
 PqReHa9Ce/qw+6H+C628TR0zD7yZF38rY0rkVaHTfPOAiaxgNm5YFAWOxHy2ZEhSqDffBvTdEaR
 7kroMM/QOFTSxz9dTDaImQCvLs23shN09oj7Oa/8ihLH7cn/x642Mixc
X-Received: by 2002:a53:be45:0:b0:667:8b91:242d with SMTP id
 956f58d0204a3-667d7c71ce3mr3825488d50.92.1783935814566; Mon, 13 Jul 2026
 02:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260706182034.1003176-1-peter.maydell@linaro.org>
 <aaee2b54-01df-48ca-9c83-796069767ca1@oss.qualcomm.com>
In-Reply-To: <aaee2b54-01df-48ca-9c83-796069767ca1@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 10:43:23 +0100
X-Gm-Features: AVVi8Cdc8GKMtE2UbOqKqqkunpyrDtbyCGU_dUMflwp0uhY_StmvAu23cR9JVeg
Message-ID: <CAFEAcA_7m47nAAENT7c0bPHt+YBi-cWFXD1L7buV0YqqyXjndQ@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/dev-wacom: Don't write off end of buffer
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 6 Jul 2026 at 21:43, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 6/7/26 20:20, Peter Maydell wrote:
> > In usb_wacom_handle_data() we allocate a buffer with a size
> > determined by the transfer size requested by the guest.  We then fill
> > it in by calling either usb_mouse_poll() or usb_wacom_poll(), both of
> > which functions take a length and return an actual length, which we
> > pass to usb_packet_copy().  However, usb_mouse_poll() doesn't check
> > the buffer size as it fills in the buffer, so if the guest passes an
> > overly short transfer size then it will write off the end of the
> > allocated buffer.
> >
> > Check the length is at least big enough for the minimum 3 byte
> > packet and return nothing if it is not, as usb_wacom_poll() does.
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3672
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/usb/dev-wacom.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
> > index c69e247f7b..895edcc17e 100644
> > --- a/hw/usb/dev-wacom.c
> > +++ b/hw/usb/dev-wacom.c
> > @@ -285,6 +285,10 @@ static int usb_mouse_poll(USBWacomState *s, uint8_=
t *buf, int len)
> >           b |=3D 0x04;
> >       }
> >
> > +    if (len < 3) {
>
> Maybe log GUEST_ERROR? Anyway:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Thanks; I'll take this via target-arm.next as I'm putting
together a pullreq anyway.

-- PMM

