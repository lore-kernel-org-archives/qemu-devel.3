Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3E3C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAtL-0002Pn-Ge; Fri, 11 Jul 2025 06:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaAtK-0002NA-22
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:22:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaAtH-0002m1-SZ
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:22:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so15054845e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 03:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752229321; x=1752834121; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wffkxJKwAsUxiLcwBkMe8Jp0Df+0TjSq3xrhPv4g5aM=;
 b=pu9vPdWfNneV2M6XEn+dAFDfLnfxe/80Ge8BQhzJGALvxegy/ZOyLFihk28Inpi1fJ
 yTsVbVrqGOO5YbIOW5KZqiMAfcAExFGoPWr3GoQauVct/shgBSkttCieDloiyzRG0N1r
 BrInXjbGLhz2V/x9jmcADmBoj74/xWNvZLCKJ1bPV2eyWHwhfz8EX4CCdhIriS+nj0ez
 jDSlRB6pUsKwfNi/rlGLcQe/YZxT8qYyJW2sjtWMT8bMTtM2GeJHA48Kfykx807/93ib
 ive/fh1iET0Zt+/gOQZ02GO7d7COy2Df0OuVyVQEDITiVX/6dPWfxjN3cLtq1ktLCPKJ
 OY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752229321; x=1752834121;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wffkxJKwAsUxiLcwBkMe8Jp0Df+0TjSq3xrhPv4g5aM=;
 b=oaRdpQFCUPgMObNpp1xM14mXgr0RjzVzrmAtcBM5HVrae+mUY5WTkCDbFt8rQz4sco
 kbAeXLW5C9+dQNsQICf9Z92byyElSUR790Mfogn6hLi2JMPE0JZ8SaVHF4XPq03s4fDz
 DRxXRJGno4ENKOuICCg2jKKYUydw063XLlmJpWkoLMbBasSuM+xl+z6e+KMsThSD4GPN
 uBE6pHeqNehT7gka3NyjH5UDhMEv5trOggMJSjqrcWlAdnu6u65Kw+omR/+58gZDdl2Z
 vI7Ti5T+mis0lSPfDYVQXrOJr19N1kqYTAE/a0Ktw/iw/jrt00KgXwA+Wkyv9wa407Zz
 /KWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg6D5qfXgOOMv4TiTIW1UZ4JfvRsBU+UADQVRhafkNR/3RQWEH02ZA1ssbowDd/hol21FTYensyG2I@nongnu.org
X-Gm-Message-State: AOJu0YzMC+U7SI2SCKlfGwZRat5GfC5Xgg84QvknsO9APiQ12u4XFcre
 MsOnSc/XS2rHVxltSzvihRUIMVMMg/E1zNX+VjVIUmOuY5qOFnjnZkZYuH74kzVY7Zk=
X-Gm-Gg: ASbGnctShoKeRgXlGsaLgxjyW72ElvYZYm4raTI31+ESIwucRClhiSvDoHC1Cpf6Dl6
 LjS8khNr6o/EGo1f2oH9eB4AyLhkOgn0PEzG41sdsLuP4Ux4sl8HseJNkb9eidMDgFFwoGx0xgo
 XLr9JC093rILbvuYpX6MjKAmo7AXp9XcZUsMvDGjPzjwSnA/BsZuz7dktpCMd0EpuiVxUBrgl+q
 ESBdtXJbMkHynRyERn2zRjfSQ2FnXIlI2xoLo1KZEvk54ashU4Xrxq7Bd8qL16QHnNf8lcQBdtD
 BrQTl3GW7LOpqptzUL5K+yMopTk3At9EtHor2DE4+qL+dhSvrN2GehGdQAuj89z8EA6fwoumAEF
 3F6ByHzKsZc6BbYWMIiX4AwkAVBXRLOxsChYEIW5IDv1h/iPm+xnA8IxkfMI/htwrc9KhNQ==
X-Google-Smtp-Source: AGHT+IH3pYPQmp2LFwrMK3fwqftxfKvy+Wx5EUFZ+GifghqV9ofSaoLg6cx0b9URIEZfeyp4diVoDA==
X-Received: by 2002:a05:600c:8909:b0:450:d3b9:4ba4 with SMTP id
 5b1f17b1804b1-455bd87a4c6mr12922695e9.2.1752229320846; 
 Fri, 11 Jul 2025 03:22:00 -0700 (PDT)
Received: from [192.168.1.47] (lfbn-mon-1-587-20.w2-4.abo.wanadoo.fr.
 [2.4.165.20]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd181bsm3990246f8f.7.2025.07.11.03.21.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 03:22:00 -0700 (PDT)
Message-ID: <eb62a1c3-1aab-4398-831b-1fb82402d67d@linaro.org>
Date: Fri, 11 Jul 2025 12:21:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x/s390-pci-bus.c: Use g_assert_not_reached() in
 functions taking an ett
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250710161552.1287399-1-peter.maydell@linaro.org>
 <36819228-b4c2-44a7-bc85-f5630c8412b5@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <36819228-b4c2-44a7-bc85-f5630c8412b5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Matthew,

On 10/7/25 23:20, Matthew Rosato wrote:
> On 7/10/25 12:15 PM, Peter Maydell wrote:
>> The s390-pci-bus.c code, Coverity complains about a possible overflow
>> because get_table_index() can return -1 if the ett value passed in is
>> not one of the three permitted ZPCI_ETT_PT, ZPCI_ETT_ST, ZPCI_ETT_RT,
>> but the caller in table_translate() doesn't check this and instead
>> uses the return value directly in a calculation of the guest address
>> to read from.
>>
>> In fact this case cannot happen, because:
>>   * get_table_index() is called only from table_translate()
>>   * the only caller of table_translate() loops through the ett values
>>     in the order RT, ST, PT until table_translate() returns 0
>>   * table_translate() will return 0 for the error cases and when
>>     translate_iscomplete() returns true
>>   * translate_iscomplete() is always true for ZPCI_ETT_PT
>>
>> So table_translate() is always called with a valid ett value.
>>
>> Instead of having the various functions called from table_translate()
>> return a default or dummy value when the ett argument is out of range,
>> use g_assert_not_reached() to indicate that this is impossible.
>>
>> Coverity: CID 1547609
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> Disclaimer: only tested with 'make check/make check-functional'
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> Also to sanity check I ran various tests with s390x guests and a few different PCI passthrough devices using a guest IOMMU to drive table_translate frequently.

Does that mean we can include your Tested-by: tag?

