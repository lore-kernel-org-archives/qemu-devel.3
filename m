Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B384FCA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFUqH-00083y-IB; Sat, 10 Oct 2026 07:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFUqF-00083a-LV
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 07:02:15 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFUqC-0004nF-Tx
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 07:02:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49fbb2acc90so1630505e9.2
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 04:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791630131; x=1792234931; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WgbWk7Vca8kiyzRWUQBXqP04t299FF3XNSJGBMsqZPE=;
 b=c3zY9YOb+iBr5Qa8DqgbLZNZZxQW7ZjGex7aO7hk3C2Ot72NvU0SmEDMieegDbH2Vh
 jezkt2qUDXJhvgCoMNqsNWgKz4U5kIID3C1uuZE1HrsLyzUXFyRMolbj1DU4jj0pp8a3
 9+xu7jGmOuU0Gv/fVMDyMvGaXj8Exr7ow0f/tOAvN+iPdnAIhDSa7v0NA9jgVJpcLsIs
 W6FSvdXHr1AzKSMTTtnoQ8TGo+pFeA2P1Mw7foG7nwOlOGkHI07QMg6zE8fuuEEXefeF
 pB3OgrXroKpvhNpvtEaoegFrAW/RjShl7K6w+2Di3Ply0c8FLPQtYqDnZfdEYuGR8jrC
 gvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791630131; x=1792234931;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WgbWk7Vca8kiyzRWUQBXqP04t299FF3XNSJGBMsqZPE=;
 b=NW/dLtRn5avT5wVu0NEF6cTSKa3vVdc0BqD0gfbip1FOXDubDLCBIgpYl7QWTgCuxL
 Y1vlQJThcw7ocGbXZcYlE/o08fj3qLZ4CH9kmgT/32dEtXsTVqx91M7qzWv3AOnI29+4
 HJ3YxkIEpfPNdc7Y00vbf1BrXUBD41qHKzM7lp8Tak+HQRfUhfAJ1K/QvhFu6ST7uRB8
 ruSCs8DQaHdnIhA0z3pj03C6ObBOrh2IFKc6NJrnUgWzkDbB/ZCZhTspvCMOLlBMign6
 rn9dtQBnkYZ0n7HILyNYFWKpToJfI4tfdZqt+3QQ2K+tqfE8eXCIAOlYHpXnvXezLVGn
 YRGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx99a4+TG9AobOILsC7uFe0YKJp48bHZpValV1lSsHd5R8W3BYwQyeii/5DSmrwWkNnPG8euzAKjvh5@nongnu.org
X-Gm-Message-State: AFq9FYIti96oigZsKQJ0JOXbNWKM3wQo7JSINbN7sAALXhcgXNucaXS6
 Q1qZWmV+tNesEkPjc1zfKfUGmY5zXKxhvyYAEGY30QwlQvTSJiyAWzhRDyFvt7FRsCZZNBrz4s3
 De5zGCXU=
X-Gm-Gg: AYBFou1d8W/v9cH98z5W6loGmJNd80igE4IQeka3eJS6Wnu2mPrNFL4pasR1Z7rj0T+
 5e7Hsgc/Twyc4Abh5dlJ/WUpZt+sngSZ930uBrAxEme0haINNSY/NKMYUmaXuO4AUyc4aEEcTud
 HhQ9YyOuJO+vARy/y0BCu8hzx+dWD0xSGVsdUJ4ikEAm9EHdx7ItwIaFPtCFRjnnoajm2pHk+nk
 xu8j71NKgae579Sutl33W8zl0fd8kQpRsAechnm3qSJAgGxd7D6zhJrf2spsPUi/GB08JIH5cA1
 UyerBZAMMl6r8DD2zbepbDBatnKWBDOmlkarU0FP8Ery6ccqnKeptzba/7C7O+mV0QfsEwFAhvA
 +mMX0jh4b3kUbWGbpf0Rn3j9/i3+8+xM3mtwXLI8Hg0yJ74s6srnMmQ4AVBGnKxvEuaT8uxNOix
 1nbaM8pz5cx4N/qfZi4JAjapcN/UehZ6tGgkmsmnBbD/umBgmKri4GaETjCq+X9/1hFwsgCjcWc
 Ovx9pbPTkJY4T2EAUvk/4M0SxuJAGjeeXSp1uoKxdkLZR9JNPSk+kQ=
X-Received: by 2002:a05:6000:4719:b0:48b:6d3:a6f with SMTP id
 ffacd0b85a97d-48dbace3a43mr7978020f8f.44.1791630130705; 
 Sat, 10 Oct 2026 04:02:10 -0700 (PDT)
Received: from ?IPV6:2a00:1e:e082:2901:1896:21cc:25f1:819c?
 ([2a00:1e:e082:2901:1896:21cc:25f1:819c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9acfa28sm8729152f8f.51.2026.10.10.04.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2026 04:02:10 -0700 (PDT)
Message-ID: <77e10e19-47c4-42c0-9ec1-562c55a45bd4@linaro.org>
Date: Sat, 10 Oct 2026 13:02:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/aarch64/tcg-target.c.inc: Correct register MIN/MAX
 instuctions
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20261006-jmac-4609-cssc-fixes-v1-1-798505d4a4a5@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261006-jmac-4609-cssc-fixes-v1-1-798505d4a4a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/6/26 22:19, Jim MacArthur wrote:
> Some digits for these were one position off.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/4609
> Reported-by: Ayoub Bourjilat<https://gitlab.com/Bourjilat>
> Signed-off-by: Jim MacArthur<jim.macarthur@linaro.org>
> ---
>   tcg/aarch64/tcg-target.c.inc | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Oops.  Thanks, queued to tcg-next.

r~

