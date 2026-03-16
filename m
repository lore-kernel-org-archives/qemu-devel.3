Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E221CF53D6E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 15:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2A6x-0004iW-P4; Mon, 16 Mar 2026 11:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2A6w-0004iC-Rm
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 11:44:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2A6v-0002lt-2M
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 11:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773675844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0iWTyw6wvE3sDgiwGkCcIOYdTHac/Kwhv7oUWsOrlKU=;
 b=ECaDFp/GfjChq3BH3+wLrBDDDNJaxUwAd6T/h1jBf6D4YwUJHgGkHru5qaqlvIW5ulLdHJ
 eDHALReGAp2/Xm3Afi9a5F/Pv3K83UQS+ZrhsNfyF1oOFNmSYAYZHh77TjWb88vKlLbisd
 Yr+21NVnfCx/scCdAfVYrMgOpHn8tog=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-mFYgUmWNPYeGaonHlqpoMA-1; Mon,
 16 Mar 2026 11:44:00 -0400
X-MC-Unique: mFYgUmWNPYeGaonHlqpoMA-1
X-Mimecast-MFC-AGG-ID: mFYgUmWNPYeGaonHlqpoMA_1773675839
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7550F18005BD; Mon, 16 Mar 2026 15:43:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DD63180075B; Mon, 16 Mar 2026 15:43:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E5F0421E6937; Mon, 16 Mar 2026 16:43:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  BALATON Zoltan <balaton@eik.bme.hu>,  Mark Cave-Ayland
 <mark.caveayland@nutanix.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Zide Chen <zide.chen@intel.com>,  Dapeng
 Mi <dapeng1.mi@linux.intel.com>,  qemu-devel@nongnu.org,
 devel@lists.libvirt.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track
 external user input
In-Reply-To: <abFqwbCCf7rNDEWs@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 11 Mar 2026 13:14:41 +0000")
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <877bricy97.fsf@pond.sub.org> <abFqwbCCf7rNDEWs@redhat.com>
Date: Mon, 16 Mar 2026 16:43:54 +0100
Message-ID: <87tsufpyo5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Mar 11, 2026 at 02:05:24PM +0100, Markus Armbruster wrote:
>> I can't find a good spot in the existing discussion where the following
>> would fit neatly as a reply, so I'm starting at the top again.
>>=20
>> Fact: a huge part of our external interface is *accidental* and
>> virtually undocumented.
>>=20
>> The sane way to do an external interface is to layer it on top of more
>> powerful internal interfaces.  The external interface exposes just the
>> functionality that's wanted there.  The internal interfaces can evolve
>> without affecting the external one.
>>=20
>> QMP works that way.  QEMU code uses internal C interfaces.  QEMU doesn't
>> send QMP commands to itself.  If we need something internally, we add it
>> to a suitable internal interface.  There's no need to add it to the
>> external interface just for that.
>>=20
>> QOM does not work that way.  The internal and the external object
>> configuration interface is one and the same.  So, if we add a property
>> for internal use, we can't *not* add it to the external interface.
>>=20
>> This has led to an external interface that is frickin' huge: I count
>> ~1000 device types with ~16000 properties in qemu-system-aarch64 alone.
>> The vast majority is undocumented.
>>=20
>> Time and again we've found ourselves unsure whether certain properties
>> have external uses, or are even meant for external use.
>>=20
>> We have been unable / unwilling to isolate the external interface from
>> internal detail.  This is madness.
>>=20
>> As long as we persist in this madness, a sane, properly documented
>> external interface will remain impossible.
>>=20
>> Do we care?  If yes, we should discuss how to isolate external and
>> internal interfaces.
>>=20
>> This series attempts to create a bit of infrastructure for such
>> isolation: means to mark properties as internal.  Is it the right
>> infrastructure?  Is it enough to be a useful step?  Maybe not, but then
>> I'd like to hear better ideas.
>
> For -object / object_add  we introduced formal QAPI modelling of
> all Object subclasses which implement the UserCreatable interface.
> IIUC, that gives us the desired separation between internal and
> external views, as only properties declared in qapi/qom.json are
> publically settable.

Correct.  Kevin Wolf's work.

> This work did not apply to the Device classes because the historical
> baggage with qdev being grafted onto qom, means we don't have that
> working via the UserCreatable inteface or -object/object_add.
>
> Can we bring Device into the same world though ?

Kevin Wolf took a stab at it.  I had a hard time understanding it back
then.  Various pennies finally dropped when he patiently explained it to
me in person.  I disliked certain aspects of its design, and wanted to
explore a bit more.  Never found the time.  Perhaps we should just take
it despite my design misgivings.

> Adding 1000 device types to QAPI is a huge job, so it would need to
> be a long incremental job, unless perhaps we auto-generate QAPI
> descriptions for everything that already exists ?

Interesting idea.

QAPI is declarative: types and their properties are declared in a
schema.

QOM is imperative: we execute C code to create types and their
properties.

Extracting a QAPI schema from the C code is impossible in the completely
general case (halting problem), and merely impractical (I believe) in
the special cases we have.

We could start with QOM introspection instead: qom-list-types and
qom-list-properties.  These are only mostly complete, but should be good
enough.

Mapping QOM types to QAPI types would involve guesswork, because QOM
doesn't have a type system, it has strings and bailing wire.

Schema documentation would be placeholders at best.  We could try to
extract documentation from -device T,help.  Most properties have nothing
there, and the remainder likely needs to be rewritten completely to be
fit for purpose.

> More generally anything we can do to bring qdev & qom closer together
> feels desirable. I dream of a future where -device/device_add are
> obsolete....

That would be lovely.


