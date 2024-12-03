Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA580E74ACF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZGu-0001j7-Ga; Tue, 03 Dec 2024 15:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tIZGs-0001iQ-JY
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:13:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tIZGq-0004C5-Jk
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733256796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baFhHHqQ78cO1EQshAvl0BS04HctJYE7yUT0FUl0jHw=;
 b=arUT4FTr5F9Hn3DRMIKLx1ce16boEENfPmPSZCWVT6bniNsh8CV3hQx9tkgcqs76syhwCv
 1GfcGZ8blCeRlx5b/EmKkz5yHjbyxSf5tHkT9el5ZkMDlUfHzYnj3Ytx1tLMAu098/XYC9
 7KWklC6rLPZEmp3zOs7kPPTLecBdia0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-4RaqFQtaNweL1FS5CoXH0g-1; Tue, 03 Dec 2024 15:12:08 -0500
X-MC-Unique: 4RaqFQtaNweL1FS5CoXH0g-1
X-Mimecast-MFC-AGG-ID: 4RaqFQtaNweL1FS5CoXH0g
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83b7cce903cso25850639f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733256727; x=1733861527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=baFhHHqQ78cO1EQshAvl0BS04HctJYE7yUT0FUl0jHw=;
 b=BMEybv9O7G8sE24T4iqjOlCh2YynvjfIfjXQLAd0BZzMXAoOiTMFSFOW+4SLyGLwyi
 rPmPEPe2DO9Mkp0vVMaLEwiOaoDHS1REuyOBXaVOHObhdOnZgluDlpduejB/fIrrUbGR
 AYxBOyzxL+SSNG8GoPwsmSyQbZDy5FwULq5ZBAONVDouSU+FQHOa6QBJkobOnOIyVBsU
 sdZ5cHIEoLux+RfUnunVhf49/fQM7DN1yw6opq4yv/X9LIYv13Exafo6ZeCDOu7lxe8E
 0OPF9N805siXaDX0PaJLv6XtT6XZFyDMJyxmRHPH2oz8Ew8x3DAEFBSMxSfFAF/GoSKU
 jIiw==
X-Gm-Message-State: AOJu0YykzljgilVSk3Urr85ZbRpXHywezElrpXw3xt1RYJWSJwoPVWS5
 Ao+obZfTEFbgyFCJHzBoyflW3aOFwymr4mkkzjEZ3gO+DHqaoqZVeQDoDg2bsFpWPZ3sewG5pfF
 mFc/heK59mJWIK+fSeOuBRClBxvRJ4aW1CxzQsTjP7hAfTdHhmicK
X-Gm-Gg: ASbGncsaB5aJ1ko/y3kRb6ASBiMKfVdiU0ik3MlWso9fgy2c/Kg7HUpew7R9ujXM8Dt
 pXbM7tFuUcVGH6d8Cy6O58z9t587Y8zf+cNPj0BPfwKqZHp89rLQnHs03zCotbL2ceZHakaMK/M
 s0qKby1QFXCNaLuQ2/AaJZbEeJI5T9dcNDs/1/bZESxOv9vnM5GsGdlk206anJ9BpOrjdyzTSuA
 mBikzEYsZIHsfw22wXdg1NvQZ9WLIOU2p9r03RbTOJV0DovC5SUpg==
X-Received: by 2002:a05:6e02:12ea:b0:3a7:e23c:d86c with SMTP id
 e9e14a558f8ab-3a7f9ab0d08mr10373115ab.6.1733256727439; 
 Tue, 03 Dec 2024 12:12:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2dKY09oMwEtvnWMrgJUgXN8pfgTZyjhpRX+/q1ljN9mysYi1XRYm5irBMlCMJyZzhuyLSkQ==
X-Received: by 2002:a05:6e02:12ea:b0:3a7:e23c:d86c with SMTP id
 e9e14a558f8ab-3a7f9ab0d08mr10373045ab.6.1733256727030; 
 Tue, 03 Dec 2024 12:12:07 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230e77c42sm2689015173.133.2024.12.03.12.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 12:12:06 -0800 (PST)
Date: Tue, 3 Dec 2024 13:12:05 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Subject: Re: [PATCH v2 0/9] vfio/igd: Enable legacy mode on more devices
Message-ID: <20241203131205.1391d69a.alex.williamson@redhat.com>
In-Reply-To: <20241203133548.38252-1-tomitamoeko@gmail.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue,  3 Dec 2024 21:35:39 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

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

The quirks related to BAR4 access are generally for the vBIOS, we
wouldn't expect guest OS level drivers to use them.  IIRC this is
handling moving the stolen memory from the HPA to the GPA when the
vBIOS is writing the GTT.

Maybe that brings up an interesting topic.  Traditionally "legacy mode"
IGD assignment has been only for 440fx machines with SeaBIOS and last I
was aware edk2 wasn't willing to accept the same hack for the BDSM as
we had put into SeaBIOS, instead indicating that it should be
implemented in the device ROM.  Your branch in [1] above seems to
indicate edk2 does now have assigned IGD specific code.

Are these patches developing full stack support of these new devices,
from BIOS hand-off, through pre-boot environments, and through to guest
OS drivers, or are we only concerned that the guest OS level driver
lights up a display?

If you're using q35 and OVMF then you must be operating in the realm of
the mythical "Universal Pass-through" mode that I thought Intel had
abandoned.  It seems like we need an update to docs/igd-assign.txt as
it's likely very out of date based on recent improvements here and by
Corvin.

Also, are you proposing the noted edk2 change upstream?  It seems like
edk2 would need some sort of device version detection to know whether
to use a 32 or 64-bit BDSM value.  Thanks,

Alex

> Changelog:
> v2:
> * Droped "vfio/igd: fix GTT stolen memory size calculation for gen 7".
> * Fixed conditions when calculating GGMS size.
> * Added Gemini Lake and Comet Lake device ids.
> * Splited mirroring register declaration macro into a new patch.
> * Minor fixes.
> Link: https://lore.kernel.org/qemu-devel/20241201160938.44355-1-tomitamoeko@gmail.com/
> 
> Tomita Moeko (9):
>   vfio/igd: remove unsupported device ids
>   vfio/igd: align generation with i915 kernel driver
>   vfio/igd: canonicalize memory size calculations
>   vfio/igd: add Gemini Lake and Comet Lake device ids
>   vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake device ids
>   vfio/igd: add macro for declaring mirrored registers
>   vfio/igd: emulate GGC register in mmio bar0
>   vfio/igd: emulate BDSM in mmio bar0 for gen 6-10 devices
>   vfio/igd: add x-igd-gms option back to set DSM region size for guest
> 
>  hw/vfio/igd.c | 248 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 151 insertions(+), 97 deletions(-)
> 


