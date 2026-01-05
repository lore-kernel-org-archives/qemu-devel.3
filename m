Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4972C2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 04:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vccIC-000209-8M; Sun, 04 Jan 2026 23:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vccIA-000200-Gb
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 23:34:06 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vccI8-00076l-QG
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 23:34:06 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7f0db5700b2so11668566b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 20:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767587642; x=1768192442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FUGBsc305A1O3UtadfcGmIkhOBtP3PpXJwBkX5jp1BY=;
 b=qmjokmz831R3gYcXNzCVRO3H+A7cHwQRDgaDTahY6JBhl1LuT73ywVUgfy1o34CwQT
 WNp4wciSGTR6iJPCUCBuXCTgKh2CTvOC4JLiqVvFY6pX3heUijdUcYQjivuBAhIlR5D+
 SThej99vK+HjnDhDlHtoQt2a4QgvqVaX5lAA+QH6PMtGkd3FifgIvP9gNH9F8btwXr3e
 j8PmYpm4l9DNaUtrP3t5Q1lViPe7wQqz/9eWc/IyPo6u0ghD6sNCQreaq+xrAWae6VTC
 Wlz/PHVAxQoVHxf6g5Vbwtvv7fcBeD6GgKKXAZ+F/JgBvSQYzbj0VRCK9pGMpiK8w4kt
 NOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767587642; x=1768192442;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FUGBsc305A1O3UtadfcGmIkhOBtP3PpXJwBkX5jp1BY=;
 b=lmrvqpg7xqZNOxXIQaTSJVhozUSFhB5mWQ557jiVnT4a/zv3ndT97ii/5iRWZSx/h4
 tGBrhiwDkZzXbF0vdRkEV2dFNimloitELTSy7E39MKpXTNVoU00vkgoqGPSTeh3GF/Ty
 4HpYEXmk6356CcKiNQcpU0afCkAiYtH/EPj9JvkKPDiSRJTbb288g5W3xdW8pqzo0GlR
 0Ij/31AjehS7xYKxR/uLrZG1W5ilDIXYPXeukn6+xC9SSugrLAkEPd1A+amAUXY7SiMg
 hjem8J36NftKM4oWH6LS2lX4TDuHXhlAyFKFMZD9cscoBapBe1BGwhG7LnLW21IUREAn
 cFeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrDh6+S+68WYBBKToP/pH6BkXts7qzGiaQ99pIXcIlluNhpFJznjLho7l7b3gL98f4zyl7bBH5RruK@nongnu.org
X-Gm-Message-State: AOJu0YyO/+0Mq+zgifg/3M4qDVRUIE4QNRJtN97IlaXebBq4HzqdigfU
 aOF++c0lWxk3J/9gnR2mxI1a6Qpi674nc5EzG+gno9eTYOmumsYaKWqMRgmpKbLkQYo=
X-Gm-Gg: AY/fxX6Vb+j3nFHn+mr3XhzG4zj7id0knaXaPK4XW7ia4fXFJb+BlZFBR2hjjq0idAL
 X5QDUw9PYQKtav+fPRXWSTzpTACFdgoRexD8XpK+asAKvRCbOuraKca6AENEh3BP/WgJKGRzjXw
 o72dUh3kfo/uCqL79EP0tQZHzhhKWE+Yo6TCg+HKl6dK1txg2sulhoIBwkcM3CXQKmQL+gi87yP
 Tngv3dV97npozyHMxqy0ZhfUvE9+tI2H/3F7/YWfFLyBHQNY+jjGqJ2wu+/Sma1gzhoqYH4qJkU
 JqWELsXnbov9KH5RFWrLAUY4UuvOKZXfFcKixBsqDv0XO3vw9pmIObAyRs88Wa7HnuCq2sbqDC6
 ilq1MjIFWSf4rtJheryutTeYbg7XshSitjzpJIUmYZvRxfYw+W49pklLzw7nT1KMmCh5fMxHmQD
 dOLnHpG5kYgagCe3PVm9pnBEbFgDxr2g==
X-Google-Smtp-Source: AGHT+IF4bOHHxu8HnMCFMNQsM6Vb+S4hHdIpMW6wPLxfeNeZED3aOCieCAPKWzTJyhsnEVg5BM/AZg==
X-Received: by 2002:a05:6a00:e87:b0:7ac:edc4:fb82 with SMTP id
 d2e1a72fcca58-7ff6421527amr35254981b3a.5.1767587642326; 
 Sun, 04 Jan 2026 20:34:02 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7b22536esm46122110b3a.23.2026.01.04.20.33.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 20:34:01 -0800 (PST)
Message-ID: <bd9e7764-38f5-4c73-8edf-a64a2eb350a8@linaro.org>
Date: Mon, 5 Jan 2026 15:33:55 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] plugins: move win32_linker.c file to plugins
 directory
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-2-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260102214724.4128196-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 1/3/26 08:47, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   {contrib/plugins => plugins}/win32_linker.c | 0
>   contrib/plugins/meson.build                 | 2 +-
>   tests/tcg/plugins/meson.build               | 2 +-
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename {contrib/plugins => plugins}/win32_linker.c (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

