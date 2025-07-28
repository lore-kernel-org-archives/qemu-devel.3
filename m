Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57596C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 11:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugLvI-0001c6-9T; Mon, 28 Jul 2025 07:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ugLhB-0006HG-GI
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:07:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ugLh9-0002FY-9m
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753700821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gr715SqRiwwBylilWn+wToJKPHwgSA0nYNVLqvOI0g0=;
 b=d84z7SnDtmsWj7k30Yo2xl/fiNB2YfC7wloIOVtczmHe+GaMHgbN1jWx2hArnJn6nMvuVR
 uEdSdDWcYeqGoX+CHVlqIy1RhyVyFBmpXxRvatzfgUZAeHhuDYyl0331IUcqJE4v87OcM9
 3nKMdS9TlvckoKaC7BBmldqggEJfUps=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-ZOoW6-igNnCxJvHK-CBu-g-1; Mon, 28 Jul 2025 07:06:59 -0400
X-MC-Unique: ZOoW6-igNnCxJvHK-CBu-g-1
X-Mimecast-MFC-AGG-ID: ZOoW6-igNnCxJvHK-CBu-g_1753700819
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b7851a096fso848044f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 04:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753700819; x=1754305619;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gr715SqRiwwBylilWn+wToJKPHwgSA0nYNVLqvOI0g0=;
 b=GtYdunoq90YrNkihoL3Gu3wp2DwhxxNAvZ1h9w7DbvOU65d6X+frT1gLmJWmrIijhy
 Gssx7IKzlNF69eTY21HyWmXUGhySnLyzKJZEev2ZSefxvGzriaXw752T6JQTfAiEPCMu
 ic2cTbt22w6uBGaJsDBLsDy7j24Fc9k0qDBJGftvhYrdbhtSSTy02sHLrNuCc1SyYBoq
 4nYV0oT+mpzE1xa+RJ3Ow7TdMwsg50bUw4tL4L6gEDEZwZDSrfLYGRjtiMeP+SDvRAsV
 gbYTJ9TURseakfSktc7spMMJw5PkR/V8og03a6HRjWN2nIrIbux5C2ckjyrHIRi93uCE
 T5Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaoLYUeV9FPjT1+ynoERCewdvV1ZxaQW4RGddu/vPcSJjrtiS1BhXfmM24bBZyHMnk2vKE5Bib+hqt@nongnu.org
X-Gm-Message-State: AOJu0Yxo9jiEIj8+sFqb5rTMWuCTeAt3eT5pTi1KxKU7XxdyXxAmDQxY
 cGhS3UiJ/bQYn9Fr7r4A7yoWg1kMf0YUnDLWuihLgX3VS8z1oXNejUGv8vGhByqF4tMJs/Lozp3
 2duHDsUc+JzM2oy8r5z3xmYNgU8s5jFa5kgwtt+5PXgr4sIh+SAv3OI1w
X-Gm-Gg: ASbGncvi2hwFKXOfZdqouNb9fc5HLPFFKRn/ewvxja7u1j70HKyRavSxGsRzhV33BEj
 g1i/No9j0RjpXSuDGus+5oBtEVjbQJD2innBH89kGFl5z0b/FlSufPnz74jE/104etrTJxmXnf/
 9+IwWkEpM/SXS+fuLDJmlHhwpMqJmY8O2+NRHtxdmUsqGn6OjK5IkgOKT7wWl41j6OnN+edDfVK
 iZC8O7DOBbuPGv/y3BCpgZm5up3lLQddS9akw1w6zSxXZEyw+Gp7gEI6CsncENx1VsFWVIndnR8
 Lj8fAgLS6uZI+Gqqv1JYIcgpcbS2v0K472D9dvJawWLY7FB+OxgkwBOgY1tPvcVZHWrEmDh6zSg
 Ea1AP
X-Received: by 2002:a05:6000:4410:b0:3b7:7870:125a with SMTP id
 ffacd0b85a97d-3b778701569mr4491941f8f.43.1753700817079; 
 Mon, 28 Jul 2025 04:06:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3Gie/8U6KANIHYrj97s+g7nxy8jC3amsAAP97WjhAkCwIfYcIy5u+cC92ZOqVVPp56tnsOA==
X-Received: by 2002:a05:6000:4410:b0:3b7:7870:125a with SMTP id
 ffacd0b85a97d-3b778701569mr4491906f8f.43.1753700816334; 
 Mon, 28 Jul 2025 04:06:56 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-113-169.pools.arcor-ip.net.
 [47.64.113.169]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778f04abcsm8450284f8f.48.2025.07.28.04.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 04:06:55 -0700 (PDT)
Message-ID: <de59f63d-5567-4b56-9380-6498087cde8f@redhat.com>
Date: Mon, 28 Jul 2025 13:06:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386: Fix 'use-legacy-x86-rom' property compatibility
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Shaoqin Huang <shahuang@redhat.com>
References: <20250723062714.1245826-1-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250723062714.1245826-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 23/07/2025 08.27, Cédric Le Goater wrote:
> Commit 350785d41d8b ("ramfb: Add property to control if load the
> romfile") introduced the `use-legacy-x86-rom` property for the
> `vfio-pci-nohotplug` device, allowing control over VGA BIOS ROM
> loading. However, the property compatibility setting was incorrectly
> applied to the `vfio-pci` device instead, which causes all `vfio-pci`
> devices to fail to load. This change fixes the issue by ensuring the
> property is set on the correct device.
> 
> Fixes: d5fcf0d960d8 ("hw/i386: Add the ramfb romfile compatibility")
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Shaoqin Huang <shahuang@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---

Thanks, this looks like the right way to fix it to me:

Reviewed-by: Thomas Huth <thuth@redhat.com>


