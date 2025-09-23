Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160AECAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10SP-0003S5-V6; Tue, 23 Sep 2025 06:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10S2-00033w-NS
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:41:01 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10Rz-0005x0-Qn
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:40:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45b9a856dc2so36534545e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 03:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758624043; x=1759228843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f/aisKST/8hDjWdiusrDcc2rSSf4U8wiExwPe1CZZmc=;
 b=z68V6gyCbCCKcLy3I3wRKxyVNl0GxP6r6ivDgJo0AZQ8MZchbhCmp3PGm8BZjVCGYq
 NNauhtRn8KJCJqhjNlDFX+acgNlu61y7/nVANrgD4kkLjiILYveu4JigRZ+CrQdimGUm
 Q+fXH0eBXEGLuKJCtvzhxTrjPNhBPIM6ei1f8H9Mb+/Zr/YxyaN4elboe+L/zsq57Dsw
 dwppU0QhzQCqFpOYWwhfs5XaeKv3bG/SH9+m9BLeyk4nZwYs/N7aaDFJ0kGi0hG2IERy
 SIT5++8h9LNx/7EZ8v4dUF88x3lIkOVZXDJp7C9mTGQcwHWxdlGXCcOiQJQgaUY9ypHH
 2usA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758624043; x=1759228843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f/aisKST/8hDjWdiusrDcc2rSSf4U8wiExwPe1CZZmc=;
 b=bFzHvRYtiKQlppcptE9Y5mZNCdeieDpA5JJGEHYVcO/4EWi3w7+qiqMXpAEoNgdNyx
 XTW3RgTnZ+oMN3FxtmO5ow6MRt37PovaFTgkFYOswoqXbOsyF/o24xj+nRln4vr+9+cr
 TP9liSCiJp3fjqU/xA733D6WczuSV1VIQb3iNtkcYrtDxsTBO2GqJN+24HTNzfi7/ykF
 AGsRpy0AD5G5XuC8oEJoDiqil+GHw72qsWFWg9OM0mcmV3aTaxBFT8yirPgxyfzBLrFT
 4nssXor7M8oJScs8jNhJtxj9Fe3GsDnpq3kvOP4XPU3gvKcW9YpwJsd6hjRVQi5Oe8yE
 Rxlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm1k2n/bgyntZBaVxOJv7STsJSsjlOMXcj/HmOHNkWdUI+fqzj0Xb0+5cJCe/g4dfS91TfSMgATt+t@nongnu.org
X-Gm-Message-State: AOJu0Yz6WNq853zYrdOgoAWljmpCFAqjrGiy/Ymj2HtCpV0zHNS8W2zf
 Wmd02MQITcSIr0PygxDKcFauEmg2Se7Mpn7US8gFGwxfM8RwYe2mNPMwusFQwKTf0BgI0pQ4di5
 sgHxqVDnXmw==
X-Gm-Gg: ASbGncvIWc4xEhjFgwlmwBkW3H3NxqkD58XueDs4bA4yx/nCM4qqN5L9EVF4Tveozn7
 mUQbZZJ/ej28hI+UT148ordVdv1RkKZJwqp2hPOF3fqbc8a3OaqCQVeGSeEIYrFYINsXizGkmH0
 1445VyT5sFe0eS9O8fHe/qEOt+SVc412evotCEoaL5v07RSVooJUBDAhT11pD2ygy1QGLtvnF24
 MBt16K4QTFpU5ztspNm/hSJ3DzRJVDA6Z4roirDQejxYh6YDlqkbdIa6K1k02KBW3ADW8guzC2i
 f7XpdiMMfx43/5kP160qsCOGjptTctBXCTCz2TAsKg76aFnbVwlB8WIcdFWQwSRFFeyNL6dv3+Q
 fHgTblKNfx4Fa23L/sBUcng841lGZqRDmFszMcKyiVzvMTox+1v4OimrgdgLfiWDjuw==
X-Google-Smtp-Source: AGHT+IGY17/Cn39taWKEXze0mrmMEzL6hIV+ywAro4a4cKtkY4quCkvY7GaM2wdBiwRzJoDDCuReJA==
X-Received: by 2002:a05:600c:4593:b0:45d:f7dc:f71 with SMTP id
 5b1f17b1804b1-46e1dadc05bmr19888445e9.25.1758624043104; 
 Tue, 23 Sep 2025 03:40:43 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4613d14d564sm314403565e9.14.2025.09.23.03.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 03:40:42 -0700 (PDT)
Message-ID: <9645a3d3-fa83-4953-8b24-588a84a58381@linaro.org>
Date: Tue, 23 Sep 2025 12:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/36] target/arm: Introduce KVMID_AA64_SYS_REG64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 16/9/25 16:22, Richard Henderson wrote:
> Allow us to create kvm ids directly, rather than going
> through ENCODE_AA64_CP_REG + cpreg_to_kvm_id.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm-consts.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


