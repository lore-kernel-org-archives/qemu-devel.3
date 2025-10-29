Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AB8CCF9F6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1wK-0001Qp-PO; Wed, 29 Oct 2025 04:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1w9-0001Lx-Ln
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:53:46 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1w3-0001nh-2d
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:53:45 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4270a0127e1so5486578f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761728014; x=1762332814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c9Ry493TIeYYB3WvDgzMv0XvkMPwvN5qm1kCQze7AIM=;
 b=Bwk1AoH9C/WHvPv46b3Cax2Zmd5KUfaJQXzEExlK5hqFKpKIjJOkh+tvVySKxhzdv4
 SMsSb7mS26he4kW6zntu4cIQk80xqJNkHCK4BpH8uluUfs8nyS7/eFZbMAPEKyUjUfm7
 lL7EppD85TASscgWdeXfiPsGol78ygTiMyWqv1F/FQ74MH8MREZbE2QLc/EznNMhIf5q
 Z9OO9HhCLvLD36cgoyq/P0t2rAJEwWhlPHV69l4Ip4Bjhk0hyhJHC8IpBVYrwPmd6m5+
 sV4tgZMNRERHcaQDhbDJNQC7YTsToHK3TWgQ4540QHyb93nJpfJqBJe8SGSqvJ/W29Jr
 +loQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761728014; x=1762332814;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c9Ry493TIeYYB3WvDgzMv0XvkMPwvN5qm1kCQze7AIM=;
 b=jKwLh2cUJLKTXY3NzmJx9CUgXcSaVrx5i66buaSiApwm1dF3oPs87n3X9OP/W0oUfV
 utOhIun3IkX29S6atlYdlLQCdLFFXDObpjMo1gz/t7rYDBhvrTNnE6npw1IF6367N8H9
 vHv5fRXXVsSecXN3EPI84uaBoQBNxDzdN7+vqIdd/ENND0o39sU4+eVDS/KQljya+wkh
 HDeF9KIm7wuw9OhafhzvHaenyQwtVCu0v3KBik8PMLfGgTNmZWMldVLtBTGXMU54ml87
 gi+6kEq3YxCHfJypOs/mVovfALuallHfuknwyoZn9xu0XnQw4IvRDT+Sfp9WZFMbrdo2
 jyDQ==
X-Gm-Message-State: AOJu0Yx6Qrree9k05Nd+qHQmG9E3p9tNB7PYRba364KmOWi9AZGb6fpI
 mzUMPnPZx9/z2zDG4YV1PazeGKOSn6GCiiwtTzVDy+TtuHwuDc+lehx812omeBAm5+5eAuUuDaY
 dEt9oDYQ=
X-Gm-Gg: ASbGncuwB+5OFe06gquCGOkhQTy0eEelMoAjQJugcTg4ryJlD43/lZIgxUYwqgYBQmo
 52kxwzkULZ+Vw58RpcPEPGbjdqTrh0mvPSSs5lILd6iQ2jFll9LJ+Er790738rNedEGJwlHT0Un
 H1CcoUh5WhhwOsdyghmBS+ZmakUn1ObBnF6WbTTYeSbVtu9ivp8lAM5NQcuS9yWQLGqmvC+b84u
 3EPHjjRDq7/1nMCfFbpVj0OzAcN7OXAcgUkFqtKrsTuj8auBer4YBwG0CkzbmmkRabErBW5hqc7
 FOIkhHJJHlPfIDyl1hk9/on/KMAebOinLHjyAX+OdPxRSgbcyGOM3zmJbl5NlzmmmO2igxHDx/j
 fjgMPVYSaSbx1fBBl/syPi3flLEPFN703+9CW+X9TmewoR7WKm1WHgeN+Fj+b+hKs614Qli9NHl
 xibaxEaKhdP6V1g6KY
X-Google-Smtp-Source: AGHT+IGtIYDdos8dCOBZzBfVlIrTXjAJePtpQ/izMkLDnzay1PczQKYWyI7dzoh8/2ffcfkNScdCoQ==
X-Received: by 2002:a05:6000:2383:b0:428:3cd7:a336 with SMTP id
 ffacd0b85a97d-429aefdd4e0mr1498471f8f.63.1761728014476; 
 Wed, 29 Oct 2025 01:53:34 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d4494sm25489405f8f.21.2025.10.29.01.53.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:53:34 -0700 (PDT)
Message-ID: <7e35897c-39c4-4633-9c3a-147acc3496f7@linaro.org>
Date: Wed, 29 Oct 2025 09:53:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/25] hw/sysbus: Remove sysbus_mmio_map_common()
 @may_overlap argument
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-24-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> memory_region_add_subregion_overlap(priority=0) is
> identical to memory_region_add_subregion(). Just use
> the former to simplify.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/core/sysbus.c | 19 +++++--------------
>   1 file changed, 5 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

