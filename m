Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5B5D148A5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 06:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdjHn-0006Ay-4m; Thu, 08 Jan 2026 01:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdjHf-0005pQ-5i
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 01:14:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdjHc-0005tN-PP
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 01:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767852847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l/lzNt1si/El5u/3JxuEqXHb6Skth5KuEneedRtr6Z4=;
 b=bvKRBOZ1F/HsDBwOFzkGDlENtt+TgrhtltYUJdB3cEru18pUC5t654RJv3TuKzDEYQwBA2
 +n0UbdDMB6S3cnJbHAO6cC2oiIEdSk1qo68qf119E9iwMfykQPd3S6zn1vO2yCZlHuC6eu
 jPRi6KHBxo8ePViB0E/rEThkmbxCUYc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-NflheJIWOkC4TEHHEkob_A-1; Thu, 08 Jan 2026 01:14:06 -0500
X-MC-Unique: NflheJIWOkC4TEHHEkob_A-1
X-Mimecast-MFC-AGG-ID: NflheJIWOkC4TEHHEkob_A_1767852845
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b807c651eefso348415366b.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 22:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767852845; x=1768457645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=l/lzNt1si/El5u/3JxuEqXHb6Skth5KuEneedRtr6Z4=;
 b=pSWtbS8AX9QFr2Xitqt6ws4Q93iz5HHv+npP9p0FVUjE6XLggqN2c5nFWvPydleeBC
 yVETp1Ef3gz2IAaDEvxU0zeNupjDogkTGr6JyAwc27HbIxAyZant9HChvMoHXN/Tm/92
 yrxRypS/qGHTpR+KdgbQc9MhLe5LlNpqaKpNMkhHTLD3QMaYqlmphiW669Y+221wDq4A
 YSiX9spDS3koqCp2FS/jOAmokBY7/AeNRtjYj2br6U9Tqy0+iD+zlCTHk5K4BRHCq1HL
 8C7piPZGFpEl/4Fm5e2o2l9OggoRTas9+8LeN3Vj5uNQNxJu6Qg/eW5KWV3CA6JMmlE7
 g7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767852845; x=1768457645;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/lzNt1si/El5u/3JxuEqXHb6Skth5KuEneedRtr6Z4=;
 b=BDoW0c+L7BX5ezXIAIKlEyqYFq8xkUXEXupd7wSNMB9HM7hRXpUv9RV2UCDGQTh+Gj
 grdpPmn7cdAP8AUoyNhrSsW6sFUyo9oStoVK7vmueTvwXYAbu84cWsoqkco9X83+ptH1
 I8WEtIcs8Ie/57cX1F6H09nTUGSHNN4DGi6nAeO2d9aq1tMoe8BGRVYcTK5jrPaidVX2
 b/O0LZ0mjTVczAPk1rOBqNRDqrQVYoCN/+iGesJuHFKqm2Lgyg0WHiiSM9yyL79o8/tg
 8htcEsrKYRFCFRuwVXvY0zgMgiyykmk3F1ELz68JAardpuVicgHccFykS9ph/zJCcrei
 0P7A==
X-Gm-Message-State: AOJu0YwyNNf2SC2VYD25AaxXVLiFlYXqDcKMwpj8CfVvrZ3j8yLxT9EY
 qbHnvrH5s9QzRbdoNfhEy2HydqJ2SiAOryrNSCetFf7envex6KB4iEKVzwkILGt4pMOBCkqInem
 VqAStcslbgFvh56nyNgQyrxhwYLCL0J9v99g9NcpQufYiiCa+N91IpPxQ
X-Gm-Gg: AY/fxX4MggKWl+u2cL53FCDZKG1T36f1nEAjrK8+HB5TCvvXYElyWiMqExtH/4rzsb9
 EXK4xr9+F11+hFbUapLSW4NZRTVtVvL9ozYemQb55V1q44lGJn7yISaZIt6CNAYVeDKDqYpAPFt
 cEoXINOh5o7RIdrEC6iVRkNtbNwm2hYk0f9+/4kV7zrzUML6wMRMpqfE1Vu056ja+7zY6TBhQJ2
 E5kA6Nxq0x6wknWdmrpAqIY/e1ZMn1drngDmnw8OgSK1Ze2DSVf1X2OpFodbXtY0DoyPxdhVeAj
 KFX80uU8+1Zr9B4et6BLjCBMadqlygaQLA+zWOibt85j4dCUZsESG6n1tGgj8iOAGDdAe0IF1Pc
 1dOh9Irg=
X-Received: by 2002:a17:907:2daa:b0:b83:972a:cb85 with SMTP id
 a640c23a62f3a-b8444c99d69mr493961066b.21.1767852845005; 
 Wed, 07 Jan 2026 22:14:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVRsnS9p9n7drdpE60e89TgHoiXqmd2qOHrMYP6giCCfm+VLK5zTWUF3eXR7xUrA4bvP5uMg==
X-Received: by 2002:a17:907:2daa:b0:b83:972a:cb85 with SMTP id
 a640c23a62f3a-b8444c99d69mr493958166b.21.1767852844503; 
 Wed, 07 Jan 2026 22:14:04 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a564284sm729832166b.62.2026.01.07.22.14.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 22:14:04 -0800 (PST)
Message-ID: <87cda384-3199-42b5-905f-a4a0488dfaba@redhat.com>
Date: Thu, 8 Jan 2026 07:14:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/27] hw/i386: Assume fw_cfg DMA is always enabled
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Amit Shah <amit@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Peter Krempa <pkrempa@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>
References: <20260108033051.777361-1-zhao1.liu@intel.com>
 <20260108033051.777361-15-zhao1.liu@intel.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260108033051.777361-15-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/01/2026 04.30, Zhao Liu wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Now all calls of x86 machines to fw_cfg_init_io_dma() pass DMA
> arguments, so the FWCfgState (FWCfgIoState) created by x86 machines
> enables DMA by default.
> 
> Although other callers of fw_cfg_init_io_dma() besides x86 also pass
> DMA arguments to create DMA-enabled FwCfgIoState, the "dma_enabled"
> property of FwCfgIoState cannot yet be removed, because Sun4u and Sun4v
> still create DMA-disabled FwCfgIoState (bypass fw_cfg_init_io_dma()) in
> sun4uv_init() (hw/sparc64/sun4u.c).
> 
> Maybe reusing fw_cfg_init_io_dma() for them would be a better choice, or
> adding fw_cfg_init_io_nodma(). However, before that, first simplify the
> handling of FwCfgState in x86.
> 
> Considering that FwCfgIoState in x86 enables DMA by default, remove the
> handling for DMA-disabled cases and replace DMA checks with assertions
> to ensure that the default DMA-enabled setting is not broken.
> 
> Then 'linuxboot.bin' isn't used anymore, and it will be removed in the
> next commit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> ---
> Changes since v4:
>   * Keep "dma_enabled" property in fw_cfg_io_properties[].
>   * Replace DMA checks with assertions for x86 machines.
> ---
>   hw/i386/fw_cfg.c     | 16 ++++++++--------
>   hw/i386/x86-common.c |  6 ++----
>   2 files changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


