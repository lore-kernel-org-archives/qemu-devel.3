Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00850C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5Kv-0000bq-Ja; Tue, 11 Mar 2025 15:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts5Kq-0000bN-Gz
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:32:18 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts5Km-0004ui-Up
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:32:15 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224171d6826so18158965ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741721531; x=1742326331; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pCNgdcqYeJk27M6WqFIWxYmXTtmahkdNNNs8Bk1Tg0k=;
 b=FKhl/GUKKL2+RKfksaSqb5PSzSd5GUnB0XvRlSSpk2dh/ysvkA4lc2jIW6mPrdBZya
 J27KQExYPINVC7hSE5jDHrDrVt/LwP3p2vF45khN9L8J1CzJn2W5leAv/SZ/gO/n58ug
 gANsO5XLPtMKpKZXqzL/KLCtlDkEguMEEAW6siVXL4sEpsmXGMLiisgBS271FfgNEsGA
 je9Xh8mrlrpvML+WkNwtuIqcbreQPXB/Eq/gwmesqHgl4UzNL+KHWF4+z5qjLaAko6qW
 lyoHTfzFtyGBG1yvrPRhOxGi7oHmmTz20EjUM0LS4ecSHRN8VToxChEWfiHi5z4U0V+b
 vRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741721531; x=1742326331;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pCNgdcqYeJk27M6WqFIWxYmXTtmahkdNNNs8Bk1Tg0k=;
 b=NbzEEPO5aGwsD6Dh8rIbOhe0YQgNDUd+9fyNKBhOoSza2hhDyln+k+fTJM9wI8uPim
 Js/+8ioL8FlGUdhTV2wok8fNCD8WrE0apo8WR/NcqQZzovlLc/QSWx4X1uegtQehwOkt
 m6WLXosCGp8eguEelHkzFl2nHGmrx7TJSxd1VOmS7sBcD//OzWF8eTMTTp0Qfhifgz6Q
 ziRy9Wfl8RuvCH+u4410V5VDbpFPAWwYaNfdvZC6FqICH/b6mXHduFXcVil3sLgjFEma
 jC3G6ibRToTfqGSUSDqMqwsXxa5+SnpXpEhez2XI73pnyTdrvD9sRO/7f4vXYi1t38Ek
 zvoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx4ihgtDdlrZsWfxBp8RTuodLra4BigxMFDk5YJXMV1M3kPqaaY0/CG1e1guJ43UYJlRGng1UCA382@nongnu.org
X-Gm-Message-State: AOJu0YzJ+AWLrrJt8JogO9P3InpWTSCm639zKJ+u+PYt51leI3nXc9gi
 7r0PAF+W7Eh5r98tpl5EancxfwJb8/Xgn1ydy0UU8EjR4BqhtEWEheME/2soZcQ=
X-Gm-Gg: ASbGnctfSsYxnuPcUWHavZUL2geA6NYHNeoE/Bb7RzOstfmJa+FUZzHTB5DMyIx8MzF
 KnK4IWYgnp5uDQuU2+8v/wDXH+CQW3ds5EZ1NmeHrefgp9pgeXqcd1MGTiXLi4/Td4ngv7ys47K
 yGf5JfzT6rp03ioVOj6ggdXDnrfntG5Srsg9JSUpIFZvQSgZU8NwZxYoo8+WsiTbmkAWEKi0A97
 3U8yNvG+8zwnetTr2YqkWert6w1+QXkSw7kSwc/OO7Y7+7hejMC4HHjrDSWNDH7TNAvZNrM31YB
 RsFAiKGsWqriR82h4K4yRU76kZjwwC5Nopa1Mi41xlTdAXeUJnNOVu24Yr7mjcf8LSNCQCXAS6u
 E5Ra2zqf1
X-Google-Smtp-Source: AGHT+IEBFV9Unvtzlj6VurPch51xslsHSPO6QJ5gpweE2oFhF8FVdOuwQJJGt0Kcn2fJK9kwir3QNw==
X-Received: by 2002:a05:6a21:3a83:b0:1f5:8e54:9f10 with SMTP id
 adf61e73a8af0-1f58e54a083mr7017789637.34.1741721530895; 
 Tue, 11 Mar 2025 12:32:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a7d6e54bsm9451191b3a.44.2025.03.11.12.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 12:32:10 -0700 (PDT)
Message-ID: <4814f85c-1119-4dd4-b12c-2df761250ace@linaro.org>
Date: Tue, 11 Mar 2025 12:32:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/16] include/exec/memory: extract devend_big_endian
 from devend_memop
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
 <20250311040838.3937136-15-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311040838.3937136-15-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/10/25 21:08, Pierrick Bouvier wrote:
> we'll use it in system/memory.c.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/memory.h | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

