Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10102C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcq3H-00055T-JL; Wed, 21 Feb 2024 12:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcq36-00052H-E5
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:06:26 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcq2x-0004Lo-Tv
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:06:24 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41276a43dc3so5733005e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708535173; x=1709139973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O0X1LzAsy/a4k7R9XKl1hR+bsJvSTIqAqENCSFh3inA=;
 b=eCe+COmUWMyc8/JSDNPtVQD/aXutxu/ZofMqyaTZoHD7HpFJCSjXlD428ygrAAoFl2
 iPMysxUgjTb9h68Ob2ALL0ecxN2zj2POUwq7Grw3JV8EsW69YwiC5zS6lTfDwMdinDa3
 sDrIoVLLeYct3QiiEvHtQhlMeXLf1vecZf4/sQUq6HVrFlGo0gMHZIAQGTJmmAywbqlp
 Zhx/Huu9SuWGFN8/fMEHna/BPI8cdNtQSH9t9jfIjy1IPHd3YocuWyRyOh0aYSSYCFJa
 aXEXIJq/SW09a10OFphT50OxyGUHFSQi0Imm0w0ZQOlN4fH3tB+PBLRXXJztEwxLHpN9
 IlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708535173; x=1709139973;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O0X1LzAsy/a4k7R9XKl1hR+bsJvSTIqAqENCSFh3inA=;
 b=SyF8q6uFgvEejhh4qFQAYJES1o6qY5TAO5ZpKloTAxni4Iy7YjRfnyHEKffxgI4xKu
 7dWHut6gqcmwaN8PJRgSbmR7ZPp63POkm49AA9ewXBkv2HrEhp81F8WRIb9JvmfZNMPd
 vpom+Oyb6HM+LIWzKF3MLr7b+Q/w3foLnzeH3e0qs/DsSEBctSRg7qhogw6urXNSct/D
 lxi+2mAvomnU8PKQZf1rexBk3RdZqjmQ/9ejNyJvCI9QlMSP80JXcRouuX+cUrAxFVL2
 2RiUsdCmQsFKoixKTD4emDfI67yO3OUqGdhO7f575ffZIJ/Pww8knGffgVBeQt7JymYw
 nsBg==
X-Gm-Message-State: AOJu0Yz3T60xcIV7ZPbfBGO4af37ymz4Lem3y/8tz2mMjybr9lP7qNkN
 /FHbMJZzqVmMd6WAcSo22XAa2aGbLjrmRWTRQc7/ixOnfPTOFqi+YtuQFYYFtgY=
X-Google-Smtp-Source: AGHT+IFP56mhiIUMwkwZjqtR6pBAjOpDgZsv5rIVbB/d3+wHjvLDDKsh5vViGR0uSnUDPqNQsjFrQA==
X-Received: by 2002:a05:600c:3b03:b0:412:63c5:2ef9 with SMTP id
 m3-20020a05600c3b0300b0041263c52ef9mr10271923wms.13.1708535173208; 
 Wed, 21 Feb 2024 09:06:13 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c45c700b0041279707ffbsm1092361wmo.15.2024.02.21.09.06.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 09:06:12 -0800 (PST)
Message-ID: <b9f8464f-8822-40fe-867a-9c702b80bdd5@linaro.org>
Date: Wed, 21 Feb 2024 18:06:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] hw/core: Add ResetContainer which holds objects
 implementing Resettable
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-7-peter.maydell@linaro.org>
 <55058f62-b59b-43ee-812c-628b8df9745e@linaro.org>
 <CAFEAcA8PuK-EVWCYh16+4FDcPFPhU4qHHp5HzsnPvFhtut+gXA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8PuK-EVWCYh16+4FDcPFPhU4qHHp5HzsnPvFhtut+gXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 21/2/24 17:09, Peter Maydell wrote:
> On Wed, 21 Feb 2024 at 15:34, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 20/2/24 17:06, Peter Maydell wrote:
>>> Implement a ResetContainer.  This is a subclass of Object, and it
>>> implements the Resettable interface.  The container holds a list of
>>> arbitrary other objects which implement Resettable, and when the
>>> container is reset, all the objects it contains are also reset.
>>>
>>> This will allow us to have a 3-phase-reset equivalent of the old
>>> qemu_register_reset() API: we will have a single "simulation reset"
>>> top level ResetContainer, and objects in it are the equivalent of the
>>> old QEMUResetHandler functions.
>>>
>>> The qemu_register_reset() API manages its list of callbacks using a
>>> QTAILQ, but here we use a GPtrArray for our list of Resettable
>>> children: we expect the "remove" operation (which will need to do an
>>> iteration through the list) to be fairly uncommon, and we get simpler
>>> code with fewer memory allocations.
>>>
>>> Since there is currently no listed owner in MAINTAINERS for the
>>> existing reset-related source files, create a new section for
>>> them, and add these new files there also.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    MAINTAINERS                      | 10 +++++
>>>    include/hw/core/resetcontainer.h | 48 ++++++++++++++++++++
>>>    hw/core/resetcontainer.c         | 76 ++++++++++++++++++++++++++++++++
>>>    hw/core/meson.build              |  1 +
>>>    4 files changed, 135 insertions(+)
>>>    create mode 100644 include/hw/core/resetcontainer.h
>>>    create mode 100644 hw/core/resetcontainer.c
>>
>>
>>> +static void resettable_container_child_foreach(Object *obj,
>>> +                                               ResettableChildCallback cb,
>>> +                                               void *opaque, ResetType type)
>>> +{
>>> +    ResettableContainer *rc = RESETTABLE_CONTAINER(obj);
>>> +    unsigned int len = rc->children->len;
>>> +
>>> +    for (unsigned int i = 0; i < len; i++) {
>>
>> Worth a pair of trace events around the callback call.
> 
> Do you think so? What would be the interest in them?
> (The way the resettable handling works this foreach loop
> gets called several times for any particular reset event,
> as well as getting called if anybody calls qemu_unregister_reset():
> so "something is iterating the resettable container children"
> can be for multiple reasons.)

I remember Damien added a bunch resettable* events and I've been
using them to test his series, but also later while refactoring
some devices or QDevifying others, in particular when devices
contain buses.

$ git grep trace_ hw/core/reset*
hw/core/resettable.c:44:    trace_resettable_reset(obj, type);
hw/core/resettable.c:53:    trace_resettable_reset_assert_begin(obj, type);
hw/core/resettable.c:62:    trace_resettable_reset_assert_end(obj);
hw/core/resettable.c:69:    trace_resettable_reset_release_begin(obj, type);
hw/core/resettable.c:76:    trace_resettable_reset_release_end(obj);
hw/core/resettable.c:124:    trace_resettable_phase_enter_begin(obj, 
obj_typename, s->count, type);
hw/core/resettable.c:151:        trace_resettable_phase_enter_exec(obj, 
obj_typename, type,
hw/core/resettable.c:158:    trace_resettable_phase_enter_end(obj, 
obj_typename, s->count);
hw/core/resettable.c:170:    trace_resettable_phase_hold_begin(obj, 
obj_typename, s->count, type);
hw/core/resettable.c:179:        trace_resettable_phase_hold_exec(obj, 
obj_typename, !!rc->phases.hold);
hw/core/resettable.c:181: 
trace_resettable_transitional_function(obj, obj_typename);
hw/core/resettable.c:187:    trace_resettable_phase_hold_end(obj, 
obj_typename, s->count);
hw/core/resettable.c:197:    trace_resettable_phase_exit_begin(obj, 
obj_typename, s->count, type);
hw/core/resettable.c:205:        trace_resettable_phase_exit_exec(obj, 
obj_typename, !!rc->phases.exit);
hw/core/resettable.c:211:    trace_resettable_phase_exit_end(obj, 
obj_typename, s->count);
hw/core/resettable.c:243:    trace_resettable_change_parent(obj, oldp, 
oldp_count, newp, newp_count);

Anyway, can be added later if useful for debugging. Certainly not a
blocker :)

