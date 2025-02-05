Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97342C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 08:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfar4-0006qb-58; Wed, 05 Feb 2025 03:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfar2-0006px-6Z
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 03:33:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfar0-00069C-Im
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 03:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738744429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qH/m51XVthpjm9SYz7hSVI8Zsi765LQs9GR/J2m/E0M=;
 b=btLBjWNQ9j/M6rcc49hOa1AOxiFMDzcn58k4ACohdJMuPYbv1Ne7NXqCBkKnv2bqnwVKEI
 90RMLzdXSxH1TVXfiZwbIr96WcsDnnCjMpWByYiKbNO1Xhi6mX5WJkow+8FNLd//puXcYE
 Brh23LLlx997WKevAyK/WrBB9xeIOkE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-pPNqTCRmObK1XEirPEpZ5g-1; Wed,
 05 Feb 2025 03:33:47 -0500
X-MC-Unique: pPNqTCRmObK1XEirPEpZ5g-1
X-Mimecast-MFC-AGG-ID: pPNqTCRmObK1XEirPEpZ5g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E2E71800268
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2025 08:33:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D32D9195608D
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2025 08:33:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A7D0921E6A28; Wed, 05 Feb 2025 09:33:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH] dbus: add -audio dbus nsamples option
In-Reply-To: <20250128120559.729221-1-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Tue, 28 Jan 2025 16:05:59 +0400")
References: <20250128120559.729221-1-marcandre.lureau@redhat.com>
Date: Wed, 05 Feb 2025 09:33:43 +0100
Message-ID: <87msf04wpk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Allow to set the number of audio samples per read/write to dbus.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/audio.json      | 22 +++++++++++++++++++++-
>  audio/dbusaudio.c    | 21 ++++++++++++++++++---
>  ui/dbus-display1.xml | 12 ++++++++++++
>  3 files changed, 51 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/audio.json b/qapi/audio.json
> index 519697c0cd..dd5a58d13e 100644
> --- a/qapi/audio.json
> +++ b/qapi/audio.json
> @@ -65,6 +65,26 @@
>      '*in':  'AudiodevPerDirectionOptions',
>      '*out': 'AudiodevPerDirectionOptions' } }
>=20=20
> +##
> +# @AudiodevDBusOptions:
> +#
> +# Options of the D-Bus audio backend.
> +#
> +# @in: options of the capture stream
> +#
> +# @out: options of the playback stream
> +#
> +# @nsamples: set the number of samples per read/write calls (default to =
480,
> +# 10ms at 48kHz).

Markup error.  This is rendered like

    "nsamples": "int" (optional)
       set the number of samples per read/write calls (default to 480,

    10ms at 48kHz).

Fix:

   # @nsamples: set the number of samples per read/write calls
   #     (default to 480, 10ms at 48kHz).

I'm not sure I understand the parenthesis.  I guess it means default
value is 480 samples per read/write call, which translates to 10ms when
sampling at 48kHz.  Correct?

> +#
> +# Since: 10.0
> +##
> +{ 'struct': 'AudiodevDBusOptions',
> +  'data': {
> +    '*in':  'AudiodevPerDirectionOptions',
> +    '*out': 'AudiodevPerDirectionOptions',
> +    '*nsamples': 'uint32'} }
> +

Could use 'base': 'AudiodevGenericOptions' instead of duplicating @in
and @out, but that would deviate from all the other AudiodevFOOOptions.
I agree with your decision.

>  ##
>  # @AudiodevAlsaPerDirectionOptions:
>  #
> @@ -490,7 +510,7 @@
>                     'if': 'CONFIG_AUDIO_ALSA' },
>      'coreaudio': { 'type': 'AudiodevCoreaudioOptions',
>                     'if': 'CONFIG_AUDIO_COREAUDIO' },
> -    'dbus':      { 'type': 'AudiodevGenericOptions',
> +    'dbus':      { 'type': 'AudiodevDBusOptions',
>                     'if': 'CONFIG_DBUS_DISPLAY' },
>      'dsound':    { 'type': 'AudiodevDsoundOptions',
>                     'if': 'CONFIG_AUDIO_DSOUND' },

[...]


