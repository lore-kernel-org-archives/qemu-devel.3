Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2191606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cLUKJiZT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ2vZ-0003zp-AR; Tue, 20 Oct 2026 02:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJ2vX-0003z4-Hf
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJ2vV-0005Vd-TI
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792476141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=353JN23q6f+hqnvB1uPVAQdFvfqeMDkzNXYAXbmwPiw=;
 b=cLUKJiZTv7sN12tVnksTdpHqUbwVBtnMjSgPvfcF1g8UTgbbeGt46Dua4iQQCUS32u6m7C
 CA87qZjVJqya8hVDyoy/OJIsbHcekW09v3ptPzs3pzZ1BNcURLP5nuf2+Ut9UrZ/IrQMZE
 1ECYz+ugfkaI828bikfQ220GduD+jsI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-8jHcqqWrN5eYNpyBMtyMUw-1; Tue,
 20 Oct 2026 06:02:17 +0000
X-MC-Unique: 8jHcqqWrN5eYNpyBMtyMUw-1
X-Mimecast-MFC-AGG-ID: 8jHcqqWrN5eYNpyBMtyMUw_1792476136
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46E1519539A7; Tue, 20 Oct 2026 06:02:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE6E41800347; Tue, 20 Oct 2026 06:02:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 84A7F21E6A04; Tue, 20 Oct 2026 08:02:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  John Snow <jsnow@redhat.com>,  "Denis V . Lunev"
 <den@openvz.org>,  Eric Blake <eblake@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 05/12] qapi/run-state: Add io-hang state
In-Reply-To: <20261019182028.45305-6-hreitz@redhat.com> (Hanna Czenczek's
 message of "Mon, 19 Oct 2026 20:20:21 +0200")
References: <20261019182028.45305-1-hreitz@redhat.com>
 <20261019182028.45305-6-hreitz@redhat.com>
Date: Tue, 20 Oct 2026 08:02:13 +0200
Message-ID: <87qzhksye2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hanna Czenczek <hreitz@redhat.com> writes:

> This state is similar to io-error, but is not entered on I/O errors but
> instead when a request takes longer than a user-defined time (set via
> the delay-stop-ns property on a block device, which is not yet available
> but will be added by a future patch in this series).
>
> In contrast to other stop states, this state does not drain block
> devices.  That is because it is entered only when a request hangs, which
> means that draining would be counter-productive.
>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  qapi/run-state.json |  7 ++++++-
>  system/runstate.c   | 25 ++++++++++++++++++-------
>  2 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index 8bbd9884087..cf3f43579de 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -53,12 +53,17 @@
>  # @colo: guest is paused to save/restore VM state under colo
>  #     checkpoint, VM can not get into this state unless colo
>  #     capability is enabled for migration.  (since 2.8)
> +#
> +# @io-hang: An I/O operation has been delayed for too long and the
> +#     device is configured to stop the VM when that happens.  In
> +#     contrast to other paused states, the VM's block devices will not
> +#     be drained when entering this run state.  (since 11.2)
>  ##
>  { 'enum': 'RunState',
>    'data': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
>              'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
>              'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
> -            'guest-panicked', 'colo' ] }
> +            'guest-panicked', 'colo', 'io-hang' ] }
>  
>  ##
>  # @ShutdownCause:

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


