Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0613FCCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 17:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQh6-0001u4-2j; Mon, 27 Oct 2025 13:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDQh4-0001tI-5Y
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 13:07:42 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDQgt-0002hb-Nx
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 13:07:40 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-63e255e9a20so5282664d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761584846; x=1762189646; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9a3+v5SSQm9CFNXUiTCelKARraMR9+J5h+medQHzgkI=;
 b=ew89DRQTbAZ2bt42btZ9ncMMfm7c3OGV/7kzc59vOWvdxDBD5MOZ/5gm9iMxkduZCG
 7wiqi6tmfjBhGk8L0zaaPSSfwjSmChBp/y1A/Si9Ou8olHR6IaFmTc0IpxnKn4KkGJMY
 HGiY0ObtcjQywxWEhDoeZEt4oDKdLP4bFayMUSzzu9JtXelDBJmj59eFGZ9jauslU/VP
 Hf9o43Ix6hIkaRnvMokjJLm7hOjQ6y0c3VuZlc/y9LygayFo7uI0+8A5Rv5LVS/+GCGd
 9UqZT8YEcVtGslHphueNNXoGcs77G0aPNWMeU4NMd/eYDNQMC6MKgSMF1mqei930tYnL
 9V0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761584846; x=1762189646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9a3+v5SSQm9CFNXUiTCelKARraMR9+J5h+medQHzgkI=;
 b=r4UN4iigysw3Lx1h7RKAHmKs4uvECU+p/BqVCElkAquO2FelDKeG3doDt6zrAMBPXx
 XzsiVLKLDN1KwDLk/dOEL+Als+W1iD5T3QKwqBQbK6Qq5Fdk8RuRhdQik0m5K/swcXoz
 NVd/8afo1ZHBrb9BLCbr8Vb+Gd0AEVuZXOJ8ADIqsFww8fq/jmfXj6peaKV9nvN5vqVU
 f5J79obaN5cinUeKZzmsutZMflp4hiTg/XWo98HW+uWPF4eH/7i+UfMsKn2E62EJNqkG
 WmSv7VzWqXszAcqW/J1WyBtR4b5ZjCIGKd6xzeeUf0Fly0C6KiXplyPWJbysvu78Mbrn
 S7jQ==
X-Gm-Message-State: AOJu0Yxe9QLDOjfigF9DMWgnVZR/oBZE3NOoeEZ+LkW1L1z1mHasUasR
 R2x5Kaua75Dk33xFy9lBDQBLo7fMWrXG16wU8bSyCCzKAGoMFy/QqxvBhFs8MB/mZ+FTP3eJRF6
 HpC+H9YUWBCEJqPjYv0qDsM863nHzxnShGsXoyLlFd6veiy/vAL4y
X-Gm-Gg: ASbGnct4ymQl85/cosYEp2ZDAowBzqjANyDlBLukqmw8TR2kO5T2syWP2LL0oFy1aJu
 m6VLzxNFqfHdmlGjgud3Jm9eyl2x9kDw046KqkebRVPWNLaGHFoPL0oAQ0ZxyW9z0uDcFpHzJPP
 yPv3307lUWeZd8ba8Xm59d5jH8czaaKVVD6DN3WiVSjOhlnriWBfASnFXrwtBQF2gw99XJaksOR
 WGmVFFOq7hBoasGOjeJa/HFpED+MuKNDZTsHlcEpxvzrCcyEBOdReB+XBLzbg==
X-Google-Smtp-Source: AGHT+IGaTaPWC/WOrfEqNVYhpfV9r0OjkR1NtUO5NaJbkPQpnMmVRGjIDGUpgnQjORUQZ+ZZt7Q98zHS0ED+M4U4bI0=
X-Received: by 2002:a05:690e:2c7:b0:63e:1031:9a2b with SMTP id
 956f58d0204a3-63f6ba40150mr496652d50.40.1761584844928; Mon, 27 Oct 2025
 10:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250920140124.63046-1-mohamed@unpredictable.fr>
 <20250920140124.63046-4-mohamed@unpredictable.fr>
 <CAFEAcA-398ZMeLUbHWyUw4np81mLikEn2PkQnFQMY4oY_iWRFA@mail.gmail.com>
 <29E39B1C-40D3-4BBA-8B0B-C39594BA9B29@unpredictable.fr>
 <CAFEAcA93e6GL9agaCBZ2AabB21JrS6KS6MsbRHGPwdc_vj7xDQ@mail.gmail.com>
 <890B1091-0ADB-459F-B1C9-173EC32DDADA@unpredictable.fr>
In-Reply-To: <890B1091-0ADB-459F-B1C9-173EC32DDADA@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 17:07:13 +0000
X-Gm-Features: AWmQ_bkJ5wc1isPc1iZpVsJRHdyiMm-ivEfqxZwcgJGUfHx4zKryr8V0lPngkKg
Message-ID: <CAFEAcA85m9FPGfm_tqfM6zsLC2C2+0fi+VWSBk-bojtaP_LYTA@mail.gmail.com>
Subject: Re: [PATCH v6 03/23] hw/arm: virt: add GICv2m for the case when ITS
 is not available
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Phil Dennis-Jordan <phil@philjordan.eu>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 Igor Mammedov <imammedo@redhat.com>, 
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Alexander Graf <agraf@csgraf.de>, Sunil Muthuswamy <sunilmut@microsoft.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Mon, 27 Oct 2025 at 16:53, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
> > On 27. Oct 2025, at 17:03, Peter Maydell <peter.maydell@linaro.org> wrote:
> > I guess that would be an argument for the "give the property
> > the right name so we can say "msi=(off,its,gicv2m,auto)". Then
> > you could say
> > -accel tcg -machine gic-version=3,msi=gicv2m
> >
> > to test that setup.
>
> Is there guidance around renaming properties?

I'm not sure if there is. So the below is just my
initial suggestion.

> Would it be proper to do:
> - if its=auto, consider the new msi property
> - otherwise, use the its property

I think we should write the code in a way that looks ahead
to marking the its property as deprecated and eventually
removing it. So the handling for the new "msi" property
should be done in a way that doesn't need changes if/when we
drop the "its" property.

We don't currently attempt to detect oddball user
commandlines like "-M virt,its=on,its=off", so I don't
think we need to go to any particular effort to diagnose
the equivalently odd "-M virt,its=on,msi=off" etc.

We can implement the two options as essentially
independent, where "its=on" is equivalent to "msi=auto"
and "its=off" is equivalent to "msi=off" (i.e. what
we currently have as a bool turns into an enum, and the
set/get functions for "its" and "msi" both operate on
the same underlying struct field.)

thanks
-- PMM

