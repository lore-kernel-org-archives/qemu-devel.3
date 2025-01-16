Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA0EC02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSYB-0005SI-TN; Thu, 16 Jan 2025 11:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tYSXg-0005Jb-Jx
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:16:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tYSXe-0005wb-VH
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737044180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qn7pHeSHWwfaxBoO+rtO+9M10JkOv/FnvuiE2vosEgY=;
 b=TBHp4WJqjcydz4c73dgiARdQgaHPHNG/2yZgDNJmXGKeYSsCJBuKMHKH06nDsJgVaCdDZJ
 RctBKK69xbF3mieLWCsW0GJ1fFGDi+8OwTACcNtAlM43D5JhtltC138Fdg1MQcAmcRVTgw
 VM8R0ERP+estOzGR+QjyuGWVsmzNo/w=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-Udl_L8OvPIOt-fghWMjQZg-1; Thu, 16 Jan 2025 11:16:17 -0500
X-MC-Unique: Udl_L8OvPIOt-fghWMjQZg-1
X-Mimecast-MFC-AGG-ID: Udl_L8OvPIOt-fghWMjQZg
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-849cc81984eso739039f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737044177; x=1737648977;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qn7pHeSHWwfaxBoO+rtO+9M10JkOv/FnvuiE2vosEgY=;
 b=gkNAB2SlOzBZkgQtruxmn9nYtE3gZ4le+1lG4mWeQohc5id73wjBgK3W9LBFwZ15XN
 QyQm5UEUgqBR2Lzs5uOPrmwI9N7qZt7UeukWWy2V6orwDjuAMRuEh10lK6IAqF5NGyvx
 p0MyJIj41xMv2Usuksi0DB3G3XTtv7mW3CDyOCYpdtj7z1Hn5eqv6awduELa1K8TBGwt
 gaaBaB72q4buOIZYOSkRpkfZj8s4GaX484JZQUHwZVMbAOeWscQbfqLIjKNnyHn3xqYP
 cGuYgAAAwEV6WzOpBJZqh31nwQJChZqWfpliG43T5LW5GsLL6sTmdxKI1Bbr4hyj2Pce
 MNUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBL8qCHy38rd30n9suoLq0/H66FC1HzmwKCeAhcs/SRS/8h+QW48ZXXNKjS5VuwUi3947orwLmYaEo@nongnu.org
X-Gm-Message-State: AOJu0Yw+SSLRujAWO7wADwpWXGa8IvbY0yiB0VrsRpquh+jwd9FmzmzF
 6bgL3TRu3Pd4yzJeIucubztfVJ7L0xAom7uFdNhazEAXS9jO2gPnH8NaNCKkGQu31ReyAroNjN8
 1tEe+Su10L3qAvstdNoCSTRme0LE0m2TfpI5HMzNPGb8FAwJCyP08
X-Gm-Gg: ASbGncv0ZhYsZcDj6aMpKvjCI7iWHpU7ejIDN4a6+E/KeenUUy69ABWCGp8d9u3Wl/L
 bMr2/ffYhmhOcgKNI6s8hyjUANJySHvmBSbVoNWyJ8U90TXmOs7hFpwb5RTf3tYlqHiOMcDkKjN
 P8KKEDGfndcJaljp5q0Kjs/w546crUC/tbjFcFt2HJRWRbPep8b6jFQ5gayi2WkB8wHksxtHlu9
 CTfZpnj+nNQYMgn1t479peaPQr8m2DBMJLXsk+nWlSaQgxboZVfh3W5qf+J
X-Received: by 2002:a05:6602:6d13:b0:84a:51e2:6642 with SMTP id
 ca18e2360f4ac-84ce00817f9mr885112839f.2.1737044177051; 
 Thu, 16 Jan 2025 08:16:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHanRnHrSQEM0emHuJ5Ax5uVYPsydLP2tP42N5j61iK36kRj4z061TmBJvdAxYeEOW/TukioA==
X-Received: by 2002:a05:6602:6d13:b0:84a:51e2:6642 with SMTP id
 ca18e2360f4ac-84ce00817f9mr885112039f.2.1737044176733; 
 Thu, 16 Jan 2025 08:16:16 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea756806dcsm90778173.131.2025.01.16.08.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:16:16 -0800 (PST)
Date: Thu, 16 Jan 2025 11:16:03 -0500
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/3] vfio/igd: VFIOConfigMirrorQuirk for igd mirrored
 registers
Message-ID: <20250116111603.20ae42db.alex.williamson@redhat.com>
In-Reply-To: <20250104154219.7209-1-tomitamoeko@gmail.com>
References: <20250104154219.7209-1-tomitamoeko@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

On Sat,  4 Jan 2025 23:42:15 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> In commit 1a2623b5c9e7 ("vfio/igd: add macro for declaring mirrored
> registers"), I introduced a macro to handle mirrored registers in igd
> bar0. However, using the existing VFIOConfigMirrorQuirk should be a
> better approach I think after going through the vfio code.
> 
> This patch set introduces a new header file, pci-quirks.h, to hold
> generic quirk declarations, and extends VFIOConfigMirrorQuirk to
> support offsets in PCI config space. This eliminates the need for
> the previously introduced macro.
> 
> Changelog:
> v2:
> * Removed 'const Property' change, it was a mistake in rebasing.
> * Removed unnecessary initializing config_offset explicitly.
> * Separated GGC and BDSM mirror into 2 quirks.
> Link: https://lore.kernel.org/all/20241231151953.59992-1-tomitamoeko@gmail.com/
> 
> Tomita Moeko (3):
>   vfio/pci: declare generic quirks in a new header file
>   vfio/pci: introduce config_offset field in VFIOConfigMirrorQuirk
>   vfio/igd: use VFIOConfigMirrorQuirk for mirrored registers
> 
>  hw/vfio/igd.c        | 125 +++++++++++--------------------------------
>  hw/vfio/pci-quirks.c |  57 +++-----------------
>  hw/vfio/pci-quirks.h |  72 +++++++++++++++++++++++++
>  3 files changed, 109 insertions(+), 145 deletions(-)
>  create mode 100644 hw/vfio/pci-quirks.h
> 

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


