Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB62C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 18:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpAGQ-0006Y5-TX; Mon, 03 Mar 2025 13:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpAGM-0006Xq-SZ
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 13:11:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpAGJ-0003if-CH
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 13:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741025484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N1d5VN8AqrhCwkxjK0gUYDrNqqebiyXoFyVvNiYAvv8=;
 b=Mc0Vqzkci5eU1d3/G6utkuiOGF+taQ6yU3kmmpodu9Doi9BP1wxn0mwckqxb8CXYToVUsG
 dqVPf4kXn+OPsMy5BUCkeeibw60yR6cgWw5bXeyuROoH0Hd1ZMhV/z+tAcIolknZrtyzXL
 SgvqWcmJtEBMSfWTLkaE3Xamb4Fzn0Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-qRFQ9pAYMsOEr0QbajDYAQ-1; Mon, 03 Mar 2025 13:11:23 -0500
X-MC-Unique: qRFQ9pAYMsOEr0QbajDYAQ-1
X-Mimecast-MFC-AGG-ID: qRFQ9pAYMsOEr0QbajDYAQ_1741025482
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43947979ce8so18515415e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 10:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741025482; x=1741630282;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1d5VN8AqrhCwkxjK0gUYDrNqqebiyXoFyVvNiYAvv8=;
 b=o230lG8tAYw8CgMhMIKDL1C7CIRAhxhaE3lpDOSPbuGeUSHNdCUAhPn455P5/3iGd8
 Pmm7NMapPAHf+UQ9BtuyG80j6Lyg/iWG11UwNfrJvZ5vCrTg2dOrzubXj9PrxwET/23/
 ia/c1M3jpftwNPij6KZY8aHt9uUDeXaMQQCatRVeOgvWgNow2hytj7j7xpjSIQZ7ICrR
 /uVcIjV0qHk97HVieeXmGeuUDgja8d2mE1NaBtMJCEoZ0odBgZtB2bouSW6+1enfczEf
 i9nGtM09Ze0r7uzt8FDaUUn5ojENB/nHbuX++3VWrxXihEGONMMMs3zZtFrfdMLEotcP
 /mYw==
X-Gm-Message-State: AOJu0YyuLtc2pdIzarWfLEvy0PD5OWB8qkRTuPLkrenocLwGwNwcyV+4
 FcrhfEwCOJCVXdBqhHd+SrUbUnbzhZGjep0EmqDm1Nxz90Od0RSdb3HQ+v6HmArNaQHIr8lKnnY
 uSjVuIDG6ZOXNpY50PI1QitFlwQqZpemv8d2HEcEg8NMaeeLQXlRR
X-Gm-Gg: ASbGncv5BnqdrC7G/dPH5dbZgVpwFV8w9nZY9q59VNwMtZCjwMJBu0SwaxnmqPuPrD3
 bHMGu/xT2nKB5cKuesHZi9Hqr+pKFbFlP4twtXkUTiIUodXcyin7UqddMg8tioPxCY7FQV0D4X3
 ab+3GvGj9zz57b08PN2gwbF6+WajOiqgoeVjaWo+xKpLluCMwh+LMmPeYBJEs+9R66ZfM9AkzHk
 ynHUyrIPCCL0LBlXjVZcmyIGorfC4E75hdqpvSCtO4l7MimJJ0TJkO3HkasO51PSS4HdZaR/Ph6
 AVGxTxLrXps2qYdlYEFbAnyWkvuFB1VOqyRfdkX4JbUdf7zKtT4LwQ==
X-Received: by 2002:a5d:59a2:0:b0:391:6fd:bb65 with SMTP id
 ffacd0b85a97d-39106fdbc7fmr4356751f8f.9.1741025482040; 
 Mon, 03 Mar 2025 10:11:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGD6kGtgMCIFp4+q3So2xHx3nGo5wIsmlM1BflJKRQYhgP21ROkWCtGE6OCerwnKN+jgvg8rQ==
X-Received: by 2002:a5d:59a2:0:b0:391:6fd:bb65 with SMTP id
 ffacd0b85a97d-39106fdbc7fmr4356729f8f.9.1741025481683; 
 Mon, 03 Mar 2025 10:11:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b6d31sm14947740f8f.42.2025.03.03.10.11.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 10:11:21 -0800 (PST)
Message-ID: <9c9232f1-73f8-40ec-9064-a0df3f2e15cf@redhat.com>
Date: Mon, 3 Mar 2025 19:11:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host
 platforms only
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
 <bb7c2adf-f146-50c7-7716-c1ee7b606b01@eik.bme.hu>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <bb7c2adf-f146-50c7-7716-c1ee7b606b01@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


>>> I see PPC is defined in target/ppc/Kconfig so I think these mark the target not the host. Vfio-pci works with qemu-system-ppc 
>>
>> Ah ! I am surprised. Which host and QEMU machine please ?
> 
> I've seen people do this on x86_64 host with pegasos2, amigaone and mac99 running 32 bit guests (AmigaOS and MacOS). Some people running older 32 bit Windows versions on pc machine might also use this.


I tried with :

     qemu-system-ppc -m 1G -smp 1 -M mac99,via=pmu -cpu g4  ....

There are some errors/warnings:

     qemu-system-ppc: -device vfio-pci,host=0000:0c:00.0: warning: MSI-X is not supported by interrupt controller
     Cannot manage 'ethernet controller' PCI device type 'network':
     >>
     >>  8086 10c9 (2 0 0)
     >> set_property: NULL phandle
     
     >> =============================================================
     >> OpenBIOS 1.1 [Sep 24 2024 19:56]
     ...

but it does work :

     root@debian-powerpc:~# uname -a
     Linux debian-powerpc 6.1.0-7-powerpc #1 Debian 6.1.20-1 (2023-03-19) ppc GNU/Linux
     root@debian-powerpc:~# lspci -s  00:10.0 -vv
     00:10.0 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)
     	Subsystem: Beijing Sinead Technology Co., Ltd. 82576 Gigabit Network Connection
     	Device tree node: /sys/firmware/devicetree/base/pci@f2000000/pci8086,10c9@10
     	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
     	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     	Latency: 0, Cache Line Size: 64 bytes
     	Interrupt: pin A routed to IRQ 27
     	Region 0: Memory at 82080000 (32-bit, non-prefetchable) [size=128K]
     	Region 1: Memory at 82400000 (32-bit, non-prefetchable) [size=4M]
     	Region 2: I/O ports at 1080 [size=32]
     	Region 3: Memory at 82800000 (32-bit, non-prefetchable) [size=16K]
     	Expansion ROM at 82c00000 [disabled] [size=4M]
     	Capabilities: [40] Power Management version 3
     		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
     		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
     	Capabilities: [a0] Express (v2) Endpoint, MSI 00
     		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
     			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W
     		DevCtl:	CorrErr- NonFatalErr- FatalErr+ UnsupReq-
     			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
     			MaxPayload 256 bytes, MaxReadReq 512 bytes
     		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
     		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <4us, L1 <64us
     			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
     		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
     			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
     		LnkSta:	Speed 2.5GT/s, Width x1 (downgraded)
     			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
     		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
     			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
     			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
     			 FRS- TPHComp- ExtTPHComp-
     			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
     		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled,
     			 AtomicOpsCtl: ReqEn-
     		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
     			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
     			 Retimer- 2Retimers- CrosslinkRes: unsupported
     	Kernel driver in use: igb
     	Kernel modules: igb
     root@debian-powerpc:~# ip link show dev enp0s16
     2: enp0s16: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
         link/ether 80:61:5f:0a:2f:c4 brd ff:ff:ff:ff:ff:ff


The number of VFIO combinations drives me nuts. It's worse than PPC.

Thanks,

C.


