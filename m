Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B871AC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 11:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twfpQ-00062X-3G; Mon, 24 Mar 2025 07:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1twfpN-00061g-FX
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 07:18:45 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1twfpL-0006bL-KF
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 07:18:45 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2260c91576aso68927445ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 04:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1742815121; x=1743419921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bElPtOoPd6bz5+Z61z6KsrnYhmnmbNko5W0M+/FgjwA=;
 b=crjWreAX6HS3HCmCZZDS1wx5aF6smWvfDGD6S2njec8wGuwPR2MIhp3kg0uCsF26ZJ
 CGEXVzs5dCizgNRXMe55toGjZeKxVqdgb870vLdWSIa/eo7rRH/M4MNuYq9o4cNT5vL2
 UslYUmcmLKBttXsYf2Gsgt5M2bHfBYbQhj2zUYfkFSZnzACWBKUntq6kipmwIF28Yv3H
 gNOtmeg50jaTADN0DjySN0KCBr0GpRjxmse1p+uLA6Z3rh5ANCGt4LRiyrmtaeXJh/PI
 uzqhG0UOL/COu3Mi0ZExkAdhaPd5bwsaVWG1iuq77iKDvDez0cCGVoeaG/5HjL4UbC+k
 uZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742815121; x=1743419921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bElPtOoPd6bz5+Z61z6KsrnYhmnmbNko5W0M+/FgjwA=;
 b=fZDuSMwFd2nAzgTZa+rMXtewq6c2CHcRJ3BU+j1qO1ZWUkBMG51goB9aRVgGrvjH9K
 G1/RmEG+P5nZl/pSEY+eVqOms5mDO54pzGUXYZd3s2TCfPDHpWhi2Z0hqqLhtUGuWEf2
 9Hd21dgqfS3a/KRTVffLObjo96aqbMZordvBDKfg7ZZcnXiAGaZO6OrZegrzberEwQBm
 WkZ2gb2tj+P9OssETxLVLXkrx0jFx+uINnYyDaVAHEA2A5phUlgmyIfc3/X//747xHGW
 YpHga7L+NEje8GDlta2aFGY8isA7xT7aGBW/S/cFVf5/emXhL/eL4zbgOll+FG2aGcw5
 oFog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYro81gE4WT67oxXkxAMQPwCn3DmzwCOyf84yr4mtesCNEIt7fbI+4XILwlME+Pbojkv1cPLCN+qw3@nongnu.org
X-Gm-Message-State: AOJu0YwAIwvr79yW6RO9o8gocezClQG2L7f9Nep40tcUOco+gitTeOY0
 lGwp9EM6Ckpk2A/8kyNx/92CPOMPouquUeY0D2eRUaF9rnr2ulYmKYK1V6XWdns=
X-Gm-Gg: ASbGncs2SgSxWfNYhsvLnzSDH+XiH5PZXFGJlsTwauCL27TzinIi7ayzyYtnOQcX/lk
 gygfsqBWKXytU/OytTn2SvBjA1RK3Wqc+2xyNO2IQzQPmuJv9cbbs/EqTyT4NmuctCCWc9mk/20
 BLBqtHZcuAN7XllJahWBhhpvN51quiinK0oEQ8GA9ctVRzro3Hl7fVqz1LBTxbpDrMNOz3mge2x
 bj/PZ8ZGprmV7FR1jD3JRasTN7T9mGEwhvARRdFS9JGuAWDfSGaCaRtGQ5bKxt86EuEONJuh4iF
 4VriN9mI+3kRT7K8oBVbaGoKuLvMEPgpG67uiTZbynk/AExqm5PDxUTg+ae3FoNpqrW6sJhgqxY
 mJC6n+uZsaZAvwLowXeQZ
X-Google-Smtp-Source: AGHT+IFm38LdfKYVcilHBwY2V7os7PQpqhq05pViY5a0hoIhu2sOluTPFqFkOpdEzw5E3qBLqt46AQ==
X-Received: by 2002:a05:6a20:7347:b0:1f1:432:f4a3 with SMTP id
 adf61e73a8af0-1fe42f57916mr19531769637.23.1742815121216; 
 Mon, 24 Mar 2025 04:18:41 -0700 (PDT)
Received: from [192.168.68.110] (201-69-66-189.dial-up.telesp.net.br.
 [201.69.66.189]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fd517fsm7583655b3a.40.2025.03.24.04.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 04:18:40 -0700 (PDT)
Message-ID: <876d83fc-1651-4f6e-b7b2-38e9da34583a@ventanamicro.com>
Date: Mon, 24 Mar 2025 08:18:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] target/riscv: fix handling of nop for vstart >= vl
 in some vector instruction
To: Michael Tokarev <mjt@tls.msk.ru>, Chao Liu <lc00631@tecorigin.com>,
 alistair23@gmail.com
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 zhiwei_liu@linux.alibaba.com, zqz00548@tecorigin.com
References: <cover.1741573286.git.lc00631@tecorigin.com>
 <b2649f14915150be4c602d63cd3ea4adf47e9d75.1741573286.git.lc00631@tecorigin.com>
 <e9992f04-869c-4485-a7f3-14538a872fa3@tls.msk.ru>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <e9992f04-869c-4485-a7f3-14538a872fa3@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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



On 3/24/25 1:48 AM, Michael Tokarev wrote:
> 10.03.2025 05:35, Chao Liu wrote:
>> Recently, when I was writing a RISCV test, I found that when VL is set to 0, the
>> instruction should be nop, but when I tested it, I found that QEMU will treat
>> all elements as tail elements, and in the case of VTA=1, write all elements
>> to 1.
>>
>> After troubleshooting, it was found that the vext_vx_rm_1 function was called in
>> the vext_vx_rm_2, and then the vext_set_elems_1s function was called to process
>> the tail element, but only VSTART >= vl was checked in the vext_vx_rm_1
>> function, which caused the tail element to still be processed even if it was
>> returned in advance.
>>
>> So I've made the following change:
>>
>> Put VSTART_CHECK_EARLY_EXIT(env) at the beginning of the vext_vx_rm_2 function,
>> so that the VSTART register is checked correctly.
>>
>> Fixes: df4252b2ec ("target/riscv/vector_helpers: do early exit when
>> vstart >= vl")
>> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 
> Is this a qemu-stable material (9.2)?

Yes. Go ahead. Thanks,

Daniel

> 
> Thanks,
> 
> /mjt


