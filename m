Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF47F46126
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4g0t-0007ah-N9; Mon, 23 Mar 2026 10:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w4g0r-0007Yr-Rf
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 10:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w4g0p-0000QX-TM
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 10:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774275131;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+pgXjCFnuwPnVNcOB7p/yWtS3v5qozYHq7LgjuMuLE=;
 b=Jh7roRJBOwUVXeBgwvyNcduePUprdNsv0gwNWELQlREKzgguhYRGUoPGNEbOP1nFJuhuJU
 VLGunFpzDPQwLOaj0yrTnYaHuQstOlQNJorQoQbj6nagRPClrlRadKsLm7I/fo15DjdT2u
 WZpt6eHZHlc4rRutpqfD7g4KDVUbq10=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-LhdyHVQKPfaTuqf0nz3QZQ-1; Mon,
 23 Mar 2026 10:12:07 -0400
X-MC-Unique: LhdyHVQKPfaTuqf0nz3QZQ-1
X-Mimecast-MFC-AGG-ID: LhdyHVQKPfaTuqf0nz3QZQ_1774275126
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9BE01955F6A; Mon, 23 Mar 2026 14:12:05 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.227])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6133D300019F; Mon, 23 Mar 2026 14:12:02 +0000 (UTC)
Date: Mon, 23 Mar 2026 14:11:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, mst@redhat.com, yuri.benditovich@daynix.com,
 akihiko.odaki@daynix.com, qemu-stable@nongnu.org
Subject: Re: [PATCH] virtio-net: validate RSS indirections_len in post_load
Message-ID: <acFKLgvFAlP7asIp@redhat.com>
References: <20260323131531.1976-1-junjie.cao@intel.com>
 <acFDFHsh8Rjhfncc@redhat.com>
 <CAFEAcA88mHqmM8Pmm0Gbbeu4ugBV8snenZh7bvjSSruUtRcywQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA88mHqmM8Pmm0Gbbeu4ugBV8snenZh7bvjSSruUtRcywQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 23, 2026 at 01:53:53PM +0000, Peter Maydell wrote:
> On Mon, 23 Mar 2026 at 13:43, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Mon, Mar 23, 2026 at 09:15:31PM +0800, Junjie Cao wrote:
> > > virtio_net_handle_rss() enforces that indirections_len is a non-zero
> > > power of two no larger than VIRTIO_NET_RSS_MAX_TABLE_LEN, but
> > > virtio_net_rss_post_load() applies none of these checks to values
> > > restored from the migration stream.
> > >
> > > A crafted migration stream can set indirections_len to 0.  Even if it
> >
> > The migration stream originating from the source QEMU is trusted.
> 
> Is it? In https://www.qemu.org/docs/master/system/security.html we say:
> 
> # The following entities are untrusted, meaning that they may be buggy
> # or malicious:
> 
> #  * Guest
> #  * User-facing interfaces (e.g. VNC, SPICE, WebSocket)
> #  * Network protocols (e.g. NBD, live migration)
> #  * User-supplied files (e.g. disk images, kernels, device trees)
> #  * Passthrough devices (e.g. PCI, USB)
> 
> which explicitly lists "live migration" as an untrusted entity.
> 
> I would definitely be extremely cautious about having a threat
> model where I had to distrust inbound migration data, but the
> above does suggest we aim to handle that, and we have I think
> in the past taken patches which add sanity-checking to the
> migration data.

My view of the migration stream is that we authenticate the client
at the point of connection (either explicitly with SASL, or implicitly
with a x509 certificate validation), and protect the data stream
integrity with TLS, or equivalent.

For the vmstate data, we simply expect that to reflect the current
QEMU configuration, and variation of that is liable to lead to
a crash or worse.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


