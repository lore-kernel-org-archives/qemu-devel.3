Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EFCC83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZopK-00056g-H9; Thu, 10 Jul 2025 06:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZopD-0004sW-NJ
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:48:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZopB-0007LH-9Q
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:48:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so5145545e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144498; x=1752749298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ML/GjR5SS75XmZVQW7fJ3shFXowBFaw2E76A3D/mPHM=;
 b=KQzu4/IsMuWrrOodD0QcXalF7CYdEBgVzoYIfh8h+cFJ6SHgqX27jJgaBAkNo6k3GY
 sPdKYkOgtPPVNBnrL3t+qC5S3hZjXa+pRdHisj+xGwKPMRrY2WbZGNCBDnjv4Sc0RqzK
 H0Pqp6ehLmId3ca4CkwklzNuFClfKyMb4hW39ZuKwU5wpqwO07bEsXK91zMer5cKZlp7
 fkSQe8ZskChbbaWjQvqBxse9avaGejeSmJNR2POqIiU5r2hWVLoPzTdPOnPX+pnfa1xW
 huYVXg4xf+R3limMQRuAwCpJNK6ZGaVGHLr3ouQfsNHqGE0PphFstgCTSY7jPMw/bhqw
 qSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144498; x=1752749298;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ML/GjR5SS75XmZVQW7fJ3shFXowBFaw2E76A3D/mPHM=;
 b=bT0uvfky+lZk5w/2+EfBGbyXvaKL/6MWa5jUyN8E6JV94VCYHXJEAOCGRbUgXluEBj
 LojQYDAteWof9gmCoJU+12Vf6SFRjwyONjqhhW0ypE9KUQQygZZcervZJ8oVO8ase2j8
 iPL6q4wLBpEgU2SvwnnMCfaDUc4qVsbz/YuSwhnpjzIDHnaQcm2iygniOpXZ+katoO01
 5jTNv7ltekscFslFClvgUBBaG3UM2t90ZhMHTqGswFYLwjjhX8WME+/0d0D6noKL0KuF
 bX6GRj4Ir8NQa04bc9oWuJ8O6mpuVKk+L0yzOj/InaP8mK1voAI1ZrFlpwQj0Bcx7+xN
 fOXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7E9qgJWsz/7SWXz6FAN8vxs+gxv6yvs8diHovQhoUEtYlvgKyfvWSfP2UeNcMU0fvfSYHyXwF9pIY@nongnu.org
X-Gm-Message-State: AOJu0YzhqEsNZ/MiOh9FO5pW/IDE0uFcAYDcMu/gmRUEG7lMDkv4BTq4
 h6y5aM94zZvwiftO+6Q939Saipi9eH9vpryDyqBpWr3Ai0ZrPp0bW4EXzjH3MKxiYfI=
X-Gm-Gg: ASbGncuZ+U1Iscci0hQSE8VMFsfVOdgkUBUOiAQtwgsQKmfuYMxHBmdMLPDZQlP3WPF
 tPeHGg2VHvsdMQmu4Vb8/1LwtI3Jvqkm79e92mtV9uvbAj2jVrIn7WsmVQc9d4JBeuPAUiLVHJ2
 s6RtrVQuhiVi2Qdk/lnze+9dZM3gJ1OcYIW76DYJ7gemPhTfjtIe1pqYvu5cuNqXFP3hP3DTTZ5
 ELrneZHEta0WRQR5RzXJsPQhxEn3Vi8AysPGM/wO0cfuMWrh914ciR+TMBw1Wqk7XoggMXFsGpb
 i8tism9kFOEHz5QOSrvtlpk++1opQdCG7QuHgxPwb9g0xlnVS8caeEDpmkGl5fm4D2YTH0Thxr+
 4Zycx5whHn7V4v0+ehePMYfkWACHgosttYK0dM2tBo68=
X-Google-Smtp-Source: AGHT+IEqiCDJZxlklavchQfIXLAgFf+cf1Sn9jKcUvhiL2VqXswE23uVGIRi036m/jwomFlkw38U6Q==
X-Received: by 2002:a05:6000:2906:b0:3a6:cfca:efee with SMTP id
 ffacd0b85a97d-3b5e44e9d0dmr5298600f8f.17.1752144498225; 
 Thu, 10 Jul 2025 03:48:18 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc217esm1499850f8f.28.2025.07.10.03.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 03:48:17 -0700 (PDT)
Message-ID: <9f9278ae-9207-4deb-b048-a39c2ee25002@linaro.org>
Date: Thu, 10 Jul 2025 12:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/18] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always true in pc_init1()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
 <20250710085308.420774-15-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250710085308.420774-15-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
> PCI is always enabled on the pc-i440fx machine so hardcode the relevant logic
> in pc_init1().
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 194 ++++++++++++++++++----------------------------
>   1 file changed, 76 insertions(+), 118 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


