Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF087C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 07:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF7L6-0005zj-23; Thu, 06 Jun 2024 03:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sF7L2-0005zU-Ru
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sF7Kz-00048a-CA
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717658103;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCVuqIgKczXo2HUheg5QY8BnemSBZ6B+SWi9EQ4uQ/U=;
 b=W3hC/08PhYlJpbnZ4NqrwBUYYmG+juNdl6bxWT9F3tQ7DL3enYl2WjXAw9c5ro6KFEvUGh
 4jM8GBVq2u3+DoQayN0NfZUrmbHB56IEG8zWq5FG9eEphtXBa7EGBViMk4vaA5c6EfqFMB
 YbAEfUatTRkoHcN/Q5MeAhiT1J1PBBI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-TPA42xnbME2YZHbnLQHfmw-1; Thu, 06 Jun 2024 03:14:55 -0400
X-MC-Unique: TPA42xnbME2YZHbnLQHfmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74A84101A520;
 Thu,  6 Jun 2024 07:14:55 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 565D7201D620;
 Thu,  6 Jun 2024 07:14:54 +0000 (UTC)
Date: Thu, 6 Jun 2024 08:14:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PULL 07/20] virtio-net: Do not propagate ebpf-rss-fds errors
Message-ID: <ZmFh64syjkG6JTcZ@redhat.com>
References: <20240604073755.1859-1-jasowang@redhat.com>
 <20240604073755.1859-8-jasowang@redhat.com>
 <ZmA8r20rrbCxKMEY@redhat.com>
 <8a2f0c43-1d48-48f3-8ab2-dafebe252ca7@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a2f0c43-1d48-48f3-8ab2-dafebe252ca7@daynix.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 06, 2024 at 05:14:20AM +0900, Akihiko Odaki wrote:
> On 2024/06/05 19:23, Daniel P. Berrangé wrote:
> > On Tue, Jun 04, 2024 at 03:37:42PM +0800, Jason Wang wrote:
> > > From: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > 
> > > Propagating ebpf-rss-fds errors has several problems.
> > > 
> > > First, it makes device realization fail and disables the fallback to the
> > > conventional eBPF loading.
> > 
> > AFAICT, this is not a bug - this is desired behaviour.
> > 
> > If the user/mgmt app has told QEMU to use FDs it has passed
> > in, then any failure to do this *MUST* be treated as a fatal
> > error. Falling back to other codepaths is ignoring a direct
> > user request.
> 
> The FD options are more like an assistance rather than a request. When QEMU
> does not have a permission to load eBPF programs, a user can get the eBPF
> programs with the request-ebpf command of QMP, load it, and pass the FDs to
> QEMU.

That still doesn't alter the fact that if the user has chosen to pass FDs
and QEMU fails to use them, it *MUST* report that error back to the user.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


