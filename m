Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4E0C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9HGA-0001ou-Rf; Wed, 23 Sep 2026 03:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x9HG7-0001oY-MV
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 03:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x9HG5-0006bh-TM
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 03:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790147951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KeDlBcgSam3Snn/++4n8vrGEpKgz9tFFNfo0/7mZhHo=;
 b=czft6Uu8Pb5DsE8Cw0A34amIh5POIejcoc/0b40kKA9h57ooOJhc+SE2IrszRSbK+e1w1p
 1+6mt1UaE1utXqzD6t577uRx5i1XdTkZuF/iSw32dT2cxA7ygcTYtttY1E2HE1R25p15qM
 WTKoFjf/ukHik/VMPNoANwGJAurroWA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-lP5zc6nPPgKsyzRK-tj-WQ-1; Wed, 23 Sep 2026 03:19:10 -0400
X-MC-Unique: lP5zc6nPPgKsyzRK-tj-WQ-1
X-Mimecast-MFC-AGG-ID: lP5zc6nPPgKsyzRK-tj-WQ_1790147949
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c2939e341f7so63800366b.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 00:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790147949; x=1790752749; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KeDlBcgSam3Snn/++4n8vrGEpKgz9tFFNfo0/7mZhHo=;
 b=bvWGIZJh1GXLg6uIwzfaW/ydnsKT8PlUdY2Z0gX5VtES2c/F9LVhaTjyxXRmR6IcOs
 Ri6wYMVZTfrrJT8YL5XzCvUPYrjOU+sKIZSKfpXELKNjREr/6y6hcU0+lPaCCJvh0vdz
 qMfH8N/6WxGoQjFOSpW5xHavEYF+j+2fFsOW5j2vCJZdDf4/Q0HwnbLci3mhdl/zsztQ
 0wOK/4iGwUD8GCH1Vgj82X/ibl/E5o1jeicJxA3luw9ii/Mx1uRecFKL7GM8JAxkwvNj
 ZLhlJCyoy60oRzutj0dzLvqS/+m1D5qXH+cvJJQdNs0NhZFAT51SsI+wAt5VTMxPThPm
 13yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790147949; x=1790752749;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KeDlBcgSam3Snn/++4n8vrGEpKgz9tFFNfo0/7mZhHo=;
 b=CXN/HQviOXOAVuB/8MDSYUMGr3GoXvhsaum+/g/2O+3/KZKUYX9EkNFF7VBY4IjPF7
 928RzL6yfT3LubyfQX/n8+fQBWytaHQUy8ay0wbrmcmfXSzxobObmJ3vGZ3fAYu10lIR
 253s9bUqCWf1y2c+14LLKRNIeIycD3nLGzNZuL6LXWSGtWAj3x4zLm2JMclW81BN9FMJ
 NAqXljnS+eU65bMeEATlz9iMACRQ3RmaQv4ZHP/IVOvoLxJ+YTYdQCfBP0RiaLlEQrL5
 sNEfxZBSJu/dyonlgV48w75PbzDoVf/rcHosv7uFZUCrhzUlG4Ed3d1vm3h7PJPcvlfy
 r6LA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnCIdUtndBj4a2nlnmmEtlo+TkL4yCdfimfKuPVn3XfBfn1cLBe+NeqUxaLJpO5V/RdwhgBTK9nsLf@nongnu.org
X-Gm-Message-State: AFuF++mbVDXgTEgQ9jDFvyKsDvZdpElopRaIXb3d05ygi/GX4oz20rA/
 3oZt3M20amlYXo/HTHpd6s9dzlK/v+2jkVgkWYMwv0MF6ycItjH59xaMMcinJWlKX9g+WJ+TMOW
 uRzCAL/en6LfCQlmllQToKs49oSMxKI27uDECORhn/3XbB2UlnPrPhoVS
X-Gm-Gg: AYBFou3w4FQalXrewlTeIJQoBQLALMNOTqKK7yzXZ5nqkyqsyFAwPhkgHa1NUejl2KZ
 5m19WvyYGQ+tzXQXgJ+clXSGNyqCU8jT0Efo/A8Rt3Os6fTCjWlNOEkSxjXjpjwrXCws154LXbj
 Icj9RTbZBp7dVuwgEV3cnvVmtW8RhlguLdOpfnRsUYyKSQH7GQ0yYtbieXkh8V+flWVYmcopNaT
 eeIb7LhbvJWU7b9HpuLiDH7ZTA0ndTSFdJo986EXn5uo/L3hmQADVyrgCItPdWwYU042eK+SH97
 n94Q3YtgcAKBAzYdsEWpCNHeevvbqcnh6EL4AmbWdrWKH+3pzr9eC5d/LSY484u67Cv3jNFFz5j
 8KM4f3H7kLQGEuqVP+KXQAJ6NQdxJDcg8ADEPDsW0
X-Received: by 2002:a17:906:f58c:b0:c29:448b:f5d4 with SMTP id
 a640c23a62f3a-c2aae2b0595mr139349866b.35.1790147948844; 
 Wed, 23 Sep 2026 00:19:08 -0700 (PDT)
X-Received: by 2002:a17:906:f58c:b0:c29:448b:f5d4 with SMTP id
 a640c23a62f3a-c2aae2b0595mr139348766b.35.1790147948503; 
 Wed, 23 Sep 2026 00:19:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae6d654bsm59543866b.58.2026.09.23.00.19.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 00:19:07 -0700 (PDT)
Message-ID: <17b3794f-9898-4089-b51c-441c0729526b@redhat.com>
Date: Wed, 23 Sep 2026 09:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] vfio/igd: Make MTL/ARL guests fall back to BAR-based
 framebuffer access
To: Yuan Wang <yuan1.wang@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, tomitamoeko@gmail.com, bosheng.xue@intel.com,
 junjie.cao@intel.com
References: <20260923052511.2842596-1-yuan1.wang@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260923052511.2842596-1-yuan1.wang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/23/26 07:25, Yuan Wang wrote:
> Meteor Lake and Arrow Lake GOP can read BAR0 MMIO offset 0x138914 to
> detect whether direct framebuffer access via DSM is available.
> 
> In a VFIO passthrough VM, the guest cannot access the host DSM memory
> region via such a pointer. If the guest GOP enables that path, it may
> hand off a DSM-based framebuffer address that the guest cannot actually
> use.
> 
> Intercept reads from the detection register and return 0 so the guest
> does not enable the DSM-based path and instead keeps using the standard
> BAR-based framebuffer address.
> 
> Suggested-by: Tomita Moeko <tomitamoeko@gmail.com>
> Reviewed-by: Tomita Moeko <tomitamoeko@gmail.com>
> Reviewed-by: Bosheng Xue <bosheng.xue@intel.com>
> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
> ---
> Changes:
> v5:
> - Rebased on top of Cédric's vfio-next branch to resolve conflicts
>    with Mike's commit.
Thanks for doing so.

Applied to

     https://github.com/legoater/qemu vfio-next


C.


