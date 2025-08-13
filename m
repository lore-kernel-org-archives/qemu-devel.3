Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BA7CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 17:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEpT-0002vu-Pq; Wed, 13 Aug 2025 12:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1umEpQ-0002lG-4K
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 12:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1umEpD-0000jo-CL
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 12:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755104370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLHzgOQAyi1F3GpKg+itCFxs4lPnNlAV0a+Ru8ZQoUQ=;
 b=RGsrGfkfCysowWIPrQhH4d2xmh/idf8JxehuB1/Ah9wIIbQNf2u3W1xGUAZtGGya3JnzQi
 NOwpozifefO18Wke8wwnbi8u1soe842fKJZQvxQLGaa+xSiwnM6VIp9MuXZstV3nSk78xE
 ELzHNQE+L4/gsiivJIo9odi6QUJz2gM=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-o-gdcpY-MYWN0N1Zq2RMNA-1; Wed, 13 Aug 2025 12:59:29 -0400
X-MC-Unique: o-gdcpY-MYWN0N1Zq2RMNA-1
X-Mimecast-MFC-AGG-ID: o-gdcpY-MYWN0N1Zq2RMNA_1755104368
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3e57004a3b4so55795ab.3
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 09:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755104368; x=1755709168;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eLHzgOQAyi1F3GpKg+itCFxs4lPnNlAV0a+Ru8ZQoUQ=;
 b=Ge3zldLbOotVQaDIlZHMLF/OCF6+Z9BpITp0kqBSfSt0oeoQyCRCQxkZeCQb8dMCtl
 1Q72m+7yU4MmEr6dSJVGf2nyksjZ+LtfLVSfZiKteE05gIuJ9RcHP5SB1iG8Z7Ke6yUb
 Z/vQk60dUuSN14rXIRCGIuTLjU8aPN+EtMfe7UCV3MHJaonqxwWHMtThEJ+Ydm/FOTvk
 5j0+BHLN9cZc+vS6o+z7it0xDkitKM3HRw1MElHR39snH/3kIw+ZTWEx6gduPAibEsKq
 oDwLhf/Nep0o8YEPVZuJUAeb+0MO1oNuIe55QVxkeHOU1pf4JZug7MsVDZwUkBFjGOfg
 Dibg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSSfdyHiYs5+VUZRzaT7LOm/zLB7KkW2qQzF/CxXiklTiorzPz8vR3d+ia3Nv2+yk69W577srRtVDS@nongnu.org
X-Gm-Message-State: AOJu0Yy9nDXUp7RkNSLl1TICBfZdf3xaQxIXPfVyWsY9AM9LwAMoRYMJ
 suV1TLG4pnm9YM1OC6ghOjkrDpdXHBkQBBt+XO6GSmqSeYMH3dXIKxjvXdCXpDd8GRzNyjpudR8
 yLWEE1Z8Y05XY1qM6KVqa3ZhVex10E59oID8RgTykkVNlmZFpICAonXyR
X-Gm-Gg: ASbGncuU5eZvggfKeS3h7oq3X/JW9wPpL0gSvDUGnncMDI5TCOV+KNSalff94nn2hv3
 LPOTgulw0dpYnq7PaKhKWz8ByozCyj9vldGAM5GSvNL7QXDrBdTa+oBjRN6OEDbrG80GJlBGJCI
 kiOelEw2fWLnc0DKYYPP+0+hO06G4V4cIr9ebhXx/l9JNjYuKULL5w/1zATbgqSKdcHpAhp533Z
 NH3lgJqMbrQ1nlE1q3HZ99x5BiyzixdYoDlDmn2D19KvZaeWlsxp7exoLajGwx4buwjgzhQ1g3M
 Emj48NBUbEimpRYpcYXwpU5YrqxQttFKRqi9OIsZRKc=
X-Received: by 2002:a05:6602:6405:b0:87c:46f2:7075 with SMTP id
 ca18e2360f4ac-884296d8aadmr176465939f.5.1755104368434; 
 Wed, 13 Aug 2025 09:59:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZZsDgPg/V7xN+diIWs7rQlWj0KCS/GkadxeglFSO8Uh70oMh8XBx92FbPMmpmqRxTV2Swgw==
X-Received: by 2002:a05:6602:6405:b0:87c:46f2:7075 with SMTP id
 ca18e2360f4ac-884296d8aadmr176465539f.5.1755104368084; 
 Wed, 13 Aug 2025 09:59:28 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-883f19abba8sm470572939f.25.2025.08.13.09.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 09:59:27 -0700 (PDT)
Date: Wed, 13 Aug 2025 10:59:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vfio/igd: Enable quirks when IGD is not the primary
 display
Message-ID: <20250813105924.51fac905.alex.williamson@redhat.com>
In-Reply-To: <20250813160510.23553-1-tomitamoeko@gmail.com>
References: <20250813160510.23553-1-tomitamoeko@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 14 Aug 2025 00:05:10 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> Since linux 6.15, commit 41112160ca87 ("vfio/pci: match IGD devices in
> display controller class"), IGD related regions are also exposed when
> IGD is not primary display (device class is Display controller).
> 
> Allow IGD quirks to be enabled in this configuration so that guests can
> have display output on IGD when it is not the primary display.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 7 ++++---
>  hw/vfio/pci.h | 5 +++++
>  2 files changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


