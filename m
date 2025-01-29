Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989CCC02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 10:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td5mA-0002R5-Nx; Wed, 29 Jan 2025 05:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td5m3-0002Oj-HP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:58:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td5m0-0001Ow-5I
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738148298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ejWY4xLZzxdHiHjWPQpKMn4uXTIrdOaoIGzEsQCoZlI=;
 b=L1roJfTR7vbODzlT56Rns3Cyv5OWvNKTzFiaz93dpXhYLF6Lx2C0h68d2OeUfgCdajiyX/
 v2HfkCrogcsPkoEM50TtnmNs81Q5eOS3UpboHtGBor9hBMcdhPd+MVPasZxvfWdzjAPIlP
 UljqkevAwtQd6cMhMsRAkH3dtJd4JWI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-N5kqXXMMOfWHCIR68bHQtQ-1; Wed, 29 Jan 2025 05:58:17 -0500
X-MC-Unique: N5kqXXMMOfWHCIR68bHQtQ-1
X-Mimecast-MFC-AGG-ID: N5kqXXMMOfWHCIR68bHQtQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3862be3bfc9so3749225f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 02:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738148296; x=1738753096;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ejWY4xLZzxdHiHjWPQpKMn4uXTIrdOaoIGzEsQCoZlI=;
 b=OQNjiFcFxv+GbgWpnpWQ5Q9K2EZN9p6eEvx2usBgFysNUuuzJfqQMr1EK+b7aH+ur+
 6COYtkvFJKQLnk3UodHk9SAwg9pLIqlwP5pzom+UCMCLIxiWX7Tk26lrpSQ7ScTTxfgS
 UAiMKPR010YLVS5v53DZRvWcyP0fG/pvoUERF8sxE9kFTFsClKky/PycVCMv2i10HmCD
 C/z+UtewzoApQ5a9FKDyQJs5qXc2gg0+yoL34QIZYEhFl46WnMS/u+rTAmfnU3z0/Bxv
 1fSdKO3p2wiTFa+wf7iKvvwXgWzu6v9KWnIhGdzEHRYPi+OUucCjh8PqfEjRywNwf79o
 FJmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVNb8Utm6x38ME/i5mMr69e0Wzxy+Joa/0+70YQFEjHjx0G/GVAnbZE3x8n2nEPqQ7g+gv6p5xxQz6@nongnu.org
X-Gm-Message-State: AOJu0YzRBpYe+5aDJJCcvAYqivaQ50g9vwZBz1SYfvHBLETZKOOq1CIl
 W9Y2rotczIo0187/OcPOsUWu02g9Acb9NtUzYeOP5hkg4S+RIowMk7lHTmHEF7dhZq+DJWu6zj4
 ypmxlWTcW2+/Xr877ogO+Ln/gLwSXSY3dfNv5Gqz0dapJOvCA/98Q
X-Gm-Gg: ASbGncseExTlL7Hb+OA09n6tmZW32Vx3V3ExXDf4GvmHDm7blvDb0qNGSfVGSAEoU0x
 nu5PJkKRsAUu7/SeHjN0pS+ROLsCv+ZOHl2yCcdDJiKliP8T671WgNjZx6Syypalwgd9GtRWQAB
 5Ty+6Ar0WaUHUgkFWiVgd3wqWe3BLwl2zuk/pD+ckEpwcrm9fzUNGjYJFw1gj/W9lWQe1FPhtmO
 PBuCx/tFPFIdVXMZK/PxUoTpYcIBFokpp4IAD4x42dyh5ynpSoPcwdczLnPM6ZzROSF52nFiOGe
 mLNCtw==
X-Received: by 2002:a5d:6d0a:0:b0:385:e30a:394e with SMTP id
 ffacd0b85a97d-38c51931f8emr2155300f8f.3.1738148296076; 
 Wed, 29 Jan 2025 02:58:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwIl3iKLs8VOWDhRPEOSMXDj8eT79UO4yJaSyvpFY//CYNceTpz5mvssTNeQ/KWQYHtNCA7w==
X-Received: by 2002:a5d:6d0a:0:b0:385:e30a:394e with SMTP id
 ffacd0b85a97d-38c51931f8emr2155281f8f.3.1738148295707; 
 Wed, 29 Jan 2025 02:58:15 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-438d7aa605asm32217335e9.1.2025.01.29.02.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 02:58:15 -0800 (PST)
Message-ID: <750f06f3-6326-473f-9d08-ad6bb1f2a54a@redhat.com>
Date: Wed, 29 Jan 2025 11:58:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 09/10] rust/timer/hpet: add qom and qdev APIs support
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-10-zhao1.liu@intel.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250125125137.1223277-10-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On Sat, Jan 25, 2025 at 1:32 PM Zhao Liu <zhao1.liu@intel.com> wrote:
>      fn read(&mut self, addr: hwaddr, _size: u32) -> u64 {

This can be &self.

>          let shift: u64 = (addr & 4) * 8;
>
> +        match addr {
> +            HPET_TN_CFG_REG => self.config >> shift, // including interrupt capabilities

This needs to be "match addr & !4".

> +            HPET_TN_CMP_REG => self.cmp >> shift,    // comparator register
> +            HPET_TN_FSB_ROUTE_REG => self.fsb >> shift,
> +            _ => {
> +                // TODO: Add trace point - trace_hpet_ram_read_invalid()
> +                // Reserved.
> +                0
> +            }
> +        }
> +    }
> +
> +    fn write(&mut self, addr: hwaddr, value: u64, size: u32) {
> +        let shift = ((addr & 4) * 8) as u32;
> +        let len = std::cmp::min(size * 8, 64 - shift);
> +
> +        match addr {
> +            HPET_TN_CFG_REG => self.set_tn_cfg_reg(shift, len, value),

Likewise.

> +    fn write(&self, addr: hwaddr, value: u64, size: u32) {
> +        let shift = ((addr & 4) * 8) as u32;
> +        let len = std::cmp::min(size * 8, 64 - shift);
> +
> +        // TODO: Add trace point - trace_hpet_ram_write(addr, value)
> +        if (0x100..=0x3ff).contains(&addr
) {
> +            match self.timer_and_addr(addr) {
> +                None => return, // Reserved.

Clippy complains about an unnecessary return, just replace it with "()".

> +                Some((timer, addr)) => timer.borrow_mut().write(addr, value, size),
> +            }

> +
> +    fn reset_hold(&self, _type: ResetType) {
> +        let sbd = self.upcast::<SysBusDevice>();
> +
> +        for timer in self.timers.iter().take(self.num_timers.get()) {
> +            timer.borrow_mut().reset();
> +        }
> +
> +        self.counter.set(0);
> +        self.config.set(0);
> +        self.pit_enabled.set(true);
> +        self.hpet_offset.set(0);
> +
> +        HPETFwConfig::update_hpet_cfg(
> +            self.hpet_id.get(),
> +            Some(self.capability.get() as u32),
> +            Some((*sbd).mmio[0].addr),
> +        );

This can be simply sbd.mmio[0].addr, without the (*...).

Also, you can change update_hpet_cfg to take arguments without the 
Option<> around them.

> +// TODO: add OBJECT_DECLARE_SIMPLE_TYPE.
> +#[repr(C)]
> +pub struct HPETClass {
> +    parent_class: <SysBusDevice as ObjectType>::Class,
> +}
> +
> +unsafe impl ObjectType for HPETState {
> +    type Class = HPETClass;
> +    const TYPE_NAME: &'static CStr = crate::TYPE_HPET;
> +}

No need for HPETClass (and for ClassInitImpl<HPETClass>), just do

unsafe impl ObjectType for HPETState {
     type Class = <SysBusDevice as ObjectType>::Class;
      const TYPE_NAME: &'static CStr = crate::TYPE_HPET;
}

which is indeed more similar to OBJECT_DECLARE_SIMPLE_TYPE().

Paolo


