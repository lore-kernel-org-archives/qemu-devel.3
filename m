Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DE1C54E65
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNuj-0007Of-7Z; Tue, 20 May 2025 10:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNuX-0007Nc-Fw
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNuV-0002y5-1h
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747751138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YXpwTELuy2jj1c0Fcom/vtTE/hXoLvRzEXKXcxfmq8I=;
 b=LMMJm2X0gMDb/hzi2aFhxbM38I2e33PHTU9iAU8wiG8ysP03llkP9aI2W5C+uAS2Pq453t
 9G4K9KlNBV3YCclgh8Hp9FPP2SYLPRrQic18Xtg0gzyhBVHzfvYxKQ6TPLctW/S3tssfj6
 CTbUhlOXVLbEYadheYxPVIrmV4w9+FU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-_L7m464bO1GNVl5jombXYA-1; Tue, 20 May 2025 10:25:37 -0400
X-MC-Unique: _L7m464bO1GNVl5jombXYA-1
X-Mimecast-MFC-AGG-ID: _L7m464bO1GNVl5jombXYA_1747751136
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac6ce5fe9bfso575588366b.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 07:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747751136; x=1748355936;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YXpwTELuy2jj1c0Fcom/vtTE/hXoLvRzEXKXcxfmq8I=;
 b=wyvav6qzEfCY51KdHAbcnFCLe0fnxFkVsZVyylxTx1jRVXRbvgdB4oZKBYAtxuefnu
 Vwv9O/b+bBToNppzQEYruq6I4Qyd/hFh4rKoXq9klv0oBxOWwWJdcb+N0NucgyZs/ajP
 /+O9yIF9ZSvNnFuaWDXLjAxZXZa4POGCxDo4GSysxgEiM/+k+Yid4nX5mpX3W/yRQCsh
 vaB93azZWIjF4xl3HN8ibG4HtWfuWcV+X4M+ePhQMaQ+0I22+1jneOt6UzCTNHvAnV9l
 sGPrgCH+O4yNziZPg7AhY8fw25uCXlKUS0TjP2n+0n70HK+9FC4CYk1tMuzv53XMqkWk
 cuSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEiceV8Z47fOsln4MlTVS00XGAQuJErOBxgBGNpy8RM6s/SNogzKibPc6eHKUKhJ6RXY5CTbXh7V6i@nongnu.org
X-Gm-Message-State: AOJu0YyD8vS2ZKwiaMdDs/Jv5WVzl8XsXNy1MhJkDNtcQkeX9BMH7Gka
 MFnFif9Nf6hGH0v/jhugQ2kuTW9PdrR1uDmKCakqOkFOzOFX9AkdWFpQPSG+0kWIDoMMv4xp+88
 ssLgjfT8SNp1ECwnq7KlLqaHtstDSaJDkix6Ybwul1Tep24IGOcIVxIL+
X-Gm-Gg: ASbGncsOLJBh9q2UW5hi0usymmBofF3ASou+pnJy5S6GxRai/me0/KSvw0ZTSMlEX4v
 CHfZaqNk6U0vCBfks9Zfd/7Fr6CVwkxdvyiRYel5znDM34dtaspOde8ZzuhdBPilKP6P8aL7i3j
 UlV5AzHepy11d12TbI4VsyijY5zDbGKmCn1g4eAPz+rxh3LJcjoRexNhBJFzjS2IQg0tkie/VVj
 wlE5BhJyukPrgm2g3rhkE2KQuemzSE3lIh844FFT90+Z/tcBhUbuqa5xtydUBZ3k0LM8AZjcTD6
 LCCISNiyuwExiA==
X-Received: by 2002:a17:907:8dcb:b0:ad2:2d60:24a2 with SMTP id
 a640c23a62f3a-ad52d45c749mr1660182466b.6.1747751135820; 
 Tue, 20 May 2025 07:25:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxGD9guygso8LpBnJIgNlqySTE0q6oS3MyuHGe7Gj/kz/xcJqU1hM3KfyBuynEwGEKN9YuvA==
X-Received: by 2002:a17:907:8dcb:b0:ad2:2d60:24a2 with SMTP id
 a640c23a62f3a-ad52d45c749mr1660178866b.6.1747751135314; 
 Tue, 20 May 2025 07:25:35 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ad52d278274sm733062066b.86.2025.05.20.07.25.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 07:25:34 -0700 (PDT)
Message-ID: <6d176fba-3628-4f7c-8822-4eb3b11e9143@redhat.com>
Date: Tue, 20 May 2025 16:25:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/25] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
To: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/20/25 13:29, Magnus Kulke wrote:
> Hello all,
> 
> as previously announced here, we are working on an integration that will
> expose the HyperV hypervisor to QEMU on Linux hosts. HyperV is a Type 1
> hypervisor with a layered architecture that features a "root partition"
> alongside VMs as "child partitions" that will interface with the
> hypervisor and has access to the hardware. (https://aka.ms/hypervarch)

I gave a look at stuff that is usually incorrect in newly submitted 
accelerators. :)  The two main thing to cover are:

- the signal handlers, which require a kernel change

- the memory region issue that isn't clear

Everything else is just small things that need to be cleaned up.

Paolo


