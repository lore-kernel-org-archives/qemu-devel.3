Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD81AC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHQAq-00057T-Hw; Wed, 12 Jun 2024 11:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sHQAp-00053M-6q
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:46:07 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sHQAn-0006dr-Iq
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:46:06 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f6f031549bso152835ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718207163; x=1718811963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QrfrlrISbi31Cyu+lHZqtj98oxaFekxBlFPaxn8Jd1k=;
 b=lfHmbGam9V/MNYMiM31o745BCcJwr0b7BGLdb8+mFZyzC0HDyKQno5MQ06TlY12xVo
 6HtgAKa3/NxA8BLQnz4mgU4DniHQshz/rI3Gh5T9rcXTI5k99xsu/7ussrDKCvwv3q31
 NWaGGOeA/TtzH5cx8sPgbewg0MeiCbuz2KMdKHC6gewHm5AyX91bImEJfWgh7XQD1Cxv
 Wu3XutwrvybAymfsGP7gIXuDhKrYldfrNa/GkbNjjaa380YMufnC8Fem3T7FL8VKFtwa
 Mup6UYMzXdDzK0wFV80GEPYUYFAYktCYnGcSXS5nAFDA8tIC7ztYcer7T3a7A8kKYsd8
 Zl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718207163; x=1718811963;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QrfrlrISbi31Cyu+lHZqtj98oxaFekxBlFPaxn8Jd1k=;
 b=T0Wxx2Q+MX0qitvZaBkdq2WKlYnicdldAE+/XzbQTJTR0jNjI5ayp3uIaGrZS6s/pq
 0+/II07nHvOspeRZZ5cPp/vEgGDL4xmShBR0Nd71cUlI6HxdDykAGmEUiHtAZ1raGfQJ
 WDxHzQvMWTT7H/YjqgdeIxw4PCGE7zhfkeG/QvxbKwBzU/wXwooSNSEi9Hcpko87vG43
 yPbezBaiNvQMtdpwVUzzN9+/9gtAPGoqxSf2lqRkMxPVkC03XWXz/gaHrIS3zbu6HXvg
 +uadBCtqnaVFkg5YoRu6HmXWRWd/BcV4sOpAz9TInA3msEQpjGUCzPFQbjUchUxF2Piw
 +yWg==
X-Gm-Message-State: AOJu0YzmNUuqOzz7+tWZx70ADjhF37roeSlUjbKDfXsHdDKVecSSHEcC
 t88GoPoUehlp/QlCIXwcs9Jk0/+BLI744xHui82WIIg8zNTw8s2jIlICqFk2ZguvuJFoO5ZWwDJ
 j
X-Google-Smtp-Source: AGHT+IF0nKT1Uq2swYwLQfLnlpW3BPZPLrBXavuQr8V54mQtKru+xG7jAPED6+CkZUuLgeJk+h/8MA==
X-Received: by 2002:a17:902:e5ca:b0:1f6:f82d:a8cb with SMTP id
 d9443c01a7336-1f83b6fae95mr23182775ad.52.1718207163175; 
 Wed, 12 Jun 2024 08:46:03 -0700 (PDT)
Received: from [192.168.100.227] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd76b861sm125190745ad.68.2024.06.12.08.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 08:46:02 -0700 (PDT)
Message-ID: <eaa422eb-d616-44fe-ac7e-79baec8d60ce@linaro.org>
Date: Wed, 12 Jun 2024 08:45:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] target/arm: Add aarch64_tcg_ops
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org
References: <20240606032926.83599-1-richard.henderson@linaro.org>
 <20240606032926.83599-9-richard.henderson@linaro.org>
 <878qzaxm6n.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <878qzaxm6n.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 6/12/24 07:36, Alex Bennée wrote:
> What happens when the CPU is running mixed mode code and jumping between
> 64 and 32 bit? Wouldn't it be easier to have a helper that routes to the
> correct unwinder, c.f. gen_intermediate_code

GDB can't switch modes, so there is *never* any mode switching.


r~

