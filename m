Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E31D591B3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 20:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD8kb-0005fb-2H; Mon, 18 Nov 2024 15:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD8kP-0005du-R1
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 15:53:27 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD8kO-0003ik-Bn
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 15:53:25 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5ceb03aadb1so4692701a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 12:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731963177; x=1732567977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ibrJewJda6kzpIcXZBnn1V6BypHenJzxRUpQo2ZfYoU=;
 b=oO8IyGGvHiyC/IZRA/duTJi1F0mdVRYRZkzUGjhvJrptyCTxYHGVKuMHjhlLF9/0tF
 Prqn6aeI0AlADY+/GFt8to1crKiX4x+ILYvHM55zdXKB3wgPjTYKh9qNDX1NUV7wwcOf
 2w0tvngdeT5/XSke6NuCl8pyXAeG7gbqU6cq55N9T0eCyHPyEB49QHkxczGyXMueth17
 Lh4h8CxaiHcppcrEokfvytak6hF9XMc1cmTnykYilg832TQWymN71dfto/ZRPOeNpv2A
 kkwxe2x3ZS/ngWzOYqwLK1ivsK7zEu56+2Z5LDZlWJQ3KVTgL82a9m9A5Gh/3IE/8oo2
 8uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731963177; x=1732567977;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ibrJewJda6kzpIcXZBnn1V6BypHenJzxRUpQo2ZfYoU=;
 b=vq2o8WSG6urOla7uy4b+3oExkBE9FJ4oAURjB1KO0WLa0CovDxIcLQ4YPFlu//hvQq
 Nz9gQqRxMuUqVeDkF9Pr3LRqhVR6YHEb2X9JLs5eKmG1tWBWxKoWO5rJe+MVE2ITM0x5
 LYm66EPeppxTlxBPLPyN8E8cQw2JG+77cmDD5zxjqyR4PCL6kWRXiRXoGT1gN2LFDrHm
 JC+2PB++8eLguyFryMSvQu/9Vz9v8URvWSSs1JfbCSm+YSRy0I5rexUiCKtAjP2Krb0p
 pPIF5JcXvNh+n2e4C9A8qbKfvKu3S7SxUmHhfgYhmlW6LPXHiqnBhB0Mwc64MmStU8aR
 wr7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeJkgni+0+l4FA2BERY9pj7WWbkhYjmLrYdLN9VvwvRQxzwx8uSl/sNwqUmq6pmswRckKM+0D9aQLp@nongnu.org
X-Gm-Message-State: AOJu0YwLvlnc0DTuHwN6LT5CqNNryg0lYzae77TOwFZIjPvnEcztzYsn
 5HcMfK8FyUGb6OR8SFuzTljpujiiDrKE8QMK/lxN6wD+6QMw5cVTPRCxmlVU+fpGAqO5jlJoHpn
 A
X-Google-Smtp-Source: AGHT+IFF2B3sJtOdYonmUzPQcSBTMXFAnbagLxOER8LBPzenCpjDPueQpkiKUFKmUXelhijZSUUYMg==
X-Received: by 2002:a17:907:7f8a:b0:a9a:e91:68c5 with SMTP id
 a640c23a62f3a-aa483454536mr1147034066b.33.1731963176796; 
 Mon, 18 Nov 2024 12:52:56 -0800 (PST)
Received: from [192.168.69.146] ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e08af75sm578025366b.202.2024.11.18.12.52.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 12:52:56 -0800 (PST)
Message-ID: <0f60c592-3fe3-4275-a65d-ddaa3b735cd9@linaro.org>
Date: Mon, 18 Nov 2024 21:52:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: fix alignment error in tci.
To: guoguangyao <guoguangyao18@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn
References: <20241118133243.291769-1-guoguangyao18@mails.ucas.ac.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241118133243.291769-1-guoguangyao18@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

On 18/11/24 14:32, guoguangyao wrote:
> Add alignment and check for fpr in
> CPUArchState, fix alignment error in
> tcg interpreter when executing LASX.
> 
> Signed-off-by: guoguangyao <guoguangyao18@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


