Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EA2109B495
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 04:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7n1y-0002yU-TL; Wed, 01 Apr 2026 00:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w7n1w-0002y1-In
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:18:12 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w7n1v-0002j3-0l
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:18:12 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35d99031e4eso2367332a91.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 21:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775017089; x=1775621889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/RoUwXjFukIuoc6dDavz4pMRz48JYzz6p6kKEpDwkZ0=;
 b=g1tLFzZHFr2OyLeSyWxVG2jG4pwAE5nwd7c2hKBh4OYSDAMrW0UI1SmKmMk27zqU1y
 F+pHLeyuUuoXgHTHBrbKdM6FA/q6gKgY9aJdejRX+9d4LpwpqAIOflwrfrVY0MqZEdCw
 HasajWiGwWYwH29MVKsR0yC2f+6SQlNUEeeuI1WUlWU+4AnzTmzo9pzCBR7UBTN4KXGG
 7Fp+LZZouUimpJgxU+5N3BV2BNn4q3z+fTSSyaHojbZHs7kTxEQ3x8ets8W4mnvkpC5I
 Q6SKRvmVm6Jutwb5JP9Gc72PBQOVemEHfXv/jodQK4mDC6HRtJmq3TCDemmxJuguFCl8
 5xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775017089; x=1775621889;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/RoUwXjFukIuoc6dDavz4pMRz48JYzz6p6kKEpDwkZ0=;
 b=e0+ceHfqp9fc7QmOtvNzDPHlZ+zraLPItRqPg5HqJdFRYbb8iTiK816SrCLiAbQmgn
 az+h1+rdK0j5tJ4zY4jOxKV8t8cFqUxAv20VurrA2esAbyaDA9IUUSFaHPtEJKtduhO2
 KKWgJHUqxOezRHARQwSXg1eoY90Pc+70cysJWbcZkdx15EbFJNiiaZg8YDt1Nc89LSI3
 8cNDD2bX/Q8kr+2562w3J2d9LRUaalyfMEiDonMYDBfdYuis9WZIXXoCO46kSaIxI/lG
 QW+E3BoZy7zYZKIqZMHmqWp/1Y7HhrGDp1ocxXd6IG4lmQbUBTVHnrY0a5KBbYn9rjlp
 lR3g==
X-Gm-Message-State: AOJu0YwiuU5Bj+N7g7cSfXVhP/yZEnWo/br9rZ1w0Bxo+seCQwHssriy
 bXhlpMxQdlSNV4PGjFACHHUy7OdT76/jcwTd7qEn4b9kimoxcsF/dwYqipQBTjp2dhk=
X-Gm-Gg: ATEYQzynuTmRKh98fv46mivtIXJO7/C3PrK/3VVI5wJoZL9EGtp134ct+RXiacMtDCK
 xclJu4/wgfUBml4UgAmaAIAZP4/EqQJIx2WAYRcKs2ToYpeEEZkxHQm3+FuhL+7VEU12mCrRPEs
 cYbglGotYzpBej+IKZ3RFw3q1EHKbLX4d0HPl9FfagFkJ4RoAu4qaijWXm6jCe/ByfAxuqnrE2m
 z0jfAee3to6ro0eHSMIT4yJ/mqhL8lUXXKTQ+tY+Jpn7FKIQDEC2zgojfkR5rlSdMK8OZJhI708
 URWbOhOHNm1cjNBNQ/QwPlY+oOIfQ2Sxexnbind2BR7jbITaJtU8m24ZrJPQ1oR/5B+MBEEplzL
 HwlDlrSzmzrqNnnRnD8xpMNtMtRBcSRUsecmhZpJfTDObZT9l/cdOtaHilXn9cKchYqjRlnf+Q2
 UCJVl0egETouC66fmnML0ivXQZ2ryGpN5mPvoVJDffNmc7Xo7a3HGvAs6zZZSVti5J8hEDSlU1v
 NI=
X-Received: by 2002:a17:90b:1dcf:b0:354:bfb7:db1a with SMTP id
 98e67ed59e1d1-35dc7094c87mr1932948a91.31.1775017089355; 
 Tue, 31 Mar 2026 21:18:09 -0700 (PDT)
Received: from [192.168.68.76] (122-150-206-176.dyn.ip.vocus.au.
 [122.150.206.176]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b242766203sm153692885ad.40.2026.03.31.21.18.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 21:18:08 -0700 (PDT)
Message-ID: <26822805-a7c9-4d33-a946-877eee1e72c1@linaro.org>
Date: Wed, 1 Apr 2026 14:17:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] target/hexagon: add v73 HVX IEEE bfloat16 insns
To: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <003328f47c0b5e286ef06ba55cc9734e7bba4af8.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3NqVcXGf+ND8KAhR_e78YD8nRJy1_ZL9y-0QBkkQ5rweVw@mail.gmail.com>
 <CABrGZ+GQK7Z+vXWR_zKFHYGpmNvPNPvPc-jesKkD5YDXUEe3kw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CABrGZ+GQK7Z+vXWR_zKFHYGpmNvPNPvPc-jesKkD5YDXUEe3kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 4/1/26 08:03, Matheus Bernardino wrote:
> On Mon, Mar 23, 2026 at 7:03 PM Taylor Simpson <ltaylorsimpson@gmail.com> wrote:
>>
>> On Mon, Mar 23, 2026 at 7:16 AM Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com> wrote:
>>>
>>> diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
>>> index c342507d1a..b70996578e 100644
>>> --- a/target/hexagon/mmvec/macros.h
>>> +++ b/target/hexagon/mmvec/macros.h
>>> @@ -25,6 +25,9 @@
>>>   #include "accel/tcg/probe.h"
>>>   #include "mmvec/kvx_ieee.h"
>>>
>>> +#define fBFLOAT()
>>> +#define fCVI_VX_NO_TMP_LD()
>>> +
>>>   #ifndef QEMU_GENERATE
>>>   #define VdV      (*(MMVector *restrict)(VdV_void))
>>>   #define VsV      (*(MMVector *restrict)(VsV_void))
>>> @@ -366,4 +369,6 @@
>>>       (int16_t)(A) > (int16_t)(B) : \
>>>       float16_compare((A), (B), &env->fp_status) == float_relation_greater)
>>>
>>> +#define fCMPGT_BF(A, B) fCMPGT_SF(((int)A) << 16, ((int)B) << 16)
>>
>>
>> bfloat16_to_flloat32
> 
> I've been experimenting with this, but it looks like softfloat's
> bfloat16_to_flloat32 conversion will handle NaNs in a way that is
> incompatible with Hexagon. I think we will have to stick with the
> 16-bits shift

Yes indeed.  Many Arm bfloat16 inputs require the same shift.
It's only the "real" conversions insns that want bfloat16_to_float32.


r~

