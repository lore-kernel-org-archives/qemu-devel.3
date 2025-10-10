Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D59CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7IIE-0005hU-9p; Fri, 10 Oct 2025 14:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7IIC-0005gX-0u
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:56:40 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7II4-0004QT-Pn
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:56:39 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-33082c95fd0so3060836a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760122589; x=1760727389; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S/CQXloyVSQIxziNcBNsZzVEzrjDDFEiJZg0b0p/8dU=;
 b=xzQ5c/2LFtRUB1hi/SM02w39g9EJS26DSkeM6im8+tE2ZD+y0OxZjigsOMGUZSQMvP
 OkOGMMizzZSF/knwI5Fvj+8nX22Ljd2x0WHqjIpbi3bCUZPYWMHE1TM0AmnAwV95Yh4V
 gKfjfVSYnNGa/XzcX5DiV1ANb2nwffTpWM9XBTtqR306D53vaAfeM3ZUxS+xHYQ+1v3d
 Wv5xS0fP25zoPTva0Bse1opyZERRErYKn0FYdNXOwCJu7b0MTUgjTAuDaBpc5n0p3KLW
 6vo2704cT8aVyksfhbD78t3Z/Dn980F8XIrlhVRVT5sXg1Q25UB5V2qUz64ATrYghCDL
 o9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760122589; x=1760727389;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S/CQXloyVSQIxziNcBNsZzVEzrjDDFEiJZg0b0p/8dU=;
 b=G7jZBp6Y9FkRV4dKu9meUOzOx2rLGT76p8eBXGfuZFR84n6YX1XIO1Sp8BlLe34Gy0
 C8bsu/JKA4Qb9GPClJFRHzCRkTr8hMtfbTCa/lE4qGh9fwz5F7skPRjUcRGbqgSNj7c0
 IRceEVqBmkrIGjnN7nlfZJLp7n/qrJ+9zPZDWzk2mPaUjK8kmmUpp3lcT3UawNvkHu+y
 8Mm7PI9siEpNf9k0bIGvggLENr8ZQYHjhefopCCW6fEMrUguF28hner9R2oNCCvXf2/p
 RVJBgWJSJaxIy69u2nN2qviPr7ka/x/WG7isFbGaxJgnyI1xWF7jwyIaJtEu/2x7xrzi
 rP6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpWwRtB607BJv2VO4oDtdZO4Eg3ABeszm8mbvZbQb/em1u8WNK42Pxd5caYpVM2+AkNu9foyVTwEXk@nongnu.org
X-Gm-Message-State: AOJu0YxiyZuoh6FGpTV5YPtiCwedzGMuHLAQy436dTc+o/i61pOJnTi3
 SGxT6uolYdGQ5dFpG3dkcgrxuZ+pGBOHWowbSxDbQJt7RNR6W2LAD0vtRVrhq4glv0g=
X-Gm-Gg: ASbGncsJntUfB+ovlMzkhjSZZbDXuna5E/o+vtYdK66FexCL4FvNcE54CTPfIfr5Gvo
 XtsuGaN8HR2KIhqhUWF/VPVvuFViOdvQmfwzpvfsECFjNGVPl63FZCRT6wWwpJR35wIv+o1X+gK
 Ty8JdZqtsLNks078IOO5trHDYJJHxjUsb0ZqqEYK1qubZYGeKd+/VMkQyYX3tOVWMnt9UbQin7B
 0BJPWV9M4qfVxVtmvgi2t9NnLny/bNuN42nt811JjfYJl+LtqZEHKKIVZymoG+H0R5aAuyLAEnD
 YBJoL/7S+IsMDRKDVH4ngZyFn0hz6djWwZAKbf+AR8cUt5bM1Av2GI/bZAHjZUaXVi++2vqJBIp
 yPLDifpTcF44/qxUtJvDBGrJdbTjDziH0ZccdVi7nrmomTX0Q4B4K1XVMakM=
X-Google-Smtp-Source: AGHT+IGbPXhoNHBI1yluGnbhp64bgRVxRuhE6DxHLXBBq/CeNSQ4oGOMD6jRnFQNfM8Vf5blJ3zQuQ==
X-Received: by 2002:a17:90b:4c4a:b0:335:228c:6f1f with SMTP id
 98e67ed59e1d1-33b51168de3mr19679346a91.12.1760122588944; 
 Fri, 10 Oct 2025 11:56:28 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b52947843sm5244404a91.1.2025.10.10.11.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 11:56:28 -0700 (PDT)
Message-ID: <a54b94fb-ee3d-418d-af6b-69ee28294952@linaro.org>
Date: Fri, 10 Oct 2025 11:56:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] target/openrisc: Conceal MO_TE within do_store()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>
References: <20251010070702.51484-1-philmd@linaro.org>
 <20251010070702.51484-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010070702.51484-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 10/10/25 00:06, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/openrisc/translate.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

