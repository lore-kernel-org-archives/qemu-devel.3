Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481D3C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 23:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzMiT-00085n-M3; Wed, 26 Aug 2026 19:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzMiS-00085f-SY
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 19:07:32 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzMiR-0003d0-5F
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 19:07:32 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-84f3ab8750cso65154b3a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787785649; x=1788390449; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cpieJqg89kPTDCPQKhdxmTG8CbHjKKqiSU9WUvk5RFs=;
 b=iQoJo2x/rpAwPEWxwtowhkbRBalKg7OBknopnG5N8Q77YtiZuL4tAj2kgIz7qrBck6
 6c7cDZ6F9bNiBizVHrNyUVhm3AclHVPsHteC2bVHFZeB3ZoZ2cbSl4hahrfG+Re3kUFM
 HX4klE6BgTqaIw2I+4ebKu95RYksW7atzQYuhy2IG7ymu/uECX2hWGDkAdTvcqlHAEIw
 MUp6MitJs+aEowUq12Ie7Cuq5vg+XVwYkDrsj27LvSzDMp/gZHCaq8AomHu7fK4PPRxU
 2hhEOr2JX6fhepCPAFevQzbfrgauPeGMC1K/r26RKESj3GDUydvRsp1/GloRySuWKoFT
 E67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787785649; x=1788390449;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cpieJqg89kPTDCPQKhdxmTG8CbHjKKqiSU9WUvk5RFs=;
 b=qqerbb9jZHSaLm/iDJYjNRI2NjDxVz3dnSKx/75KrFK/XmyJaAvsmomUMhcuiyhSUC
 15T2fCli9EEnCryRb6t+Hq4rGfIz5bYgsCETvSOJJ8Prd02IiGaWy4q2Bt16Rrb165wq
 rI52Lo55824/JBroW9shRICv/Ea4hxYfP07fXblPNSZ+r9o6bs0Dq7Dc5NQtmDdJqlG9
 p+Cs661M2v677KAGbqfgyXGEB3rSTK0y/hjmLwj2ye4alFIVTBXkrMH06b6nvVc+NPK6
 9xGw2WcGBNPdfA3YN5BDETVGRBVKU77rK0x+wMJH9RKug65mDaoJ2rtMCZTA+RAyqdsH
 MJtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8x7XIwm8H9hCs/sMGBWyOMqEEmUqNK1aIx4MhWjaxNeZhEO3gMjxqCqVWk7QM5fgS7Ol1QO8OUNcv@nongnu.org
X-Gm-Message-State: AFuF++ljzJ4toB4TWYDWmYEj2nCie8CACb2XMaqeExHt628FqeDcNvuM
 df10zyn/sR5G+n0Lhaf55ptL/DDhgN1Kn1AUfpR3cOlE0XBMKaaXPXtOyaKPUfpZEII=
X-Gm-Gg: AR+sD10p5gWUp8luHQPLElHg0w81S9DiaRVt9P7uu9Gk453UEegj3ybro/eQPB4/5+L
 PeS6iUgDzMNexFraOR2DpfZP53LdF6fQ+//mUj9D0SIuPdEJgApt1JkrdtoXu3H0tSO9z8wSRmz
 QCw7ktLJyDS1WNUYYKfmTBmLVKeeu1gVKGLSPNflLW8b7vgXDzrZXPQQPwxaXqJrH5lSmc76GZ7
 XTC/i0tjgS69dAVi8Ft2vevv5o9Ujt//pCdLo23x4DumwLePtVT7BDDckH24M139uWTxuSmD6Zk
 QOW0T8wkSrjEdbGBiFqq6NV2HXo0AkQ5YdmYSj+OtYcKj6kDVEid2MmJWesMWwfHEy9HHIy47pF
 +TGS8W5yjZIqI82FTXNsIw/zIdTYlLQ5hF5CfTJjPcGiKQcmzCW0kx1I5OJwzFdAKxCUrvh7mjM
 ziMyiShIrLR0lkKwNMmBzgZh2aNMnKwgD+QoO6ztLM8Kgvj1JWQor88vV9QmuPmK17qGZTTl5HM
 GM77wxgnXb76UHZGvGerCw/Yf1t
X-Received: by 2002:a05:6a00:92a7:b0:845:363e:12d9 with SMTP id
 d2e1a72fcca58-85372ea2e70mr16609513b3a.3.1787785648934; 
 Wed, 26 Aug 2026 16:07:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535acbbb6bsm1440013b3a.24.2026.08.26.16.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 16:07:28 -0700 (PDT)
Message-ID: <9292ce2a-6493-41f9-85a0-b6d90f1fdab0@linaro.org>
Date: Wed, 26 Aug 2026 16:07:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <a9c89dd7-6317-42f1-9e03-30e48c2d08aa@oss.qualcomm.com>
 <anRgKw58IMYoR4p-@redhat.com>
 <5bda3566-5ce5-46dc-a281-2cc07a56dc6f@oss.qualcomm.com>
 <077fc585-a6b8-455a-abdc-fd72e13b8315@oss.qualcomm.com>
 <anTPOqFKWFKAX_3C@redhat.com>
 <102a3de8-ac17-429a-9294-e3b159aa642a@oss.qualcomm.com>
 <anxQdlwxAtqfl-N-@redhat.com>
 <cc88ff07-474f-48d6-a2a4-1a2c3f64f3fd@oss.qualcomm.com>
 <anxvMQpZlBUu5SaB@redhat.com>
 <9db3cc07-61e6-4740-823d-112ec80f216b@oss.qualcomm.com>
 <anyCswBYBZWeMt3I@redhat.com>
 <e40e5a75-cb20-4608-b628-f363068a36ba@oss.qualcomm.com>
 <b0930315-f3b6-4fcd-82ca-11028856c343@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <b0930315-f3b6-4fcd-82ca-11028856c343@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 8/21/26 16:53, Pierrick Bouvier wrote:
>>>>>>>> Based on this, I'm much more in favor or 1. The fact availability
>>>>>>>> information is in the same location than type definition is the biggest
>>>>>>>> advantage for me.
>>>>>>>>
>>>>>>>> On example given above, this would give something like this:
>>>>>>>> static const TypeInfo emulated_card_info = {
>>>>>>>>       .name          = TYPE_EMULATED_CCID,
>>>>>>>>       .parent        = TYPE_CCID_CARD,
>>>>>>>>       .instance_size = sizeof(EmulatedState),
>>>>>>>>       .class_init    = emulated_class_initfn,
>>>>>>>>       .is_available  = target_config_X,
>>>>>>>> };
>>>>>>>>
>>>>>>>> Would that work for you?
>>>>>>>> Do you have a 3rd way to offer to solve the problem we have?
>>>>>>> In the case of user creatable objects, we represented a classes'
>>>>>>> conditional availablity in QAPI schema. For example:
>>>>>>>
>>>>>>>    { 'struct': 'InputLinuxProperties',
>>>>>>>      'data': { 'evdev': 'str',
>>>>>>>                '*grab_all': 'bool',
>>>>>>>                '*repeat': 'bool',
>>>>>>>                '*grab-toggle': 'GrabToggleKeys' },
>>>>>>>      'if': 'CONFIG_LINUX' }
>>>>>>>
>>>>>>> Now this isn't quite a match for what we want, as QAPI schema is
>>>>>>> common to all targets and used to control the code generator to
>>>>>>> turn off output. Thus the permitted CONFIG_xxx are only those in
>>>>>>> config-host.mak, not any from $TARGET-softmmu-config-devices.mak
>>>>>>>
>>>>>>> The other scenario in QAPI is the concept of features:
>>>>>>>
>>>>>>> { 'struct': 'SevCommonProperties',
>>>>>>>    'data': { '*sev-device': 'str',
>>>>>>>              '*cbitpos': 'uint32',
>>>>>>>              'reduced-phys-bits': 'uint32',
>>>>>>>              '*kernel-hashes': 'bool' },
>>>>>>>    'features': ['confidential-guest-reset']}
>>>>>>>
>>>>>>> where again we just have a list of named strings. Features are fully
>>>>>>> dynamic, and crucially they are introspectable so applications can
>>>>>>> query at runtime what is available.
>>>>>>>
>>>>>>> The introspection concept is something that is highly likely to be
>>>>>>> relevant to our use cases here. If we have a single binary with all
>>>>>>> types, it would be very valuable to be able to query it once to
>>>>>>> discover everything in one go, instead of havnig to query it over
>>>>>>> and over again for each target. That implies the application doing
>>>>>>> the query needs to be told about per-target usage restrictions on
>>>>>>> types it is querying.

Having read through Pierrick's v2, I'm not a fan of inventing a new 
enumeration, creating a switch, calling exactly the functions we could 
have registered directly.

I think the misunderstanding here, Dan, is that the filter is for the 
non-heterogeneous '-target foo' case.  In the target-foo case, the 
introspection is not highly likely, because we don't have it now.  The 
only point is to have, at the end of registration, exactly the same set 
of classes as we have now.

The introspection case is perhaps probable in the heterogeneous case, 
where the filtering will not apply.  In the heterogeneous case we just 
register *everything* and let the magic runtime defined machine pick and 
choose.  Thus incorporating the filter into the introspection is 
pointless.  That said, I *suspect* there will be very little in the way 
of introspection at all -- I suspect that users will simply create their 
machine description, attempt to instantiate, and error out if there are 
missing classes.

Can we please just have a plain callback?


r~


