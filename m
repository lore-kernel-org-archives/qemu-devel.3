Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24095C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 15:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1radDW-0003DG-EJ; Thu, 15 Feb 2024 10:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1radDV-0003CR-E6
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:00:01 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1radDR-0001Ep-RR
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:00:01 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41205e19660so6929245e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708009196; x=1708613996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Scw7mWZwOesiC9kjAItUYQqno2Y53ika4VsIu9enHpk=;
 b=sTLn+1WeFZ/K/cFAFZwmFjbWo7TacSe5ZWjI7J7lv55uXr2T5MZxInaaQoDDqNZ4+3
 Hg5C3tTLtCTCScugUad+nF7IPjm3o0+FyOgmMZaU6ccgJMCiF1QpPppevBkK23BCtaYS
 2Z9gApOruVpVvWNLkPLIxrbHyQSIz4k4Ep/uwvMmzWA5jqGZ2fyqizv+2f+wrzcopRFh
 k4xSMa/OFnJ+IyUOk8Abinup0VQTZvU1FtKeK8R6K9Ris4hRYbD316SmsnXgf/zxr2Qc
 LqZtGWOR3CgUiqoGJXOBrW0Sp+H43tPdf/iowGrGDTM2SuQ4KUB/CyjPg8OCxdioGQGm
 8cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708009196; x=1708613996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Scw7mWZwOesiC9kjAItUYQqno2Y53ika4VsIu9enHpk=;
 b=RYYbK5XveaAd36QtbB0yGL39P3fq2qtqrOv4aDEGbjdlE4ZQGyeXeVQgtDeNqjf7Y0
 K70dcDh7uHhqe41wy28v0SP5XNQMFsXJdbBfGqftfuJjsHH3GIAVj+c5gH5K/eTU/YSq
 vIaxvUU617e0rtk/DsI2TxB3Vkk3CCvqJqm0y/FURwC/6xyW6S9AHfHt+/j/7YT24d0G
 GP27kmqfc4qqxIZ8mgvQp3w1zVRsqYniu1zcYat5kXc300CblJAND/rR2Elmy5ugbI//
 6jkm3+0BIShTdFpbkImz9va1iLIRyNbaopMH0MTDZCqaavur5Cabrcf0kDxO+cj5YOuG
 gBMg==
X-Gm-Message-State: AOJu0YwZMocEL3d9CRSQUw+gRnKCeJXEIt3lKfk1nE407qU5wu2AnI1e
 6F5++To528eCBqdwJxQ4sH4F8Au9BPjs2RM4KHvTW+5eEKiUjKzdrKNwe2hxHxV5vu5SnxB//wD
 /3U4=
X-Google-Smtp-Source: AGHT+IFoQjn9MOharayAQZLJaW5gKWNow6jGtGu9nuegCBrS48/wa1dre4Q9Bo7itD8U3wC5uyO0BQ==
X-Received: by 2002:a05:600c:4f4e:b0:412:943:9dca with SMTP id
 m14-20020a05600c4f4e00b0041209439dcamr1766617wmq.29.1708009195785; 
 Thu, 15 Feb 2024 06:59:55 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 hi11-20020a05600c534b00b00410dd253008sm5274074wmb.42.2024.02.15.06.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 06:59:55 -0800 (PST)
Message-ID: <6b3deedb-2a9d-4ed1-b8a6-5bb43b77b6ff@linaro.org>
Date: Thu, 15 Feb 2024 15:59:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/sparc/leon3: Minor cleanups
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240130113102.6732-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240130113102.6732-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 30/1/24 12:31, Philippe Mathieu-Daudé wrote:
> Minor cleanups noticed while reviewing Clément series:
> https://lore.kernel.org/qemu-devel/20240116130213.172358-1-chigot@adacore.com/
> 
> Philippe Mathieu-Daudé (2):
>    target/sparc: Provide hint about CPUSPARCState::irq_manager member
>    hw/sparc/leon3: Remove duplicated code

Series queued.


