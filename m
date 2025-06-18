Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150C3C7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 21:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS0nv-0002SE-Do; Wed, 18 Jun 2025 17:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uS0nt-0002Rv-4G
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 17:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uS0nq-0007qE-MA
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 17:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750283920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1GX3VR3zwwzoNvJnv6ba5Oys9yAv3Y+PfHmnkUbPaN8=;
 b=cJk2r8h+lasbidhDsTsFG3Q8dCxzqHmSkbecspA+gEztoTRl1XTU1cvpDdVS//Yduk3Sr9
 n95TwVDdc4itmfTLuBsqzaMT2X+gvp0iMrGNLnNflBbuVKE24WbNE6d54TKUyj5EzdkaOf
 cpUeunRIswNBy/zUX8a2NLPLW1LEKPk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-psjAMVhMMk2ChAW7syaizQ-1; Wed, 18 Jun 2025 17:58:37 -0400
X-MC-Unique: psjAMVhMMk2ChAW7syaizQ-1
X-Mimecast-MFC-AGG-ID: psjAMVhMMk2ChAW7syaizQ_1750283916
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-748f13ef248so88470b3a.3
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 14:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750283916; x=1750888716;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GX3VR3zwwzoNvJnv6ba5Oys9yAv3Y+PfHmnkUbPaN8=;
 b=AfsVTh6GEXiU5CwO1X1384ffiGGiFWIvXGrIWZ7QRIgeUad406Ez567u9deMk8by9+
 wacZCDEYyX9qVmPsHD03V+xzzbmxUNvKANJTT1JPok+muytXHf+vcjG4Zh9KxyKq5VgH
 eMlqVO+YMvi1D37VmgRPAEOd+tl5doKE5wFenkMvGyCTQrr++251YzeRV6pCPNJx26O5
 SclJ0X+mxRZRdwbtkjyKBHMU+0zMQS8XcpPUHIuk2nMEG+Yh6mlUAQa1BpHXgImITdOR
 i4vE4QosYZbfLtIwbpzq5JbMZyNDpwHwII8bWqACMAZCAmU3GOxY6+618apP5Dx9gaF0
 8nlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFgodBr/m6uwf3syUdvUfJ+6pvLBfW2ryZbF91tFckIPlFp8X03flJQ+g9FW12TXnxAizr+KNh6v/d@nongnu.org
X-Gm-Message-State: AOJu0YxyyYIu8IqsUZjZQR5w6qmp2rN20etG1+y7dBev9XnZMdrxNNxT
 h+6MPeQtTC+oZ82rx3KX69GZjpbfldhUjvWLNYaSUOeZQXZldgDL0M6z3A+9PJA8NksvwfPmVzj
 WWIH2Lvz/U8OdDJxZSybldwe3sVzVVstN+x31CIWM2p8vUqzLhIs1lfoY
X-Gm-Gg: ASbGncviZ18dR5f8FZ7pqPeYTx8KHbwIB2bGx6Yk/Ux2mYDHSeoccBTn4qCBVZAn9Z1
 XTx/+lLFGC2PaNslKTdpTjgH6aJKO2AVXJNmMeDHZJrO9o0YajMsIfFygJ3OW3D8SCnhwkEtkCQ
 GxsgY00W72vsP295Oz4Zt8V50WqxusF6VAzYqOFAiRZCRVDyPeFDDAsEglc6/Z4ZNMRZ5YiI1rH
 6Zf39/zFJSZsUsFHNCH2fpKjvmbsnRYviO6z9V/+8OSeX+5cxCr4rQJpPkEFsnoyFcpHLqfZJIb
 BzTg2L/B6L1OGA==
X-Received: by 2002:a05:6a00:cc8:b0:73e:10ea:b1e9 with SMTP id
 d2e1a72fcca58-7489ce45c6amr24603951b3a.6.1750283916089; 
 Wed, 18 Jun 2025 14:58:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrGuvcRJ9h3sdim+cF5rfkGm/rfr7TlO54C2ki4yjnMzdbBlFJZcbtUwlDFQVM32x8tAx0IQ==
X-Received: by 2002:a05:6a00:cc8:b0:73e:10ea:b1e9 with SMTP id
 d2e1a72fcca58-7489ce45c6amr24603925b3a.6.1750283915692; 
 Wed, 18 Jun 2025 14:58:35 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7489000749csm12088504b3a.68.2025.06.18.14.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 14:58:34 -0700 (PDT)
Date: Wed, 18 Jun 2025 17:58:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Gao Chao <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v7 0/5] Enable shared device assignment
Message-ID: <aFM2hFgjiBm3nML6@x1.local>
References: <20250612082747.51539-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250612082747.51539-1-chenyi.qiang@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi, Chenyi,

On Thu, Jun 12, 2025 at 04:27:41PM +0800, Chenyi Qiang wrote:
> Relationship with in-place conversion
> -------------------------------------
> In-place page conversion is the ongoing work to allow mmap() of
> guest_memfd to userspace so that both private and shared memory can use
> the same physical memory as the backend. This new design eliminates the
> need to discard pages during shared/private conversions. When it is
> ready, shared device assignment needs be adjusted to achieve an
> unmap-before-conversion-to-private and map-after-conversion-to-shared
> sequence to be compatible with the change.

Is it intentional to be prepared for this?

The question more or less come from the read of patch 5, where I see a
bunch of very similar code versus virtio-mem, like:

        ram_block_attributes_for_each_populated_section
        ram_block_attributes_for_each_discarded_section
        ram_block_attributes_rdm_register_listener
        ram_block_attributes_rdm_unregister_listener

Fundamentally, IIUC it's because of the similar structure of bitmap used,
and the listeners.  IOW, I wonder if it's possible to move the shared
elements into RamDisgardManager for:

    unsigned bitmap_size;
    unsigned long *bitmap;
    QLIST_HEAD(, RamDiscardListener) rdl_list;

But if we know it'll be a tri-state some day, maybe that means it won't
apply anymore.  However the rdl_list is still applicable to be merged if we
want, it's just that it'll be a smaller portion to be shared.

Other than that, even if I don't know how to test this.. I read the patches
today and they look all good.  The duplication is a pure question I have
above, but even if so it can also be done on top.

I do plan to pick this up. Paolo/David, any comments before I do?

Thanks,

-- 
Peter Xu


