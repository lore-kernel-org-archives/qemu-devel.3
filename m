Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6D6C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 07:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTzPR-0002WC-2D; Wed, 17 Jul 2024 03:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sTzPO-0002Tj-27
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 03:49:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sTzPM-0000ew-JH
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 03:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721202544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JNEdefjGcocfy5mLNpbxGVSV/h9bPFNGCSVJ6TepRno=;
 b=fODvod2Hnt+lGl4UqwswcO/M4xRFlJHFTl9lpusPFPIYP6zI9Lb3xe6O9VsVM0JDlF8bQQ
 Nee40rmTqD7q1ni8qT0yn6tiCEu5rhhxeeeSlgT1R13DNjXnxinIcpoo/fYiXD/cRfMb+A
 J2sHDmgpWwLMSrHaB6FfPzaSM4N+URU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-27MrBWhVN5-Kka2j8V-C4A-1; Wed,
 17 Jul 2024 03:48:59 -0400
X-MC-Unique: 27MrBWhVN5-Kka2j8V-C4A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0ADCA1956046; Wed, 17 Jul 2024 07:48:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DBE41955D42; Wed, 17 Jul 2024 07:48:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A989F21E668E; Wed, 17 Jul 2024 09:48:53 +0200 (CEST)
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
Subject: Re: [PATCH v2 9/9] qapi: remove "Example" doc section
In-Reply-To: <20240717021312.606116-10-jsnow@redhat.com> (John Snow's message
 of "Tue, 16 Jul 2024 22:13:11 -0400")
References: <20240717021312.606116-1-jsnow@redhat.com>
 <20240717021312.606116-10-jsnow@redhat.com>
Date: Wed, 17 Jul 2024 09:48:53 +0200
Message-ID: <87plrch316.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Fully eliminate the "Example" sections in QAPI doc blocks now that they
> have all been converted to arbitrary rST syntax using the
> ".. qmp-example::" directive. Update tests to match.
>
> Migrating to the new syntax
> ---------------------------
>
> The old "Example:" or "Examples:" section syntax is now caught as an
> error, but "Example::" is stil permitted as explicit rST syntax for an
> un-lexed, generic preformatted text block.
>
> ('Example' is not special in this case, any sentence that ends with "::"
> will start an indented code block in rST.)
>
> Arbitrary rST for Examples is now possible, but it's strongly
> recommended that documentation authors use the ".. qmp-example::"
> directive for consistent visual formatting in rendered HTML docs. The
> ":title:" directive option may be used to add extra information into the
> title bar for the example. The ":annotated:" option can be used to write
> arbitrary rST instead, with nested "::" blocks applying QMP formatting
> where desired.
>
> Other choices available are ".. code-block:: QMP" which will not create
> an "Example:" box, or the short-form "::" code-block syntax which will
> not apply QMP highlighting when used outside of the qmp-example
> directive.
>
> Why?
> ----
>
> This patch has several benefits:
>
> 1. Example sections can now be written more arbitrarily, mixing
>    explanatory paragraphs and code blocks however desired.
>
> 2. Example sections can now use fully arbitrary rST.
>
> 3. All code blocks are now lexed and validated as QMP; increasing
>    usability of the docs and ensuring validity of example snippets.
>
>    (To some extent - This patch only gaurantees it lexes correctly, not
>    that it's valid under the JSON or QMP grammars. It will catch most
>    small mistakes, however.)
>
> 4. Each qmp-example can be titled or annotated independently without
>    bypassing the QMP lexer/validator.
>
>    (i.e. code blocks are now for *code* only, so we don't have to
>    sacrifice exposition for having lexically valid examples.)
>
> NOTE: As with the "Notes" conversion (d461c279737), this patch (and the
>       three preceding) may change the rendering order for Examples in
>       the current generator. The forthcoming qapidoc rewrite will fix
>       this by always generating documentation in source order.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


