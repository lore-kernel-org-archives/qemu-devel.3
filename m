Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0597EC83030
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 12:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWDH2-0006qz-Hx; Mon, 30 Jun 2025 08:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWDGz-0006oL-Nr
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 08:06:09 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWDGv-0001at-UM
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 08:06:09 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6fac7147cb8so74890256d6.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 05:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751285162; x=1751889962; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W6M2J+4IborllrbKiZETvC4zyIiNtZA7cTGNPFAXMe8=;
 b=lyJuG1eWxAs6hsA0Y1uRZwlzkWhm7BmVAWRgLmED1yR7BxYO+PAOVWjMy8D0/wCm26
 dHBDtzI68A1RNyXN5+CEnJkacDG4WJVsJLRvVkVIZ6/6Z99fGCnfDcoPbnneqIpHDHCF
 3dJ1haDcx9+8HI2LD+sEbLWYX7pjyQNc9RJqAJYqjM52YwFm0aiP7bAFmqFV8sNAAF5t
 Hoz0+Fxh1J4IT3RA7LmWK8OOoG97/Oz38djqb4ah2/bw3bnHMhfVxVUyDr1b4Vz3FR1T
 5t2g24y4eCgEvSoyRXRD8kbs8dxFVRe6oVxcxbDSZjiqWlAhOLwQKpSflobjZzj7B0zx
 wAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751285162; x=1751889962;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W6M2J+4IborllrbKiZETvC4zyIiNtZA7cTGNPFAXMe8=;
 b=VCuZUyyIcv5Xi0GOEST2o/F3r5OzCZsiSz8oAfRv0IdTpdAg8RrogB0IB38YCJiZHY
 gO4/BUmUgk3HDG6ze3HlV0qSUJkkSYYRphsu+pl5XTEnZMqopqAdCiKDg10kcYBmB3NB
 RKaHIB4X+JWAfDfz+LpoL94TnihO96vPZzllCcoJsy9r2/WWxkqSmrhq/twTO6xScOg4
 s++4iyWcYO57jgHLbSdOuaLVi5e/kz3vK+Nue/rC6SMV0dWtd+kTBOwrjhRZUE678u2O
 LV1W4dwJpaTI5YFjusAaloNIkxRrXk8UNIqUJdzmi8pn9VjEbH7vQtelDAMY8OjqfIqE
 EP2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX96nNWlvkiOCQwCXmCF0bA3mwTmxNt/3o15fxcJjk7TtwNM3hl6dyZgn7Otj21s79CeNFdJeLAWJ7l@nongnu.org
X-Gm-Message-State: AOJu0YzcerhpIz8qBAR/yibEy44NZoIQZ449v8MlqKmYQ7jUpL6y0Z3x
 xHtxjDjF2yzCw9jcpT3vGfd7ijv35REMvLxnRk4Ryg0n03jn5D+ngbeuHEwELJ5cnpJG1+pPdSg
 DvqtE
X-Gm-Gg: ASbGncuHFewVMeaXVbHL2P+wOPigFgUVCc8piKbcr23C+Wj89cBp8nsghJLSiKZQde+
 RGW6bD1IyoysgnBFttiG9tJy5xRu87/jodxwBRYoybZuxpJQZ0YAnmf/JR634R4IPSsZw/Hb4XT
 jGA8dLVJpQ9a4MrcVnLSZ6u3S+kV5qj34P0ThCYts4TU7/LW8saLpkjSCP20/5yAP4Tgu9GoRRk
 UIKahGcRBXdDj+9BnTOANUONDwQneRVGehkop65IWJwnLhUdfGMlrO1dAZv9yTqtvXEBizvfazm
 hlgZjp5+kxWAec6Nd8ZY3/wzPpHcudKMjkmsAfLw2Kaosn3cK66AuLa9qEqBA0Fi0CgTvvSlooN
 dv2XIJoU1VQ==
X-Google-Smtp-Source: AGHT+IG4QUTSYrZqYEc6imXsoS+TrNId+cr0ZkhxO40LZBFSzxT4g1J61IxA9sWuR6JuWVMer/spug==
X-Received: by 2002:a05:6214:2c05:b0:6fd:7505:b3ff with SMTP id
 6a1803df08f44-6ffed7a4278mr209715066d6.3.1751285162014; 
 Mon, 30 Jun 2025 05:06:02 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.20.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd771dcd5dsm65789476d6.51.2025.06.30.05.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 05:06:00 -0700 (PDT)
Message-ID: <73d775f7-fcaf-4546-a9b0-85c05d5a0296@ventanamicro.com>
Date: Mon, 30 Jun 2025 09:05:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] riscv/boston-aia: Add an e1000e NIC in slot 0
 func 1
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
 <20250625141732.59084-12-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250625141732.59084-12-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 6/25/25 11:18 AM, Djordje Todorovic wrote:
> The Boston AIA board needs a basic GbE NIC.  There is no PCH GbE
> device emulation, so use an `e1000e` instead.  We place it in
> **slot 0, function 1** in order not to conflict with the existing
> AHCI device in slot 0 func 0.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/boston-aia.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
> index 6ed5c636cc..34cc0abe79 100644
> --- a/hw/riscv/boston-aia.c
> +++ b/hw/riscv/boston-aia.c
> @@ -437,6 +437,11 @@ static void boston_mach_init(MachineState *machine)
>       ide_drive_get(hd, ich9->ahci.ports);
>       ahci_ide_create_devs(&ich9->ahci, hd);
>   
> +    /* Create e1000e using slot 0 func 1 */
> +    pci_init_nic_in_slot(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e", NULL,
> +                         "00.1");
> +    pci_init_nic_devices(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e");
> +
>       if (machine->firmware) {
>           fw_size = load_image_targphys(machine->firmware,
>                                         0x1fc00000, 4 * MiB);


