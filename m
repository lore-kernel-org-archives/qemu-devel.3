Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B424AD44D49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 10:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8db6-0007TV-HX; Wed, 06 Nov 2024 05:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8day-0007T6-Ct
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:49:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8daw-0006Ub-0b
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730890136;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ysgcVCXSS3kQZ+tMf/9C/uhsk05fOrzJ8TK/GnQh5s=;
 b=OmhpYpT1hKYggMvuLU4uJ95bl5VJC6Q8V39xMnqko8uHdCabjY0hgSPOGHlzeh9HL9Spf1
 D3B8nGNpngtxNYFrgFy+13EfcOncVL+DUn6x+nOG8NMCwmUNu9g+VFxcSGoP/GGkHbUDvM
 +KM8aMvlmnNrzEkqJLY/X55j0fjSPYg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-VngcktcXMbaftCPpAyvq7A-1; Wed,
 06 Nov 2024 05:48:52 -0500
X-MC-Unique: VngcktcXMbaftCPpAyvq7A-1
X-Mimecast-MFC-AGG-ID: VngcktcXMbaftCPpAyvq7A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61AF71955BC7; Wed,  6 Nov 2024 10:48:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.182])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 365ED1955F40; Wed,  6 Nov 2024 10:48:47 +0000 (UTC)
Date: Wed, 6 Nov 2024 10:48:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 05/22] tests/qtest/migration: Move bootfile code to its
 own file
Message-ID: <ZytJbv4YVL1xxcKs@redhat.com>
References: <20241105180837.5990-1-farosas@suse.de>
 <20241105180837.5990-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105180837.5990-6-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 05, 2024 at 03:08:20PM -0300, Fabiano Rosas wrote:
> Move the code that creates the guest binary out of migration-test and
> into the qtest/migration/ directory, along with the rest of the
> a-b-kernel code.
> 
> That code is part of the basic infrastructure of migration tests, it
> shouldn't be among the tests themselves.
> 
> Also take the chance and rename migration-test.h, which is too generic
> a name for this header which contains only values related to guest
> memory offsets.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/meson.build                       |  8 ++-
>  tests/qtest/migration-helpers.c               |  1 +
>  tests/qtest/migration-test.c                  | 58 +--------------
>  tests/qtest/migration/bootfile.c              | 70 +++++++++++++++++++
>  .../{migration-test.h => bootfile.h}          |  9 ++-
>  5 files changed, 86 insertions(+), 60 deletions(-)
>  create mode 100644 tests/qtest/migration/bootfile.c
>  rename tests/qtest/migration/{migration-test.h => bootfile.h} (85%)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


