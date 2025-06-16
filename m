Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3693C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 12:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR8pz-0003CI-1Y; Mon, 16 Jun 2025 08:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uR8pw-0003BW-9v
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 08:21:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uR8pd-0005UN-WC
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 08:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750076455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Db0Ykx6d+vh661wn4PHwAaAWcaKkpRtDQ4t0NjAp5C4=;
 b=L1TAhmn5JafoKHOUP0/apJCnV3QAQ+AHSoUkhheDMclUqFYzZMV2PYqAijqW1UFiipY+KR
 UZ2KxHazc4bVfDu89770bWxFox3GYM+voPH+C5CiWt/RnDp1ZrGKZ5E4TD0xkYANwYta/t
 nUT43W0F7H/wXKkUHp/UZmuJc/aSRVs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-krdZ50PzPOeceVhp7DzxiA-1; Mon,
 16 Jun 2025 08:20:53 -0400
X-MC-Unique: krdZ50PzPOeceVhp7DzxiA-1
X-Mimecast-MFC-AGG-ID: krdZ50PzPOeceVhp7DzxiA_1750076450
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A47419560B5; Mon, 16 Jun 2025 12:20:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.11])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB69219560A3; Mon, 16 Jun 2025 12:20:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5020821E6A27; Mon, 16 Jun 2025 14:20:44 +0200 (CEST)
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
Subject: Re: [PATCH v2 2/3] docs: remove legacy QAPI manual generator
In-Reply-To: <20250612221051.1224565-3-jsnow@redhat.com> (John Snow's message
 of "Thu, 12 Jun 2025 18:10:50 -0400")
References: <20250612221051.1224565-1-jsnow@redhat.com>
 <20250612221051.1224565-3-jsnow@redhat.com>
Date: Mon, 16 Jun 2025 14:20:44 +0200
Message-ID: <87ldprho83.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> Thanks for your service!
>
> Remove the old qapidoc and the option to enable the transmogrifier,
> leaving the "transmogrifier" as the ONLY qapi doc generator. This in
> effect also converts the QAPI test to use the new documentation
> generator, too.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Fails "make check", because tests/qapi-schema/doc-good.txt needs an
update.

Unfortunately, the diff of the update is less than useful.  To make
sense of what changes, I split doc-good.txt into parts before and after,
and diffed those.


  diff -rupw o/01 n/01
  --- o/01	2025-06-16 13:53:05.036940854 +0200
  +++ n/01	2025-06-16 13:49:07.167435996 +0200
  @@ -1,11 +1,13 @@
   Section
   *******

  +Just text, no heading.
  +

Looks like a bug fix.  Needs a mention in the commit message then.

   Subsection
   ==========

  -*with emphasis* "var" {in braces}
  +*with emphasis* @var {in braces}

Rendering of @references changes.  Okay.

   * List item one

  @@ -35,4 +37,3 @@ Example:

   -> in <- out Examples: - *verbatim* - {braces}

  -
  diff -rupw o/02 n/02
  --- o/02	2025-06-16 13:53:17.133712123 +0200
  +++ n/02	2025-06-16 13:49:21.024174424 +0200
  @@ -1,32 +1,15 @@
  -"Enum" (Enum)
  --------------
  +Enum Enum
  +    *Availability*: "IFCOND"

  +   Values:
  +      * **one** -- The _one_ {and only}, description on the same line

  -Values
  -~~~~~~
  +      * **two** -- Not documented

  -"one" (**If: **"IFONE")

Member conditional is lost.  Known issue; see commit dbf51d15fdb.

  -   The _one_ {and only}, description on the same line
  +   Features:
  +      * **enum-feat** -- Also _one_ {and only}

  -"two"
  -   Not documented
  -
  -
  -Features
  -~~~~~~~~
  -
  -"enum-feat"
  -   Also _one_ {and only}
  -
  -"enum-member-feat"
  -   a member feature
  +      * **enum-member-feat** -- a member feature

   "two" is undocumented

  -
  -If
  -~~
  -
  -"IFCOND"
  -
  -
  diff -rupw o/03 n/03
  --- o/03	2025-06-16 13:53:27.556514971 +0200
  +++ n/03	2025-06-16 13:50:44.582595942 +0200
  @@ -1,17 +1,7 @@
  -"Base" (Object)
  ----------------
  -
  -
  -Members
  -~~~~~~~
  -
  -"base1": "Enum"
  -   description starts on a new line, minimally indented
  -
  -
  -If
  -~~
  -
  -"IFALL1 and IFALL2"
  +Object Base
  +    *Availability*: "IFALL1 and IFALL2"

  +   Members:
  +      * **base1** ("Enum") -- description starts on a new line,
  +        minimally indented

  diff -rupw o/04 n/04
  --- o/04	2025-06-16 13:53:39.356291772 +0200
  +++ n/04	2025-06-16 13:50:54.486408751 +0200
  @@ -1,5 +1,4 @@
  -"Variant1" (Object)
  --------------------
  +Object Variant1

   A paragraph

  @@ -7,21 +6,11 @@ Another paragraph

   "var1" is undocumented

  +   Members:
  +      * **var1** ("string") -- Not documented

  -Members
  -~~~~~~~
  -
  -"var1": "string" (**If: **"IFSTR")

Likewise.

  -   Not documented
  -
  -
  -Features
  -~~~~~~~~
  -
  -"variant1-feat"
  -   a feature
  -
  -"member-feat"
  -   a member feature
  +   Features:
  +      * **variant1-feat** -- a feature

  +      * **member-feat** -- a member feature

  diff -rupw o/05 n/05
  --- o/05	2025-06-16 13:53:43.429214731 +0200
  +++ n/05	2025-06-16 13:51:05.247205330 +0200
  @@ -1,4 +1,2 @@
  -"Variant2" (Object)
  --------------------
  -
  +Object Variant2

  diff -rupw o/06 n/06
  --- o/06	2025-06-16 13:53:48.461119551 +0200
  +++ n/06	2025-06-16 13:51:10.990096739 +0200
  @@ -1,19 +1,12 @@
  -"Object" (Object)
  ------------------
  +Object Object

  +   Members:
  +      * The members of "Base".

  -Members
  -~~~~~~~
  +      * When "base1" is "one": The members of "Variant1".

  -The members of "Base"
  -The members of "Variant1" when "base1" is ""one""
  -The members of "Variant2" when "base1" is ""two"" (**If: **"IFONE or
  -IFTWO")

Likewise.

  -
  -Features
  -~~~~~~~~
  -
  -"union-feat1"
  -   a feature
  +      * When "base1" is "two": The members of "Variant2".

  +   Features:
  +      * **union-feat1** -- a feature

  diff -rupw o/07 n/07
  --- o/07	2025-06-16 13:53:55.988977158 +0200
  +++ n/07	2025-06-16 13:51:16.869985559 +0200
  @@ -1,28 +1,13 @@
  -"Alternate" (Alternate)
  ------------------------
  +Alternate Alternate
  +    *Availability*: "not (IFONE or IFTWO)"

  +   Alternatives:
  +      * **i** ("int") -- description starts on the same line remainder
  +        indented the same "b" is undocumented

  -Members
  -~~~~~~~
  +      * **b** ("boolean") -- Not documented

  -"i": "int"
  -   description starts on the same line remainder indented the same "b"
  -   is undocumented
  -
  -"b": "boolean"
  -   Not documented
  -
  -
  -Features
  -~~~~~~~~
  -
  -"alt-feat"
  -   a feature
  -
  -
  -If
  -~~
  -
  -"not (IFONE or IFTWO)"
  +   Features:
  +      * **alt-feat** -- a feature


  diff -rupw o/08 n/08
  --- o/08	2025-06-16 13:54:11.692680115 +0200
  +++ n/08	2025-06-16 13:51:35.957624638 +0200
  @@ -1,47 +1,29 @@
   Another subsection
   ==================

  +Command cmd (Since: 2.10)

  -"cmd" (Command)
  ----------------
  +   Arguments:
  +      * **arg1** ("int") -- description starts on a new line, indented

  +      * **arg2** ("string", *optional*) -- description starts on the
  +        same line remainder indented differently

  -Arguments
  -~~~~~~~~~
  +      * **arg3** ("boolean") -- Not documented

  -"arg1": "int"
  -   description starts on a new line, indented
  +   Features:
  +      * **cmd-feat1** -- a feature

  -"arg2": "string" (optional)
  -   description starts on the same line remainder indented differently
  -
  -"arg3": "boolean"
  -   Not documented
  -
  -
  -Features
  -~~~~~~~~
  -
  -"cmd-feat1"
  -   a feature
  -
  -"cmd-feat2"
  -   another feature
  +      * **cmd-feat2** -- another feature

   Note:

     "arg3" is undocumented

  +   Return:
  +      "Object" -- "Object"

  -Returns
  -~~~~~~~
  -
  -"Object"
  -
  -
  -Errors
  -~~~~~~
  -
  +   Errors:
   * some

   Notes:
  @@ -68,10 +50,3 @@ Examples:
   Note::
      Ceci n'est pas une note

  -
  -Since
  -~~~~~
  -
  -2.10
  -
  -
  diff -rupw o/09 n/09
  --- o/09	2025-06-16 14:11:32.819939859 +0200
  +++ n/09	2025-06-16 13:51:43.469482599 +0200
  @@ -1,22 +1,14 @@
  -"cmd-boxed" (Command)
  ----------------------
  +Command cmd-boxed

   If you're bored enough to read this, go see a video of boxed cats

  +   Arguments:
  +      * The members of "Object".

  -Arguments
  -~~~~~~~~~
  +   Features:
  +      * **cmd-feat1** -- a feature

  -The members of "Object"
  -
  -Features
  -~~~~~~~~
  -
  -"cmd-feat1"
  -   a feature
  -
  -"cmd-feat2"
  -   another feature
  +      * **cmd-feat2** -- another feature

   Example::

  @@ -24,4 +16,3 @@ Example::

      <- ... has no title ...

  -
  diff -rupw o/10 n/10
  --- o/10	2025-06-16 14:11:35.771883514 +0200
  +++ n/10	2025-06-16 13:51:46.653422395 +0200
  @@ -1,14 +1,7 @@
  -"EVT_BOXED" (Event)
  --------------------
  +Event EVT_BOXED

  +   Members:
  +      * The members of "Object".

  -Arguments
  -~~~~~~~~~
  -
  -The members of "Object"
  -
  -Features
  -~~~~~~~~
  -
  -"feat3"
  -   a feature
  +   Features:
  +      * **feat3** -- a feature

The only unexpected change is the first hunk.


