Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AA0ECD6CB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqDYX-00010v-Qp; Wed, 11 Feb 2026 11:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqDYR-0000yy-Cl
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:59:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqDYP-0000l4-3G
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770829142;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ox35IEfoWH6lG1wpTj79H5xCSdV7QC1Hgyvq14ub2o=;
 b=Hdd9nsb19QieOr3RrEAzOczQv3+z6jo0mWn3afGRN/UWO4BvoXYlHexgVx6d65jCFFDu6G
 jZleA6biZ0biBNzNnJA5YYBoO4WyrQ1eBRP+u/wAiaLObk1CWAJF+8w4tYndiroPqQxBfk
 PQ2hivcMVJSaJ2dfEbiJGyvdqhm3R/A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-9iIOudd9Paa5Zn8hM0HYjA-1; Wed,
 11 Feb 2026 11:58:59 -0500
X-MC-Unique: 9iIOudd9Paa5Zn8hM0HYjA-1
X-Mimecast-MFC-AGG-ID: 9iIOudd9Paa5Zn8hM0HYjA_1770829137
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB1901800378; Wed, 11 Feb 2026 16:58:56 +0000 (UTC)
Received: from redhat.com (unknown [10.45.227.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92AD818004AD; Wed, 11 Feb 2026 16:58:51 +0000 (UTC)
Date: Wed, 11 Feb 2026 16:58:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 14/21] hw/core/qdev-properties: allow qdev properties
 accept flags
Message-ID: <aYy1R-JQjZ-Y38Am@redhat.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-15-zhao1.liu@intel.com>
 <aYsAuFNQQvwYiLPI@redhat.com> <aYwv/mcUBXy9kUYZ@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYwv/mcUBXy9kUYZ@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 11, 2026 at 03:30:06PM +0800, Zhao Liu wrote:
> On Tue, Feb 10, 2026 at 09:56:08AM +0000, Daniel P. Berrangé wrote:
> > Date: Tue, 10 Feb 2026 09:56:08 +0000
> > From: "Daniel P. Berrangé" <berrange@redhat.com>
> > Subject: Re: [PATCH v2 14/21] hw/core/qdev-properties: allow qdev
> >  properties accept flags
> > 
> > On Tue, Feb 10, 2026 at 11:23:41AM +0800, Zhao Liu wrote:
> > > Update qdev property interfaces (qdev_property_add_static() and
> > > qdev_class_add_property()) to accept and pass 'ObjectPropertyFlags'.
> > > This enables marking qdev properties with flags such as DEPRECATED or
> > > INTERNAL.
> > > 
> > > To facilitate this at the definition level, extend the boolean and
> > > uint8_t property macros (as the examples) to accept variable arguments
> > > (VA_ARGS). This allows callers to optionally specify flags in the
> > > property definition.
> > > 
> > > Example:
> > > 
> > > DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF,
> > >                   .flags = OBJECT_PROPERTY_DEPRECATED),
> > 
> > In other places where we track deprecation in QEMU, we have not used
> > a boolean flag. Instead we have used a "const char *deprecation_note"
> > internally, which lets us provide a user facing message, to be printed
> > out in the warn_report, informing them what to do instead (either the
> > feature is entirely removed, or there is a better alternative). IMHO
> > we should be following the same pattern for properties, as it is much
> > more user friendly than just printing a totally generic message
> > "XXXX is deprecated, stop using it" 
> 
> Yes, rich deprecation hint is better. I think this still depends on
> USER_SET - distinguish internal/external or not :-(.
> 
> Since when we mark a property as deprecated, its code remains in the
> code tree, and internal calls should not trigger warnings. Deprecation
> hints are intended to reminder external users.

This depends on where you put the deprecation check. IIUC, all the user
facing codepaths for setting properties end up calling through
object_set_properties_from_qdict, but internal codepaths don't use that.

That method can check & emit the deprecation warnings, without us needing
any explicit tracking of "user set" - the use context is derived from the
codepath


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


