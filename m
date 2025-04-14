Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273BDC369B5
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 10:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4HQN-0002bQ-7J; Mon, 14 Apr 2025 06:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4HQH-0002ZU-5T
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:52:17 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4HQF-0007n4-LQ
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:52:16 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso2229560f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 03:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744627933; x=1745232733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3ZrqRr5HPjC7mQLam6H1rwgMMkgsj7fVAo7GxFBLLa4=;
 b=FVUDjm17nJnv8Mbh88kaY0tSFHr07cB+IYdPm+lRhqk+XFydsgzrp9IaisAyV3T1xo
 ku+Awd/57vU8zzEUsxEDuLEcYaaTMte03ph37vQWE3e9DTeXvuxK/8njfiRswYHn0alX
 c+xn5GeBR+ZB3Td45HwpUxn3eDXuyvkbABNhN/cfCZwY+nL8EB+e2NyFVIVqlO8WL0iq
 pTIIxfd0wrhySakWUziQmlO8BpFDtsUVOz1FT4lxQ3CBUbEc1+WrauFQ2ajMEpe/gCKc
 8BxFZFH+zWrpwWR0BJ2c5n2egBLehHxvQdXOs4WmAk+vT1aB2wCyK3Uo1HQVylGIkgP8
 ZWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744627933; x=1745232733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ZrqRr5HPjC7mQLam6H1rwgMMkgsj7fVAo7GxFBLLa4=;
 b=qnIdXSKK0Pn+XFmY7edu4+iZdbgujkfr/7l7/wz0/55rbFzDh8W41rQ8NvWAIE1usj
 5NvQhMa5nk1OAJL0934dIDBxqUsWAlqfd5cqGktQ2PLST5GkXAOZu4wStDVJnMkeW3EP
 nrxp02rGbZRjUZXFqbcQWRoSl88kbK55OhCmDfdIQ6I2K6ozFev0dn2HUpWfDnYQZxjb
 bOLd2KYJfiv4I1zdkB56xPl8T6ZioQGFpIN0adexOPfsD/gI/7o6O/Cldh6AqHLKPoNa
 cp42C3OY9g3Yu+i4PwVa0ZoRFGyquToWfIujZ/dCSiITwHqrGK2ASJ4q9ylcAc5ilNCp
 5RQw==
X-Gm-Message-State: AOJu0YyWLWr2O/PY/FvtqFr+TAjFH5xwK3SXef+DQddQTVUgIzRwnWOk
 9QEbqRSaDu9/IpY+Pw+XL+Qf9xLwROX0rN0MV1iXSf92OIiRov32SCuHn0I0KHIGoGTHMQCsTM+
 C
X-Gm-Gg: ASbGncthgSzJ5iQgWs2LN46sw/phBgcv0XzdbSxkcUJFn3ZT2zLsAhOYujd+kvYABAr
 qxS+5z0MdGrLVndV7yepqbp7PT7dCrYG9T0+aje3avIIB76i2+9t3hh9382gOWW7fFcXuvPkJaG
 dOkF3jezk7pshA0Z8V3BqLeZndKuGCnch2xjHY5zTS5q+Le1T5LWkD2q1U4Q1aBy1glrQbb955f
 7FcWr6ebYqXlkqzU03sVsC4A1lNWpQIgByu7MvJ9ar8PAJlup13+Vse+JqCTvVC/6TSdv5ZkG4k
 yiLpDY+5bO83AoIq9txx1KDcp+D5e+5zH9cU5aimp/gFwzeXrdPUO4KDfL+k2fjBJCjhP5t79Oa
 TDOI/n9tn5TwZSEofHR4=
X-Google-Smtp-Source: AGHT+IE1Vkt20mP/0fbEm+TKjleqaY6Uacix0pOns8Du60ZHogi89K+1ktxm9QWDrMu0J2Wm1XFAiA==
X-Received: by 2002:a05:6000:2282:b0:391:39bd:a361 with SMTP id
 ffacd0b85a97d-39ea51f5a3bmr9118452f8f.18.1744627933187; 
 Mon, 14 Apr 2025 03:52:13 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae979637sm10810593f8f.53.2025.04.14.03.52.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 03:52:12 -0700 (PDT)
Message-ID: <af5ab3aa-f72a-4668-aa64-ae09755f0e58@linaro.org>
Date: Mon, 14 Apr 2025 12:52:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/loongarch: Code cleanup with function
 loongarch_map_address
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20250414012528.4075447-1-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250414012528.4075447-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi Bibo,

On 14/4/25 03:25, Bibo Mao wrote:
> Get physical address from virtual address is important for qmp command to
> dump memory content. In TCG mode, it searches TLB tables firstly and
> then do page table walker. In KVM mode, there is no TLB tables and page
> table walker is used directly.
> 
> Here TLB tables searching is moved to directory tcg, and code about page
> table walker is put in common part so that it can be used in KVM mode
> also.
> 
> Bibo Mao (5):
>    target/loongarch: Move header file helper.h to directory tcg
>    target/loongarch: Add function loongarch_get_addr_from_tlb
>    target/loongarch: Move function get_dir_base_width to common directory
>    target/loongarch: Set function loongarch_map_address() with common
>      code
>    target/loongarch: Move function loongarch_tlb_search to directory tcg

Please check if changes in patches 4 & 5 need adjustment.
Otherwise for the series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


