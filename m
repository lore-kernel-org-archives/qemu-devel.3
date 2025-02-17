Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB3CC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwBl-0006uW-RC; Mon, 17 Feb 2025 03:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwBa-0006ts-1k
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:09:02 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwBX-00006r-ES
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:09:00 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4396424d173so38092385e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739779737; x=1740384537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NlC8sg1pUoWU0fttJiNDx2nP1YWuiziRK15/3rHPMXw=;
 b=sD13I+esG6g5Q0c/CBlfr3x/JIk/VD815dWvBUC+3IS6AsUjwUuK6jwMfOAtCk/ZCt
 te0lkyp+2YVaXm8At77dqTgwa+eAk44UxWxH0tMkaC/rAnKKwpnVTZekTqndw7fG5wH0
 DuFmIBkHWSseWiNKZiFsZwQxgSpDd2ghuGt+dpnoiU6mhRcTHEPyNhPlEIsf5QE92R3m
 Eca4KO/AJ9c8CrxZe+tDBpU2t+fUUqmCmkSvzLwatxRnRmT0dWxOXqIjPL8DNptobN4Q
 uyflIN18/iPwM1eU8mve1Ds3Xf1uecsWfMxNSX+35h0jzOAG229LJuDQHF+aFVDSoiO9
 bXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739779737; x=1740384537;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NlC8sg1pUoWU0fttJiNDx2nP1YWuiziRK15/3rHPMXw=;
 b=iVE7febVkazf4Htnd2ECN4TZfs+rZ8YFtjEjsA6SL/1jlGeqeem0McWZuwGQXek/JO
 PqLpmvkfac8XIefrqIvzKLogOdh3xjNrsfFjArxi7WKacXRPoA9qDyQhcG2AvCY1gYRQ
 aq2CJhnnszX1FLHtmxuiml12aVopKYEH9fYKQ9/yVlHCFwKApdnvOCpHNd/hT7EQXfRw
 YSjtgQ3LWPA7P9Yd5tNo/L5H3PJ45eaTQ/eaRniH/sbAXWhD+P112cP5rzfmwWafPiJD
 aGw3pbG+uvNYjcgyDdL2nnW7MnTtHTz4j5gR75fr8OqmOf6ioLjaKq98Cb8MPWGERomb
 Rukg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIf4xuc+8fGjm9hahKPGRiNSAZIJEcnSll7aQmm65jbxvJ5AK2bitIQd7LLN0aoXu4HE5s50YGP0fA@nongnu.org
X-Gm-Message-State: AOJu0YxHDa2bjnPKmlQdsjzQBBbKgNZmbPsf9ealnlz7C7zRK12bDGR+
 k8QqXOWcVjpEd+BeZHBKDxDGLUkj+BMO57rbEewSPYfbXYlWibZpvRM/N16MoHpsLNiN2bz9Dd7
 w
X-Gm-Gg: ASbGncsw0kit0V1fZ5m9Yz7xBJfpkjF7nEN2AsKO+M6Ws0JplNZrb07g8TYWZyy1w7m
 L+zIjZvSKhiaMJdOSbqBskgVpYESjkX19GNdigSubf3JdGgATbyAayguHfQyIJelDlsBPBnJoQT
 dOApsuVcMOWA3fqZZz2UqoGhHbpeLmCtfZ/hMHtnzikW8VhYuxt3H/D7oj676RKEbLEnThGQBiW
 RIhzDyJEctOKXNVCmlQfqIh6cHIIHZpMhiV8Q/+I7n6RH9T0/5jxksLjFOeYXqZ+mzgSKl8qVhF
 kmqXf0PNXG6SsjeGuCsVnLbnhTExUA==
X-Google-Smtp-Source: AGHT+IHtd6/fB7o3mt+u1uxvXrbYxWflTl9GctO41+2KXYjeubHvFnm+5Iu4Cgl4cDY4mG4IufT+SA==
X-Received: by 2002:a05:600c:a384:b0:439:88bb:d023 with SMTP id
 5b1f17b1804b1-43988bbd481mr12246995e9.11.1739779736980; 
 Mon, 17 Feb 2025 00:08:56 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398cb4de78sm1503605e9.24.2025.02.17.00.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:08:56 -0800 (PST)
Message-ID: <033291c1-9f37-4738-961e-f116b808156a@linaro.org>
Date: Mon, 17 Feb 2025 09:08:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 089/162] tcg: Merge INDEX_op_bswap32_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-90-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-90-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  4 +---
>   tcg/optimize.c           |  7 +++----
>   tcg/tcg-op.c             |  8 ++++----
>   tcg/tcg.c                |  9 +++------
>   tcg/tci.c                |  5 ++---
>   docs/devel/tcg-ops.rst   | 13 ++++++-------
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 20 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


