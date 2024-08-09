Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5384CC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 07:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scJmR-0002hF-W3; Fri, 09 Aug 2024 03:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1scJmM-0002am-N6
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 03:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1scJmL-0005uf-77
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 03:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723187471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=55FiknPVOjMgPerwYdzxQyFRVU6c8E5y8pIIfmOhXag=;
 b=fKxnzB9NdVN9ypamLjnHtlfOWBtuM2zXbYzUTiiR39sYTRitzBmAAmTWjP1TEGH78GHVYX
 lHgGH+8HYK0rX/ht8CN5r/l6VQdP32fTesXdsy8AsBzQBrqrKuQScIQgVsgdGwmiyUhkb0
 WuXHMPnUR0IRw8RrerjX3KnKbxQhvbo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-juI5lSNNN12rJ7wUww4ndQ-1; Fri,
 09 Aug 2024 03:11:06 -0400
X-MC-Unique: juI5lSNNN12rJ7wUww4ndQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B0191955F49; Fri,  9 Aug 2024 07:10:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABFD83000198; Fri,  9 Aug 2024 07:10:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9DBF721E6682; Fri,  9 Aug 2024 09:10:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org,  alex.williamson@redhat.com,
 andrew@codeconstruct.com.au,  andrew@daynix.com,
 arei.gonglei@huawei.com,  berrange@redhat.com,  berto@igalia.com,
 borntraeger@linux.ibm.com,  clg@kaod.org,  david@redhat.com,
 den@openvz.org,  eblake@redhat.com,  eduardo@habkost.net,
 farman@linux.ibm.com,  farosas@suse.de,  hreitz@redhat.com,
 idryomov@gmail.com,  iii@linux.ibm.com,  jamin_lin@aspeedtech.com,
 jasowang@redhat.com,  joel@jms.id.au,  jsnow@redhat.com,
 kwolf@redhat.com,  leetroy@gmail.com,  marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com,  michael.roth@amd.com,  mst@redhat.com,
 mtosatti@redhat.com,  nsg@linux.ibm.com,  pasic@linux.ibm.com,
 pbonzini@redhat.com,  peter.maydell@linaro.org,  peterx@redhat.com,
 philmd@linaro.org,  pizhenwei@bytedance.com,  pl@dlhnet.de,
 richard.henderson@linaro.org,  stefanha@redhat.com,
 steven_lee@aspeedtech.com,  thuth@redhat.com,  vsementsov@yandex-team.ru,
 wangyanan55@huawei.com,  yuri.benditovich@daynix.com,
 qemu-block@nongnu.org,  qemu-arm@nongnu.org,  qemu-s390x@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 09/18] qapi/machine: Rename CpuS390* to S390Cpu, and
 drop 'prefix'
In-Reply-To: <Zqix4UGgy4adBVFG@intel.com> (Zhao Liu's message of "Tue, 30 Jul
 2024 17:26:57 +0800")
References: <20240730081032.1246748-1-armbru@redhat.com>
 <20240730081032.1246748-10-armbru@redhat.com>
 <Zqix4UGgy4adBVFG@intel.com>
Date: Fri, 09 Aug 2024 09:10:45 +0200
Message-ID: <87ttfumaru.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Tue, Jul 30, 2024 at 10:10:23AM +0200, Markus Armbruster wrote:
>> Date: Tue, 30 Jul 2024 10:10:23 +0200
>> From: Markus Armbruster <armbru@redhat.com>
>> Subject: [PATCH 09/18] qapi/machine: Rename CpuS390* to S390Cpu, and drop
>>  'prefix'
>> 
>> QAPI's 'prefix' feature can make the connection between enumeration
>> type and its constants less than obvious.  It's best used with
>> restraint.
>> 
>> CpuS390Entitlement has a 'prefix' to change the generated enumeration
>> constants' prefix from CPU_S390_POLARIZATION to S390_CPU_POLARIZATION.
>                          ^^^^^^^^^^^^^^^^^^^^^    ^^^^^^^^^^^^^^^^^^^^^
> 			 CPU_S390_ENTITLEMENT     S390_CPU_ENTITLEMENT

Yes.

>> Rename the type to S390CpuEntitlement, so that 'prefix' is not needed.
>> 
>> Likewise change CpuS390Polarization to S390CpuPolarization, and
>> CpuS390State to S390CpuState.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qapi/machine-common.json            |  5 ++---
>>  qapi/machine-target.json            | 11 +++++------
>>  qapi/machine.json                   |  9 ++++-----
>>  qapi/pragma.json                    |  6 +++---
>>  include/hw/qdev-properties-system.h |  2 +-
>>  include/hw/s390x/cpu-topology.h     |  2 +-
>>  target/s390x/cpu.h                  |  2 +-
>>  hw/core/qdev-properties-system.c    |  6 +++---
>>  hw/s390x/cpu-topology.c             |  6 +++---
>>  9 files changed, 23 insertions(+), 26 deletions(-)
>
> [snip]
>
>> diff --git a/qapi/pragma.json b/qapi/pragma.json
>> index 59fbe74b8c..beddea5ca4 100644
>> --- a/qapi/pragma.json
>> +++ b/qapi/pragma.json
>> @@ -47,9 +47,9 @@
>>          'BlockdevSnapshotWrapper',
>>          'BlockdevVmdkAdapterType',
>>          'ChardevBackendKind',
>> -        'CpuS390Entitlement',
>> -        'CpuS390Polarization',
>> -        'CpuS390State',
>> +        'S390CpuEntitlement',
>> +        'S390CpuPolarization',
>> +        'S390CpuState',
>>          'CxlCorErrorType',
>>          'DisplayProtocol',
>>          'DriveBackupWrapper',
>
> It seems to be in alphabetical order. The new names don't follow the
> original order.

You're right.

> Just the above nits,
>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Thanks!


