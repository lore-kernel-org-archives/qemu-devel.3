Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B4AC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafuI-0005NP-IP; Thu, 15 Feb 2024 12:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafuG-0005LE-9o
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:52:20 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafuE-0000Cl-Mn
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:52:20 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d0d799b55cso14096171fa.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019536; x=1708624336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b8JSWfSbqJ38j0ddbtTcXV/tKfgCQrmY8HQse6Eb7fU=;
 b=keb4hCWzoriIuEmUT2D9K5vM1etv0JHwRF09YHW/vIh93GgFyjNZH9DcrC9Snb0CmE
 fQCOTCGoqgnnNr3hhY3BlAgAud3ovbnT4WB6a/xe6sIej46lr0KyCjE9zsInQ15qGq8h
 UKPaL4zRpNy5qKwDOumzsQjpen83U31/lXxAXa82hz2L3KMx1BgUD6ZWAV0bY4mZqwZC
 1y0hmH9tRR5P5zFysEE49hpDSZHNV48fxaI5ymCLDy8OLbJbNAqEkrFERh9AEsXowLKI
 pPWX8yhvYy6fpQLE6LlFcxqqL+Oyym5oRdnlwpjiGEFdlnT0nx3DhyqP6NIN1we0GdQ6
 hNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019536; x=1708624336;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b8JSWfSbqJ38j0ddbtTcXV/tKfgCQrmY8HQse6Eb7fU=;
 b=vuQ984yIn8PHf0lRvLy5GRm/hko5Hho23HcznXzqRvHgQWUnUh52v9xdtfEM1RaZlN
 Apj0KQ+dIIBBeuhz+1gS9/4W6T5FyXj3DtREB1cuw1RV91UeL/j8/hTGN0c5PeBAXkgp
 V2eJLf00cSNTT0s3M8wIA2FD6HjKyN2nj2Cy9gZhr6XwoaXhwbvPhPvu+8KAd5jxDhow
 wrOxKv6gV0pKtUGr4cAfuAZuf91j2I9mi5qH2QEkfsojzyR82B8OrIVcHlNGXUuRMy8G
 M9qU+EV1HbIjdi0NTMPChqwRySZTcrIZsElGHIYUZKKOoQ0yqLdYPO8SjiNyr1wY66sh
 JP2Q==
X-Gm-Message-State: AOJu0Yx0E+osdqJzYnoV7fSF5nqckcMLnxhjU98JaWpkH53p/xkc+7mY
 juzI4sC0iA/1QwVeAcf/OjLelvGeARthdNycHqQhIkGrQ//n9v0xhD52Q14ekfzTHYRnQz7cxED
 mwsA=
X-Google-Smtp-Source: AGHT+IFr0AlWXKGd3r9esHPkyU1fzynyyiOq/w3JIpjXwzSUmWlID62t61+PFV2cLwqHyUzKygxUHQ==
X-Received: by 2002:a05:651c:1033:b0:2d1:15d0:4711 with SMTP id
 w19-20020a05651c103300b002d115d04711mr2124420ljm.5.1708019535999; 
 Thu, 15 Feb 2024 09:52:15 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a05600c044e00b004104bc8d841sm5680826wmb.13.2024.02.15.09.52.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 09:52:15 -0800 (PST)
Message-ID: <b9a8f47e-eded-4e81-bead-1aeb4138641a@linaro.org>
Date: Thu, 15 Feb 2024 18:52:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] hw/ide/ahci: Housekeeping
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, John Snow <jsnow@redhat.com>,
 qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240213081201.78951-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240213081201.78951-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

On 13/2/24 09:11, Philippe Mathieu-Daudé wrote:
> - Split 'ahci.h' as sysbus / pci
> - Inline ahci_get_num_ports()
> - Directly use AHCIState::ports instead of SysbusAHCIState::num_ports
> 
> Philippe Mathieu-Daudé (9):
>    hw/i386/q35: Use DEVICE() cast macro with PCIDevice object
>    hw/ide/ahci: Expose AHCIPCIState structure
>    hw/ide/ahci: Rename AHCI PCI function as 'pdev'
>    hw/ide/ahci: Inline ahci_get_num_ports()
>    hw/ide/ahci: Pass AHCI context to ahci_ide_create_devs()
>    hw/ide/ahci: Convert AHCIState::ports to unsigned
>    hw/ide/ahci: Do not pass 'ports' argument to ahci_realize()
>    hw/ide/ahci: Remove SysbusAHCIState::num_ports field
>    hw/ide/ahci: Move SysBus definitions to 'ahci-sysbus.h'

Series queued.


