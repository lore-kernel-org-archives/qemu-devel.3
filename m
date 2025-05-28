Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6678C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLfT-000433-7x; Wed, 28 May 2025 14:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLfQ-00042c-IP
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:38:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLfN-00082g-Rn
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748457496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o0nOf++Ny/GkzikIxTRBsQ/5cIA2/bDGkDpZQUCz8Ds=;
 b=R0FnsI8V0Wri2McZ786ewqEtTUMdzqoqERtMsGjaW1JnIOr7CqNnQHBW0Lli/PFqH/VREZ
 DpwgrID0aQxzGmFkIj09/Xedk24wVuhgHPbFhAEvrLd0uIXCqyfS4SPzAtbvHbe0b4GLra
 0AIugE9Ui6FqTK+Kaop9Jt9ZalAo2Mw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-r-lLiWPcP4yr89d3eVf3NQ-1; Wed,
 28 May 2025 14:38:12 -0400
X-MC-Unique: r-lLiWPcP4yr89d3eVf3NQ-1
X-Mimecast-MFC-AGG-ID: r-lLiWPcP4yr89d3eVf3NQ_1748457490
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 047A11800570; Wed, 28 May 2025 18:38:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39D2319560A3; Wed, 28 May 2025 18:38:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0FCA21E6768; Wed, 28 May 2025 20:38:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Fan Ni <fan.ni@samsung.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Kashyap Chamarthy <kchamart@redhat.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  qemu-block@nongnu.org,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  Ani Sinha <anisinha@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Zhenwei Pi <pizhenwei@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Fabiano Rosas <farosas@suse.de>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Alex Williamson
 <alex.williamson@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Igor
 Mammedov <imammedo@redhat.com>,  "Gonglei (Arei)"
 <arei.gonglei@huawei.com>,  Eric Blake <eblake@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Michael Roth
 <michael.roth@amd.com>,  Yanan Wang <wangyanan55@huawei.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Lukas Straub
 <lukasstraub2@web.de>,
 Stefano Garzarella <sgarzare@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Mads Ynddal <mads@ynddal.dk>,  Konstantin
 Kostiuk <kkostiuk@redhat.com>,  Peter Xu <peterx@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Kevin Wolf <kwolf@redhat.com>,  Cleber
 Rosa <crosa@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH 1/3] docs: fix errors formatting in test-good
In-Reply-To: <20250522170219.58058-2-jsnow@redhat.com> (John Snow's message of
 "Thu, 22 May 2025 13:02:17 -0400")
References: <20250522170219.58058-1-jsnow@redhat.com>
 <20250522170219.58058-2-jsnow@redhat.com>
Date: Wed, 28 May 2025 20:38:04 +0200
Message-ID: <87iklkvawj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> If we remove the legacy parser, this formulation begins to fail because
> the body text is appended directly after the field list entry, which is
> invalid rST syntax.
>
> Markus: suggest where the new Exception(s) should go, if anywhere, and
> how to update the tests? I'm assuming deeply you'll want to.

I'm confused and out of time for the week.  Can you give me a bit more
context?

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qapi-schema/doc-good.json | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
> index 14b808f9090..6dcde8fd7e8 100644
> --- a/tests/qapi-schema/doc-good.json
> +++ b/tests/qapi-schema/doc-good.json
> @@ -165,7 +165,8 @@
>  #
>  # Returns: @Object
>  #
> -# Errors: some
> +# Errors:
> +#     - some
>  #
>  # TODO: frobnicate
>  #


