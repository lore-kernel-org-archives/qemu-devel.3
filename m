Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74785C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 21:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPqqh-0000RV-4p; Fri, 05 Jul 2024 17:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPqqf-0000Qo-Qy
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 17:52:09 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPqqe-000328-94
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 17:52:09 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-367993463b8so1337639f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720216326; x=1720821126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Famnk2FKpTDwuEsdryBV8iJ8lwuFDU9utG5CZue62t4=;
 b=BzUS34m+NdqmHvcTdkyfGD+sBybaSyVDdJ7E5UOxoUDpOdHST3BiSXxpRY1TsHRBDG
 isf3FsfXLORLaTkrpeOBWvydra5KrXXRDqyKgp6qVBJA/HST8sB98GMcsay9hZ3lJREN
 C7I8F2mwCZZNJDlfz0+HPt3oGcjmgEtvOf7qqF4eSqa5QAhgDpbkygX23ih/s4dLFlA2
 D/Pb53Pabyqqv3Jm6K1qY2CRmfQSWgg6nZw/SPKqlglo+DR/o/n1Yzm14tVIpX0gPS0v
 +1gTWutjA61GDbtsiURi4olG+o5r6zdUOertbC0fUI3vB1m8pblEPBTv2rPUVNV3Upf+
 VIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720216326; x=1720821126;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Famnk2FKpTDwuEsdryBV8iJ8lwuFDU9utG5CZue62t4=;
 b=u2h8mcaFe1+g/srxYL0AtXQ1YyWdlte4Oss7eJhRtOBeUQeQqlRin/aUFceVCCvA0Q
 rMxLjyUSv4v84YhFEmhToWwEUwSxj4CMpDdWXO0n8IerIk/2xOghXjhd/lHMM4oSlGSc
 JE6Yw/Re9pAktqLIG6aQxIIhlnEyz2GqswA3SwV0BGl30ulOgfkGeIOos+qQJPXHhDQi
 C+0JA7Kbcvg9kYqlO0dz+jIZ/nj7msmCC/H0ffBdrUKxUMicuFrJim9T4xzU0U8qf52L
 epGP1xCrB8yd0WMORolZa83nVtMei7FVwCTKzwGJpVAhviXDzoMTRAwLnxIojlsFrUbT
 79RA==
X-Gm-Message-State: AOJu0YwSos0iQ1UQ3xBD1iDsLEUq61jztU2NyF2xLAtCSh7HKC/BF1uL
 GwP+W1Hm681Qd3Jp64zAdHKlkphVwcpT70mQpXPeyVhiP+ZUhS8cfSbq5l8e5y0sjXD8KCDPtOe
 b
X-Google-Smtp-Source: AGHT+IGwo5NMT66CpSOklH84gv+vZsTNwr7bYROsjDiwJTHLUeAaX4UWkKloLH90+28AVGBIhjyUvA==
X-Received: by 2002:a5d:420e:0:b0:366:ec2c:8646 with SMTP id
 ffacd0b85a97d-3679dd63b25mr3802612f8f.43.1720216326406; 
 Fri, 05 Jul 2024 14:52:06 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3679ac6d60dsm5250708f8f.39.2024.07.05.14.52.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 14:52:05 -0700 (PDT)
Message-ID: <186b3369-3bd6-41ff-9288-5be8d295706b@linaro.org>
Date: Fri, 5 Jul 2024 23:52:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] qtest/npcm7xx_sdhci: Use card-provided address (RCA)
To: qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, Thomas Huth <thuth@redhat.com>,
 Shengtan Mao <stmao@google.com>, Chris Rauer <crauer@google.com>,
 Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Laurent Vivier <lvivier@redhat.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Patrick Venture <venture@google.com>
References: <20240702140842.54242-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240702140842.54242-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 2/7/24 16:08, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (4):
>    hw/sd/npcm7xx_sdhci: Use TYPE_SYSBUS_SDHCI definition
>    hw/sd/sdhci: Log non-sequencial access as GUEST_ERROR
>    tests/qtest/npcm7xx_sdhci: Access the card using its published address
>    hw/sd/sdcard: Generate random RCA value

Series queued, thanks.


