Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F1CE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 16:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJb9W-0003el-Ix; Fri, 06 Dec 2024 11:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJb9U-0003eB-Tx
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:26:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJb9S-0005I9-LM
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733502357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/JXHsfupEqo1lUbQUnIR93i5XlGRzCMmaPLRFkl6gLw=;
 b=E3UEUy/NoeIYmiYeG8R5qP3mBeO3M4z+rasg15+zOiwQ3GbsTpqFx+Fj/gURtNNKPQI/FV
 ZvXl/oay99n2HW+Rc3E6mjOdVCYOrMoJeKK4tYhD5hluUMRGgh8G0Y5BruOsrlwcD7l0rU
 zOscoyQhKgp5Bt/A/mZbu+FL+R2x9mc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-73dxkbRROvmnU1k5fVxWwA-1; Fri, 06 Dec 2024 11:25:56 -0500
X-MC-Unique: 73dxkbRROvmnU1k5fVxWwA-1
X-Mimecast-MFC-AGG-ID: 73dxkbRROvmnU1k5fVxWwA
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b678f64ac9so401455185a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 08:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733502355; x=1734107155;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/JXHsfupEqo1lUbQUnIR93i5XlGRzCMmaPLRFkl6gLw=;
 b=XHcRKdFVBCLC4HLCau9dYCfk9natwGY+gQhSOb8iRjZbAtWF2MupvmLaGCuhXydQwB
 5u8YAsp+j9tBBixzgGILFW4cc0OiL7Wg1AX91V8nW9drjWCqLatbDBRmPCUQAH8tfsym
 D97rnE8k94nhr4DXMlw3Et3pKYysk2gMR7cdR1bCKBADN5xPFrAjmZ75LP7rRWPP4UmR
 oMZW5b7F0rPHPDMeOfY8kpZr3QtUu4zuw3n7wU4hukACr6bUqFsrBobfyjVUXxrKXYjP
 MNAyUfUMTSXd2twUrdNpBLCMU3bJzOFPpu7jTApZctz4nR3kJrxKGASoHrmQmFv4+489
 vLzQ==
X-Gm-Message-State: AOJu0Yw05Ss5gwXbs+gn2KEqsfd57jtfRu0MQnItqqCfbEb3SPboVF3u
 Eq7J+cuxmSfhIV/HH7YU7VLgtRuZb5Ftj9JSWpNToOPXJbTD2ipZEsCYFfk30kmlgsi9CksiuCH
 c+alxsU1844hnk+yDdUXZZj96LdvxNS+FyMv+Ixvrb6WGEMLYHrZv
X-Gm-Gg: ASbGncvLpXiY3akGEsyF2H8FxFJ3VtQjPBNo7TzTnFJ2RQIw8hKc9ykr3LhgXl/Iid4
 9coh/iloYxjZTyG0lIlNH3WOxwCq6QhlUDJLYknVgIzrT6n6/fn4MwjXBp1LhusBO0OTPNV18B8
 MegOdbPLZXaQ/6LYKs7mH58ZZFBP/gs9yCnwfm3hAaYBFnhf940h9oavSuonLFHhRVze5PHmmB0
 r2N/MZquc90cMCWOWZERJTFXC8lBRh8s0RDGVUiJVx9G4jzTjT7f5Z+GH2qRauFLQpNg3IYJ+bm
 UohSo2Fc7/bJ
X-Received: by 2002:a05:620a:190d:b0:7b6:6a76:3a49 with SMTP id
 af79cd13be357-7b6bc911acdmr726876685a.11.1733502355614; 
 Fri, 06 Dec 2024 08:25:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkl0dPNJTpMgF6K3k+oc+Dwi/4K/YPw3gWqB7Z+MPbls5PGSeUwbBvwkiP99fzBxAO3jNPYQ==
X-Received: by 2002:a05:620a:190d:b0:7b6:6a76:3a49 with SMTP id
 af79cd13be357-7b6bc911acdmr726873285a.11.1733502355280; 
 Fri, 06 Dec 2024 08:25:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a46717sm187646085a.25.2024.12.06.08.25.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 08:25:54 -0800 (PST)
Message-ID: <07bff417-d6ba-4a9d-897a-8649167401b8@redhat.com>
Date: Fri, 6 Dec 2024 17:25:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] vfio/igd: Enable legacy mode on more devices
To: Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <c.koehne@beckhoff.com>
References: <20241206122749.9893-1-tomitamoeko@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241206122749.9893-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/6/24 13:27, Tomita Moeko wrote:
> This patchset extends the support of legacy mode igd passthrough to
> all Intel Gen 11 and 12 devices (including Ice Lake, Jasper Lake,
> Rocket Lake, Alder Lake and Raptor Lake), and emulates GGC register
> in MMIO BAR0 for better compatibiltiy (It is tested Windows and GOP
> driver will read this MMIO register).
> 
> It also replaces magic numbers with macros to improve readability,
> and aligns behavior (BDSM registor mirroring and GGMS calculation for
> gen7) with i915 driver to avoid possible issues.
> 
> The x-igd-gms option removed in 971ca22f041b ("vfio/igd: don't set
> stolen memory size to zero") is also added back so that data stolen
> memory size can be specified for guest. It is tested that GMS may
> related to framebuffer size, a small GMS value may cause display issues
> like blackscreen. It can be changed by DVMT Pre-allocated option in
> host BIOS, but not all BIOS comes with this option. Having it in QEMU
> helps resolves such issues.
> 
> This patchset was verified on Intel i9-12900K CPU(UHD 770, 8086:4680)
> with custom OVMF firmware [1] and IntelGopDriver extracted from host
> bios. IGD device works well in both Windows and Linux guests, and
> scored 726 in 3DMark Time Spy Graphics on Windows guest.
> 
> [1] https://github.com/tomitamoeko/edk2/commits/igd-pt-adl/
> 
> Btw, IO BAR4 seems never be used by guest, and it the IO BAR itself
> is not working on Gen11+ devices in my experiments. There is no hints
> about that in old commit message and mailing list. It would be greatly
> appreciated if someone shares the background.
> 
> Changelog:
> v4:
> * Move "vfio/igd: fix GTT stolen memory size calculation for gen 8+" to
>    the first.
> Link: https://lore.kernel.org/qemu-devel/20241205105535.30498-1-tomitamoeko@gmail.com/
> 
> v3:
> * Added new patch to fix GTT stolen memory size calculation for gen 8+
>    devicess.
> * Fixed quirk index in "vfio/igd: add macro for declaring mirrored
>    registers"
> * Fixed condition in "vfio/igd: add x-igd-gms option back to set DSM
>    region size for guest"
> * Updated comments and commit message.
> Link: https://lore.kernel.org/qemu-devel/20241203133548.38252-1-tomitamoeko@gmail.com/
> 
> v2:
> * Droped "vfio/igd: fix GTT stolen memory size calculation for gen 7".
> * Fixed conditions when calculating GGMS size.
> * Added Gemini Lake and Comet Lake device ids.
> * Splited mirroring register declaration macro into a new patch.
> * Minor fixes.
> Link: https://lore.kernel.org/qemu-devel/20241201160938.44355-1-tomitamoeko@gmail.com/
> 
> Tomita Moeko (10):
>    vfio/igd: fix GTT stolen memory size calculation for gen 8+
>    vfio/igd: remove unsupported device ids
>    vfio/igd: align generation with i915 kernel driver
>    vfio/igd: canonicalize memory size calculations
>    vfio/igd: add Gemini Lake and Comet Lake device ids
>    vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake device ids
>    vfio/igd: add macro for declaring mirrored registers
>    vfio/igd: emulate GGC register in mmio bar0
>    vfio/igd: emulate BDSM in mmio bar0 for gen 6-10 devices
>    vfio/igd: add x-igd-gms option back to set DSM region size for guest
> 
>   hw/vfio/igd.c | 262 +++++++++++++++++++++++++++++++-------------------
>   1 file changed, 165 insertions(+), 97 deletions(-)
> 


Applied to vfio-next.

Thanks,

C.



