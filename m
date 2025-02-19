Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B124C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 18:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkpHf-00080I-9x; Wed, 19 Feb 2025 13:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tkpHd-0007zu-HE
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:58:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tkpHb-000786-Cp
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739991533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gZ/ma8ZU2lNoh2I96AVFwFLpkIjrtQUTOPW5IwaPdi4=;
 b=QU5HVbZIpLz2PpIZP0g21njqqb0kAM/TOdKGDZisLYfkqfGy4QdQghpONxi8Ua6gN2WtLd
 sNCFxqXO+bRkGDxvUnsqJQ7DQJuunrAHLQpAr5Uuiz+rSNUwSbNE8ccibl9Hp359k6REkB
 sO2PYG8aw4Thf7BkSF+OxJCT24Ijx6o=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-gqgDGo4VNNCdLjbzJGf28g-1; Wed, 19 Feb 2025 13:58:51 -0500
X-MC-Unique: gqgDGo4VNNCdLjbzJGf28g-1
X-Mimecast-MFC-AGG-ID: gqgDGo4VNNCdLjbzJGf28g_1739991531
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-855902600b5so685139f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 10:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739991531; x=1740596331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gZ/ma8ZU2lNoh2I96AVFwFLpkIjrtQUTOPW5IwaPdi4=;
 b=YnYtzUcOxzftv3uITUgyAViNUJCtKjYhMgXNyjX0Z7GDlIsU2mGWeDHUGIRgNOVLVR
 SMlBkMbEMV5zyGto2nEdqPJCuT+6fbz+FFMEo9kHWWHNoNHBsNUx1JE2BglvNHhSvBUe
 6WRwF6nLXsQZD9aNOhYco4qbt3VNIwF4vvUKbuHBp1pXX89mrsTPbueirWjamWCnrEYF
 1ao92TcpJleLcIVcPN5PgVQxk4w7KW1ZWnn7wVglGHHBbR4T9buFVi52QSGLxoPLzuxg
 yPtmYAWbiq3o9mfIgf7IZs5gg3C/auCrBmmBc6yT1Nk9YT0AFNa8QsAfQKhasg3KDEtd
 zQsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeL6teXIC9xuOfPXvEFD2GunSW9DXurl6/94L8UJmkPBZR8NHnmCp3f/VjYz1a1OTksAmiT7kUE+TM@nongnu.org
X-Gm-Message-State: AOJu0YwHhjJOM6RZTjfhjJtizuHouY3CzyMw4yTzy7qhkh7nCQuuTSA1
 R3Q7y7LvAsKGRA8gmHI+8d+sMLzCLwkLPLUjCuyrOuFJ1R1sMu1jdUFw0yZ6W8eLFt7j2RDrPnt
 DlLTZwvFW8uz/r5CZ2s1+qsVct8Sg30vhRTMcXWkSbU5/sSFAXfMm
X-Gm-Gg: ASbGncuTQAMRHj1Amnemhw/pSLvKjEW2GtYztO5OXtg/g9bBXoe14FeeNd3ziqIvU4L
 FIlLEqFkHLbJBhYTkX7S6v5KOSYg7KnQhbniJ657xNFoJcMQlIaJj6W6gUXxZd7653zKynt4rSJ
 xY1cPrlkO4DX13rr19A48DU8QefXfveDHOpxe1VYpNVUXtQSWFoxuD3QGOWy5dLlTBH+Lzp/4Vn
 prb1dXUVFU/7XRqV7N0VoSv9jtFF7S2xOGPYfPMKM20E+KGsKCgestiZ8LjgQr3tyU1FNhr90L6
 b6Am+MsV
X-Received: by 2002:a05:6e02:1805:b0:3d1:3d56:d15d with SMTP id
 e9e14a558f8ab-3d280935057mr49049565ab.5.1739991531132; 
 Wed, 19 Feb 2025 10:58:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4ouS3cXetRF3Hh63qBAwJ/0rYMso1UHS/DwzmJd8hJS64g33fAIDmSJ0w910nfXL5D1/nGw==
X-Received: by 2002:a05:6e02:1805:b0:3d1:3d56:d15d with SMTP id
 e9e14a558f8ab-3d280935057mr49049515ab.5.1739991530800; 
 Wed, 19 Feb 2025 10:58:50 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d18fb56f99sm29796085ab.50.2025.02.19.10.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 10:58:47 -0800 (PST)
Date: Wed, 19 Feb 2025 11:58:44 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, clg@redhat.com,
 zhenzhong.duan@intel.com
Subject: Re: [RFC 0/2] hw/vfio/pci: Prevent BARs from being dma mapped in
 d3hot state
Message-ID: <20250219115844.062c5513.alex.williamson@redhat.com>
In-Reply-To: <20250219175941.135390-1-eric.auger@redhat.com>
References: <20250219175941.135390-1-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, 19 Feb 2025 18:58:58 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> Since kernel commit:
> 2b2c651baf1c ("vfio/pci: Invalidate mmaps and block the access
> in D3hot power state")
> any attempt to do an mmap access to a BAR when the device is in d3hot
> state will generate a fault.
> 
> On system_powerdown, if the VFIO device is translated by an IOMMU,
> the device is moved to D3hot state and then the vIOMMU gets disabled
> by the guest. As a result of this later operation, the address space is
> swapped from translated to untranslated. When re-enabling the aliased
> regions, the RAM regions are dma-mapped again and this causes DMA_MAP
> faults when attempting the operation on BARs.
> 
> To avoid doing the remap on those BARs, we compute whether the
> device is in D3hot state and if so, skip the DMA MAP.

Thinking on this some more, QEMU PCI code already manages the device
BARs appearing in the address space based on the memory enable bit in
the command register.  Should we do the same for PM state?

IOW, the device going into low power state should remove the BARs from
the AddressSpace and waking the device should re-add them.  The BAR DMA
mapping should then always be consistent, whereas here nothing would
remap the BARs when the device is woken.

I imagine we'd need an interface to register the PM capability with the
core QEMU PCI code, where address space updates are performed relative
to both memory enable and power status.  There might be a way to
implement this just for vfio-pci devices by toggling the enable state
of the BAR mmaps relative to PM state, but doing it at the PCI core
level seems like it'd provide behavior more true to physical hardware.
Thanks,

Alex


