Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1944C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 21:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD8Od-0007xE-73; Thu, 08 May 2025 17:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uD8Oa-0007qe-UA
 for qemu-devel@nongnu.org; Thu, 08 May 2025 17:03:09 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uD8OZ-000215-D7
 for qemu-devel@nongnu.org; Thu, 08 May 2025 17:03:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so1240553b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 14:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746738185; x=1747342985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vuhTbHFGYK0QgHIF5cYt1w6KuugZ8hE/iTA0zbQApWs=;
 b=gcHXIi0sqVrYSuAR9OSkJ1U6mIcqVjouQoGJSY+XWRdPiA4hCHHt5jM4h0+MEyutUn
 rtMVmsM6jT4Jz7indQT0hQFxzhMC8+vUC0XDkGr5qEgYCD189DzMj5eVnIBNnFWcmM5P
 bVOMfznMIJwsE1yxQxkPAik6e7Oyl2lIGJFe/qg9zi4bq0l4XMYEyIf30kTZEz+x7dMe
 PDbuKlopeKqnqJULpiTuoXTai2LgaMvyoM7adIbyHnm6dJX3kUAaM5fjN6Jw6oJCTHto
 NHXp30w3E+LZN8PBY2qfJ7dxryKZ5pxU1epAJKO5Ev2+lnwETA18n9k82rhJFNdC0b/c
 l4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746738185; x=1747342985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vuhTbHFGYK0QgHIF5cYt1w6KuugZ8hE/iTA0zbQApWs=;
 b=RCNYhWO49mcDSE/ChUrxANy9qhlJs25Cs/koZuCgpNC8SefUzDr+Uar6hCS+32Y6YN
 Y2G+s8d8FlzFevsn17aspOQMqPxAlmZOyMVMBmqxwAhp/1PdCeIaSxSUIfrO+nBRrwTn
 LH39ZUqruPO2WVTvGCSztY5RjXrS/pXp1M6dr35WDy2C4svIgEj5iiRICWH0IUnYYqft
 GYgjTzXah8EmiRsazpjot+gWHexN3GFDB/r1ydls++JouO0xePMKy3c9XaXiAbQ6uxg3
 gOjMJbi5hFAGUz1GrSLswE5nj974d0ZBN1zIMsnsGpfTED2D9F86Zdsj9ICAfB/Yheab
 zcLg==
X-Gm-Message-State: AOJu0YzZQDn3acYChwKemaXm2cLX7rkia4S6EsgRLWcCFLAETMc+pZG0
 2V/oGxaLkxDf4i1XwyZUqpBBDXBakB/xq/R6fqJYhsxff3xoo7lEIOmiyNPoBqn7VrguiZENvmo
 k
X-Gm-Gg: ASbGncvBgq8hvNl0SBmtfnPTr5VeOwMj/qJeXVvzlzc9yQoTJQAnEC0bWpu1jprF6Tv
 z8j4jcaf2SljY3iKcc5JpzRp5YNsJUBivotmRn7PvDs5ZTL6xrq2oAHgRmQGcyG+WmzI6I6Z95s
 bf0zRb0nfMxhAjBGrdWehNMsarzHc2KFlrFKAPxm5xLnjBPDnAjGnipCYLeNKXAj+/IAgLIm6Nt
 dtDJzI8wTw9tXvAakdN5G19dldtODvUG2v0YHC/RAeKiee1KhTk6cu4X1RQrIzrPEudUE5d2U5r
 0seSReGthwYZnlBp1HZb1f6hqeKZoSH5T7MSlTqPlXs+ObpjQgKHNKJ+k4Wk
X-Google-Smtp-Source: AGHT+IHLP30wdiVpmAV1Pm+hM8QwtjdEBAfy58mRsPTEQdJkJcjSKHk/M9RJftNUCfgBn0nsS9LEmw==
X-Received: by 2002:aa7:8885:0:b0:736:7270:4d18 with SMTP id
 d2e1a72fcca58-7423bfba8f9mr1005803b3a.14.1746738185318; 
 Thu, 08 May 2025 14:03:05 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a40589sm488199b3a.145.2025.05.08.14.03.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 14:03:04 -0700 (PDT)
Message-ID: <bd7a7405-b061-4c94-baf5-26026afb5ddd@linaro.org>
Date: Thu, 8 May 2025 14:03:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: do not check supported TCG architecture if no
 emulators built
To: qemu-devel@nongnu.org
References: <20250508095044.468069-2-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250508095044.468069-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 5/8/25 02:50, Paolo Bonzini wrote:
> Errors about TCI are pointless if only tools are being built; suppress
> them even if the user did not specify --disable-tcg.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   meson.build | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

