Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0592BE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 18:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL4rD-0003ge-LU; Tue, 10 Dec 2024 13:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4r8-0003gF-BL
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:21:10 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4r6-0003jR-Vs
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:21:10 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d89dc50927so39986636d6.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 10:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733854868; x=1734459668; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D8BO4niUECEoH5WPdxlc1ur6BBRfI0H08YvWbGqNnrs=;
 b=JRL0zsuL23LlBdJAsYi/whTQeu/SEJx3xchD3x5o+0RC8atI3JuZG0Ijv7ou7XgEfK
 UO1hu1t5v7za8QSWfuiZpByCgzc4zrbVCymp8tYd7V8V2k6ZPPIgZfYYTn9Hr+O6a5j5
 xMmYKYC726SKbDcPJRSF6YvtUGHrAYCUdsX3TWTzH6wv3vQHL5Mm/ELyuXnQQrR1dexZ
 xc3+XFrYwYio0J15A4/wPcV9iPBYEJNoBAuNJg16/u1K+AoS0sOB1xDjlR7eYhjQyzbs
 1TvjlQm/8s6fXQaAaFS6ylaYdn/H3Ost4E/rbHREB5ezn73K5YyYBc2r4aM7jJdYdK+1
 PAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733854868; x=1734459668;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D8BO4niUECEoH5WPdxlc1ur6BBRfI0H08YvWbGqNnrs=;
 b=ufiP0Ye1SKVwM27TcGq+YdstXimSj44aysm9Y4oY5L0TiwH2oO8MxU6Ed96L897Kj0
 KRZofbyUVMSqTpENbBCpewRuUmYBoOAYgtHeHDgXhHYgM5eSAPbSQrwMl1+Fz+kmIhKn
 lq9xv+G6SQ1aou4R93EWmMto9GS0PR3X6H68SSfJ9ZKzlgAINfA/cPGC3EMphMSHJsBY
 xArxKm0b0TukES9e185KUFTjJtOcr5TeZp25rsOzZQC+5m//l9kwMVToXRCeE+mR9vSJ
 3dfVKHtxC9+N72Onrs23uSEXhDJFg/TGRpYgUsmZ0AEPWHXb0oj/lMgaqhMNtJTQK1dD
 rSuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqOnATUrK2YT/IkC7JGhLj3v1TmaGN64l/1U2DblgJv0iqzL35jyigz4skdOVRtzz3JIEtU8lc6VqG@nongnu.org
X-Gm-Message-State: AOJu0YwWUu5O1tt69hbIjbdCspR45ZH0HAY8vvJvyNepQvAWovBEt+bh
 LqRTMU3iLYkQbQGpmCEDEJhHJypqaeRPyeXIAA9/TaIiumeyN8+d0O9uJ6Pfe7k=
X-Gm-Gg: ASbGncs5u4RdHt2dWldte1TDFERqrOlMMFt4OI7pPoWYLkCJHFSsR1Nu/qmJUAolGVp
 CBOitgtRYcMFIlrTTnIRIwQ44kMUj4Ktsz4sCuFR1t1+tsaSdp0gkwV8k9PV+WlY4DLinO6ZsRS
 9KZPXXHwdpW1TZkNZwVtdEh7zVm5KoxJKOGEOUQDNO4gfhUHBRpvH3s6Wb9/pBZI+9+ECggUhJP
 HsWKlXsTeuWm5Urx2lrtyH9CsWlWeRtZ8Q0La9I6Pu/xtRZDqozvUZC2ilM0U1C0o/g9pE=
X-Google-Smtp-Source: AGHT+IF/GwjzKtXSbUlm1FgyTWWpaIvzpueXXZUzisYEX3z/OO56DUd5JgcFPgqT8xC0H/vB+ruoeQ==
X-Received: by 2002:ad4:4eac:0:b0:6d8:8aa6:ef27 with SMTP id
 6a1803df08f44-6d91e418852mr97203866d6.38.1733854867876; 
 Tue, 10 Dec 2024 10:21:07 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d9162133aasm20592736d6.129.2024.12.10.10.21.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 10:21:07 -0800 (PST)
Message-ID: <f98e8422-9ba1-427e-83d4-a6d93526a449@linaro.org>
Date: Tue, 10 Dec 2024 12:21:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] target/arm: Move small helper functions to
 tlb-insns.c
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
 <20241210160452.2427965-9-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241210160452.2427965-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2d.google.com
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

On 12/10/24 10:04, Peter Maydell wrote:
> The remaining functions that we temporarily made global are now
> used only from callsits in tlb-insns.c; move them across and
> make them file-local again.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpregs.h        |  34 ------
>   target/arm/helper.c        | 220 -------------------------------------
>   target/arm/tcg/tlb-insns.c | 220 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 220 insertions(+), 254 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

