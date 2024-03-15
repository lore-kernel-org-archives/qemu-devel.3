Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF196C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 06:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl0jK-00017k-5D; Fri, 15 Mar 2024 02:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl0j5-0000vg-Dt
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 02:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl0j3-0007vt-9A
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 02:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710482848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RY4Yk72aFv3Y2uvea1HZuSf4K7y9l/pb9OIVp8Kgxw8=;
 b=Rqwqd5Z1+flSfldbfdMhgRaGbl0W5hszW8oYM/wNbXr2ffdKMHjxClMdTazoSB++cv4nEx
 Y5riY8TcK5SOQJr8UHnnyuh1Cl5vvNN/757z3M40zHhLtrcn0ZeYUAUl6VxEVgwiWSIQ+V
 zvJWENUjsgh91qFCaVv7iVXlkSGEJVA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-CroS8c_kPViHXyD0Db-RDw-1; Fri, 15 Mar 2024 02:07:21 -0400
X-MC-Unique: CroS8c_kPViHXyD0Db-RDw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67040811E81;
 Fri, 15 Mar 2024 06:07:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41057492BD1;
 Fri, 15 Mar 2024 06:07:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3AA7A21E6A24; Fri, 15 Mar 2024 07:07:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Justinien Bouron <justinien.bouron@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Eric Blake
 <eblake@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] input-linux: Add option to not grab a device upon guest
 startup
In-Reply-To: <20240307062823.2377318-1-justinien.bouron@gmail.com> (Justinien
 Bouron's message of "Wed, 6 Mar 2024 22:28:22 -0800")
References: <20240307062823.2377318-1-justinien.bouron@gmail.com>
Date: Fri, 15 Mar 2024 07:07:20 +0100
Message-ID: <875xxoni3r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Justinien Bouron <justinien.bouron@gmail.com> writes:

> Depending on your use-case, it might be inconvenient to have qemu grab
> the input device immediately upon starting the guest, especially if the
> guest takes a while to start in which case it may take a few seconds
> before being able to release the device via the toggle combination.
>
> Added a new bool option to input-linux: grab-on-startup. If true, the
> device is grabbed as soon as the guest is started, otherwise it is not
> grabbed until the toggle combination is entered. To avoid breaking
> existing setups, the default value of grab-on-startup is true, ie. same
> behaviour as before this change.
>
> Signed-off-by: Justinien Bouron <justinien.bouron@gmail.com>
> ---
>  qapi/qom.json    | 13 ++++++++++++-
>  ui/input-linux.c | 20 +++++++++++++++++++-
>  2 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 032c6fa037..50e66d55cc 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -508,13 +508,24 @@
>  # @grab-toggle: the key or key combination that toggles device grab
>  #     (default: ctrl-ctrl)
>  #
> +# @grab-on-startup: if true, grab the device immediately upon starting the
> +#     guest. Otherwise, don't grab the device until the combination is entered.
> +#     This does not influence other devices even if grab_all is true, ie. in the

i.e.

> +#     unlikely scenario where device1 has grab_all=true + grab-on-startup=true
> +#     and device2 has grab-on-startup=false, only device1 is grabbed on startup,
> +#     then, once the grab combination is entered, grabbing is toggled off for
> +#     both devices (because device1 enforces the grab_all property) until the
> +#     combination is entered again at which point both devices will be grabbed.
> +#     (default: true).

From docs/devel/qapi-code-gen.rst section Documentation markup:

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.

> +

No blank lines in the middle of comment blocks, please.

>  # Since: 2.6
>  ##

Together:

   # @grab-on-startup: if true, grab the device immediately upon starting
   #     the guest.  Otherwise, don't grab the device until the
   #     combination is entered.  This does not influence other devices
   #     even if grab_all is true, i.e. in the unlikely scenario where
   #     device1 has grab_all=true + grab-on-startup=true and device2 has
   #     grab-on-startup=false, only device1 is grabbed on startup, then,
   #     once the grab combination is entered, grabbing is toggled off
   #     for both devices (because device1 enforces the grab_all
   #     property) until the combination is entered again at which point
   #     both devices will be grabbed.  (default: true).
   #
   # Since: 2.6
   ##

>  { 'struct': 'InputLinuxProperties',
>    'data': { 'evdev': 'str',
>              '*grab_all': 'bool',
>              '*repeat': 'bool',
> -            '*grab-toggle': 'GrabToggleKeys' } }
> +            '*grab-toggle': 'GrabToggleKeys',
> +            '*grab-on-startup': 'bool'} }
>  
>  ##
>  # @EventLoopBaseProperties:

[...]


