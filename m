Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8A5606A322
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eZuhLOhk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQMTu-0001ag-M9; Mon, 09 Nov 2026 05:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xQMTs-0001ZS-FQ
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 05:20:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xQMTq-0001Ju-SK
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 05:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794219601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g7PB2f4XYRuO519bdafPJquBGBH/fGZy2mxDuIuTL5g=;
 b=eZuhLOhklJxVSZCesUhQEf402KU6xXQoVftyfKpk8ROXyv/aLxWvHAPJDdvG7J+7hU278A
 caBVXKpIPM2Z4iV3YwaWUU6s+EJzeS6PBvXsa20yGtqLvkY2AJ90TeiVcXTMLU5sT26NKc
 vhAv+PEr0p3nbm+3kjUuwrbGbI3rrak=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-cHVZWLxVNRWI9A0EaZKB-A-1; Mon,
 09 Nov 2026 05:19:57 -0500
X-MC-Unique: cHVZWLxVNRWI9A0EaZKB-A-1
X-Mimecast-MFC-AGG-ID: cHVZWLxVNRWI9A0EaZKB-A_1794219596
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F307180055B; Mon,  9 Nov 2026 10:19:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73DF630000E5; Mon,  9 Nov 2026 10:19:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 19F2921E6A04; Mon, 09 Nov 2026 11:19:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com,
 milesg@linux.ibm.com,  qemu-ppc@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH 8/8] hw/gpio/pca955x: Simplify pin and led getters and
 setters
In-Reply-To: <291007a5-c42c-4efd-b4ef-3d11924c3944@nutanix.com> (Mark
 Cave-Ayland's message of "Mon, 9 Nov 2026 09:09:05 +0000")
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-9-armbru@redhat.com>
 <291007a5-c42c-4efd-b4ef-3d11924c3944@nutanix.com>
Date: Mon, 09 Nov 2026 11:19:53 +0100
Message-ID: <871p8u71di.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:

> On 06/11/2026 11:04, Markus Armbruster wrote:
>
>> Pass the index via object_class_property_add() parameter @opaque
>> instead extracting it from the property name.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>

[...]

> Interesting. I think I had a similar issue trying to get the index of a 
> gpio when converting one of the hw/adc devices. No objection here, but 
> we should try and be consistent about how we obtain the index in these 
> cases as I can see this coming up frequently.

Yes, consistency is desirable.

Permit me a digression.

QOM is designed to be maximally flexible, at the cost of extra
boilerplate.  It also enables different solutions to similar problems.

Consider properties.  Property accessors get passed the object and a
void *opaque.  Maximally flexible: the object is necessary, and @opaque
can be anything.  In practice, this pushes you towards writing one
bespoke getter/setter pair per property, ignoring @opaque.

When that becomes too cumbersome, people use @opaque however they see
fit.  For instance, the object_property_add_T_ptr() convenience
functions use it to pass a member offset.  But @opaque can be anything,
and this lets people get creative.

Qdev is different: accessors get passed a property descriptor (struct
Property), which (among other things) includes an @offset.  This pushes
you towards writing a single getter/setter pair per kind of property,
using @offset to access the object memory backing the property.  Less
flexible, less freedom, less boilerplate, more consistency.

Since qdev was rebased onto QOM, it uses @opaque to pass the property
descriptor through QOM to qdev accessors.

End of digression.

We should use @opaque for its intended purpose: pass whatever additional
information the getter/setter needs.  We should not abuse the property
name to pass such information.

object_class_property_add_enum() doesn't support @opaque.  Maybe it
should.

We don't have an object_class_property_add_enum_ptr().  Maybe we should.


