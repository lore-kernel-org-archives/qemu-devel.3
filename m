Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0367C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 07:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTzLR-00061t-Sp; Wed, 17 Jul 2024 03:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sTzLH-00060Q-Hw
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 03:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sTzLF-0002jb-RC
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 03:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721202288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CHjgb3X51NIFyj9+4/vrjGqcn8gX6tT80eEWXOvkheo=;
 b=YwZ4RzmcHmnWwvgtCocDe7BYblUngVia/MeV+ip2WfQAv7G+nyRW3CMSaQ2hydL7H54LbA
 JOzyhqFmWyO3Rycxe3wBc1ez8lIAj1m0IS21STPUhq81eyZeazQ4H7ayODsMrPhWI8u4NA
 2gPRl7SEW87m2itubNzEZBFDqg9I2XU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-1X_TY1pTPdWn3AbCLzkjYg-1; Wed,
 17 Jul 2024 03:44:01 -0400
X-MC-Unique: 1X_TY1pTPdWn3AbCLzkjYg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C26B41955D45; Wed, 17 Jul 2024 07:43:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63681195605A; Wed, 17 Jul 2024 07:43:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 216A721E668E; Wed, 17 Jul 2024 09:43:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter Xu <peterx@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,
 qemu-block@nongnu.org,  Lukas Straub <lukasstraub2@web.de>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Eric Blake <eblake@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Mads Ynddal
 <mads@ynddal.dk>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Michael Roth <michael.roth@amd.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Alex Williamson
 <alex.williamson@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 6/9] qapi: convert "Example" sections without titles
In-Reply-To: <20240717021312.606116-7-jsnow@redhat.com> (John Snow's message
 of "Tue, 16 Jul 2024 22:13:08 -0400")
References: <20240717021312.606116-1-jsnow@redhat.com>
 <20240717021312.606116-7-jsnow@redhat.com>
Date: Wed, 17 Jul 2024 09:43:55 +0200
Message-ID: <87ttgoh39g.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Use the no-option form of ".. qmp-example::" to convert any Examples
> that do not have any form of caption or explanation whatsoever. Note
> that in a few cases, example sections are split into two or more
> separate example blocks. This is only done stylistically to create a
> delineation between two or more logically independent examples.
>
> See commit-3: "docs/qapidoc: create qmp-example directive", for a
>               detailed explanation of this custom directive syntax.
>
> See commit+3: "qapi: remove "Example" doc section" for a detailed
>               explanation of why.
>
> Note: an empty "TODO" line was added to announce-self to keep the
> example from floating up into the body; this will be addressed more
> rigorously in the new qapidoc generator.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

[...]

> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index 4d40c88876c..ab7116680b3 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json

[...]

> @@ -469,7 +469,7 @@
>  #
>  # Since: 9.1
>  #
> -# Example:
> +# ..qmp-example::

Lacks a space, output is messed up.  Can fix in my tree.

>  #
>  #     <- { "event": "GUEST_PVSHUTDOWN",
>  #          "timestamp": { "seconds": 1648245259, "microseconds": 893771 } }

[...]

R-by stands.


