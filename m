Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB641C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ect-0001Ax-9S; Tue, 29 Apr 2025 02:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ecr-0001An-KN
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:39:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ecp-0008UQ-Sv
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:39:29 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso34892985e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 23:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745908766; x=1746513566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7CZYd56vHvn1lrT9u9XP2P09UzewUsazyPj4YfaaK5w=;
 b=XwW8syNPz4XdnPKcC+qhdmVRH6RJq+bp8QAQ5rk6fQ6ibZN29i9TfxYITrB5l9pLzj
 wULnlanROGIu4U6BGi3teKGvldq+7UAtSSNJoiPah9XpcLNMNYSgzd4xmgw6TQuhBSwf
 If1YHhNrnfSnG8Y4B7+9psLIZlkpCAuMSKHvw9ZOExV5GGDwFixDMfvKHptA5cBaeIaP
 srCFQqQ9rgzKDfPgN4aEU/+73wgO2Z5vWVzlu6PC4GBVyHqIzVpUcMCnZnpU8FAKxffi
 kAptiAWeFcuR8fI098RnmW4iXpB1GC78FU3JMcxgrC+fZV9gfDrin5p7hzzC+4XWeDQQ
 W1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745908766; x=1746513566;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7CZYd56vHvn1lrT9u9XP2P09UzewUsazyPj4YfaaK5w=;
 b=jRSBxYVkiMWbDnFOb2UrhR4o2U3BKtC/4PS8eHOInsGNXxSSL33f+5wWwYsLsaxfTX
 71fufvvcwezCJsZX75vM9GcpK3llmXaoOZzm8rByaxtCDxz7Pknb1Mh1rSIN0/1uRiqC
 eOR15RXRk8uFR8kShTKFNGeqFVjViFsjQnbry4nsF/CnFfbc65V2oI8Oa5K37CDT3Df/
 fz6Cj6xAASKmJGxOPxXbTvTJtO2faWcQnv+JY9GFapJaW10Zy0aBsTHHetfc22AK6yRx
 w8qaVCFHk9nUwYlzB9EfCottfu0PMDx+aYiO/YgNXDWJ2iYDlvkRJ/Hw6odbVfwE31Rq
 TDhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw74CVgLeTVaRzYlu9VWTrtw5FLatOz8bp31eBFkjGQAA6SJ7Q0+aG1zukjcGOozCKct6C/nkIqyUu@nongnu.org
X-Gm-Message-State: AOJu0YzIuN4CGQn4CWmz0gb4fjawAP9m8FTYM/+lGcfFL3DxbXLhQYd6
 kzWuOR8Hb9AbPxmWU7HEaunWjOrH/dAA9CjNLCbGka2exAqGre9D+rhlMj17kaA=
X-Gm-Gg: ASbGncsnScD/1qGItZ8TDQDs86mJ9P78WJ8j1AGVz6dUU/LefC2zRmpNbqi2aS9+clL
 WcLghmyFwvptcdU3MmgFpcllkuQ2yVRurIaQMIA6h1yJPK9+XE4fAnjE5mCvxiuIp5YwObBN5x6
 d52EE7zJ73fP8esQP08WSNj7aUb7P7qJOWIKqe8sPIknS9GUJBBZ9wc+T3Bzx7G10eOFeGB3dgp
 g7Sv/1lun3GKVP8z6NfI/x4MYqLFadDp3aP/sucEscsf0Ak4sAJ/+FtHtDyV95vM5w0yuZ/JQDk
 wbCZv73JcWJFyqZyf4pjLl7c0PHDAy363XOqS4OUKwzbz24kBNNNMwnf+q8rJy4bNkKc2f+zvgL
 tdCEqg65Q
X-Google-Smtp-Source: AGHT+IF4GLcJSz4zrwojALsCUyAA6p6MgKdDitZvHS88PsjcN+ltYkxjgw/hGYqdkbv6G871z9Bo/A==
X-Received: by 2002:a05:600c:3d0b:b0:43c:f44c:72b7 with SMTP id
 5b1f17b1804b1-441ac859010mr20222825e9.14.1745908765939; 
 Mon, 28 Apr 2025 23:39:25 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca5473sm13180843f8f.31.2025.04.28.23.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 23:39:25 -0700 (PDT)
Message-ID: <39c6c35b-f483-4313-977d-544ad5946247@linaro.org>
Date: Tue, 29 Apr 2025 08:39:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] target/riscv: Move cpu_get_tb_cpu_state to tcg-cpu.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250428201028.1699157-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 28/4/25 22:10, Richard Henderson wrote:
> This function is only relevant to tcg.
> Move it to a tcg-specific file.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/cpu_helper.c  | 97 -------------------------------------
>   target/riscv/tcg/tcg-cpu.c | 98 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 98 insertions(+), 97 deletions(-)

https://lore.kernel.org/qemu-devel/20230703183145.24779-9-philmd@linaro.org/ 
;)


