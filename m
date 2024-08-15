Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A4CC52D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 09:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seWhf-0007A5-Q5; Thu, 15 Aug 2024 05:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seWhc-0006pj-6E
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 05:23:28 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seWha-0004cn-4F
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 05:23:27 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7d89bb07e7so94247766b.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 02:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723713804; x=1724318604; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZV4yYLgsJYYfr9wPBSwOyHnhuFfypb1oHwVxECJb3/g=;
 b=Rhc7CNFBACLt9yZqJvbsycGQlfCKc9Wu4Levx3rE08db8wj3l8H+b8moUN1DGsqugy
 KplwYrR8TEMHy8Cd5F4PyqyoPdm7hQjOaXys+8sxsTM95dD3OVonhJHVzPuv54KFQxRg
 E1ZgNoWakNI9QkPe5nLCdSVpbQqq0dWq9W6Yofqe9M+eQl3jwIurxzhlk4RKEwdzM1hU
 PQsPhNV9SC1OCf5qdJWeMj5MiOHrZ31xNA3VDgiuL/Pz8HTKWWKlPXDVXLSyZ0o/A2oo
 HJUBmcuUEEQIwikEQk43DX4YFFL1QZod2qil9G15DWs/hUL7tpfjwA5MOhVWNFoM7R2s
 majg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723713804; x=1724318604;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZV4yYLgsJYYfr9wPBSwOyHnhuFfypb1oHwVxECJb3/g=;
 b=tYjsvjOLVHPSQYQQQrNrh4dCIjOoI4p30jeu+clR60S8dR4YNeqKfNDCqg4i9/ICGp
 LCukfES61jhuaP71LMqibLnKXKEr6TJswOM4hGw+O3/Cb3egMtGs2lNztgyns7c7kbUB
 4lgIKjulxm73z9tMOyNhflHvo/31BxPvGIMnAljaIt6PjWhRYliL4dpvQaZjTWhoNfSX
 FAqYSGwg3z+GkZuCY8cQcgWEUqL31zzz+AICfo6K+l0a54ozC4ivku2F28J1NswhOU0O
 9wdvEM/J1m4vyTUVAU9gk2oNPd/2sWr6wgjA+txSGTeBdTjDKrnwDf3S1ReNCsFnHEea
 6w/w==
X-Gm-Message-State: AOJu0YwpgYC6cJoOXmO9KgKMipQV7gJ4+vwYpflLH6c5tc9Vc4G9IqVp
 HFZXZP33pXetpnxwXwePGU+D2H0R5QDzCIvAsjlzY/O8+xwrYdsJtVI+ZtiUMzgcc6Bj2M1nwTl
 ICk4=
X-Google-Smtp-Source: AGHT+IFyn+abpTjJwS7UXszmTtZU9i1ZgWJi2Thmr2r3sZEb51KA1hc8jFaromso0T2lqr/3NPA1zA==
X-Received: by 2002:a17:907:1b03:b0:a6e:f7bc:dcab with SMTP id
 a640c23a62f3a-a836705803dmr421499266b.65.1723713804276; 
 Thu, 15 Aug 2024 02:23:24 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a838396c2cfsm71311566b.205.2024.08.15.02.23.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 02:23:23 -0700 (PDT)
Message-ID: <1363ce1d-ff00-4e23-9fdd-fd217e4bea84@linaro.org>
Date: Thu, 15 Aug 2024 11:23:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v4 0/3] target/mips: Use correct MMU index in
 get_pte()
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Waldemar Brodkorb <wbx@uclibc-ng.org>, Aleksandar Rikalo
 <arikalo@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240814090452.2591-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240814090452.2591-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 14/8/24 11:04, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (3):
>    target/mips: Pass page table entry size as MemOp to get_pte()
>    target/mips: Use correct MMU index in get_pte()
>    target/mips: Load PTE as DATA

Series queued.


