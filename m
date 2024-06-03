Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8CFC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEA49-0001BD-6G; Mon, 03 Jun 2024 11:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEA46-0001AN-BY
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:57:42 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEA44-00061m-54
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:57:42 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35b6467754cso44359f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717430258; x=1718035058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pfqXv9O156k/qVlRPORBHveRYZBimdALutURsiXGVic=;
 b=xoH/PTVoIlBAmJmYWvFdpafjBiCjGzRiQ+GBgZdFKEOfUhc0X7H+Mha70vpRC17PCW
 mipqiN3rVnSZA8FUlRHG9axjoNGzWiUjqLsAO6J4BQj4OOIgnWsOPk4S/FPdKlJQpT4w
 sJ22oZNsJQ0AVeIXVhX4yV9k92Xb9y98kiFqj/RPKrEd88m5fzMjQ4lxH05JNef6op50
 ogBqiKPBTQJqtB0FdtOiFCiSIlCU1L4kacB3oTOmpQJd44RQrqmiatVjbfBHEONJfrrr
 0TEIlsWKf3L8nITlypkpRO3XBa/u73hGWuuE0PkfcRN5YrPWScEObLRl1WZMGmxb3d+j
 2/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717430258; x=1718035058;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pfqXv9O156k/qVlRPORBHveRYZBimdALutURsiXGVic=;
 b=eO6KdmGikP2N4YMOWbhi4KF9r5jUQdiHZ/qboVB4owxNQ7rIJ0R9aae0fnVlvttt6l
 ZJuWkrzV/GzvwR3agCzqQfY/RX2QiO8YVvjyAiuFMmIbaHdYXot/ZjeZTFlyqWM88shU
 a0959UPI/a/gfvg7z0vVhwuml4mYwF900vIAjc5lGNGwmLI40iOKh8eOVn6T/UtvGN30
 tNxl+8Pq5wRT5EPhdSAt733t0rFA11D7qny1h4zcAwwdblNGMBEnp2ooeWccaNuvKEW9
 6LTeOv6ZkfY58KZN1vrPZSFI27FbAhlGo+O7GPVrx6l9z3poZ4zh+2TnFVZC5kJFOwHt
 EIsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdciSLTGXgMOgjCnAhXHMB72SYCB0qnVLNjoG30CvRl8hb54Lx+DNVcqBoBjQKGm8ZqTA32MopSYEmFjFOwbSf9iMe4/A=
X-Gm-Message-State: AOJu0YxtK99GRdiveIYWyzorRUX20XNsyeJDwXDuiXAzujDBe6I4PSiF
 gy74wkGSWBBwp0LJKmS1HdZc53cvTTwqHvd++JVi8NvKl9uxDlUl8nTdaKnFrIw=
X-Google-Smtp-Source: AGHT+IG0AwImAZQCWL5EcwF+xN/h0jceBRg8jiE8riT+hg2DO7rDBxMnf5lD3Tad7RQSC7AjUj7+Fw==
X-Received: by 2002:a5d:5272:0:b0:354:de21:2145 with SMTP id
 ffacd0b85a97d-35e0f271297mr7022282f8f.22.1717430258024; 
 Mon, 03 Jun 2024 08:57:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd0667366sm8975604f8f.111.2024.06.03.08.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 08:57:37 -0700 (PDT)
Message-ID: <abf1c6da-71fe-483d-8edb-0ebfef14dbcc@linaro.org>
Date: Mon, 3 Jun 2024 17:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/8] xen: mapcache: Make MCACHE_BUCKET_SHIFT runtime
 configurable
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
References: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
 <20240529140739.1387692-2-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240529140739.1387692-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 29/5/24 16:07, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Make MCACHE_BUCKET_SHIFT runtime configurable per cache instance.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> ---
>   hw/xen/xen-mapcache.c | 54 ++++++++++++++++++++++++++-----------------
>   1 file changed, 33 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


