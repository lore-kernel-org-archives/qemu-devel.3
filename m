Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D4AC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 06:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2P9Y-0005nv-56; Wed, 09 Apr 2025 02:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2P9N-0005mv-5r
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 02:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2P9E-0001tq-Qk
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 02:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744180974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReSjXhTMyXs68TOAKRohePS4DFiaZ4opUsV4HIHmny8=;
 b=O5Cnwvwe1R31vRQVlCOF6UcCULbxervdApNamrvtXSuVkzbPqQb6JNJfDN3mp8MEQXjbFY
 j4xh3LkIvzgVLX83ZfasEF1kzcDP3u4/7wGvztjnkzpCDQY8KpFG7euBWD7rXQEec8LVIR
 ErW1UotEzVRF4qOujZJfIld2CA4qsUc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-dIYiwDFSO5e-QYXd9yM_Tg-1; Wed,
 09 Apr 2025 02:42:48 -0400
X-MC-Unique: dIYiwDFSO5e-QYXd9yM_Tg-1
X-Mimecast-MFC-AGG-ID: dIYiwDFSO5e-QYXd9yM_Tg_1744180966
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C2C61801A07; Wed,  9 Apr 2025 06:42:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 638251801747; Wed,  9 Apr 2025 06:42:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 017CD21E6773; Wed, 09 Apr 2025 08:42:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: n.shubin@yadro.com,  qemu-devel@nongnu.org,  Linus Walleij
 <linus.walleij@linaro.org>,  Bartosz Golaszewski <brgl@bgdev.pl>,  "Enrico
 Weigelt, metux IT consult" <info@metux.net>,  Viresh Kumar
 <vireshk@kernel.org>,  Eric Blake <eblake@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,  =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le
 Goater <clg@kaod.org>,  Peter Maydell <peter.maydell@linaro.org>,  Steven
 Lee <steven_lee@aspeedtech.com>,  Troy Lee <leetroy@gmail.com>,  Jamin Lin
 <jamin_lin@aspeedtech.com>,  Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,  qemu-arm@nongnu.org,  Nikita Shubin
 <nikita.shubin@maquefel.me>,  Nikita Shubin <nshubin@yadro.com>
Subject: Re: [PATCH PoC 1/7] QAPI: gpio JSON
In-Reply-To: <Z9qpeF9-LNLk_nON@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 19 Mar 2025 11:24:40 +0000")
References: <20250319-gpiodev-v1-0-76da4e5800a1@yadro.com>
 <20250319-gpiodev-v1-1-76da4e5800a1@yadro.com>
 <Z9qpeF9-LNLk_nON@redhat.com>
Date: Wed, 09 Apr 2025 08:42:30 +0200
Message-ID: <87h62xg7jd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Mar 19, 2025 at 10:57:51AM +0300, Nikita Shubin via B4 Relay wrot=
e:
>> From: Nikita Shubin <nshubin@yadro.com>
>>=20
>> Signed-off-by: Nikita Shubin <nshubin@yadro.com>

The commit message should briefly explain the purpose of the change.

>> ---
>>  qapi/gpio.json        | 68 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  qapi/meson.build      |  1 +
>>  qapi/qapi-schema.json |  1 +
>>  3 files changed, 70 insertions(+)
>>=20
>> diff --git a/qapi/gpio.json b/qapi/gpio.json
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..1c2b7af36813ff52cbb3a44e=
64a2e5a5d8658d62
>> --- /dev/null
>> +++ b/qapi/gpio.json
>> @@ -0,0 +1,68 @@
>> +# -*- Mode: Python -*-
>> +# vim: filetype=3Dpython
>> +#
>> +
>> +##
>> +# =3D Gpio devices

Spell it GPIO in doc text, because it's an acronym.

>> +##
>> +
>> +##
>> +# @GpiodevInfo:
>> +#
>> +# Information about a gpio device.
>> +#
>> +# @label: the label of the gpio device
>> +#
>> +# Since: 9.2

Make that 10.1 everywhere.

>> +##
>> +{ 'struct': 'GpiodevInfo',
>> +  'data': { 'label': 'str' } }
>> +
>> +##
>> +# @GpiodevBackendKind:
>> +#
>> +# @chardev: chardevs
>> +#
>> +# Since: 9.2
>> +##
>> +{ 'enum': 'GpiodevBackendKind',
>> +  'data': [ 'chardev' ] }
>> +
>> +##
>> +# @GpiodevChardev:
>> +#
>> +# Configuration info for chardev gpiodevs.
>> +#
>> +# @chardev: chardev id
>> +#
>> +# @size: buffer size, default is 65536

What buffer is being sized here?

>> +#
>> +# Since: 9.2
>> +##
>> +  { 'struct': 'GpiodevChardev',
>> +    'data': { 'chardev': 'str',
>> +              '*size': 'int' } }

Use 'size' instead of 'int' for byte counts, please.

>> +
>> +##
>> +# @GpiodevChardevWrapper:
>> +#
>> +# @data: Configuration info for chardev gpiodevs
>> +#
>> +# Since: 9.2
>> +##
>> +{ 'struct': 'GpiodevChardevWrapper',
>> +  'data': { 'data': 'GpiodevChardev' } }
>> +
>> +##
>> +# @GpiodevBackend:
>> +#
>> +# Configuration info for the new chardev backend.
>> +#
>> +# @type: backend type
>> +#
>> +# Since: 9.2
>> +##
>> +{ 'union': 'GpiodevBackend',
>> +  'base': { 'type': 'GpiodevBackendKind' },
>> +  'discriminator': 'type',
>> +  'data': { 'chardev': 'GpiodevChardevWrapper' } }

Why GpiodevChardevWrapper?  Consistency with similar existing things?

The wrapper types are remnants of "simple" unions.  New code should
avoid them, unless avoiding them would make things hard to use.  For
instance, when adding a new branch to a union where the existing
branches are of such wrapper types, use a wrapper for the new one to
keep things consistent.

What other backend types do you have in mind?

> While historically we've just wired things up to chardevs in QEMU,
> in most cases this is just a hack to get the ability too configure
> a socket, with the other chardev backends being never used. The
> downside of this is that chardev APIs internally are not very nice
> to work with, especally if you want/need to be aware of client
> connection establishment/closure.
>
> These days we've got common socket APIs and QAPI schema available
> and can bypass the chardevs (which have a pretty unpleasant
> internal API) if all we need is a socket backend connecting to
> an external server. This would let code directly work with the
> QIOChannelSocket object, instead of that object being hidden
> behind the chardev APIs.

Good point.  Nikita, do you see a use for chardevs other than sockets?

[...]


