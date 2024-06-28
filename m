Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17ABEC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 09:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN8H8-0003Vl-UT; Fri, 28 Jun 2024 05:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sN8H6-0003Um-8O
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sN8H4-00057d-4j
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719568329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hvqQNCK09Mna0+msWpnLGs1wnggU893LPWVcJEkXJ+U=;
 b=cTD6vuSOTV3RW9uk785RONRBXGKTsdRhdVS3nLBo2IbORe7qmRyhYrQXBw2zeZSErJwteO
 FOLRDbpu0fNRnCV0GmFfBgd7OTGau2u7gIJkyI+L5AAEAvFZWdVBDVGOKDrE80o8D0wVkJ
 VXyvPaseQcv7o28AxvJobv9E+jh0s+E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-knI2JirkPZKq2GwfM-7EKA-1; Fri,
 28 Jun 2024 05:52:05 -0400
X-MC-Unique: knI2JirkPZKq2GwfM-7EKA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A0FD19560B0; Fri, 28 Jun 2024 09:52:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F06E919560A3; Fri, 28 Jun 2024 09:51:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D422F21E668B; Fri, 28 Jun 2024 11:51:52 +0200 (CEST)
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
Subject: Re: [PATCH v2 10/21] qapi: convert "Note" sections to plain rST
In-Reply-To: <20240626222128.406106-11-jsnow@redhat.com> (John Snow's message
 of "Wed, 26 Jun 2024 18:21:16 -0400")
References: <20240626222128.406106-1-jsnow@redhat.com>
 <20240626222128.406106-11-jsnow@redhat.com>
Date: Fri, 28 Jun 2024 11:51:52 +0200
Message-ID: <87a5j5z96v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> We do not need a dedicated section for notes. By eliminating a specially
> parsed section, these notes can be treated as normal rST paragraphs in
> the new QMP reference manual, and can be placed and styled much more
> flexibly.
>
> Convert all existing "Note" and "Notes" sections to pure rST. As part of
> the conversion, capitalize the first letter of each sentence and add
> trailing punctuation where appropriate to ensure notes look sensible and
> consistent in rendered HTML documentation. Markup is also re-aligned to
> the de-facto standard of 3 spaces for directives.
>
> Update docs/devel/qapi-code-gen.rst to reflect the new paradigm, and
> update the QAPI parser to prohibit "Note" sections while suggesting a
> new syntax. The exact formatting to use is a matter of taste, but a good
> candidate is simply:
>
> .. note:: lorem ipsum ...
>    ... dolor sit amet ...
>    ... consectetur adipiscing elit ...
>
> ... but there are other choices, too. The Sphinx readthedocs theme
> offers theming for the following forms (capitalization unimportant); all
> are adorned with a (!) symbol (=EF=81=AA) in the title bar for rendered H=
TML
> docs.
>
> See
> https://sphinx-rtd-theme.readthedocs.io/en/stable/demo/demo.html#admoniti=
ons
> for examples of each directive/admonition in use.
>
> These are rendered in orange:
>
> .. Attention:: ...
> .. Caution:: ...
> .. WARNING:: ...
>
> These are rendered in red:
>
> .. DANGER:: ...
> .. Error:: ...
>
> These are rendered in green:
>
> .. Hint:: ...
> .. Important:: ...
> .. Tip:: ...
>
> These are rendered in blue:
>
> .. Note:: ...
> .. admonition:: custom title
>
>    admonition body text
>
> This patch uses ".. note::" almost everywhere, with just two "caution"
> directives. Several instances of "Notes:" have been converted to merely
> ".. note::" where appropriate, but ".. admonition:: notes" is used in a
> few places where we had an ordered list of multiple notes that would not
> make sense as standalone/separate admonitions.

I looked for hunks that don't 1:1 replace "Note:" or "Notes:" by
".. note::."  Findings:

* Two hunks replace by ".. caution::" instead.  Commit message got it.
  Good.

* Four hunks replace by ".. admonition:: notes", one of them as a test.
  Commit message got it.  Good.

* Three hunks split "Notes:" into multiple ".. note::".  Good, but could
  be mentioned in commit message.

* Two hunks drop "Note:", changing it into paragraph.  The paragraph
  merges into the preceding "Example" section.  Good, but should be
  mentioned in the commit message, or turned into a separate patch.

* One hunk adjusts a test case for the removal of the "Note:" tag.
  Good, but could be mentioned in the commit message.

Perhaps tweak the paragraph above:

  This patch uses ".. note::" almost everywhere, with just two "caution"
  directives. Several instances of "Notes:" have been converted to
  merely ".. note::", or multiple ".. note::" where appropriate.
  ".. admonition:: notes" is used in a few places where we had an
  ordered list of multiple notes that would not make sense as
  standalone/separate admonitions.  Two "Note:" following "Example:"
  have been turned into ordinary paragraphs within the example.

Okay?

> NOTE: Because qapidoc.py does not attempt to preserve source ordering of
> sections, the conversion of Notes from a "tagged section" to an
> "untagged section" means that rendering order for some notes *may
> change* as a result of this patch. The forthcoming qapidoc.py rewrite
> strictly preserves source ordering in the rendered documentation, so
> this issue will be rectified in the new generator.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com> [for block*.json]

I dislike the indentation changes, and may revert them in my tree.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


