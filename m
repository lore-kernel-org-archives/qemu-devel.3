Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39B1F01818
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyRbU-0008PB-2v; Fri, 06 Mar 2026 04:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vyRbR-0008Ox-JW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:36:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vyRbP-0002a9-Op
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772789770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=FMt6DAxebeFGsJ3SRnbPlEhI9MCrsNrLTfLV9WYCPyA=;
 b=NT4wxIbfZVA6U8q/qOB3Pr9it9J6deRsrMBOmSWQ4D9tm5e1Cw/1OVgloHj3MPb1RV9CUG
 k+XG59KkSF7CcjUgaXBeg/lvq/j0fjSWB8pW30hTHyz+mnCDxbBS3kOKnArLV4w6MDSrwU
 1+kimTnm5MmyFs1WOqJ4HkV6IxBc7h0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-FKELRIajOFmHrCSOIVNqVQ-1; Fri,
 06 Mar 2026 04:36:07 -0500
X-MC-Unique: FKELRIajOFmHrCSOIVNqVQ-1
X-Mimecast-MFC-AGG-ID: FKELRIajOFmHrCSOIVNqVQ_1772789766
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80E0A1800464; Fri,  6 Mar 2026 09:36:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 863C91956095; Fri,  6 Mar 2026 09:36:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1BF4D21E6A04; Fri, 06 Mar 2026 10:36:02 +0100 (CET)
Resent-To: balaton@eik.bme.hu, eduardo@habkost.net, zhao1.liu@intel.com,
 zide.chen@intel.com, peter.maydell@linaro.org, philmd@linaro.org,
 pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 dapeng1.mi@linux.intel.com, devel@lists.libvirt.org,
 qemu-devel@nongnu.org, mark.caveayland@nutanix.com
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Fri, 06 Mar 2026 10:36:01 +0100
Resent-Message-ID: <87qzpxi9ku.fsf@pond.sub.org>
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
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 14/21] hw/core/qdev-properties: allow qdev properties
 accept flags
In-Reply-To: <aYy1R-JQjZ-Y38Am@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 11 Feb 2026 16:58:47 +0000")
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-15-zhao1.liu@intel.com>
 <aYsAuFNQQvwYiLPI@redhat.com> <aYwv/mcUBXy9kUYZ@intel.com>
 <aYy1R-JQjZ-Y38Am@redhat.com>
Date: Fri, 06 Mar 2026 10:30:04 +0100
Message-ID: <877brpjof7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

> On Wed, Feb 11, 2026 at 03:30:06PM +0800, Zhao Liu wrote:
>> On Tue, Feb 10, 2026 at 09:56:08AM +0000, Daniel P. Berrang=C3=A9 wrote:
>> > Date: Tue, 10 Feb 2026 09:56:08 +0000
>> > From: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
>> > Subject: Re: [PATCH v2 14/21] hw/core/qdev-properties: allow qdev
>> >  properties accept flags
>> >=20
>> > On Tue, Feb 10, 2026 at 11:23:41AM +0800, Zhao Liu wrote:
>> > > Update qdev property interfaces (qdev_property_add_static() and
>> > > qdev_class_add_property()) to accept and pass 'ObjectPropertyFlags'.
>> > > This enables marking qdev properties with flags such as DEPRECATED or
>> > > INTERNAL.
>> > >=20
>> > > To facilitate this at the definition level, extend the boolean and
>> > > uint8_t property macros (as the examples) to accept variable argumen=
ts
>> > > (VA_ARGS). This allows callers to optionally specify flags in the
>> > > property definition.
>> > >=20
>> > > Example:
>> > >=20
>> > > DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_=
DEF,
>> > >                   .flags =3D OBJECT_PROPERTY_DEPRECATED),
>> >=20
>> > In other places where we track deprecation in QEMU, we have not used
>> > a boolean flag. Instead we have used a "const char *deprecation_note"
>> > internally, which lets us provide a user facing message, to be printed
>> > out in the warn_report, informing them what to do instead (either the
>> > feature is entirely removed, or there is a better alternative). IMHO
>> > we should be following the same pattern for properties, as it is much
>> > more user friendly than just printing a totally generic message
>> > "XXXX is deprecated, stop using it"=20

Not entirely true.

QAPI/QMP uses special feature flag @deprecated, i.e. a boolean.

We cannot emit a "user facing message": QMP cannot transport warnings.
We could at best log one, in the hope that the user finds it.  But we
don't.

Instead the deprecation note is in the documentation.

The deprecation flag is visible in QAPI/QMP introspection.  Management
application developers need this; see Peter Krempa's reply.

QEMU can be configured to reject input that makes use of deprecated
stuff, and to hide deprecated stuff in output.  This is intended for
"testing the future".

>> Yes, rich deprecation hint is better. I think this still depends on
>> USER_SET - distinguish internal/external or not :-(.
>>=20
>> Since when we mark a property as deprecated, its code remains in the
>> code tree, and internal calls should not trigger warnings. Deprecation
>> hints are intended to reminder external users.
>
> This depends on where you put the deprecation check. IIUC, all the user
> facing codepaths for setting properties end up calling through
> object_set_properties_from_qdict, but internal codepaths don't use that.

This may well be true (I didn't check), but how can we ensure it remains
true?

> That method can check & emit the deprecation warnings, without us needing
> any explicit tracking of "user set" - the use context is derived from the
> codepath
>
>
> With regards,
> Daniel


