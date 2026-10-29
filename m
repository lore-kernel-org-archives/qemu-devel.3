Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04164606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=epEhn4ta
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMLpH-0006nJ-S4; Thu, 29 Oct 2026 04:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xMLpF-0006nA-PH
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 04:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xMLpE-00029l-0a
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 04:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793263770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8EpTxfRr+v74XtuRYLhwcKF+ZlDpYbK3HxQAXhPP9o=;
 b=epEhn4taRJxm027dJzOEtavMdKg+72hAJnaYuKMbgGVhgX0qzAan/0RpkJtpY6KON6LYfK
 Seo9Ahzlnxl5tVzjifvwI9gsKpBdwEGymnKNoWnomoVO4H50q0eNhHx1sNxwaaJV3qg7vE
 tMppVhT2VZJwy6Vnviz8zro2mBwhX1M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-OviB5wr1OXyU6-Z44S6JqA-1; Thu,
 29 Oct 2026 04:49:26 -0400
X-MC-Unique: OviB5wr1OXyU6-Z44S6JqA-1
X-Mimecast-MFC-AGG-ID: OviB5wr1OXyU6-Z44S6JqA_1793263764
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 503021955EB3; Thu, 29 Oct 2026 08:49:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D6841800643; Thu, 29 Oct 2026 08:49:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1DEF121E6A04; Thu, 29 Oct 2026 09:49:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,  Richard
 Henderson <richard.henderson@linaro.org>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 14/21] util: introduce capture of textual messages in
 data recorder
In-Reply-To: <20261015112044.1999748-15-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 15 Oct 2026 12:20:37
 +0100")
References: <20261015112044.1999748-1-berrange@redhat.com>
 <20261015112044.1999748-15-berrange@redhat.com>
Date: Thu, 29 Oct 2026 09:49:21 +0100
Message-ID: <874ie4gacu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Introduce a circular buffer concept to the data recorder that can be
> used to capture text based messages from subsystems. Support for
> multiple distinct "buckets" is provided, one per type of information
> to be captured. This ensures that data from subsystems which is
> captured at a high rate, does not prematurely wrap the buffer and
> overwrite (still relevant) messages from a subsystem that records
> at a low rate.
>
> Each bucket has a max capacity of 64 KB by default (though it is
> configurable), but grows on demand. IOW the bucket capacity puts
> an upper limit on memory usage, actual usage will be zero until
> data is recorded. Every captured message will be prefixed by a
> timestamp and suffixed by a newline, if one is not already present
> at the end of the message.
>
> While writing into the bufers is synchronized with mutex locks,
> when dumping from a signal handler the buffers are accessed
> without any locking to avoid deadlocks. Atomic loads/stores are
> used in certain places so the signal handler can dump data with
> acceptable accuracy even when racing with other threads still
> writing new messages.
>
> When the circular buffer wraps, old messages will be overwritten
> without attention to message boundaries. IOW, when later dumping
> the data recorder, the first printed message is likely to have
> its leading text and timestamp missing. This is considered an
> acceptable tradeoff to avoid tracking message boundaries which
> greatly adds complexity and is hard todo safely without locks
> when dumping.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 1c9031fba9a..f1c37bce6c2 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -8,6 +8,7 @@
>  { 'include': 'block-core.json' }
>  { 'include': 'common.json' }
>  { 'include': 'crypto.json' }
> +{ 'include': 'tldr.json' }
>=20=20
>  ##
>  # ***********************
> @@ -1239,11 +1240,13 @@
>  #
>  # @crash-target: fully qualified path to perserve data recorder
>  #                contents on QEMU crash

Blank line, please.

> +# @messages: custom configuration for message buckets
>  #
>  # Since: 11.2.0
>  ##
>  { 'struct': 'QTLDRConfigProperties',
> -  'data': { '*crash-target': 'str' }
> +  'data': { '*crash-target': 'str',
> +            '*messages': ['QTLDRMsgBucketConfig'] }
>  }
>=20=20
>  ##
> diff --git a/qapi/tldr.json b/qapi/tldr.json
> index 8e2b7cda324..987d36b91f8 100644
> --- a/qapi/tldr.json
> +++ b/qapi/tldr.json
> @@ -26,3 +26,37 @@
>  #     <- { "return": {} }
>  ##
>  { 'command': 'tldr-dump', 'data': 'QTLDRDumpOptions' }
> +
> +##
> +# @QTLDRMsgBucketType:
> +#     List of message bucket types

This isn't a list, it's an enum.  Simply scratch "List of".

> +#
> +# @error: error messages and warnings
> +# @command: QMP commands which change state and error responses
> +# @event: QMP events reflecting state changes
> +# @log: log messages from any subsystems

Blank lines between member descriptions, please.

> +#
> +# Since: 11.2.0

Make this 11.2 to match overwhelming existing practice.  Same elsewhere.

> +##
> +{ 'enum': 'QTLDRMsgBucketType',
> +  'data': ['error', 'command', 'event', 'log' ] }
> +
> +
> +##
> +# @QTLDRMsgBucketConfig:
> +#     Configuration for message buckets
> +#
> +# @type: the message bucket to enable

Blank line, please.

> +# @capacity: override the default bucket size, in bytes (64kb)

Let's use KiB.

> +#
> +# Each bucket allocates memory on demand, so capacity merely
> +# puts an upper limit on the memory usage in a bucket.  The
> +# capacity must be larger than the per-message size limit,
> +# which is 2048 bytes.
> +#
> +# Since: 11.2.0
> +##
> +{ 'struct': 'QTLDRMsgBucketConfig',
> +  'data': { 'type': 'QTLDRMsgBucketType',
> +            '*capacity': 'size' }
> +}
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5f96257cef0..da9d1e2b7bd 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -6685,6 +6685,8 @@ SRST
>=20=20
>=20=20
>      ``-object tldr-config,id=3Did,crash-target=3Dpath``
> +        \
> +    ``-object "{'qom-type':'tldr-config','id':'tldr','crash-target':'foo=
','messages':[{'type':'BUCKET','capacity':BYTES}]}"``
>          Creating the ``tldr-config`` object enables the thrifty live data
>          recorder, which continuously captures important information about
>          the operation of the QEMU process. When a SIGSEGV, SIGBUS,
> @@ -6695,6 +6697,12 @@ SRST
>          The ``tldr-dump`` QMP command can also be used at any time to
>          save the captured data to an arbitrary file.
>=20=20
> +        The data recorder will capture upto 64kb of data by default in
> +        each bucket, but when using the JSON syntax for ``-object``, this
> +        can be tailored with the ``messages`` parameter. ``BUCKET`` takes
> +        one of ``error``, ``command``, ``event``, or ``log`` and the
> +        capacity value is in bytes.

JSON only because -object still uses QemuOpts for KEY=3DVALUE,...
arguments.  Arrays can be done with QemuOpts, but it's not worth the
bother here.

> +
>          The ``tldr-config`` object can be added at initial startup
>          or via QMP at runtime. Once created, however, it is not
>          permitted to disable it.

[...]


