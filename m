Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A1ED489A3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgjWt-0000SS-6x; Fri, 16 Jan 2026 08:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgjWr-0000Rn-C2
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:06:17 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgjWp-0002On-Mt
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:06:17 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43284ed32a0so1129816f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 05:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768568774; x=1769173574; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FnxKrSKxFe/1mr96NLsoEHseQIqVRs/wR1LzZw0u1H4=;
 b=WKeUAr7svZ7H2r21asCJoFiIi3Y3ws5pxYx/+MyrgeKlHcjjstgXI31ZUqm1nvfkZy
 rZuUY6R6klkr4ow9DMen6cWi/CKvF9kDkt1iL14QNhB+rW1vf/J69PIC1glly6kEjEg4
 cbSNKhypsQKAv975gjdTdzROFzxQn+eKQMzie7oNpdTMG3m7a+arlZr7Hj9EjIdx5vuw
 fIxLDCS2UVtMBT79hLJAZY1iAB0Q+LgdYDi/PEz/rRbDkIu1wzT8QLlgkmbt4lvsc/rP
 ZG6s4CXYLcIQdzvOixs3Zb0W98tPxIYZK6kzahiW6hZ1zgIKz0QzFdywR0xJ3m6Kqy7a
 v3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768568774; x=1769173574;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FnxKrSKxFe/1mr96NLsoEHseQIqVRs/wR1LzZw0u1H4=;
 b=fVrqIZGGWGrztzBgcXdNfS+k5sJN/AG8DQu2DaG7WD5Qhsn/UF1BmNJKl8GtTARKsN
 kWaMU4RMF94ncWc6zWpgGd4PB01E6upbx230hKPRM+bv88922B4HQbAxbJxr1Dd8AUeq
 0YWeAMkaZIk4aOvR2rLkeSe+pyh6B6vrPgrCq74S6gKT88crno2TSgAOePT/8Aa8KRe4
 q+H6e+gKor7ADyaHJohfyi6EpgoqWnxAHeKSRF6xMUd3rKlUK71/48HqodV25tzxM1dB
 dDX2hEE163TAXhVhpqBtjZGUIRDp8IIlAWkAaML8ghUM792z+Ly7EqkbZqeUkJy6wO6/
 QAMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGklz6WR5K0bIziFFheR26Hm+AIOIxHPnX6mbcpt+DereZgxAdbHtyINKqYoM7rjpyaakAIhzVXJYA@nongnu.org
X-Gm-Message-State: AOJu0YzUE26hgwV2dCAySykxFCubaNIPGWDpHNqAjrObrKFhf2AcJg4S
 9u8k6vRtwEInKMw9bLwC+0oH4LuVu0Z3aetRkIQP8h4agVTo6SGuYBq74mesF4t+Teg=
X-Gm-Gg: AY/fxX4mAFxs59KbKXgpjIqtAdVygCchCBzjijx4GeEfbXIJwbYF3VXA7Cfqc4CmALB
 KLVXmaFlfPfaazaCacz5qd06bJAEAg7xIZXpupltc9InmXwr0wbPT9V6c9oo7E50HQpDWNoNrdl
 XXRUfo8qh+aJqwoSqjV825zK3AZmKghkdNeh0OLwCaBFCtcImazFhaUf0rOe0ZYllM3iXVS1VEv
 +Py+pQ4OTjGqjBNDJM/yFiLvybf+Y5fIjKSsYYaMCb2YuI9PYBvXHKX56vLbVZSDFg8IZwD39dX
 EvzPrl2/dbcYlwYzk58+V0wGPCmP/WE90fcCKek+aPZm9TGwXnbDFy8NAVVdQS8HFykK3lq33q8
 HJD0HdjFqejl8RdTItHybnUjiRjA8je2yfxaMWJ/p1WlBamzBrWfHBS2sA/nPAVVXqx9XHy38Xj
 XGKU/Wkaecjfg+jwGEhy3sNT74ER4t2XruEHd7DoGOjS2krrBaJtGBNQ==
X-Received: by 2002:a05:6000:2203:b0:432:ca6c:7b03 with SMTP id
 ffacd0b85a97d-4356998b122mr3454412f8f.26.1768568773853; 
 Fri, 16 Jan 2026 05:06:13 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921facsm5056374f8f.5.2026.01.16.05.06.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 05:06:13 -0800 (PST)
Message-ID: <8838d003-b1ed-48d6-a6f3-f1a3791c0a4c@linaro.org>
Date: Fri, 16 Jan 2026 14:06:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] all: Clean up includes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20260116125830.926296-1-peter.maydell@linaro.org>
 <20260116125830.926296-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116125830.926296-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 16/1/26 13:58, Peter Maydell wrote:
> This commit was created with scripts/clean-includes:
>   ./scripts/clean-includes '--git' 'all' '--all'
> 
> and manually edited to remove one change to hw/virtio/cbor-helpers.c.
> All these changes are header files that include osdep.h or some
> system header that osdep.h pulls in; they don't need to do this.
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/scsi/lasi_ncr710.h          | 1 -
>   hw/scsi/ncr53c710.h            | 1 -
>   include/hw/core/loader.h       | 1 -
>   include/hw/i386/tdvf.h         | 1 -
>   include/hw/ppc/spapr_fadump.h  | 1 -
>   include/hw/riscv/iommu.h       | 1 -
>   include/system/accel-irq.h     | 1 -
>   linux-user/alpha/target_proc.h | 1 -
>   qga/commands-windows-ssh.h     | 1 -
>   qga/vss-win32/vss-debug.h      | 1 -
>   target/i386/kvm/vmsr_energy.h  | 2 --
>   11 files changed, 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

