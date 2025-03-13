Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FBBC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 18:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsn7Q-0005xM-L7; Thu, 13 Mar 2025 14:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsn7L-0005wJ-VT
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 14:17:16 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsn7K-0008AK-8S
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 14:17:15 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22409077c06so35264955ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741889831; x=1742494631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D630YNswjhNm70+PXVcrDg0VlWavMy3mSdJr1GWN4+w=;
 b=CtK2wjOPgzBUfQZQ36oLKfNO4KSVsHMCKfTZHRGWgh3kgdDf8jdr+cRWAp+X9WMQRD
 th6IgrjJjxP6oQZTJudajYlfjfzL0X94L2lau39DuAOrBipuYXA7OGiHAbuAwAkRDbjy
 9dXqIdktaubBxC67sV41eh1g3lN9+JmwdxixEtSPi/ymZIu7434D5N0nwPFAHVRp96n0
 lh5Kq8g2i5Bk13ZkDvhyfqR6WyXPBDwn/uJSgFOiyYBts4MQFwkKC3MqSlFfV/7R0ROu
 i4/CWX81yH224iQCn3Clsjx+TGkMfKE42Ma6l1rX5AwpJIysvgggTnXmiDzc/pKpRoQF
 Q2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741889831; x=1742494631;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D630YNswjhNm70+PXVcrDg0VlWavMy3mSdJr1GWN4+w=;
 b=nbxJhLQis8Mi22rKo1TqaSLuQrDGE4YZNii2Ls09ANC3G65gLuDzCidVkK8aL7QpmL
 m/co5lOXFNL/BeeZSW3AnBMdYDDuieBlo80dyd9xcqi2gJCVbPap46KvNiJ9JHzpgfsN
 Geky9TGuO2nqyhXfr0qoPPE3EMVXB2O5vv7o5SVea9xB8YlGF4qNWLdho+kDO/eEAfuc
 0AwtBwUnsNeB+er4pZC3g7SZo2VGTEJPzgH9ar6BUjeyEzBhoYcqf/krpfcitdX3tHDb
 kvOBuz9i/tLnjFfx16MGpXXGLbqj3UC/0RcWwj3Ubx/g+n3yeBj/DBV+GPSk1fsHwEuE
 BYWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXti6I/LBsV90O4ilhLm/J1pbZhYaq4sWXe01/7To0/Qa4NJp4VkQ8krqwyB24O4woZEJAusqZMk95T@nongnu.org
X-Gm-Message-State: AOJu0Yzylleks7sfvXSVS9maOG8Xl9d87Wb6gW7qPIEdc/q8lAhGjB5t
 KkOAhIPdhxqeHHjflxysF3hUyvr4QJm3mpwxY2Re5kK5e1jz18JkCPihKABb18TlSnD2zihK8Bn
 G
X-Gm-Gg: ASbGncurW7pPwgvFQSvNTRK0B1Sfe9Na199qI/0ivfGQmPiFI/yQeQNk8+C/REfGD+S
 lMs3kowLNsdmJfIT0O+CNcGVUP9EU3lnHOv4D9NOdgEcim7D9jmQbZDtmHLVGrs+x0VJTDN5ZEH
 2+1dcpG3WvAINnacnpExQzkv7SHPW/2aB2x2SKJ14byc/k5cfJUrqzAXi3I/3MTsPp59FWYlmhR
 M35785sIgIjQHrTmchXvKdYnOcgprAPNqifj+sJiO90DKW69rdGyvhOKlgsJRUoKSEDQ+uOtu9N
 esWGV93+zVpukTYR7FSM+M758UONpVy9i9JgSi8uEt6yPLnYaiZI/xhWJMu8MxA4Cwn/6Jv/r9n
 q0gIpxcea
X-Google-Smtp-Source: AGHT+IEOsXZo9sj6UE1ilRNBpyNM+nHsASZfrZrZjZ/yr9suMT/ardwOXDFgCEEmopXIbCiZJnBZQQ==
X-Received: by 2002:a05:6a21:394c:b0:1f5:67e2:7790 with SMTP id
 adf61e73a8af0-1f5bd7eaf01mr952126637.17.1741889831421; 
 Thu, 13 Mar 2025 11:17:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9e195asm1599150a12.25.2025.03.13.11.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 11:17:11 -0700 (PDT)
Message-ID: <02f6b778-2ecb-48d7-85ff-237bd587be90@linaro.org>
Date: Thu, 13 Mar 2025 11:17:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/37] accel/tcg: Implement translator_ld*_end
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-12-richard.henderson@linaro.org>
 <025651b5-3b4c-4326-9aec-87f81df725c6@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <025651b5-3b4c-4326-9aec-87f81df725c6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/13/25 10:33, Pierrick Bouvier wrote:
> On 3/12/25 20:44, Richard Henderson wrote:
>> Add a new family of translator load functions which take
>> an absolute endianness value in the form of MO_BE/MO_LE.
>> Expand the other translator_ld* functions on top of this.
>> Remove exec/tswap.h from translator.c.
>>
> 
> Is there a need further down the road to break the dependency to tswap?
> I am not sure of the benefit to drop tswap, as the resulting code is more complicated than 
> simply calling tswap*().

This combines the tswap in the core routine with the bswap in translator_ld_swap().

It enables cleanup in the various translators where we currently choose "swap from 
TARGET_BIG_ENDIAN" rather than specifying the absolute endianness desired, which is 
usually already at hand for use by all of the other memory references.


r~

