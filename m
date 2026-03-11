Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F0C112580D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 13:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0JmQ-0001hF-Gw; Wed, 11 Mar 2026 09:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1w0JmP-0001h7-SI
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 09:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1w0JmO-00060h-2k
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 09:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773236352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MC+V3JVEYg6UoOP6g0yRdfXAg3mB9xEoG/Mba/DcIVs=;
 b=PT22sjXxtoCsH/4zMzNHjIJWI/x09XhtwsIHL3DeFdgiTEUetZufwzzUXir1z4BLGngrLj
 oEvjJYQur6wuEPWYRsWtBf/v3SYoEFhwv4s1HW//X+z8B/NvISHNyks7Nzd1x7yGgiIM1O
 0H2jUQ0YZeB+OY7k2ZnO485Oi5f9mtk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-4qAQ3NxBPL2I4m3r5AbubA-1; Wed,
 11 Mar 2026 09:39:09 -0400
X-MC-Unique: 4qAQ3NxBPL2I4m3r5AbubA-1
X-Mimecast-MFC-AGG-ID: 4qAQ3NxBPL2I4m3r5AbubA_1773236347
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79FE71956050; Wed, 11 Mar 2026 13:39:06 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EA9919560A6; Wed, 11 Mar 2026 13:39:01 +0000 (UTC)
Date: Wed, 11 Mar 2026 14:38:58 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track external
 user input
Message-ID: <abFwch8dksmk2kKV@angien.pipo.sk>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <877bricy97.fsf@pond.sub.org> <abFqwbCCf7rNDEWs@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <abFqwbCCf7rNDEWs@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
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

On Wed, Mar 11, 2026 at 13:14:41 +0000, Daniel P. Berrang=E9 via Devel wrot=
e:
> On Wed, Mar 11, 2026 at 02:05:24PM +0100, Markus Armbruster wrote:

[...]

> For -object / object_add  we introduced formal QAPI modelling of
> all Object subclasses which implement the UserCreatable interface.
> IIUC, that gives us the desired separation between internal and
> external views, as only properties declared in qapi/qom.json are
> publically settable.
>=20
> This work did not apply to the Device classes because the historical
> baggage with qdev being grafted onto qom, means we don't have that
> working via the UserCreatable inteface or -object/object_add.
>=20
> Can we bring Device into the same world though ?
>=20
> Adding 1000 device types to QAPI is a huge job, so it would need to
> be a long incremental job, unless perhaps we auto-generate QAPI
> descriptions for everything that already exists ?

When I was converting libvirt to use the JSON syntax for -device I've
used the output of -device DEVTYPE,? to figure out the required types.
=46rom what I've observed, in the vast majority of casesthe type that
qemu wants is already reported, thus generating the schema for it should
be feasible.

Obviously majority of the options lack any form of description so
documentation would be a much bigger problem, but there would be already
an starting point.

Anyways for anyone wanting to actually do this libvirt's qemuxmlconftest
suite could be useful here as it contains a sizable portion of options
libvirt supports (I'ts extremely likely that we don't cover some corner
cases though). In addition the testsuite can actually perform
validation of any of the commands taking JSON against the monitor schema,

To validate that everything that libvirt covers by tests is present in
the schema for 'device_add' one would need to just change 1 boolean (to
force full schema validation for device_add) and add a schema dump.


