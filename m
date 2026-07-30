Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D2CC54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpMwm-0000Aj-Im; Thu, 30 Jul 2026 05:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpMwl-0000A4-6C
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 05:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpMwh-0003Us-Fq
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 05:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785403253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NZCuLmXf1UjT2mns75nu3L1DB4/5yaS4QF/NEPsjTF8=;
 b=Cu5ucf766qM5GjifL5uHj9wr14PsgD5b35P2vDDFopU8Q8U8zA+XpINFfgYbM+nmRr8H+g
 jVMXx3gRmhbkE6nWznYJkio8Lhz1BNsC5Pkcrw+TX7ysEHTLX033QWbl04K1OsyyxSHk3O
 NQe1yOCjT+OgXgEABWmrHJwKzvjQTjY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-6gF-Hr4mOvew-lK5VfFKMw-1; Thu, 30 Jul 2026 05:20:52 -0400
X-MC-Unique: 6gF-Hr4mOvew-lK5VfFKMw-1
X-Mimecast-MFC-AGG-ID: 6gF-Hr4mOvew-lK5VfFKMw_1785403251
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-496b408a5c0so10418785e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785403251; x=1786008051; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NZCuLmXf1UjT2mns75nu3L1DB4/5yaS4QF/NEPsjTF8=;
 b=Us4N5zaeeT3fxmcQmPlkvlttMOisGGwxcEjaKob6pdsA8FLkz1BTViFF87TB2lodXi
 fyf/uIuJ6zdNhry5OHW94JkYDRlmQ4txWik7neqbA+YY5DEGDbr6eyDqGB8OqlC+E25A
 pJ6C3lctPMACDg+L5d3oQ17XSjV4UlKlWTl71NGE8BsFYvqc2UlkpAslkih05FxLttfz
 NmJNG9TF2iKVD+C80gehVnmOe+C9u29D+41i/9I3u9RnxN9KMN+Txv+IMwncX8y2U30u
 4yeGf7qehk4ZQMMBqVBxCyN7PQ3vK6SI4G9gymuaOycPiaFbW1id9ydMbhd/SQnTv4sa
 sEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785403251; x=1786008051;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NZCuLmXf1UjT2mns75nu3L1DB4/5yaS4QF/NEPsjTF8=;
 b=PGajiAa+kdRpgJS/ePep24jNaPb5VKXRh82n4mQeeluXCCkfuQdmWGgiWfzOinWC0g
 eg9cdekDxZQH4SGPG9f7v04P602okCeaLCIlqLoqOU9yMvjr/QQBtOuuY2fJKe6yOT6X
 LtFHycVPX+eYSr9et9t3IRep3TbPW9SGwDXg6ixkqp+oulSdYQqMn9UQIu7et+WbGEsj
 CJKOmBRgd0ga8g4c5l0/J1HNT+ljabyfYV2TE9hYFVndpDBr/00L+w5nmCKwGlBUzj+w
 Z9rzv1seFvW6ZHgD/iXbN5MLf+D5IylEEMk2Sw3cK0F7SW9d2JtIPpo3aLYsiGhtwl0V
 o/BA==
X-Gm-Message-State: AOJu0Ywv5rL2ZDhjg11zz4LoKp3UR4IbVcAfjKw28ZA3ZHY1wMmNQj2l
 indlZ9HwjcuflGWnsst1uBYXQ2NOgbAPqDMHjdyFrUep1Hc28PrDBeA/eWpAqB6miaSon8XnEaN
 HoNzMfzC2tCk1QU4BBQBH2VqHLaFrqoxrT7BP9+NyYiF5ooa4lXvpknvU
X-Gm-Gg: AR+sD13zwYna++O1G9TJDsyN3EnToYctpDGsH+mPm3jm+fN1Q3qqEYA6enfPEt8jMRb
 lFmBudlCMHtWcM7dyE9I6zFlyrewOXirY1TVXOtBTs1v+OlQwGGg3ugfLled5fCHG6aIo4ZD9tD
 Usgw/kl4s6jnpSQUOLxdHhphMYaSjovM56wnW7L8m0BmbJ2QJUhk6JFtaaf6ZKRgH4BWNJGqGtZ
 1wWbtS6l3NafclYyOKV4uXXN/8eYyJz2ddt77vzXYFzyLMPh+jP3nkpypzMEvKTOos6W4USHBgc
 0RVxlWb7upvVLiiwWB1q88biDc/hwIPdHQu+o57VSMy6GUqSTIOKJK3mkx561b5GG4BrUaNjqyh
 lm89iIym2rzgUeiTN9roLx9U=
X-Received: by 2002:a05:600c:1989:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-49800e6d3ecmr22462975e9.7.1785403250853; 
 Thu, 30 Jul 2026 02:20:50 -0700 (PDT)
X-Received: by 2002:a05:600c:1989:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-49800e6d3ecmr22462495e9.7.1785403250224; 
 Thu, 30 Jul 2026 02:20:50 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc8941717sm4672761f8f.34.2026.07.30.02.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 02:20:49 -0700 (PDT)
Date: Thu, 30 Jul 2026 05:20:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 0/7] Harden virtio migration load paths against
 crafted streams
Message-ID: <20260730052027-mutt-send-email-mst@kernel.org>
References: <20260729231904.775331-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729231904.775331-1-lvivier@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 30, 2026 at 01:18:57AM +0200, Laurent Vivier wrote:
> A crafted migration stream can crash the destination QEMU process
> through unvalidated fields in the virtio device state: an unbounded
> allocation in virtio-serial, reachable assertions in the shared
> virtqueue element deserializer, assert()/exit(1) calls in
> virtio-scsi and spapr-vscsi request loading, and missing error
> propagation through the SCSI and virtio device load paths.
> 
> These are hardening fixes: the destination QEMU is in a paused
> pre-start state and the source VM is unaffected by a failed migration.
> 
> Patch 1 adds an Error** parameter to the virtio and SCSI load_request
> callbacks, allowing proper error propagation instead of error_report()
> or silent failures. This provides the infrastructure for the remaining
> patches.
> 
> Patch 2 validates the virtio-serial nr_active_ports count against the
> configured maximum before allocating the post-load array.
> 
> Patches 3 and 5 are from Michael S. Tsirkin, modified to use the new
> Error** parameter:
> 
> Patch 3 makes virtqueue_map() return bool instead of calling exit(1)
> on mapping failures, and propagates errors through
> qemu_get_virtqueue_element() to virtio-blk, virtio-serial, and
> virtio-scsi.
> 
> Patch 4 replaces the assertions in qemu_get_virtqueue_element() with
> a bounds check returning NULL on invalid in_num/out_num counts.
> 
> Patch 5 replaces the assertion in mptsas_load_request() with proper
> error handling.
> 
> Patch 6 replaces the remaining assert() and exit(1) calls in
> virtio_scsi_load_request() with proper error returns.
> 
> Patch 7 replaces the assert() calls in vscsi_load_request() with
> proper error returns and propagation.


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> v2:
> - New patch 1 to add Error** parameter to load_request callbacks
> - Patches 2, 4, 6, 7: add error_setg() calls with descriptive messages
> - New patches 3 and 5 from Michael S. Tsirkin (modified to use errp)
> - Patch 4: remove caller updates (now handled by patch 3)
> - New patch 7: harden spapr_vscsi load_request
> 
> Tested with migration round-trips for virtio-serial (0 to 511 ports),
> virtio-blk (1-2 disks), virtio-scsi (1-2 disks), mptsas1068
> (with and without scsi-hd), and spapr-vscsi, plus the original PoC
> reproducers for issues #3801, #3802, and #3888. ppc64 qtests pass.
> 
> Laurent Vivier (5):
>   VirtioDeviceClass: Add an Error parameter to vmstate load member
>   hw/char/virtio-serial-bus: validate nr_active_ports from migration stream
>   hw/virtio: return NULL from qemu_get_virtqueue_element() on invalid state
>   hw/scsi/virtio-scsi: harden virtio_scsi_load_request() against invalid stream
>   hw/scsi/spapr_vscsi: do not crash QEMU on migration errors
> 
> Michael S. Tsirkin (2):
>   virtio: do not crash QEMU on migration errors
>   mptsas: do not crash QEMU on migration errors
> 
>  hw/block/virtio-blk.c       | 16 ++++++--
>  hw/char/virtio-serial-bus.c | 33 ++++++++++----
>  hw/scsi/esp.c               |  2 +-
>  hw/scsi/mptsas.c            | 18 +++++---
>  hw/scsi/scsi-bus.c          | 25 +++++++++--
>  hw/scsi/scsi-disk.c         | 10 +++--
>  hw/scsi/scsi-generic.c      |  3 +-
>  hw/scsi/spapr_vscsi.c       | 18 +++++++--
>  hw/scsi/virtio-scsi.c       | 27 ++++++++++--
>  hw/usb/dev-storage.c        |  2 +-
>  hw/virtio/virtio.c          | 82 ++++++++++++++++++++++++++-----------
>  include/hw/scsi/scsi.h      |  4 +-
>  include/hw/usb/msd.h        |  2 +-
>  include/hw/virtio/virtio.h  |  4 +-
>  14 files changed, 182 insertions(+), 62 deletions(-)
> 
> Laurent Vivier (5):
>   VirtioDeviceClass: Add an Error parameter to vmstate load member
>   hw/char/virtio-serial-bus: validate nr_active_ports from migration
>     stream
>   hw/virtio: return NULL from qemu_get_virtqueue_element() on invalid
>     state
>   hw/scsi/virtio-scsi: harden virtio_scsi_load_request() against invalid
>     stream
>   hw/scsi/spapr_vscsi: do not crash QEMU on migration errors
> 
> Michael S. Tsirkin (2):
>   virtio: do not crash QEMU on migration errors
>   mptsas: do not crash QEMU on migration errors
> 
>  hw/block/virtio-blk.c       | 11 +++++--
>  hw/char/virtio-serial-bus.c | 30 +++++++++++------
>  hw/scsi/esp.c               |  2 +-
>  hw/scsi/mptsas.c            | 16 ++++++----
>  hw/scsi/scsi-bus.c          | 18 +++++++++--
>  hw/scsi/scsi-disk.c         |  7 ++--
>  hw/scsi/scsi-generic.c      |  3 +-
>  hw/scsi/spapr_vscsi.c       | 25 +++++++++++----
>  hw/scsi/virtio-scsi.c       | 28 ++++++++++++----
>  hw/usb/dev-storage.c        |  2 +-
>  hw/virtio/virtio.c          | 64 ++++++++++++++++++++++++-------------
>  include/hw/scsi/scsi.h      |  4 +--
>  include/hw/usb/msd.h        |  2 +-
>  include/hw/virtio/virtio.h  |  4 +--
>  14 files changed, 150 insertions(+), 66 deletions(-)
> 
> -- 
> 2.54.0


