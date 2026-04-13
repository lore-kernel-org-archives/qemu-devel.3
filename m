Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D161F531CE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCR1A-00032I-Ed; Mon, 13 Apr 2026 19:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCR19-000323-Lt
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:48:35 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCR18-0001xd-0I
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:48:35 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35da1af3e10so5036443a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776124113; x=1776728913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=saritAySCns44gDYhxBLWOzClnQ8r/IQ2rXx8lB7NJo=;
 b=ItAFNd4lm3qZhIYqlAg5YvT7yLixykAMKX8pZ2X7LfOscJxdYLNG7vW9SmEiEzHObU
 BFw6ZlD0lD66KM+ZOx9rfZOoW4xU7zdfa+FuPp+X2mpqRoljNS6twyfTcjYTin4MYdT/
 6Lc+sWd6PHsPm8h8unriTLWD98U8v8Iuh/OvQr+e5Pcl0hS58ldTUWF1rUZNlDWOlPYe
 KSToaiAVtdx2w/Q8F8+TVZg2mUGcTRRslnUCWesuY02dzp1zAKky43HUYUld7Uq3yiDI
 BwLUOqa//5c7j6LNhQ2jtmX0wNYSfJyD7hiL8SFyi0MlUem+TxIapUmtXqecnvibNmGo
 7ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776124113; x=1776728913;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=saritAySCns44gDYhxBLWOzClnQ8r/IQ2rXx8lB7NJo=;
 b=fNI8qdH45sRhXPNfvnH6PTvgXreEca87ioQX1EKWHrGchWLCjXY7flE/wE27jtCT1H
 0DtKpV0Zx5xDtMzLWjae9Qzz5ggbi+bVhRxOaQxOo0vv8zzAePamTFXQ4fpks32vwc+S
 A0T+pVMpS9SaljznOHKsE7sosj8oDp7EPGmXC/nGLzr76O9JemcYwpRC0kXCXYx6sWLu
 vrJzOIHcuvvoaYO8i+YYjtt3c3P7ubMZHq9Fe1UznDlntZpDsZLkU1s5Zy8simTT3uDD
 QlOAgnOX7lr2Iy7vSgT9Nywjia94iPSJzsItkxQFiNC1P9IMJAeQgSn+CIWv0I0K8W1r
 GM6g==
X-Gm-Message-State: AOJu0Yzchm8YlQoJZ/RfAMjqUGQs/Me0dLiWqic9Z6SLw/8YQCF678gF
 N8YfNkk/yAPpYaEQbsTB2aq+IT2wHj6IvoYnOvCst2o010CB5IBJy6bK55LJtw7r8UYLfD+mTj2
 z5/xq
X-Gm-Gg: AeBDieuDdLP916YdwjUKtVVSaDrReqMG9R8on+VHXRXbDsweZiZDfkSXYRfbvQa9Fs/
 5FJVjvsw5Na+IOjmgf1wKAFxwC9o2Km4v1jJitpS1WufoWN44q6QNpkfKbidupxBCTwQNbt4qjA
 ipMiSTbnmv8Www9ZS8yEB0eEj/TkLZr3qAhg8V8QyAjaTteNyIQm+3xoQdzOuYJszURmJhATcIN
 EY1eT8HUwsQUA7a4vgwsbIJ/44cKmVjS+/NNmSzPZ7o1ESv44tMEUgCYyUGjpg1dTEjf96EEB8M
 NgJj/c/8teYdvIfuUzbzhhr5tKBn/zuS4bPi1VOS+RK6rcJLdmQkxmiCzERFO5fkGBWonMj1/mD
 buLgP8fsX3UmT+CNrQXkecm5nelVOA4swrBarOV11l/Qj/fJXBuqn7j80X6voSDf8VGq4w2vnhw
 +3xwRu3aET3PXSTSee+b9+n4E0Y8nW3tUjMRm4nUwWRzH9yshidotgyNOjCu+skwGo5qEdHxUve
 azXLsLqySlLzg==
X-Received: by 2002:a17:90b:17c4:b0:35e:27ec:dea with SMTP id
 98e67ed59e1d1-35e42854de8mr16363251a91.23.1776124112539; 
 Mon, 13 Apr 2026 16:48:32 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:377f:61ec:6edd:e205?
 ([2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35fc6e75bf7sm101054a91.9.2026.04.13.16.48.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 16:48:32 -0700 (PDT)
Message-ID: <170ac49a-c65c-43ef-984e-61602451e188@linaro.org>
Date: Tue, 14 Apr 2026 09:48:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] target/arm: Compile mve_helper.c once
To: qemu-devel@nongnu.org
References: <20260410200628.19378-1-philmd@linaro.org>
 <20260410200628.19378-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410200628.19378-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/11/26 06:06, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/tcg/mve_helper.c | 2 +-
>   target/arm/tcg/meson.build  | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

