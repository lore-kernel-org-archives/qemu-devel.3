Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBA8C36014
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 14:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0hjU-0001OR-Dc; Fri, 04 Apr 2025 10:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0hjQ-0001Ns-89
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:09:16 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0hjO-0006Ck-EQ
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:09:15 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-af590aea813so2218886a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743775752; x=1744380552; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dptn4fH9Cndvv3OsJcJ24/kMvY1Pv8fp4O5MhbRmRzU=;
 b=jRPZ7v7sextIRCdntxYa3lYLpHeaAU7ZO3pgu+WlyZXAGd+Q5toiVpr4DpFxRbOAGv
 dIG2DrnIko2luKPK6QnELFyCqJvs0/xTKUrJ5zYCVihfdn86sX9D/sx7TLHxFXMdl7jj
 bbgCKiXo4V0EMb9ehEgDffciPhh5y1FnLHP4g26nnqjfOdaV5c5ixzzxcqMNiyOvgR0S
 u76vunKKRpY+k24aezcRRnYetp0YOf5XXRm6ZqPaZ7O+m/qh1fmofv/NiQTrnSackDmz
 Gc7BdBa8yiXiNb9CkITHo46zAlTqbrlXmerIAvYOvzJZBnN7WeTu3YqanukT8xUjoZp6
 FFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743775752; x=1744380552;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dptn4fH9Cndvv3OsJcJ24/kMvY1Pv8fp4O5MhbRmRzU=;
 b=vC4dhjVhU2VdHZuH6Phz1nMh8T4zPMp1Iw1aAj1AqFPnhYrlZZOwHYj29gCr00AXOQ
 rH2kYBFcM+80YfYqwEcZ+uxnsygRZJ2waBN9TteT2nBNxjWgBFnM3VBCQJ2AzaGzwIIp
 RG4ZF1fiHa84PCU53Nn74CmZYN06qZMSOtXqxzdlQnu/c352xKXPO3U/53pT05xQZGo7
 ePrpgZdx6x8NvzX+sV1IKGnFokSti84h5VHoTGC7IF54T9aOd3mWmfh1D4xmWX91bhlS
 +VQj1/FGXWWq00K36MeSsCK7xcpbnTbGlYJfPrWUQqFJ0sCICzCu7bI/tUcbfFlg3DpP
 mZuQ==
X-Gm-Message-State: AOJu0YxYNSR8g2VkVTF9d2bUt/7xdsY5y38c7C5EmfFjaoucP66A6dk6
 kQeoFBYfrqeE1akGSPWamCCkZW82jFhfkWE0aCO00nKw0qCkV4bD8pzWpxX9Pi5if1s4O8H32V3
 R
X-Gm-Gg: ASbGncsaXw/utEp6IFdrNyrX975gWfsdBgN32F6mkVWRxL4olpklxuIU5loKLzpU5eu
 UDijnqTdLzeWWxC+PG41yAJLzUZ3oPvV7I53MpIcAe6XXwFbKpwrSrrRuo/sGokMQ08fGYwqjN1
 JjluKXotTyuEB7mlknfYxmIA6o4BMk4wk8DgqfIxcQIyno6h/EwOf4TIwmBBEsQ/fbuTwCIiy0L
 jM81VeWfUefNNYjhE1gl/C02TVFx4B6RaOglwiAprgImLv44i78D42P7o3GYuoJutkYOdeAffY1
 sjr6M+Dj7jobftlF2gT4rv9NirC/JYJtsU5MUZR/NgSf0BMD2KUd+5D9ZG38FWppoEwernwvjrY
 =
X-Google-Smtp-Source: AGHT+IGGE7be3QXcDrxZ0VGwwUrtNu0/aluoqUDeL+xyVkf3htj8z+vjXqD5qwQKw2aDb5UPpRiAKA==
X-Received: by 2002:a17:903:8d0:b0:224:24d3:60fb with SMTP id
 d9443c01a7336-229765bdf6cmr109678945ad.10.1743775751940; 
 Fri, 04 Apr 2025 07:09:11 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0b4869sm3470603b3a.138.2025.04.04.07.09.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 07:09:11 -0700 (PDT)
Message-ID: <100e54ea-de1c-4f3b-a820-b2123a7a3922@linaro.org>
Date: Fri, 4 Apr 2025 07:09:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0] docs: deprecate RISC-V default machine option
To: qemu-devel@nongnu.org
References: <20250404122858.241598-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250404122858.241598-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 4/4/25 05:28, Daniel Henrique Barboza wrote:
> Commit 5b4beba124 ("RISC-V Spike Machines") added the Spike machine and
> made it default for qemu-system-riscv32/64. It was the first RISC-V
> machine added in QEMU so setting it as default was sensible.
> 
> Today we have 7 riscv64 and 6 riscv32 machines and having 'spike' as
> default machine is not intuitive. For example, [1] is a bug that was
> opened with the 'virt' board in mind, but given that the user didn't
> pass a '-machine' option, the user was using 'spike' without knowing.
> 
> Being explicit in the command line is desirable when we have a handful
> of boards available, so deprecate the default machine setting from
> RISC-V.
> 
> [1]https://gitlab.com/qemu-project/qemu/-/issues/2467
> 
> Suggested-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   docs/about/deprecated.rst | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

