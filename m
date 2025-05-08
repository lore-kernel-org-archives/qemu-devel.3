Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C39C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD3M5-0001VG-K8; Thu, 08 May 2025 11:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD3Lt-0001UM-No
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:40:01 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD3Lr-0003P3-Oi
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:40:01 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-74237a74f15so158153b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746718798; x=1747323598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mwetbVEbsWlEBRMEp55p88gTN7b1SIR115e/4o401sA=;
 b=VlmCcULkYHOXVAfCK+GypA2ShZTW1csnA+pABRVAsjRmQqXphQOvzOObFZf0fFJbZh
 a7bVDrXVp0NA7/n9ExpuNoULqva2ny6A+p2tuvenWyb4GRgyodoyk6gqNVshBjWlvsud
 fTmB5vORTYieJhnryV1ERLll6/51BiDI4TR21v1Cx8hwa3pu+XxgPhZ/1u/CLQV+kGlT
 1YCyh4sQEbxGD88cIS2rPBPKy/Htir4N3j5xJ7loB/RyVN+mIzVCp6HvoKc64ZdUpOIr
 ZcOReR0oFPbHHHtGivyvkz1sL0GBYjY2gOe+fyOWOnf7hZBzqDznDfNXDXnyZqIiMh0i
 WIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746718798; x=1747323598;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mwetbVEbsWlEBRMEp55p88gTN7b1SIR115e/4o401sA=;
 b=CNbLhITj3RcJj3/FTpbt+KKslbNqc+1Tp+wNwipYrrnFc9eS43Qlr2ybv2w7nddSYw
 dhL479mfvicbXd6SeNZG9oaGJ8iUaq/z/rs4aOElhLlfzlMlT2XosdDib0ArYt9pr1zA
 JgLN9npUFT4R3GwCa2+ZltZ/en1k5Nn08tcNibdwcOJutFeSa6pxL2rxEGid5EKeKgGK
 5WNVjUg7s47fO8Hzvrzp6CFErTm5FSvJvG26zGSynEnuaXwmLxz6u+8nZ0ewMJPU0Z24
 COQ9k8+PPYAP7brNqKZaVRdg02N+oddsKUmUL2X9p5MGQ5EJ4DfWrSqCcniLO5GAZrm8
 gTrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDCeERwwIN1idI+5DKobU43PSLmq2D7fbNDfk4Ov9GI/NZwE1SJ+BObHZWJJgrldI4XdYtzxSjDwXa@nongnu.org
X-Gm-Message-State: AOJu0YxuWVMQt0SFcW0rg1PNd4GOcv1BvqSHpd8TCxLq3YcQwfhnB3W4
 +4+j1hejB3FcNn20NJj9tbtbY3ukJN8x86JHS85YjPMcfnPtbSmmFTrjE5khqhc=
X-Gm-Gg: ASbGncsLhIRK1u23EdmuBII7WanY48o+nDctGTTubX6HMYHJ1Z+iBgXK26C9ZF87EmS
 wSfUV62aK4Vt7roIJolkOOLgggwx15zPzfJGgd/OeXhfGkhU4co3KvM3uzxLqY0hoMjybxQ0vy4
 BnVKdrNBE7Yla7/fYnCHnqbJlO9DXkV9td2NJ7gZuvpKEjWiSr+YjKo85Y13utHcODHkmaSoia3
 Li/ioZoSRUFCFbOHUiVwKClTcuorRjeCL3FpDSB1rRXWIkCLIa28gTyMpUEybcg75Kwru37n+d/
 gVJNoHrNZ9kjBLeWpgW8iDzbQjuwzxeald2Av+GWhVCxA+ruS1uXZO3uKXm0PFKyhBrInKMnMRP
 23z+EncEI
X-Google-Smtp-Source: AGHT+IHzebjCZhAi29kF65dLEPIK+QqucVs5K522qd9vp7xTbfRavabadQC3L12zJhqGH4ORSZsZSQ==
X-Received: by 2002:a05:6a00:3394:b0:740:595a:f9bf with SMTP id
 d2e1a72fcca58-7409cedc6b7mr13438104b3a.3.1746718797759; 
 Thu, 08 May 2025 08:39:57 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237703f97sm146736b3a.8.2025.05.08.08.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 08:39:57 -0700 (PDT)
Message-ID: <44064e22-bbae-4102-8465-7fba276559d5@linaro.org>
Date: Thu, 8 May 2025 17:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] include/hw/dma/xlnx_dpdma: Remove dependency on
 console.h
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250508144120.163009-1-thuth@redhat.com>
 <20250508144120.163009-2-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250508144120.163009-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42b.google.com
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

On 8/5/25 16:41, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> console.h brings a dependency on the <epoxy/opengl.h> and the pixman
> header file (if available), so we should avoid to include this file
> if it is not really necessary (otherwise we have to specify the
> dependency in the meson.build file, too, to get the right include
> paths everywhere). console.h does not seem to be necessary for the
> xlnx_dpdma code, so drop the include here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/dma/xlnx_dpdma.h | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


