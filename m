Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF83C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHh4G-0004S2-8g; Thu, 13 Jun 2024 05:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHh4E-0004Rc-7f
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:48:26 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHh4C-0001fh-KI
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:48:25 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-35f0d6255bdso799173f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718272101; x=1718876901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xGhk/spDP89wS2ZNe2S7gyQIoX1ZGRST+KHMCay608w=;
 b=TcmCuvBgtwtW/1OmVl9g/KbgoyErR1u4GY67Roli63JcfrTmsca37cotoZNl1Qe5G7
 6y4gBEOONXtrQS/l0r/YNBAiSmHe5esTKii5pWFMtrv8K+nfjhrJMIi67aMgx/1GXUf7
 9rQ9vITIQ0QeGnPbc9JrHy/xffknLKkTQZtaSE0wZtGiF07BrpIsXTTZOjhSJMGGp2jN
 xsBZXlx7neh4DV0gVPtIveQAFq5XkP2yX8WacB+YOIDJg++2vWa+v50ONG4jk2tCbO8j
 Htaxz3FW4PwYEFP98WqihrJ/Bo2et7H+lDJ9o9CFaDob9y0Gta11FfqKiikBnmMjsIMh
 FWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718272101; x=1718876901;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xGhk/spDP89wS2ZNe2S7gyQIoX1ZGRST+KHMCay608w=;
 b=jR9w9oi2+Kn8KgEO+kwvfKfYXEIbkuxeUSnp0F5BDIDwhd/pWhUSwha53d/81uJNAV
 U9m2U5Fk1TcA07FJ5pjRBzRVNI5jFQ9BLtQH4lGQ5KRC8YRcR8usjqKCicH/h0B5gW2S
 cyWvomgqXKTWM3pxVDlr3miTxJ5VQdhklf6nE/O0Aki5E+mDcYU+FlRysCCyM01v+HRI
 yfMDWDic7oLS3BXZWsmErcI/gHTPwHFtV/V+e8XEZiRMmtbdMCrAHqhVe/PXnBOGZe/n
 6ImrCbXmaNUBzA3MQeaPuB0jaP5ChRlhi2FaC00oQWFVX85zY3ansJq3R/uKRs7sjTQY
 UQcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGMZcFZXqhiwNZaNc+q8brgfQl403ABmZDZ2uZu9aIgO/k5X7hMgtZk597yzLPDcRE4AKlM9Kt7JZBYRR3XAbXaFMsmDs=
X-Gm-Message-State: AOJu0Yz3miyQdntqwunT+4I90yVUf7J0Pu99/zkrDNgXLNoohBz3MZEk
 I2f1KfE/pKLBPD2Qac+g7wNgcRrbe6n5rAjWbZE4j0uN5/H4YAgIm5fgG73mIHw=
X-Google-Smtp-Source: AGHT+IHtjgQTe2IQDtIMBIABZMxKQjtjTUoPz/1QICH4eFhaT1N7pwGoXBStReN3MRQl+BKpHb63XA==
X-Received: by 2002:a5d:5308:0:b0:35f:1e30:f69a with SMTP id
 ffacd0b85a97d-35fe88c91f6mr3301679f8f.42.1718272101107; 
 Thu, 13 Jun 2024 02:48:21 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.148.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104c17sm1174740f8f.106.2024.06.13.02.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 02:48:20 -0700 (PDT)
Message-ID: <c44dcf6c-3e99-4a32-888d-3c7dfc305a01@linaro.org>
Date: Thu, 13 Jun 2024 11:48:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] hw/ppc: Prefer HumanReadableText over Monitor
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240610062105.49848-1-philmd@linaro.org>
 <cd48f836-3017-4559-b509-9945d041a327@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cd48f836-3017-4559-b509-9945d041a327@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 10/6/24 10:19, Cédric Le Goater wrote:
> On 6/10/24 8:20 AM, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> This series remove uses of Monitor in hw/ppc/,
>> replacing by the more generic HumanReadableText.
>> Care is taken to keep the commit bisectables by
>> updating functions one by one, also easing review.
> 
> Did you do any testing ? POWER[8-10] CPUs on pseries and powernv machines
> should be checked. A bit tedious I agree but not that long.

I ran these smoke tests comparing monitor output with baseline:

$ ./qemu-system-ppc64 -M powernv8 -S -monitor stdio
QEMU 9.0.50 monitor - type 'help' for more information
(qemu) info pic
CPU 0 XIRR=00000000 (0x0) PP=ff MFRR=ff
ICS 1000..1005 0x14c03d9c0
   1000 LSI ff 00
   1001 LSI ff 00
   1002 LSI ff 00
   1003 LSI ff 00
   1004 LSI ff 00
   1005 LSI ff 00
ICS    0.. 7ff 0x14c0e93e8
ICS    0..   7 0x14c0e9328
      0 LSI ff 00
      1 LSI ff 00
      2 LSI ff 00
      3 LSI ff 00
      4 LSI ff 00
      5 LSI ff 00
      6 LSI ff 00
      7 LSI ff 00
ICS    0.. 7ff 0x14c16ffe8
ICS    0..   7 0x14c16ff28
      0 LSI ff 00
      1 LSI ff 00
      2 LSI ff 00
      3 LSI ff 00
      4 LSI ff 00
      5 LSI ff 00
      6 LSI ff 00
      7 LSI ff 00
ICS    0.. 7ff 0x14c2177e8
ICS    0..   7 0x14c217728
      0 LSI ff 00
      1 LSI ff 00
      2 LSI ff 00
      3 LSI ff 00
      4 LSI ff 00
      5 LSI ff 00
      6 LSI ff 00
      7 LSI ff 00
Interrupt controller information not available for 
power8_v2.0-powerpc64-cpu.
(qemu) q

$ ./qemu-system-ppc64 -M pseries -cpu power10 -S -monitor stdio
QEMU 9.0.50 monitor - type 'help' for more information
qemu-system-ppc64: warning: TCG doesn't support requested feature, 
cap-cfpc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, 
cap-sbbc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, 
cap-ibs=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, 
cap-ccf-assist=on
(qemu) info pic
CPU 0 XIRR=00000000 (0x0) PP=ff MFRR=ff
ICS 1000..1fff 0x600003b05b00
   1000 MSI ff 00
   1001 MSI ff 00
   1100 MSI ff 00
   1101 MSI ff 00
   1102 MSI ff 00
   1103 MSI ff 00
   1200 LSI ff 00
   1201 LSI ff 00
   1202 LSI ff 00
   1203 LSI ff 00
irqchip: emulated
Interrupt controller information not available for 
power10_v2.0-powerpc64-cpu.
(qemu) q


