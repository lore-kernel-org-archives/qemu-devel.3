Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD40C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 13:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgO0a-0006U1-Ep; Fri, 07 Feb 2025 08:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tgO0Z-0006Sw-17
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 08:02:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tgO0V-0003pb-7D
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 08:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738933372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JewV+YyHcsdjAUqINIHy0lCtkJXQJZffAdLvcStJN+w=;
 b=NasUUcOsZwrw3MCw1nWppkXX9LxaCP1XvnkmbHpyOjs3IpWS/1AiqVfXg+osJ1Ma+s+1s1
 Sf9zyyDl4TZMeNPQ5II+YHIO3fM5jHzmYRXo0LDM2Eh5XBttKAnRaxa6kpXrs+ii8oNPum
 cUEE6QpIXXbqTHDf+dbiK0rBbLh6yCY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-ecTQ4cyJN7CaGoPy11B-QQ-1; Fri,
 07 Feb 2025 08:02:49 -0500
X-MC-Unique: ecTQ4cyJN7CaGoPy11B-QQ-1
X-Mimecast-MFC-AGG-ID: ecTQ4cyJN7CaGoPy11B-QQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77BA61800875; Fri,  7 Feb 2025 13:02:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF83D18004A7; Fri,  7 Feb 2025 13:02:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2283221E6A28; Fri, 07 Feb 2025 14:02:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  Shaoqin Huang <shahuang@redhat.com>,  Eric
 Auger <eauger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>,  Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org,  kvm@vger.kernel.org,  qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>,  Yi Lai <yi1.lai@intel.com>
Subject: Re: [RFC v2 1/5] qapi/qom: Introduce kvm-pmu-filter object
In-Reply-To: <Z6TH+ZyLg/6pgKId@intel.com> (Zhao Liu's message of "Thu, 6 Feb
 2025 22:32:25 +0800")
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <20250122090517.294083-2-zhao1.liu@intel.com>
 <871pwc3dyw.fsf@pond.sub.org> <Z6SMxlWhHgronott@intel.com>
 <87h657p8z0.fsf@pond.sub.org> <Z6TH+ZyLg/6pgKId@intel.com>
Date: Fri, 07 Feb 2025 14:02:44 +0100
Message-ID: <87v7tlhpqj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Zhao Liu <zhao1.liu@intel.com> writes:

>> Let's ignore how to place it for now, and focus on where we would *like*
>> to place it.
>> 
>> Is it related to anything other than ObjectType / ObjectOptions in the
>> QMP reference manual?
>
> Yes!

Now I'm confused :)

It is related to ObjectType / ObjectType.

Is it related to anything else in the QMP reference manual, and if yes,
to what exactly is it related?

>> I guess qapi/kvm.json is for KVM-specific stuff in general, not just the
>> KVM PMU filter.  Should we have a section for accelerator-specific
>> stuff, with subsections for the various accelerators?
>> 
>> [...]
>
> If we consider the accelerator from a top-down perspective, I understand
> that we need to add accelerator.json, kvm.json, and kvm-pmu-filter.json.
>
> The first two files are just to include subsections without any additional
> content. Is this overkill? Could we just add a single kvm-pmu-filter.json
> (I also considered this name, thinking that kvm might need to add more
> things in the future)?
>
> Of course, I lack experience with the file organization here. If you think
> the three-level sections (accelerator.json, kvm.json, and kvm-pmu-filter.json)
> is necessary, I am happy to try this way. :-)

We don't have to create files just to get a desired section structure.

I'll show you how in a jiffie, but before I do that, let me stress: we
should figure out what we want *first*, and only then how to get it.
So, what section structure would make the most sense for the QMP
reference manual?

A few hints on how...

Consider how qapi/block.json includes qapi/block-core.json:

    ##
    # = Block devices
    ##

    { 'include': 'block-core.json' }

    ##
    # == Additional block stuff (VM related)
    ##

block-core.json starts with

    ##
    # == Block core (VM unrelated)
    ##

Together, this produces this section structure

    = Block devices
    == 
    ##

Together, this produces this section structure

    = Block devices
    == Block core (VM unrelated)
    == Additional block stuff (VM related)

Note that qapi/block-core.json isn't included anywhere else.
qapi/qapi-schema.json advises:

    # Documentation generated with qapi-gen.py is in source order, with
    # included sub-schemas inserted at the first include directive
    # (subsequent include directives have no effect).  To get a sane and
    # stable order, it's best to include each sub-schema just once, or
    # include it first right here.


