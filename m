Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABB7E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLng1-0004Mm-At; Thu, 12 Dec 2024 13:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLnfw-0004LV-OZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:12:37 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLnfu-0003Zk-4k
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:12:35 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-216401de828so8763915ad.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734027151; x=1734631951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1lwMwykDY1Tdw7nrWT32NtYxImwWpTGpP8knmDCkmmg=;
 b=VXesgLDwNdOkBG6VkIuRPVUM9YJ+sg8e7RNNXz7TSeNPsQNYRT3j9Nr1vc1RJCZZi6
 cKDPJzH2V/wnftHReMZD4dmOpqxRY0NNDzWvfVRTQZVhYJ2Glik841TAbFFa/wQy5Muv
 jogMaUg4gppBYE4tNNS7ui05mm0COvFY7kTYHE0IsiwyjjcvCWWnJs/pFdm3WdTPH8nX
 F6reWWYVry6hLrwiHs51QjtHbDZpH4NCwejeXMepEX5fySLFENRsarVef18xfE1Gm/uE
 a84ZQT9oVKn+gWDW3tkcS29JeAxRxSBxPbYU1IYc8VlkqqqlfE21r6qnSNnwumWrJPHO
 KK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734027151; x=1734631951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1lwMwykDY1Tdw7nrWT32NtYxImwWpTGpP8knmDCkmmg=;
 b=RDWw6pFJjR12O9E7yk487guXFDdZulRDg36NihbrWqquPHhF03Xq/EsQRfn+7MOcpY
 U/wdqoZ0TPypFWAHkQ7te7mZ8itJaYBTx4zoJbiDJEshfI9K0RVye/coGlzT9b6c9ulQ
 +8uqY/FS2+8SecCmu5AMmGPf2CK1IRm2JxaljJS1WYmRS21d/k1r1uhVMdXCPYHfT0BX
 VRofz9eDlTvwBwUvwpZGKcYN3+kA2UmxIhtAdo/hT2/yhYcM5QcapbYeWKMFUH00Fzjt
 tVKVrO+AB/ennLOqtj9UNbt2KJFfBfgvdsV3i1rnTRcEmqa5sQlE4sOE2LqnzcGCGLb7
 8iMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+obPDZOMb/04L0pDYlKU/SS0lGrBxM73atsVQr2HCwAweo4le/U8d9DmhcTjrllAgvFIN9NLfYBWy@nongnu.org
X-Gm-Message-State: AOJu0YzmZRFI9TbuSkupc4dIxKY19C3EaLOleurYhzA/30ZE2FfX0NbN
 tq2osd+rt/l3wNdVTolPNOI0tqhzHUbYe6mkJl1iGaZIwgcZRhs2i6iHqJi/T2I=
X-Gm-Gg: ASbGnctAy2WCbOfkp0HqkcT0prOnhczEjbQv3F84ejBfVIRU3M+aptL/h85YT01I8fn
 ZAzHAC6iD4Js23kfyjPOyvYJ4vzYSxluVeiHXGr/ZD9XWVhp/8Eyd0NOCsewO6rGaxocaL5uRvR
 qUCZZxMz40byh4bOXobW3zCJ/7mCnAXSqNRQu/17QHbU4hRh0mcX8mI5GG2PZypXqqtWtoHXpCj
 cOJZuxr0+zjvoVOy2Yk7otDero+XCUs42m4yKITrxDjddSOYy1qcYtFu5sAuAAlM5kuWJJszA==
X-Google-Smtp-Source: AGHT+IEZcRsK4rxunv3XsoZWTygWEUIuGKif2GawRfGtuigRWJOv9RGlKrwTQ2cl9TNHve+4gP8W1A==
X-Received: by 2002:a17:902:f54e:b0:216:53fa:634f with SMTP id
 d9443c01a7336-21778562039mr125516155ad.48.1734027151117; 
 Thu, 12 Dec 2024 10:12:31 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2162e21321asm92376835ad.279.2024.12.12.10.12.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 10:12:30 -0800 (PST)
Message-ID: <bcc5e5a2-91d4-45b3-9f67-d6b49833a3ef@linaro.org>
Date: Thu, 12 Dec 2024 12:12:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 02/20] arm/cpu: Add sysreg definitions in
 cpu-sysregs.h
To: eric.auger@redhat.com, Cornelia Huck <cohuck@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, alex.bennee@linaro.org,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20241206112213.88394-1-cohuck@redhat.com>
 <20241206112213.88394-3-cohuck@redhat.com>
 <2a83a49b-6863-4fb8-b5de-c3eacf3cdb77@linaro.org>
 <12a2ef7c-0ba3-49d9-9e08-733b8ca6a753@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <12a2ef7c-0ba3-49d9-9e08-733b8ca6a753@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 12/12/24 11:46, Eric Auger wrote:
>> Do we really need anything beyond the defined registers, or even the
>> defined registers for which qemu knows how to do anything?
> what do you mean by "defined registers". The end goal is to be able to
> tune any id reg that the kernel allows to write. So I guess we shall
> encompass more regs than qemu currently handles.

Defined registers as in "have an architected definition".

E.g. there's no need to set any fields in (op0=0 op1=0 crn=0, crm=0, op2=1), because that 
isn't a defined system register.  It's in id register space sure, and almost certainly 
RAZ, but there's no call to either set it or represent it within qemu.

Because you're working to a a symbolic command-line interface, with FEAT_FOO, ID_REG.FIELD 
names, qemu will (be extended to) handle every register named.

> Wrt op1={1,3}, tbh I initially sticked to the KVM API. Now looking at
> D22-2, effectively we have very few ID regs there. If we were to use a
> hashtable we may be more flexible in picking up the indexes that are
> relevant for us.

Yes.  And I'm suggesting the "hashtable" be defined by compile-time constants.

>> const uint32_t id_register_sysreg[NUM_ID_IDX] = {
>>      [ID_AA64ISAR0_IDX] = SYS_ID_AA64PFR0_EL1,
>>      etc
>> };
>>
>> struct ARMISARegisters {
>>      uint64_t id[NUM_ID_IDX];
>> };
>>
>> This seems trivial to automate, and wastes no space.
> 
> Sure we will study such rework. As long as the key (ID_AA64ISAR0_IDX)
> can be matched against the index used by the KVM API we should be fine.

I haven't looked to see what KVM_ARM_GET_REG_WRITABLE_MASKS really returns, but I see no 
reason that it should not be trivial to map back and forth between the spaces.


r~

