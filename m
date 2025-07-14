Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B882DC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQum-0001fX-RT; Mon, 14 Jul 2025 17:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubPL1-0001B3-Je
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:59:51 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubPKx-0004cK-Jz
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:59:46 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so2516512f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 12:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752523181; x=1753127981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Oqsk6CkLiHdbbrMTT5tOZqh4Ya8vaJXhfxYFOrdCkA=;
 b=P/J+UxvTVEdGBrdBVPvW84n3QuxIGNk30STslEC8MQwPoPcOLfZZvnTvm6g25/sVSS
 O3OXoB5OG7EjVNhYignVXQ0HEb3dd3V9gs/S00y0STteRENiGSbZJiHaFY6IjP4clPPb
 j+s84KuGmonRWVh9eigVwrMXp698iEjYuHHh4OxKixVGbTlGbHTuiPEZda5nEoBn26bJ
 X2NLbxfMv7xUFVm5EMZVz555s3HU1cb+NY0ghx39ckBlUuv61OawujJuOKQOChMvVCtW
 Q+0KoZu38heclhM64UV5fSLQK2bXbNxlxfAQYhSkwMBefpPp7CEkciB/U4cntC6v6ymN
 F+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752523181; x=1753127981;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Oqsk6CkLiHdbbrMTT5tOZqh4Ya8vaJXhfxYFOrdCkA=;
 b=QoB/2tH2nHQj4SqVfGeigy1Q/eCheXnHa8pEeZIWo9o4bBykUU6hpUdhn4vfKsmzus
 8LPoxSgel+j1wHVWFftKzu9bevjM9I7h+Ij/eVWuTlF5tjUO97B3qPVX74HLJSIF6Hj2
 qvEIVM/AmfkKr/W1zGJHJn7OGbO3iJTw9PNAGniKFSiZpcsfgXZcDVkg6vKcUbJfSO52
 yIBJ+zcY6zapNNgagbRTcYALGXyQyT5xym+zQ5K1bzdXtB7bMhuydIi8G+BNRNP9FavY
 pAs2mIj0k2duzFfdW91DUBbABZj2WHsyco1pX/lgVIj37A2ABbWFQewNrcZg4BeqnrvT
 upCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuKpH90P0zdGsl9zMsyBlWTaLT5I2x79BjGlD1tZ28fAWiZfHlIdh87XIopWu28QZFsl5CV6wPUmMC@nongnu.org
X-Gm-Message-State: AOJu0YxMTEhsDoo5kYv9ipl1EVN+cunGt9eGENMNsfA379B/g/1b7+Q3
 YIwCAaiGphYTy2o3CkfLPvPuRW88WMkRzxjW3TOnhWb7J0OjPfbxtEvlaHggTYIXGnA=
X-Gm-Gg: ASbGncvFsMaCH05jvVvkVg/hMfW7Tol5OaF1xUWj/Pj3xMSQdashJ+fdEFSn8m35Nkn
 Mx50P0gRebSonifk3FszTiXQW7fCjECCav5w69cKyAYQUU4aFPHwwtPH1VaAjxE3l1rUw4ZzVWJ
 3kJc0VREr9+G+msnp+Nj4MNmltHOcy1UIw/KEopPLyGspVMi0UpLAmmJ+Sovq3ZUJa5gKUIl8FT
 s/OvSWfbSVjguz9LsNA1kZaPyCwDe5N+crlwhsWXUUcKyXzotzPgbInAnb7ZxfJi26MEGAsX/i6
 FADMUl2oePcrX84lzowfzV3Tk1yAanf1/Wr9W/Z3yp5Wq8oIMFKsDDS6s1jKyrRIALkgFAPjHwY
 16RjL8y7sV8hiu3JdTQYbF2NnxeKlB5rAM5MB6+vdIw8HzErcJEG7JXUoSs48f6azVg==
X-Google-Smtp-Source: AGHT+IHqIuCt9jSTmOx5fH4djTosypbrnoETtLqzHAdfbwkVRlGqTwOLlEEXt8HF+t5zveFfM1VJMA==
X-Received: by 2002:a05:6000:2f81:b0:3a4:f975:30f7 with SMTP id
 ffacd0b85a97d-3b5f2e3b17bmr10523822f8f.56.1752523181512; 
 Mon, 14 Jul 2025 12:59:41 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc2131sm12964593f8f.29.2025.07.14.12.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 12:59:41 -0700 (PDT)
Message-ID: <15aae8f9-db6b-4bdb-80fb-332c347f38b4@linaro.org>
Date: Mon, 14 Jul 2025 21:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hvf: arm: Emulate ICC_RPR_EL1 accesses properly
To: Zenghui Yu <zenghui.yu@linux.dev>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: agraf@csgraf.de, mads@ynddal.dk, peter.maydell@linaro.org
References: <20250714160139.10404-1-zenghui.yu@linux.dev>
 <20250714160139.10404-3-zenghui.yu@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250714160139.10404-3-zenghui.yu@linux.dev>
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

On 14/7/25 18:01, Zenghui Yu wrote:
> Commit a2260983c655 ("hvf: arm: Add support for GICv3") added GICv3 support
> by implementing emulation for a few system registers. ICC_RPR_EL1 was
> defined but not plugged in the sysreg handlers (for no good reason).
> 
> Fix it.
> 
> Fixes: a2260983c655 ("hvf: arm: Add support for GICv3")
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> ---
>   target/arm/hvf/hvf.c | 2 ++
>   1 file changed, 2 insertions(+)

To the best of my knowledge (auditing this is safe for EL<=2),

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


