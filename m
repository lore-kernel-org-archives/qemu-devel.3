Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC91EA3F2F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpkG1-0008Eb-CC; Tue, 10 Feb 2026 04:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vpkFz-0008E3-K8
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:42:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vpkFy-0005rm-8P
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770716525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nXM62eXkBi23bRJDPrGwARHPhLF2TU1/UR/eSTskVlk=;
 b=G/wbIuz6bjMAcTLldRu+IuXyTFLJPKzKfUHMnkGaAUeg9sS/QWm0n6aN5aR+btvHtd5fIV
 o8pBMmz1m8xW68Mtv88FCDHOgRstASUvjA4g8IUDmS89LW590Ne5C9eOrdrWYQ+RZUll33
 bh8hvEFiLNTjR0v80FwwFuidYM9Mptg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-NxcLfZ9tPfmJL9vGugel_A-1; Tue,
 10 Feb 2026 04:42:02 -0500
X-MC-Unique: NxcLfZ9tPfmJL9vGugel_A-1
X-Mimecast-MFC-AGG-ID: NxcLfZ9tPfmJL9vGugel_A_1770716520
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E183B19560A5; Tue, 10 Feb 2026 09:41:59 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D64B30001A5; Tue, 10 Feb 2026 09:41:53 +0000 (UTC)
Date: Tue, 10 Feb 2026 10:41:50 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
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
Subject: Re: [PATCH v2 14/21] hw/core/qdev-properties: allow qdev properties
 accept flags
Message-ID: <aYr9Xnt0Qq38dDhv@angien.pipo.sk>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-15-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210032348.987549-15-zhao1.liu@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 10, 2026 at 11:23:41 +0800, Zhao Liu wrote:
> Update qdev property interfaces (qdev_property_add_static() and
> qdev_class_add_property()) to accept and pass 'ObjectPropertyFlags'.
> This enables marking qdev properties with flags such as DEPRECATED or
> INTERNAL.
> 
> To facilitate this at the definition level, extend the boolean and
> uint8_t property macros (as the examples) to accept variable arguments
> (VA_ARGS). This allows callers to optionally specify flags in the
> property definition.
> 
> Example:
> 
> DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF,
>                   .flags = OBJECT_PROPERTY_DEPRECATED),

Is there a plan to expose at least the _DEPRECATED property to be
introspectable (e.g. via qom-list-properties or device-list-properties)
?

In libvirt we try to stay proactive about adapting to deprecations and
this would allow our test-suite to detect deprecations programmaticaly
similarly to how we detect deprecations via query-qmp-schema. Although
with the current patchset there doesn't seem to be anything that libvirt
would need to adapt to.


