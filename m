Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A93DC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 06:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2PMw-0000Ie-HW; Wed, 09 Apr 2025 02:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2PMu-0000Hy-0q
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 02:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2PMs-0004eH-88
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 02:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744181821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bdXLUhDFBZnqWIM0OScM+yJqDCgLY6zkPW5gq/U+PoU=;
 b=gFZDEoHPwGuFWPcIOw1EAXe3oBE9IJVi7h3z/mOfXTUn2akd9GBIi9yOdWnIWKFHjx5sl0
 kctStlMxv0dMenLj4eb5DhCGrT8smNM633k+FFSBuApOCwpfhUqFBK5S7T2As5IpwbBtEs
 VCpyTDQbacBn8BhPcmMUx7mFXSs5hQ0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-ldKryXfgOEOOuXMlYB1C6w-1; Wed,
 09 Apr 2025 02:56:57 -0400
X-MC-Unique: ldKryXfgOEOOuXMlYB1C6w-1
X-Mimecast-MFC-AGG-ID: ldKryXfgOEOOuXMlYB1C6w_1744181815
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06102195608D; Wed,  9 Apr 2025 06:56:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EC943001D0E; Wed,  9 Apr 2025 06:56:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 000A421E6773; Wed, 09 Apr 2025 08:56:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Nikita Shubin via B4 Relay <devnull+n.shubin.yadro.com@kernel.org>
Cc: qemu-devel@nongnu.org,  n.shubin@yadro.com,  Linus Walleij
 <linus.walleij@linaro.org>,  Bartosz Golaszewski <brgl@bgdev.pl>,  "Enrico
 Weigelt, metux IT consult" <info@metux.net>,  Viresh Kumar
 <vireshk@kernel.org>,  Eric Blake <eblake@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,  Steven Lee
 <steven_lee@aspeedtech.com>,  Troy Lee <leetroy@gmail.com>,  Jamin Lin
 <jamin_lin@aspeedtech.com>,  Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,  qemu-arm@nongnu.org,  Nikita Shubin
 <nikita.shubin@maquefel.me>
Subject: Re: [PATCH PoC 7/7] gpiodev: Add gpiobackend over GUSE
In-Reply-To: <20250319-gpiodev-v1-7-76da4e5800a1@yadro.com> (Nikita Shubin
 via's message of "Wed, 19 Mar 2025 10:57:57 +0300")
References: <20250319-gpiodev-v1-0-76da4e5800a1@yadro.com>
 <20250319-gpiodev-v1-7-76da4e5800a1@yadro.com>
Date: Wed, 09 Apr 2025 08:56:44 +0200
Message-ID: <875xjdg6vn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Nikita Shubin via B4 Relay <devnull+n.shubin.yadro.com@kernel.org>
writes:

> From: Nikita Shubin <n.shubin@yadro.com>
>
> Add GUSE (FUSE based kernel module similiar to CUSE) based backend.
>
> This allows transparent usage of Linux GPIO UAPI based tools like
> in kernel tools/gpio or libgpiod.
>
> libgpiod requires some modification to allow "/sys/class/guse" in
> gpiod_check_gpiochip_device().
>
> It requires guse module to be loaded and providing DEVICE()->id
> for GPIO module, for example:
>
> ```
> DEVICE(&s->gpio)->id = g_strdup("aspeed-gpio0");
> ```
>
> The id should be provided to gpiodev with any `devname` that doesn't
> exists in /dev:
>
> ```
> -gpiodev guse,id=aspeed-gpio0,devname=gpiochip10
> ```
>
> That /dev/gpiochip10 can be used in the same way we usually operate with
> gpiochip's.
>
> Link: http://git.maquefel.me/?p=qemu-gpiodev/libgpiod.git;a=shortlog;h=refs/heads/nshubin/guse-fix
> Link: http://git.maquefel.me/?p=qemu-gpiodev/guse.git;a=summary
> Link: http://git.maquefel.me/?p=qemu-gpiodev/libfuse.git;a=shortlog;h=refs/heads/nshubin/guse
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>

[...]

> diff --git a/qapi/gpio.json b/qapi/gpio.json
> index 1c2b7af36813ff52cbb3a44e64a2e5a5d8658d62..e3cdca793260212622a30947eaea61bd523e98fb 100644
> --- a/qapi/gpio.json
> +++ b/qapi/gpio.json
> @@ -21,12 +21,36 @@
>  ##
>  # @GpiodevBackendKind:
>  #
> -# @chardev: chardevs
> +# @chardev: Gpio dev over chardev backend
> +# @gusedev: Gpio dev over GUSE FUSE module
>  #
>  # Since: 9.2

10.1

>  ##
>  { 'enum': 'GpiodevBackendKind',
> -  'data': [ 'chardev' ] }
> +  'data': [ 'chardev',
> +            { 'name': 'gusedev', 'if': 'CONFIG_LINUX' } ] }
> +
> +##
> +# @GpiodevGusedev:
> +#
> +# Configuration info for guse gpiodevs.
> +#
> +# @devname: Name of device created in /dev

Existing names for similar things elsewhere:

* @dev in AudiodevAlsaPerDirectionOptions

* @device in ChardevHostdev

* @devname in NetdevNetmapOptions

* @vhostdev in NetdevVhostUserOptions

* @sev-device in SevCommonProperties

* @filename in RngRandomProperties

* @path in BlockdevOptionsNvmeIoUring,
  BlockdevOptionsVirtioBlkVhostVdpa, TPMPassthroughOptions

What a mess.

@filename and @path are clearly bad.

I'd prefer @device or @gpio-device, or maybe @dev.

> +#
> +# Since: 9.2
> +##
> +  { 'struct': 'GpiodevGusedev',
> +    'data': { 'devname': 'str' } }
> +
> +##
> +# @GpiodevGusedevWrapper:
> +#
> +# @data: Configuration info for chardev gpiodevs
> +#
> +# Since: 9.2
> +##
> +{ 'struct': 'GpiodevGusedevWrapper',
> +  'data': { 'data': 'GpiodevGusedev' } }

Avoid the wrapper?

>  
>  ##
>  # @GpiodevChardev:
> @@ -65,4 +89,5 @@
>  { 'union': 'GpiodevBackend',
>    'base': { 'type': 'GpiodevBackendKind' },
>    'discriminator': 'type',
> -  'data': { 'chardev': 'GpiodevChardevWrapper' } }
> \ No newline at end of file
> +  'data': { 'chardev': 'GpiodevChardevWrapper',
> +            'gusedev': { 'type': 'GpiodevGusedevWrapper', 'if': 'CONFIG_LINUX' } } }
> \ No newline at end of file

Please add a newline at the end of the file.


