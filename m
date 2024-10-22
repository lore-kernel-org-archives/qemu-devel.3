Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F85CDD0FB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 21:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3MfR-0003DJ-Vw; Tue, 22 Oct 2024 17:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t3MfP-0003D6-Sa
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:43:52 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t3MfO-0007SP-56
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:43:51 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e2ed2230d8so4567337a91.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 14:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729633428; x=1730238228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gaWiwYZzM+BMPGemUJNfcnHcAG6OLblZCKP/lgCXBdA=;
 b=mbzY6TD7eqBugFQ0caUUdidA/sfNVNHlVYq8wJAAZ/D2H9AM4FxRHT2K5Qy+IpHl5/
 SxvJ1iarG1qdf3iWJ+/0cD7DJbAmxSICcTuqWe7lNYzIO5by5SXWAAjsuczDJ2eJO8bg
 wCoVr7WBa9HMEqq2QFZ5tE9Zwu2N6sR0pc31ELqt8Wj2sH7FIQO3qubMOC7y+klENA2p
 7btivnzczXsCg+WzSNBMf5pr/TXuvi7u12RmAr71r/5YXDCO8iXzuxskeaAL8qHesnfr
 xhp5jXVCIrgTiEZM/FhJ40DCoYC2GU27nXjsW1L5HRE9fHyYEcSH2N4LGypjU3jWR+ll
 x4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729633428; x=1730238228;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gaWiwYZzM+BMPGemUJNfcnHcAG6OLblZCKP/lgCXBdA=;
 b=b54z4OE/x6gfXT/8ieWutFUkZ3bMEsiZVwtfFdl7R3MMVuGgfwAftmY6k7iq6evp5L
 h4pOi98Hs/Q7KC+WbQTn3zPn3uQXuXZzJguVtl38UO7YXygFoEYCuTmzZJsrU4ZAaJw2
 /RpHf2I9P39jLVBFdfx3X4na1wzNPr7fkLSMf0Bg9HE8IZzxxrBKA555sM8I+JyIwAqR
 ac8WFfs0+YGhAPyYypceK2zRZAe3/BJGZvSNnMP/CSx7e9xwWRFGrFwGB7szrgFl+Trn
 8q4NR7iwTf1jbUARrOtRUKU4HM7duiUfSGvpI6m2EOyEpsVBvSaZq4iFhS47+h2CugLM
 mktA==
X-Gm-Message-State: AOJu0YxGDF/Q0gdO/ZMr4yG8b4xwpdPRJAPkFLu7zMTY0phpwQjahmgY
 1hWT4hGujPupI7SiHLb85Y5KcUIMoo+N6YFUluodPw+jEhJryapdxOIxo8tlAdg=
X-Google-Smtp-Source: AGHT+IHREMp0Q0cEVbNtLkdE+szChAE3iRhgRnXnSNrtzzRZ//Gpxq+fcA02bLZr2tP4j2rPxEpFBg==
X-Received: by 2002:a17:90b:30c3:b0:2e2:bd32:f60 with SMTP id
 98e67ed59e1d1-2e76b6e14f0mr444399a91.32.1729633428554; 
 Tue, 22 Oct 2024 14:43:48 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0f368asm46884575ad.268.2024.10.22.14.43.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 14:43:48 -0700 (PDT)
Message-ID: <ab4af84d-a518-406b-8dbb-513d41aa4d61@linaro.org>
Date: Tue, 22 Oct 2024 18:43:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] qdev: make properties array "const"
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-11-pbonzini@redhat.com>
 <12b03ebb-6bc2-4ffe-99cc-4818b5d992ee@linaro.org>
 <CABgObfawNPijVE7FqdGpnpAZ2JM9puY6=PSivFR4GgbHTKE2Fg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfawNPijVE7FqdGpnpAZ2JM9puY6=PSivFR4GgbHTKE2Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1033.google.com
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

On 22/10/24 02:23, Paolo Bonzini wrote:
> On Tue, Oct 22, 2024 at 6:31 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>> -void qdev_property_add_static(DeviceState *dev, Property *prop)
>>> +void qdev_property_add_static(DeviceState *dev, const Property *prop)
>>>    {
>>>        Object *obj = OBJECT(dev);
>>>        ObjectProperty *op;
>>> @@ -980,7 +980,7 @@ void qdev_property_add_static(DeviceState *dev, Property *prop)
>>>                                 field_prop_getter(prop->info),
>>>                                 field_prop_setter(prop->info),
>>>                                 prop->info->release,
>>> -                             prop);
>>> +                             (Property *)prop);
>>
>> I like the overall patch idea, but I'm not keen on casting
>> const to non-const. Should we adapt the callee -- here
>> object_property_add() -- to also take a const argument?
> 
> This argument goes into prop->opaque and is passed to all
> accessor/resolver/finalizers functions. So it would be a much larger
> change because it needs to change all those functions from "void
> *opaque" to "const void *opaque".
> 
> It would also be an issue because some finalizers write to the opaque
> for good reason:
> 
> static void object_finalize_child_property(
>      Object *obj, const char *name, void *opaque)
> {
>      Object *child = opaque;
> 
>      if (child->class->unparent) {
>          (child->class->unparent)(child);
>      }
>      child->parent = NULL; // <--- here
>      object_unref(child);
> }
> 
> So, it's not great but it seems necessary. At least keeping the const
> within qdev properties makes things "safer" within that realm.

Since it is only within qdev-properties.c, it is indeed reasonable to
accept. Maybe make it explicit via a well-named macro to do the cast?

   /* NON_CONST_PROP: Specific macro to this file because ... */
   #define NON_CONST_PROP(prop) (Property *)(prop)

Regards,

Phil.

