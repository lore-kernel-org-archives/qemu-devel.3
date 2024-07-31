Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CC0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 05:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ1e1-0008J2-UQ; Wed, 31 Jul 2024 01:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZ1e0-0008FY-D9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 01:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZ1dy-0001Qq-Hl
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 01:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722402777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iVHQrxNekcxtK1Yq7919QcmyccPj5czJKpkTBAdsp/s=;
 b=fhOjWul3xKZJ59yKpivh7vu1VaAHwJUVitAqfM6AqqQD+cEFVgly9DXfPq4cSygcRw7Om2
 B1faBCGelyYrSr3ZT9q0MiS5zfjhqtdfrjnbR9awklObIsfb6kBcYiZ5Xk0jb9UTO4UfNW
 s1RuYyiqjfWm5APQbPsPI7uSnikgPHI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-dAPmUXj7O6O0ulCe7pCW5A-1; Wed,
 31 Jul 2024 01:12:52 -0400
X-MC-Unique: dAPmUXj7O6O0ulCe7pCW5A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 948711955BFC; Wed, 31 Jul 2024 05:12:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BFAF1955F3B; Wed, 31 Jul 2024 05:12:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4BF7921E668A; Wed, 31 Jul 2024 07:12:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 alex.williamson@redhat.com,  andrew@codeconstruct.com.au,
 andrew@daynix.com,  arei.gonglei@huawei.com,  berto@igalia.com,
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
 zhao1.liu@intel.com,  qemu-block@nongnu.org,  qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org,  kvm@vger.kernel.org,  =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>
Subject: Re: [PATCH 01/18] qapi: Smarter camel_to_upper() to reduce need for
 'prefix'
In-Reply-To: <9b147a34-4641-4b4c-a050-51ceb3ea6a67@nvidia.com> (Avihai Horon's
 message of "Tue, 30 Jul 2024 16:33:31 +0300")
References: <20240730081032.1246748-1-armbru@redhat.com>
 <20240730081032.1246748-2-armbru@redhat.com>
 <ZqiutRoQuAsrllfj@redhat.com> <87mslzgjde.fsf@pond.sub.org>
 <9b147a34-4641-4b4c-a050-51ceb3ea6a67@nvidia.com>
Date: Wed, 31 Jul 2024 07:12:38 +0200
Message-ID: <87jzh2kuux.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Avihai Horon <avihaih@nvidia.com> writes:

> On 30/07/2024 15:22, Markus Armbruster wrote:
>>
>> Avihai, there's a question for you on VfioMigrationState.
>>
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>
>>> On Tue, Jul 30, 2024 at 10:10:15AM +0200, Markus Armbruster wrote:

[...]

>> * VfioMigrationState
>>
>>    Can't see why this one has a prefix.  Avihai, can you enlighten me?
>
> linux-headers/linux/vfio.h defines enum vfio_device_mig_state with values=
 VFIO_DEVICE_STATE_STOP etc.

It does not define any VFIO_DEVICE_STATE_*, though.

> I used the QAPI prefix to emphasize this is a QAPI entity rather than a V=
FIO entity.

We define about two dozen symbols starting with VFIO_, and several
hundreds starting with vfio_.  What makes this enumeration type
different so its members need emphasis?

[...]


