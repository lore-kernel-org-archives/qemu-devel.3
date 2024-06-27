Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68562C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMmbj-0001nC-RY; Thu, 27 Jun 2024 06:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sMmbh-0001mX-Na
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sMmbf-00033G-SQ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719485038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cKcr16G81EKQssoXRGb1ZjBzu53zhrpSIPEqjNiEmT4=;
 b=EKvCpS+nYSw37ZYM9uMKsBMRfMFxFfQVdJvft9XCn3dV5+rUcGMcxKx2SStgO7RCBCpd2G
 8kX5QNJXx4ofPhMDqEOhtd4nLDqFu9t/SwSTtPAQaG468OTiq0OQmVQNcQMdapEPcTalmu
 IsqJsYM2gv3xOipDJRGalv4gL1QMF9A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-jp_9otKCOAq285gTvaPR8g-1; Thu,
 27 Jun 2024 06:43:55 -0400
X-MC-Unique: jp_9otKCOAq285gTvaPR8g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87EA8195608C; Thu, 27 Jun 2024 10:43:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18BB4300021A; Thu, 27 Jun 2024 10:43:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02F3721E6693; Thu, 27 Jun 2024 12:43:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Mads Ynddal <mads@ynddal.dk>,  Jiri Pirko
 <jiri@resnulli.us>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Michael
 Roth <michael.roth@amd.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Alex
 Williamson <alex.williamson@redhat.com>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Victor Toso de Carvalho
 <victortoso@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  qemu-block@nongnu.org,
 Ani Sinha
 <anisinha@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Lukas Straub
 <lukasstraub2@web.de>,
 Igor Mammedov <imammedo@redhat.com>,  Jason Wang <jasowang@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Hanna Reitz <hreitz@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH v2 05/21] qapi/parser: preserve indentation in QAPIDoc
 sections
In-Reply-To: <20240626222128.406106-6-jsnow@redhat.com> (John Snow's message
 of "Wed, 26 Jun 2024 18:21:11 -0400")
References: <20240626222128.406106-1-jsnow@redhat.com>
 <20240626222128.406106-6-jsnow@redhat.com>
Date: Thu, 27 Jun 2024 12:43:47 +0200
Message-ID: <87ed8ihdi4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Change get_doc_indented() to preserve indentation on all subsequent text
> lines, and create a compatibility dedent() function for qapidoc.py that
> removes indentation the same way get_doc_indented() did.
>
> This is being done for the benefit of a new qapidoc generator which
> requires that indentation in argument and features sections are
> preserved.
>
> Prior to this patch, a section like this:
>
> ```
> @name: lorem ipsum
>    dolor sit amet
>      consectetur adipiscing elit
> ```
>
> would have its body text be parsed into:
>
> ```
> lorem ipsum
> dolor sit amet
>   consectetur adipiscing elit
> ```
>
> We want to preserve the indentation for even the first body line so that
> the entire block can be parsed directly as rST. This patch would now
> parse that segment into:
>
> ```
> lorem ipsum
>    dolor sit amet
>      consectetur adipiscing elit
> ```
>
> This is helpful for formatting arguments and features as field lists in
> rST, where the new generator will format this information as:
>
> ```
> :arg type name: lorem ipsum
>    dolor sit amet
>      consectetur apidiscing elit
> ```
>
> ...and can be formed by the simple concatenation of the field list
> construct and the body text. The indents help preserve the continuation
> of a block-level element, and further allow the use of additional rST
> block-level constructs such as code blocks, lists, and other such
> markup.
>
> This understandably breaks the existing qapidoc.py; so a new function is
> added there to dedent the text for compatibility. Once the new generator
> is merged, this function will not be needed any longer and can be
> dropped.

I'll restore this paragraph if you don't mind:

  I verified this patch changes absolutely nothing by comparing the
  md5sums of the QMP ref html pages both before and after the change, so
  it's certified inert. QAPI test output has been updated to reflect the
  new strategy of preserving indents for rST.

> Signed-off-by: John Snow <jsnow@redhat.com>
> [Edited commit message and code comments per review --js]

And I'll drop this line.

> Reviewed-by: Markus Armbruster <armbru@redhat.com>


