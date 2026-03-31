Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B811061B37
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 12:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Y7c-0002lS-Ay; Tue, 31 Mar 2026 08:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1w7Y7b-0002lI-7P
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 08:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1w7Y7Y-0004Bj-VN
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 08:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774959778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2UAMB6poZY7leerUb90s5HMuhXmlO9lko6HSBVFBHo=;
 b=gtDu8Sv4jlHXBmUbGm8/3nMVS0aaJIGlUXeOUl/JKpVKrAYrGbrvjR2yGtBqnTRMC/4C5e
 xXASBv0MO9p7D4xp+r8OMPAWobceMKiO34d4OiYLOTYRDGqJxD5Nj8MZ4IwfAcgjM4YaVP
 jmb9mmgIAK118Y05T/DU0h1eS9Z67ak=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-VKYu86aYMyqIKodgT1SPNg-1; Tue,
 31 Mar 2026 08:22:55 -0400
X-MC-Unique: VKYu86aYMyqIKodgT1SPNg-1
X-Mimecast-MFC-AGG-ID: VKYu86aYMyqIKodgT1SPNg_1774959774
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E3AF1955DBB; Tue, 31 Mar 2026 12:22:53 +0000 (UTC)
Received: from localhost (unknown [10.67.32.150])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CF9730001A1; Tue, 31 Mar 2026 12:22:50 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/2] hw/loongarch/virt: Add versioned machine type
 support
In-Reply-To: <7276eab9-784a-a551-53b6-d4906c1704aa@loongson.cn>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251225014102.2666365-1-maobibo@loongson.cn>
 <7276eab9-784a-a551-53b6-d4906c1704aa@loongson.cn>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Tue, 31 Mar 2026 14:22:45 +0200
Message-ID: <87ecl0dw8a.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Mar 26 2026, Bibo Mao <maobibo@loongson.cn> wrote:

> ping.
>
> Should the first compatible machine type patch merged before QEMU=20
> version release or just after it?

This is unfortunately the first time I've seen these patches... I would
expect it to be merged at the beginning of a development cycle, maybe
softfreeze would have still been ok, but I guess we're a bit late for
11.0 now.

Note, I'm not really the maintainer for this, I guess maintainership for
this would be with general loongarch machine maintainership, and I would
have expected it to be included in a pull req there.

I plan on sending the compat machines for 11.1 soon, feel free to pick
that patch and rebase this series on top of that (or on top of whatever
pull req ends up including the 11.1 machines.)

>
> Regards
> Bibo Mao
>
> On 2025/12/25 =E4=B8=8A=E5=8D=889:41, Bibo Mao wrote:
>> Now la464 CPU type feature is basically finished, versioned machine type
>> is added here for compatibility support in future.
>>=20
>> ---
>> v1 ... v2:
>>    1. Change version machine from 10.2 to 11.0
>> ---
>> Bibo Mao (2):
>>    hw/loongarch/virt: Define virt machine type with type_init()
>>    hw/loongarch/virt: Define versioned virt machine
>>=20
>>   hw/loongarch/virt.c | 66 ++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 53 insertions(+), 13 deletions(-)
>>=20
>>=20
>> base-commit: 8dd5bceb2f9cc58481e9d22355a8d998220896de
>>=20


