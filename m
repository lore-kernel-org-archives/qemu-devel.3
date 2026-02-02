Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B27AE73176
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmuJU-0003Rv-HA; Mon, 02 Feb 2026 08:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmuJT-0003Qd-BS
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:49:59 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmuJR-0005Se-PI
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:49:59 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-790b7b3e594so45155007b3.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:49:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770040196; cv=none;
 d=google.com; s=arc-20240605;
 b=YId//2THYK6l2q9o8VO+5KPj5tRzie2Lm0/QSNuaKDmICYTJoRGBKgcPhFYuO2WYaB
 EXY3svx/DWTq5w76q3W7U080Mv3hPvwfNNPTZqGvClPTLcJ82v9ocBbLq+060HIpcUuR
 FZl5tbhkFvnoBYRkQcw7+MSoi4UbdA9/N+jUMW/arq87FGbRcvd21NttP5EKBN4WbMGl
 v3e8PAzH52p/VGflVZL/aKIhppIiLTRDNr5/1rU10zj/j8VJa/55CvjMkBgrvqwuqccJ
 mqL3PH0RT/jIzpzooACVDNs17hlJWkW343Lh8mWBnD6zgY6gxgK9D2/kuL+/bXZfDaB3
 yk0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xrZIpAFZGquKXWnjZgf/7sOBNHczMZ1kA3U/EQOXnVU=;
 fh=/0pxUU20+D2p0KPLzhwUcKnxMiOCqX3YUFX40lJIjsM=;
 b=erJCplUcVDD8n+l4KJ+Yr1sJJtKEHiGcB1UypAxvWSXb9YIwnm7ttkdYf+om+YsQni
 +/DDyYofV37cfhJKrDQ/XNJZXNRoYLcpXmVTUKDfRWMhOdH6Jv+2q240migAg1gScHDv
 3MICuFW0mQTtYdU4aQK4RqIRtUy2bndZbdAT0ZYwTtL8uOO2KS+Dr7ww8YYi6wLhsJ+W
 mhKDMAih0v2ydG2dFiLDUzIs3YqZuSwSNMmaa8VZKDI/f4s8ywtXxxlfaAMsBqyLMqKV
 V3nMpFDihQEZVZq/HJaWK18G7So9sHpV4G9UnMAfN5vSF4BLW/QogDsgMWx2HTXiV7A2
 QJLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770040196; x=1770644996; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrZIpAFZGquKXWnjZgf/7sOBNHczMZ1kA3U/EQOXnVU=;
 b=e6fTi9El5jWsQV878zAa9RJ6Q5cdxr/z6LyioSAwfuRM4ARpF96bwmH8ytcj55vzry
 eTQm3DfvUhqth41wnyQqVLrBfKko8jMBwFoQn5WiYqdxS7WvL7VARwLOwc3fJ8kc6QkZ
 MDOEEQDPXNv6CrEjTbCOdfcNUfYGXaSKSex4MVmG+1r5E1hWgmMTdv7qzdp6IzcMb5on
 HY1mjNDFM1dMtsSZW37/txXK0yZvfbYfoafSEbIVSW/6xWLTtQ2DMgQ41dWgPsTPca13
 OXq/8+2fBX1npXxXaRSUTo+4QyNKw72Pg5QtYkomm7ouA5fSRFqcY1kyAZ498SbKrj6B
 NQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770040196; x=1770644996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xrZIpAFZGquKXWnjZgf/7sOBNHczMZ1kA3U/EQOXnVU=;
 b=hFPvzcnDjwTpPkY3351PuPEQ0ChqDxOgdfi6cbsCkjnJ4mmY6vB+Rtp9fB+NaAz7hs
 QllkDpoppnNzMpdDLttq/HpQVPncv8mvfSK54wKzo2cW9WvSTkJiAmHyqS2kZvcmI30k
 l3tzlc5DLy1Xesq3MPo9dNJCVnCsdjmP7rlojKQc3oMeCs7obeMJLKDgnB0RQcoBf+/n
 y6BQslZWnM7PAuWOPe1j8yLyM9qyNyRE6ZOVHwKhTL0gM3KFQmNMyyUd2BBrO31oYSQX
 yqpBR2X1W8kr+Wc94WGWNeAJx926nc2lwBCNuUxsOm10Ji3ZsFqnxyTh2irMV3Pjh5BT
 Wnbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY5XFHpJZ9DcUx/upH64zzHJ90QNJCg74Q/Z8hpdIwUHFogeFOYmF64ngbY4b8oGK4uo8+6/plh7rT@nongnu.org
X-Gm-Message-State: AOJu0YzTQYRuqjloXbFiUsHtB2ru7NiVklY1EVxWN1vCmBCcTbfc2h4u
 0Xdg4YvI2gECelJRbUgnC21FtrZVQKmJHjI3IFmNkwQGzOmQROKHRuEDZKNtvDNQ0AAHej2zWRE
 MFYYAisNHcPLem82qbYwCb4+xHxR6M2NkARuSaJ5Zzg==
X-Gm-Gg: AZuq6aJpAfeKXrmGLWrLez3J4NVggxwuD/pTFIMndFd5fy/k8rYCybAatdYfTq4i3Qt
 /Zyr6nNWME3Cuon/YN2XhWEuelGT/9PPXouil2fnESoN7QSsCyX/ex9td85hmDNT6fNiEZnMJaZ
 i0dAStnuWTd9zJEgEhQCOCrTCDdPh0wgZZU9jZzMSdpVlXMUibfsnzvoGD0qJkN6LLUcE9wMpK/
 zS8zDcQ8StRQcfszdkVCuENvRAyBorocbQPTHNxL9VGVe7/qAJluCCQYu/P7kRCStDYXw==
X-Received: by 2002:a05:690c:fd2:b0:78c:64c1:c021 with SMTP id
 00721157ae682-7949de7f1fcmr93236017b3.7.1770040196194; Mon, 02 Feb 2026
 05:49:56 -0800 (PST)
MIME-Version: 1.0
References: <875x8fpa0x.fsf@draig.linaro.org>
 <2946621b-3d00-40dd-a80f-3f301a2e9564@redhat.com>
In-Reply-To: <2946621b-3d00-40dd-a80f-3f301a2e9564@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Feb 2026 13:49:45 +0000
X-Gm-Features: AZwV_QhrOITpFuPZPNrHR_h7o4h-PmEsOtBmkJCd8YaiPcYoXep1w7Tp7eYeMt4
Message-ID: <CAFEAcA8rsJc_+JZY=TT96NAt0yskvwatvvMSHgwT+Zf5Y4=Daw@mail.gmail.com>
Subject: Re: KVM/QEMU Community call (3/2/26) agenda items?
To: eric.auger@redhat.com
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>, 
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, 
 Markus Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, cw@f00f.org, 
 demiobenour@gmail.com, dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, 
 eblot@rivosinc.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, felipe@nutanix.com, 
 Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com, Warner Losh <imp@bsdimp.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, 
 Jim Shu <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 Max Chou <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com, "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, 
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 wei.w.wang@intel.com, 
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com,
 Sebastian Ott <sebott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Mon, 2 Feb 2026 at 13:29, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Alex,
> On 2/2/26 2:09 PM, Alex Benn=C3=A9e wrote:
> > Hi,
> >
> > The KVM/QEMU community call is at:
> >
> > https://meet.jit.si/kvmcallmeeting
> > @
> > 03/02/2026 14:00 UTC
> >
> > Are there any agenda items for the sync-up?
> >
> I would be interested in discussing RH aarch64 cross kernel migration
> issues.
>
> [PATCH v6 00/11] Mitigation of "failed to load
> cpu:cpreg_vmstate_array_len" migration failures <https://lore.kernel.org/=
all/20260126165445.3033335-1-eric.auger@redhat.com/#r>
> (https://lore.kernel.org/all/20260126165445.3033335-1-eric.auger@redhat.c=
om/)
> and
> [PATCH v4 0/2] arm: add kvm-psci-version vcpu property <https://lore.kern=
el.org/all/20251202160853.22560-1-sebott@redhat.com/#r>
> (https://lore.kernel.org/all/20251202160853.22560-1-sebott@redhat.com/)

FWIW, that set of patches are in some sense on my to-review queue,
but the area is complex enough that I have not yet made time to
try to understand it and have enough of an opinion to review them.

thanks
-- PMM

