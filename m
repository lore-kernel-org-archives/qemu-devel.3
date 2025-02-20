Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B4AC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 17:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9zE-0004jE-O9; Thu, 20 Feb 2025 12:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tl9zB-0004hW-NT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 12:05:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tl9z6-0007QD-Qy
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 12:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740071109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+HSG8KDJ6D2pDzYsEKaTB10+FXvVQw9sV8ulw2xPk74=;
 b=M/RtjNjV67+rUR+lU3KV6iGEcgdwMt2U7m2tfu+k7alUbG/bJtpA3kY3UBxBucMH5LyKdS
 GvBQVoG1nWkTjZhR57HN33r/UbNz0Xkudf1H49uC+wkvFYw2znhcSlkJS7/z+i1HWZhaKb
 mBS4pdTSQ6/GU6ZpjDOtKqqlgHRGqR4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-4uIC2BqGNn-8badFbuSH2Q-1; Thu,
 20 Feb 2025 12:05:06 -0500
X-MC-Unique: 4uIC2BqGNn-8badFbuSH2Q-1
X-Mimecast-MFC-AGG-ID: 4uIC2BqGNn-8badFbuSH2Q_1740071105
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D002419039C6; Thu, 20 Feb 2025 17:05:04 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.44.22.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E15C51800359; Thu, 20 Feb 2025 17:04:58 +0000 (UTC)
Date: Thu, 20 Feb 2025 18:04:54 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 00/12] virtio-scsi: add iothread-vq-mapping parameter
Message-ID: <Z7dgtjIK3EBrGpEQ@angien.pipo.sk>
References: <20250213180043.713434-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213180043.713434-1-stefanha@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 13, 2025 at 13:00:31 -0500, Stefan Hajnoczi wrote:
> Implement --device virtio-scsi-pci,iothread-vq-mapping= support so that
> virtqueues can be assigned to different IOThreads. This improves SMP guest
> scalability where I/O-intensive applications can become bottlenecked on a
> single IOThread.

Hi I was playing around with this along with the patches and I can see
that multiple iothreads do get loaded when I configure the mapping. It
was a bit tricky to spot it though among the 200-odd 'worker' threads
qemu spawned :D (but spawns also without this feature being used).

I didn't do any benchmarks ...

> The following benchmark results show the effect of iothread-vq-mapping. fio
> randread 4k iodepth=64 results from a 4 vCPU guest with an Intel P4800X SSD:
> iothreads IOPS
> ------------------------------
> 1         189576
> 2         312698
> 4         346744

... so I'll trust you here, but at least configuration wise this seems
to work.

As discussed on the libvirt patchset it might be a good idea to
docuement that the ctrl and event queues need to be mapped as well if
you'll be dealing with docs.

Tested-by: Peter Krempa <pkrempa@redhat.com>


