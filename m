Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B60DD735EE
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 06:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHGmE-0007V0-MD; Sat, 30 Nov 2024 01:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGm7-0007H0-0x
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:16:16 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGm3-0002ti-Dk
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:16:14 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21285c1b196so24808875ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 22:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732947365; x=1733552165;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=edTZ+SkrnE/JMBfnnHqKmdSdnVM2/S+y9Q27JWUYvuY=;
 b=2bXZe2YWuXB3Y/v/48XHvcM41ifr7J5f25bSSTpSMG5CmsQT4Lz7rJ/8Ei8kFJfm+Z
 Io7S9zwNya9u6b2C7Pk7dk5bFasxDtgV5SfQ5H9pvU31tcKcy4Oi94jL5RkUeMETmkxX
 2e8ikyhUbgPL9L8u5LwVAP2Vo/Z9TeMDTX5o5kvzmlPijnuoXLRTmLfxR45g/uh/vtz/
 ncNPTA+emmGdaC/Y+QA309myI0XJDg5sTVVLClxacXB3bCv/fL202Hz0iAFf5/iqgyzr
 qmm5Q3ZC5xqfxPs2Yetc+eOgwTXpqT4mnO1LXIRRCKWin79SMpIvqP5tCGqBRrprSvW9
 3I3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732947365; x=1733552165;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=edTZ+SkrnE/JMBfnnHqKmdSdnVM2/S+y9Q27JWUYvuY=;
 b=JMADkV2WCkGQQbv6p27dZnS9dNF2iDPxSP+ATZbVmZUaZo7i5a2wtailOOMcEscxO1
 W6pO7PkhGZrlBYmk0thH1vt9lqSxN+di9OzmH1M7PJsK3qgP6VpfB6ZZy4tao2G3VbYV
 EsulzNAwEQRkQ7oULucD2k+9eK6uP8IilbTaRVTKOgg+n3taeUNHX2f/6zVxQj7ywmeu
 cf3MZEOPyZk5mlW1NuzD4c7JBQBPFC4zz13+3ZMqW+eF0Z0M3p6ex62ajNEab4mhw+AQ
 BEh2jaqkpD7kA5r4MNMC31gPx9Yubrk6rxBBQr3yDyidX12QdVwm8xL6AX3ZpnTDPpDU
 4Alw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvTf6BcJbQfI9OpzLE7LI0pn9pZCl19U4amWDK9hMXNGbWT2I5qqy0sixbQwij95xIzRn2Vk/twoKP@nongnu.org
X-Gm-Message-State: AOJu0YyYc80sudbG2DYawoC6SG8yHBnO0fVZ+yXRhZw5+x+2nI3ZWbU/
 Fa2cq6lVwcrB+g5HLCAokVRwD47jYsvbMKWQawK+duP6DX6kUEPqkmSBzpXhvyE=
X-Gm-Gg: ASbGncvuzoUHL/t8Sb5LCBHE2jWKLwZv2Mtp7/wqX1UiGmaSKDLP6jM+EinWOks5m4j
 7VgdO76QHJhiIj78+q8XOFZmGU6Z73gty5cNV83XP/1QKmsQTOytPBluSOGnq8S14ZREOjzpzQF
 T7WvnGdszRjaWuUq9aPfTkO3sLc6LIIuFkwJ3BATn3tiR1UpnHuRTr7QKrXbotDOtUKpfCiN+k2
 y7sUkcA+SBzSQpalqOu2/EO7uL9/4khGhxjAu6i7uLgxryIgIoWSn2Zcc8agOg=
X-Google-Smtp-Source: AGHT+IHvQGamfokwJK7BI5T/fHPuhfGXHgs1BtPEnCH47dccAO21jGQdlWeZQf3rAM81vx/+8NxV8Q==
X-Received: by 2002:a17:903:364d:b0:212:66cc:8110 with SMTP id
 d9443c01a7336-21501f63cf0mr188002365ad.51.1732947364737; 
 Fri, 29 Nov 2024 22:16:04 -0800 (PST)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215413d3408sm22526655ad.159.2024.11.29.22.15.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 22:16:04 -0800 (PST)
Message-ID: <2a9bd2dc-9030-4074-8e51-8f902051a3f6@daynix.com>
Date: Sat, 30 Nov 2024 15:15:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/15] gpex: Allow more than 4 legacy IRQs
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu,
 Alexander Graf <graf@amazon.com>
References: <20241129152506.59390-1-phil@philjordan.eu>
 <20241129152506.59390-10-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241129152506.59390-10-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2024/11/30 0:25, Phil Dennis-Jordan wrote:
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
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>

