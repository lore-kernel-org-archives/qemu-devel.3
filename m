Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731C8ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 18:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snisc-0004iV-0x; Mon, 09 Sep 2024 14:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snisZ-0004de-Cd
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:12:47 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snisX-0002T7-Qh
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:12:47 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-277ef9a4d11so2574822fac.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725905563; x=1726510363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bgWFiWE4QVhUO+143r49gPc4CxlKLZPWhuBZO2rCSxE=;
 b=A/w2J632DuOYX3/Cw0DY2+/Sd31v/GCpsDnLfFgDrBrmz0mZA11D76hSpoFIiNhNQd
 3X1fhiFxBr7lXJcg5elPQzsHx/azH4tqfXQg4v5gjYsOq3/5Oh9eSJ4zWrbTPZFFoCoX
 URRLsCZRiQOLYDwbEuJNOH6vgT1XRDYl8WfxXU+wey77nstY0T/aOYct5nxGsEY1vf5f
 z7b7K+v8HTp2ixahJjHukR8U6qFOWJgbLxPkJfxp8DVYeE8ITcUujOGROX30CLm4Kgp0
 3+jqIHKYlAEkKtL+m480tWEGvD4lb4fN4ChigzSqphIgCG65qkCghicL3ZaTgtYieoJk
 noZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725905563; x=1726510363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bgWFiWE4QVhUO+143r49gPc4CxlKLZPWhuBZO2rCSxE=;
 b=NiHX4ULY1h3HslxH0APrQY1+AP0mESUMD9IvYqX/uzaWZurJGGfkvsta5HBBnESDSa
 8OFdoSmuleemJH/nRtsgEh4wg9v1iLzh/EgkPfEDeDjUOnOo4K1OcGHN5Cp8PMIx6LD3
 0L92Jfze0sgRzOQ0rWZoIUrQ2oeWk+284df/KrLsgbp2ZwEGFmshmc5RiJNjhU7DUX98
 bEdeh7YueagaF8c0V7JBtI9aG3zREBWl/UFTanJZKv3+GPjRsvlx3f2381LKApi06FnP
 +NRP5mGX4VrwhzhFl9tQndPTA0N2EGAvRrfo7/OLj/Rul4kuhqedBqgQMluqxn7Y8zG3
 n8Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbdlHWLvQeu/VAP6WnkyaN9Qevd+k+wQlNruEQTFdxtKiU8oYgRH5ybKi/HNsC+GF0TSLs/2orYeA0@nongnu.org
X-Gm-Message-State: AOJu0Yy0jQjXIHpHkEJF4v3z7ep3ODgpaIMZeZ9Vjt8zIAoRwhMV1ptm
 1/T57XkCVIDxLK5Bf9hqyb5yp1bIwbCgNlGx4MjQDfWHfu5IvAM4FvocPDDTr9w=
X-Google-Smtp-Source: AGHT+IHmI0DwqJq+TiW2awMWIVnyjR7uggJ+9P+WvGXrzXwc2iCkOfI/LtNXE7TESiwj/XU35kHTzQ==
X-Received: by 2002:a05:6870:3913:b0:264:9161:82cb with SMTP id
 586e51a60fabf-27b82f9f4e4mr13206334fac.31.1725905563216; 
 Mon, 09 Sep 2024 11:12:43 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe2106sm28685b3a.46.2024.09.09.11.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 11:12:42 -0700 (PDT)
Message-ID: <78b6e29d-5ffc-4c31-86e4-33d34bc77518@linaro.org>
Date: Mon, 9 Sep 2024 11:12:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/i386: Implement vector TST{EQ,NE} for avx512
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240908185110.485573-1-richard.henderson@linaro.org>
 <9f9b2305-da3a-4215-bf97-462bd1ade4c8@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9f9b2305-da3a-4215-bf97-462bd1ade4c8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

On 9/9/24 02:53, Philippe Mathieu-Daudé wrote:
>> @@ -3145,6 +3153,13 @@ static void tcg_out_cmp_vec_k1(TCGContext *s, TCGType type, 
>> unsigned vece,
>>           { OPC_VPCMPB, OPC_VPCMPW, OPC_VPCMPD, OPC_VPCMPQ },
>>           { OPC_VPCMPUB, OPC_VPCMPUW, OPC_VPCMPUD, OPC_VPCMPUQ }
>>       };
>> +    static const int testm_insn[4] = {
>> +        OPC_VPTESTMB, OPC_VPTESTMW, OPC_VPTESTMD, OPC_VPTESTMQ
>> +    };
>> +    static const int testnm_insn[4] = {
>> +        OPC_VPTESTMB, OPC_VPTESTMW, OPC_VPTESTMD, OPC_VPTESTMQ
> 
> OPC_VPTESTNMB, OPC_VPTESTNMW, OPC_VPTESTNMD, OPC_VPTESTNMQ ;)

Oops, yes.  There are not so many uses of this in target/ yet,
and I happened to pick one that used testm.  :-/


r~

