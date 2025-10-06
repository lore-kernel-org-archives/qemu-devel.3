Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3C0CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 13:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5l1S-0007T7-Ia; Mon, 06 Oct 2025 09:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5l1P-0007Sj-WD
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 09:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5l1H-0002j8-HW
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 09:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759756364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZX5X7NZc+e0nNEzSVMGJer7k1nFPtWQz0KM+RWSTz4=;
 b=bq2GIaK5n/DUYUpH5xqyzx6d97VxjMgh8xu/gvFOUgRM7E1QNAsRedSBfrKZHlQcW44YgJ
 qZx4xaa+7Js2AhdMB7OADA+REpgjlYddBvJY5A7ix9ScdnIsEHigritnORnP7ZGUA7mukg
 LEobgSraqj+I8pXIGzuIMJQTnGWEytM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-yDddLTVFPJmtpuADZz5j7Q-1; Mon, 06 Oct 2025 09:12:40 -0400
X-MC-Unique: yDddLTVFPJmtpuADZz5j7Q-1
X-Mimecast-MFC-AGG-ID: yDddLTVFPJmtpuADZz5j7Q_1759756360
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e4cc8ed76so20126885e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 06:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759756360; x=1760361160;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bZX5X7NZc+e0nNEzSVMGJer7k1nFPtWQz0KM+RWSTz4=;
 b=h+PCxYSYSjqfshv2vaZF/ooGTPZrWGdirxzPNirf5c2MRVDBjF7w3oUQsGClmpfiu/
 iEy5e8DpTekGwLZ0RxpGW6qyTX2u6hTZrK3niUfEs5y9+8RZgILXUSaWnifsDt58pZnL
 7VelGct4FZLCMds0+m0hMGn1HgKDPYZHkozWM+adLFOW4s00padcyoLWcGnNxbcpCwLP
 YiemJJZn/C59X6R9aJZiVEWtH/VQ5K5oBbxxkw5Llqj6fPUbPGdMBbmItH4F+HOKO/G1
 4g2GneMJi85dg+QaCJfsrkbN7a6kHtCZgfGVEb5UT01PJYKKksUtsJvlvpyRKfCMKzRa
 jC4w==
X-Gm-Message-State: AOJu0YyQ39L4xPXYet0I0Qq9oDXm9Txyni9FNQ/J1azcy5YgSzo6J0Gd
 uATF1vKtJPwFZismGdnH5A1X/J6gxvzk4dq2NOA7stsieZovIsd1MpzprjrqPs38MPOhnJ6HFLO
 +LXRvc3pTlYrElo8Dvb8IYlwFG694OimLX1+a1RU+CSArOm8KNeuJruau
X-Gm-Gg: ASbGncswzJ+q6VpTM1DgYonieKZQZyBFwrUjINV8qEbtqVzXf8PWmbYXagl1LTRmnjr
 Sfl7OkvFNq4eWpWlHfOV0KedPGWFU0kW4PdLQ7OagM22W1vbM+WkloX4IC7+hdhINuRAKRcz15v
 WrA7W02I4kdtTDoZ0jEsehXThIjiiCa9LJBX7bURwIwgSYJeYZlAnC7tUdfgYQoNOhAgi+n5n2a
 QpkGDYLy/86uKqsR09NzG3JIvydMFLPl0H0B4tDLD9gphcB49e/wjQSKKc9Java5bvglDwC8XXk
 JDFnaEtxMVjJgeO78CGHwcA8uOR6BuqPYYiDOzA=
X-Received: by 2002:a05:600d:13:b0:46e:41e6:28c7 with SMTP id
 5b1f17b1804b1-46e714acf6amr68095535e9.8.1759756359393; 
 Mon, 06 Oct 2025 06:12:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2qtW3lG+TMWoe50L45Fy1tpw8PbsSTr5Yr+/xRjZfuwDK3WBPkcZEhGMwJ1550s57H0s02w==
X-Received: by 2002:a05:600d:13:b0:46e:41e6:28c7 with SMTP id
 5b1f17b1804b1-46e714acf6amr68095195e9.8.1759756358900; 
 Mon, 06 Oct 2025 06:12:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9719sm21219952f8f.31.2025.10.06.06.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 06:12:38 -0700 (PDT)
Date: Mon, 6 Oct 2025 09:12:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-arm@nongnu.org,
 Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 06/25] hw: Remove unnecessary 'system/ram_addr.h' header
Message-ID: <20251006091227-mutt-send-email-mst@kernel.org>
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001082127.65741-7-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Oct 01, 2025 at 10:21:06AM +0200, Philippe Mathieu-Daudé wrote:
> None of these files require definition exposed by "system/ram_addr.h",
> remove its inclusion.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/ppc/spapr.c                    | 1 -
>  hw/ppc/spapr_caps.c               | 1 -
>  hw/ppc/spapr_pci.c                | 1 -
>  hw/remote/memory.c                | 1 -
>  hw/remote/proxy-memory-listener.c | 1 -
>  hw/s390x/s390-virtio-ccw.c        | 1 -
>  hw/vfio/spapr.c                   | 1 -
>  hw/virtio/virtio-mem.c            | 1 -
>  8 files changed, 8 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index eb22333404d..15d09ef9618 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -77,7 +77,6 @@
>  #include "hw/virtio/virtio-scsi.h"
>  #include "hw/virtio/vhost-scsi-common.h"
>  
> -#include "system/ram_addr.h"
>  #include "system/confidential-guest-support.h"
>  #include "hw/usb.h"
>  #include "qemu/config-file.h"
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index f2f5722d8ad..0f94c192fd4 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -27,7 +27,6 @@
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "system/hw_accel.h"
> -#include "system/ram_addr.h"
>  #include "target/ppc/cpu.h"
>  #include "target/ppc/mmu-hash64.h"
>  #include "cpu-models.h"
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 1ac1185825e..f9095552e86 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -34,7 +34,6 @@
>  #include "hw/pci/pci_host.h"
>  #include "hw/ppc/spapr.h"
>  #include "hw/pci-host/spapr.h"
> -#include "system/ram_addr.h"
>  #include <libfdt.h>
>  #include "trace.h"
>  #include "qemu/error-report.h"
> diff --git a/hw/remote/memory.c b/hw/remote/memory.c
> index 00193a552fa..8195aa5fb83 100644
> --- a/hw/remote/memory.c
> +++ b/hw/remote/memory.c
> @@ -11,7 +11,6 @@
>  #include "qemu/osdep.h"
>  
>  #include "hw/remote/memory.h"
> -#include "system/ram_addr.h"
>  #include "qapi/error.h"
>  
>  static void remote_sysmem_reset(void)
> diff --git a/hw/remote/proxy-memory-listener.c b/hw/remote/proxy-memory-listener.c
> index 30ac74961dd..e1a52d24f0b 100644
> --- a/hw/remote/proxy-memory-listener.c
> +++ b/hw/remote/proxy-memory-listener.c
> @@ -12,7 +12,6 @@
>  #include "qemu/range.h"
>  #include "system/memory.h"
>  #include "exec/cpu-common.h"
> -#include "system/ram_addr.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "hw/remote/mpqemu-link.h"
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index d0c6e80cb05..ad2c48188a8 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -13,7 +13,6 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> -#include "system/ram_addr.h"
>  #include "system/confidential-guest-support.h"
>  #include "hw/boards.h"
>  #include "hw/s390x/sclp.h"
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 8d9d68da4ec..0f23681a3f9 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -17,7 +17,6 @@
>  
>  #include "hw/vfio/vfio-container-legacy.h"
>  #include "hw/hw.h"
> -#include "system/ram_addr.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "trace.h"
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 1de2d3de521..15ba6799f22 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -25,7 +25,6 @@
>  #include "hw/virtio/virtio-mem.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> -#include "system/ram_addr.h"
>  #include "migration/misc.h"
>  #include "hw/boards.h"
>  #include "hw/qdev-properties.h"
> -- 
> 2.51.0


