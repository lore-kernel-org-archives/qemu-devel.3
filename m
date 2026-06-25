Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC0DCDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclao-0005dy-GJ; Thu, 25 Jun 2026 11:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wclal-0005YB-U3
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:02:11 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wclai-0004Sa-3G
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:02:11 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-845369f60faso1869726b3a.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782399726; x=1783004526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0xhOsqe7nS8cQ+6lEyoLyVqzA5GyksaDPUEoc1wWl1U=;
 b=o2USJ8cHEkP9/vnIaQKLzjFEDPn8jHAGq/Og8mpLAQOfZ/zH44hKqe+PuwmI3uTSKJ
 E0QjWVMHnnEd0M94HLvz4rQqPFIsxA7Tla7ZOJitquJc8fTLGcKucmzOJIuoZ0RQjdnB
 0ZWuHtdlE6CmR+HP/4s7iDOmOU5xf39y571DAEeM2/t1mk8RYxLdy//9uYcJm+MKU10i
 4csqXoMcx/w1bvQNrPHWvg9XWB5sN50NwBIW5F+ewREvNBIF0RDtfJ5tQBKGw6+MSwYT
 +FajhGv8JRooHjvHa8o2OZq7rIOZ4bIP9vN5D4I0i1Z6DhVumBl2AIBMTbU4VeBF/7N9
 mG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782399726; x=1783004526;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0xhOsqe7nS8cQ+6lEyoLyVqzA5GyksaDPUEoc1wWl1U=;
 b=Ne+N3FhbqRTjplrkvx+alfljypWEcOJJr6SK28eSASKNkyLjaQr3zXGpFmozn17uJx
 kgLjhFR2PypNI+P3RbK3PVLaW6pKYuDnxPdtfIQ0Oshhmoby9bk98dVKgtwcj/3lAdBv
 yDi5NyteUbmu4MHBNux7GY2wUak/+T718U90NIKUZbFsdEYTnjj2sMlwL+XqiX+FeFHO
 PMzmREA6Lng9TC+9iR+MSxoNp4qrNNBecEFo9bPMhJZXvVO/pWS9sLJJtYzdNy3AbxjB
 nnePyeHGuQ9JhmXK+QEBl7BOV+Lh/qfDB4xyVf9GFhfSdxPjOLWh/CjKXSnJf0gfIJMb
 p3QA==
X-Gm-Message-State: AOJu0Yxe1c43zpYXZiwGah2EtapugTfdP+DtkxiyinB3g5vBVluvg70+
 KQdC5fUu24Ec94XV6IL6ku9xLguH/SAQjzbSpDUg4gd4aH7kiaQ2YIgkO7BdM3CfTwTqp+GhYAR
 DRbDd
X-Gm-Gg: AfdE7cl1PrLB4VvA8+f4m4lDfDEN6zVxQiimdXG0yQLEbC/xVFAcrKA2xnRbBhvuFGU
 RBIVhI2QEH5qx/KXyaWtxsb02p/xEOkG+4mIqd23nvreqBBuw6V6LGsmYON3KIV2h1l1BkftyFw
 zW3/9mjnO85eOxzQIJU4n7l5+HIlZL7l7hMAK1j2jODFXSFJ16355sZwY0vmS0m/aHaJOJ0nIUo
 i1IWaQkoVQQY86V42tlYLwl/R6mllxVVkdkwk1LmUcbT70e9AyfWb0B5Fk7ooyGUimsvKBq0j6E
 1nim2Wv+ozIjJ+T7aFHinSljIUsXrwHn8DuwnBnqV4YqgfR6uKqm8PkGDAlXxapbO/XyNlyuMzi
 Q6OrJru8tnscnPFePPompfNl0rfeWchxIjcoWO/tsK0ImkkUijl/14V98q1mm7/iq2RqkZsUFjS
 cU2ud0oPcgkiERAG6cjGfrKq+7gnLDHTMn/QRJ5j/au0deSh4pgOoUOTDRFhe0mHvTssUQ
X-Received: by 2002:a05:6a20:72a8:b0:3a0:aee6:acc1 with SMTP id
 adf61e73a8af0-3bd4ae7b2f7mr3573326637.33.1782399725816; 
 Thu, 25 Jun 2026 08:02:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c92b9cc8496sm1832313a12.8.2026.06.25.08.02.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 08:02:04 -0700 (PDT)
Message-ID: <9600fa81-a466-490a-9ed3-e4a1d0cc48ed@linaro.org>
Date: Thu, 25 Jun 2026 08:02:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/7] target/arm: ensure we create the wxft_timer for
 all modes
To: qemu-devel@nongnu.org
References: <20260624103049.884930-1-alex.bennee@linaro.org>
 <20260624103049.884930-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260624103049.884930-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/24/26 03:30, Alex Bennée wrote:
> We don't want to just use it for timeouts as we will calculate which
> will comes first. Remove the wxft feature test in favour of the
> broader architecture checks.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>



Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

