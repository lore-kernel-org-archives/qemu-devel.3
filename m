Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D98C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 11:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1turY0-0001zG-6c; Wed, 19 Mar 2025 07:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1turXy-0001yU-C8
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1turXv-0004Rz-3c
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742383512;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=C1w8kgAFq/a4lRFCTW6J283Rau1D7/rkcE+jQX8KfME=;
 b=WbV5qw5/KRc3iYGnLYdlyORyEZyoEjzUh5B2c8kKygXmG56YRInW3nvTGwaQemKBac8d19
 LlN40eSdmGC8IFdsVEZgLul1fV2N7lrK7R9Rjpujcul7aXH3vJcn2VT9b3BVFH3/A9teHH
 nUjm4GU59vQdwyYmtAvz3HWMoZKRgiM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-GY9be_JqP72Fprzkb37gfA-1; Wed,
 19 Mar 2025 07:25:08 -0400
X-MC-Unique: GY9be_JqP72Fprzkb37gfA-1
X-Mimecast-MFC-AGG-ID: GY9be_JqP72Fprzkb37gfA_1742383506
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87EB319560B7; Wed, 19 Mar 2025 11:25:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B36B3001D0E; Wed, 19 Mar 2025 11:24:46 +0000 (UTC)
Date: Wed, 19 Mar 2025 11:24:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: n.shubin@yadro.com
Cc: qemu-devel@nongnu.org, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Viresh Kumar <vireshk@kernel.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Nikita Shubin <nikita.shubin@maquefel.me>,
 Nikita Shubin <nshubin@yadro.com>
Subject: Re: [PATCH PoC 1/7] QAPI: gpio JSON
Message-ID: <Z9qpeF9-LNLk_nON@redhat.com>
References: <20250319-gpiodev-v1-0-76da4e5800a1@yadro.com>
 <20250319-gpiodev-v1-1-76da4e5800a1@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250319-gpiodev-v1-1-76da4e5800a1@yadro.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Mar 19, 2025 at 10:57:51AM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nshubin@yadro.com>
> 
> Signed-off-by: Nikita Shubin <nshubin@yadro.com>
> ---
>  qapi/gpio.json        | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  qapi/meson.build      |  1 +
>  qapi/qapi-schema.json |  1 +
>  3 files changed, 70 insertions(+)
> 
> diff --git a/qapi/gpio.json b/qapi/gpio.json
> new file mode 100644
> index 0000000000000000000000000000000000000000..1c2b7af36813ff52cbb3a44e64a2e5a5d8658d62
> --- /dev/null
> +++ b/qapi/gpio.json
> @@ -0,0 +1,68 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +#
> +
> +##
> +# = Gpio devices
> +##
> +
> +##
> +# @GpiodevInfo:
> +#
> +# Information about a gpio device.
> +#
> +# @label: the label of the gpio device
> +#
> +# Since: 9.2
> +##
> +{ 'struct': 'GpiodevInfo',
> +  'data': { 'label': 'str' } }
> +
> +##
> +# @GpiodevBackendKind:
> +#
> +# @chardev: chardevs
> +#
> +# Since: 9.2
> +##
> +{ 'enum': 'GpiodevBackendKind',
> +  'data': [ 'chardev' ] }
> +
> +##
> +# @GpiodevChardev:
> +#
> +# Configuration info for chardev gpiodevs.
> +#
> +# @chardev: chardev id
> +#
> +# @size: buffer size, default is 65536
> +#
> +# Since: 9.2
> +##
> +  { 'struct': 'GpiodevChardev',
> +    'data': { 'chardev': 'str',
> +              '*size': 'int' } }
> +
> +##
> +# @GpiodevChardevWrapper:
> +#
> +# @data: Configuration info for chardev gpiodevs
> +#
> +# Since: 9.2
> +##
> +{ 'struct': 'GpiodevChardevWrapper',
> +  'data': { 'data': 'GpiodevChardev' } }
> +
> +##
> +# @GpiodevBackend:
> +#
> +# Configuration info for the new chardev backend.
> +#
> +# @type: backend type
> +#
> +# Since: 9.2
> +##
> +{ 'union': 'GpiodevBackend',
> +  'base': { 'type': 'GpiodevBackendKind' },
> +  'discriminator': 'type',
> +  'data': { 'chardev': 'GpiodevChardevWrapper' } }

While historically we've just wired things up to chardevs in QEMU,
in most cases this is just a hack to get the ability too configure
a socket, with the other chardev backends being never used. The
downside of this is that chardev APIs internally are not very nice
to work with, especally if you want/need to be aware of client
connection establishment/closure.

These days we've got common socket APIs and QAPI schema available
and can bypass the chardevs (which have a pretty unpleasant
internal API) if all we need is a socket backend connecting to
an external server. This would let code directly work with the
QIOChannelSocket object, instead of that object being hidden
behind the chardev APIs.

 { 'enum': 'GpiodevBackendKind',
   'data': [ 'socket' ] }

 { 'struct': 'GpiodevSocket',
   'data': { 'addr': 'SocketAddress',
             '*size': 'int'} }

 { 'struct': 'GpiodevSocketWrapper',
   'data': { 'data': 'GpiodevSocket' } }


 { 'union': 'GpiodevBackend',
   'base': { 'type': 'GpiodevBackendKind' },
   'discriminator': 'type',
   'data': { 'socket': 'GpiodevSocketWrapper' } }

if you need to switch between client/server mode some further
additions would be needed.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


