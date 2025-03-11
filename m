Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1CEC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1Qm-000825-6G; Tue, 11 Mar 2025 11:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1ts1Ql-000817-3i
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1ts1Qj-00078l-Ep
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741706523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KsQ3xerlblEQJ8L1BE9l2Kwp42DRb9QBeWw/y3m2PRI=;
 b=i1NZjUUuMlezcGsc322NLbY70UwvfcRm6E5iFvkaix5C909PHNRDshKqQgDcEzmcK+yjdZ
 Uq3uJFltefLyBTjurbr7ymJTNc9M+NWZGIlm/GYsWcqo27C4XQXyK7qv6/VcTcodqEdwHX
 o/TR89I0XfhroOQ0SrPFpGzs2btJj14=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-fpYlzBR2P6ab0KG2Q86mqw-1; Tue,
 11 Mar 2025 11:22:00 -0400
X-MC-Unique: fpYlzBR2P6ab0KG2Q86mqw-1
X-Mimecast-MFC-AGG-ID: fpYlzBR2P6ab0KG2Q86mqw_1741706519
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5F5F18001E0; Tue, 11 Mar 2025 15:21:57 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA8B318001F6; Tue, 11 Mar 2025 15:21:51 +0000 (UTC)
Date: Tue, 11 Mar 2025 16:21:47 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v4 00/13] virtio-scsi: add iothread-vq-mapping parameter
Message-ID: <Z9BVC0IObZw-Ty8E@angien.pipo.sk>
References: <20250311132616.1049687-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311132616.1049687-1-stefanha@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Mar 11, 2025 at 21:26:03 +0800, Stefan Hajnoczi wrote:
> v4:
> - Squash fixup commit properly this time >_< [Peter]
> v3:
> - Use vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED] as the AioContext for the Block
>   Backend [Kevin]
> v2:
> - Only expose cmd vqs via iothread-vq-mapping [Kevin, Peter]
> 
> Implement --device virtio-scsi-pci,iothread-vq-mapping= support so that
> virtqueues can be assigned to different IOThreads. This improves SMP guest
> scalability where I/O-intensive applications can become bottlenecked on a
> single IOThread.
> 
> The following benchmark results show the effect of iothread-vq-mapping. fio
> randread 4k iodepth=64 results from a 4 vCPU guest with an Intel P4800X SSD:
> iothreads IOPS
> ------------------------------
> 1         189576
> 2         312698
> 4         346744

I've modified my libvirt patches to take only the command queues into
account same as with virtio-blk.

After learning how 'fio' works I was able to set multiple iothreads on
fire based on the mapping.

Tested-by: Peter Krempa <pkrempa@redhat.com>


