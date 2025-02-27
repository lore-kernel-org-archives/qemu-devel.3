Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCD7C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnb59-0004E4-Um; Thu, 27 Feb 2025 05:25:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnb50-0004DF-Qm
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:25:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnb4y-0000sm-TE
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740651920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4izwBpHuU7+6BaLcXuwAJHA8PZ1Zetd5X6CeOgk/MGw=;
 b=heV9O37byXhlLLAuq9K9mqe9t0+EDJF3SKz2rSNjJWYcfCzTtfuq8nlBHA5c4djD5n9dSM
 x2ZgzvKhwVImFLjeU0hNwjEfI+pw9vPcwVzt77ZRUy6wpTgsjR4xUyO7CtZ04xr/LyOnHY
 MlqqQivnO76apXPusU/kB55SA13P7Ac=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-rkTG27GSNMSSXkicS2YikA-1; Thu,
 27 Feb 2025 05:25:15 -0500
X-MC-Unique: rkTG27GSNMSSXkicS2YikA-1
X-Mimecast-MFC-AGG-ID: rkTG27GSNMSSXkicS2YikA_1740651914
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96B8E190ECDF; Thu, 27 Feb 2025 10:25:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C9041944F2E; Thu, 27 Feb 2025 10:25:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B013121E66B9; Thu, 27 Feb 2025 11:25:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 pbonzini@redhat.com,  eduardo@habkost.net
Subject: Re: [PATCH v2 6/6] qdev: Improve a few more PropertyInfo
 @description members
In-Reply-To: <Z8Aw6wcsEiU_D7nB@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 27 Feb 2025 09:31:23 +0000")
References: <20250227085601.4140852-1-armbru@redhat.com>
 <20250227085601.4140852-7-armbru@redhat.com>
 <Z8Aw6wcsEiU_D7nB@redhat.com>
Date: Thu, 27 Feb 2025 11:25:10 +0100
Message-ID: <87a5a7fzw9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Feb 27, 2025 at 09:56:01AM +0100, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/block/xen-block.c             | 2 +-
>>  hw/core/qdev-properties-system.c | 2 +-
>>  hw/core/qdev-properties.c        | 1 +
>>  hw/s390x/ccw-device.c            | 4 ++--
>>  target/sparc/cpu.c               | 1 +
>>  5 files changed, 6 insertions(+), 4 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index 5a801057db..c04df3b337 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c
>> @@ -247,6 +247,7 @@ static void set_bool(Object *obj, Visitor *v, const =
char *name, void *opaque,
>>=20=20
>>  const PropertyInfo qdev_prop_bool =3D {
>>      .type  =3D "bool",
>> +    .description =3D "on/off",
>
> Awkward as on/off for QemuOpts, but JSON true/false  for QMP, but I
> guess clarifying this is beyond the scope of the .description field.

In my view, description applies to human-friendly dotted-keys syntax,
not to JSON.  Trying to make it work for both would result in verbose
and confusing descriptions.

Thanks!


