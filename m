Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2FDC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 23:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0q2U-0002cw-FA; Fri, 04 Apr 2025 19:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0q2Q-0002bG-Me
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 19:01:27 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0q2N-0002rV-8h
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 19:01:26 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so2113777b3a.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 16:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743807680; x=1744412480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2lC4RzCqg7I4Szx9S3dVxC7iKAJYJ3G7HjFeFI0Fol4=;
 b=El5GWrV6CQqC+3NoiL81Qd5TxkSJbKckda6xkz5Kru0IYqcbnsy4Qmqe2+PrRj5d/A
 4SthkOHznTbM9oB2v68+a/0BdD3lsAJ0hzM2+Vm+88iy+GFOaJXlAIRB7yDUKOf4Sjt1
 07lnyqZ8kdvrC8DdGvrDAlpN1HkPtlU58Xb3H3bt9YBrjgQ4FG5Ad2uiSwLpqCA+o7G2
 4M626AgOxR7ZHM3Z+TlzaN0WxA8n+ofgeXgWeKKoqcg2QrxGWSZ11Kt2+0FKs7ib8KDC
 vYmuL+Mdf65Ln4P39gf3wOzlN+enlYbyV4c6y0N2oivdbBlF/Iljau5CctaxCva7GLBn
 leDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743807680; x=1744412480;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2lC4RzCqg7I4Szx9S3dVxC7iKAJYJ3G7HjFeFI0Fol4=;
 b=RC3vQiEdST7Q9FbMp0q9UVUOi6td0D2ZsDi7UOq87eBKr2sgFw+JmucZGiRm41biD2
 UnHVz49ATKjpXi5+1dMRIeEsEe7R+8Jl8L3QX/oPGb4sZ6evhvnWJKKroixqwITuEzCP
 vrGpRnu//HrgjPoPX3kJiiaMX6WA3Bct2OKQbThDF33Jl7SbbTkiK413d718yH9FQ3rM
 /SJV2n6ZpLP/5OLCLfVQkvRalPp7m3N9NXsUyBqXbtONOlCUc0m8VoHxbu9d3LQAYLOi
 8OBNkaYAov+aREJBJpkwaO5dL3XL8AG0zfv9XkVG0FvNFsDGDawmVlqrG3qg0vXxeMgp
 GREQ==
X-Gm-Message-State: AOJu0YwJ0OktTGiaetXDtDZhMKIPEzNMk/8MnXfoww2knJw5Qay7FXOm
 oKGAWqBO/PS/BNrPJoAdD2H3zO/vDtpiB8WFnshrxCVvW2zqOfKwbMrrneQYTuNP9e7wCgdamLN
 n
X-Gm-Gg: ASbGncvpKEPtXduB5hS1w4fT1vjv1CRBxW8v86jsnHAALBvZxbib8qnzDvLJCzAhPn4
 7OCqxL0yowFN/9HreiM2nIjWkBPU4TNxk1zOJ/xxdmaFC1LL46mYL9kcewgCLVFZiNBh6yXyRJ9
 yhQQlQB+WIO+PS0IbqcnI/g4QqgqVfFqwfAygi+xUJESAumwrGLJX8h4L99lAaNZ53t1UWKSTfu
 JIm3hY5irbv56N2d+qAZDGMX8I5pJ2n0omysjBXgAqqu5rk2jRJAWb33yjdmjVhKb0CJbq6S2CD
 BeFP4nVkirhFe5WD2pa6L75IpR+/lCVLFyttCvAZRKTNpHYdsoWAR8ybWA3G0t9m
X-Google-Smtp-Source: AGHT+IHbD8nXfTpzOtWmnLb8mQUAFRc2NNiHUOT3Mb0KXt+bMNCQM1eWIJhraz7LxMY+whvmVlJG2A==
X-Received: by 2002:a17:90b:3d09:b0:2ee:863e:9ffc with SMTP id
 98e67ed59e1d1-306a61796c2mr4986069a91.21.1743807679750; 
 Fri, 04 Apr 2025 16:01:19 -0700 (PDT)
Received: from [192.168.122.15] ([173.164.107.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ad9a0sm38250265ad.39.2025.04.04.16.01.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 16:01:19 -0700 (PDT)
Message-ID: <debc3677-3282-4064-a34c-0234d0eb7a78@linaro.org>
Date: Fri, 4 Apr 2025 16:01:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/riscv/virt.c: change default CPU to 'max'
To: qemu-devel@nongnu.org
References: <20250404152750.332791-1-dbarboza@ventanamicro.com>
 <20250404152750.332791-3-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250404152750.332791-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/4/25 08:27, Daniel Henrique Barboza wrote:
> Using 'max' as
> default CPU is done by other QEMU archs like aarch64 so we'll be more
> compatible with everyone else.

This isn't true.  qemu-system-aarch64 -M virt defaults to cortex-a15 (for hysterical 
raisins), which is completely and totally useless.  Which means that one must always pass 
a -cpu option to qemu-system-aarch64.

Moreover, -cpu max has zero migration guarantees, so anyone who wants to be able to 
reliably migrate is encouraged to use a real cpu model.

I suppose, for throwaway VMs, -cpu max is a decent default.  But there's a lot to be said 
for not specifying a default at all.


r~

