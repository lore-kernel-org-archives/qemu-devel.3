Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACAED13593
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 09:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5LwM-00073l-NT; Mon, 28 Oct 2024 05:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5LwJ-00073A-Sz
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 05:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5LwI-0006l8-6l
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 05:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730107288;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=HA9QC8WB3D3k1ePpTcsdEEuwsYtQDfvuRDiUdrDHc60=;
 b=VvpArblzQ4pIM2PD9z7KhbYNghsKvRNBCjppOYgob0SrNPrSDrqWMvC9A9ath0Nv+YsBt1
 4ZjlK/6PXqe6j38/pigMoodMlHpdgHF3g4i30lpiyfmvtAEbP5HGK7JbYx8bIrLFAAgOwf
 1SK4gsNrrbaTIC88F9VgyCqjn7EttGQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-poBFQnTFMDODvSmSVKRI_g-1; Mon,
 28 Oct 2024 05:21:24 -0400
X-MC-Unique: poBFQnTFMDODvSmSVKRI_g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51BD11944CFB; Mon, 28 Oct 2024 09:21:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.86])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C89B3000221; Mon, 28 Oct 2024 09:21:11 +0000 (UTC)
Date: Mon, 28 Oct 2024 09:21:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 manos.pitsidianakis@linaro.org, zhao1.liu@intel.com, junjie.mao@hotmail.com
Subject: Re: [PATCH v3 00/23] rust: fix CI + allow older versions of rustc
 and bindgen
Message-ID: <Zx9XbxxA5iXmfVWC@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <95b07b6b-0980-4a32-86fd-602985750104@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95b07b6b-0980-4a32-86fd-602985750104@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Oct 27, 2024 at 10:01:26AM +0300, Michael Tokarev wrote:
> I think this is the wrong direction (ie, backwards).
> 
> Sacrificing current code to be compatible with old stuff feels wrong.
> Especially for really old, like rustc in debian bookworm.
> 
> bookworm has rustc-web (and a few related packages) which is regular
> rustc version 1.78, just renamed.  It is regular bookworm, not backports.
> It has some packages disabled (compared to regular rust) and is a hack,
> but it exists and can be used for now (dunno if it is sufficient for
> qemu though).
> 
> Also debian has backports mechanism, which also can be used for qemu -
> I can try back-porting regular rust (and llvm) to bookworm.
> 
> I think this is a better way (at least a way forward) than trying to
> move backwards.
> 
> But generally, what is the reason to support debian stable?  I understand
> the CI thing, - we need a way to test stuff.  For this, I'd say a better
> alternative would be to target debian testing (currently trixie), not
> debian stable.

The stable distros are what our community of contributors are usually
using, as few people want non-released bleeding edge distros as their
primary development platform.

Custom installing latest upstream pieces is not a user friendly position
to take. Occassionally it is unavoidable, but it is something to be
avoided wherever practical.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


