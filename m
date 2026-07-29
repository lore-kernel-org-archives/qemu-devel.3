Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAB0C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0fk-0008CU-1V; Wed, 29 Jul 2026 05:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp0fj-0008CL-1w
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp0fh-0007yS-IE
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785317632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8g4DexJtR4YjAKHqeHRSG0L8dG+hA5n6I5AxcdMrLlc=;
 b=JeLD5AOZ1L7XCtJXCI/wXDOF4Jap1XOBXzNhTC72nZf03ZppDSXw+RN6Xy4OfW9U5i/GmL
 2SN+X0aNobFZA4IwBhLYjGO8fmZ85OWr/mCv/Uiq6viZFGuEo/n4xcaJIzq2ZY1YrlA58+
 XgIBV8ST0sYyyhWwxrzhTHxPiVICr2Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-2xSoBJsCP0iz_9mdqmf4FA-1; Wed, 29 Jul 2026 05:33:51 -0400
X-MC-Unique: 2xSoBJsCP0iz_9mdqmf4FA-1
X-Mimecast-MFC-AGG-ID: 2xSoBJsCP0iz_9mdqmf4FA_1785317630
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955b84e25eso5124425e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 02:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785317630; x=1785922430; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8g4DexJtR4YjAKHqeHRSG0L8dG+hA5n6I5AxcdMrLlc=;
 b=r5FQkLf3UVyECTIGUTWxv+t/3JJM4kY/FeFxSIf4ZRC3Me0PyUZe9oUaA8Wew/TT4y
 GRAPWcOwNYi/NwSZh6cWIGPHZHdaUMBRP0SWmNhlx7NSsPJsPo0VfplhpsYVKHBGd+hn
 HGCcNxx0utGygte/TJuqr0YtTj1+AfizHZfIEz1BrbNgAsXkDHd+++YD91XuexPoMAZN
 /WpLv9tYUQDsF7hvwxjJ4nI0MG3AFUxGf9qxZ4IBj5chxPaVPQ7Q/aBBtK7V9snra9gR
 XbLFvo6lQqbWmhEVoEcYxGj0cQOPG7YlxnSI3DqNRL7/Y9ddIcHpOZ+xb7VuCyktmt2o
 WSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785317630; x=1785922430;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8g4DexJtR4YjAKHqeHRSG0L8dG+hA5n6I5AxcdMrLlc=;
 b=dMXL+/LNKp2FZjlp6rqVZTfLb0xVVinD17KX5tYDpGZ5vdCCsmK1iun4KCd7fXg875
 69USdUjDdGF9HGKRubwHxKlS7upbv7m2PZvvHaVyNH5QF9frSTh1JFCp960JeznE6WLt
 FBn/9z1Ep9B6czEriTP/las2+TES7pH1+6QX7V3pblGIqo5G2Hb8dOU7KayMKbrIttce
 X844i7++fYVwfxGhHDi12Z4TSXXPNWF8WTZUm/8qGiGZZlyqkQjIr8Z5jLWLX1JNeF57
 6UtD1GPt8eE/lPH1nHmZgJ9K44rUqwR9lHPOUHpytmnRdf/kywxyVnipOnhn6HUJJj3l
 AN2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqL11XzqPfqIPC+tcQ3yj7JzrjwXUzmcBHQ8iyzaH0fdZ33HpNConuQJ8wJQuF4Dtg6218ccT5pfhjG@nongnu.org
X-Gm-Message-State: AOJu0YzAz4pims9bCbzPOQPO08PkWbTgq5JqeiH209RMjhqtSrve2N2m
 mvmUBWzOtBMJfRmm9Fsp80EB74AvIsT6zvr5YnrHYFMEGcpK1rxT28EkvlxMW6j2bvSYWDNdOvX
 z20K5X6FEarBHDF0tatUiD03D1hCYvYuIU/5tN+H388Npi+m/wq9dIjkh
X-Gm-Gg: AR+sD11hvkbTcCWzDffpQNWgxD64nMhzd99Calk2Sudj0LebUw0UbUzi/PlXNE66KQR
 UJrsOZDL7F767MBm4muOO824RTx95UyP1WzNqHk+PI0Qp1MvJliKkaztQpOycg3KQfZ1eub4tGj
 QHe9kN4/i67dtm+4iBQf0l82xzA9anP31JLx+bszgjp7MvBgYXO+HlI3EVfQBSzZp4kSx+vO76J
 NsuopZt7irBtv7oQyZDv/r2qrE0/HSswsfua2tjY23//IDzYUHhZQ2Rlm6TqVaWF8bf3FRX2LLA
 Jh9detkheN0CmdweJa+FZR/G461GnfIFz8D5exokdZilQ7FsjEKmW9FpNrwVMm59viGzc2G5V17
 PupfQyL3PyD45Z5FPp4eDsKk=
X-Received: by 2002:a05:600c:4e02:b0:495:3fe1:4ce4 with SMTP id
 5b1f17b1804b1-496c65979dcmr61715635e9.26.1785317630051; 
 Wed, 29 Jul 2026 02:33:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4e02:b0:495:3fe1:4ce4 with SMTP id
 5b1f17b1804b1-496c65979dcmr61715205e9.26.1785317629524; 
 Wed, 29 Jul 2026 02:33:49 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d777afsm52741275e9.4.2026.07.29.02.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 02:33:48 -0700 (PDT)
Date: Wed, 29 Jul 2026 05:33:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>
Subject: Re: [PATCH 0/3] Harden virtio migration load paths against crafted
 streams
Message-ID: <20260729053331-mutt-send-email-mst@kernel.org>
References: <20260710102859.1967551-1-lvivier@redhat.com>
 <20260725113324-mutt-send-email-mst@kernel.org>
 <amjEALq8-unXNAZS@redhat.com>
 <6a3b587a-09de-4d63-9aba-403a9af97b63@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a3b587a-09de-4d63-9aba-403a9af97b63@redhat.com>
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

On Wed, Jul 29, 2026 at 10:56:56AM +0200, Laurent Vivier wrote:
> On 7/28/26 17:00, Kevin Wolf wrote:
> > Am 25.07.2026 um 17:34 hat Michael S. Tsirkin geschrieben:
> > > On Fri, Jul 10, 2026 at 12:28:56PM +0200, Laurent Vivier wrote:
> > > > A crafted migration stream can crash the destination QEMU process
> > > > through unvalidated fields in the virtio device state: an unbounded
> > > > allocation in virtio-serial, reachable assertions in the shared
> > > > virtqueue element deserializer, and assert()/exit(1) calls in
> > > > virtio-scsi request loading.
> > > > 
> > > > These are hardening fixes: the destination QEMU is in a paused
> > > > pre-start state and the source VM is unaffected by a failed migration.
> > > > 
> > > > Patch 1 validates the virtio-serial nr_active_ports count against the
> > > > configured maximum before allocating the post-load array.
> > > > 
> > > > Patch 2 replaces the assertions in qemu_get_virtqueue_element() with
> > > > a bounds check returning NULL, and updates all callers (virtio-serial,
> > > > virtio-blk, virtio-scsi, scsi-bus) to handle the failure gracefully.
> > > > 
> > > > Patch 3 replaces the remaining assert() and exit(1) calls in
> > > > virtio_scsi_load_request() with proper error returns.
> > > > 
> > > > Tested with migration round-trips for virtio-serial (0 to 511 ports),
> > > > virtio-blk (1-2 disks), and virtio-scsi (1-2 disks), plus the
> > > > original PoC reproducers for issues #3801 and #3802.
> > > > 
> > > > Laurent Vivier (3):
> > > >    hw/char/virtio-serial-bus: validate nr_active_ports from migration
> > > >      stream
> > > >    hw/virtio: return NULL from qemu_get_virtqueue_element() on invalid
> > > >      state
> > > >    hw/scsi/virtio-scsi: harden virtio_scsi_load_request() against invalid
> > > >      stream
> > > 
> > > Kevin objected to my version of this, I guess same will apply?
> > 
> > Objecting is a big word. I suggested some improvements around passing
> > errors to the caller instead of trying to handle everything locally. But
> > yes, at the first sight I think they would apply here, too.
> 
> Michael,
> 
> will you rework your series or do you prefer I update mine?
> 
> Thanks,
> Laurent

Pls go ahead, thanks a lot!


