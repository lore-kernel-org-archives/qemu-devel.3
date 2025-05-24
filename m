Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1752BC54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 16:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsBG-0005CZ-Ir; Sat, 24 May 2025 12:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsBA-0005Bz-QJ
 for qemu-devel@nongnu.org; Sat, 24 May 2025 12:57:02 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsB8-0004M1-GZ
 for qemu-devel@nongnu.org; Sat, 24 May 2025 12:56:59 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a4c95fc276so1044882f8f.3
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 09:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748105817; x=1748710617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kmcZ7WUMMM0vggXaRrMlBdmcycFPH1/PWIhDEv9+RkY=;
 b=mNjTRnUjFrlsyLF8r04nvXjlCGfmKNaY6JNZcyElhLhEWL+6UDwpFGVT3q10zwM7U4
 /EsmUhDOUhT0OV0xYIVcWrhgpm+TeZtjORntLBbmb2n+NHM6GS89WVAmUJnYPQy+hcRE
 MEGStlzRmnNm+HdqEZFrUghRuXaWeFaOyZeQ3Uv6XWv1OGVavF/sc99ui6EMa3LH325S
 VBF4XdixQchHpXHj7jZ6asXv/0YzBuzltn6x/WSB3BbHV54noPdUr7Me+NagDj+FFXRZ
 MLOIxmELct06eSefHMUNoozjlklLV/lmnYFTgE3s5qp5+5a/bwAbUeK61UUzltBSl9S/
 d6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748105817; x=1748710617;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kmcZ7WUMMM0vggXaRrMlBdmcycFPH1/PWIhDEv9+RkY=;
 b=H3nxF32Y3bMS0JIUE7/gdfV3IT4G2ptZUckAsYEbUbWm/E18lfWe3VJ5DljuwRZHnU
 2EyUSLGe1bmCYzh4SDDR9hzV7NKqwLgohARc+UhRwEBUM1uIGPEpS0XawCmlYZHo54rg
 4dM340xZ86wJ3Y9W/AOAJb2R2hnD/CIZDgitWX2XEP5eBran3qEdWGXWBtmJW8xRORJ6
 nMt4/fsJq/SXKPatXMV5EOHPfC1kOIaROGBKhf49GR1aGieICc6dX7jVbVqbJODD9exP
 H0jbXBnI9VwONRjAKyGg1kv8HblbNuGakZN6hG+IDQORRXQczic9H7YqDGky65f7Rjdp
 rtFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxY6hkPRwxFkuCfKtrzGZ5MPeFduw9op13PXsoBTv4IgY5HGEUDC4aVkMeHr7BuLSQV7V9Cl/bm7Cm@nongnu.org
X-Gm-Message-State: AOJu0YzcrVRRAHMUCGpIIYKMANyO6W4CzFt+witPwoZgkYeBs3Yhp7Xo
 VI1QTxjIQWRIDyKSzW/cyWYlCQ56io1QpIcA4Th+wVGqRUsyLZLGGYlE1hZl4TKygUqokhaTPc1
 wUiwiA8+yUQ==
X-Gm-Gg: ASbGnctG++WjwGX/7MeExUDsZXhRL9BvvJd0O1Vo0XnAovy+dnmRFne/JifYqTahZaB
 /k9s0ujKauozIBqXlA2+vuP2eCCG8ar2rnSxYHdyusCjrO+K9hQP+q2DqSYRMPGbyC3N8PPzmRX
 HF8P5Stkd4tgkBTwRvAWpuSZNqLpk/D66v1/I8DS8s0BqDwyhGOUeY4hMTg+YZ6a0+mr/dZyiTH
 ubnTbqrh925zzXXuGHyUwPiicN/qTcAmO6UBaMVBItEXtwUfq2d33FlQp8KDeCvkyj3fMqevl8i
 ZJdbwC7LzMlWLL5dR2DF9gQMuQjYWPn+esz/CCM261Qb/+SMaiGuioSyU3WE2Y0XfA==
X-Google-Smtp-Source: AGHT+IFL4qFUZkNv08t+LQKRkjPUzBkR7LVsPC1k5ah5n/ChKuV0goaF8h7os7iKf/ZferYOWlyBxw==
X-Received: by 2002:adf:fa10:0:b0:3a4:cbbd:6330 with SMTP id
 ffacd0b85a97d-3a4cbbd63c3mr1724531f8f.24.1748105816939; 
 Sat, 24 May 2025 09:56:56 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f18251adsm189113795e9.2.2025.05.24.09.56.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 09:56:56 -0700 (PDT)
Message-ID: <e1152e9d-9043-4eff-a8e5-5baf562f0ca8@linaro.org>
Date: Sat, 24 May 2025 17:56:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/25] target/alpha: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <a5ec8863418a946530d167677184d40319470af2.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a5ec8863418a946530d167677184d40319470af2.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for Alpha targets.
> 
> Signed-off-by: Julian Ganz<neither@nut.email>
> ---
>   target/alpha/helper.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

