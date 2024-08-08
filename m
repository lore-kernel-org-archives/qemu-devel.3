Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B264AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 08:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbyn9-0000T2-1t; Thu, 08 Aug 2024 04:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbyn7-0000Ma-DD
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbyn4-0006z1-EV
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723106793;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//TBbDm7wCvIfqFbVSUWVOAXNEb4PP6al1JaT1sbs0g=;
 b=NVmyYTjaWfMdG7lC9sSCb8cS5KluuzYbkKam70yyK+SHUXy1pnnQTd34yqj7FulkCc6mXZ
 lgfRvhi69FLqyaLjG4qEid+MYDK2SRPRXNxiaKf30HoWW1L9a2LwzJZ73+3AA8vAMF1zZu
 qkUC53v13+uzbjrtrfs5vzBLXQ+fEIg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-kjHcsSvTPBm1E3786Ue4kQ-1; Thu,
 08 Aug 2024 04:46:29 -0400
X-MC-Unique: kjHcsSvTPBm1E3786Ue4kQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D9AC1953977; Thu,  8 Aug 2024 08:46:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.163])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57FD91953BBF; Thu,  8 Aug 2024 08:46:24 +0000 (UTC)
Date: Thu, 8 Aug 2024 09:46:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Alejandro Zeise <alejandro.zeise@seagate.com>, qemu-arm@nongnu.org,
 kris.conklin@seagate.com, jonathan.henze@seagate.com,
 evan.burgess@seagate.com, clg@kaod.org, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/15] hw/misc/aspeed_hace: Fix SG Accumulative Hash
 Calculations
Message-ID: <ZrSFwd1yMzyrO4EV@redhat.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
 <ad028c76-dd83-4795-85a4-cbd6b528a9b5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad028c76-dd83-4795-85a4-cbd6b528a9b5@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 07, 2024 at 10:01:40PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Alejandro,
> 
> On 7/8/24 21:51, Alejandro Zeise wrote:
> > The goal of this patch series is to fix accumulative hashing support in the
> > Aspeed HACE module. The issue that stemmed this patch was a failure to boot an
> > OpenBMC image using the "ast2600-evb" machine. The U-boot
> > 2019.04 loader failed to verify image hashes.
> 
> 
> > Alejandro Zeise (15):
> >    crypto: accumulative hashing API
> >    crypto/hash-glib: Implement new hash API
> >    crypto/hash-gcrypt: Implement new hash API
> >    crypto/hash-gnutls: Implement new hash API
> >    crypto/hash-nettle: Implement new hash API
> >    crypto/hash-afalg: Implement new hash API
> >    crypto/hash: Implement and use new hash API
> >    tests/unit/test-crypto-hash: accumulative hashing
> >    crypto/hash-glib: Remove old hash API functions
> >    crypto/hash-gcrypt: Remove old hash API functions
> >    crypto/hash-gnutls: Remove old hash API functions
> >    crypto/hash-nettle: Remove old hash API functions
> >    crypto/hash-afalg: Remove old hash API functions
> >    crypto/hashpriv: Remove old hash API function
> >    hw/misc/aspeed_hace: Fix SG Accumulative hashing
> 
> >   13 files changed, 753 insertions(+), 283 deletions(-)
> 
> Even without the unit test this is still more than 700 LoC,
> which seems a huge patchset to merge while we are in freeze
> period. Do you expect this to be in the next v9.1.0 release?

No, I'm not going to queue it for this release, I will put it
into my queue for 9.2.0

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


