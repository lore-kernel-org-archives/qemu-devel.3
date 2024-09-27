Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2D0CDD1CD
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 16:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suE9V-0001hV-44; Fri, 27 Sep 2024 12:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suE9T-0001h1-VC
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 12:49:08 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suE9S-0006pk-BJ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 12:49:07 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53988c54ec8so985092e87.0
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727455744; x=1728060544; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rw7kc6ewZR873XR44ypiXj1tN1+A6FgdVu2Q3D9pdFQ=;
 b=eb39epAZh4SABisZPaso0IxC/MN4CGY7y3cKLKNwsVw9P5CSinomu9HzzKI2knsVPy
 qwvVxVWG6IBmHdeBrx3/bC7QVsc0hB8UQoIGdNqjXt6LZDp0nJf+GS71pBJU9g2ysDTu
 CvPD4rxKWlhnfQ93BboIYbJ+P5t/xYHuUxGgdGF067ja4eIU54B+aqHMEUsPnWPK6uNr
 +FaRLNeYhTubiaqyYNedrgAE1L1AWJolMSfuY6WcNo+CoRrfv/jkoVlUDwNZFwXr7qD2
 P+6MQY8xmsHgJ90dgEaxJ/xxF88IjHcl62ezlaq5/Vre4sFkuCTlDewmOukQ+LjW28Ze
 hCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727455744; x=1728060544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rw7kc6ewZR873XR44ypiXj1tN1+A6FgdVu2Q3D9pdFQ=;
 b=WAPtpYECg9K20veeQkjlTyWIf49GHVnR0vwnHea/PvcRGh1LfkIJSj6YqodjrErFmT
 HD/yP/PW0kPQ30DA7kOmVdXVWlUENUgm/4mG9nSkRCfJXGf4oaqjou7PnOHnXb+v4d8e
 EvGaME8WVOZrBGkGUXOxEDe5WVyLYHy0/kRuqvYkr0FsjveEBGfRTsd93mu2AN9c5qgZ
 2ONJTByVTlT/eMWdiHg3qttLQugdPxZJh9VUox0M6tI1WaYgVLjGSE5+ZsppX3LdwR7v
 7+3zpEDRPpte8denivYoDFzt6JC/1As0LiolLwMEthlyI+QoFzzInZxtL37pUT1zVHr4
 uopA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsIsW0WCmhq+tpNkPjNMF3/yLc5uvd/GOxbdwyQbdK7JcjLS7cUUQA9g9IfoZ42iqgUyUuA+Iu5P+i@nongnu.org
X-Gm-Message-State: AOJu0YxV1gt+5W7NIhXTAIrNQhpHOCv5g5J/J+50uouHTp8tzGnArToL
 yP3wS0KYImkcYMHJfHwmQAntSaAqV4rBeicD/ProDaMdmPdiA6ET9O4O7BGH2djlgAYiiourbCs
 8HEyLYacudtLAVsfeINzCV4d3ss0cWbjNPEHYbA==
X-Google-Smtp-Source: AGHT+IGyqyHRnrcK+x5TN86I65uNFwih03Kn5S4AIT6TWLynUTS3SiOIyQZVQ+t0vz9nXw5DjjaKfNtG3muqgHcJft8=
X-Received: by 2002:a05:6512:3095:b0:533:4620:ebfb with SMTP id
 2adb3069b0e04-5389fc3c405mr3204090e87.21.1727455744305; Fri, 27 Sep 2024
 09:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230616143803.73926-1-kinsey.moore@oarcorp.com>
 <e36a681f-53e2-8379-078e-25e43fc3966e@linaro.org>
 <20230710140948.GJ6984@fralle-msi>
 <LV3PR19MB82782241F7CFA4A66D762D5D90692@LV3PR19MB8278.namprd19.prod.outlook.com>
In-Reply-To: <LV3PR19MB82782241F7CFA4A66D762D5D90692@LV3PR19MB8278.namprd19.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2024 17:48:53 +0100
Message-ID: <CAFEAcA_k3JuPMtT6rAmx7xAqSeTYj_HEup16=2Zr6FA_5dPE4g@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/xlnx: Connect secondary CGEM IRQs
To: Kinsey Moore <kinsey.moore@oarcorp.com>
Cc: Francisco Iglesias <frasse.iglesias@gmail.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "philmd@linaro.org" <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 25 Sept 2024 at 20:34, Kinsey Moore <kinsey.moore@oarcorp.com> wrot=
e:
>
> Hey,
> I just wanted to check on the status of this patch since it's been sittin=
g for a bit now and I noticed it hasn't gone into any branches. Is this wai=
ting on something from me?

No, I'm afraid I just hadn't noticed it to pick it up.
I've applied it to target-arm.next now; sorry about the delay.

(Generally if nothing seems to have happened to a patch
you can 'ping' it on the mailing list after a couple of weeks
to get somebody's attention on it.)

thanks
-- PMM


> Thanks,
> Kinsey
>
> -----Original Message-----
> From: Francisco Iglesias <frasse.iglesias@gmail.com>
> Sent: Monday, July 10, 2023 09:10
> To: peter.maydell@linaro.org
> Cc: Kinsey Moore <kinsey.moore@oarcorp.com>; qemu-devel@nongnu.org; philm=
d@linaro.org
> Subject: Re: [PATCH v2] hw/arm/xlnx: Connect secondary CGEM IRQs
>
>
> +PMM (I think this one might have fallen throught the cracks)
>
> Best regards,
> Francisco Iglesias
>
> On [2023 Jun 18] Sun 00:50:47, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 16/6/23 16:38, Kinsey Moore wrote:
> > > The Cadence GEM peripherals as configured for Zynq MPSoC and Versal
> > > platforms have two priority queues with separate interrupt sources fo=
r
> > > each. If the interrupt source for the second priority queue is not
> > > connected, they work in polling mode only. This change connects the
> > > second interrupt source for platforms where it is available. This pat=
ch
> > > has been tested using the lwIP stack with a Xilinx-supplied driver fr=
om
> > > their embeddedsw repository.
> > >
> > > Signed-off-by: Kinsey Moore <kinsey.moore@oarcorp.com>
> > > ---
> > >   hw/arm/xlnx-versal.c         | 12 +++++++++++-
> > >   hw/arm/xlnx-zynqmp.c         | 11 ++++++++++-
> > >   include/hw/arm/xlnx-versal.h |  1 +
> > >   include/hw/arm/xlnx-zynqmp.h |  1 +
> > >   4 files changed, 23 insertions(+), 2 deletions(-)
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >
> >

