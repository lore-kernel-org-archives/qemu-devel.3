Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FD5C83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 06:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZODJ-0007Rh-Ow; Wed, 09 Jul 2025 02:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZODD-0007QA-Qe
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 02:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZODB-0007GG-Jx
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 02:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752042198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6+rKPfZDrzvBFYIIw5///omdBIt3zBAk6FeauJb59k=;
 b=coq6CGkcZPNaNKpRizIEcNdJyy/ITQWmdOxBMtLY7wdXp52RZ4qoCy3zPF716WKWDp5/6S
 thpVYLhNH2nR8dyJ0xI4ioKh/2R7oRtC0X0FItx3cQ3P7GJ7bITn7T6KBWx1lSEHpznW6q
 hzdGIF1JDyQGKMq56ECLLqQOsKUOUbI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-aoK_LMikO4mAM6uD5j8yJw-1; Wed,
 09 Jul 2025 02:23:14 -0400
X-MC-Unique: aoK_LMikO4mAM6uD5j8yJw-1
X-Mimecast-MFC-AGG-ID: aoK_LMikO4mAM6uD5j8yJw_1752042193
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30D301978C9A; Wed,  9 Jul 2025 06:23:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1366180035C; Wed,  9 Jul 2025 06:23:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 15D6521E6A27; Wed, 09 Jul 2025 08:23:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Steve Sistare <steven.sistare@oracle.com>,  qemu-devel@nongnu.org,  John
 Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Daniel P.
 Berrange" <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH V3 3/3] tests/qtest/qom-test: unit test for qom-list-getv
In-Reply-To: <bdb92ceb-59d3-4e82-83f7-d4bde9b96583@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 9 Jul 2025 00:02:07
 +0200")
References: <1751995472-211897-1-git-send-email-steven.sistare@oracle.com>
 <1751995472-211897-4-git-send-email-steven.sistare@oracle.com>
 <bdb92ceb-59d3-4e82-83f7-d4bde9b96583@linaro.org>
Date: Wed, 09 Jul 2025 08:23:10 +0200
Message-ID: <87v7o1righ.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Steve,
>
> On 8/7/25 19:24, Steve Sistare wrote:
>> Add a unit test for qom-list-getv.
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   tests/qtest/qom-test.c | 64 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   1 file changed, 64 insertions(+)
>> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
>> index 27d70bc..4defff1 100644
>> --- a/tests/qtest/qom-test.c
>> +++ b/tests/qtest/qom-test.c
>> @@ -11,11 +11,72 @@
>>     #include "qobject/qdict.h"
>>   #include "qobject/qlist.h"
>> +#include "qobject/qstring.h"
>>   #include "qemu/cutils.h"
>>   #include "libqtest.h"
>>     static int verbosity_level;
>>   +static void test_getv(QTestState *qts, QList *paths)
>> +{
>> +    QListEntry *entry, *prop_entry, *path_entry;
>> +    g_autoptr(QDict) response =3D NULL;
>> +    QDict *args =3D qdict_new();
>> +    QDict *prop;
>> +    QList *return_list;
>> +
>> +    if (verbosity_level >=3D 2) {
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> But I note this doesn't assert anything except if you use V=3D3 and
> look at the output.
>
> Maybe stick it to a particular machine and check for a particular
> path and its properties?

Or create some suitable thing with -object, and get that.  No machine
dependence.

[...]


