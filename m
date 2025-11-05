Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14EACCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 07:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGXdj-00075I-GJ; Wed, 05 Nov 2025 02:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGXdd-00071Y-HB
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 02:09:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGXdb-0005Yp-0z
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 02:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762326536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ktf+OBCtYKJaIbGK59VNhCQTEJUAwiAB0jtH9hi/6vU=;
 b=hbd/z+g0tkAhKjKZjm8171VXhli5qLLSu+mq0ICyQw5on/sce9b3HKkhBtOcMw7NUQjveU
 +eVdZ1Zro45DDO4J7BW6i8GyPugrfMjKMJ7nwTGZv4uRbwcQiOn4c0qcvKp/hDpiIV7xlp
 tncNiOWgijoyTYDH9MFYIqMDn7WRz/M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-4OB6Fv4oOXe5RBgnUzVF4w-1; Wed,
 05 Nov 2025 02:08:53 -0500
X-MC-Unique: 4OB6Fv4oOXe5RBgnUzVF4w-1
X-Mimecast-MFC-AGG-ID: 4OB6Fv4oOXe5RBgnUzVF4w_1762326532
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5A89195606D; Wed,  5 Nov 2025 07:08:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 265F0300018D; Wed,  5 Nov 2025 07:08:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A59E21E6A27; Wed, 05 Nov 2025 08:08:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>,
 qemu-devel@nongnu.org, hreitz@redhat.com,  qemu-block@nongnu.org
Subject: Re: [PATCH 5/5] vvfat: add support for "size" options
In-Reply-To: <aPqCJRNCjxcZ6jq5@redhat.com> (Kevin Wolf's message of "Thu, 23
 Oct 2025 21:29:41 +0200")
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-6-chigot@adacore.com>
 <aPqCJRNCjxcZ6jq5@redhat.com>
Date: Wed, 05 Nov 2025 08:08:49 +0100
Message-ID: <874ir9ot1a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Kevin Wolf <kwolf@redhat.com> writes:

[...]

> To me it looks a bit like what we really want is an enum for floppy
> sizes (though is there any real reason why we have only those two?), but
> an arbitrary size for hard disks.
>
> Without the enum, obviously, users could specify 1440k and that would do
> the right thing. Maybe special casing whatever 1.44M and 2.88M result
> in and translating them into 1440k and 2880k could be more justifiable
> than special casing 1M and 2M, but it would still be ugly.
>
> Markus, do you have any advice how this should be represented in QAPI?

Still want answers here?

[...]


