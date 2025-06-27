Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A99C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 09:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV5lC-0001Zf-Lv; Fri, 27 Jun 2025 05:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uV5lA-0001ZA-47
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uV5l8-0006SC-0o
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751017956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EPgFLY5mOeVJ9I7NqfX9llmIJbcx6jupzJikb8SVHcM=;
 b=CZE6QOAkJjuYPkFh0hh6NutnbD6z/H9kVxZEuZe0bsNJ6tc1tD/Od9kDXzvHx/+WZTMF8Z
 LppUEIV3irEJ3Q8pPc9y/3Qlss/SqhhegIC8ZCBVVtLbRsVjhAkLrT06MTg4pIyUldR4c6
 sKroPQwMe6MscTTIIg7Zz2wT6SxvGkM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-IifSwPJDPe2E_2rts6mgEA-1; Fri,
 27 Jun 2025 05:52:32 -0400
X-MC-Unique: IifSwPJDPe2E_2rts6mgEA-1
X-Mimecast-MFC-AGG-ID: IifSwPJDPe2E_2rts6mgEA_1751017950
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D5D81801218; Fri, 27 Jun 2025 09:52:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 388FA30002C0; Fri, 27 Jun 2025 09:52:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EF57621E6A27; Fri, 27 Jun 2025 11:52:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Jiri Pirko <jiri@resnulli.us>,  Fan Ni
 <fan.ni@samsung.com>,  Stefano Garzarella <sgarzare@redhat.com>,  Michael
 Roth <michael.roth@amd.com>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-block@nongnu.org,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fabiano Rosas <farosas@suse.de>,  Kashyap Chamarthy
 <kchamart@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Ani
 Sinha <anisinha@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Alex Williamson <alex.williamson@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,  Jason Wang <jasowang@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v3 4/5] docs/sphinx: remove special parsing for freeform
 sections
In-Reply-To: <20250618165353.1980365-5-jsnow@redhat.com> (John Snow's message
 of "Wed, 18 Jun 2025 12:53:52 -0400")
References: <20250618165353.1980365-1-jsnow@redhat.com>
 <20250618165353.1980365-5-jsnow@redhat.com>
Date: Fri, 27 Jun 2025 11:52:22 +0200
Message-ID: <874iw1o6jt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

> This change removes special parsing for freeform sections and allows
> them to simply be unmodified rST syntax. The existing headings in the
> QAPI schema are adjusted to reflect the new paradigm.

"Allows them to" suggests the patch enables use of rST headings.  Is
this the case?  Or do they just work, and this patch just switches
schema code to use them, and drops now unnecessary generator code?
>
> Tests and documentation are updated to match.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

[...]

> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index 231cc0fecf7..dfdbeac5a5a 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -876,25 +876,35 @@ structuring content.
   Documentation comments
   ----------------------

   A multi-line comment that starts and ends with a ``##`` line is a
   documentation comment.

   If the documentation comment starts like ::

       ##
       # @SYMBOL:

   it documents the definition of SYMBOL, else it's free-form
   documentation.

   See below for more on `Definition documentation`_.

   Free-form documentation may be used to provide additional text and
   structuring content.


>  Headings and subheadings
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -A free-form documentation comment containing a line which starts with
> -some ``=`` symbols and then a space defines a section heading::
> +Free-form documentation does not start with ``@SYMBOL`` and can contain
> +arbitrary rST markup. Headings can be marked up using the standard rST
> +syntax::

Nothing stops you from using such markup in definition documentation.
It's probably a bad idea, though.

I think it's easiest not to talk about the two kinds of doc blocks here
at all.  Scratch the first sentence?

>  
>      ##
> -    # = This is a top level heading
> +    # *************************
> +    # This is a level 2 heading
> +    # *************************
>      #
>      # This is a free-form comment which will go under the
>      # top level heading.
>      ##
>  
>      ##
> -    # == This is a second level heading
> +    # This is a third level heading
> +    # ==============================
> +    #
> +    # Level 4
> +    # _______
> +    #
> +    # Level 5
> +    # ^^^^^^^
> +    #
> +    # Level 6
> +    # """""""
>      ##
>  
> -A heading line must be the first line of the documentation
> -comment block.
> -
> -Section headings must always be correctly nested, so you can only
> -define a third-level heading inside a second-level heading, and so on.
> +Level 1 headings are reserved for use by the generated documentation
> +page itself, leaving level 2 as the highest level that should be used.
>  
>  
>  Documentation markup

[...]


