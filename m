Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A82EC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 08:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF81x-00011Z-5D; Thu, 06 Jun 2024 03:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sF81t-0000y8-8d
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sF81r-0004pE-GG
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717660760;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwdP6V1XXwR+Ie9Q0kbV7M8ngNHgBbKTCnQUy5IhZ+s=;
 b=KmeZ2JcWt+y9DyDcrGv8SIWb3x48cEIyxRZ7oB0eNCRy1UZ/Vfhmon6RwxgoyBGLVeFIL9
 ATcnnpVq4s3KF57c2Q7vZ9l0fDKXrg+xUcCBXTspu92NAW7JnMv/gVjjqDqCBqMInZj1L6
 IuZnD6wOI4AW/ajalzFjOrY9Z10Ygwg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-y5iTP7lkM7C2zsFQCVflyw-1; Thu,
 06 Jun 2024 03:59:17 -0400
X-MC-Unique: y5iTP7lkM7C2zsFQCVflyw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42E9F19772EE; Thu,  6 Jun 2024 07:59:16 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E4B71955F14; Thu,  6 Jun 2024 07:59:13 +0000 (UTC)
Date: Thu, 6 Jun 2024 08:59:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PULL 07/20] virtio-net: Do not propagate ebpf-rss-fds errors
Message-ID: <ZmFsTrS5QGAOfVpn@redhat.com>
References: <20240604073755.1859-1-jasowang@redhat.com>
 <20240604073755.1859-8-jasowang@redhat.com>
 <ZmA8r20rrbCxKMEY@redhat.com>
 <8a2f0c43-1d48-48f3-8ab2-dafebe252ca7@daynix.com>
 <ZmFh64syjkG6JTcZ@redhat.com>
 <7b4aefd5-1949-4fa5-9bc0-e3ebb4218e73@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b4aefd5-1949-4fa5-9bc0-e3ebb4218e73@daynix.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Jun 06, 2024 at 04:19:11PM +0900, Akihiko Odaki wrote:
> On 2024/06/06 16:14, Daniel P. Berrangé wrote:
> > On Thu, Jun 06, 2024 at 05:14:20AM +0900, Akihiko Odaki wrote:
> > > On 2024/06/05 19:23, Daniel P. Berrangé wrote:
> > > > On Tue, Jun 04, 2024 at 03:37:42PM +0800, Jason Wang wrote:
> > > > > From: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > 
> > > > > Propagating ebpf-rss-fds errors has several problems.
> > > > > 
> > > > > First, it makes device realization fail and disables the fallback to the
> > > > > conventional eBPF loading.
> > > > 
> > > > AFAICT, this is not a bug - this is desired behaviour.
> > > > 
> > > > If the user/mgmt app has told QEMU to use FDs it has passed
> > > > in, then any failure to do this *MUST* be treated as a fatal
> > > > error. Falling back to other codepaths is ignoring a direct
> > > > user request.
> > > 
> > > The FD options are more like an assistance rather than a request. When QEMU
> > > does not have a permission to load eBPF programs, a user can get the eBPF
> > > programs with the request-ebpf command of QMP, load it, and pass the FDs to
> > > QEMU.
> > 
> > That still doesn't alter the fact that if the user has chosen to pass FDs
> > and QEMU fails to use them, it *MUST* report that error back to the user.
> 
> The user should be more interested in whether the eBPF functionality is
> successfully enabled or not, and that is irrelevant from whether the eBPF
> program is loaded by QEMU or someone else.

No, this is wrong. A mgmt application or user will have made a decision
about *how* it wants QEMU to configure a particular feature. QEMU must
always honour the mgmt application's request, and not try to do something
different.

If the mgmt app did not want the FDs to be used, it would not have
passed them to QEMU in the first place. Ignoring the FDs is not likely
to work, because QEMU is unlikely to have permission to open the FDs
itself.

Ignoring the errors when creating the FDs, makes it much much harder
to detect and diagnose deployment problems, because the root cause
error is being discarded, and replaced by a later error which misleads
the app managing QEMU.

Always honouring the user requested config, or giving an error back
when it fails, is standard QEMU practice.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


