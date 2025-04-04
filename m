Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163F6C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 21:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0oyu-0000bh-SO; Fri, 04 Apr 2025 17:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0oyr-0000bB-Sj
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 17:53:41 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0oyq-0002P0-6k
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 17:53:41 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso1490548f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 14:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743803618; x=1744408418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8uJU+qZ/tsBYJrCMGjfzMLRX0rTu2jwu8hxqqoKE3Jc=;
 b=Pp2EgTl0SGq5Hb2wV84comYZSCetq6CYyHpZxKBTzNyiw8FGAATqg5Z+a9Halhtavy
 FgrlBz7eM1vvkCTbJZ0xPxRUGkk2ED4UP0vvQXCtNfNWHMV4OpO1L8WP7f+R1w2iJjNe
 4Phk1KmL4zUkRMCGd/Vspd+o6JyGSLmdyubXog64+P7jIK4+zsAo50KoaZgaoHayytxX
 dmAmuY/TiAY93JfoSSUn43TVc4bU28pFHJTOipC3TSkX4XavYgCVUmGohiE2o7hVH4wK
 HIpz1tzUjWMS2H9xHR/0mkP/d1DvUkSaCoWu4wkNMCvKaBv9vqjTyB9wMwhLio4ZnRtQ
 6Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743803618; x=1744408418;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8uJU+qZ/tsBYJrCMGjfzMLRX0rTu2jwu8hxqqoKE3Jc=;
 b=fGjDYg6XOYFZyGF9EQUTYi6XZC4xU9XuzB3U2WPdLnu45VgFxfgXw2RSLX6xXQgHCX
 DtKDJomXpZTEs89V1V1rZmp0asEur3kA6kRbeatEyLYlW7Uven3EzHZfqO7HPPa5NcEG
 1GuhEZ1MGmV+YYTvvoudEtlphjT/qtyOa3MjjuLdh0Hiql/M66ge9RD34VzCkr6tN9ss
 CmKu60RPKylF7bYzxRnXX5j+opFjzgUU8foj7LmlnZuy77ZCS0NJLajL6L/UGkLe4tX6
 zRZbMfoycbmHjpTEwN2ijbQhff7jB+6pZWxodoVqdwi8ERgBPQSwmeKZbFuhf5W/0gRN
 OMVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhclnvgiZoOaVj2GMhDSGhWPaExqixklNdOl0rum3ITNHVORE3RNgz4RSAFWRQY7vuRDFAcQQAGxSl@nongnu.org
X-Gm-Message-State: AOJu0YzE80DRZ86PeOWdcOJ1y4+5BAssbUPvQ0twz/DhCLfQqbstu+Ro
 8akQT68NFYf3Sk1b3ULbgDRw+MLLE0q402bFDaig+sNkYk0/scd4GS5U0OCYt2Q=
X-Gm-Gg: ASbGncvi26AK3PmlmeyBYNkrlTNxL6Pj/NhrYUNmI1xrpTcH2Uf7VZXz00I15/DtrO6
 ofJAEdMg8ljo+PexMbt0X2tyfeFSQjr7xmvOK3cOnSm1xcIqzqkxXdKPT/DT41hHUxFf73tvmVQ
 8Rg2zHw1+N/aU4fGsn4BB57f+nMIMTDVeOvabGjCfAPYaYFComikpCcbFHpMi/X62fE5mR0EzTN
 qfqFeU/Jg/TaohnTC5z3aOUF3UjsUrfIE7odNdxkn/ukqa7ZSTbG7jMb9QLbHaVb/qMb4FuRoPj
 MlciYt0k7qgyOWfPdBk7QxHXI7sA3UDiY6qRxD6DFIrItiiLaPzad040qdaBD/ruClEEikI7lwl
 Tj1CpVe+Wo36/ndT69w==
X-Google-Smtp-Source: AGHT+IEeU+eCYaSoqn0Dgk3FjLX1QV118UsDi3w8cEZR/z6SsggRbGxc74MrP1AF+nK6SI4D96pmZA==
X-Received: by 2002:a5d:5f52:0:b0:391:2fe3:24ec with SMTP id
 ffacd0b85a97d-39cb3596c9dmr3753358f8f.14.1743803617825; 
 Fri, 04 Apr 2025 14:53:37 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d63csm5438373f8f.69.2025.04.04.14.53.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 14:53:37 -0700 (PDT)
Message-ID: <a3d5cd32-4a1f-4753-8536-43180229721f@linaro.org>
Date: Fri, 4 Apr 2025 23:53:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 11/39] hw/arm: Use full "target/arm/cpu.h"
 path to include target's "cpu.h"
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-12-philmd@linaro.org>
 <83a57c49-93fd-4463-81bf-fc0014ff5f3d@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <83a57c49-93fd-4463-81bf-fc0014ff5f3d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 4/4/25 20:20, Pierrick Bouvier wrote:
> On 4/3/25 16:57, Philippe Mathieu-Daudé wrote:
>> We would like to get rid of '-I target/$ARCH/' in the CPPFLAGS.
> 
> While this change is correct, this is not strictly needed.
> With the current approach, using a set of common files per architecture, 
> we can rely on this include to be present, and it does not block from 
> having common files.

Indeed, I rebased this commit from my heterogeneous branch.

I'll keeping carrying / rebasing it for various months, trying to
remember to not keeping posting it.

Or alternatively I'll post it in a separate "cleanup series", not
mentioning single-binary or heterogeneous emulation.

>> Use the full path to "cpu.h": "target/arm/cpu.h".
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/arm/digic.h      | 2 +-
>>   include/hw/arm/fsl-imx6.h   | 2 +-
>>   include/hw/arm/fsl-imx6ul.h | 2 +-
>>   include/hw/arm/fsl-imx7.h   | 2 +-
>>   include/hw/arm/fsl-imx8mp.h | 2 +-
>>   5 files changed, 5 insertions(+), 5 deletions(-)


