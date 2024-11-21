Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3DAD6ED04
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 11:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE52y-0000CM-GE; Thu, 21 Nov 2024 06:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tE52w-0000Bw-GX
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 06:08:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tE52u-0002I0-3x
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 06:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732187302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZSm40vKu9QKzup4hQxLg1EiiTpZrLAXVR4ECFVOf/no=;
 b=WuR6C0M9B/4nKLYrBd1YMvlezmFs5eZ9XB8pfaIt5e6hklFPncVizNj0C9jVjuohx3UnmK
 CHy8/Es4Sg7BF/hfz8Qyz+5DzKVvsMX+HgxoCT1L0+/iRYtcqxjPcfswCNDDANyvQs+qil
 Zxv7o/qtGuxfj+k2am67AAAWX+Cqr5I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-IMyVQdR5OZO7Dejz3eNFOA-1; Thu, 21 Nov 2024 06:08:21 -0500
X-MC-Unique: IMyVQdR5OZO7Dejz3eNFOA-1
X-Mimecast-MFC-AGG-ID: IMyVQdR5OZO7Dejz3eNFOA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3824395a677so364245f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 03:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732187299; x=1732792099;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSm40vKu9QKzup4hQxLg1EiiTpZrLAXVR4ECFVOf/no=;
 b=uOOelFpene9bM74dvbyoXBTuuHniBr0vyms1HFwcMfBdMVA+QRKw+GkhEGksf1tscU
 FyHrMlMYGVYZBctOBRJRRWOmvb7PgibBh5N84UIKvHM6toS14pSzwChHMu/gDBlCiFdn
 oBxnkpB1RgQOXf7k2IoUXPR/YHw/ffQat3DQc+319cy6ml0+BcgyEBP1mYKVNaFXjH1c
 NuJoAceZjnXvQqc/QcInrOtlwFSRW9Jda+NXH75XYK0EeQWaWLkQ+ruO9LG+L/EZXV1V
 kMZCVPDmqoWvRKQxgSSDRFh5cZSImPOAtuxI89mPNDO8FzEVPJoHGgN+nI+XAfUy9B5+
 MhWQ==
X-Gm-Message-State: AOJu0YzpEnhFeIvCBY36411jNMQFLgsGqRH1Z2h0xXj69HRIE4kBEqdx
 VQKIqDmgCZ9sXBFOD5c4pRgLRaX8j4bRltVfpRrlA5obPBQ2uV4RPErmvb1w2gDapWlxDUlvxsj
 VKbaiGrIzycah3+DqzhUH6y6X8p4uh826A+rAthm8tkVyC0KDsXAzeT8wZ+zW1SWj/vsNfG7L8U
 hXhMylYmLhH8iHY6b1xQEvXl4/ulzLliIAaw==
X-Gm-Gg: ASbGncvYYNfWXAaoYwFKTpXTIloGkE0XGNAy9V3LC7wahEsBM7HClqniE7nou4VUFCE
 5G8rUJAJZuuVXwN/RVAIOUrntFUdDqxSxNpqnxqM3KZTGcvI7iY1Cho3D63+9RgQfAlUQr67orf
 jHVLvDTVlwGmWvtKbLqpRMYD4zvxu3IWCc0C6v3Ul2wRnPT9epY/EKvUkXSXctLovpfXjIYylj+
 qEhyRI2YuTJ8S8zpovNoy3pL8gWD6jAgHzAI2dXn9xVEVJ9GNbp8OvAhIW6bUsDHtq+tJ035O7L
 dOYlYEWigq6Oml5MRaqGM8c=
X-Received: by 2002:a05:6000:2a12:b0:382:464e:1ab4 with SMTP id
 ffacd0b85a97d-38254adee18mr3486879f8f.3.1732187298856; 
 Thu, 21 Nov 2024 03:08:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbutwYDYUL/VGg4e2FrXIZ8urzCmiKmvw1ITROfvkiJ7dImr5pG58xHCXNn/QotROQii462g==
X-Received: by 2002:a05:6000:2a12:b0:382:464e:1ab4 with SMTP id
 ffacd0b85a97d-38254adee18mr3486858f8f.3.1732187298463; 
 Thu, 21 Nov 2024 03:08:18 -0800 (PST)
Received: from rh (p200300f6af368f00f7bae606b15f3bdb.dip0.t-ipconnect.de.
 [2003:f6:af36:8f00:f7ba:e606:b15f:3bdb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38254933bf7sm4812403f8f.72.2024.11.21.03.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 03:08:18 -0800 (PST)
Date: Thu, 21 Nov 2024 12:08:17 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: qemu-devel@nongnu.org
cc: Alex Williamson <alex.williamson@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] pci: ensure valid link status bits for downstream
 ports
In-Reply-To: <20241111123756.18393-1-sebott@redhat.com>
Message-ID: <4995a8b7-af4e-cc74-81c5-9a7fb066ec1d@redhat.com>
References: <20241111123756.18393-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 11 Nov 2024, Sebastian Ott wrote:
> PCI hotplug for downstream endpoints on arm fails because Linux'
> PCIe hotplug driver doesn't like the QEMU provided LNKSTA:
>
>  pcieport 0000:08:01.0: pciehp: Slot(2): Card present
>  pcieport 0000:08:01.0: pciehp: Slot(2): Link Up
>  pcieport 0000:08:01.0: pciehp: Slot(2): Cannot train link: status 0x2000
>
> There's 2 cases where LNKSTA isn't setup properly:
> * the downstream device has no express capability
> * max link width of the bridge is 0
>
> Fix these by making the LNKSTA modifications independent of each other.
>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>

Friendly ping. This fixes PCI hotplug to a downstream port on ARM.

Thanks,
Sebastian


