Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1FFFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHcuD-0004LE-DM; Tue, 28 Apr 2026 03:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wHcuB-0004Kz-8b
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wHcu8-00023j-Q6
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777361447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v6uJegLKT1EjOoAY0MDWl/EcvoQWxENZwzLh21yY00Y=;
 b=hc08chPXmzjpzFMgUIDyAwfZKAEMQg+2frcOyhFtZLU/YBahlgqF91a+bQsXzEfqo/9hO8
 PZ9mhFXq2v9buhsl0uRvrb5b4h8Ky54xc41qG7mkDv5zJwrKD8Nm1NVvrW3WZMruOcM32y
 jR8WfSNJXYaawNzPzauvZ42Jnvsoa2I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-6XY1BxBPOq6dwY_JKHD1lw-1; Tue,
 28 Apr 2026 03:30:43 -0400
X-MC-Unique: 6XY1BxBPOq6dwY_JKHD1lw-1
X-Mimecast-MFC-AGG-ID: 6XY1BxBPOq6dwY_JKHD1lw_1777361441
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D80161956080; Tue, 28 Apr 2026 07:30:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 569B13000C22; Tue, 28 Apr 2026 07:30:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E009721E6A28; Tue, 28 Apr 2026 09:30:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v5 2/2] ui/gtk: Turn clipboard flag into runtime option
In-Reply-To: <20260427-gtk-clipboard-v5-2-6968feb31a5d@gmail.com>
 (=?utf-8?Q?=22Jind=C5=99ich=09Makovi=C4=8Dka=22's?= message of "Mon, 27 Apr
 2026 22:06:44 +0200")
References: <20260427-gtk-clipboard-v5-0-6968feb31a5d@gmail.com>
 <20260427-gtk-clipboard-v5-2-6968feb31a5d@gmail.com>
Date: Tue, 28 Apr 2026 09:30:37 +0200
Message-ID: <87340f5yoy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Jind=C5=99ich Makovi=C4=8Dka <makovick@gmail.com> writes:

> - Compile the GTK clipboard support unconditionally
>
> - Introduce GTK clipboard option, defaulting to off

Should the patch be split?

> Signed-off-by: Jindrich Makovicka <makovick@gmail.com>

[...]

> diff --git a/qapi/ui.json b/qapi/ui.json
> index e3da77632a..b2c42a7f57 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1319,6 +1319,9 @@
>  #
>  # GTK display options.
>  #
> +# @clipboard: Enable host-guest clipboard sharing.  Defaults to "off".
> +#     (Since 11.1)
> +#

Educate ignorant me: what does it mean to share the clipboard?

>  # @grab-on-hover: Grab keyboard input on mouse hover.
>  #
>  # @zoom-to-fit: Zoom guest display to fit into the host window.  When
> @@ -1344,7 +1347,8 @@
>  # Since: 2.12
>  ##
>  { 'struct'  : 'DisplayGTK',
> -  'data'    : { '*grab-on-hover'     : 'bool',
> +  'data'    : { '*clipboard'         : 'bool',
> +                '*grab-on-hover'     : 'bool',
>                  '*zoom-to-fit'       : 'bool',
>                  '*show-tabs'         : 'bool',
>                  '*show-menubar'      : 'bool',
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 21972f8326..e780bc2ac0 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2209,9 +2209,9 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
>      "            [,window-close=3Don|off]\n"
>  #endif
>  #if defined(CONFIG_GTK)
> -    "-display gtk[,full-screen=3Don|off][,gl=3Don|off][,grab-on-hover=3D=
on|off]\n"
> -    "            [,show-tabs=3Don|off][,show-cursor=3Don|off][,window-cl=
ose=3Don|off]\n"
> -    "            [,show-menubar=3Don|off][,zoom-to-fit=3Don|off]\n"
> +    "-display gtk[,clipboard=3Don|off][,full-screen=3Don|off][,gl=3Don|o=
ff]\n"
> +    "            [,grab-on-hover=3Don|off][,show-tabs=3Don|off][,show-cu=
rsor=3Don|off]\n"
> +    "            [,window-close=3Don|off][,show-menubar=3Don|off][,zoom-=
to-fit=3Don|off]\n"
>  #endif
>  #if defined(CONFIG_VNC)
>      "-display vnc=3D<display>[,<optargs>]\n"
> @@ -2295,6 +2295,9 @@ SRST
>          drop-down menus and other UI elements to configure and control
>          the VM during runtime. Valid parameters are:
>=20=20
> +        ``clipboard=3Don|off`` : Enable host-guest clipboard sharing,
> +                               defaults to "off"
> +
>          ``full-screen=3Don|off`` : Start in fullscreen mode
>=20=20
>          ``gl=3Don|off`` : Use OpenGL for displaying

[...]


