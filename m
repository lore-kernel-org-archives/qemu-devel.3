Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5B2C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 13:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgO4J-0008OT-Uo; Fri, 07 Feb 2025 08:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tgO4E-0008MX-Nn
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 08:06:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tgO4A-0008BB-EV
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 08:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738933601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+/xEHSqNCYLGzlOdpZkl/FdgOJohjnC5Km7HHdqNE1U=;
 b=VuB5lGEA0FmmHomVuIrqL23vuCqLPmo76JP4jOkZqz5YDv/VBSlmhGQldlKLI9qCDJ4RqZ
 c2+y3jQ0mj368qZO4ZZeW7xohR5Q5QcNxk6amfDSBslb01cdE+brMNf7gV3fiCR6Xd2ZC1
 C+B4RTgIB9vgSXbEisnsP+z5XOknsyE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-XBNqVhAqOyyx6wCAtLvc5g-1; Fri,
 07 Feb 2025 08:06:37 -0500
X-MC-Unique: XBNqVhAqOyyx6wCAtLvc5g-1
X-Mimecast-MFC-AGG-ID: XBNqVhAqOyyx6wCAtLvc5g
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 772E71800871; Fri,  7 Feb 2025 13:06:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAA241800360; Fri,  7 Feb 2025 13:06:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6F65A21E6A28; Fri, 07 Feb 2025 14:06:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Daniel P. =?utf-8?Q?Berrang=EF=BF=BD?= <berrange@redhat.com>,  Paolo
 Bonzini
 <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Eduardo Habkost <eduardo@habkost.net>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  Shaoqin Huang <shahuang@redhat.com>,  Eric
 Auger <eauger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>,  Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org,  kvm@vger.kernel.org,  qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>,  Yi Lai <yi1.lai@intel.com>
Subject: Re: [RFC v2 3/5] i386/kvm: Support event with select & umask format
 in KVM PMU filter
In-Reply-To: <Z6TNMZbonWmsnyM7@intel.com> (Zhao Liu's message of "Thu, 6 Feb
 2025 22:54:41 +0800")
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <20250122090517.294083-4-zhao1.liu@intel.com>
 <87zfj01z8x.fsf@pond.sub.org> <Z6SG2NLxxhz4adlV@intel.com>
 <Z6SEIqhJEWrMWTU1@redhat.com> <878qqjqskm.fsf@pond.sub.org>
 <Z6TFr49Cnhe1s4/5@intel.com> <Z6TNMZbonWmsnyM7@intel.com>
Date: Fri, 07 Feb 2025 14:06:32 +0100
Message-ID: <87o6zdhpk7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Zhao Liu <zhao1.liu@intel.com> writes:

>> > Do users need to know how to compute the raw event value from @select
>> > and @umask?
>> 
>> Yes, because it's also a unified calculation. AMD and Intel have
>> differences in bits for supported select field, but this calculation
>> (which follows from the KVM code) makes both compatible.
>> 
>> > If yes, is C code the best way?
>
> Sorry, I missed this line. In this patch, there's macro:
>
> +#define X86_PMU_RAW_EVENT(eventsel, umask) (((eventsel & 0xf00UL) << 24) | \
> +                                            ((eventsel) & 0xff) | \
> +                                            ((umask) & 0xff) << 8)
>
> So could I said something like the following?
>
> +##
> +# @KVMPMUX86SelectUmaskEvent:
> +#
> +# x86 PMU event encoding with select and umask.  Using the X86_PMU_RAW_EVENT
> +# macro, the select and umask fields will be encoded into raw foramt and
> +# delivered to KVM.

Doc comments are for the QMP reference manual, i.e. for users of QMP.
Explaining the QMP interface in terms of its implementation in QEMU is
not nice.

> +#
> +# @select: x86 PMU event select field, which is a 12-bit unsigned
> +#     number.
> +#
> +# @umask: x86 PMU event umask field.
> +#
> +# Since 10.0
> +##
> +{ 'struct': 'KVMPMUX86DefalutEvent',
> +  'data': { 'select': 'uint16',
> +            'umask': 'uint8' } }
> +
>
> Thanks very much!
>
>> > Here's another way:
>> > 
>> >     bits  0..7 : bits 0..7 of @select
>> >     bits  8..15: @umask
>> >     bits 24..27: bits 8..11 of @select
>> >     all other bits: zero
>> >
>> 
>> Thank you! This is what I want.
>> 
>> 
>> 


