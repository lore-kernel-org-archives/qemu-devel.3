Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF195D5D685
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 19:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t983Q-00041y-Tc; Thu, 07 Nov 2024 14:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1t983P-00041V-C4
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:20:27 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1t983N-0006yy-NS
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:20:27 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539e5c15fd3so1265782e87.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 11:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731007223; x=1731612023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Zz5kL6y/wDLJt2CKn+1xpDRHFWuR0Y8dtAbpAyWGLA=;
 b=LynK4rZmlS6hLSilopSjDplvmbUOLkb5mnAG7DFXJEiW1y6vq+85/DqtjN7A3NBlDR
 263shM8A+M/Dbn25JM5Vo4WXhY+SI2mHFzzCDTcSKf2V0Y+TvgLU5OSRQJvkeOGZ90Du
 FwVrQBazNzOnf52Zum9nqUrzSpDgEbZfod0PnPo34gumlPXRjHjbVgCTqPA+Bs69UmU/
 W198TWkqgRNj1A/YF7uulLXITiw1W/0eYMYWHZjJ6YOPYtWN/aMATyoFymr6K9WM6Q0O
 IQvFbrtGurMWDmQfo7ThaJhB7gkZ3b7lj0o30gPNLdJYcXlE4ts2H4bno077afqp6x8q
 fj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731007223; x=1731612023;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Zz5kL6y/wDLJt2CKn+1xpDRHFWuR0Y8dtAbpAyWGLA=;
 b=oBGcYFxeigNb5tatv5Hr5tNVnsf7+6epYDkJMElVcn4UtsdSXkXMcg8ZBFIT6vQZC5
 L/FyW2OS9nV16zahziHxvLGNe98qgQ/DEwYEMDNXJUPnOzGwBbnCKWikelqcEn47Jah3
 BJPkEhFjjz4j1wjOhFE4i4ffb7S+G6hWiE78IdJZth105AsyEDEbqZ9P+Chl232sXZMu
 7f5i/mbAS9OeXRRKp3hYTkS1qoo2YkSEnlaG4yj4pS/5zTUT8q4dMxcKHsdLoR1lkVEA
 bY8G5Er+JzIXQD5t7eglf1U7WfkI30ddguvo9psH8ZKSi/o5Pmaxmu5dAGF+uLMt4tSO
 OD7Q==
X-Gm-Message-State: AOJu0YzjjKtljyuIyT3OatzupcCk+CCX9DGqoEf3Ftn1G22NTU2/K4YP
 olBoPx42k4WWp3+w6u9XOQwBDv7i8b3Tct4LfGIJiWFwMkzK1hE/zbi71Q==
X-Google-Smtp-Source: AGHT+IFJMDyWLJ+ixKxbe6JQCpn3lMXwBkhWcfevEdm46300QrEyVr/8wqb8hU7h4Jp1l+yK5+zL1w==
X-Received: by 2002:a05:6512:3185:b0:539:e761:c21a with SMTP id
 2adb3069b0e04-53d862f7a62mr133791e87.48.1731007222231; 
 Thu, 07 Nov 2024 11:20:22 -0800 (PST)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0dc49cesm135843566b.126.2024.11.07.11.20.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 11:20:21 -0800 (PST)
Date: Thu, 07 Nov 2024 19:10:53 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Dmitry Frolov <frolov@swemel.ru>
CC: pbonzini@redhat.com, sdl.qemu@linuxtesting.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/i386: fix NULL-dereference
In-Reply-To: <ZyyCkFQX548AgEye@intel.com>
References: <20241107070415.694662-2-frolov@swemel.ru>
 <ZyyCkFQX548AgEye@intel.com>
Message-ID: <81E75394-83C1-4882-9F1A-E64BC92CE26A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 7=2E November 2024 09:04:16 UTC schrieb Zhao Liu <zhao1=2Eliu@intel=2Ec=
om>:
>+Philippe for ISAPC
>
>On Thu, Nov 07, 2024 at 10:04:10AM +0300, Dmitry Frolov wrote:
>> Date: Thu,  7 Nov 2024 10:04:10 +0300
>> From: Dmitry Frolov <frolov@swemel=2Eru>
>> Subject: [PATCH] hw/i386: fix NULL-dereference
>>=20
>> If pcmc->pci_enabled is false, pcms->pcibus is NULL and is passed
>> to pc_nic_init() where it is being dereferenced=2E
>>=20
>> Found making check with enabled sanitizers=2E
>>=20
>> Signed-off-by: Dmitry Frolov <frolov@swemel=2Eru>
>> ---
>>  hw/i386/pc_piix=2Ec | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/hw/i386/pc_piix=2Ec b/hw/i386/pc_piix=2Ec
>> index 2bf6865d40=2E=2E2a92d2dbb7 100644
>> --- a/hw/i386/pc_piix=2Ec
>> +++ b/hw/i386/pc_piix=2Ec
>> @@ -313,9 +313,9 @@ static void pc_init1(MachineState *machine, const c=
har *pci_type)
>>      /* init basic PC hardware */
>>      pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
>>                           !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
>> -
>> -    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
>> -
>> +    if (pcmc->pci_enabled) {
>> +        pc_nic_init(pcmc, isa_bus, pcms->pcibus);
>> +    }
>>  #ifdef CONFIG_IDE_ISA
>>      if (!pcmc->pci_enabled) {
>>          DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>
>In principle, I think the fix is right=2E Currently only ISAPC's
>pci_enabled is false=2E
>
>I think ISAPC shouldn't need nic, so it's safe=2E Is this right, Phil? :)

The isapc machine has an ne2k_isa nic by default=2E I'd rather preserve th=
at behavior, especially as we have Peter's fix which does that=2E

Best regards,
Bernhard

>
>The potential issue lies in pci_init_nic_devices() with "&bus->qbus"=2E
>Although "bus" (which is pcibus here) is NULL, the compiler seems to
>optimize this, making &bus->qbus also NULL=2E Therefore, I did not
>encounter any errors when attempting to start ISAPC=2E
>
>Thanks,
>Zhao
>
>
>

