Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09702C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZorY-0007eb-4E; Thu, 10 Jul 2025 06:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZoqV-0006u9-8b
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:49:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZoqQ-00088t-II
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:49:42 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-454df871875so1196325e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144577; x=1752749377; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=75aNR8axSs1XN1w+sk8dwCjnWMV7zsdhUQwBYGBiFAc=;
 b=pn03L7Jqju8OM11w+n6kQffDRdWqE55JL0Ucv6VqsX8dbCsJhxxC2w/LcD28Q3VPMl
 OIgeFm4tjMA7dH2K4/FmK2buOp5KcaVkrHLo+GN2cenHRSWp8h+UjVgA4l6qUm6Dm409
 Ii2uclQUa6qVo56FSpkOlAYCAoN2PNF0XTnUQiRCgAUXcNfPXkbyboLsqrVsdMnJhTAt
 joMG7CLYcdJPayEVzEOP92ZJMlaxlxj7K4VWTs4fKKY+8fneTYq4QC0eEGNc0utG9jXv
 CzOrj5aEb5HUToU3cBIyqlVnrd5CzwxdMfpIXWHkZoqsmm5OARIs7wWxk5xAg2pSwsHZ
 zVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144577; x=1752749377;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=75aNR8axSs1XN1w+sk8dwCjnWMV7zsdhUQwBYGBiFAc=;
 b=QZijZ3k1G2K2m3b4lXgiHvh2K7RP8cPPsRv4m78ijYmtWz3EIBxAaWromSwg6GpV6Q
 SBoSwmN5Dolz3jVoaioQHCufdtAAoYMkqjfwBfXCN0Y42WcTI+wioE5SDzgV2sfoeUBn
 mspWgP6f580gaPRJkKFlU12ti931LgvjJIA653U+JRZ7uRW4vDfFlqmYxvOYldk+RgZj
 27GJlCD1G8n0Cb8GLP6tIzDkQcoV1c61KmlUo8/xXd+o+a8TlS0m1hfPbCMVrs+ShD1i
 s05fpU4uCI+i5iIUYTMot+1YFxI81swKFkdi9LPBxPj//yaVUcy5QhSF0YMRKhTd/2ll
 JwSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE6HDj9RD4O6gGjFV9z7ThekA3aOXFl7sdaRSUFeaenp9JBXl8QM7xXe9eFeS2CDjx8m6wHX5WRoyD@nongnu.org
X-Gm-Message-State: AOJu0YyBR9auEw6lX64YtBdJeSz3bEKT7xhWlXDHFf6Wsod/4+I4wzyo
 EHcvvAJmtxiB3U2zO9E2TUUV274sJh37mzMV/AGN/QTzjwJ5l6/BRAjQjDoNOPd41kU=
X-Gm-Gg: ASbGncv7R6Mn3HIJwEbLK/pF+iENiooh0OcMKY008M5p3sowaBZ/vGHQwlIBqxCx409
 KwnOj1P7RC+/YYZELu9q7m5QYdSewrGoZ/MzSlplNwPoPakN2ROmvXIEcXMYywQdLdqsqUDqWX2
 DqycgXtGXYrWBfklMXsoKoJ8kjdwaF1rJ9mW7V12oBOWwhYEwOT6gAqxiXNLT1UrfgyqVWMyE5n
 3JIovMRNLRAwfvFwW9ImxIEneNqcGX0Xq1a9qfYy0F8afzhZz+IoyCAPgMt4eB82M+E1K5TIqCm
 SWcKSDwD5wKNJMvWP6XiLVR7vwPUWANezv5mkAzEK6YiO2FnZuGO6m5/6SzINNKeTmogSbUvaoy
 aeFfECbmPQvdbD7BOoZUTqoFkBRNUIqNLzczKscc+HuO9cI52URizNw==
X-Google-Smtp-Source: AGHT+IHfAGAVXRwtgsxZh/q6qo2ZLUq9MDEV0VYEm+1wmSM4ikcnsgfNhOolq34ZhT4CQqF7BPPvDw==
X-Received: by 2002:a05:600c:860b:b0:43c:f0ae:da7 with SMTP id
 5b1f17b1804b1-454d530eb01mr57069255e9.7.1752144576077; 
 Thu, 10 Jul 2025 03:49:36 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50516c8sm53681425e9.13.2025.07.10.03.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 03:49:35 -0700 (PDT)
Message-ID: <7127a7c7-f014-42c2-9891-7317cc5c194a@linaro.org>
Date: Thu, 10 Jul 2025 12:49:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/18] hw/i386/pc_piix.c: replace rom_memory with
 pci_memory
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
 <20250710085308.420774-18-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250710085308.420774-18-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 10/7/25 10:52, Mark Cave-Ayland wrote:
> Now that we can guarantee the i440fx-pc machine will always have a PCI bus, any
> instances of rom_memory can be replaced by pci_memory and rom_memory removed
> completely.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


