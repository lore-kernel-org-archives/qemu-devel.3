Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2085C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 20:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJfc8-0007dQ-PX; Tue, 18 Jun 2024 16:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJfc5-0007dB-MR
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:39:33 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJfc3-0004uw-TO
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:39:33 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5295e488248so6407413e87.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 13:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718743169; x=1719347969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pIa1SXe6DHWA4kS1mtyye7lcir+hPhPxuuGsztA2gtk=;
 b=Id43MsSaWBCw/uYebsROl0QasCz0mmVzF2A4ZCqpskbM2SGxkOd8TkP7An254sS7o1
 uFGFTNZx2e4MYhRlIzfHVyaRt+QK0chow/5shgTnX1NB/xiEWRfTFsXNE6/NKQfUiFTE
 yVT1n+oOVtag4UPLDyB9/kJ5OR5Htf2MTrLtNjlGIGCBWhXcrSUNuZ9Hq1QnJFOKMUKI
 aDiFQzW6fN+sy0pjr7xD/vJRM1nZxDpNsaRilCZSjZQ6jybRVuz5cWsbXOJCHV/r4muF
 isO/wDnznI5JHeHW2xo9EUobHMKbfy+oua6dDt0hGoMUb5JavqbxKcmaua5DU7bVWQoH
 0LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718743169; x=1719347969;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pIa1SXe6DHWA4kS1mtyye7lcir+hPhPxuuGsztA2gtk=;
 b=AmZReqfn+P5uPyLWDdJZIePdHCpIjo4IsVJfzraC3lu38+/UtqqG8XcXVCZ0n1CdYb
 j7/NPpjF4xctlQ3TdTLhxQHsuO7ZeD7eiK2VJBh4HLNDkcSYs+8H5oUnD0Ywm0HRGIqR
 hTbQ0tn4ftZx3QgEuLhQOBNace6yOVyBSxOn3PONt7tMLN7tDRdo3V05UC9Y4prcEE/d
 cKZzaPgVDsJqNIo8VVNdftDi8xUDvvazvqLTPidGdvd6bHe4ZWo+lj5IMDhldH7BywaU
 xrKPxaF1RABsajLTy3mN9vHJu//7Bb8PyQMw6gPbsNMwyE6CZpbCpH3ZPmBTnxe6cF2H
 Dl5A==
X-Gm-Message-State: AOJu0YwOeb1DvW4NJfQnAeIGHpMZFX3ffPeQeZxAHlypDFYxvlqZwPD3
 aIbNcUIDCiQ4x5sqFkQzYxbwusNdyfh/MKvFgPv1RGV7dG8vbsdQqfu7MhGqbzfZlQeTFfOGA68
 e
X-Google-Smtp-Source: AGHT+IHt0ETTRt//IOnCDmiTZwJIAA51U6tZFTy7fFjyaodSBjwJZim3YbEZ1v5zVM9I/FxjUXMqnQ==
X-Received: by 2002:ac2:46e4:0:b0:52c:83cf:d8f9 with SMTP id
 2adb3069b0e04-52ccaa2a8b6mr402403e87.13.1718743169395; 
 Tue, 18 Jun 2024 13:39:29 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42307d5b78fsm152643095e9.6.2024.06.18.13.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 13:39:28 -0700 (PDT)
Message-ID: <557f5fab-dfca-41c1-8764-1976a9a35b06@linaro.org>
Date: Tue, 18 Jun 2024 22:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/76] Misc patches for 2024-06-18
To: QEMU Developers <qemu-devel@nongnu.org>
References: <20240618202032.40268-1-philmd@linaro.org>
Content-Language: en-US
Cc: Richard Henderson <richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240618202032.40268-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

On 18/6/24 22:20, Philippe Mathieu-Daudé wrote:

Per 
https://lore.kernel.org/qemu-devel/68014035-47e7-48b4-b11b-83b219f4ef63@linaro.org/, 
please ignore this v2.

> ----------------------------------------------------------------
> Misc patches queue
> 
> . Remove deprecated pc-i440fx-2.0 -> 2.3 machines (Phil)
> . Always use little endian audio format in virtio-snd (Phil)
> . Avoid using Monitor in INTERRUPT_STATS_PROVIDER::print_info (Phil)
> . Introduce x-query-interrupt-controllers QMP command (Phil)
> . Introduce pnv_chip_foreach_cpu() to remove one CPU_FOREACH use (Cédric)
> . Set arm_v7m_tcg_ops::cpu_exec_halt & mandate TCGCPUOps::cpu_exec_halt (Peter)
> . Constify few uses of IOMMUTLBEvent (Phil)
> . Wire loongson_ipi device to loongson3_virt/TCG (Jiaxun)
> . Fix inclusion of tracing headers on s390x/TCG (Phil)
> . Add few shortcuts missing to readline (Manos)
> . Update ui/display entries in MAINTAINERS (Gerd)
> . Use qemu_add_mouse_change_notifier on Cocoa (Akihiko)
> . Fix Standard VGA screen blanking and cleanups (Gerd)
> . Fix USB/MTP reported "free space" value (Fabio)
> 
> ----------------------------------------------------------------


