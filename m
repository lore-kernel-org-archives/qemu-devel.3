Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDE4D68BC8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tByQa-0002Ik-Qr; Fri, 15 Nov 2024 10:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tByQa-0002HG-13
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:40:08 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tByQY-0008Os-Ch
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:40:07 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so32664061fa.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731685199; x=1732289999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QhTFRcx85wE8fb22sEvb1aiaYbywPGbGhYYO1rv3drs=;
 b=FPEuEO0+K2LbQELAo5jjEceDPDL5d25T9iN/NMfQY6d3qWNj5VVdipOlSe9OrUVTDA
 9/o77M73qn1sKdHKE6Yh1DmTBgUWVqn+FOwaFoZVorOfrjlSaUSGTPAsHwMBhg3Hmjjb
 YUhm9duye2Eh4r3F6JKPf9PafH8HgEtAuqV9f9jtcWSiPKQzOvWi27jMAeNrL1JIlFi8
 lj3iT0sHw9EUUurgtnvCQGzD/oFnVw5O1RiPwA6k62t29aB2HdwIWt3WaFheIYoCN/P+
 m9c3N4qi5F7Fccj9JQ2awpkdgll6dZy15ac5bDFo8YwdMa+ucuUl4MsGAggNff55MREh
 FexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731685199; x=1732289999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QhTFRcx85wE8fb22sEvb1aiaYbywPGbGhYYO1rv3drs=;
 b=A/Sbdtv/DRJqkP0lTfseOXKjBQ+BzXnM/4tZ+wZjEJJhWAuIN0j4KeqzbmGMcxG9AX
 kGWUOevovxYknHCSj6+/YVevxKvhTxBuU14LRV3QfATnZJ4rcMjckvMocIjSvVFuo1De
 +BjQNHtnDmSyAdE38LnfazNnrt+4b/C0pmrCQC7X9K36t7EAtuFicle6iiDjuy5hHsHb
 OKHo1SLgW11QvsNIa/lihYX+FxrIVOwu5sSY0R5wuckAPxyD1nzSDx5qBXfgB7WmqUZN
 q7bMVgq/lFUFd3veGRuGAF0TieQdxDLqk0z5s7anaizsl+yjxSkwM+aqsdNGWdlz/Kqh
 ZUpA==
X-Gm-Message-State: AOJu0YyRlIvy788/CW2s//caWzuseAVACI8laRIa5B/eApzt2fXvf35E
 h7ljKethcWofRy6bzM8NCrRSyBhvDDVVaoOYXVJd3t0rj+HZDT7m0Be2t2A/hg3lo7kz2ws2O65
 C
X-Google-Smtp-Source: AGHT+IHl6GkVdEMD0pwoM3BkvTp/s0spMkM+Gn1mBVHazdxcJ1GPkbBj3c6pqEbMVaTvlZ3JQNnY6Q==
X-Received: by 2002:a05:651c:154c:b0:2ff:5645:121f with SMTP id
 38308e7fff4ca-2ff606fdbbbmr29819151fa.40.1731685198776; 
 Fri, 15 Nov 2024 07:39:58 -0800 (PST)
Received: from [192.168.69.174] ([176.187.214.209])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20dffd7e7sm189513266b.119.2024.11.15.07.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 07:39:57 -0800 (PST)
Message-ID: <09687c31-cc47-4166-9b5a-09308c8dff24@linaro.org>
Date: Fri, 15 Nov 2024 16:39:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] target/mips: Convert Octeon LX instructions to
 decodetree
To: qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241111222936.59869-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241111222936.59869-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 11/11/24 22:29, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (3):
>    target/mips: Extract gen_base_index_addr() helper
>    target/mips: Extract generic gen_lx() helper
>    target/mips: Convert Octeon LX instructions to decodetree

Thanks, series queued to mips-next tree.

