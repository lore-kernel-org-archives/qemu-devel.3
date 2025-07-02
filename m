Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29179C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 08:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWsYe-0006Mb-Kd; Wed, 02 Jul 2025 04:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWsYd-0006MI-AU
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 04:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWsYX-000145-9x
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 04:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751443858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tub+nsV35wYRfYdvKfpNw0kT5bQr8fYwfLx7zow7NOs=;
 b=hinWTxJXP0zjVMBkDSquJoJg3mSlMbHvKHr6uea1eEt3aAiWpo8EnixgNpauMmdoGxHOaF
 hF0Tm65STlNi6pAPIb+a8rc41rCIPR980Fy29KftKE5uCyWWYB8QTjCX4qdP19RUWype0+
 a6KYc5h6Wj0sHw124R2aYRAnI4YNGUQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-FgoJHIbyPRmin4RfqNzMcA-1; Wed,
 02 Jul 2025 04:10:55 -0400
X-MC-Unique: FgoJHIbyPRmin4RfqNzMcA-1
X-Mimecast-MFC-AGG-ID: FgoJHIbyPRmin4RfqNzMcA_1751443854
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B133195FCC8; Wed,  2 Jul 2025 08:10:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69F47195608F; Wed,  2 Jul 2025 08:10:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F040821E6A27; Wed, 02 Jul 2025 10:10:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Eric Blake <eblake@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?=
 <alex.bennee@linaro.org>,  Lukas Straub <lukasstraub2@web.de>,  Ani Sinha
 <anisinha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,  Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 15/18] qapi: add cross-references to ui.json
In-Reply-To: <20250613203620.1283814-16-jsnow@redhat.com> (John Snow's message
 of "Fri, 13 Jun 2025 16:36:17 -0400")
References: <20250613203620.1283814-1-jsnow@redhat.com>
 <20250613203620.1283814-16-jsnow@redhat.com>
Date: Wed, 02 Jul 2025 10:10:49 +0200
Message-ID: <87o6u3ovw6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/ui.json | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/qapi/ui.json b/qapi/ui.json
> index 7136c985c38..5bc54403cc2 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -39,7 +39,7 @@
>  ##
>  # @SetPasswordOptions:
>  #
> -# Options for set_password.
> +# Options for `set_password`.
>  #
>  # @protocol:
>  #     - 'vnc' to modify the VNC server password
> @@ -63,7 +63,7 @@
>  ##
>  # @SetPasswordOptionsVnc:
>  #
> -# Options for set_password specific to the VNC protocol.
> +# Options for `set_password` specific to the VNC protocol.
>  #
>  # @display: The id of the display where the password should be
>  #     changed.  Defaults to the first.
> @@ -94,7 +94,7 @@
>  ##
>  # @ExpirePasswordOptions:
>  #
> -# General options for expire_password.
> +# General options for `expire_password`.
>  #
>  # @protocol:
>  #     - 'vnc' to modify the VNC server expiration
> @@ -124,7 +124,7 @@
>  ##
>  # @ExpirePasswordOptionsVnc:
>  #
> -# Options for expire_password specific to the VNC protocol.
> +# Options for `expire_password` specific to the VNC protocol.
>  #
>  # @display: The id of the display where the expiration should be
>  #     changed.  Defaults to the first.
> @@ -183,7 +183,7 @@
>  #     the head can only be specified in conjunction with the device
>  #     ID.  (Since 2.12)
>  #
> -# @format: image format for screendump.  (default: ppm) (Since 7.1)
> +# @format: image format for `screendump`.  (default: ppm) (Since 7.1)

This is a link from a command argument back to the command.  Meh.  The
real issue is of course that the argument description is sub-par: "for
screendump" is entirely redundant.  Not for this patch to address.

Similarly crappy text descriptions may well exist elsewhere.  If we care
to clean them up, perhaps we can use "link to definition within the same
definition" to find them.

>  #
>  # Since: 0.14
>  #

[...]


