Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB01C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 22:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thc0v-0001xY-Eq; Mon, 10 Feb 2025 17:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thc0f-0001dp-5w
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:12:10 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thc0d-0001ER-Dp
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:12:08 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fa1e25e337so5984393a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 14:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739225525; x=1739830325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QqmxHfGf1ujzhqbDSxyygIhwXCXDJev2LskftYaJDcY=;
 b=pLasVdPfAuglQdcCfLcNoMXIsEnplbKTAUG2d0QkTjhmISP0wy2LW4dbATzPneLNb5
 Wi5bGMPI31k2V6CbmipE1wJIpLHjiaVZrVFAmRx+G5SI5vZLCUk2Y+7tpmiO5VQBm6V2
 JtIRsnB8zM0rqLI86488XJiGkpAWr0ejGZBa9gANVdo1Ww+G9xx17uLClIbsHLqUbNNA
 rvC381DCc9c0xQ82kJAAbdpHcyp+h8wbQX/bbksg0lpjCpdsxW0fQianzuVJzG1BssVg
 4QHRVIlPYgBwaBJ2TwvsswP7RDjqPKj09gOOaHBpACncPs0vdWTIZ7kD7zpICqv90/sp
 n3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739225525; x=1739830325;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QqmxHfGf1ujzhqbDSxyygIhwXCXDJev2LskftYaJDcY=;
 b=FVuOfVMNHN3aw+IB3GuO1Btu4DgqmMjh+caJBkv3weoPzIM3aYvxj1jGzid/D/h1s3
 wQlZ/pTePI8YjeUevDf6KMhA1Wa3Wo3ol1ZwsLTgopUbHCbCX9qNQzne0qNNL/T7jBsP
 kHgJTCAK9PTKaK5h/SPsw/DJxvOAgL3Vz8WKRI0UdxdEXMyWx8VCPLhr8EJcIDZffdQq
 XXPL4LYG9yBqVWtImZKUSMBNgbFjCSqeYuVEvY7DYzwOJgj6/JgJBKYMAZjezcIGI1VN
 HjwH60512zNKyfbpmleMuD0hYyfvrAcYUi8HwDu+QnZyTJeCFbP+PdeBWyaa8EyN7Dnu
 SCxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3co48z0GN+vN0RgRKcCUzVkqlw5yVbVEaD/uF3K348ykxTGP0eT+qgj0W/z0b8exw0drhnKZ9MRfq@nongnu.org
X-Gm-Message-State: AOJu0Yx44yMopPlx/EwcJmIeUegzGWz64SZ+E+2nQo0u+3YSCh1ZF1zA
 tKassp+8aTrEpREbLBtG/sA17utBRgZEa2kLc4dUToTuejjVgOEJ5nCUrDblqRE=
X-Gm-Gg: ASbGncssL1KmYV3r1bBtB1UFR+uCgmJqgArR6lyzSxCC4+3fP+lnYLTDytYF45X3pr2
 dRKZDqbMpyQhXzbraLo8SHgKkzUCvr+X11iO+iywzdAcrIeGddLjabz+UEvkY07qrpx0ErZnCog
 RotwC8toVLsoK7zqHti7G8c6rg5ArRxkE1PlnfdVBfb8+jn6ukXz520a7mYaA7BkO4mshzSFOcg
 7/N79N6SRoa2eBA0g6QOH0TfXYjXwNFpInUXAIFYCM9u+KgBtNs1Ai8VBF19j2GTpKbMV+sDe73
 Fd38MHd/g/K3cp0869xbP6jxPF1guznWacfURtPjVexBYVmYxLZUzCI=
X-Google-Smtp-Source: AGHT+IGugWr1GoxPCxVbHDwVXDU0LtlrYPIXrm2BNdCG2VIeN117F9rX3cF5HMh3upEqa7oAblB1cw==
X-Received: by 2002:a17:90b:2252:b0:2fa:1a8a:cff8 with SMTP id
 98e67ed59e1d1-2fa243ed2efmr22680571a91.29.1739225525308; 
 Mon, 10 Feb 2025 14:12:05 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa20eba0dasm7782809a91.45.2025.02.10.14.12.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 14:12:05 -0800 (PST)
Message-ID: <fd3fba28-ea24-4ecb-84a3-2c9a84bab68a@linaro.org>
Date: Mon, 10 Feb 2025 14:12:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] target/mips: Set disassemble_info::endian value
 in disas_set_info()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth
 <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org
References: <20250210212931.62401-1-philmd@linaro.org>
 <20250210212931.62401-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210212931.62401-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 2/10/25 13:29, Philippe Mathieu-Daudé wrote:
> Have theCPUClass::disas_set_info() callback set the
> disassemble_info::endian field.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> ---
>   target/mips/cpu.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

