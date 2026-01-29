Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2DED73E84
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 18:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlWPk-0005Dt-Uw; Thu, 29 Jan 2026 13:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vlWPi-0005DH-Je
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 13:06:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vlWPh-0006z4-1t
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 13:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769709998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJKuVhdvR5Ru0pnKjn7wkNwk7UuupCgbeKG3FVMPz1A=;
 b=SFn1pK9F0OpQ3pxarizkEYurOErDKoazOXzAz8/Qq+zQ5Efi4rSoeZI6+oJlYo8pw1wYVG
 jBMVLoy1BCt/qSU5FD9Jloe5+STK+tUbd4eQnxo2VHOUBbn9ONTOVD6c5wqaYsEmBBfFYU
 MuiPVZ+ZiX0R49j+QXQF+8S8hU8ukRQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-om30HgiBM9ueGBlMPHDWsw-1; Thu, 29 Jan 2026 13:06:26 -0500
X-MC-Unique: om30HgiBM9ueGBlMPHDWsw-1
X-Mimecast-MFC-AGG-ID: om30HgiBM9ueGBlMPHDWsw_1769709985
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d4029340aso25679695e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 10:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769709985; x=1770314785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MJKuVhdvR5Ru0pnKjn7wkNwk7UuupCgbeKG3FVMPz1A=;
 b=DIr5pL/UeWQFMcnzHR+t/HpWgMuUmZJN9nYmkGhFM2Wb1QHcpzvOUi0FxGpfH3Qsly
 giSo/tIF7xBbtnDCxiur0BubdPJTOaE2cj4tg2FgdRZok16KfzjkLR11ez565+PDDlPL
 gu/jtL9MHCkhEk/3bAEKYF7wCpGTcZK5cTpj6hpdL21grD/05H8YIlx04WoS5DR4N057
 Y/DWaTj1pU/cWwVObQkfAGAHyGFE8HDLCwTKuWedzX65h+XAfRze3Np4fi0DhaGSvu4f
 HnMjayN3znYKyfF+waBugm0YfJOT3qnVIXFTgL3Cj44mCn3uhfSyKQlaPqjleuS3IeMp
 xDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769709985; x=1770314785;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MJKuVhdvR5Ru0pnKjn7wkNwk7UuupCgbeKG3FVMPz1A=;
 b=g1eZcOQq6VUd/42x4ktkicHyNkOw7dWWoT5etIIVBppzQhPwGSEyDB5G2MCSU60sYl
 Hr4bY6sp3dcXsjfMQhDkAzWysY3j3UqQxAPc0KKK4hru/w7XZF4eCPV52Nr6FpAkJKMt
 OESY0x9tV6iU75UuCQTQytNChkojMSIQ7Oe6irvfcG7/tp0A0g/fjnm2aVOsWTANxiri
 h17uscKUWXPtW/RQAWqF/ySDB+tgx/V+4vl9ZuqLcoZ/nP2qgaE5P4+/cz5UkRfRaNnH
 2aJSiUp6wSU2a62fPappNSsJz9tVE8Qbr1YP5NEdbyh+u9Fd7oBr7FPKaLjtpOtMr3/0
 U9pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYtBVddo0J9/D3fR/MOlTdZGNS4JD+y2gXX6k20heLhxSykOBPRrCwXA0ZF2pSh/98ikeTSce/lOcJ@nongnu.org
X-Gm-Message-State: AOJu0YwDSKWvSf2SMSJXWqgr7HeJWxDzslZ9P31Cj1glgEeRxeKKQNYw
 xOeoDlC6vS580ljrJxZLmy9w/1y1gmZ7TlWdeIzCdIyknzHXAc06rOEXWfqESIS1rrl/WnHJ4YR
 i1tE+eqrc4T4ekUUgOuBvMEXtKmDwVX83beAhGK1AO2t8EDALiUUj3Ce7
X-Gm-Gg: AZuq6aLcwQKR7zNLXdqoHaY6/mbR2R7z+mhNflf5UyVUO7WrHCmPSRxEORZzr3wF4AE
 nyEZMw4xXs6KfRheaiosY71MqeT1Nr5NA25xWNO1rVuv6Luwtg3Qmm3AmEr+WDki3SH7Q82allQ
 denQrdcn3uLEr6GGYlJOSjOfeYQxk3/Gs3qQXFmMOkIcTkw6ma5e0Jnl3MevfzCPwKwFQqYIJ6m
 344DXinnQ8wBeT5p1QX6TKLEfMz3Kb9GNHZwdIZP08g7pHj1Yxtr8Be69KHNw7yoKoH344wTpzt
 cmKbiyNA0uejnigRMa4C+Kdrr+FUiJrAVah9j3Ug2HNPwK0RVr1bEtMSTyg0CytA9TWURZ0mbrv
 V7cz/Dbe6v/Spz/isUPhdO85dXWswJVOnrqv2qVDTLY8ynpxG9lGRv1vvuRmc18l961gYTpOq7Z
 xFy6M83D6BoqMAJQ==
X-Received: by 2002:a05:600c:4f09:b0:477:7991:5d1e with SMTP id
 5b1f17b1804b1-482db4959demr210745e9.25.1769709984641; 
 Thu, 29 Jan 2026 10:06:24 -0800 (PST)
X-Received: by 2002:a05:600c:4f09:b0:477:7991:5d1e with SMTP id
 5b1f17b1804b1-482db4959demr210465e9.25.1769709984242; 
 Thu, 29 Jan 2026 10:06:24 -0800 (PST)
Received: from [192.168.10.81] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-482da8d98b8sm820205e9.1.2026.01.29.10.06.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 10:06:23 -0800 (PST)
Message-ID: <581b1d82-de10-47c5-9034-165b5af62e42@redhat.com>
Date: Thu, 29 Jan 2026 19:06:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] Implement memory_region_new_* functions
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <cover.1769362313.git.balaton@eik.bme.hu>
 <CAFEAcA_jS3hef=dhxZ5s7MReSW4ir+jMUGwu+RjD_JP7ZRrRXQ@mail.gmail.com>
 <0118dc9b-d467-7f6b-92a8-4f42760ecb6c@eik.bme.hu> <aXkXWGho7lnJ-gwX@x1.local>
 <2fa59d39-5634-0b8c-27ee-9e9548a7f92a@eik.bme.hu>
 <562f0e5c-7ae8-4d95-9dd4-674447362ef7@rsg.ci.i.u-tokyo.ac.jp>
 <cfacf068-7663-6c7f-4908-928bb63e803c@eik.bme.hu>
 <CAFEAcA-8-jC-HJix5YFVbmg3sEuhcSMD8gKJxzAiz=GPy0sw9Q@mail.gmail.com>
 <b5721fa1-e613-889a-03de-77c46aa01da4@eik.bme.hu>
 <d83ac948-afb4-4128-9e23-44aa8a8e31c4@rsg.ci.i.u-tokyo.ac.jp>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <d83ac948-afb4-4128-9e23-44aa8a8e31c4@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/29/26 05:41, Akihiko Odaki wrote:
> However, I see another problem in struct embedding; it breaks 
> object_ref(). When embedding, the child object effectively takes the 
> reference to the storage of the parent object, but this reference is not 
> counted, so use-after-free can happen if someone takes a reference to 
> the child object with object_ref(). That is why the wrapper of 
> object_ref() in rust/qom/src/qom.rs needs to be marked unsafe. Memory 
> regions workaround this with memory_region_ref(), but it's not perfect 
> since it relies on object_ref() in the end.

Yes, and in Rust the idea was to have (in addition to Owned<T> which is 
for an allocated object) another smart pointer Child<'a, T>: an embedded 
object that is owned (the parent has a reference and a field of type 
Child releases that reference when the parent is finalized) but cannot 
be cloned.

> For this reason I think object_initialize(), object_initialize_child(), 
> and the like are better to be noted as deprecated in
> include/qom/object.h. Then memory_region_init() can be deprecated 
> referring to them.

This would be huge and I don't think it's feasible.

It also only provides the appearance of safety.  If you have a backwards 
pointer (such as the memory region's owner), you still have either a 
leak or the risk of a use-after-free.

Paolo


