Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE8CCCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuTV-00040s-RD; Mon, 03 Nov 2025 08:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFuTT-00040a-GG
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:19:56 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFuTN-0000zK-38
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:19:55 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-475dd559b0bso59405005e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 05:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762175978; x=1762780778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xFKGvcUvspf53GurFP8T1yRW2JUQf5wcgEySEWv1nGY=;
 b=q3MxB7UIlqCeldB/qrQfHIv0SdW2z9iV+vSkjMVROvOFvvFTyOsTvDI58Q43dV/j5F
 WPLG7I4lfK6gBm/COlW297L4LjtS6rFEH/l2CzMn2ZeOAwvtwq5Us8n3SpYGEF3SYtD4
 6VsNhtMwyRdztL3pYU1IJ0B/YEs9+U7bbWchQb0m34BSX0RKi7MnkdLORg4DDpiGCbqS
 crRDjcCCa3YpQkfiZZ72pDmSVYEAQ6PhNahdhXyuPZdkInoZl3uXz+hF/pOOZ7Ytg7eT
 RX1hF5t9vgBcMdXWf/BxZpN3bi6g/n8X83B49OI/9WpfriMRfDuI1OovWaSujT1URNfN
 zyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762175978; x=1762780778;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xFKGvcUvspf53GurFP8T1yRW2JUQf5wcgEySEWv1nGY=;
 b=KG/U6YchCAE0yibJyFSzR6m5L89+f1ywJVoo8T+Rt1pkLA0Lzcdzz+ZXsNfryfAJ0X
 8GFvYe5gAs/qOHyWdMoKwKd6llaPT1RiByQUMLXNSOfV9WW2Rlvj8WpDF0oH0r3C1jmA
 uQcqlg260QNSreLKf9b5JsnIGR/5CGP62xdIE/jHEky0sN7WwgByBnPp8se3xdHI/fTF
 uRiHeJHNLWLS5h2z4qxL62Kz6KNwUMWKEM4WqYtVbmioVj7ae0RWjblFHV8WRrbMFFx6
 IlEartb60vPWFAhUSWF/EIvgkPz7XKHDT2VefgHncYzix0BejD890y1GsUkx32wJxpSQ
 VVfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGxeaf/369ocexE9oRdISdmpj3W2lawVe8F0ZFOIXlnUZFyZ+n+iNuVo6WBFdJlNqj4K8XdJuY14Vj@nongnu.org
X-Gm-Message-State: AOJu0YweGGsgIBLsVg5kk+ajzsyrPOb8New/M2m2IUzWgxteB4DEZQ9v
 IQVNIrLZqwGFxqKrKoLChhP/hhnfT1dQkN+2MZqUHxdgRpXzwHjSEEbBdmHrbD5723M=
X-Gm-Gg: ASbGncvwSg16eGPQGkXar8BZ/+urqLhqs2xkLu89XRe17W6u10bZQ/PxSN8fH16WahW
 dFIV1EaCKJhZ6vwPLjc/9qPqZ18wfCQfHc4UDBiSSISDvWBu9E+AcBpLYimbKVSAG1JUj5MMjww
 g/23Zy40qJh1WjEWFZ02oqd6cc/nEJj8M2pldfJNARuwYnOD9TwzStt1LaCrycXLYbTNX+hsQHd
 X7AypAEz1fVsyIe7XA4EzTL7HwmBy4gMHWy5jXHnP/qTfSzzBLcYsq/m9OeEy6CX/Gh2F5hR/0L
 fu0yx5Zcymph6oWh5df18pOHCHjEcUeVjyhh3XGdf9YDwc1GBKobED5w/grRGj9Y/ggPxNbFAN7
 ThR1iz73ln8wy68KfTByNJYou7fv90X9Wx95cmwqzYQ2MFzk/G/L6BxI7/hFWc8Mtr78X/v7gTn
 +EFH84tFxNcM+P6Pq46xnn9iJP2RvUkPQ7qgYqDVnYFKoUTISekPB/9K7crLETplg=
X-Google-Smtp-Source: AGHT+IEiVdpOaZpU0YZv3suUNuzRg1jwBvo/t+Cw65P/lWbFYNz4dkbXN+GA2vQKRSGy7/MdNnwlEg==
X-Received: by 2002:a05:6000:4308:b0:425:7590:6a1f with SMTP id
 ffacd0b85a97d-429bd6a949amr11264643f8f.49.1762175978335; 
 Mon, 03 Nov 2025 05:19:38 -0800 (PST)
Received: from [172.18.140.215] (ip-185-104-138-156.ptr.icomera.net.
 [185.104.138.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429ce80ded1sm9822214f8f.4.2025.11.03.05.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 05:19:37 -0800 (PST)
Message-ID: <4e836608-dc06-41ea-8be0-eb34232b8b60@linaro.org>
Date: Mon, 3 Nov 2025 14:19:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/8] Accelerators & CPU patches for 2025-11-02
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251102181406.51160-1-philmd@linaro.org>
 <6aabcdbb-acdd-4b3a-8652-b9c1cf3ce435@linaro.org>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6aabcdbb-acdd-4b3a-8652-b9c1cf3ce435@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

On 3/11/25 10:20, Richard Henderson wrote:
> On 11/2/25 19:14, Philippe Mathieu-Daudé wrote:
>> Vladimir Sementsov-Ogievskiy (2):
>>    util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
>>    tests/unit: add unit test for qemu_hexdump()
> 
> This doesn't build:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/11947161300
> https://gitlab.com/qemu-project/qemu/-/jobs/11947161195
> 
> and 10 other variations.

Nice. Apologies for missing that.

Vladimir, please repost (only) the test:
https://lore.kernel.org/qemu-devel/20251031211518.38503-9-philmd@linaro.org/

