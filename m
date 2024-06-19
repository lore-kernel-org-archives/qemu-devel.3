Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2769FC2BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 12:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJuke-0005c2-VK; Wed, 19 Jun 2024 08:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJukd-0005al-8B
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 08:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJuka-0008Nz-LU
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 08:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718801359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WIcJKdJudu0F60frY9jZpg/H6w4MwarPvlfgSAPNQyE=;
 b=ONkVTaSKl7qdaqhDNGcdCcVWAi/UR2cVizWDBCm73SAZFYAwWou2u580EOpe8AcgqYvgg3
 zxJrhUkK92q2a9x5x68t6cwIGRvi0Q3BkBbAfmcTR+m4G11GRNR+UY2rquGYbJYGOexr0u
 xwLw+EVMV3NSwpxjG/oAFLRxOvL32pw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-WoZC2M1CN9W0nT-9_HJXdw-1; Wed,
 19 Jun 2024 08:49:16 -0400
X-MC-Unique: WoZC2M1CN9W0nT-9_HJXdw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B18D81955DCE; Wed, 19 Jun 2024 12:49:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 833AA19560AF; Wed, 19 Jun 2024 12:49:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 40A4821E6757; Wed, 19 Jun 2024 14:49:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Victor Toso de
 Carvalho <victortoso@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Marcel
 Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Fabiano Rosas <farosas@suse.de>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Mads Ynddal <mads@ynddal.dk>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Peter Xu <peterx@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Jason
 Wang <jasowang@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,  Jiri Pirko <jiri@resnulli.us>,  Alex Williamson
 <alex.williamson@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH 09/13] qapi: convert "Note" sections to plain rST
In-Reply-To: <20240619003012.1753577-10-jsnow@redhat.com> (John Snow's message
 of "Tue, 18 Jun 2024 20:30:08 -0400")
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-10-jsnow@redhat.com>
Date: Wed, 19 Jun 2024 14:49:07 +0200
Message-ID: <87wmmlyu64.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
> consistent in rendered HTML documentation.
>
> Update docs/devel/qapi-code-gen.rst to reflect the new paradigm, and ...
>
> ... Update the QAPI parser to prohibit "Note" sections while suggesting

Scratch "... ..." and downcase "Update"?

> a new syntax. The exact formatting to use is a matter of taste, but a
> good candidate is simply:
>
> .. note:: lorem ipsum ...
>
> ... but there are other choices, too. The Sphinx readthedocs theme
> offers theming for the following forms (capitalization unimportant); all
> are adorned with a (!) symbol in the title bar for rendered HTML docs.
>
> See
> https://sphinx-rtd-theme.readthedocs.io/en/stable/demo/demo.html#admonitions
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
> directives. ".. admonition:: notes" is used in a few places where we had
> an ordered list of multiple notes that would not make sense as
> standalone/separate admonitions.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com> [for block*.json]

[...]

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index b3de1fb6b3a..57598331c5c 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -422,8 +422,9 @@
>  # Returns: GuestFsfreezeStatus ("thawed", "frozen", etc., as defined
>  #     below)
>  #
> -# Note: This may fail to properly report the current state as a result
> -#     of some other guest processes having issued an fs freeze/thaw.
> +# .. note:: This may fail to properly report the current state as a
> +#    result of some other guest processes having issued an fs
> +#    freeze/thaw.
>  #
>  # Since: 0.15.0
>  ##
> @@ -443,9 +444,9 @@
>  #
>  # Returns: Number of file systems currently frozen.
>  #
> -# Note: On Windows, the command is implemented with the help of a
> -#     Volume Shadow-copy Service DLL helper.  The frozen state is
> -#     limited for up to 10 seconds by VSS.
> +# .. note:: On Windows, the command is implemented with the help of a
> +#    Volume Shadow-copy Service DLL helper.  The frozen state is limited
> +#    for up to 10 seconds by VSS.
>  #
>  # Since: 0.15.0
>  ##
> @@ -479,10 +480,10 @@
>  #
>  # Returns: Number of file systems thawed by this call
>  #
> -# Note: if return value does not match the previous call to
> -#     guest-fsfreeze-freeze, this likely means some freezable
> -#     filesystems were unfrozen before this call, and that the
> -#     filesystem state may have changed before issuing this command.
> +# .. note:: If return value does not match the previous call to
> +#    guest-fsfreeze-freeze, this likely means some freezable filesystems
> +#    were unfrozen before this call, and that the filesystem state may
> +#    have changed before issuing this command.
>  #
>  # Since: 0.15.0
>  ##
> @@ -560,8 +561,8 @@
>  # Errors:
>  #     - If suspend to disk is not supported, Unsupported
>  #
> -# Notes: It's strongly recommended to issue the guest-sync command
> -#     before sending commands when the guest resumes
> +# .. note:: It's strongly recommended to issue the guest-sync command
> +#    before sending commands when the guest resumes.
>  #
>  # Since: 1.1
>  ##
> @@ -596,8 +597,8 @@
>  # Errors:
>  #     - If suspend to ram is not supported, Unsupported
>  #
> -# Notes: It's strongly recommended to issue the guest-sync command
> -#     before sending commands when the guest resumes
> +# .. note:: It's strongly recommended to issue the guest-sync command
> +#    before sending commands when the guest resumes.
>  #
>  # Since: 1.1
>  ##
> @@ -631,8 +632,8 @@
>  # Errors:
>  #     - If hybrid suspend is not supported, Unsupported
>  #
> -# Notes: It's strongly recommended to issue the guest-sync command
> -#     before sending commands when the guest resumes
> +# .. note:: It's strongly recommended to issue the guest-sync command
> +#    before sending commands when the guest resumes.
>  #
>  # Since: 1.1
>  ##
> @@ -1461,16 +1462,15 @@
>  #     * POSIX: as defined by os-release(5)
>  #     * Windows: contains string "server" or "client"
>  #
> -# Notes: On POSIX systems the fields @id, @name, @pretty-name,
> -#     @version, @version-id, @variant and @variant-id follow the
> -#     definition specified in os-release(5). Refer to the manual page
> -#     for exact description of the fields.  Their values are taken
> -#     from the os-release file.  If the file is not present in the
> -#     system, or the values are not present in the file, the fields
> -#     are not included.
> +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,
> +#    @version, @version-id, @variant and @variant-id follow the
> +#    definition specified in os-release(5). Refer to the manual page for
> +#    exact description of the fields.  Their values are taken from the
> +#    os-release file.  If the file is not present in the system, or the
> +#    values are not present in the file, the fields are not included.
>  #
> -#     On Windows the values are filled from information gathered from
> -#     the system.
> +#    On Windows the values are filled from information gathered from
> +#    the system.

Please don't change the indentation here.  I get the same output with

  @@ -1461,7 +1462,7 @@
   #     * POSIX: as defined by os-release(5)
   #     * Windows: contains string "server" or "client"
   #
  -# Notes: On POSIX systems the fields @id, @name, @pretty-name,
  +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,
   #     @version, @version-id, @variant and @variant-id follow the
   #     definition specified in os-release(5). Refer to the manual page
   #     for exact description of the fields.  Their values are taken


>  #
>  # Since: 2.10
>  ##
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index dfd6a6c5bee..53b06a94508 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -548,6 +548,21 @@ def get_doc(self) -> 'QAPIDoc':
>                          r'(Returns|Errors|Since|Notes?|Examples?|TODO): *',
>                          line):
>                      # tagged section
> +
> +                    # TODO: Remove this error sometime in 2025 or so
> +                    # after we've fully transitioned to the new qapidoc
> +                    # generator.
> +
> +                    # See commit message for more markup suggestions O:-)
> +                    if 'Note' in match.group(1):
> +                        emsg = (
> +                            f"The '{match.group(1)}' section is no longer "
> +                            "supported. Please use rST's '.. note::' or "
> +                            "'.. admonition:: notes' directives, or another "
> +                            "suitable admonition instead."
> +                        )
> +                        raise QAPIParseError(self, emsg)
> +
>                      doc.new_tagged_section(self.info, match.group(1))
>                      text = line[match.end():]
>                      if text:
> diff --git a/tests/qapi-schema/doc-empty-section.err b/tests/qapi-schema/doc-empty-section.err
> index 5f03a6d733f..711a0d629c2 100644
> --- a/tests/qapi-schema/doc-empty-section.err
> +++ b/tests/qapi-schema/doc-empty-section.err
> @@ -1 +1 @@
> -doc-empty-section.json:6: text required after 'Note:'
> +doc-empty-section.json:6: text required after 'Errors:'
> diff --git a/tests/qapi-schema/doc-empty-section.json b/tests/qapi-schema/doc-empty-section.json
> index f3384e9a3bb..f179d3eff6d 100644
> --- a/tests/qapi-schema/doc-empty-section.json
> +++ b/tests/qapi-schema/doc-empty-section.json
> @@ -3,6 +3,6 @@
>  ##
>  # @foo:
>  #
> -# Note:
> +# Errors:
>  ##
>  { 'command': 'foo', 'data': {'a': 'int'} }
> diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
> index 8b39eb946af..4b338cc0186 100644
> --- a/tests/qapi-schema/doc-good.json
> +++ b/tests/qapi-schema/doc-good.json
> @@ -29,7 +29,7 @@
>  # - Second list
>  #   Note: still in list
>  #
> -# Note: not in list
> +# .. note:: not in list

Uh...  see [*] below.

>  #
>  # 1. Third list
>  #    is numbered
> @@ -157,7 +157,7 @@
>  # @cmd-feat1: a feature
>  # @cmd-feat2: another feature
>  #
> -# Note: @arg3 is undocumented
> +# .. note:: @arg3 is undocumented
>  #
>  # Returns: @Object
>  #
> @@ -165,7 +165,7 @@
>  #
>  # TODO: frobnicate
>  #
> -# Notes:
> +# .. admonition:: Notes
>  #
>  #  - Lorem ipsum dolor sit amet
>  #  - Ut enim ad minim veniam
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
> index 435f6e6d768..2c9b4e419cb 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -76,7 +76,7 @@ Not in list
>  - Second list
>    Note: still in list
>  
> -Note: not in list

[*] This demonstrates the "Note: ..." is *not* recognized as a "Note"
section before the patch (compare to the change we get for recognized
sections below).

Obscure fact: the doc parser recognizes tagged sections *only* in
definition documentation.  Arguably a misfeature.

Your series makes the misfeature even more obscure, because afterwards,
the only tagged section left that could make sense in a free-form doc
comment is "TODO".  Let's not worry about the misfeature now.

Two sensible solutions:

1. Since the patch converts tagged sections, and this isn't, don't touch
it.  If you feel you want to mention this in the commit message, go
ahead.

2. Touch it anyway.  Do mention it in the commit message then.

> +.. note:: not in list
>  
>  1. Third list
>     is numbered
> @@ -169,15 +169,17 @@ description starts on the same line
>  a feature
>      feature=cmd-feat2
>  another feature
> -    section=Note
> -@arg3 is undocumented
> +    section=None
> +.. note:: @arg3 is undocumented
>      section=Returns
>  @Object
>      section=Errors
>  some
>      section=TODO
>  frobnicate
> -    section=Notes
> +    section=None
> +.. admonition:: Notes
> +
>   - Lorem ipsum dolor sit amet
>   - Ut enim ad minim veniam
>  
> diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
> index 847db70412d..b89f35d5476 100644
> --- a/tests/qapi-schema/doc-good.txt
> +++ b/tests/qapi-schema/doc-good.txt
> @@ -17,7 +17,9 @@ Not in list
>  
>  * Second list Note: still in list
>  
> -Note: not in list
> +Note:
> +
> +  not in list
>  
>  1. Third list is numbered
>  
> @@ -193,11 +195,9 @@ Features
>  "cmd-feat2"
>     another feature
>  
> +Note:
>  
> -Note
> -~~~~
> -
> -"arg3" is undocumented
> +  "arg3" is undocumented
>  
>  
>  Returns
> @@ -211,9 +211,7 @@ Errors
>  
>  some
>  
> -
> -Notes
> -~~~~~
> +Notes:
>  
>  * Lorem ipsum dolor sit amet
>  
> diff --git a/tests/qapi-schema/doc-interleaved-section.json b/tests/qapi-schema/doc-interleaved-section.json
> index adb29e98daa..b26bc0bbb79 100644
> --- a/tests/qapi-schema/doc-interleaved-section.json
> +++ b/tests/qapi-schema/doc-interleaved-section.json
> @@ -10,7 +10,7 @@
>  #
>  #           bao
>  #
> -# Note: a section.
> +# Returns: a section.
>  #
>  # @foobar: catch this
>  #

"Returns:" is only valid for commands, and this is a struct.  Let's use
"TODO:" instead.


