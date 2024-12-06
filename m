Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD22E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 16:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJasL-0004Zn-31; Fri, 06 Dec 2024 11:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tJasG-0004Sm-Ng
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:08:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tJasD-00080z-Dj
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733501284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VAx9XHZ8lL9jBGampJQkp2O3S0lS12uEwutLaGi6ckg=;
 b=QrhtlZNW4QBBSg53ERuNcQAMTFFDSj0DnK1nGk1lDeU6YH42T59jBGLFDkwZfXqfBnXUfZ
 bF1K47qgEb3iVENPHMR4UyY4tfQHwGdlIOcTPsJgYmkWHsNU06exEM16sgR9Cwd66QT1kc
 m8oj35WWBUI6QqRK6rOGyCFUYUo/DXQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-097H9KNlNG-ov7d97PzOLA-1; Fri, 06 Dec 2024 11:08:03 -0500
X-MC-Unique: 097H9KNlNG-ov7d97PzOLA-1
X-Mimecast-MFC-AGG-ID: 097H9KNlNG-ov7d97PzOLA
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-843e2e46265so34090739f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 08:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733501283; x=1734106083;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VAx9XHZ8lL9jBGampJQkp2O3S0lS12uEwutLaGi6ckg=;
 b=BiqOExyrfyZ1v1By1D9Rza3MsZAMcTinWkyZ+PNvD7zsoR7zJ/So/sQlNVDBcx0bq3
 KR+TNdkrZsIB6YbtXBQJAtZjvS2dIY2awMQrJ2UtAT6nZ/V6n+mGBVwjYjvDCVr3FzpE
 dOKsOpbnGRxPG1wlKCGLmd6kQQXfryVe1PFxOCvhsBz6z9qdMr5ifQApYcb3Ht4q40K/
 LmVNPMSL88Dqrn5zWqdHIVD7vv/LztZ38mHKCfAb0AblU3hjaCoOAZSeDRoxfSXRJqGP
 IIO8cynPoXEVj7kjiJvkgx/XOneNT8/B9V0iqi45OG8evMUA2W8c/EtQVfdtqxS6czZI
 TYdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDQuBRp5p+acheoH9B+uB3M/EAh7g8s/ZCSEXv/wYfPTKKcAnqFEY+cstKMyTu3OgoXt5h9zlkEt3q@nongnu.org
X-Gm-Message-State: AOJu0YylosvOPFlIm9JAqvbjAvlWAAn/gH/qVoosAVLs+AOx7FmShyR/
 6mWBoXBDq6Wq3hKcU5VQ/7MW1lm8uM1L9Lcpue7UbI42lOuOXf+YDj2PlVSoXaiKl3aBc1j0ji0
 vUB8aTHMk4gRXD5pKJaaU7uV7uwOBIXi0VpYbOdBfO11q3syn1Rqi
X-Gm-Gg: ASbGncvldQG7oNNTJyFA9aI+uqw2XaPVv2CO036gC+ZJHt7UI8JhVmzT2AomPqnpA3b
 NKxdkJv7NeZfnj6TGTqGr+eRYVPX4zIX+rxJ7tSEQZFs+hkAEKOX2O7jz6jL0AiGI2w/iTTBDPY
 JkfGnGUpmFXZoJCwWEIoslDNaBlaWxbNzLhJfBVVH79mn7OgWyEq6LSoBbGaIw/6KgF+MOOyWPh
 /C0HXLFd9EGD1OZmFhXwTIGsb1D/5yjZGMxoxUoxNvcF8imQbfjvQ==
X-Received: by 2002:a05:6e02:1544:b0:3a7:e23c:d86c with SMTP id
 e9e14a558f8ab-3a811e4b82dmr10441155ab.6.1733501282859; 
 Fri, 06 Dec 2024 08:08:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkf3QHhoWy/ERdP/UljwO9AsSonS7aK6j3Oq68fD58PIv8XIIyr7AmqTF2OgBCYr0piEvzoQ==
X-Received: by 2002:a05:6e02:1544:b0:3a7:e23c:d86c with SMTP id
 e9e14a558f8ab-3a811e4b82dmr10441065ab.6.1733501282519; 
 Fri, 06 Dec 2024 08:08:02 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a808db1f49sm11632175ab.34.2024.12.06.08.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 08:08:01 -0800 (PST)
Date: Fri, 6 Dec 2024 09:07:59 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Subject: Re: [PATCH v4 00/10] vfio/igd: Enable legacy mode on more devices
Message-ID: <20241206090759.7e2ea1cc.alex.williamson@redhat.com>
In-Reply-To: <20241206122749.9893-1-tomitamoeko@gmail.com>
References: <20241206122749.9893-1-tomitamoeko@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
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

On Fri,  6 Dec 2024 20:27:38 +0800
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
> 
> Changelog:
> v4:
> * Move "vfio/igd: fix GTT stolen memory size calculation for gen 8+" to
>   the first.
> Link: https://lore.kernel.org/qemu-devel/20241205105535.30498-1-tomitamoeko@gmail.com/

Series:

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


