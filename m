Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C1BD47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghnd-0005QL-NO; Fri, 16 Jan 2026 06:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vghnP-0005Hv-WA
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:15:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vghnN-00052c-Ly
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768562111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uBFcIcrgb2MjkGS3VK1hgFnObDBwyhac/qUF9dw1XGY=;
 b=QUaX0PdwDw1/zi1vG9ooZwG4tdRyFlkcS4OiQFSjc8kNfMLQP5eTH57fmVn4bH5buJXwti
 /9PnIyv61pBXaR5ScYYO+EHuzmeQrd+O+Geu4g/v63nIZkmTsvaf9CnsKURPjWu6skXsk/
 2lTUpk8qO2pyrBh37tmsaoyrOiXGmfE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-JgPj9ksMMaKBZt_XHXlg4A-1; Fri, 16 Jan 2026 06:15:10 -0500
X-MC-Unique: JgPj9ksMMaKBZt_XHXlg4A-1
X-Mimecast-MFC-AGG-ID: JgPj9ksMMaKBZt_XHXlg4A_1768562110
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c52f89b415so486767785a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768562110; x=1769166910; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uBFcIcrgb2MjkGS3VK1hgFnObDBwyhac/qUF9dw1XGY=;
 b=pIT1bDWzVp1Y5FMkd+UdtAp/uORQvX7SAZ/NjRA4omHm/RRPGVnIyQQg07rExfbSNA
 jwkdYXZA2BS0s0+4UwxqK8x3ZFHi3JtP5xd8F6AzZGha9Ho3D8XeWqdNMIjaknk4Hape
 apkWbcNaQKt4j1BW/Z8vE+dUTH+T01LGD8NjcjyfJPTWkJgRxHVYXZ2BLE4Roi/N+UHu
 7q0sEC8i/0OtlHSkwaXJk8t8Rd/hqBUELPj6lcdHWcSUKxl4CUgjWC+zQggAyDlmIlET
 vYZHz64KCjn/Hgn6UI2ksGJ1GhaqmkFwfpW+4l7Rng890ZKUCf0O0cJ/GBS1F5OebInq
 WigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562110; x=1769166910;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uBFcIcrgb2MjkGS3VK1hgFnObDBwyhac/qUF9dw1XGY=;
 b=f3DxahuR2I2juAC3sZh3IPPYK+Cpls/p9WP90y5xKhesB7wn//l/Ljv0hT5y3SAgh4
 A55ofiz0Km1CuzOTI5XzQBqhLtDeIQ71jNp9Ew1QdzeknEEYFFRKWzDZt6uuY71RHFPu
 IZptv7qw3AdL6U6Fuk2X5/7D71fsEHx3L8/MIHbIZmEavanVKej455opTUeyVeU66vJy
 IKjPqAMmixieIrJgzoGwSjWLdJ61YAKfndVmC50dQejx0WEWHWn+GA8PC3vvM4j9ZcLm
 uOa1ACJL2hK2eping8ftlp9nrLaeaP/Nm7Ec5c67Sqv6luWuxrV9I9ytKNyUtbqJWhgp
 jaOg==
X-Gm-Message-State: AOJu0YzUd7nMEoCpXygWKFEL8w2gJ+NJqmGO8E4Y4VSy3STjimT90Pak
 U6KPY6/0Dv3fdAtSiGLY83LoHVDcOfxEuzbOnr1aSZ6d7yXOvs3baZ772aY2qhRWLTNOtOCydRA
 XJ1ehd256jY0/VXtcHpkvPxtt7aKuDMdp7jvViRzqL1+uWBO+4Gzr+P31
X-Gm-Gg: AY/fxX4pDZnApNrSj4guByf5qy6ylBXrTmZtjFUQrQxqRvnu+4AyHu67kEUZGqi1nW2
 gvQiDw2b5CZLyY0u3328/CM//EKHWEAdCGHUJLy+arVODVSB6chXIkkDVGJ26l/i2shpq96PWsz
 TgVwryCXTicEvORml3XKyRfKKFUJTCh+87toXqKY5oWYfsqgOA2CeiHRZlxh6SOhXR5CbX55GXZ
 UhaiDBfMCmz0DW6GKbUoi9qoaSoD46a91ddrMkXgQE3ec5gD/0WIIE+0c5i1YLLkBgPT+KbWg63
 qS1loo9160iY6E8CQJPUBPLXOV74ez9+Pmzp96Rjd6+s8FlysMCu/20Az08Y0xkzs6C//3jWln3
 e1T/Pj1g863mp0BajsaQiTSOVgFT2Qg==
X-Received: by 2002:a05:620a:6c0d:b0:8c6:a06c:f2d3 with SMTP id
 af79cd13be357-8c6a66da8c1mr351768585a.8.1768562109958; 
 Fri, 16 Jan 2026 03:15:09 -0800 (PST)
X-Received: by 2002:a05:620a:6c0d:b0:8c6:a06c:f2d3 with SMTP id
 af79cd13be357-8c6a66da8c1mr351763685a.8.1768562109410; 
 Fri, 16 Jan 2026 03:15:09 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a72986bdsm201223285a.55.2026.01.16.03.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 03:15:08 -0800 (PST)
Date: Fri, 16 Jan 2026 06:15:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, dbassey@redhat.com,
 manos.pitsidianakis@linaro.org, slp@redhat.com, stefanha@redhat.com,
 Fabiano Rosas <farosas@suse.de>, jasowang@redhat.com,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com, hi@alyssa.is,
 stevensd@chromium.org, Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v11 5/7] vhost_user.rst: Add GET_SHMEM_CONFIG message
Message-ID: <20260116055716-mutt-send-email-mst@kernel.org>
References: <20251111091058.879669-1-aesteve@redhat.com>
 <20251111091058.879669-6-aesteve@redhat.com>
 <CADSE00+24EjXdRMDXXf7tgWLaH2gqeDhL_OeRbmZQ2e8JULPXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00+24EjXdRMDXXf7tgWLaH2gqeDhL_OeRbmZQ2e8JULPXA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 16, 2026 at 11:20:25AM +0100, Albert Esteve wrote:
> On Tue, Nov 11, 2025 at 10:11 AM Albert Esteve <aesteve@redhat.com> wrote:
> >
> > Add GET_SHMEM_CONFIG vhost-user frontend
> > message to the spec documentation.
> >
> > Reviewed-by: Alyssa Ross <hi@alyssa.is>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  docs/interop/vhost-user.rst | 39 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index 6c1d66d7d3..6a1ecd7f48 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -371,6 +371,20 @@ MMAP request
> >    - 0: Pages are mapped read-only
> >    - 1: Pages are mapped read-write
> >
> > +VIRTIO Shared Memory Region configuration
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > ++-------------+---------+------------+----+--------------+
> > +| num regions | padding | mem size 0 | .. | mem size 255 |
> > ++-------------+---------+------------+----+--------------+
> > +
> > +:num regions: a 32-bit number of regions
> > +
> > +:padding: 32-bit
> > +
> > +:mem size: contains ``num regions`` 64-bit fields representing the size of each
> > +           VIRTIO Shared Memory Region
> > +
> 
> When implementing this for rust-vmm, the mem size came up a bit
> confusing. In the last patch (7/7) of this series, the implementation
> uses `num regions` as a count for the number of valid regions (thus
> accounting for gaps in the shmem region mapping). Thus, `mem size` has
> this confusing statement saying that it containers `num regions`
> fields. It should say it contains 256 fields (it is only sent once
> during initialization, so no need to save bytes here), with only `num
> regions` that are valid (i.e., greater than 0). Maybe it could even
> discard the `num regions` field, and send only the full array.
> Thoughts?

Let's discuss the exact wording here.
I'm not sure why would we need this padding sending unused fields
though. Waste no, need not?

> As much as I wanted this series merged, this deserves a clarification.
> So I can either send a new version of the series or split the last
> three patches into a different series. Hopefully it only requires one
> more version though.
> 
> 
> >  C structure
> >  -----------
> >
> > @@ -397,6 +411,7 @@ In QEMU the vhost-user message is implemented with the following struct:
> >            VhostUserShared object;
> >            VhostUserTransferDeviceState transfer_state;
> >            VhostUserMMap mmap;
> > +          VhostUserShMemConfig shmem;
> >        };
> >    } QEMU_PACKED VhostUserMsg;
> >
> > @@ -1761,6 +1776,30 @@ Front-end message types
> >    Using this function requires prior negotiation of the
> >    ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
> >
> > +``VHOST_USER_GET_SHMEM_CONFIG``
> > +  :id: 44
> > +  :equivalent ioctl: N/A
> > +  :request payload: N/A
> > +  :reply payload: ``struct VhostUserShMemConfig``
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the front-end
> > +  to gather the VIRTIO Shared Memory Region configuration. The back-end will
> > +  respond with the number of VIRTIO Shared Memory Regions it requires, and
> > +  each shared memory region size in an array. The shared memory IDs are
> > +  represented by the array index. The information returned shall comply
> > +  with the following rules:
> > +
> > +  * The shared information will remain valid and unchanged for the entire
> > +    lifetime of the connection.
> > +
> > +  * The Shared Memory Region size must be a multiple of the page size
> > +    supported by mmap(2).
> > +
> > +  * The size may be 0 if the region is unused. This can happen when the
> > +    device does not support an optional feature but does support a feature
> > +    that uses a higher shmid.
> > +
> >  Back-end message types
> >  ----------------------
> >
> > --
> > 2.49.0
> >


