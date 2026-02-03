Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FF0E87839
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 14:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHln-0002Yc-Hr; Tue, 03 Feb 2026 09:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHlj-0002Xv-Op
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:52:43 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHlh-0006k5-8B
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:52:42 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b88455e6663so835365366b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 06:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770130360; x=1770735160; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HIMGJIVRYeKcK4l8/KUcHlcklnCeV+3ERlyb4jWqI2M=;
 b=e6bwQ2OBv7eSydy46ISvB1FQeXNCM1jsZnc4na0AD8dBp1eaWksTbOZP1S3TZRMn0k
 Nm5EAaCPD1QVWUKZi1gfwy5qrrcFU7tvAPDt7k1bIWHJjdxhRo5MwG2LLU7BoUMMR8CG
 fkFQpFIcIWwYOesgm9+eJsWwDb9vosQww+Z/uMRm0ijDIY8dD2oMi3UWcQ5ajwIMRHuL
 sACTDXuHt0tU6syK4ZcF8BOHwDdEoNaTUgCW1CTA8Fp0/PDVRVZZOPxbFc3PeL3fa13V
 GjPMJxdVoQ7A7HljeVw7vYN/yJKaUPOmftNhF/6RkCoHEcAmbXw9eChTXEosExuYeuLw
 w7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770130360; x=1770735160;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HIMGJIVRYeKcK4l8/KUcHlcklnCeV+3ERlyb4jWqI2M=;
 b=c3VRY4hpFHiPUY3llqF2/9K7fKc/HcVyC/ZAh9BwBcxY3j5Ib9CCggsKF/DKzsvTkA
 xX90NivEPThS0lrzKtPrgI9RZhbqyRg+hymTYaaEdEOd48KZ+dAAB8uQLVtYccUzoLd7
 bmdVSbiwbYe1glVX6kM74PC73QjuSIYlOAnBpdullxWjYk2irdYcz/cqKZ1OMOgogoEe
 x4W3rmQfFUfWzCerJHnw8Qks+3J4UB8ZOuSuv2SPYR339g3X1+FA6UmV1L2gxEKZOaw1
 XOS1W8PPoJBh2AC9VQjVPhSRTsEbGgHXweX/Gt7fZCSmJqBxtyUfJ1Ser5oA8AyK9uZk
 d4eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1qlyY3W2OXoW6PGXeFXDYskoQ/7OHkPFsu2DhOEiMnKZYi/gdiasmcoNnz1Psmv75ssVS9mgM7le8@nongnu.org
X-Gm-Message-State: AOJu0YxtHpCSBAf7GidnoKEaWuAorHzva2pjYRVnxGrrpy92jc3wluE/
 BBRoLRlGoyalbi6gKMwkQ9UA5nmJuJX8/iuYeQejJ0z4fHHUD8/bwlQMFrJeLIZWGtU=
X-Gm-Gg: AZuq6aJnYfQOwaCqCUPoqFbsWYiegfayoT438D+hnv9sC3oKmV1sJD2s6XD9jK1M+4C
 onU/fCJvfUGtUOylfgMo+rXkS78vUmdUQpBlfUag8mJvSHjMKIBeFc7gVDFjASU0D3A7D3/uHZD
 332hVT+codNJJ+pq/N/BEx+gvMq68+CNA/cJ/GyzF6ZscbJZwkfdAimIbVOVKtXl7ucw2xbZmHa
 CmesWrxOUSE7TyxQJ1ujrnIpSTo03f3Z3rygPcQiwDDSZloi5oE586p1AEoTwAmMPqBBzeal8gs
 kCL14Gb5uUV30QAParQb2cATV02kWRhAUNMggZ3D7a3b94MUROl8lty36bUsFDmjtVKIcgljmsB
 KCx/23geFrMjgu0i4xIAmMziIWDQL7FH7+Qe7i65hTyi4uYcs0P3JJlRVcdhSHTrqV2wJ+BctB2
 2O+Od/BCHrjo/qIs9VjY5JjKwZ3VrvOxOLg7pe+cyCXxqB1R3Cc8v5jw==
X-Received: by 2002:a17:907:96aa:b0:b87:19b3:3d66 with SMTP id
 a640c23a62f3a-b8dff7c41d8mr993389766b.60.1770130359654; 
 Tue, 03 Feb 2026 06:52:39 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dbf2ed584sm1061654466b.61.2026.02.03.06.52.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 06:52:39 -0800 (PST)
Message-ID: <2af33652-d467-42be-86c3-e1995f2c1b89@linaro.org>
Date: Tue, 3 Feb 2026 15:52:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/pci: Refactor atomic capability checking
Content-Language: en-US
To: Manojlo Pekovic <manojlo.pekovic@amd.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, Nikola.Prica@amd.com,
 Dejan.Andjelkovic@amd.com, Manojlo Pekovic <mpekovic@example.com>
References: <20260203144939.49-1-manojlo.pekovic@amd.com>
 <20260203144939.49-2-manojlo.pekovic@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260203144939.49-2-manojlo.pekovic@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Manojlo,

On 3/2/26 15:49, Manojlo Pekovic wrote:
> From: Manojlo Pekovic <mpekovic@example.com>
> 
> Extract atomic capability checking logic into a separate function
> vfio_get_atomic_cap() for better code organization and reusability.
> 
> Signed-off-by: Manojlo Pekovic <mpekovic@example.com>

Don't you mean "Manojlo Pekovic <manojlo.pekovic@amd.com>"?

> ---
>   hw/vfio/pci.c | 53 ++++++++++++++++++++++++++++++---------------------
>   1 file changed, 31 insertions(+), 22 deletions(-)


