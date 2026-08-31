Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB721C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12Bw-0000qK-Cp; Mon, 31 Aug 2026 09:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x12Bt-0000pW-Pp
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x12Bs-00010L-8T
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788183407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WCs2Aq9tg9fBZkM3AoyGj6bTEL9C6nYwd+ohMUtyCFo=;
 b=RkLP37SWvgWrMSm5dxrKS2x0vTrnPeAzaAGtROiENug7Ngc9ZZ0SnaXrcBq08kQvztktxI
 VlveC+sGkG76Z3ZZjiGMfgQfNDkH4HPar828ZM5YZFWM+ZLx8pBNWesftLeQCzdCyor5y9
 s4BjrseROCaxOi+R8jevjV9G8iBa9FE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-p2frzGdJOeKlgdYB206L-A-1; Mon,
 31 Aug 2026 09:36:43 -0400
X-MC-Unique: p2frzGdJOeKlgdYB206L-A-1
X-Mimecast-MFC-AGG-ID: p2frzGdJOeKlgdYB206L-A_1788183399
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75A94183F9DB; Mon, 31 Aug 2026 13:36:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A0FA3000223; Mon, 31 Aug 2026 13:36:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 24F5821E6837; Mon, 31 Aug 2026 15:36:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex Williamson <alex@shazbot.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 linux-cxl@vger.kernel.org,  Michael
 Tokarev <mjt@tls.msk.ru>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,  qemu-trivial@nongnu.org,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Jonathan
 Cameron <jic23@kernel.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Zhao
 Liu <zhao1.liu@intel.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Lukas Straub
 <lukasstraub2@web.de>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 42/43] qapi: convert trivial intro sections for
 machine.json
In-Reply-To: <20260826193840.2152000-43-jsnow@redhat.com> (John Snow's message
 of "Wed, 26 Aug 2026 15:38:39 -0400")
References: <20260826193840.2152000-1-jsnow@redhat.com>
 <20260826193840.2152000-43-jsnow@redhat.com>
Date: Mon, 31 Aug 2026 15:36:34 +0200
Message-ID: <87pkyye7j1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/machine.json | 208 ++++++++++++++++------------------------------
>  1 file changed, 73 insertions(+), 135 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 2d63c1bac3b..3a5c6df9cff 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json

[...]

> @@ -469,8 +453,7 @@
>  
>  ##
>  # @NumaOptions:
> -#
> -# A discriminated record of NUMA options.  (for OptsVisitor)
> +#     A discriminated record of NUMA options.  (for OptsVisitor)
>  #
>  # @type: NUMA option type
>  #

The parenthesis is questionable.  As long as it's there, this isn't
"very trivial".

> @@ -488,8 +471,7 @@
>  
>  ##
>  # @NumaNodeOptions:
> -#
> -# Create a guest NUMA node.  (for OptsVisitor)
> +#     Create a guest NUMA node.  (for OptsVisitor)
>  #
>  # @nodeid: NUMA node ID (increase by 1 from 0 if omitted)
>  #

Likewise.


[...]

> @@ -1156,10 +1125,9 @@
>  
>  ##
>  # @BALLOON_CHANGE:
> -#
> -# Emitted when the guest changes the actual BALLOON level.  This value
> -# is equivalent to the @actual field return by the `query-balloon`
> -# command
> +#     Emitted when the guest changes the actual BALLOON level.  This
> +#     value is equivalent to the @actual field return by the
> +#     `query-balloon` command
>  #
>  # @actual: the logical size of the VM in bytes.  Formula used:
>  #     logical_vm_size = vm_ram_size - balloon_size

Two sentences, i.e. not "very trivial".

[...]


