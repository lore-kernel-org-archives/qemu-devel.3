Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F397EC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 21:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfoCv-0006ac-JS; Thu, 29 Feb 2024 16:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rfoCr-0006aB-7k
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 16:44:46 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rfoCn-0006uh-JZ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 16:44:44 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a3e7f7b3d95so212904666b.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 13:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709243078; x=1709847878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixVV9DhlYVTBX3q3gPFMZ6jeh61iEalEd3vEpvbPnHg=;
 b=QQGs08+8AvFiyvf2hXibzYV2BA/BE8fe1+cMK5Gw9yC6AvKsQ2X1N5n4Omah/H3wd/
 ZwkHW3OdsGStiSkgvzs6gKN8FCOwgbJdCv6QJ/Yx4Z0xEV0GFv2YvaALLSTREqp97AwI
 gWc8mmz5YOAu5yXkRXhGCSDuXddrYqDl1FhFx9bqK8S0+um+cfPTw+Ym0SFX15mToC3K
 hCcnfjPfnZZPm9VHw2wGcHpVVGsllqHV7R3qM2DdgFPtGEAKDNt2kXSbBQxN1jWxHDyB
 ZMHokHfDpXCaPz7tX1+w2uct3tvLLaJtWfaO7ck0i1f8S1AyOyoB8efP7AEDEReQhEhv
 Vu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709243078; x=1709847878;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixVV9DhlYVTBX3q3gPFMZ6jeh61iEalEd3vEpvbPnHg=;
 b=lZaWrVGOBAK78Vt3DfbBDuqF9bQ14++FQwe3X8fF1kTIW2GuAJLbKoL6hQcP7gte5h
 jsysgXgRVv9bS37qSx8m7FObyA4ywDWHwaleG/HHla/Tnx1ppIhzwENjCo+xpyOBHuHm
 QpfoK4Kgjql7TrePToSlYhCpGH4Cc5lxKDOtLa/BzTa4f0RJQdZy5WHG7EBG3H5E6roP
 k8ZDBPz1t6w7gDj2A2e/uyPXgRMMFts7DMLgTcHQVmPULAZCxcceZwjQ+8S4/sSkqA1d
 tPrMyQ5EzhGJ+zUW3X1sLvosFFtSAD0Im18UrS81IaI/BGOISBZawSE2OhsXUTFSJu1s
 VbnA==
X-Gm-Message-State: AOJu0YwRGoSaIeYnJepT2IYewV+lmPXJ952tLGVL9DtS1P0ybiI99CgN
 gYXfIIsaQthenLYkvQ+k3ECHnWUV/40RYfU/3mm5enQIrYBqSP0r2wlv4jhN
X-Google-Smtp-Source: AGHT+IHDSVK7lPWaQfMtoka6xIqUhTpo9h9WMdF7bMEebU4hrWsd0+s/xcE9ELkyLkcAJKkeaOUZJQ==
X-Received: by 2002:a17:906:3c57:b0:a44:5515:3b48 with SMTP id
 i23-20020a1709063c5700b00a4455153b48mr139325ejg.14.1709243077726; 
 Thu, 29 Feb 2024 13:44:37 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-014-126-211.89.14.pool.telefonica.de.
 [89.14.126.211]) by smtp.gmail.com with ESMTPSA id
 sa20-20020a1709076d1400b00a4432543b21sm1053757ejc.198.2024.02.29.13.44.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 13:44:37 -0800 (PST)
Date: Thu, 29 Feb 2024 19:38:06 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_Revert_=22hw/i386/pc=3A_Con?=
 =?US-ASCII?Q?fine_system_flash_handling_to_pc=5Fsysfw=22?=
In-Reply-To: <20240226215909.30884-1-shentey@gmail.com>
References: <20240226215909.30884-1-shentey@gmail.com>
Message-ID: <08AD24F8-DE32-4ED6-A3D7-7E1F144D27C5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 26=2E Februar 2024 21:59:07 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>As reported by Volker [1], commit 6f6ad2b24582 "hw/i386/pc: Confine syste=
m
>
>flash handling to pc_sysfw" causes a regression when specifying the prope=
rty
>
>`-M pflash0` in the PCI PC machines:
>
>  qemu-system-x86_64: Property 'pc-q35-9=2E0-machine=2Epflash0' not found=

>
>Revert the commit for now until a solution is found=2E
>

Ping

>
>
>Best regards,
>
>Bernhard
>
>
>
>[1] https://lore=2Ekernel=2Eorg/qemu-devel/9e82a04b-f2c1-4e34-b4b6-46a058=
1b572f@t-online=2Ede/
>
>
>
>Bernhard Beschow (2):
>
>  Revert "hw/i386/pc_sysfw: Inline pc_system_flash_create() and remove
>
>    it"
>
>  Revert "hw/i386/pc: Confine system flash handling to pc_sysfw"
>
>
>
> include/hw/i386/pc=2Eh |  2 ++
>
> hw/i386/pc=2Ec         |  1 +
>
> hw/i386/pc_piix=2Ec    |  1 +
>
> hw/i386/pc_sysfw=2Ec   | 17 +++++++++++++----
>
> 4 files changed, 17 insertions(+), 4 deletions(-)
>
>
>
>-- >
>2=2E44=2E0
>
>
>

