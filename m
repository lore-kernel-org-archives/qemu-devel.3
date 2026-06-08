Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D37DCD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWVlv-00018F-V5; Mon, 08 Jun 2026 04:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wWVlr-00015n-52
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 04:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wWVlp-0001SA-Gt
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 04:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780908944;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=2oSkTdQLECK9diOUg2NKmtmz1IKvhAZdLEXS7Xs1mn8=;
 b=UE4J4kCe1pZDc1GLsvz9Ms8X7FhPAPFullGqsYQNIOyJobm7Td7geENb6waHnPuPY3AiIe
 7y1jZCUKhJs6/4zwIAD31FmQNmyTUtt8FMlX8UBNH/zKpUkEm1t+D3vwhsvbV3ZI46UF1O
 blYN5wwY8LDUp3rh3u1wrzgy/ylVi9c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-ec9_myasPGC-NtiFNk8EUg-1; Mon,
 08 Jun 2026 04:55:35 -0400
X-MC-Unique: ec9_myasPGC-NtiFNk8EUg-1
X-Mimecast-MFC-AGG-ID: ec9_myasPGC-NtiFNk8EUg_1780908935
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C34F71956094; Mon,  8 Jun 2026 08:55:34 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.219])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D6C81955DC9; Mon,  8 Jun 2026 08:55:32 +0000 (UTC)
Date: Mon, 8 Jun 2026 09:55:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jugraham@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <aiaDgG26a6TUrKuM@redhat.com>
References: <20260608001821.850921-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608001821.850921-1-gshan@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jun 08, 2026 at 10:18:21AM +1000, Gavin Shan wrote:
> On the guest where a NVidia's GH100 card is passed from the host, the
> guest system hang can be observed on attempt to compile 'cuda-samples',
> as reported by Julia.

snip

> By default, the max bounce buffer size is only 4096 bytes, even less
> than one page when the guest page is 64KB. This tries to fix the issue
> by inheriting the customized max bounce buffer size of the virtio bus's
> parent through property 'x-max-bounce-buffer-size' when the customized
> size is a larger one. With this applied, no guest system hang is seen
> with '-device virtio-blk-pci,...,x-max-bounce-buffer-size=268435456'.

"x-max-bounce-buffer-size"  is an experimental / unsupported property.

We really shouldn't be expecting users to have to set this in a production
deployment in order to stop a guest from hanging.  Even if we dropped the
experimental marker from this property, users would still need to know to
provide this magic setting, so it would still be broken out of the box.

How can we  get a solution that "just works" out of the box, which is
fully supported, not relying on experimental properties ?

> 
> Reported-by: Julia Graham <jugraham@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  hw/virtio/virtio-bus.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


