Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F14BC3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 07:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saVe0-0004Np-HG; Sun, 04 Aug 2024 03:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVdz-0004Du-2R
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:27:07 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVdx-0005Mh-HS
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:27:06 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e0bf97a2b96so935016276.3
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 00:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722756424; x=1723361224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ODODGyF0jDqpgjd44c35DlSyRsyYpcN+GwIJ8WkWVwo=;
 b=dLTnrHokvDhsO0Hl68fQ5qjybCJazxg/Phngwnr0uRXqO67dbYKmkUIycxhNM3Very
 MlP+nZY1muOqiIpnGtP4CCP4L0hkhYYz/Zx5MD/5O7LE+eNYIuvYrcC6QODxmZniHAim
 eUHYe03dx5TnbxvIIgqdBM5iReLBpBQmyKJB+cJGzvQl1o7lu61C7j1bTlVbUZZqvwE6
 ssjKb/nSyGUauuJTo6v9jlJ7ZKz8vHP3rHvLWCDlOt64bHCYMpvzuEm6dvg7DgvTd+K4
 N99ch7G7wOyi0itcDqOalxsTpwuPlKzE7p+BL9r4OVQOI+dWWaZX6x7PrZAD4gAsTInA
 bm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722756424; x=1723361224;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ODODGyF0jDqpgjd44c35DlSyRsyYpcN+GwIJ8WkWVwo=;
 b=AA0isFXTxzxmdvp3tHGtDtzP+nTJk2OD0ah2jJSSwfBimJJ+t6iFiQMPxATAx13r9+
 7AUQqn/HzPiqCocC2gWb9m+s2wFKj6JsHf1kN9T6LfxKlCm+qQt2a0MuE4HSB7sMI5ph
 xxQWSb+XnbIpi4sC/TiEPV8U7Y0X61A9uK3yXLvE0e1/SD4QN8su59BHLucvLQHss1In
 wl6CggYcoy6FqgmMa5SOl63rHalvX18ZBx2twK7ENWTvTcYADmj3LaRMV3aVUAJDl++O
 Iy1E3mBYwkfoq6bXPbB/rdTvDm98ynepqGyX+pdMVaHpL4q0Y5CdB2WB9rEyT/gYMJbT
 ty/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcIHgVsZNViqe69MyO3c2Y4UxFex9bGuM2MT/R4GAqR3PeUmR9Y6Vfd1375fpRMHVrCfbHeZrl7KGVYiU4PtuXVau4XJI=
X-Gm-Message-State: AOJu0Yy2txFb23FB6yfv/Q8cb4aKgFMkl4ttjeIH9VYpmvUPfZN/MPnp
 T78qtNYAyYcDeStmJcMk5tc5scRdjl2Ip7TMjyJT4BLn1doG/BHVkFbd4bpGZoRJvODzThX8S2c
 It7QfXw==
X-Google-Smtp-Source: AGHT+IE6BYTMKCsQIoDYUzXQzLENZUouGxLMF912x/1Tr8bPs0UQnqEqw50bfPXJIavEs+F6Nfv07Q==
X-Received: by 2002:a05:6902:2b83:b0:e03:6023:ef75 with SMTP id
 3f1490d57ef6-e0bde408988mr10155959276.38.1722756424291; 
 Sun, 04 Aug 2024 00:27:04 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cfdc4cf660sm7966105a91.42.2024.08.04.00.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 00:27:03 -0700 (PDT)
Message-ID: <16b1f448-b281-4e94-a87c-aba8db94b6cd@linaro.org>
Date: Sun, 4 Aug 2024 17:26:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] bsd-user: Remove deprecated -p argument
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-8-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-8-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2c.google.com
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

On 8/3/24 09:56, Warner Losh wrote:
> FreeBSD never really used the -p argument, so it's safe to remove
> entirely.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/main.c | 8 --------
>   1 file changed, 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

