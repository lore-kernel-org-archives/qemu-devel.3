Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C582AC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspVF-0002tS-P2; Thu, 13 Mar 2025 16:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspVD-0002tF-NI
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:50:03 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspVB-0004hR-OL
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:50:03 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22349bb8605so32720895ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899000; x=1742503800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kGCSJF60hPj1xBb/AFNlL1GNn5bv9GYDHuU+mA/Bl9I=;
 b=GM7t3Ok1FFvCLsGijYQ2zhgoXvAMKBAZjna5dMtk9Z4+amhOPDZOy06P5VDUZVxE7P
 /0HoVjKkxadJhYdyHjknHfQf0FDLWCXk/3apsoKPAO6KW/4+1JTU1dZLc9OivwCppzti
 p+7hUYQu98T9MXzcZ4zQr/ZU9CPMOgUN62YtBapF8XB81p8zt9mnd30kCPUGCdGvy8sk
 w9qbCCp4wh5aiWWg38o96t4Z86qrrmvBycBxq0oSbkooYDsVm9DydDYccHAB2gT7MRi3
 1XuhLMEnYR28C16dhfsjwzfKyEjQyLbbgcB++tHK7qnTWlnAC81SO+OLh7pgu4K0Kydo
 xvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899000; x=1742503800;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kGCSJF60hPj1xBb/AFNlL1GNn5bv9GYDHuU+mA/Bl9I=;
 b=USjEYLV5PwnvTr4z6vEb7/lwN6yR2f+OlP091K8CNcacRYuCVHS1cgmH3+Bw6wBUfb
 59EAdsYJhCTzG8l525/fzw/BVP4FQ29vQS+SCIY0iLgGJZiVnFdYC1VRNTNaFGdeiQCP
 O9S5CSSmjSCAJd3th6Ngy/0mxl4DPpAQb4rYGkC0sBY4I8ch19bb92NPcj1Nyou8QmCp
 W/SxGPwipCgKfcItvOQZMNXe3Z585jMlD7ea41y9iJ8YkEZNMmeJ2iCAuY1iqnujw+M7
 s4J28ZGg3fPNQXJvtqYd/wmq5P7UIf45nIlRf3De9pdVMvdqQXQt1iFlmYvxL+4q59JG
 l2Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXabSUlWf6ETGr+eXSpxypxsIpDzHpiCuWOu08pAeVe5G+aEqw4aJajRZMVxaEB0zsnoIW9BEXurRKs@nongnu.org
X-Gm-Message-State: AOJu0YxJUP2brjHRxHXbQrMmhubyhcRJD1bxD+6mXSKCi1XzB+nLRbJk
 w48kc1YN6zLJx3v+zWcXrBR37FknamQ5d6Jk6crZZBmKYjGKcHY+kXQM3JJ9Oik=
X-Gm-Gg: ASbGnctmZcnzWdPxy8bS7bCXFz2FAlK9hQ4nlvkvVcC+OwspjRqCZ3Ks5TWnlLn+NyU
 0+NTITACKdGPMUmbPAad0ZKEE4Yl4M9fnO8B2amw0Z9/+GovLrqR9nVkU3i3em6JZuVawJpoQHC
 hSzmCf53CxtUjQU8Pi00V5h5bO8RvBfEfQNOxtTf7U091mmrssW6XLySZCWJWQKyNSRDO4CDu81
 33beAkYLuU+CPAJkMTnM6X8lEGVdJmcaUOPkD8Rcf1bAXnCoZLK5lswpCe6YO9A4Za80RgSGBf8
 Sn9EDcl8CnmhfdxsxtjYm+JPNLD5csBTM2QkE9ZkCjAdMA1Cu/hCr+tXPw==
X-Google-Smtp-Source: AGHT+IFPvvI0Vwf+YNiD3pjshDJXw6LvYf2Jm3Bwu74C858ziotMTuRiTad2fJjjGU9qeUyGVAZhIg==
X-Received: by 2002:a17:902:f70b:b0:224:d72:920d with SMTP id
 d9443c01a7336-225e0afa009mr310695ad.37.1741898999924; 
 Thu, 13 Mar 2025 13:49:59 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6888303sm18019405ad.42.2025.03.13.13.49.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 13:49:59 -0700 (PDT)
Message-ID: <f5c0bbc7-501e-4d43-a309-c95361c497d6@linaro.org>
Date: Thu, 13 Mar 2025 13:49:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/37] accel/tcg: Implement translator_ld*_end
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-12-richard.henderson@linaro.org>
 <025651b5-3b4c-4326-9aec-87f81df725c6@linaro.org>
 <02f6b778-2ecb-48d7-85ff-237bd587be90@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <02f6b778-2ecb-48d7-85ff-237bd587be90@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/13/25 11:17, Richard Henderson wrote:
> On 3/13/25 10:33, Pierrick Bouvier wrote:
>> On 3/12/25 20:44, Richard Henderson wrote:
>>> Add a new family of translator load functions which take
>>> an absolute endianness value in the form of MO_BE/MO_LE.
>>> Expand the other translator_ld* functions on top of this.
>>> Remove exec/tswap.h from translator.c.
>>>
>>
>> Is there a need further down the road to break the dependency to tswap?
>> I am not sure of the benefit to drop tswap, as the resulting code is more complicated than
>> simply calling tswap*().
> 
> This combines the tswap in the core routine with the bswap in translator_ld_swap().
> 
> It enables cleanup in the various translators where we currently choose "swap from
> TARGET_BIG_ENDIAN" rather than specifying the absolute endianness desired, which is
> usually already at hand for use by all of the other memory references.
> 

Ok.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

> 
> r~


