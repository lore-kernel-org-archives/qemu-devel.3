Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC92ACCD18D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 12:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8eWd-0005G0-CD; Tue, 14 Oct 2025 08:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8eWY-0005FB-QU
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 08:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8eWQ-0003uP-JR
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 08:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760446373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3UqQXrcego6DBmgEw1aiqxuJEkjeFTMvBia1HFgwGw=;
 b=NbDe1llu9FlNY5leS9wXXMMtlV6fmU3AXrVEuxvlaFfMQLHAvUCG2ASiyVOQHSJVZIDp7d
 2YwD1ruC3MQ+iqdhf04DR9gnlCqxzc8Os2YbCyyzhjLO69uDCwMdpk7eRRwKeCQvqgs7oN
 2AfAL2bIwkBalWuBifiteHgGdy0reZE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-88jpo1BKMauoxGOC25keTQ-1; Tue,
 14 Oct 2025 08:52:49 -0400
X-MC-Unique: 88jpo1BKMauoxGOC25keTQ-1
X-Mimecast-MFC-AGG-ID: 88jpo1BKMauoxGOC25keTQ_1760446369
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05416180028D; Tue, 14 Oct 2025 12:52:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 862B11955F21; Tue, 14 Oct 2025 12:52:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 23EB321E6A27; Tue, 14 Oct 2025 14:52:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com,  Bernhard Beschow
 <shentey@gmail.com>
Subject: Re: [PATCH] ui/pixman: Fix crash in qemu_pixman_shareable_free()
In-Reply-To: <2831438d-9ca2-4629-b708-65874cf3a4a7@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 13 Oct 2025 16:11:32
 +0200")
References: <20251013112102.2396012-1-armbru@redhat.com>
 <2831438d-9ca2-4629-b708-65874cf3a4a7@linaro.org>
Date: Tue, 14 Oct 2025 14:52:46 +0200
Message-ID: <87jz0xmyqp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 13/10/25 13:21, Markus Armbruster wrote:
>> Reported-by: Bernhard Beschow <shentey@gmail.com>
>> Fixes: b296b29d3414 (ui/pixman: Consistent error handling in qemu_pixman=
_shareable_free())
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   ui/qemu-pixman.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
>> index e46c6232cf..aea09755b9 100644
>> --- a/ui/qemu-pixman.c
>> +++ b/ui/qemu-pixman.c
>> @@ -291,7 +291,9 @@ qemu_pixman_shareable_free(qemu_pixman_shareable han=
dle,
>>       Error *err =3D NULL;
>>=20=20=20
>>       qemu_win32_map_free(ptr, handle, &err);
>
> Slightly better if qemu_win32_map_free(), as per commit e3fe3988d78
> ("error: Document Error API usage rules") recommended style:
>
> + *  We recommend
> + *   =E2=80=A2 bool-valued functions return true on success / false on f=
ailure,
> + *   =E2=80=A2 pointer-valued functions return non-null / null pointer, =
and
> + *   =E2=80=A2 integer-valued functions return non-negative / negative.

I went fo a minimal fix.

I now see that this is the only use of qemu_win32_map_free().  Changing
it to return bool would've been okay.

> Anyhow,
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks!

>> -    error_report_err(err);
>> +    if (err) {
>> +        error_report_err(err);
>> +    }
>>   #else
>>       qemu_memfd_free(ptr, size, handle);
>>   #endif


