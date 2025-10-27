Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF961CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 07:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDHGy-0005WK-53; Mon, 27 Oct 2025 03:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDHGw-0005W6-VN
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:04:07 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDHGu-0004jO-Rt
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:04:06 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso2835462f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 00:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761548641; x=1762153441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0mQVhAXv00+zT8RXAmyYCoi453Zd9I6h6298kj8sywo=;
 b=GB9PR4eRn3VeyOoviYUuj10zjOGXwYBHxxDpA0OS6aFlrp2arJU9Y+IQS1PWY/KsDl
 2i7btoH/lI9keNl7oRSy5FKyvOGbX4nvJVPRwz8tW6fHe964VyTMnaSdG0x4QlD0fB0K
 csefTDqnTPcchEaVUfwfFS+QVZxuQj8+0MrbRpOMZO/M0uf2XlhYdlr6tyST3CksVvxb
 Oca4orLsdD/Z50EXx/G9WKu6P9fKYZEz4xe+5NoNcFUtAJPPfZd0rMmgHACXmW+dkg5p
 vgfESu7f6UaOJFFTOovaFRZ6L19IqwxY9f1ISzvfNLv4IR9i/SLHmTL7foEIrpP07dFz
 TO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761548641; x=1762153441;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0mQVhAXv00+zT8RXAmyYCoi453Zd9I6h6298kj8sywo=;
 b=bxMLLFeFH+F2RUxZm6HiOQPUaUKG42Q94khI/2DuiW0M4PcndJOrM+NXx8nXqM9DoQ
 3U3k2IlRVwv6u+TZfYMKMPsdpaX90FyKUbvue0fvPzrVWY40RvKK2Fr99HYvTlv2o7KO
 3ZSCBC2NTuvhPKeuRFdjIJFQtodu8UmNGqxZoRXaQkdtjROmTwk9JB2sn713uysRvPx4
 nPQwJYHn12x2Ouho5HvdhiDd+L6svonHKjE6QBmfJvKDj3diRJZAbHcJ2kBaRgBG2qMh
 AfNok1bfJwHKq3xuWMgzXZqTySlw03KOg/u+EnYhjDI7vzHsY/eZgaZouloBqcoNbq0Q
 k3SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8N+7K2TW2qxrjz4M9QlGFZ0gTNUVIojwQgy4mTo79TrRfq/9OSV6kEkI4wyymH5zlEPy0Gzxgyib9@nongnu.org
X-Gm-Message-State: AOJu0Ywvtgr7yseGvDbESVEgQrzdhOrFXwolhcaYVsQJyTYNhVchomFq
 ZHNkfE869LMSG54gUi2eAxxgDvTeFTDdfD2q16HRGzNqDMTXtH/aaZI9cOAZG+tSn7M=
X-Gm-Gg: ASbGncvKqkAwr88G7rYulsISqzJD+D05RQMchFoxrZnTdUXoAySPTF7EQSkjO0NNYxc
 hcEtEcigzw1dnc2nhgbCwGlcdCXbAF0cmWCWHyKnwSF27ci3JOsgbndBJDiAp2FzJ73t9uSClaT
 z6IsLt8/3zqSV443QueFBYMN3hFYnonUE4OMdWYiznGYxOFHLL2Mod+I9qbkdyWdTG/iAn6VZtl
 +mNUVFVbiHljKa29gvRHA8VuBh6IVn6cHmA2UZn3vh5dG9zvIM/pLbZT6OhM9+DATep+kiydDrw
 iQSz461ZzFVYfBNH1GafZJE/XQBryT/O4Ec2jCqL2c93M+QFe1DPZqjq1j8mzw/C6WsuvqTr0H8
 yNhkdka81F/UpXKYPdU0h5VOMpvm6n9dLDyIkDeHP8nOfKHS1NsXPIDZxZbo3jgoW0FBBxIDlNF
 y8JrNJqYOu75oNweU3KnyY9CfuukFbnFe+hWxrZgOz1cXfXHseL7NVvqP0vTsYEPof9Q==
X-Google-Smtp-Source: AGHT+IFGld2zldjd7c+w+l7+biv32SRqlhmwOOKlWxOl0UHPTakqRQIzr2YrKc4o7lViqjxFHAUt4w==
X-Received: by 2002:a05:6000:2406:b0:429:8bd9:571f with SMTP id
 ffacd0b85a97d-4298bd9587fmr9011724f8f.23.1761548641367; 
 Mon, 27 Oct 2025 00:04:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6?
 ([2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7b22sm12419255f8f.9.2025.10.27.00.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 00:04:00 -0700 (PDT)
Message-ID: <07681618-1aa3-4f56-8688-30060d8de71e@linaro.org>
Date: Mon, 27 Oct 2025 08:03:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] plugins/core: add missing QEMU_DISABLE_CFI annotations
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20251023133943.3025569-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251023133943.3025569-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x430.google.com
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

On 2025-10-23 15:39, Alex Bennée wrote:
> Most of the memory callbacks come directly from the generated code
> however we have do have a a direct from C callback for the slow-path
> and memory helpers.
> 
> There is also a reset callback that calls out to plugins.
> 
> Like the other plugin points we need to disable CFI as we are making
> function calls to dynamically linked libraries.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3175
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   plugins/core.c   | 1 +
>   plugins/loader.c | 1 +
>   2 files changed, 2 insertions(+)
Thanks for the fix.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


