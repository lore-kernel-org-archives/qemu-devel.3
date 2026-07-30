Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1E2C54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpOKq-0004ZG-No; Thu, 30 Jul 2026 06:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpOKp-0004Yr-4S
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 06:49:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpOKn-0008Hg-A3
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 06:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785408592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IB/lYIRcIinlGQE7h2YVSmXh/jIsEiUThe2fdHPl2Jw=;
 b=aUOX/ACUFTO1tCFP3xLtw+DgVFLWklvi6WBUgshWe8ux4YQmfKkbLTfHmP3bkxZNNcfr0G
 nrvVeBzk9ZarbZk69KGKKFdKO/nMiEPZj5SXN5F4jWWMzsxo0WiOGT8Dn6DXiH8r+4EMzR
 Ujz3VNU/4wl6kPRG6YwrXOd85hhxf4g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-xl5KtkbqNH6liMV7KtXczQ-1; Thu, 30 Jul 2026 06:49:51 -0400
X-MC-Unique: xl5KtkbqNH6liMV7KtXczQ-1
X-Mimecast-MFC-AGG-ID: xl5KtkbqNH6liMV7KtXczQ_1785408590
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495517d39fbso11868435e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785408590; x=1786013390; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IB/lYIRcIinlGQE7h2YVSmXh/jIsEiUThe2fdHPl2Jw=;
 b=GNCB+DnRSCuireDnCPcQ3iKCnwnmrK8JwSNDnS6cBlYZQWiGkpk3BUgxL2l65LvWec
 IL3qLBGAeWZwTdJlMCfdmlxl3sYJ1ATRBKZPYrw0qmVfksmVFdBejkVuFou2QAH+86jx
 w8NFRwUTDmgDWrECH3Tq4TuZRWDUTsZAvQAD/9wX1we8zqqPJA80NPMvF07Kf/cNKelp
 RfAyaInhzh304/YQgcBtJtpwRGU8sUwR/bbjAxM+PEq/hgkdT0l9xZNVNjD2pPSTwvww
 6o6T2z91Uti/TMKf8RunPNRW8xXO8P+WQscTg66U2XxalLnUhLdaHtBt8KNzXYIr6c9C
 wIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785408590; x=1786013390;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IB/lYIRcIinlGQE7h2YVSmXh/jIsEiUThe2fdHPl2Jw=;
 b=jcRPJpRuAcO9z6KiwIvNnjFulzfbtE6o2e0lPgpUb9u+MCt54toe2kwkcg3d6T2NlA
 7sIXydxd2rOQ2LC2C+I9YEJrpbEVBc2sOWYM2oahBPad1iYf2bVy0M6OSH2GubLdDe+t
 hxSvUfuWATNAH611ATC2IkTsCvHBbU24NKy3JzbM5y8x6ZW1BPw60HtidS5XPitS+0LG
 expSgBZLPEeD7lwInkmH3PpKgmGuy6f4X53YSzoSJTKnmOK5Sf6kWWoYEDEM4Hml8AQ6
 DR8gK4uHzd79W/E4iEqZymlFSAaee3mYGxRK438wySfqqy2ifMM6zAMFmBjX/87Zi978
 vPHw==
X-Gm-Message-State: AOJu0YwUiEcm8JAfz//knCDBlk5dPxcQFfL2QONoZzB2A6sYnhvTiNjw
 9H2q4xSCeA76Q+9/Vbo9qICUEHjv4HvH1uwQ71RUfcsTXELhRPqQ5xOd0FSGts8Sc7u52aaUUJC
 hZGPxw8K6d4INK1rnNsjtW098qn6fz6kJ5e7tdmQayfUrhQ8UA1342lfh
X-Gm-Gg: AR+sD13nDTJQkD8mQJnAINGa02X4th2pJzkDfr7PuWeSh9MOfQGuYHInmIkZwBPWJlv
 beE69U+OhqPVOynB604sOU+1WdmPm4zFy661bKLpZ9kvLQApNgc1hQaBuExpbTbnpaf14+hq4PN
 UhFf9equQxJ7rSFSbHg6LNcxpo78/jkIQpyapKg2oV4LOaCPvZiP40coXDI788mqcDkKIbVpJ6k
 gyCGU7I5/vpIjXZuNy/WYliRWwipdz+YGjs9agSD2lu/8UK/0Uq8l62tMnyt1Af1Kf1NQaS7dKU
 hoC0/6fVm8nfQ6OInU/WAb1TpHQohE8UjJgN1JchNDYG2dwXE5VWdQGWoWWmZpZd6NzeDSh16cw
 ClWOzD5XFaCD2BUzwEFyE9lI=
X-Received: by 2002:a05:600c:3104:b0:493:aab3:c09c with SMTP id
 5b1f17b1804b1-49800ead744mr27238395e9.28.1785408589929; 
 Thu, 30 Jul 2026 03:49:49 -0700 (PDT)
X-Received: by 2002:a05:600c:3104:b0:493:aab3:c09c with SMTP id
 5b1f17b1804b1-49800ead744mr27237755e9.28.1785408589420; 
 Thu, 30 Jul 2026 03:49:49 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc893fe58sm8497811f8f.31.2026.07.30.03.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 03:49:48 -0700 (PDT)
Date: Thu, 30 Jul 2026 06:49:46 -0400
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
Message-ID: <20260730064923-mutt-send-email-mst@kernel.org>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


who's merging this btw? me?

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


