Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C40C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 18:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfk5u-00051j-EV; Wed, 05 Feb 2025 13:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfk5s-00051M-BV
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:25:48 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfk5q-0000cY-Ie
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:25:48 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21f20666e72so2677285ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 10:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738779945; x=1739384745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w6NHmnVDKKp3ZtGQSeQWU7CqxkSE/9v9r9iFEFiXHQ8=;
 b=HLGRM1RBbAUL7Ncp3zPuFCsZKBkKn9nn+RUuEu9Mc+dr2A9CUzqwHlc271rzg3BgoM
 ehfflYkjzjJfgQILc5clzSr0EpxWKMjjFHARBd9w1XlD1t7M4H1qejySI/U+5CloI8uz
 dFrlPagxo8glUL671iiOh0m5rZYVPjH3QscO1ZUpfLoP1gGhTZ6cOly5Vu7KMZrylecX
 8mE2cWBOUcrsAh9GY13ctBfQjZs4tQRfZOhfWzxLyRJZ2oOfYzDVsywrf9gDOK9ttT+Q
 IUzLUqbeB34wsf96Om3vlfRwT3eAMKgBKQOa8lKGRbdmPycZn2gpbo1lyaJWIA6Dyvp8
 rDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738779945; x=1739384745;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w6NHmnVDKKp3ZtGQSeQWU7CqxkSE/9v9r9iFEFiXHQ8=;
 b=t1w5stCr7CnFBoIahy5LWI7tHqnxOlA7gkCt48h2wcdTN89XrA8rS9IpL24kgjJAnk
 o7D/+dzoz2c6b/Mjlu1pUCApWhN1PwlyNBy2zjIfVn60bS+LRUrURtMmyRSxjekhL9Zc
 Dxk33DscE4NksyLKzO+lKe5KAeR0Jp5xJcazRh5WKOAlBmOOd4b8ay4S7Huyi3xebEQ+
 iwupFqxC9pDYd6aE3b34g3Fl4DbKq+VSjS2m0dqstiHLYfGgoCyhWesbrRrpFERgHB2M
 BnIHR80TL4n/Mcx6VVt4aFn+fV+0x0adYwyz4FCzIX8IVJX0iVzxvOip+w5o92Zb/5/c
 t6Kg==
X-Gm-Message-State: AOJu0YyglcDP4R2KdH84bzWJ2cOG5e7gspXDq1MEEJ3vDrrxIfeeQ9Ii
 ZcO22Fbi7TjZAZkoUuDYTYAxWX7Oxn2dC6zhSSJIPp0Ky4N9J+HKtkJGk1pE62NgL1z54/Z7L42
 6
X-Gm-Gg: ASbGncv2uAJQO+616FChzQcBCE4Bcb1TJHxYM3wyN299BNN4DloTB3JkLxeAL5Nbx48
 XzrzUa68k/5XdDnYeA0QmwfSyRt/e6hWvSQ/U73FwHypuOt54+XHDdpSMUt/N+QONVrUZC8xdQM
 ySLbdY14cnSvsRQKkHSz099FYXBRLY55R8ZAR9oz8v9+LZRfYsr8F76k7Pj2u3ZOpdSiiDXRrlL
 pcTPOknx4b14XcIaqziJXOMGoRIACVtSdChy3JkBPHASeSIA+6VS1LxB/9MhjvJhDLrImcJB0o1
 Oon4g7L69nuVDo594rQ3Kk4RDugh3elG/jVRiVJm4HDnVzXshZGniaw=
X-Google-Smtp-Source: AGHT+IFkhv2Vd+Iwfg+vVRh2IjBxU/cOrtvwuWP/Iw/6fKjoxh6ybqkm4tdx7Cc2/ZqHoxsaJYVuVA==
X-Received: by 2002:a05:6a20:d70a:b0:1ea:ee89:5d9b with SMTP id
 adf61e73a8af0-1ede88453c2mr7678959637.21.1738779944797; 
 Wed, 05 Feb 2025 10:25:44 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe64275c4sm13358102b3a.61.2025.02.05.10.25.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 10:25:44 -0800 (PST)
Message-ID: <23032dd9-063e-49b3-a6b8-25d0c8f72cef@linaro.org>
Date: Wed, 5 Feb 2025 10:25:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] tests/functional: skip mem addr test on 32-bit hosts
To: qemu-devel@nongnu.org
References: <20250205155946.2811296-1-berrange@redhat.com>
 <20250205155946.2811296-6-berrange@redhat.com>
 <9edd3138-3411-4459-96c3-d48c30e197e0@linaro.org>
 <Z6OXlPu0fw_S9iy6@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Z6OXlPu0fw_S9iy6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/5/25 08:53, Daniel P. Berrangé wrote:
>>> +Decorator to skip execution of a test on 32-bit targets
>>> +Example:
>>> +
>>> +  @skipIf32BitTarget()
>>> +'''
>>> +def skipIf32BitTarget():
>>> +    enoughBits = sys.maxsize > 2**32
>>> +    return skipUnless(enoughBits,
>>> +                      'Test requires a host with 64-bit address space')
>>
>> skipIf32BitHost?
> 
> I don't mind either way.

Definitely host.


r~

