Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF39E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaRz-0000C9-5m; Fri, 20 Dec 2024 05:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOaRw-0000Bk-0h
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:41:41 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOaRu-0004SH-KD
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:41:39 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so1121369f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 02:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734691297; x=1735296097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RfyElAWcq+Baw3j3YI7gZKswU6v3RXlA3HsC1BbSqHg=;
 b=wKqtj5WNrmabOPK8UkK+P5CGsYHuBAz//rALnzFcr7Uaer57uD35TDWQaRy05o7+jB
 cJ4f7TaEpmsbd5t3agWk6zaZUiTuw1MOEgWnpcyjytLq0DA5cgjUXsBGkE7Jpk0dhOyM
 sAZBSb8ry82KCbn8k6Ypp4QRONBEZ0FblwNRZT24LT7CB+V1spr7cfQ5aCkvo0Sg4E8y
 EPuq66X15XFYS0OOnBbxMbPdINtQjWp8HrFN1m9Y1ZggLdgpSqdD7QdI/kEsPKBS5uu/
 Azs+2Lh5zhgF4qWTOm+XTExFL4NF5uHljT0AHdp3zF2BeK9pFUBR6kzYXfxK/+o3F83v
 eP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691297; x=1735296097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RfyElAWcq+Baw3j3YI7gZKswU6v3RXlA3HsC1BbSqHg=;
 b=kvRupxnq3AwHDlKXPbMO97c38IPXkODM3BL4Cq+HLxISPoQq84vySnw3L+wgxItyJm
 e8+0S81vdT8KfAtkxskLmmXkWZlVZ1RbcQ4eEGR7Ql2C6caFNY3686Gs6YQxJ0mxCSY8
 tOmulmbAIBZ2qwQMIzAHjc/ld3/IxxRwfV354nupigGp03RU4RBpP8O78YLZ7OviK/N0
 Ky/jaN5+cV35FLjsvZCPT/jQ5BbnQuQZ2QzPNKFD7xFiJSEHOnfP4NJ5BStNpz3E6GiP
 aspL6wesvRkHAjJPtfVa4Se0D45hXNh3aUjDK57zT/e1UcM/3MlIwgiAl7HI1C3M4F1l
 bZTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj31DsewySzFScDlGcmH6jTwjzvy21fgucKxjEl8kYlK8My65tZNuHfEbAiD9wOrnRj7m2oSpVZ+TA@nongnu.org
X-Gm-Message-State: AOJu0YwZZHg5HTPCNejEvveh94MQtupnQR5vMe3aNtAAiJ+jtL4oK3rD
 MKal+kn5g21nFKnVqmdu5Ile6VeOiKkbHmQnzrrJc9KFST0VSiWI14/LDfRftPc=
X-Gm-Gg: ASbGncuU5yJ3HVOe/UlSl/6KdJJnB24q4CVYv4hpcDWIhmxRICYOWPZYnif+CYph04y
 nrydv1OYBSrmzrbt4R7zNUlV9Km1NrwrEzxfRI2Pmqf2wytsIRjTJD4jgeZqoX3hhZWHtTu5ZK2
 fbZ3zvkoqSXCsuJSIOZOqOC7uDQHglh7pCeLl+x0/IA/sKLEIcZCYsDUnxiiVigaAehDvM5j+OZ
 3e+2Lw7zrHngiL3Hjc9OgzCg39KMCzXPTgx8GULFopbN4/hcFYz19dnEyCCCInu8xTxNok=
X-Google-Smtp-Source: AGHT+IF5+nnSWggpoRwnFE5zB6imaV0635y+T09UZmBXyn1pbyC6aoPkgo2PE+Sc2+j2DJj1V99nPQ==
X-Received: by 2002:a05:6000:1a86:b0:386:3702:d2d8 with SMTP id
 ffacd0b85a97d-38a22400b0emr1996244f8f.58.1734691296698; 
 Fri, 20 Dec 2024 02:41:36 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a8d32sm3747206f8f.99.2024.12.20.02.41.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 02:41:36 -0800 (PST)
Message-ID: <2964bbb9-8b13-476b-97b3-45f860b4d1d2@linaro.org>
Date: Fri, 20 Dec 2024 11:41:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] qxl: Do not use C99 // comments
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@redhat.com>
References: <7d287eaf00e0b52b600431efd350b15a0b5b3544.1734633496.git.yong.huang@smartx.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7d287eaf00e0b52b600431efd350b15a0b5b3544.1734633496.git.yong.huang@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 19/12/24 19:46, Hyman Huang wrote:
> Do not use C99 // comments to fix the checkpatch.pl error
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>   hw/display/qxl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


