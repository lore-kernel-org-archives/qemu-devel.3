Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17643C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMU4-0006uE-Ph; Wed, 28 Feb 2024 11:08:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfMTv-0006tA-6v
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 11:08:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfMTg-00016z-9s
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 11:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709136492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ILhv+GjEodUGp6k6Q/8JNrMw2H+1KNk8L5USVeS7wdY=;
 b=MN9Lgh31jvBqxKb5RoUqsARsc718lqKm+SgYW2REIYYYzFAUS/lKWIcyma7rz9X2MDhVO8
 crxYSXy3jkbD9DdbmapSYe9ARzDbwCOfDhNvN7ahzZ/o7QylCCTnsvRNlYSkDJx4nGE+bE
 GfvsH605qdyVQJ4BXnL8XsVE0B2bCJ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-EzkXrEeJNgOaeH1-ebjCRQ-1; Wed, 28 Feb 2024 11:08:10 -0500
X-MC-Unique: EzkXrEeJNgOaeH1-ebjCRQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4788108C19B;
 Wed, 28 Feb 2024 16:08:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CC5D492BE2;
 Wed, 28 Feb 2024 16:08:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5DB6621E66F4; Wed, 28 Feb 2024 17:08:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: <ankita@nvidia.com>,  <jgg@nvidia.com>,  <alex.williamson@redhat.com>,
 <clg@redhat.com>,  <shannon.zhaosl@gmail.com>,
 <peter.maydell@linaro.org>,  <ani@anisinha.ca>,  <berrange@redhat.com>,
 <eduardo@habkost.net>,  <imammedo@redhat.com>,  <mst@redhat.com>,
 <eblake@redhat.com>,  <david@redhat.com>,  <gshan@redhat.com>,
 <zhiw@nvidia.com>,  <mochs@nvidia.com>,  <pbonzini@redhat.com>,
 <aniketa@nvidia.com>,  <cjia@nvidia.com>,  <kwankhede@nvidia.com>,
 <targupta@nvidia.com>,  <vsethi@nvidia.com>,  <acurrid@nvidia.com>,
 <dnigam@nvidia.com>,  <udhoke@nvidia.com>,  <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 1/2] qom: new object to associate device to numa node
In-Reply-To: <20240228135504.00005d12@Huawei.com> (Jonathan Cameron's message
 of "Wed, 28 Feb 2024 13:55:04 +0000")
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-2-ankita@nvidia.com>
 <8734td3uty.fsf@pond.sub.org> <20240228135504.00005d12@Huawei.com>
Date: Wed, 28 Feb 2024 17:08:06 +0100
Message-ID: <87bk80vaft.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

>> >  ##
>> >  # @RngProperties:
>> >  #
>> > @@ -911,6 +926,7 @@
>> >  ##
>> >  { 'enum': 'ObjectType',
>> >    'data': [
>> > +    'acpi-generic-initiator',
>> >      'authz-list',
>> >      'authz-listfile',
>> >      'authz-pam',
>> > @@ -981,6 +997,7 @@
>> >              'id': 'str' },
>> >    'discriminator': 'qom-type',
>> >    'data': {
>> > +      'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
>> >        'authz-list':                 'AuthZListProperties',
>> >        'authz-listfile':             'AuthZListFileProperties',
>> >        'authz-pam':                  'AuthZPAMProperties',  
>> 
>> Jonathan, you pointed out interface design issues in your review of v2.
>> Are you fully satisfied with the interface in v3?
>
> Yes. I'm fine with the interface in this version (though it's v7, so I'm lost
> on v2 vs v3!)

Looks like I can't count to 7!

With NUMA capitalized in the doc comment, QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>

Thanks!


