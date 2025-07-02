Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68DDC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 08:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWsbj-00081u-Uz; Wed, 02 Jul 2025 04:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWsbj-00081G-1z
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 04:14:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWsbg-0001Zk-80
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 04:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751444053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nc4IEC+itcR7vlJW47Ng2F8MYYWLbohqTkuJ3+oKUpk=;
 b=JnHgj1IKzLV9ydp5ejXm0mbr7yeHfxz6dDMhizTbGjvbpNUuyE8eJ3UOg51qLi7epk6yqG
 Lo/CxzoNvA34yY2XAGLF4YQobqH5zNW4wo2vdKvaSWcQj8c/ZHc+jNsHPR6OO872bORn58
 fp65pP431s2KcpPl9fflxQb9Zt/LSNQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-WX3UdlKSPhi8xjafLMZniQ-1; Wed,
 02 Jul 2025 04:14:10 -0400
X-MC-Unique: WX3UdlKSPhi8xjafLMZniQ-1
X-Mimecast-MFC-AGG-ID: WX3UdlKSPhi8xjafLMZniQ_1751444048
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 165671808984; Wed,  2 Jul 2025 08:14:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84F151800285; Wed,  2 Jul 2025 08:14:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 176E221E6A27; Wed, 02 Jul 2025 10:14:05 +0200 (CEST)
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
 Markus Armbruster <armbru@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,  qemu-block@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 17/18] qapi: add cross-references to yank.json
In-Reply-To: <20250613203620.1283814-18-jsnow@redhat.com> (John Snow's message
 of "Fri, 13 Jun 2025 16:36:19 -0400")
References: <20250613203620.1283814-1-jsnow@redhat.com>
 <20250613203620.1283814-18-jsnow@redhat.com>
Date: Wed, 02 Jul 2025 10:14:05 +0200
Message-ID: <87h5zvovqq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/yank.json | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/qapi/yank.json b/qapi/yank.json
> index 9bd8ecce27f..931d4b22d4b 100644
> --- a/qapi/yank.json
> +++ b/qapi/yank.json
> @@ -9,7 +9,7 @@
>  ##
>  # @YankInstanceType:
>  #
> -# An enumeration of yank instance types.  See @YankInstance for more
> +# An enumeration of `yank` instance types.  See `YankInstance` for more

A yank instance is not an instance of the yank command.

I think most instances of "yank" should be left alone.  I'm going to
flag the ones that should be made links to the yank command.

>  # information.
>  #
>  # Since: 6.0
> @@ -20,7 +20,7 @@
>  ##
>  # @YankInstanceBlockNode:
>  #
> -# Specifies which block graph node to yank.  See @YankInstance for
> +# Specifies which block graph node to `yank`.  See `YankInstance` for
>  # more information.
>  #
>  # @node-name: the name of the block graph node
> @@ -33,7 +33,7 @@
>  ##
>  # @YankInstanceChardev:
>  #
> -# Specifies which character device to yank.  See @YankInstance for
> +# Specifies which character device to `yank`.  See `YankInstance` for
>  # more information.
>  #
>  # @id: the chardev's ID
> @@ -46,20 +46,20 @@
>  ##
>  # @YankInstance:
>  #
> -# A yank instance can be yanked with the @yank qmp command to recover
> +# A `yank` instance can be yanked with the `yank` qmp command to recover

Keep the second `yank`.

>  # from a hanging QEMU.
>  #
> -# @type: yank instance type
> +# @type: `yank` instance type
>  #
> -# Currently implemented yank instances:
> +# Currently implemented `yank` instances:
>  #
>  # - nbd block device: Yanking it will shut down the connection to the
>  #   nbd server without attempting to reconnect.
>  # - socket chardev: Yanking it will shut down the connected socket.
>  # - migration: Yanking it will shut down all migration connections.
> -#   Unlike @migrate_cancel, it will not notify the migration process,
> +#   Unlike `migrate_cancel`, it will not notify the migration process,
>  #   so migration will go into @failed state, instead of @cancelled
> -#   state.  @yank should be used to recover from hangs.
> +#   state.  `yank` should be used to recover from hangs.

Keep.

>  #
>  # Since: 6.0
>  ##
> @@ -74,7 +74,7 @@
>  # @yank:
>  #
>  # Try to recover from hanging QEMU by yanking the specified instances.
> -# See @YankInstance for more information.
> +# See `YankInstance` for more information.
>  #
>  # @instances: the instances to be yanked
>  #
> @@ -100,7 +100,7 @@
>  ##
>  # @query-yank:
>  #
> -# Query yank instances.  See @YankInstance for more information.
> +# Query `yank` instances.  See `YankInstance` for more information.
>  #
>  #
>  # .. qmp-example::


