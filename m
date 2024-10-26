Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7C2D10BE4
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 05:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4ZFW-0000ju-8l; Sat, 26 Oct 2024 01:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t4ZFU-0000jD-8G
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 01:22:04 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t4ZFR-00060m-TA
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 01:22:03 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7ed9f1bcb6bso1760157a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 22:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729920120; x=1730524920;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ww8Iskq/8oBghySyWBt6sP9pJZ15tL0TXiwn42A5mRg=;
 b=HO9AkuaUNTrxpCFjydvztrleGZtcQ5zmzgg78GnvlH+tZ8Mq7tZL7wwgbePw2vQq3F
 AWw9TpXvr1Sqlm7uG/tYvAz2G+0HaH1Krz/bvXHS5Amh1na6j+0VgtuFAQIYMpdqmTG+
 rlTnVuxu2yvDawUZOTv6fR3SgdmReJ0IxInGDGxg6eEjnDpdY24E6nCqL+KpeqM+jOMQ
 cPb0ftS9ZsPO7ynZt+lyAA2A2w++C1DMIYdEdvNQ7z1+ezE93XwZvVCTXUeF03SlA6/x
 NKoYhN1eUnrbrZA8CQ7T0AKGI5c5iP9fLzSZ+vvyzYIQvVNh4zhgAtxLAlRjqNjLeiYe
 BFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729920120; x=1730524920;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ww8Iskq/8oBghySyWBt6sP9pJZ15tL0TXiwn42A5mRg=;
 b=PHkmmxSVIhEXoySeRiQ4GEklpZcQK2UE5UBPRhMSwX7Ey445mp9p444IjJS/Ff4Lgd
 kMw46MBaXkJ2OiGijk6/bElX8bvf8Vyt+PrVKZZieJj7xNUhTYUcvv4CcWPOcpOTWM5E
 JFsb/sUU8rlSEKSY7731HL1gqU19I0AjUzChRG/JBxXy5nVzTRllpX+CJHRBCO8ozlwS
 71fGAoILukP8s/MJOGMn2x+EpCFXO3UujbHpzGV/oj6InPJQrh+DUAc3H6eHTjUZVBdZ
 Ok19yU0Lh3sv4hP9WjaZIY9qXU6Xq+slRLDxfjOGUIFIBeRiZrW+D3hbU/fbFHlewCrN
 MhIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIig2uA528a63q7x/Duf2vnG5qHqydIYO/paYy8fXsRgnXSA+3BJXYF/Mov9Dl1A0oAQ1V3CEP/q5z@nongnu.org
X-Gm-Message-State: AOJu0YzKHVFHk2ykaP9GvmYX8yaF9q+FqikzE7O7cUUj+T+3o3jqbzOk
 L9eBGaY8VuJuivHrICZ2p6XgZMp37C8bF6NVe1+gmBv+ttKtRtVMvnmxTKucJTE=
X-Google-Smtp-Source: AGHT+IG9S9BzG1V0fcLQIROvVjBqqEFD5dHNzgKvswwKg4oSCfGX2Wk7aNtmd11+Ix0ctw0C6JN5Bw==
X-Received: by 2002:a17:90a:4e0a:b0:2cc:ef14:89e3 with SMTP id
 98e67ed59e1d1-2e8f1071ca9mr2214961a91.15.1729920120452; 
 Fri, 25 Oct 2024 22:22:00 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e77e5a4ec4sm4555263a91.54.2024.10.25.22.21.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 22:22:00 -0700 (PDT)
Message-ID: <cc3be5b6-5a8c-48a7-8558-dc333234d9b5@daynix.com>
Date: Sat, 26 Oct 2024 14:21:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/15] gpex: Allow more than 4 legacy IRQs
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 Alexander Graf <graf@amazon.com>
References: <20241024102813.9855-1-phil@philjordan.eu>
 <20241024102813.9855-10-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241024102813.9855-10-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/10/24 19:28, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> Some boards such as vmapple don't do real legacy PCI IRQ swizzling.
> Instead, they just keep allocating more board IRQ lines for each new
> legacy IRQ. Let's support that mode by giving instantiators a new
> "nr_irqs" property they can use to support more than 4 legacy IRQ lines.
> In this mode, GPEX will export more IRQ lines, one for each device.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

