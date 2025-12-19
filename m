Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3D4D711CA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 04:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWS6l-0001uc-1d; Thu, 18 Dec 2025 23:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWS6i-0001tQ-8U
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 23:28:48 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWS6g-0005Ik-Jv
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 23:28:48 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso9799275e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 20:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766118525; x=1766723325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=svposOKBgnzfELy1cdjGmGbJ58Ovq46Q3Jj55N7SiRM=;
 b=kmKRKoXw65A8/7xPNEDCyuJxGUBpFGloXvoq8IrvNlWjpbQ9HjIaivcmQkzOydivnq
 DRzTFPcrXj5CZhWaEF0phpeEi0q2EMnNIJGXqaMyezz86dUKD9FCfb4iiQntEnx+dN8L
 vkIDsS98NNOt8hWVQKKCfrxu2u8OpRi2HACL0Jz+EkSLoOJQtt8AgK1GOdJeaolYu8Rb
 PHss8mYh/4G5DAGdBjWlsiXQ4LaM2nfTYYGqZS9cOis2sQbXXrOm5aKsnoE1jMvAu4Yb
 m/StYIHCdw6GD7qHTZ7PJokgWF4KBcQvGybzSkKeIZBfb5k/rMvgi2oPbrS7wlXbhRQ4
 6T4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766118525; x=1766723325;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=svposOKBgnzfELy1cdjGmGbJ58Ovq46Q3Jj55N7SiRM=;
 b=ugyrC6g1IXIaewR/CAwchKH+U0d1yLAnyevrENJ/eTF7uq+IkiYa3tNQEfw0S0f0cg
 xNguYkNPe+3l+LylbJP2o9tfnDk1BrGbri9G0A7WRzbv4Sh0I4gn3GgJLxnwAsQ6rysO
 3tHcFdSGrJOYF8yEftuDFq/KQPVTk4tWdIN5l+7Y++nx2dgbK5iPv0x1krGic5pUfdcV
 0qZpdQXOodfjT4d3Zo/9XGphXMZVuhJQQqGMnN0fWAthLB1yiXfEXMiu0H9+BVNa8IDA
 bhu2nK27X1kIxF5Y+/pcq15QJfyeWHWWhVwuvq2AgG0YSWEEw7BnRuJuf9LYlW0BzENB
 V7Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1r/kvF907RYM/IeccLNHt6qhvG6JtinPKvKfK/sw6ywnle6eanVhnqsKSM609EWDyLTYc5vhPZP6i@nongnu.org
X-Gm-Message-State: AOJu0YyUNhn7Yj06ibQpagkR8a+Z/7Oiape8PrGc9wh2UgiV4L+y9OT/
 9qk2HWJ/BqFsO2FvsaFSsxwy3nKBKc35SpDfheNYIpSRz/mkeOLXZ6vH2nFqFw8OwXM/K1mzSRZ
 5nscPB1M=
X-Gm-Gg: AY/fxX4MhCTAPFSLeC+8pIHHCn1SRrGrh7naSyFl1bIFXZESQpZpGL6ImS2CBdcpiLB
 SP2ryibM3S+G/ToBOyAvyCbM51wTQ9R6Y6A5nfJdl3DfBAiFR+jE3y5tacPXeGZ5VK0RxyRk+OG
 yc60V38kGRlEJDeA4buUhYsWuurfix95MBEKM8gO4gX4dNrVja3vFhrg9Lk7aYD2wFDJlaDJHGW
 tHj/DzTmNnDvTiditzpyt5uDTGjKtnBcS8aRHZghSc/2rQSTulnjg1hULlB8uoE1E3j59oPi0wV
 0gJAJlgIlvHtMNeidpHL5cLDMTHHxs9CC3z9pFNVWp6o5CZBlMTuz9a1T+nNw2mbiZ90FJ6XGUW
 Q21OVArvtUrhidvwGmSCr7/NgeQVMCJyJ5GKBCZ7Y9ixKfWVXr8wqgZgoSWUq5IUZS8sXVhNWZ+
 VUGnhEhVB+oxYJOOEjYqNaqBl8/Tpf2Ord2C7b9WLGOCuOdAx3O6sOoQ==
X-Google-Smtp-Source: AGHT+IGvIlRKWC95m/TcGBkdzbaCM71DaXe510/9FD4kP3iiVHXD4ULbJdSy0YF9W8JeIv4vTrHJGw==
X-Received: by 2002:a05:600c:35d1:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-47d1954a165mr12960325e9.15.1766118524876; 
 Thu, 18 Dec 2025 20:28:44 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa4749sm2519390f8f.37.2025.12.18.20.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 20:28:44 -0800 (PST)
Message-ID: <5837fdc7-f74f-4677-ad90-84c2ac52f970@linaro.org>
Date: Fri, 19 Dec 2025 05:28:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Remove unnecessary zlib include from
 qemu-file.h
Content-Language: en-US
To: Chad Jablonski <chad@jablonski.xyz>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20251219014512.387773-1-chad@jablonski.xyz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251219014512.387773-1-chad@jablonski.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 19/12/25 02:45, Chad Jablonski wrote:
> Commit 70eb5fde05 removed zlib from the libmigration dependencies but
> missed removing the zlib include from the header file. zlib doesn't
> appear to be used anywhere in qemu-file.h. This is fine in most
> environments where zlib is nearly always in the default include path but
> breaks the build when it isn't (NixOS for example).
> 
> Fixes: 70eb5fde05 ("migration: remove unnecessary zlib dependency")
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
>   migration/qemu-file.h | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


