Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5479210F6FBF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 16:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7yPF-000611-Df; Wed, 01 Apr 2026 12:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w7yP4-0005qr-54
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 12:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w7yP0-0001dD-Sr
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 12:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775060804;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GAz5A7cp5pKEE8nNDIOv9L2ev/0rJIZvnCDoEdkysXk=;
 b=bwfV8Kw/AIn3Ij+gtX0SFGyOvpsMkghPXT2m0brVA2QRrHqWe4nsjRmh2Busmwu6NIVhSE
 ie80qRPL6IscRXoFx8Iy2002nxYwxSwPyv7sG9K9KsNP0f5OUf7UT5XGh6B7itkC5qND5B
 mu7iQ3DjEWC/iyU7BY8+hPv52s6h9Ro=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-D0QFSDKAMAyIpBxC9kzdIA-1; Wed, 01 Apr 2026 12:26:42 -0400
X-MC-Unique: D0QFSDKAMAyIpBxC9kzdIA-1
X-Mimecast-MFC-AGG-ID: D0QFSDKAMAyIpBxC9kzdIA_1775060802
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4853466655dso51146655e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 09:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775060801; x=1775665601;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAz5A7cp5pKEE8nNDIOv9L2ev/0rJIZvnCDoEdkysXk=;
 b=gT/7YLkHr1NmO6VWGoYnTW/zbRTEgapLNMhYobECOlVC7Aa57XynXagGq1vo270fyn
 OLRt3T23sTlqIv5Mx7ZHGx/JT8E2jmBIWZtvUPeolRf4FddhrJwuywmmpnh+sPjZ+Ctv
 CNnbAPVsP9aKDPTgtkw+m3azJPsPZgRslRtUyI++o5BzkBhLy6T9MFErTJgmZWNH4E3/
 R/CUEvEnmKlgZYCrtRwTjykBXB/CPvR2csVO6HVnNXobgiIdxzs8F5d94vFTcK2lXY3R
 KEn8fZV1TVAWzM2bHrZRADg8QYkHegDCclIkR44/EoabpL2T6ihjUoXE1teeYbg6cqAI
 QpiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7T0uSHeCDZ39SbHEHg6+jYOaEVtIc7uF+qddX0pxgVWts0yxkMj5ufmnGP8XEocAIt33Z0FNRJD9J@nongnu.org
X-Gm-Message-State: AOJu0YzyWkFSFRXzlRYYGmjqRe1Mzm8sB90jGYjadd6wnxKXjJuOmm6F
 fDQamY2VqakX5NLEuiaQR1xfian9NjX/eqMOjHYzL0Sbjc3skegsFq60Ym9SbyI1SZZT/eWmUhO
 LTQ6syieBTvchHEELkBr4Lz87gxx5bEm8P4YyZ2H3nWRtRZsECoi/hbyn
X-Gm-Gg: ATEYQzzl0cNdDMm8YtAHSnbvZCCIX+qh07JjncrdeNsPhY0DR/xTXWLFxwpEqmmkVHF
 XA7f4k2q/DT9FdGAAlcMa4OLRSnaVbhwWiFaY9sTZ4QPYI3ij90jE5Biy5ubWi1TNPTR/VtP7Pw
 m29SYLNTp+9MaACRp0OM6GmWzdgqalAyo9/TFdlzSuFAW/Ij5VY7sBq3372GSa3zYO/Pwssipxw
 DTZN4jSmuEQLWRE+n1eSrlZaZF8Mz+Y3V3Cry5CM9KJuiJxVAZ5dncK2r22aB8ikIBpj4sPXdLB
 3wMxZnXW+wF/IhlMTWS/iuH9GlnB9dk4qVhftHLGIMkhg2abNgs3xqr8/xetwYr64/dPjiIdezj
 Xg83opkGlmUbdsXlSHGVpRGuy6v8+x/TTiy18qTPJ6r3MfkGMmVKyS17H0nJTpICx8HXmFA==
X-Received: by 2002:a05:600c:858e:b0:487:467:4276 with SMTP id
 5b1f17b1804b1-488835cd391mr56911245e9.30.1775060801407; 
 Wed, 01 Apr 2026 09:26:41 -0700 (PDT)
X-Received: by 2002:a05:600c:858e:b0:487:467:4276 with SMTP id
 5b1f17b1804b1-488835cd391mr56910785e9.30.1775060800868; 
 Wed, 01 Apr 2026 09:26:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8b12aesm42579935e9.22.2026.04.01.09.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 09:26:39 -0700 (PDT)
Message-ID: <b5315132-bedb-499a-9cf6-83132e8559a3@redhat.com>
Date: Wed, 1 Apr 2026 18:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm: handle demuxed ID registers
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260204133229.297061-1-cohuck@redhat.com>
 <20260204133229.297061-2-cohuck@redhat.com>
 <8ecca07b-7ff0-4a46-8de3-6a3f21173a00@linaro.org> <87bjg3drhf.fsf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87bjg3drhf.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/1/26 10:17 AM, Cornelia Huck wrote:
> On Thu, Feb 05 2026, Richard Henderson <richard.henderson@linaro.org> wrote:
>
>> On 2/4/26 23:32, Cornelia Huck wrote:
>>> For some registers, we do not have a single ID register, but actually
>>> an array of values (e.g. CCSIDR_EL1, where the actual value is
>>> determined by whatever CSSELR_EL1 points to.) If we want to avoid
>>> using a different way to handle registers like that for every
>>> instance, we should provide some kind of infrastructure. Therefore,
>>> add accessors {GET,SET}_IDREG_DEMUX that are similar to the accessors
>>> we already use for regular ID registers.
>>>
>>> Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
>>> Reviewed-by: Sebastian Ott <sebott@redhat.com>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>   target/arm/cpu-sysregs.h | 13 +++++++++++++
>>>   target/arm/cpu.h         | 20 ++++++++++++++++++++
>>>   2 files changed, 33 insertions(+)
>>>
>>> diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
>>> index 7877a3b06a8e..911f54bc8a4f 100644
>>> --- a/target/arm/cpu-sysregs.h
>>> +++ b/target/arm/cpu-sysregs.h
>>> @@ -35,6 +35,19 @@ typedef enum ARMSysRegs {
>>>   
>>>   #undef DEF
>>>   
>>> +/* ID registers that vary based upon another register */
>>> +typedef enum ARMIDRegisterDemuxIdx {
>>> +    NUM_ID_DEMUX_IDX,
>>> +} ARMIDRegisterDemuxIdx;
>>> +
>>> +/*
>>> + * Number of register variants per demuxed register, trying to accommodate
>>> + * possible use cases.
>>> + * CCSIDR_EL1 currently needs 7*2, could be 7 more with FEAT_MTE2, in which
>>> + * case we would need to bump this number.
>>> + */
>>> +#define ID_DEMUX_ARRAYLEN 16
>>> +
>>>   extern const uint32_t id_register_sysreg[NUM_ID_IDX];
>>>   
>>>   int get_sysreg_idx(ARMSysRegs sysreg);
>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>> index 21fee5e840b7..f9d51c0fc187 100644
>>> --- a/target/arm/cpu.h
>>> +++ b/target/arm/cpu.h
>>> @@ -906,6 +906,25 @@ typedef struct {
>>>           i_->idregs[REG ## _EL1_IDX];                                    \
>>>       })
>>>   
>>> +#define SET_IDREG_DEMUX(ISAR, REG, INDEX, VALUE)                        \
>>> +    ({                                                                  \
>>> +        ARMISARegisters *i_ = (ISAR);                                   \
>>> +        i_->idregs_demux[REG ## _EL1_DEMUX_IDX][INDEX] = VALUE;         \
>>> +    })
>>> +
>>> +#define GET_IDREG_DEMUX(ISAR, REG, INDEX)                               \
>>> +    ({                                                                  \
>>> +        ARMISARegisters *i_ = (ISAR);                                   \
>>> +        i_->idregs_demux[REG ## _EL1_DEMUX_IDX][INDEX];                 \
>>> +    })
>>> +
>>> +#define COPY_IDREG_DEMUX(ISAR, REG, FROM_INDEX, TO_INDEX)               \
>>> +    ({                                                                  \
>>> +        ARMISARegisters *i_ = (ISAR);                                   \
>>> +        i_->idregs_demux[REG ## _EL1_DEMUX_IDX][TO_INDEX] =             \
>>> +            i_->idregs_demux[REG ## _EL1_DEMUX_IDX][FROM_INDEX];        \
>>> +    })
>>> +
>>>   /**
>>>    * ARMCPU:
>>>    * @env: #CPUARMState
>>> @@ -1084,6 +1103,7 @@ struct ArchCPU {
>>>           uint32_t dbgdevid1;
>>>           uint64_t reset_pmcr_el0;
>>>           uint64_t idregs[NUM_ID_IDX];
>>> +        uint64_t idregs_demux[NUM_ID_DEMUX_IDX][ID_DEMUX_ARRAYLEN];
> [Oops, totally overlooked this email! Sorry about that.]
>
>> I'm not keen on this.  Surely we don't expect all multiplexed ID registers to have the 
>> same number of sub-registers?  A rectangular matrix isn't a great representation.  Also, 
>> you're wasting a hole in idregs[] with CSSIDR_EL1_IDX.
>>
>> Why not just have the N sub-registers occupy N entries within the regular idregs[]? 
>> Something like
>>
>> #define DEF_MUX(NAME, OP0, OP1, CRN, CRM, OP2, NUM) \
>>      NAME##_DEMUX_IDX,                               \
>>      NAME##_DEMUX_LAST = NAME##_DEMUX_IDX + NUM - 1,
>>
>> #define SET_IDREG_DEMUX(ISAR, REG, INDEX, VALUE)                        \
>>      ({                                                                  \
>>          ARMISARegisters *i_ = (ISAR);                                   \
>>          i_->idregs_demux[REG ## _EL1_DEMUX_IDX + INDEX] = VALUE;        \
I guess we would use regular i_-> idregs[] here, right? 

Thanks

Eric
>>      })
>>
>> etc.
> Yeah, I was not overly excited about my solution, either. I'll go and
> play with this, thanks.
>
>


