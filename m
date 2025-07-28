Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B480C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 15:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugQ4P-0005rM-IB; Mon, 28 Jul 2025 11:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1ugQ4H-0004l6-TO
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1ugQ4F-00030j-Sh
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753717629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBLKkvwuJVVQcJaszxXSX2LMwunHw5V7xOZf8nca3Uo=;
 b=IFX9BDt6nSSv1IU7pHqaSGIWU9dAA6jLUcrmFkE+gr491nzjz93bxQ4b4GrKaKsnCeoaeV
 KR/5BgKeHiD2M7+ETFxGuRPYpxDZ975EYkVpWeVUooqyxAEfkjW0kbosPG6o3BZaM9jfjd
 AdfiQfFd+7not8EieUJuA1d3/5zBwjo=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-OLWKqsh8OGuHymRZrRup2w-1; Mon, 28 Jul 2025 11:47:08 -0400
X-MC-Unique: OLWKqsh8OGuHymRZrRup2w-1
X-Mimecast-MFC-AGG-ID: OLWKqsh8OGuHymRZrRup2w_1753717627
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3dde762b351so8281615ab.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 08:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753717627; x=1754322427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aBLKkvwuJVVQcJaszxXSX2LMwunHw5V7xOZf8nca3Uo=;
 b=EbTD5tG+ttR719Nbh8lb9j3wxNGV8YA4omxj/mPYplBPh8GH1wvyLLP0b3F6OwVAea
 Keop/cmNMq/rifghAbyQqkr+Rd5ZI+PlSa+KHM1TN2Ob7qWSLryR6MeVcLyTLlV89+iw
 sWqRjifOcAgI82OQRDWQb6KPA8La/tg3tKjCrFnDm2iMOVck3fJyP4eaC0mAo11lzL/O
 pobfOhj82n7mPcTS0CT5uzMzqUxUFZ3LempXVcN7VnIFQQko9Gl8mexr/aZex76jh6kR
 XcOTbZ8D7PBSG8XcV8NBJ828lI7C427yaUGok5j/gStP2RR5DAAydmfdSARxf+60hc7x
 4poA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlZ8dzEv4UTK/EmvLT67P+70X/7NxSbUKMgAk9BxsujBxwlNiYpUIq2D91uqnd0bbaatWyMPtFrUyc@nongnu.org
X-Gm-Message-State: AOJu0YwYyvAikelu2IJqckH9+hiF0oz8yHUxuq9OrEiwPTY67Kxolvs+
 +N2mWIDV0FkkhyVjEwbsWcoxRK1ZU5s9uXLNWlgrzE/9X1iX141boNzradxSByNHZmSfM8qK8/J
 656dYOmorvjvIaBGFC42dKLBgIOpxNLbEZmVb1QcCFQQMyehCkp8yaZnDUchng3MA
X-Gm-Gg: ASbGnctcnNOwJew8ST1lpGNiD1WQ+wPc/5ll4tsca7+X6ImAAaAVPAlaTnHWYZXZKlu
 fWR+XEvEWw+L9Ms9TFuOfsASNqPZIX/3a3GoX6tBEE+o2nyVQq4JsWjS/gQk3YmIrMACJJEnGyY
 DIC9pgP5qyqiKHv6P2SrC34fgFvZh8v00TlStvKmgfEI7lgIMBJtpDXDYmsNHgYxFxv6+eNn+EB
 gEsA7UA35sgCbc+zSp5rTxMfKZoYYBUyCoIc0yUP352NsvTFOdbD6ps42E2BelqMdXVmKsrQudW
 WwFcvtXJwjOv/PDA+uZwN2Cpdq619r1o8+yxkQjaB6c=
X-Received: by 2002:a05:6602:342a:b0:87c:46f2:7075 with SMTP id
 ca18e2360f4ac-880229e3cb3mr574141839f.5.1753717626777; 
 Mon, 28 Jul 2025 08:47:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJfzqlPgFqv3PbbyFpE0KXrRg0XUFwo8wJqOXNIGl4wxSF1/6Dh1PAHnrPfYoFeTXjYST9JQ==
X-Received: by 2002:a05:6602:342a:b0:87c:46f2:7075 with SMTP id
 ca18e2360f4ac-880229e3cb3mr574120439f.5.1753717619433; 
 Mon, 28 Jul 2025 08:46:59 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-880f7a6b62esm182742239f.35.2025.07.28.08.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 08:46:58 -0700 (PDT)
Date: Mon, 28 Jul 2025 09:46:56 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] vfio/igd: Legacy mode fixes after introduction of
Message-ID: <20250728094656.017faa03.alex.williamson@redhat.com>
In-Reply-To: <20250723160906.44941-1-tomitamoeko@gmail.com>
References: <20250723160906.44941-1-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 24 Jul 2025 00:09:04 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> This patchset aims to fix 2 bugs on legacy mode brought by commit
> a59d06305fff ("vfio/pci: Introduce x-pci-class-code option").
> 
> 1. QEMU tries to enable VGA access on device emulated to VGA controller.
> 2. pci_register_vga() is not called after calling vfio_populate_vga().
> 
> 
> Tomita Moeko (2):
>   vfio/igd: Require host VGA decode for legacy mode
>   vfio/igd: Fix VGA regions are not exposed in legacy mode
> 
>  docs/igd-assign.txt |  1 +
>  hw/vfio/igd.c       | 19 ++++++++++++-------
>  hw/vfio/pci.c       | 13 ++++++++++---
>  hw/vfio/pci.h       |  1 +
>  4 files changed, 24 insertions(+), 10 deletions(-)
> 

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


