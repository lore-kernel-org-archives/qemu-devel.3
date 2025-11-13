Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087ECCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 22:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJfO9-00030U-6z; Thu, 13 Nov 2025 17:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJfFd-0001JI-9H
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:53:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJfFa-0000nH-Sw
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763070785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aeIC1KXpQ9Kyy+ArZDN6hgwLuKd2ZMwagVWxQTz88pY=;
 b=caQ1Ms8Q0uhbjolQoEyGJchxVBdYZFV1ybNLVGia63hFFg9XfBDlGa/cMryxnGDsy3sNVP
 f0K/UJmYxieD+csUZNyaqm98a8GD7TSSQVezwBzLo5DKUgAaS15q9L1dXjlW/njjCYIvfG
 UxaO4+lwl+AyQUvh7EXrTWOEQjnqOaM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-oOiP5LpzMZq9DumWAhHxJA-1; Thu, 13 Nov 2025 16:53:04 -0500
X-MC-Unique: oOiP5LpzMZq9DumWAhHxJA-1
X-Mimecast-MFC-AGG-ID: oOiP5LpzMZq9DumWAhHxJA_1763070783
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8804823b757so76291536d6.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 13:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763070783; x=1763675583; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aeIC1KXpQ9Kyy+ArZDN6hgwLuKd2ZMwagVWxQTz88pY=;
 b=cQ+RJFFEOcjW+rp04n5fZtCopsiTn+kVcT1uZXxSvVJv06s7FRf6duvRPT1lW18lyn
 GzxD1vmXi19qnYkoup83P7KL4y5C1EI1ROdKnsjkxHOB65EEmajxP6SVAYGAfx/Upc6O
 OGuj2WaVc5ZvABbzeOtwymyRTHVN3mCjGzM0l/+Upr1TfhktmAhumaAqYKFb8ocCvWr+
 krDnZmtHJqYu2PiKIfUH278YfmRIWHnD/bPTvN5ZAqykg1sfheMoDHj8V9RGfItThnKE
 2U02viVTegTI3V9al6AnFfUmpT0lKwVEIlyveT5GzmjNPDan7PxaCEPwPf8/mXuv2/Sr
 tyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763070783; x=1763675583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aeIC1KXpQ9Kyy+ArZDN6hgwLuKd2ZMwagVWxQTz88pY=;
 b=bNUdbvyXAu/0fgdOMH4cPkxGVclzs3jm9cbp5sqkeRKKyZLHP+VGvFfNBdIGLVCbPl
 6Ao4k3icYPl64QpLuIlxESkBcaLtXTjJKda1iv2wjZzik+MbPZY4N/K4qRxU/+VNJ9w9
 xYXY9985gznAxl/3V+uUZWGGDMrE1VPe6IS/4ZhRkzSgwE0rxmSHLR/H2waMtLzNIr6l
 fQvWlr7XWilXBROlYtspVtiDdQA5h2jP95MwYykoZD7Fflh+NMkRW34CPwlBdUR/JZP5
 l3u5/013ntgLg11geFSdGXpRgyH9FJLIU2lYF5r643TyBk5oPQZuN1nQbVgnImQDlc0f
 KJSQ==
X-Gm-Message-State: AOJu0YxQcAT+Ft7k2eiwax8ALTu9MhyvSf4JdpR80dL7pho65kK/8DRF
 7rnQOzu3M5KvEBGgD3vy9zuopkxhV9itBlrRyQe6Muu8tR4v2X9MOdKIpmTPvFX+b+i+2cQG30n
 cCRSzp6gx0o8Ayyub+D161YPIGTpfyTc399OHLRu8MDjxzXAciP7fUet3
X-Gm-Gg: ASbGncua8ax3Z3sbAvs5zEVX+agTCiUbcpEVbp0rA9rIjbZo0sLe/fTDXs1XWkj8So4
 0yHJIbWP1LhRTWT0X/wJkjPxrjBpHw6VekWWvJjFuVxrOtZcJ5tu9reDCf3FKPsZ8pMIR5AtVs8
 cplPsuy5d4riqp8QfxT+I+HWs8cpORTLYm+BAS5mxaAXv7GzhUM1KwGtfLEpo3eZ+KVbfz9zGXO
 pBPcbOVn2DwJY8d3Ofd4eJMA3sxRBscXt8tZsn7Z34aLkxAERdPUgEon1rY8OGHmTdk0D4U2xoW
 TRsRcAIlUwfT5nGAT8G4evMPVLjE9l2q+LPbQPuXTPLa90qf/qOFilSYd5RhYIQpXnTtixvn0qP
 nYg==
X-Received: by 2002:a05:6214:da4:b0:78e:f6cd:4704 with SMTP id
 6a1803df08f44-882817a0df6mr70182436d6.5.1763070783452; 
 Thu, 13 Nov 2025 13:53:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtQofiA24+3uVqDuPzJOjI1kJBF0bmPp+PIt/9ZZ5FF+vWlFzip+/Z/P9LwYGRl6tqlKbrdw==
X-Received: by 2002:a05:6214:da4:b0:78e:f6cd:4704 with SMTP id
 6a1803df08f44-882817a0df6mr70182106d6.5.1763070783007; 
 Thu, 13 Nov 2025 13:53:03 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-882865d1dd4sm19537156d6.58.2025.11.13.13.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 13:53:02 -0800 (PST)
Date: Thu, 13 Nov 2025 16:53:00 -0500
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 8/8] hostmem: Support in-place guest memfd to back a VM
Message-ID: <aRZTPBN9Nx2ykDWK@x1.local>
References: <20251023185913.2923322-1-peterx@redhat.com>
 <20251023185913.2923322-9-peterx@redhat.com>
 <fe713fb6-56db-4080-b03d-a0c36952ee22@intel.com>
 <aPuZuf_S-gvOf_7J@x1.local>
 <ebb35318-5c02-469a-82bd-dc278cd583e9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebb35318-5c02-469a-82bd-dc278cd583e9@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Oct 27, 2025 at 01:24:25PM +0800, Xiaoyao Li wrote:
> I was not authorized to do the QEMU upstream of gmem mmap support inside the
> company. So please keep your series and I'm happy to help review it and make
> it upstreamed.

Thank you, I'll definitely copy you for all future posts.

> 
> > > 
> > > Third, the intended usage of gmem with mmap from KVM/kernel's perspective is
> > > userspace configures the meomry slot by passing the gmem fd to @guest_memfd
> > > and @guest_memfd of struct kvm_userspace_memory_region2 instead of passing
> > > the user address returned by mmap of the fd to @userspace_addr return mmap()
> > > as this patch does. Surely the usage of this path works. But when QEMU is
> > > going to support in-place conversion of gmem, we has to pass the
> > > @guest_memfd.
> > > Well, this is no issue now and we can handle it in the future when needed.
> > 
> > Yes, that's something the private guest-memfd would need.  For completely
> > shared guest-memfd, IIUC we will use a lot of different code paths, the
> > goal is to make old APIs work not only for KVM_SET_USER_MEMORY_REGION, but
> > for all the rest modules like vhost-kernel, vhost-user, and so on.
> 
> And if pass the @guest_memfd, we will need to handle the issue of aliased:
> https://lore.kernel.org/all/aH-0MdNJbH19Mhm3@google.com/

Note that it's intentional here I reuse userspace_addr, and I have no plan
to support gmem binding with fully shared gmems yet because my current
purpose doesn't need it (I want to ultimately enable postcopy 1G, hence I
want to move away from hugetlbfs but use gmem).

Hence as discussed, my goal is to make gmem work exactly like memfd here
and exactly like before, supporting all kinds of kernel modules.  GUP must
work, hence HVA is needed.

So yes, I was aware of the issue discussed there on SMM aliasing, because I
also hit it at that time when testing against the very 1st kernel patchset
from Ackerley on supporting 1G.

That's also something I want to avoid when reusing userspace_addr rather
than using KVM_SET_USER_MEMORY_REGION2.

I plan to leave any form of kvm gmem binding support to others.  Likely
this new interface is not needed by either the old approach (where
ramblocks need to duplicate memory consumption like right now), or when
in-place conversion is ready (hence no double mem consumption issue,
however guest-memfd as fd will still be privately created).

Thanks,

-- 
Peter Xu


