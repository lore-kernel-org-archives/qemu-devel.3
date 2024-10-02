Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F447CF31B4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 12:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svy37-00019O-RR; Wed, 02 Oct 2024 08:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svy2w-00017h-E6
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svy2u-0003Uz-PU
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727870491;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=F0pHY42ZhujEfgLa4ymvUuXv/8tQGt1pFPcOGX4Khcs=;
 b=PLKZa6kQR7YcU0S5nVpKO3KTmMcSKxq+H+X54WCBnRcZMKCD4AJeYm78GU5TmLNo9XS3NW
 BwCYkr1jWqwx8w63rUOiBbAH0CUO+O45m01Lawd+zZQ9h3dSpsk1Nn9U3+KJ4iHI5e9olZ
 DKiPM5/2oXV4EeBpCrWyMbPzlXEDmXI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-EWLqehXyMQqbQmHgEBBiKw-1; Wed,
 02 Oct 2024 08:01:26 -0400
X-MC-Unique: EWLqehXyMQqbQmHgEBBiKw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96B061955F42; Wed,  2 Oct 2024 12:01:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C79B19560A3; Wed,  2 Oct 2024 12:01:23 +0000 (UTC)
Date: Wed, 2 Oct 2024 13:01:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Simon Rowe <simon.rowe@nutanix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "freddy77@gmail.com" <freddy77@gmail.com>
Subject: Re: Corrupt VNC display for 1366x768
Message-ID: <Zv02EDIKgmq2L0fg@redhat.com>
References: <DM8PR02MB81217D61C42562572F8AFFB093702@DM8PR02MB8121.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR02MB81217D61C42562572F8AFFB093702@DM8PR02MB8121.namprd02.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Wed, Oct 02, 2024 at 11:09:13AM +0000, Simon Rowe wrote:
> I've been trying to track down the cause of a glitch that affects guest VNC consoles when the resolution is set to 1366x768. This results in a "stair case" effect where each successive row is offset to the right by a handful of pixels. I believe this is related to the fact that the horizontal resolution only divisible by 2, not 16 which most others are.
> 
> There was a similar report many years ago, with a proposed patch
> 
> https://lists.gnu.org/archive/html/qemu-devel/2013-03/msg02732.html
> 
> but this was never committed and the code has been significantly reworked in the meantime.
> 
> Could anyone give me any pointers as to where the problem may lie?

There's a newer bug report here, but not real progress:

  https://gitlab.com/qemu-project/qemu/-/issues/90

1366 is particularly problematic as it apparently can't be represented
exactly in EDID which needs a x8 multiple.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


