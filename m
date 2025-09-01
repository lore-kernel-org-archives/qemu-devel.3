Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA94CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4iF-0004yi-L8; Mon, 01 Sep 2025 09:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut4iD-0004wb-H0
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:36:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut4iA-0002mJ-TP
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:36:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b89147cfbso12830305e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756733800; x=1757338600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=54Q6EzDt2CuWrPreE3EFty6fRQizOgYDQaAoVD7B9nY=;
 b=pE9QYWtQ99CsU0edSP6DsmDtSD8kmaY9NPH17R6AF3cjdxXlmtQrKfVggOJYsh2fkM
 zdtxqdxnHqZ5+uzj5B9OtRwoyp5PGfF7Ih/vOG1mdSxinPEAtSYTkT5pIWpQ7hp2YzF5
 D77UfeazfPPmYprFg1+IgWl/rjkt8YKZEI1tILwrja7fy22VNG19JwB7zKEacAscRZE0
 3r/yNsWbyFgoHJNarUHQXYd5SW2paKPzA6Gl4TxEIgT8wU5ARPPzdvaTxD+QzIoVCI0U
 TCpjcJeEUm3VdsVivpz2VJwSzpSqbEIJX0eot6KWNYK1H3vHrB5P+HBUNFQDpezGezgp
 zvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756733800; x=1757338600;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=54Q6EzDt2CuWrPreE3EFty6fRQizOgYDQaAoVD7B9nY=;
 b=ZyY7hCdq7cE8rkun1UJxelBDLQU67VMS3F0KOxw7Zt34/L/5bz4fU05xCWVU/4Wucr
 Qhr473ucbrtuwtWvE1JHds+OUWPMq1Cq15p3JKqHVG2baX484SXhve8fIf+G4oxE09E8
 /rXHr5+/iEeSYp/btYbtkSOJmET1PjKuOSOEfDiGLwH/uUEY3gxshQ+e4OYKYGwN2h7T
 jepO5fY2ZYByUSROilWxCml0HZvBZfTsFllzIa8OlacvPubQDpE9F77KKTw6hqgcsXym
 5f2xPd4FK8s2RypEgTEzjnybEbnrF3IISfNeBm8JgUfEdXiKUYk1P4+bHr2EBCBjQFta
 wreg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUKjskr8/k3rSb+AbYKjX/6UCTfeKlfuKM0snG/afjRkSAmzDqHFHeA00GDslnCY6tsrDQcG8S2y+3@nongnu.org
X-Gm-Message-State: AOJu0YwloIAYjKTnesJDfRbZ8RySCoU+GANPUpUXWACARwOv23EYIS4v
 7wqY0o2aDBcvqQ5numwrluZgiDJtq1SlXKI3GpnDxVT1C3fxKGip8JCVhfM/Rxz+gy4=
X-Gm-Gg: ASbGncvmKWtVSzCqt1NHXxmSDQaWobKsf6TuKConcqnwgjYGJXpdgIdKL6qWYIseRbn
 AW8N3JF2+yM5EQusDJ6ObGzR5e5MlBSGBKULApzqafRJJvoXm6HQMIQiHg/XRc7zbLdcQTuk04e
 cDYvzZDTteL6q8Qs52HhE/p+K/8AgfcEdcTP1cvy8iNQVp3uK5OMbEgSqDXnON3w8dQ6SPM2q4E
 kWeueyTob0sshp6NZb2gYymsxHp8iLCuR78gTP5190S1PqdTPW+SIGChm1DfsDFLMBLFWsMylgf
 ZRxjdHNCNDT8gedXkTNwAB/EW/oKmxhcWh1nOD82Iusmn/zKxdXdlsgKPB1/0XrZaaRaSbp/TO/
 6VdeUlT2+WXEUpLCjjgiQDZ9VmidHCxTlefkyMnSqoOA43CoRIT6euGKbxEBdpI+4l5UHcrrioO
 fc
X-Google-Smtp-Source: AGHT+IHqehvQ62+oAgMa0nm8yc4DG0g1tzDf0Nk5fdDSxDBkoLzAOv87IIprMCixY3169LU9rs4yCA==
X-Received: by 2002:a05:600c:354f:b0:459:e094:92c2 with SMTP id
 5b1f17b1804b1-45b855addd6mr54539615e9.27.1756733800242; 
 Mon, 01 Sep 2025 06:36:40 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf274dde69sm15359089f8f.14.2025.09.01.06.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 06:36:39 -0700 (PDT)
Message-ID: <dc143cea-d559-4491-8154-1406f227e597@linaro.org>
Date: Mon, 1 Sep 2025 15:36:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/pc_piix.c: remove unnecessary if() from pc_init1()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, peter.maydell@linaro.org, 
 pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250901132639.1123726-1-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250901132639.1123726-1-mark.caveayland@nutanix.com>
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

On 1/9/25 15:24, Mark Cave-Ayland wrote:
> Now that the isapc logic has been split out of pc_piix.c, the PCI Host Bridge
> (phb) object is now always set in pc_init1().
> 
> Since phb is now guaranteed not to be NULL, Coverity reports that the if()
> statement surrounding ioapic_init_gsi() is now unnecessary and can be removed
> (CID 1620557).
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Fixes: 99d0630a45 ("hw/i386/pc_piix.c: assume pcmc->pci_enabled is always true in pc_init1()")
> ---
>   hw/i386/pc_piix.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 7e78b6daa6..b6d0cf411d 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -284,9 +284,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)

Maybe also remove the pointless NULL-init?

   -    Object *phb = NULL;
   +    Object *phb;

>           pc_i8259_create(isa_bus, gsi_state->i8259_irq);
>       }
>   
> -    if (phb) {
> -        ioapic_init_gsi(gsi_state, phb);
> -    }
> +    ioapic_init_gsi(gsi_state, phb);
>   
>       if (tcg_enabled()) {
>           x86_register_ferr_irq(x86ms->gsi[13]);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


