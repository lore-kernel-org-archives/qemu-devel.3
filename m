Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C52BC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDfD-0000AW-Bk; Fri, 12 Apr 2024 05:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvDfA-0000A5-TM
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 05:57:41 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvDf9-0000Th-57
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 05:57:40 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34641b7c49aso499234f8f.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 02:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712915857; x=1713520657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C1Tz1ZS73XEON099vogrXxYrWoknfUamFqo+pBOVEb0=;
 b=vmfoZmu9MqkiU1KU3DG4OkmEe3h/70jhbqr2aTgOpskcRxI6qBiq8HedyKbM724WOf
 ucMHu09sCipqs8jfhNoPl0tslHWyPKAbwQHfA42ClbRYV9ML4tJ6Jw4R4QV10gLSeRxn
 aaDxOy+inxgWrnhlU+NiimLAeXQDU6RD0WiwHoSQoii/GeU7HscbMNkBBNGOlHNyB0Zz
 lLuw8TxSHrrtlRc1iZR93IVAQSlGkffgCM89MX3Im++TATxR4yEhZ38uzYGOU0wnCy+E
 2y9GDcFKZkpl6MYFsa1aghJJDYuHj6112ywOEDB44dEIPAtm/opA6uaFTqE9dfiz3GXx
 /pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712915857; x=1713520657;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C1Tz1ZS73XEON099vogrXxYrWoknfUamFqo+pBOVEb0=;
 b=V2QUmtAVLgND8JDdqSHTMsEne+dPMTNyoOEQ05SKLec8SE1aXjnVQ2SNaI76qtzrrF
 xL0n31I83RsfykvnmhMOnPKy7F61CxB0JVCsh6ohgH2J7L9cLWAEBEwZiYEdsvwOPI2k
 edO9WoH7PteqfyVOpPSSasfwCxm0gJcx/+T7zy2wudAPBrZhoaJQg/3L7eICIy9hK/Aq
 q95NEe43sXkjmArI/1W+JalaPcv3P8L4FzneBqaNfLXoFibXBye5By4b0gua1EooQ76l
 zR9P/Cxc2cpoJKDdrmR6YrxYeWL+WrZUMEMtIPwbb66MyI3qKM2wpVQ4qgiypRJZFPS0
 vh2Q==
X-Gm-Message-State: AOJu0YypCbgOo2BiezG0jxtA/uFffwnm28HHOXz1buGcUk17pPXPpxk5
 2VPTyGzjxN7mwiFpPQnGtz61skookrm88OqcbkrfTZb/W8JB2jZ37TU6DSEFGTU=
X-Google-Smtp-Source: AGHT+IEbXOPLWdyFxgYiDGL/tTOKih7fkvdkdlpxnHEG4dFEyjReADG0GFQtsIETU6NS3NtcHBT6qw==
X-Received: by 2002:adf:a150:0:b0:343:d35d:71d with SMTP id
 r16-20020adfa150000000b00343d35d071dmr1273942wrr.8.1712915856787; 
 Fri, 12 Apr 2024 02:57:36 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 dd14-20020a0560001e8e00b00343e9f52903sm3859601wrb.57.2024.04.12.02.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 02:57:36 -0700 (PDT)
Message-ID: <305d659b-d4d6-4681-bdad-cd869e552333@linaro.org>
Date: Fri, 12 Apr 2024 11:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers for
 PC Q35
To: Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20240412085358.731560-1-zhao1.liu@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412085358.731560-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Hi Zhao,

On 12/4/24 10:53, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Commit e4e98c7eebfa ("pc: q35: Bump max_cpus to 4096 vcpus") increases
> the supported CPUs for PC Q35 machine.
> 
> Update maximum CPU numbers for PC Q35 in the document.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   docs/system/target-i386-desc.rst.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/system/target-i386-desc.rst.inc b/docs/system/target-i386-desc.rst.inc
> index 5ebbcda9db4c..319e540573d3 100644
> --- a/docs/system/target-i386-desc.rst.inc
> +++ b/docs/system/target-i386-desc.rst.inc
> @@ -36,7 +36,7 @@ The QEMU PC System emulator simulates the following peripherals:
>   -  PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1
>      hub.
>   
> -SMP is supported with up to 255 CPUs.
> +SMP is supported with up to 255 CPUs (and 4096 CPUs for PC Q35 machine).

This comment is not accurate since a while, IIUC:

Up to q35-2.7: 255
q35-2.8: 288
q35-8.0+: 1024
q35-9.0: 4096

>   QEMU uses the PC BIOS from the Seabios project and the Plex86/Bochs LGPL
>   VGA BIOS.


