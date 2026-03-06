Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8F3F01814
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyRLx-0007eN-O3; Fri, 06 Mar 2026 04:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyRLv-0007c4-VO
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:20:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyRLp-0000ku-Td
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772788802;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/iE6Uz00m+Wd597RZDSF9kxAb6fhSW1vartUiW7H/T4=;
 b=WRViYgnGsCk5qdHwiXAumgTorAZMZ+KIWA2q6J9T8+ZaQ1+ndYCdP+utNnAxG+CB3Pc3Fd
 BR+iyk8ULQzy62lZ809Rt0neGoE7J9jWuScHZL6yXCVuBiaXo2bOG9yHXisUrlr8fs6GBN
 nrWPJ4wnPIswumKznsPlHx+n5Yy5WWg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-JXA58BYOMK2px65VziLKgw-1; Fri,
 06 Mar 2026 04:20:01 -0500
X-MC-Unique: JXA58BYOMK2px65VziLKgw-1
X-Mimecast-MFC-AGG-ID: JXA58BYOMK2px65VziLKgw_1772788799
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7DF2180044D; Fri,  6 Mar 2026 09:19:58 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.197])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C96E91800361; Fri,  6 Mar 2026 09:19:52 +0000 (UTC)
Date: Fri, 6 Mar 2026 09:19:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>,
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
Message-ID: <aaqcNeyNO2nmqEje@redhat.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-15-zhao1.liu@intel.com>
 <aYsAuFNQQvwYiLPI@redhat.com> <aYwv/mcUBXy9kUYZ@intel.com>
 <aYy1R-JQjZ-Y38Am@redhat.com> <20260218105120.5e55ad07@imammedo>
 <87seadjp5c.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87seadjp5c.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 06, 2026 at 10:14:23AM +0100, Markus Armbruster wrote:
> Igor Mammedov <imammedo@redhat.com> writes:
> 
> > I might be totally wrong, but occasionally I've considered using
> > object_set_properties_from_qdict() internally as much more compact form
> > compared to 'object_new()/set_this_property and set that one too' noodle.
> 
> Clear signal our C interface to QOM object configuration is lacking.
> 
> Going through a QDict is disgusting, though.  There has to be a more
> direct way.  One that doesn't involve building temporary trees just so
> we can use existing visitors.
> 
> What if we could pass the entire configuration as a struct?  Instead of
> setting properties one by one, pass a struct literal and be done.

Or we pass things as typed variadic args.

  object_new_args(TYPE_NAME,
                  "foo": someval,
		  "bar: otherval,
		  NULL);

we know the QAPI type for each named property, so we know how to
interpret type-correct values for each property in the var-args.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


