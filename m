Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137A8D0E6C4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 11:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNrUu-00022i-JH; Tue, 25 Nov 2025 06:46:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vNrUs-00020g-89
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:46:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vNrUq-0008SU-2q
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764071168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GQpjXUgBwbRc8kvJ0Wf1OVgFFD0DeTcUjFsYZBuUQxY=;
 b=X1y2kFxON1aNw9ApgB5foJRyMzQlwZLdC8yQiLIiOlAmGKmSZWKLG+TS3GoseQyT6gLJGp
 9lhACLtm2216AoNaMwzuTb5I2uA17/G8oJCAnrsz1HDH8G9/3dfRRP8u6ICg9LHtR/QOIx
 iwYZEYJpCAfZpNhHNJDU6QWspnGOnjQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-HPMZR-tkNIWC3uKtiPB5lg-1; Tue,
 25 Nov 2025 06:46:05 -0500
X-MC-Unique: HPMZR-tkNIWC3uKtiPB5lg-1
X-Mimecast-MFC-AGG-ID: HPMZR-tkNIWC3uKtiPB5lg_1764071164
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AC901800372; Tue, 25 Nov 2025 11:46:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BD6F3003E40; Tue, 25 Nov 2025 11:46:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 26EF221E6A27; Tue, 25 Nov 2025 12:46:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 peter.maydell@linaro.org
Subject: Re: g_autoptr(Error)
In-Reply-To: <aSWSLMi6ZhTCS_p2@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 25 Nov 2025 11:25:32 +0000")
References: <20251125070554.2256181-1-armbru@redhat.com>
 <871plmk1bc.fsf@pond.sub.org> <aSWSLMi6ZhTCS_p2@redhat.com>
Date: Tue, 25 Nov 2025 12:46:01 +0100
Message-ID: <87jyzexrly.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Tue, Nov 25, 2025 at 08:40:07AM +0100, Markus Armbruster wrote:
>> g_autoptr(T) is quite useful when the object's extent matches the
>> function's.
>>=20
>> This isn't the case for an Error object the function propagates to its
>> caller.  It is the case for an Error object the function reports or
>> handles itself.  However, the functions to report Error also free it.
>>=20
>> Thus, g_autoptr(Error) is rarely applicable.  We have just three
>> instances out of >1100 local Error variables, all in migration code.
>>=20
>> Two want to move the error to the MigrationState for later handling /
>> reporting.  Since migrate_set_error() doesn't move, but stores a copy,
>> the original needs to be freed, and g_autoptr() is correct there.  We
>> have 17 more that instead manually free with error_free() or
>> error_report_err() right after migrate_set_error().
>>=20
>> We recently discussed storing a copy vs. move the original:
>>=20
>>     From: Peter Xu <peterx@redhat.com>
>>     Subject: Re: [PATCH 0/3] migration: Error fixes and improvements
>>     Date: Mon, 17 Nov 2025 11:03:37 -0500
>>     Message-ID: <aRtHWbWcTh3OF2wY@x1.local>
>>=20
>> The two g_autoptr() gave me pause when I investigated this topic, simply
>> because they deviate from the common pattern migrate_set_error(s, err)
>> followed by error_free() or error_report_err().
>>=20
>> The third one became wrong when I cleaned up the reporting (missed in
>> the cleanup patch, fixed in the patch I'm replying to).  I suspect my
>> mistake escaped review for the same reason I made it: g_autoptr(Error)
>> is unusual and not visible in the patch hunk.
>>=20
>> Would you like me to replace the two correct uses of g_autoptr(Error) by
>> more common usage?
>
> I had previously proposed g_autoptr(Error) a year or two back and you
> rejected it then, so I'm surprised to see that it got into the code,
> because it requires explicit opt-in via a G_DEFINE_AUTOPTR_CLEANUP_FUNC.
>
> Unfortunately it appears exactly that was added earlier this year in
>
>   commit 18eb55546a54e443d94a4c49286348176ad4b00a
>   Author: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>   Date:   Tue Mar 4 23:03:35 2025 +0100
>
>     error: define g_autoptr() cleanup function for the Error type
>=20=20=20=20=20
>     Automatic memory management helps avoid memory safety issues.
>=20=20=20=20=20
>     Reviewed-by: Peter Xu <peterx@redhat.com>
>     Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>     Link: https://lore.kernel.org/qemu-devel/a5843c5fa64d7e5239a4316092ec=
0ef0d10c2320.1741124640.git.maciej.szmigiero@oracle.com
>     Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>

I missed it.  Not he submitter's fault; it was cc'ed to me.

> When removing this usage, ensure that commit is reverted too, which
> will prevent anyone unwittingly re-introducing g_autoptr(Error)
> usage

Thanks for the pointer!


