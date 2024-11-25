Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B013D58D4F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZrV-00037e-8O; Mon, 25 Nov 2024 09:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFZrT-00037R-KI
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:14:47 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFZrR-0007iJ-Tq
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:14:47 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-29687cd1924so2317135fac.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 06:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732544084; x=1733148884; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UrL/dIBt9uTBdBmadV78TEVSyml1Ukxh7UYu/YNXmzI=;
 b=x/SLVf67dSHa2B1rnP6M8nnjpwV3uJs0gBHbjW4eaZXBByIi+YIxYRQnO2oCMfGvH0
 3i1EATjX8RKom2EZkzmOhMHDcJAlg4cKQA0qrfvL6A/LsU3+aqdyoHEtAxqqYa65VQer
 pEdRNwMOHkDPtFA4SsBoK6SsfIEAhAEATOtCNeAGGTUr56Adq46aiqG92Me10Td0/k+j
 KLotTb2L1vkJuX0Mo46vcSRpf0+aEhvCUHFR7zXEJjGArdgKVBjhPUTByGixeonnTzWN
 F/n+kHASAPULEwLIovWRQraYH/VK/ZwkVPIGebzM0cPZkQtiV2KIx6csI3wipJWWeAig
 A+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732544084; x=1733148884;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UrL/dIBt9uTBdBmadV78TEVSyml1Ukxh7UYu/YNXmzI=;
 b=Fac6+CNHkN3BfH9rwM9aMvx4M4KTxxeyRv+JO7QDDkhKcyou+PXJAzeaKU2grS1JJ3
 Wi+jlikXIE+DPwhU4lcR6bHNvNRx4ONhM8r9OeH2vxLQJj28/wDeKaJQHkWd3o6MhbzQ
 VkqXgJsbiZjGUtXqUBnGUixwZ80Sn8DJrhXhNyTOqWsPYoW5M3kQ45nVNdznqmi/7Urt
 a2NF3teXlI/czR5jS3wYsgd5Wp0CgjF+sTi1b6sBsudXXhHSP72DQBOlEdulQVw3hNpN
 0GLFq1K0PsXg87Ivlq7QIDI8mh58/Y/G6FiLlhYOnMAPGN6cIGfqbKK3C997R1gWwJ0Y
 EvZQ==
X-Gm-Message-State: AOJu0YwyfEYtUue5UKVdiuLxOG706dcEwVC4lT+MzRToebw2rMXempPj
 5zvc8o4g7hzYOzjRPIpo3F9u6v8R9nf4WyCixdSAChs55i8Ncnfrk2GUveWAQetI4oytM3EUmDh
 vYak=
X-Gm-Gg: ASbGncvzwzSWmqocMbSjgP77XnivLrFQ5CKk1PdEyNh6rPVtfuRXumD8h/CfKRXZT5r
 BkEYKcCSRZG4phzx+6ckdSyEQ4RI7Z6HGbRuxik2BtKv3QOGzBg4FYbG/+KfS2OTOd9QHFcTpHH
 CNdUdNC4+uE3FwYzq2hfS3v14uNfrHYIA6c3yPcLOXOGexz8C4uPNcJRbkbtFbktaTWjZwe7uTr
 nACLctnLnJ6FXUpE+SHKzqMLWLWjxsZE1RnZeqj2SyGtS/z7uGrmNjTKXVGwQvetQ==
X-Google-Smtp-Source: AGHT+IFnBmzGbieqHT02wRLOscyofVUfyz2xF5UR/5gtzTNlHb6V0KpoIXBAZifpUW0eTXVPsYpJ4A==
X-Received: by 2002:a05:6870:d113:b0:277:c28c:147e with SMTP id
 586e51a60fabf-29720d6ef33mr10737745fac.21.1732544083331; 
 Mon, 25 Nov 2024 06:14:43 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71c0381e282sm2339254a34.48.2024.11.25.06.14.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 06:14:43 -0800 (PST)
Message-ID: <3b3e2723-9489-482a-b08d-09915f04fb0d@linaro.org>
Date: Mon, 25 Nov 2024 08:14:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/aarch64_virt: add test for FEAT_RME
To: qemu-devel@nongnu.org
References: <20241125065950.1179068-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241125065950.1179068-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

On 11/25/24 00:59, Pierrick Bouvier wrote:
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Welcome to Buildroot')
> +        time.sleep(0.1)
> +        exec_command(self, 'root')
> +        time.sleep(0.1)

There are patches on list or just merged to allow matching login/ps1 prompts instead of 
sleeping.


r~

