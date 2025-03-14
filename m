Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF116C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 00:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tstD6-0006h0-97; Thu, 13 Mar 2025 20:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tstCl-0006ax-2U
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 20:47:18 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tstCj-0000UZ-95
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 20:47:14 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2243803b776so45943945ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 17:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741913231; x=1742518031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wkWX0TOe3VG0MU//3ZsYG9cAkYDJup76uZOhOaZ52E4=;
 b=NZTGkA2mXaeY4qks07UWtmWUnQaFVRYtXcuWKlGuNFb2anMHIk59ARA2+ySSySsfUE
 4yVnvrjVYMeqayAE6W5v81YVVQs9S6AyOKeoYRSr0MKCmduQcE4tO5Z1EyYHHHKzQ1TB
 o3b9Xisd+YthGDxIghFgzxQqXGrC27ZG6IEReC4+vXF0nu8gCFnVTWNvpfoZRQRnOZM2
 AszMhkmmbrR6pxzy3i/aC6LPjehaj7cqQ3cpExy3l5r3GQHzVFCpD4oI10ci8BCadYRd
 wArPgBHIVBpUEFOp3XqydQNyFaXBwwxy4ZONyfWQEKLW0JMbjW1Pqvk3MQb+zlWa3UOs
 eS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741913231; x=1742518031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wkWX0TOe3VG0MU//3ZsYG9cAkYDJup76uZOhOaZ52E4=;
 b=AZpXbKtLyNlU3n1BGqF2Ej692DmnQnLq1IWcaBI8ocUFOBcgDmg07yBq5KKAZZBpPL
 DL0ExLzBSIhx0V+sCaKDhEZct28w8tztUzKlKw5+Mb8YrNK05BRbS3WNx0+PmL4tNsoa
 qViWCjcJwv04QmyNY4xlkv7l4yG+gMcd5NYmNFMyAxcg9ifiGCTno/ZTikeRnIUPXoqA
 F4SHg2wB0VjEnwTKn8kJk+hIAUKHzxD+IER01GtGfSXmMI+odSlb3T2KQ2alhs/zs1JW
 V6r5gdsFiTKRTNd5wH+TFgbexNI87xBkWyPTvGOcJxmN7PdxFT8ZagEA2kYdz0UVO4+q
 9ZHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDlN3riH4r3geUN+oc03uCATXSsTtSXXD2usQL3BA1X5kC09bOU1CRI25EwOSRmsFc/k2zFsWZ7ceu@nongnu.org
X-Gm-Message-State: AOJu0Yz0OchDIeVlMKGFTtSjCbXrL+v44v/NczL5EztwwH8Cuj0QhUj4
 JZLR4JIfewG2npcyDrJe4gs9dGawuxpodUD3hlR/4m8rDTwtSz2Y+pthatMy5Pk=
X-Gm-Gg: ASbGncvzRZFJMoTfZwsPaQyIQD4EVygBvhxQmgccWpzyIAOYEg3AbXQZRH+aYqlgvIe
 MGWn/ZH7s1C2rropEMH68na1Hvn6dVoxhIfUjIn7XSJcY5ejMrAHCq5xCgJccjfe75ybXaMKX2d
 BRAAVLR2+uHdgGik0pf8p/hoGEYeX3m0UZzarvBPbQreXG2Ed/BmvEvB7LbMVTL6IeaMYrB8KAo
 yDpu3IKPKckQ20YB6REQvz+bI2Eybm/TCmOdAl+vnOFUvzwwNsjPuCdr5PiPMuAjap9a3V/q7+B
 sblfQQg5qDSPlnSoUitfWY1gtK/xn7wAFxbejD+urjz5aVkuoS0JvfMC4e7PFPBWen6JWrZgrrW
 MNIaeEf4hpOm0+GdKQKw=
X-Google-Smtp-Source: AGHT+IEOEmRH1nxm/alIWzQcxTHft5PM4w5RN3FNSS832DllLjLqKqR7lj8CxPj0/955eCVNmtopDA==
X-Received: by 2002:a17:903:1b68:b0:220:d078:eb33 with SMTP id
 d9443c01a7336-225e0ae719bmr7738505ad.36.1741913230833; 
 Thu, 13 Mar 2025 17:47:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbe960sm19702915ad.200.2025.03.13.17.47.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 17:47:10 -0700 (PDT)
Message-ID: <c31e1b0d-7d13-48b1-9122-3c381cc6d2ab@linaro.org>
Date: Thu, 13 Mar 2025 17:47:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/37] accel/tcg: Perform aligned atomic reads in
 translator_ld
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-10-richard.henderson@linaro.org>
 <51cfbbc5-c258-49af-bcab-ad1ce21ff711@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <51cfbbc5-c258-49af-bcab-ad1ce21ff711@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/13/25 10:14, Pierrick Bouvier wrote:
>> +#ifdef CONFIG_ATOMIC64
>> +    case 8:
>> +        if (QEMU_IS_ALIGNED(pc, 8)) {
>> +            uint64_t t = qatomic_read__nocheck((uint64_t *)host);
>> +            stl_he_p(dest, t);
> 
> Should it be stq_he_p?

Good eyes, thanks.
This would have only appeared as disassembly errors on x86_64 guest.


r~

