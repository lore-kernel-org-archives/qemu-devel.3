Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03689C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZorY-0007ik-DN; Thu, 10 Jul 2025 06:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZor8-0007SE-G7
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:50:24 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZor5-0008Sm-9m
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:50:21 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso628931f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144617; x=1752749417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KYMD1b0Axa0/Xrv6uSuCapQrTyCe/ZpzL3fMm3o0xNU=;
 b=GCuKh8HYFT7f2htFSeKn57Y7MlU5pCkJZPLN4Irq6su/UdZcXRXA9SIvOVDkCAf/US
 OpRNf/BME3uG692H0Eb37ohuWJQ6G30bvf7F3uhI0zImCG3Q4g3Uh7mdH+zo79YKOmhY
 4kOfDxvls4J7kAdddIDjravIXD3SUorEI4JErxkN83/L9QJLe5z1h+2euTaVQ55JAeDq
 2AqJ2dQzyZcd6NSQRWsFNkip3EhLBqBjNqtaM1dSSHgyFpr08aUci0qBHOXW0AiSBAZA
 YKXWgMY63fHZLJDjvLf/EsXyvC39TxwOGM9iKC0BhYGuFs3EEOjnq4XXUJkLoLTJFQaY
 +LSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144617; x=1752749417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KYMD1b0Axa0/Xrv6uSuCapQrTyCe/ZpzL3fMm3o0xNU=;
 b=On24ghnNvugLQkXFK06vrvPTRoHbArJJuYAry/RZt4hV3UngC16excmrofpDAcdxKC
 aicSj/GyvEdJILpuE/VhL84spQkIRMgbFiYlsuwz4e8mefNtl+kiSJaQnjBtDARnlb0l
 hT4Yz+sFbHnO9IknK9JKMOZpd/f+1pizrQWn8rH6FRBM8CdpTmYkPNxJM85AJdWHdFeO
 nnWz3ZFi4JG2F4J9QnWBOcXmqFl6dvh2puYDrZPPM9dj1qxfvUfuRZtiLCtSXYNTvU/Y
 l8WkKWRluukfrvk5fozF7Cd+FyjCJRJmG2nTjniL6FMoQ895jQZzgy8wqnBzEb1eUKM5
 89RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCv6poUY+E02urQ1N74XP5FlLCpvOz96xUjmR+Y6EgsTWD8NRImXdoykhXzNNUSZmYDp/xnqiMky4N@nongnu.org
X-Gm-Message-State: AOJu0Yx30CgA2m4USfFozlj8prLGEviXrsSGqdtK6xU9p9wJn94tQM0k
 OXGocdbUER0EwJ7h1pMAvBLgWjOP9064q17JKRYaJpGaU7m5PmJlxIMBOmgc1tgzTBk=
X-Gm-Gg: ASbGncuP++KrGfw2DpYTPfLo6fsnWW7f2Y4uR35ctougj1fqmLlHRJ9v9OZ2/dIZZ4Z
 nUT3S7NRejvcUgwkv8qE54Xa8vBqIe+Yfn77rhdGhoOMiXy+WYI6eonSB1JN1xRK0f6zSOf1Pcc
 ifjkTyiByE76uQXFuEOAk+S/n3JR6kIoncYLgrRv2aIvFurwPBFN+utOzPWmItezwsPjG5Vz6pl
 wYx/wFoTO++RclFVdv2rKfrnuaerVGwpgxbgDGGSX2KDfCp42uEURmsJKvUyWUwiiFL7bfg0QDy
 d7oz/MiyqKlCJvMEq//EuMx72dRXMYtmvvsreHQI655E5W+GF9iV8nhrCfjZP7ryKNthEsvmCIg
 67b/BjYKgIkDWN1OGgfEs6geApqhSbwGyQ8mUu/4bFWs=
X-Google-Smtp-Source: AGHT+IFu8keqwDusHzTHLM/zZeWIEwyeoaC/5WkcjTqffglUHF1A5KlJpsLAFZOF/GRFj55ODJLTMw==
X-Received: by 2002:a05:6000:2008:b0:3a5:8a09:70b7 with SMTP id
 ffacd0b85a97d-3b5e86bbb56mr1810401f8f.38.1752144617107; 
 Thu, 10 Jul 2025 03:50:17 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d872sm1562810f8f.60.2025.07.10.03.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 03:50:16 -0700 (PDT)
Message-ID: <2b78b11a-51dc-450a-86c4-8dd56386a36d@linaro.org>
Date: Thu, 10 Jul 2025 12:50:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/18] hw/i386/pc_piix.c: remove unused headers after
 isapc machine split
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
 <20250710085308.420774-17-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250710085308.420774-17-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
> The headers for isapc-only devices can be removed from pc_piix.c since they are
> no longer used by the i440fx-pc machine.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


