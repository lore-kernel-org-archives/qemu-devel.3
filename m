Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAB61098782
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3aCB-00042i-Fi; Fri, 20 Mar 2026 09:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3aBv-00041Z-Ru
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3aBu-0000A4-Dl
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774014425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J3B/mI3AOfHz1pvg363p95+BSCtprUWG6I8Zx2GmKJQ=;
 b=U54WLI9kqWO0mKcDHevMlADgQEF2mPGJuZe64kTCKEqwL2kaQk1opt3S9tkf1tEH0mRqiW
 HdK4hH0aK25iWzBPutjUgNEnV8s8huziZuT6+47g2iBOF76VQWKsVdLiwjSv0GqY1OTGwW
 c9nmLRY4+ncTWDa7ukIhU13i91E1uJM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-dW7BMhz6NI2DoQPAYSQZyw-1; Fri,
 20 Mar 2026 09:47:02 -0400
X-MC-Unique: dW7BMhz6NI2DoQPAYSQZyw-1
X-Mimecast-MFC-AGG-ID: dW7BMhz6NI2DoQPAYSQZyw_1774014419
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA127195DE1B; Fri, 20 Mar 2026 13:46:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAF081955D9F; Fri, 20 Mar 2026 13:46:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F27121E6937; Fri, 20 Mar 2026 14:46:47 +0100 (CET)
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
Subject: Re: [PATCH 2/8] qapi: prohibit 'details' sections between tagged
 sections
In-Reply-To: <20260316182608.148628-3-jsnow@redhat.com> (John Snow's message
 of "Mon, 16 Mar 2026 14:26:01 -0400")
References: <20260316182608.148628-1-jsnow@redhat.com>
 <20260316182608.148628-3-jsnow@redhat.com>
Date: Fri, 20 Mar 2026 14:46:47 +0100
Message-ID: <87pl4y62bc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> This patch prohibits plain documentation sections from appearing between
> "tagged" sections. The two existing uses of this pattern are patched
> out.
>
> This is being done primarily to ensure consistency between the source
> documents and the final, rendered HTML output. Because
> member/feature/returns/error sections will always appear in a visually
> grouped element in the HTML output, prohibiting plain paragraphs between
> those sections ensures ordering consistency between source and the final
> render.
>
> Additionally, prohibiting such "middle" text paragraphs allows us to
> classify all plain text sections as either "intro" or "details" sections,
> because these sections must either appear before structured/tagged
> sections ("intro") or afterwards ("details").
>
> This keeps the inlining algorithm simpler with fewer "splice" points
> when merging multiple documentation blocks.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/qom.json                   |  4 ++--
>  scripts/qapi/parser.py          | 17 +++++++++++++++++
>  tests/qapi-schema/doc-good.json |  4 ++--
>  tests/qapi-schema/doc-good.out  |  4 ++--
>  tests/qapi-schema/doc-good.txt  |  8 ++++----
>  5 files changed, 27 insertions(+), 10 deletions(-)

Missing: update to docs/devel/qapi-code-gen.rst.  Suggest to put in a
FIXME, so we don't forget.

Missing: negative test case for the new error.


