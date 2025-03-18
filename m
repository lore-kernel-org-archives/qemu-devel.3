Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB84C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tufch-0004hq-IB; Tue, 18 Mar 2025 18:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tufcg-0004hX-H3
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tufcZ-0001jA-MY
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742337673;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RIFtX9yBm5BO8VpFMJbu2MZRtN7vSedanz6nIWdqH6Y=;
 b=iNij6jRBu7ENIxZ8fj3Jm0ASPVm8uCJItr6j5C3Yi1KsMVhM7aoatNBv83vt8Oo8dp7nTZ
 o+SZ307VnbMZyn4sxRlYvnp6JQpNisnmiksjiNi9qNiYuP/Fnd+GE0G0UKdD5btnEGvp3n
 3DcA+/eMP9TSXNelgw2f823mMRJeZ9o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-GJ30IwSUPEi3oLlp8-pyww-1; Tue,
 18 Mar 2025 18:41:10 -0400
X-MC-Unique: GJ30IwSUPEi3oLlp8-pyww-1
X-Mimecast-MFC-AGG-ID: GJ30IwSUPEi3oLlp8-pyww_1742337669
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C4531956048; Tue, 18 Mar 2025 22:41:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 554CE18001F6; Tue, 18 Mar 2025 22:41:07 +0000 (UTC)
Date: Tue, 18 Mar 2025 22:41:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, gerben@altlinux.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] qcow2: Don't crash qemu-img info with missing crypto
 header
Message-ID: <Z9n2ZC9Y7Xkuc8H2@redhat.com>
References: <20250318201143.70657-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318201143.70657-1-kwolf@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 18, 2025 at 09:11:43PM +0100, Kevin Wolf wrote:
> qcow2_refresh_limits() assumes that s->crypto is non-NULL whenever
> bs->encrypted is true. This is actually not the case: qcow2_do_open()
> allows to open an image with a missing crypto header for BDRV_O_NO_IO,
> and then bs->encrypted is true, but s->crypto is still NULL.
> 
> It doesn't make sense to open an invalid image, so remove the exception
> for BDRV_O_NO_IO. This catches the problem early and any code that makes
> the same assumption is safe now.
> 
> At the same time, in the name of defensive programming, we shouldn't
> make the assumption in the first place. Let qcow2_refresh_limits() check
> s->crypto rather than bs->encrypted. If s->crypto is NULL, it also can't
> make any requirement on request alignment.
> 
> Finally, start a qcow2-encryption test case that only serves as a
> regression test for this crash for now.
> 
> Reported-by: Leonid Reviakin <L.reviakin@fobos-nt.ru>
> Reported-by: Denis Rastyogin <gerben@altlinux.org>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c                                 |  4 +-
>  tests/qemu-iotests/tests/qcow2-encryption     | 75 +++++++++++++++++++
>  tests/qemu-iotests/tests/qcow2-encryption.out | 32 ++++++++
>  3 files changed, 109 insertions(+), 2 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/qcow2-encryption
>  create mode 100644 tests/qemu-iotests/tests/qcow2-encryption.out

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


