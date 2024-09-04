Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F252ACD4847
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 11:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sloAX-00083P-1d; Wed, 04 Sep 2024 07:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1sloAT-0007et-Er
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1sloAR-0005Wb-On
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725449238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8tl0jOTmEYYQnLxRltpzKo9bjguJw3uzb+RPW2huIZA=;
 b=LpmnryBR+L08ffxSHz/mNIbROoqOM2K3N6xKhJSNmr3r6PyUsMGRlCCVqb/QNpKbQ4Z1VZ
 ujPCNgCsIbE8n/5r7KbaXoSWuDKnq/6BonNpOgRFK22QZtV64KxwoVGqlTYb8hrbXlqSFT
 nyaksOy2qHC5dEhEzqK29LuLHFpyznU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-RHp8hd3uMReF3oNkiAvi5g-1; Wed,
 04 Sep 2024 07:21:10 -0400
X-MC-Unique: RHp8hd3uMReF3oNkiAvi5g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D59801955D4F; Wed,  4 Sep 2024 11:21:09 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.24])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 112031956052; Wed,  4 Sep 2024 11:21:06 +0000 (UTC)
Date: Wed, 4 Sep 2024 13:21:03 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH] chardev: introduce 'reconnect-ms' and deprecate
 'reconnect'
Message-ID: <ZthCn1ze3oUXbR3K@angien.pipo.sk>
References: <20240904051913.53148-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904051913.53148-1-d-tatianin@yandex-team.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 04, 2024 at 08:19:13 +0300, Daniil Tatianin wrote:
> The 'reconnect' option only allows to specify the time in seconds,
> which is way too long for certain workflows.
> 
> We have a lightweight disk backend server, which takes about 20ms to
> live update, but due to this limitation in QEMU, previously the guest
> disk controller would hang for one second because it would take this
> long for QEMU to reinitialize the socket connection.
> 
> Introduce a new option called 'reconnect-ms', which is the same as
> 'reconnect', except the value is treated as milliseconds. These are
> mutually exclusive and specifying both results in an error.
> 
> 'reconnect' is also deprecated by this commit to make it possible to
> remove it in the future as to not keep two options that control the
> same thing.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---

[...]

> diff --git a/qapi/char.json b/qapi/char.json
> index ef58445cee..7f117438c6 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -273,7 +273,19 @@
>  #
>  # @reconnect: For a client socket, if a socket is disconnected, then
>  #     attempt a reconnect after the given number of seconds.  Setting
> -#     this to zero disables this function.  (default: 0) (Since: 2.2)
> +#     this to zero disables this function.  The use of this member is
> +#     deprecated, use @reconnect-ms instead. (default: 0) (Since: 2.2)
> +#
> +# @reconnect-ms: For a client socket, if a socket is disconnected,
> +#     then attempt a reconnect after the given number of milliseconds.
> +#     Setting this to zero disables this function.  This member is
> +#     mutually exclusive with @reconnect.
> +#     (default: 0) (Since: 9.2)
> +#
> +# Features:
> +#
> +# @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
> +#     instead.
>  #
>  # Since: 1.4
>  ##
> @@ -287,7 +299,8 @@
>              '*telnet': 'bool',
>              '*tn3270': 'bool',
>              '*websocket': 'bool',
> -            '*reconnect': 'int' },
> +            '*reconnect': { 'type': 'int', 'features': [ 'deprecated' ] },
> +            '*reconnect-ms': 'int' },
>    'base': 'ChardevCommon' }

This is a little off-topic:

So I wanted to make libvirt use the new parameter to stay ahead
deprecation. I've applied this patch to qemu, dumped capabilities and
pretty much expected a bunch of test cases in libvirt fail as they'd be
using a deprecated field as libvirt is supposed to validate everything.

And the test suite passed unexpectedly. I've dug further and noticed
that for some reason libvirt doesn't still use JSON parameters for
-chardev (which is the pre-requisite for validation).

I've also noticed that at some point I attempted to convert it over
witnessed by having an (unused) capability named QEMU_CAPS_CHARDEV_JSON
that I've introduced.

My questions are:
1) Does '-chardev' accept JSON identical to 'chardev-add' QMP command?

If yes:
2) Since when can that be used? (What can I use as a witness)
3) Are there any gotchas?

I wonder this as I'd love to finish that out, but I really don't fancy
digging into qemu to find a gotcha 3/4 of the way there.

Anyways, as I've already stated, this patch is okay for libvirt, but I
didn't review the implementation, thus, on behalf of libvirt:

ACKed-by: Peter Krempa <pkrempa@redhat.com>


