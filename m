Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DD5C87FDA
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhg5-0004tW-T4; Wed, 06 Aug 2025 13:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujgzm-0003iJ-21
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujgzj-0007y3-B8
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754497680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KFXOuBsDsPbVG5C0H8Yx4j1xu12N1AGTweJIHr/znHw=;
 b=N65bb4s4/2z6FkBvwCHlfUPk9Xa928dI48rk+Rz4dBD+bV5fR0TFv7KxPifnEJc7B6fqNn
 79e4ZFC0CUWxZKlGGmtZ+P0P2LhohGnxl6ASDnCAT58Z+tbTRn+iiM5sSYXF//FQPB8Sgk
 yVfh2gZqOR5SVZkEL7lUdJiiiqgmMYA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-TKCUkcTwNuy3ovs7MK7Bqg-1; Wed, 06 Aug 2025 12:27:58 -0400
X-MC-Unique: TKCUkcTwNuy3ovs7MK7Bqg-1
X-Mimecast-MFC-AGG-ID: TKCUkcTwNuy3ovs7MK7Bqg_1754497678
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-71b6cb9eba5so93810477b3.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 09:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754497678; x=1755102478;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFXOuBsDsPbVG5C0H8Yx4j1xu12N1AGTweJIHr/znHw=;
 b=rrGpf8rKR9XmfIdi6TNHjygkLcQlOZMnY7xtZfCAqfb/O0h4YV7+2j1UevU/ThLQZF
 eDGHJWcBDnp5hLdufIzM5CyX+kGkeSlwaIWrdNJ9n7IPeu264Zf8B3f0QSFP4AmF6Ny8
 jJXTo5VJhW7P/gAK1X+JI9bXeCN9F48OPyqLuK4Jc+Bv5nshJvRS0n9hdl4HAHAA5sbL
 YNn+/Vh9EfOI/+JYiQpkRQFbTPWLomKfynUnz7uyJu0Owpatti31K/kqyXcYAJ0cLwHr
 DygKgby28hzbHUFLaO5it0QbVqoWygOU+8DVMKLBl0P43SbdiZti8kfwCu/KWtJivZKv
 zOmA==
X-Gm-Message-State: AOJu0YyYDtKv2xTlQjOSZ/yIi/vhaBF0xndk2fNy4YkG+IHVaBNB46W1
 jdIeE/CRTrdZkLjF34wIkYsHAm4sBjHx+KOMLQxxssgkf9uE3ZA1a2eVaLdjYdmTVoF6kbZgb6v
 yrsON44w9yUHrgeuIp9A5mGy6+YQKV6CnAsc0keVJzB3Cj++vyMjas78j
X-Gm-Gg: ASbGncs4u9mdKnpNPq1sIw2YWWYTnWzwbUPcVWcL/VsnJAiiZDlTRcc5gkMSaZKypnQ
 9b3VkjN0jX7j1QH+La2ugoanA+s73Z+xAoxH6kyrvl17Lwqj0JCV3E2Qvl/hNk9Pr28HiGG7vNO
 O23upATN26WhwsEbJ6+3OXlNInDmirbznRDI/iGEEp/Gq+vUQINV9Po5GozmfELEGGdstJggyea
 tGj4I88PjABTxSIklh1OH0ybyi5REzfHogUaGxtbHq972W7zzQOyclatq+jSZS40izE2kc/tggl
 /miIo1toKfWuDvn9yf9vqSvHZ6496JweJNgmVT/32DVe49I+uXusmqL79IVeuq3XNtjcN9MPGKv
 7UJnNcupc1ciQTzluN0DfxA==
X-Received: by 2002:a0d:e706:0:b0:71b:d028:b925 with SMTP id
 00721157ae682-71bd028bba9mr25116167b3.18.1754497678101; 
 Wed, 06 Aug 2025 09:27:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWguJbQvYH6UlCp8xDrhbenv3zCB3dNsZBZXeVrLZShu3ZLumxjOmIhneYfYZR5dwTUJ3CTw==
X-Received: by 2002:a0d:e706:0:b0:71b:d028:b925 with SMTP id
 00721157ae682-71bd028bba9mr25115877b3.18.1754497677719; 
 Wed, 06 Aug 2025 09:27:57 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a5f9d3esm40085817b3.83.2025.08.06.09.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 09:27:57 -0700 (PDT)
Date: Wed, 6 Aug 2025 12:27:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
Message-ID: <aJOCiUPp0dckmgAn@x1.local>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722124127.2497406-6-jonah.palmer@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Jul 22, 2025 at 12:41:26PM +0000, Jonah Palmer wrote:
> Iterative live migration for virtio-net sends an initial
> VMStateDescription while the source is still active. Because data
> continues to flow for virtio-net, the guest's avail index continues to
> increment after last_avail_idx had already been sent. This causes the
> destination to often see something like this from virtio_error():
> 
> VQ 0 size 0x100 Guest index 0x0 inconsistent with Host index 0xc: delta 0xfff4

This is pretty much understanable, as vmstate_save() / vmstate_load() are,
IMHO, not designed to be used while VM is running.

To me, it's still illegal (per previous patch) to use vmstate_save_state()
while VM is running, in a save_setup() phase.

Some very high level questions from migration POV:

- Have we figured out why the downtime can be shrinked just by sending the
  vmstate twice?

  If we suspect it's memory got preheated, have we tried other ways to
  simply heat the memory up on dest side?  For example, some form of
  mlock[all]()?  IMHO it's pretty important we figure out the root of why
  such optimization came from.

  I do remember we have downtime issue with number of max_vqueues that may
  cause post_load() to be slow, I wonder there're other ways to improve it
  instead of vmstate_save(), especially in setup phase.

- Normally devices need iterative phase because:

  (a) the device may contain huge amount of data to transfer

      E.g. RAM and VFIO are good examples and fall into this category.

  (b) the device states are "iterable" from concept

      RAM is definitely true.  VFIO somehow mimiced that even though it was
      a streamed binary protocol..

  What's the answer for virtio-net here?  How large is the device state?
  Is this relevant to vDPA and real hardware (so virtio-net can look
  similar to VFIO at some point)?

Thanks,

-- 
Peter Xu


