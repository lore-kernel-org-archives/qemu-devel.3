Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25DFC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 11:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR88Y-0002gd-2m; Mon, 16 Jun 2025 07:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uR88W-0002gM-8T
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 07:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uR88U-0006yD-3r
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 07:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750073777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UeH4punPiQ1fT2jxxrGg8VP5ycPbG2V1bxC+QqvNw7U=;
 b=MuOwXRkE6Ap8DAsxH/uENd4yQDZ/YCimPlhZcMLHLkLAR6AWJ8F9PeH6r0/kFdhzPXHvnm
 oEO9R4AeIXM4DxEUS/o4Uoha89gsg9PqCDr7OO1cbJ9ZL1VgbNE52hBgAxeIHvvQG/rkkF
 QqtjCF1p1PPWErGhx0uaqDdpQf3h9E4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-gAF3iO9kMgScsr7t83EmOw-1; Mon,
 16 Jun 2025 07:36:14 -0400
X-MC-Unique: gAF3iO9kMgScsr7t83EmOw-1
X-Mimecast-MFC-AGG-ID: gAF3iO9kMgScsr7t83EmOw_1750073771
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF93019560B2; Mon, 16 Jun 2025 11:36:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.11])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4E7F30044D6; Mon, 16 Jun 2025 11:36:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 31C5921E6A27; Mon, 16 Jun 2025 13:36:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhenwei Pi <pizhenwei@bytedance.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Jiri Pirko <jiri@resnulli.us>,  Ani
 Sinha <anisinha@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Mads
 Ynddal <mads@ynddal.dk>,  Zhao Liu <zhao1.liu@intel.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Kashyap Chamarthy <kchamart@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Hanna Reitz <hreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org,  Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Eric Blake <eblake@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,  Lukas Straub
 <lukasstraub2@web.de>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Fan Ni <fan.ni@samsung.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Kevin Wolf <kwolf@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Konstantin
 Kostiuk <kkostiuk@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 1/3] docs: fix errors formatting in
 tests/qapi-schema/doc-good
In-Reply-To: <20250612221051.1224565-2-jsnow@redhat.com> (John Snow's message
 of "Thu, 12 Jun 2025 18:10:49 -0400")
References: <20250612221051.1224565-1-jsnow@redhat.com>
 <20250612221051.1224565-2-jsnow@redhat.com>
Date: Mon, 16 Jun 2025 13:36:05 +0200
Message-ID: <87ecvjj4uy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> If we remove the legacy parser, the doc-good.json formatting begins to

"parser"?  You mean docs/sphinx/qapidoc_legacy.py, don't you?

> fail because the body text is appended directly after the field list
> entry, which is invalid rST syntax.

We've been running the test suite with the legacy doc generator.
Unwise; we should've switched to the new one right away.

> Without this change, we see this error:
>
> /home/jsnow/src/qemu/docs/../tests/qapi-schema/doc-good.json:169:
> WARNING: Field list ends without a blank line; unexpected
> unindent. [docutils]

The reporting is less than helpful.

> And this intermediate rST source:
>
> tests/qapi-schema/doc-good.json:0167 |    :error:
> tests/qapi-schema/doc-good.json:0168 |    some
>
> With this patch applied, we instead generate this source:
>
> tests/qapi-schema/doc-good.json:0167 |    :error:
> tests/qapi-schema/doc-good.json:0168 |        - some
>
> which compiles successfully.

Hmm.

As far as I can tell, the problem is lack of indentation[*].

By convention, the contents of an Errors: section is a list.
docs/devel/qapi-code-gen.rst:

    "Errors" sections should be formatted as an rST list, each entry
    detailing a relevant error condition.  For example::

     # Errors:
     #     - If @device does not exist, DeviceNotFound
     #     - Any other error returns a GenericError.

This test case is the only instance of something else.

It's just a convention, though.

Your change to the positive test case makes some sense all the same; it
should cover how we want the thing to be used.

What I don't like is how the new doc generator fails when we fail to
adhere to the convention.

Here's docs/devel/qapi-code-gen.rst on tagged sections:

    A tagged section begins with a paragraph that starts with one of the
    following words: "Since:", "Returns:", "Errors:", "TODO:".  It ends with
    the start of a new section.

    The second and subsequent lines of tagged sections must be indented
    like this::

     # TODO: Ut enim ad minim veniam, quis nostrud exercitation ullamco
     #     laboris nisi ut aliquip ex ea commodo consequat.
     #
     #     Duis aute irure dolor in reprehenderit in voluptate velit esse
     #     cillum dolore eu fugiat nulla pariatur.

This tells us that

    # Errors: some

and

    # Errors:
    #     some

and

    # Errors: some
    #     more

should all work, just like for any other tag.  However, only the second
one works in my testing.  With qapidoc_legacy.py, all three work.

We can make Errors: unlike the other tags.  But it needs to be done
properly, i.e. in scripts/qapi/parser.py (for decent error reporting),
and documented in docs/devel/qapi-code-gen.rst.

Keeping the QAPI domain accept what the generator generates might be
easier.

Thoughts?

>
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

Fails "make check".  Fixup appended.



[*] Evidence:

    # Errors:
    #     - some

which expands into

    :error:
        - some

and

    # Errors:
    #     some

which expands into

    :error:
        some

both work.

docs/devel/qapi-domain.rst:

    ``:error:``
    -----------

    Document the error condition(s) of a QAPI command.

    :availability: This field list is only available in the body of the
                   Command directive.
--> :syntax: ``:error: Lorem ipsum dolor sit amet ...``
    :type: `sphinx.util.docfields.Field
           <https://pydoc.dev/sphinx/latest/sphinx.util.docfields.Field.html?private=1>`_

    The format of the :errors: field list description is free-form rST. The
    alternative spelling ":errors:" is also permitted, but strictly
    analogous.

    Example::

       .. qapi:command:: block-job-set-speed
          :since: 1.1

          Set maximum speed for a background block operation.

          This command can only be issued when there is an active block job.

          Throttling can be disabled by setting the speed to 0.

          :arg string device: The job identifier.  This used to be a device
              name (hence the name of the parameter), but since QEMU 2.7 it
              can have other values.
          :arg int speed: the maximum speed, in bytes per second, or 0 for
              unlimited.  Defaults to 0.
-->       :error:
-->           - If no background operation is active on this device,
-->             DeviceNotActive

This makes me expect

    :error: some

also works.  However, the obvious

    # Errors: some

produces

    :error:
    some

which doesn't work.


diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index dc8352eed4..3711cf5480 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -176,7 +176,7 @@ another feature
     section=Returns
 @Object
     section=Errors
-some
+    - some
     section=Todo
 frobnicate
     section=Plain
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index 17a1d56ef1..e54cc95f4a 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -207,7 +207,7 @@ Returns
 Errors
 ~~~~~~
 
-some
+* some
 
 Notes:
 


