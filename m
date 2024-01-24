Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE812C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaSw-0002FV-V2; Wed, 24 Jan 2024 05:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaSo-0002F1-3p
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:26:34 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaSm-0005LX-B6
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:26:33 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5100c4aa08cso1493822e87.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 02:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706091990; x=1706696790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r12sVsqEGH47jYsmakDboBTMdmOFgHzBDlkELkNODOg=;
 b=YeqitDRWft05J588uodqZoCDgk36YEhgQqV12vhsQk5QjPFByp5DVoukyVjcAP5YH1
 VNZNEC40ok4GlhEAQqwXXZSk6UTDPamj5GAmN/OjpOQZxB1wrgZUhJjmsRka5fjP1WDY
 vSpw6X6XVJL/4ykrX8VVekpP26yj3CxCtw5/o4y/bUar+WvYoOWTdrNWiHhiqzdkUfET
 31hCMdEfc2NSkxmrLcsYupcEsn5LjTfMdiyzLdVoHwyVtWVGoTA2sOn9B4cAxU/LyKCR
 H3Op/s2A1Tt5KFlHM+xPx13i7l7EGwKKER+oNbzrRpB6cH7rOljGihMUfnNZW9pmCm75
 r9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706091990; x=1706696790;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r12sVsqEGH47jYsmakDboBTMdmOFgHzBDlkELkNODOg=;
 b=UDYos0PWLe/p3dOiEhRokp+qzrEyM21Q5/FZDrXplb7x3g8HUDS0mTXZuAAOgS49ol
 7uDhPKarveOl9LI21qjbyhdd505solxaRAVnkRFaCPSJytCp1d0iskJju9VOFfeW1lBp
 TlC4dWahZQ9evCDo7LSMZj/Cc/01Eamit83ZAvk5HtnZaD735L2YBTZj9D68NrbiWQu+
 MKIzteePd66/D+zSVGLrhr8uKBBpZ6GZ0GgqWXXra8861ogw8rdO6DGTfz/9EmNrhgAX
 Ijwrw2+iRHSMcYbr5sqP0nUAgZAufep4VdE0sjF4O33n9ZUEK+JI21xBqCG3maHhTdMF
 9CTg==
X-Gm-Message-State: AOJu0YxgRAOpW28v6jpkg6HjWZvgsXTtfMMR8I2EhFShjl2IVxsjUx1C
 AgIonKoaL6bdDB9XnUEdSSC09cWuiaVQFVqupnVM9JDjUUumWa7Z59qH/E3gQio=
X-Google-Smtp-Source: AGHT+IEjeNUmzmGamlaj7vUzgxS/4wluQUEupAQWjjulzxOWkab5zl0jRVzhznhDAKpM8er7tdhoZw==
X-Received: by 2002:ac2:518c:0:b0:510:a0b:52e3 with SMTP id
 u12-20020ac2518c000000b005100a0b52e3mr1051093lfi.68.1706091990205; 
 Wed, 24 Jan 2024 02:26:30 -0800 (PST)
Received: from [192.168.69.100] (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 c13-20020a170906170d00b00a2c047c6847sm15263070eje.113.2024.01.24.02.26.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 02:26:29 -0800 (PST)
Message-ID: <8c0501b8-6ce9-46f2-afb5-70b053f42c1e@linaro.org>
Date: Wed, 24 Jan 2024 11:26:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] hw/scsi/virtio-scsi: Use RCU_READ macro
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C_=C3=A9_dric_Le_Goater?= <clg@redhat.com>
References: <20240124074201.8239-1-philmd@linaro.org>
 <20240124074201.8239-5-philmd@linaro.org> <7re0d.o8r1pancklv@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7re0d.o8r1pancklv@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 24/1/24 10:17, Manos Pitsidianakis wrote:
> On Wed, 24 Jan 2024 09:41, Philippe Mathieu-Daudé <philmd@linaro.org> 
> wrote:
>> Replace the manual rcu_read_(un)lock calls by the
>> WITH_RCU_READ_LOCK_GUARD macro (See commit ef46ae67ba
>> "docs/style: call out the use of GUARD macros").
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/scsi/virtio-scsi.c | 12 ++++++------
>> 1 file changed, 6 insertions(+), 6 deletions(-)

> Unrelated to your patch: I just noticed in hw/scsi/virtio-scsi.c, 
> s->resetting is used to flag whether the bus is resetting; but there's 
> no check if a resetting is taking place before starting another. Is this 
> single threaded code so it's not necessary?

No clue about this device, I'll let the maintainers answer you :)

