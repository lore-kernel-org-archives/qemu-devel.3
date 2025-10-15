Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9358FCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v950G-0007QT-Vq; Wed, 15 Oct 2025 13:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v950D-0007QG-30
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:09:29 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9507-0003dI-Hz
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:09:28 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-471075c0a18so7380265e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760548150; x=1761152950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5jopzM0swassCYuNUhN7gP+sTCya11oFX1c1euu/V3U=;
 b=zfDzaWo3jLvncLzKoO7TZlCJKAnq7VwV9Qy0LyPrgOVQJ/w8bKIDi6n3o2NdTFBvjZ
 rMDqkDy/WFP8maNzPyNEeCeUQHFEzsUiQ/tLUgDanMDNsxz1BEcbnSwGiilRJ1Z/zkpv
 CBAc9Al81/xZCHnxVxk/1agnlJKdtXPHMylTEq246n8dPVwLo7Khy4glerOC9kMYYwDB
 oHEdypUhY30vbPgVhFTgsQFJLcqGb7bH75rx/SgS/bwCsAPlM6tiYD7jOqYwMjEACW9d
 298cwU8ClNyC43g/BKa5UNGRBeH1kJQ+ijwrXLriRszZfRyviazhVsZ11HDSs30jGQJn
 60gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760548150; x=1761152950;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5jopzM0swassCYuNUhN7gP+sTCya11oFX1c1euu/V3U=;
 b=ZJKcSASJnvBWMEp3l5h9r3WRrmVxVg85FZ4l3cjqNSNqp4UR3Xs+f/0OTv1iVSUFqC
 VE8uSMdt8l+hnPcCRikO/Im01EI+2DQBYGnd/nuul1YgVAgq271Duc08Y9wQhXoJ21lB
 b6eTGmiwT+rbvmd6AV62TFvvsdtQlW1sFvbd5AYM+s07/L4aoGMKWfQbgVCzSusSM8om
 vQz9fuTJoxDww+MK6m5yVarO24/CWehvcNQrf+ns2EDVtL6efxAH4ciGK5lwJP/SDrz5
 F5fDKpYJa0na8TPArJFiqTsnGMjehjn7gsh3kQTMxkLYUWWVEu/n1UPmYpSaMTRsManS
 7sqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnHsQF9XYEqHBhMV/cPRZtlR/bk+4eUgedZwT7UFflEK7RiTE0gWitHntv4Dw8M6kRJ7XM0O0FL8A9@nongnu.org
X-Gm-Message-State: AOJu0Yy1R2lW/bcrGOV36umtq6zUs7/OIRsbF5OfH/hd2U4erTILhBz4
 sxDLl/M2IVruN6v8QFpB5tuehf5FRUlYMsNz7LFXWTuOSdWdKbEMWFHqJAklLpBjEY0=
X-Gm-Gg: ASbGnctpr0kkkBYOrogAvtEv3BCMxm1naKrMDfMBn+T38Fj4eWM5eSk3mdl+4Jy0tID
 jNhMbGdCRPXpgMqWl0HoLBRfkubnE0CbK0MAwEiBvNObJQ0pYMqJW+6Ry9hm5j+DWltf5C6rG2X
 miVww/+dZ3IsTvf82gL71yNaVTLvfLsdBoO4RmmuEIrkEBPI98sol23A7AQvFPpzOnI8IiEGQ43
 8JgaDLVTOt8Om3DwfOi+DXbAJ7BY4/3mmJXyMHVWVSgXVMKSyXflqDMtgrRt2CodgZf55ww9ltr
 cZPckYSWjLrmnfL2kXEs9cQL7f1SWdxLtIYZ6O1zycHL96KgFMmXN+OUOE0hkhDzbLoXxvYkfOQ
 aqxGOu0Hgs7A4i10bZsZq0xyr2gKc960wrRJcP+gFT97vveql3EALF6lN/BGxNKtjf5YvbcBfZb
 KQBK4DifC/QmNi2djGEKkLFpw=
X-Google-Smtp-Source: AGHT+IFbRsNSVQZb/tg8RtuOjyu4kfSXzAjdAcxZehRMPX52cgh07xsIqXRFpNl2EPWZO2UWGjPofQ==
X-Received: by 2002:a05:6000:43d6:20b0:426:f391:1968 with SMTP id
 ffacd0b85a97d-426f3911a30mr3759293f8f.35.1760548150113; 
 Wed, 15 Oct 2025 10:09:10 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d4bbsm30468629f8f.2.2025.10.15.10.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 10:09:09 -0700 (PDT)
Message-ID: <155aadcd-5044-443c-a647-02c5e3d92ad6@linaro.org>
Date: Wed, 15 Oct 2025 19:09:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] target/hppa: Replace MO_TE -> MO_BE
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>
References: <20251009101040.18378-1-philmd@linaro.org>
 <20251009101040.18378-10-philmd@linaro.org>
 <2079231a-e7e9-4b1f-80a6-b60e2431c8e1@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2079231a-e7e9-4b1f-80a6-b60e2431c8e1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 9/10/25 19:04, Richard Henderson wrote:
> On 10/9/25 03:10, Philippe Mathieu-Daudé wrote:
>> We only build the PA-RISC targets using big endianness order:
>>
>>    $ git grep TARGET_BIG_ENDIAN configs/targets/hppa-*
>>    configs/targets/hppa-linux-user.mak:5:TARGET_BIG_ENDIAN=y
>>    configs/targets/hppa-softmmu.mak:2:TARGET_BIG_ENDIAN=y
>>
>> Therefore the MO_TE definition always expands to MO_BE. Use the
>> latter to simplify.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/hppa/translate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>> index 6fec63cb433..c9009441ad0 100644
>> --- a/target/hppa/translate.c
>> +++ b/target/hppa/translate.c
>> @@ -106,7 +106,7 @@ typedef struct DisasContext {
>>   static inline MemOp mo_endian(DisasContext *ctx)
>>   {
>> -    return MO_TE;
>> +    return MO_BE;
>>   }
>>   /* Note that ssm/rsm instructions number PSW_W and PSW_E 
>> differently.  */
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Indeed.  Like ppc64, hppa always defaults to big-endian and has a PSW 
> bit to enable little-endian.  (Which we don't implement, and quite 
> possibly was never implemented in any hardware.)

Indeed, per parisc2.0.pdf:

   PSW_E
   Little endian memory access enable. When 0, all memory references
   are big endian. When 1, all memory references are little endian.
   Implementation of this bit is optional. If it is not implemented,
   all memory references are big endian and this bit is a reserved bit.

I'll squash:

    /* The PSW_E bit sets the (little) endianness, but we don't 
implement it. */

Thanks,

Phil.

