Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48C0C8302F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 12:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWDhO-0007tk-58; Mon, 30 Jun 2025 08:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWDhH-0007rv-6J
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 08:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWDhA-0006Ej-4a
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 08:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751286787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQG9bwPM9BJpK6Gujs0rh6gqyVzr9jXwRpqSPvCv7UY=;
 b=hVGCFqKFGl3HEYLug6nhulzFUXAfs2XUhLRNm997pCerVsqMwCGuGO/itrvpfObYQFRRHR
 nl9WtYIc2LQcnBXegO+Nr38mvpdGUyDBeD+fnYAUnd9QripTJv1kv07qA24rXT4Y80pWWP
 W5MM8fHdNeNH38hawcQtU4jxf67t55Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-nQ1e-jAVPH-3J5kXNKG0KA-1; Mon,
 30 Jun 2025 08:33:03 -0400
X-MC-Unique: nQ1e-jAVPH-3J5kXNKG0KA-1
X-Mimecast-MFC-AGG-ID: nQ1e-jAVPH-3J5kXNKG0KA_1751286780
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27F75180029E; Mon, 30 Jun 2025 12:33:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F00B418003FC; Mon, 30 Jun 2025 12:32:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 61E4B21E6A27; Mon, 30 Jun 2025 14:32:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Jiri Pirko <jiri@resnulli.us>,  Fan
 Ni <fan.ni@samsung.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  "Gonglei (Arei)"
 <arei.gonglei@huawei.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,  Fabiano Rosas
 <farosas@suse.de>,  Kashyap Chamarthy <kchamart@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Igor Mammedov <imammedo@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,  Ani Sinha <anisinha@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>,  Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?=
 Le Goater <clg@redhat.com>,  Peter Xu <peterx@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Konstantin Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Alex Williamson
 <alex.williamson@redhat.com>,  Zhenwei Pi <pizhenwei@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,  Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v3 4/5] docs/sphinx: remove special parsing for freeform
 sections
In-Reply-To: <CAFn=p-ZkBt8ck7WWg_1FFBi5GoYmyEhVPZGfdL4ODN6GBn3YSw@mail.gmail.com>
 (John Snow's message of "Fri, 27 Jun 2025 12:49:53 -0400")
References: <20250618165353.1980365-1-jsnow@redhat.com>
 <20250618165353.1980365-5-jsnow@redhat.com>
 <874iw1o6jt.fsf@pond.sub.org>
 <CAFn=p-ZkBt8ck7WWg_1FFBi5GoYmyEhVPZGfdL4ODN6GBn3YSw@mail.gmail.com>
Date: Mon, 30 Jun 2025 14:32:56 +0200
Message-ID: <875xgd9zpj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> On Fri, Jun 27, 2025, 5:52=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This change removes special parsing for freeform sections and allows
>> > them to simply be unmodified rST syntax. The existing headings in the
>> > QAPI schema are adjusted to reflect the new paradigm.
>>
>> "Allows them to" suggests the patch enables use of rST headings.  Is
>> this the case?  Or do they just work, and this patch just switches
>> schema code to use them, and drops now unnecessary generator code?
>>
>
> Ehm... Kind of both? I guess I hadn't considered that rST headings might
> already work without the switch. I guess they didn't because of the
> headerless freeform section bug I fix in this series.

To double-check master, I use

diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.j=
son
index 14b808f909..201462688f 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -8,7 +8,9 @@
     'documentation-exceptions': [ 'Enum', 'Variant1', 'Alternate', 'cmd' ]=
 } }
=20
 ##
-# =3D Section
+# *******
+# Section
+# *******
 ##
=20
 ##

Doesn't work with the legacy doc generator:

    Exception occurred:
      File "/work/armbru/qemu/docs/sphinx/qapidoc_legacy.py", line 360, in =
_start_new_heading
        raise QAPISemError(self._cur_doc.info,
        ...<2 lines>...
                           % (level, level - 1))
    qapi.error.QAPISemError: /work/armbru/qemu/docs/../tests/qapi-schema/do=
c-good.json:20: Level 2 subheading found outside a level 1 heading

So switch to the new one:

diff --git a/tests/qapi-schema/doc-good.rst b/tests/qapi-schema/doc-good.rst
index 1e4c23305a..9978ac2e9c 100644
--- a/tests/qapi-schema/doc-good.rst
+++ b/tests/qapi-schema/doc-good.rst
@@ -3,3 +3,4 @@
    a plain-text output file and compare it against a reference.
=20
 .. qapi-doc:: tests/qapi-schema/doc-good.json
+   :transmogrify:

Chokes on "# Errors: some", you fix this (unrelated) bug in PATCH 1.  I
could apply that fix, but instead I simply work around the bug:

diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.j=
son
index 14b808f909..201462688f 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -165,7 +167,8 @@
 #
 # Returns: @Object
 #
-# Errors: some
+# Errors:
+#     some
 #
 # TODO: frobnicate
 #

The rST heading seems to work fine then.

The next-level heading

diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.j=
son
index 14b808f9090..fac13425b72 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -16,7 +18,8 @@
 ##
=20
 ##
-# =3D=3D Subsection
+# Subsection
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 #
 # *with emphasis*
 # @var {in braces}

doesn't:

    Extension error:
    /work/armbru/qemu/docs/../tests/qapi-schema/doc-good.json:22:1: '=3D' h=
eading must come first in a comment block

Removed in this patch.

So you're right, "kind of both": they work just fine with the new doc
generator, except for the "=3D=3D=3D=3D" rST headings, because the parser s=
till
recognizes them as old-style schema doc headings.

> I guess you're technically right, I just never thought of it in that way.
>
> I'll update the message so I don't confuse you in the future.

Yes, please.

[...]


