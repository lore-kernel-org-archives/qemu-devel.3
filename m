Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A900FD3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvzP-0007f7-RX; Tue, 26 Nov 2024 08:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFvzO-0007er-7T
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:52:26 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFvzM-0003Up-SH
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:52:25 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5f1e560d973so984531eaf.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629144; x=1733233944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lwb0v4A0HzD+x7rCMsVy49rE6G46vtMrbFrBP2Svi2o=;
 b=xWliuMAf025eW8GXPgonVvUbsXJCnzFmV1ygKaSVHDiOslNISE/4456hf5Dtfr1BGt
 dJTs+RiNuJvyxQIxoPllSgEpcseQPOo6GhT4z0MP+LuhQylcMXJXQc5S6O0WazCsUSNL
 BgECym8TCupqNO2ZEZ4dFJUTrGk6sbnND7Qt2fRbIc3V17vU4tYPc2JOIu8vsCxaE1ig
 eumVSfXXy8ySQkcfmDlYzwncxQtYueo4+wwK8rX3xHdTgS8F3+h/j3CFj+1tY+pM39vv
 GKNQdJqG1/hsA3webN9EVnHW54R77yogRJdsjskhAaDJfqNhZ8PcEY/uNAtA/F7dR32v
 3wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629144; x=1733233944;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lwb0v4A0HzD+x7rCMsVy49rE6G46vtMrbFrBP2Svi2o=;
 b=cfl4VLM1reH0VargY/+jBw/V3Ce5NVkjeWTo4jAafYaUgvd+FscNaqUZdWoYSGZvaK
 ykrNl0QwSDnAKNgainT2y1UzWJMUVVZ4sLVu4hvPOi04odzOnXybZsGxRiXw4OCu19xy
 311pFaX4V7QakSOM19EigCwlNz2cxuKGb+IZDfKOhrpJ8CmHgsuXHWBtEIi8dYzK1yPj
 nyTZv1XHlb8nNU45Q2w9pBStXWdkzGbk0MpwHw60t4vy9jyv8Cl5+BMDrSmnOtb6M1Oi
 t6CtuLS0eWuweFdLSHYa7Aa8iDP5DGTDGmUJJeFr/jYVP9mp/9k3K5TS/3WZ7ryFnyte
 2/3w==
X-Gm-Message-State: AOJu0Yx+0Hx0J/haMKcvMnTSqMK+RUtUG2HJjpOrsU8mAjmwc8u45snG
 z8CDHhysyBFvtotAp0502mCa1ExZx3IxN+IH4R8k6lXtjlcxbeW0Avr8n0Cfi9Yx4mTbq4rio92
 8
X-Gm-Gg: ASbGncsla9l7EV4KBbs6KI9pVWqhpjbLerOchM2WWYvqbUFe8IByw/ZWa8Ep8WcYZ68
 R2UIrjVCi6QIXu9a7HJ84mc3dWJsORxNy3kezDnyJF88m5X54dsDRpfG8UCNSWXix7q752mggHU
 MZyy2m7xfFoeZb3wtarZ4imdv8affKxFck/+1LQDOmtuiRbQmC8qVT4VFsvV9EpZZzjQJNjcAKg
 iryXDe+8iSzLO/Eec+75mOUPVHaxk1OL40a/tT4hKiFoMhruray9dcTEVfGA6PDhA==
X-Google-Smtp-Source: AGHT+IHlGH4yqFvrqZp55piQW5NNTRcLxdY37FIoMfR0518akRZ+orofLIH6V2HBRjcpkLJsXkdcNQ==
X-Received: by 2002:a05:6820:503:b0:5f1:dc89:fa85 with SMTP id
 006d021491bc7-5f1fc75a6d8mr1783266eaf.3.1732629143806; 
 Tue, 26 Nov 2024 05:52:23 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f06984b14bsm2755726eaf.31.2024.11.26.05.52.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 05:52:23 -0800 (PST)
Message-ID: <0b15a9ea-001f-4b3d-a0c0-b942b9a5356b@linaro.org>
Date: Tue, 26 Nov 2024 07:52:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] target/mips: Rename gen_base_offset_addr() ->
 gen_base_offset_addr_tl()
To: qemu-devel@nongnu.org
References: <20241126131546.66145-1-philmd@linaro.org>
 <20241126131546.66145-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126131546.66145-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

On 11/26/24 07:15, Philippe Mathieu-Daudé wrote:
> MIPS gen_base_offset_addr() takes a target-specific TCGv argument.
> Rename it as gen_base_offset_addr_tl() to clarify, like other TCG
> core helpers.
> 
> Mechanical change doing:
> 
>    $ sed -i -e 's/gen_base_offset_addr/gen_base_offset_addr_tl/' \
>       $(git grep -l gen_base_offset_addr)
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

