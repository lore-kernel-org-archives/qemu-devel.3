Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6737C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxeT-00077C-R0; Tue, 11 Mar 2025 07:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1trxeR-00076l-AU
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:19:59 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1trxeM-0003do-Ks
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:19:59 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2241053582dso3284485ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 04:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1741691987; x=1742296787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kTDaSn2BJnCTUSUdjCs0GrYLXrKD7PhXl347fUhQTmQ=;
 b=c4F25vauA8Edm95QOWcobdOPRyguXRMknHbWUsh620uHSlLoNaLKiKkVO11ZMwKkJ4
 R/iKxHrlG6AjPLEq3cKYE0pjDHioYd8zJkIS92/NdnLOHsy80D5KrOant5GByW1xuA0I
 cUYSEpn//+ofq/jLQxxDy416jYwVxWscnvyNcoBXMRPWlq+h8x8F63PvoC+cXXAX8xC6
 Pj9MJGpYw4Btb4vAVChOT4IJ7l3EAWGT+9U1cV9pcb8ZjDOmsPcEOVKTXlvZ2c6hcBs+
 xExwnzclsIg/RQrgGQiHx82naZf60R17Prqs/E8GWTODmgQ54CAH4G0RRqXGC1USKs5T
 uyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741691987; x=1742296787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kTDaSn2BJnCTUSUdjCs0GrYLXrKD7PhXl347fUhQTmQ=;
 b=GQlctecisAqVJN3TZGjXA+pqMvlO1u3w4hqYpV4rrF4n7adPNM9agEstGnM0OmOA5e
 8InGMSemwAPoyImkOaZEBe/MdVOaVYodqSM1ahQ/zzKeUzY5Q0JL3oAsotaufYfYivyF
 iddm+hXE6t4tS15g56/fqQVp/LwmloVy5SuJ9uVee8tSS0+ALCVzbE8XZFHs4iRCSpSX
 GauZGmQEfS0bNEM6m6j5W4pohm9pVhfvoAvuAF0aQKLMhARoy7fMlyOoTN0d7JAFBlDO
 z9/GvrGiX6r678dThmfwL43s5qV6KwxMld17RZzJDuZMbbBPSU1Pi9IH5KlUDMxzyAVs
 s8oA==
X-Gm-Message-State: AOJu0YwU7HbpTFSK7ExzNXIGKEYKWPFqdz1iCuHkmlXBC1IXiZRu5tCH
 G7UL4yBKc78+h/ifKKOhZnmigC8Pt4OBzlMmbiVK10AJOFvFVPXf/IDODrpKPWCkTqqqH/+PwG5
 +
X-Gm-Gg: ASbGncvPNYLO3ow28GYDF90v5fbJ6cJF77obJjfUngQVSGGTV135hnWg2o8P0ts4Tju
 Nkwp44WNH5fCi92Rus6z6Q3GpxOUtrP3gYUuTnyQel3ikN4e8efHlX9DYx6kDGigkqpm5Yb5EAd
 +F8YKWMGuhqqRHGz2M8JjLvUwktXf5eheIwJSjFN1XDlaBXeM3b8/PHSl5MdBZDF7g4MjJ9hmB1
 W9RPE2TgeRyUi63R6xD2/eljHtDtxp7qO2jNTsg+NDSYxR13zZAkVwDk81BRhvUoi1GOXNM4GRl
 G6ii6j7sYjHBupRyNIix13ljWlq5f6oeE/l4teXhfdFXM8zq9dg=
X-Google-Smtp-Source: AGHT+IGHyHViJ+r0WI26+ma0eYV1ssUSJO3VM6iiqP2HwWnItfUlEDrwAdvPArY6mRq9MvbHI59Wzw==
X-Received: by 2002:a17:903:40cb:b0:21f:85ee:f2df with SMTP id
 d9443c01a7336-2242888adfemr265256055ad.15.1741691987492; 
 Tue, 11 Mar 2025 04:19:47 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410aa5171sm95322485ad.225.2025.03.11.04.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 04:19:47 -0700 (PDT)
Message-ID: <39c8618a-51fe-47d5-b9ab-b98b6ddeca1e@bytedance.com>
Date: Tue, 11 Mar 2025 19:19:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [RFC] Proposal for a QEMU video subsystem for cameras and
 webcams
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, David Milosevic <david.milosevic@9elements.com>
Cc: qemu-devel@nongnu.org,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>
References: <CAFUY6-d5GZSrDzD0vUEF6P4YnstMjx=G3Q77iFGLt3eBUf5WUA@mail.gmail.com>
 <87senk7rro.fsf@draig.linaro.org>
 <1cd5fa82-50db-418c-bd9e-ce6fda3c6ee4@redhat.com>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <1cd5fa82-50db-418c-bd9e-ce6fda3c6ee4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x634.google.com
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



On 3/11/25 00:57, Thomas Huth wrote:
> On 10/03/2025 17.51, Alex Bennée wrote:
>> David Milosevic <david.milosevic@9elements.com> writes:
>>
>>> Dear QEMU Developers,
>>>
>>> I would like to propose the development of a video subsystem in QEMU, 
>>> with the initial
>>> implementation focusing on UVC video device emulation and support for 
>>> multiple
>>> backends, including V4L2, GStreamer, and libcamera.
>>>
>>> This work is already in progress at 9elements, and we would like to 
>>> upstream it.
>>>
>>> == Motivation
>>>
>>> Currently, USB pass-through is the only way to make video devices 
>>> available to guests, which
>>>
>>>      - excludes non-USB cameras (e.g., MIPI)
>>>      - performs poorly with high-resolution cameras
>>>      - does not work with USB 3.0 video devices (Issue #1613)
>>>
>>> == Proposal
>>>
>>> We aim to introduce a video subsystem in QEMU that allows for the 
>>> implementation of various
>>> video devices, similar to how QEMU handles audio. The first device 
>>> implementation will be
>>> UVC (USB Video Class) device emulation, with support for multiple 
>>> backends. Future extensions
>>> could include virtio-video or other PCI-based video devices.
>>
>> Are you aware of virtio-media? It was an alternative proposal to
>> virtio-video which effectively becomes an encapsulation of v4l to the
>> guest.
> 
> ... but USB video would also be nice, wouldn't it? That could enable 
> guests to use webcams without needing additional virtio drivers for it, 
> I think?
> 

Agree. UVC based hardware emulation does not need additional guest 
driver, and it may help guest kernel driver debug. It's also useful for 
USB video related education.

Virtio based hardware will use the common video/camera framework, this 
is also another good shape: hardware devices emulation -> generic 
framework -> multiple backend driver implement.

