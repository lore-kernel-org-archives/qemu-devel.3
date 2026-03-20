Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0881098782
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3alU-0007lG-7W; Fri, 20 Mar 2026 10:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3alS-0007kI-9v
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3alQ-0007rc-5O
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774016626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ypjBfmHkuQGw7YJoI/kvdT9hLbpxcSvm+IXQKpR4aTU=;
 b=J42uLIIlVMD+bTUY9vTqFpCY5D01D8XlF/QT5F+l1fUWCHmHECEJf6nQbeod2+glOFrRwh
 UjSKJMkYUwyFsS3rTgf3pRmP6dHcGNHCAHdgSaMpnxWaiRDsl+KayxCOO8hInlQphsqJwz
 iwRt+xIRJRRSzAywXEKvACw/aYtRIB0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-14E9nArSPk-xcRM3jjFHsA-1; Fri,
 20 Mar 2026 10:23:42 -0400
X-MC-Unique: 14E9nArSPk-xcRM3jjFHsA-1
X-Mimecast-MFC-AGG-ID: 14E9nArSPk-xcRM3jjFHsA_1774016620
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E83ED1956056; Fri, 20 Mar 2026 14:23:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AF151800351; Fri, 20 Mar 2026 14:23:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ADD2621E6937; Fri, 20 Mar 2026 15:23:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>,  Richard Henderson
 <richard.henderson@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,  Jason
 Wang <jasowang@redhat.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Peter
 Xu <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  qemu-block@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau
 <marcandre.lureau@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Alex Williamson <alex@shazbot.org>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Yanan
 Wang <wangyanan55@huawei.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH 7/8] qapi: re-order 'since' sections to always be last
In-Reply-To: <20260316182608.148628-8-jsnow@redhat.com> (John Snow's message
 of "Mon, 16 Mar 2026 14:26:06 -0400")
References: <20260316182608.148628-1-jsnow@redhat.com>
 <20260316182608.148628-8-jsnow@redhat.com>
Date: Fri, 20 Mar 2026 15:23:36 +0100
Message-ID: <87y0jm4m1j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Note that with "Since" being moved to the last position, we open up a
> good many new cases of ambiguos intro-vs-details text which must be
> corrected with "Details:" tags.
>
> This patch doesn't only add these markers where it would definitively
> impact inlining - it adds them to *any* doc block that has more than one
> paragraph of plaintext and no other distinguishing features (members,
> features, errors, returns).
>
> It may well be the case that not every last one of these *needs* to be
> amended in this way, but this is the broad coverage shotgun approach
> that demonstrates which places in the code may cause footguns with
> regards to automated stub insertions of members/arguments/etc, returns,
> or inlining order ambiguities.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

[...]

> diff --git a/qapi/accelerator.json b/qapi/accelerator.json
> index d333a772384..5624b5d88b7 100644
> --- a/qapi/accelerator.json
> +++ b/qapi/accelerator.json
> @@ -29,12 +29,12 @@
>  #
>  # Return information about KVM acceleration
>  #
> -# Since: 0.14
> -#
>  # .. qmp-example::
>  #
>  #     -> { "execute": "query-kvm" }
>  #     <- { "return": { "enabled": true, "present": true } }
> +#
> +# Since: 0.14
>  ##
>  { 'command': 'query-kvm', 'returns': 'KvmInfo' }
>  

Rendered output changes unexpectedly from

    Command query-kvm (Since: 0.14)

       Return information about KVM acceleration

       Return:
          KvmInfo

       Example::

          -> { "execute": "query-kvm" }
          <- { "return": { "enabled": true, "present": true } }

to

    Command query-kvm (Since: 0.14)

       Return information about KVM acceleration

       Example::

          -> { "execute": "query-kvm" }
          <- { "return": { "enabled": true, "present": true } }

       Return:
          KvmInfo

I guess the "Since:" quietly serves as separator between INTRO and
DETAILS before the patch, and the patch is missing a DETAILS: line.

Several more instances follow.

[...]


