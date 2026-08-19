Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736D1C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 07:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwbAO-0001Wo-Pd; Wed, 19 Aug 2026 03:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wwbAN-0001Wg-CT
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 03:56:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wwbAL-00040G-Ud
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 03:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787126211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+nmUItYjxHrKSDwMYx9A/typy/hWxTGWH+8O5qMU8nI=;
 b=gAm/bKnxwjaS+8QQzPioZ11VqRs0rhFM6hBKV5fsFcb9uWCqc8N41Jf+Uw4PeWv/2S60Z7
 5hX4fbjpUrwFg+siGIfgbhMOZ8q9Q5mm+TXEss+zIldHorNW0dKARHRQebhp4YzS0N7n8y
 FGOcZI5TU3WST0YY9C8N6z3CVoENvjU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-rwUZML8fNpqZstCl0wycjQ-1; Wed, 19 Aug 2026 03:56:50 -0400
X-MC-Unique: rwUZML8fNpqZstCl0wycjQ-1
X-Mimecast-MFC-AGG-ID: rwUZML8fNpqZstCl0wycjQ_1787126209
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4994cf6cdb9so4604375e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787126209; x=1787731009; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+nmUItYjxHrKSDwMYx9A/typy/hWxTGWH+8O5qMU8nI=;
 b=qd7QhPUiehPJTLigNUGH/+VF7dpb4ACuy36xHFsbr+PIcwdgrmcCPdSgeeMIPR88jB
 q3Q2j7eljktoSup50AlRGVbxF/3SK4vTZ/osT8H4wOdOTmw0PW4ScO3XWKslrFNDAQHB
 P+b92OwY5gloPk+O43xagi4s8u0d6i41W662c3LyPDRE3+W8p3freGnzj7xICJgNFyXp
 3UURi40eqa4wi7RzsOLiUeZyvNFIp5b95S5JTVuVlTanKX8sSZP4J4yD3MStTFWAkF3F
 jmb0LBAGQrlDW/WuQPfs1NiBcXNZ6RCh6MAtNJ5yxUI0iT7vzyzvwGKxhtibAi5+41e/
 GrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787126209; x=1787731009;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+nmUItYjxHrKSDwMYx9A/typy/hWxTGWH+8O5qMU8nI=;
 b=jTCcCg5YrXh/bT3RX4yPezLR9EAFmYvt3RD04m4YuJ6yjWC23VP8hPpvETanxfL5P5
 KrGapBP3UYWyRciV4fL0W7c5oj+I3Q/fxXfpLHffHyRbyXT5m8PCIiPaQAfse/wkt1JV
 2AsF9K5lw37ENevfbupAQqDAFpZjo0xTF7TwIaQO1yE7Una9EmkabQJ0p6n2UjrBLR4w
 EoEadt6htIgiBCRPdfrtmSUxd7SHr78OlgnoHCtksxi52BU6pKh1m1M2FtIlziAkGgBS
 JtShpZkw0XV8OSKNpEOPctaq9udRlu7RcnBW3npwDrQXhUp5g3yU/xdT4qhGjU4NdnCn
 Ok8g==
X-Gm-Message-State: AOJu0YxaK8wNWitJC/2T/rcTRXq7szo0tS84yosR/eDsnvIptXUa9UWr
 4wJE3oH/iu0Hgz/BF9lJEVxZUyv5tAxk5XoFtTeCZaprlMEnLBqxsKMXgjt2GxcC7YrLxf8mABc
 K1caic4aPu5H2FZjjvIDRyuZHtqa5IGvWBmjN+4AnOKG5QgZiwPUJJfov
X-Gm-Gg: AR+sD12M1CEifQ9oCWu2Ao/dbsuTBZbdrvoP6CicblH8bglZPl8eROpx/MqPHlyewpw
 nJkNaAbntol3BSUyr9jbzgiMasRngal0fOag6aNM92w+fB0QvIgsD/+GEC83l4JDGkERwgv/Wjg
 5ksySxfrpV4lWL+Kd9aHDPnyLbCXpufUJGHDICHr3q3tCqZylUfmqGT9iqjX9iWBZCJMe8RE3I8
 GSgjGZ9jtHp+k2LS/NB7jQc+bLWcHZLkezpMpLYRAcb4lrnlqIjrH0Yn/2aOWSmgyWmC1r0r0Tx
 Z8TJywZd96vXw32+B/Q6llOIL46jDMD5pMkRFr5uA9bWEn39zqyjm2M/0lSa3gDa9UXK3ban/N4
 pYMOI0yscZf4XEWlokSaXQp6R0c3s/f5ZWnjgD7Gq6D783K0W8I93
X-Received: by 2002:a05:600c:5294:b0:492:4e09:9fc1 with SMTP id
 5b1f17b1804b1-499aa1f5413mr47873945e9.15.1787126208796; 
 Wed, 19 Aug 2026 00:56:48 -0700 (PDT)
X-Received: by 2002:a05:600c:5294:b0:492:4e09:9fc1 with SMTP id
 5b1f17b1804b1-499aa1f5413mr47873415e9.15.1787126208402; 
 Wed, 19 Aug 2026 00:56:48 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it.
 [82.53.135.154]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499ab2a8b34sm45080405e9.8.2026.08.19.00.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 00:56:47 -0700 (PDT)
Date: Wed, 19 Aug 2026 09:56:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Feifan Qian <bea1e@proton.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3] vhost-user: Reject SHMEM_MAP when no KVM memory slot
 is left
Message-ID: <aoVhrSPHfdtnqyRs@sgarzare-redhat>
References: <HXrBMZ9Gx9L-VxdMEr26ORPUYQn99p4rgEYVkeMHA4-5M49Ax3_mx1euIWe7uj33nl5mZ19sZeUDyksqxKT7H1WPxWhYtxdomofcVTyMTjo=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <HXrBMZ9Gx9L-VxdMEr26ORPUYQn99p4rgEYVkeMHA4-5M49Ax3_mx1euIWe7uj33nl5mZ19sZeUDyksqxKT7H1WPxWhYtxdomofcVTyMTjo=@proton.me>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

On Sat, Aug 15, 2026 at 04:13:37AM +0000, Feifan Qian wrote:
>Each SHMEM_MAP request creates a separate RAM MemoryRegion that
>consumes a KVM memory slot. Once all KVM slots are in use, processing
>another SHMEM_MAP request would make the KVM memory listener fail while
>registering the new region.
>
>Shared memory mappings are filtered out of the vhost memory table
>(vhost_section() skips TYPE_VIRTIO_SHARED_MEMORY_MAPPING regions), so
>they never count against the negotiated vhost-user slot limit; only
>the KVM slot budget applies. Reject the request with ENOSPC before
>changing the memory topology when KVM has no free slot left.
>
>Also validate each vhost memory table against the slot limit negotiated
>with the backend before sending regions via SET_MEM_TABLE or
>ADD_MEM_REG.
>
>Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request")
>Signed-off-by: Feifan Qian <bea1e@proton.me>
>---
>Based-on: <20260717134920.265128-1-dbassey@redhat.com>
>("vhost-user-gpu: Add blob resource and shared memory support" v4,
>which filters TYPE_VIRTIO_SHARED_MEMORY_MAPPING regions out of
>vhost_section())

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


