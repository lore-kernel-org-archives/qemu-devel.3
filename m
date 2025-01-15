Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CF0C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 09:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXzTd-0003Cs-Md; Wed, 15 Jan 2025 04:14:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1tXzTQ-0002zZ-In
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 04:14:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1tXzTO-0003KY-Bg
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 04:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736932440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ARwekFpKjOKhinrwmdvG3loaml3oVD++putzwDM4Ang=;
 b=HWGVVnPcSYpxx6sSi/UCFRrw01epx35dLyD1UK8NHVKxOQuCFKrRVO2x7iYbw7bSj2QScY
 jldAl4JmU19OR9V5/46waKxQXdJRy0YMJVpOLN2SXc3cxNIvtwQP5WJrTa7qr8jOnTszSS
 Qk2UWjPZy7vT+rCxOgG26j+GxIFaxPo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-AejEqd6oOG6vHnVMrlcb8g-1; Wed,
 15 Jan 2025 04:12:49 -0500
X-MC-Unique: AejEqd6oOG6vHnVMrlcb8g-1
X-Mimecast-MFC-AGG-ID: AejEqd6oOG6vHnVMrlcb8g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D404B19560AA; Wed, 15 Jan 2025 09:12:47 +0000 (UTC)
Received: from orkuz (unknown [10.43.3.115])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F12C219560A3; Wed, 15 Jan 2025 09:12:46 +0000 (UTC)
Date: Wed, 15 Jan 2025 10:12:45 +0100
From: Jiri Denemark <jdenemar@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 00/16] migration: Switchover phase refactoring
Message-ID: <Z4d8DWKgWveN17M9@orkuz.int.mamuti.net>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jdenemar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 14, 2025 at 18:07:30 -0500, Peter Xu wrote:
> CI: https://gitlab.com/peterx/qemu/-/pipelines/1625266692
>     (note: warning is present on rust stuff, but shouldn't be relevant)
> 
> This series refactors the migration switchover path quite a bit.  I started
> this work initially to measure the JSON writer overhead, but then I decided
> to cleanup the switchover path in general when I am at it altogether, as I
> wanted to do this for a long time.
> 
> A few major things I tried to do:
> 
...
>   - DEVICE migration state
> 
>     QEMU has a very special DEVICE migration state, that only happens with
>     precopy, and only when pause-before-switchover capability is enabled.
>     Due to that specialty we can't merge precopy and postcopy code on
>     switchover starts, because the state machine will be different.
> 
>     However after I checked the history and also with libvirt developers,
>     this seems unnecessary.  So I had one patch making DEVICE state to be
>     the "switchover" phase for precopy/postcopy unconditionally.  That will
>     make the state machine much easier for both modes, meanwhile nothing is
>     expected to break with it (but please still shoot if anyone knows /
>     suspect something will, or could, break..).

No problem from libvirt side...

Tested-by: Jiri Denemark <jdenemar@redhat.com>


