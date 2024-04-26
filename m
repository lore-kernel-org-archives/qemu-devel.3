Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F5CC19F4E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 09:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Hi3-0000fO-Cp; Fri, 26 Apr 2024 05:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0Hhw-0000eq-VA
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0Hhl-0004yP-Mg
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714123025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tX7OwYNvfCwW+SWnuBtJDlZFGrh8rNO2CpXDQ7/7/cQ=;
 b=TCx58bvGB6N0SIdYJPWDmhWlFTtI0YD1pNe2oUPz1XcRrrFEcuaCOMG4mrw4mS2zyjuj4E
 4uMsJLeq7aJwCd2gvOvccISrFFmdHPCi1xye1qg8Sz9+lJP1q3rbjCwQyHfZa2ZWO2IqrU
 02qh2jNbJG63gYjv1VzVU9469+clkwc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-Jy2qDFmHM_C8QUarimcQ_w-1; Fri, 26 Apr 2024 05:17:00 -0400
X-MC-Unique: Jy2qDFmHM_C8QUarimcQ_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B914918065AD;
 Fri, 26 Apr 2024 09:16:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 994982166B31;
 Fri, 26 Apr 2024 09:16:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A341221E6680; Fri, 26 Apr 2024 11:16:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Hao Xiang <hao.xiang@linux.dev>,  marcandre.lureau@redhat.com,
 peterx@redhat.com,  farosas@suse.de,  armbru@redhat.com,
 lvivier@redhat.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/14] migration/multifd: Add new migration option
 for multifd DSA offloading.
In-Reply-To: <Zipl4WkTFgMr92NP@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 25 Apr 2024 15:17:05 +0100")
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
 <20240425022117.4035031-9-hao.xiang@linux.dev>
 <Zipl4WkTFgMr92NP@redhat.com>
Date: Fri, 26 Apr 2024 11:16:58 +0200
Message-ID: <87zftgwkj9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Apr 25, 2024 at 02:21:11AM +0000, Hao Xiang wrote:
>> Intel DSA offloading is an optional feature that turns on if
>> proper hardware and software stack is available. To turn on
>> DSA offloading in multifd live migration:
>>=20
>> multifd-dsa-accel=3D"[dsa_dev_path1] [dsa_dev_path2] ... [dsa_dev_pathX]"
>>=20
>> This feature is turned off by default.
>>=20
>> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
>> ---
>>  migration/migration-hmp-cmds.c |  8 ++++++++
>>  migration/options.c            | 30 ++++++++++++++++++++++++++++++
>>  migration/options.h            |  1 +
>>  qapi/migration.json            | 26 +++++++++++++++++++++++---
>>  4 files changed, 62 insertions(+), 3 deletions(-)
>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 8c65b90328..934fa8839e 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -914,6 +914,12 @@
>>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>>  #     (since 9.0)
>>  #
>> +# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
>> +#     certain memory operations. Enable DSA accelerator offloading by
>> +#     setting this string to a list of DSA device path separated by spa=
ce
>> +#     characters. Setting this string to an empty string means disabling
>> +#     DSA accelerator offloading. Defaults to an empty string. (since 9=
.2)
>
> Passing a list of paths as a single space separate string is a
> design anti-pattern. This needs to use a list type at the QAPI
> level.

Yup.

> Also I don't think we need add 'multifd' on the name - all
> new features are for multifd.
>
> Overall it should be called 'dsa-accel-path' I thjink

Moreover, docs/devel/qapi-code-gen.rst:

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.

[...]


