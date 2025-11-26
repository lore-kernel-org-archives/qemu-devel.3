Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB32DD1038C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 08:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOAan-0005Bc-Gv; Wed, 26 Nov 2025 03:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOAaM-00053R-2E
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 03:09:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOAaI-0008SM-Ux
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 03:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764144545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rI0v4zLkrktHjP52KN7v25MmlWi/x/mh9lDuy0oTS54=;
 b=YUdvRyKHrdwsrcqffQ5plqDzMIrcvNWQ+eYxmWEn0SunmlCJJBGx/ehblOBA8NEYzCri0i
 JqjMZQ5evNdODIxKZE+9Y09pR8Os2yx8ULdQJz+uOwTCMX2+2pwFAM5SEyW4bt/jnOvv4m
 Fc7vm+18S5kjjR5OhCw368O/OmuBTOY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-STf6d3X2O2OOGsvzeKTUew-1; Wed,
 26 Nov 2025 03:09:03 -0500
X-MC-Unique: STf6d3X2O2OOGsvzeKTUew-1
X-Mimecast-MFC-AGG-ID: STf6d3X2O2OOGsvzeKTUew_1764144542
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A27419560A7; Wed, 26 Nov 2025 08:09:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C26D1195608E; Wed, 26 Nov 2025 08:09:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EAE1B21E6A27; Wed, 26 Nov 2025 09:08:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  Juraj Marcin
 <jmarcin@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>
Subject: Re: [PATCH for-11.0 2/6] Revert "error: define g_autoptr() cleanup
 function for the Error type"
In-Reply-To: <cc6af1a8-f87d-4094-aeb8-d0c2d0b77e54@redhat.com>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Wed, 26 Nov 2025 08:43:20 +0100")
References: <20251125204648.857018-1-peterx@redhat.com>
 <20251125204648.857018-3-peterx@redhat.com>
 <cc6af1a8-f87d-4094-aeb8-d0c2d0b77e54@redhat.com>
Date: Wed, 26 Nov 2025 09:08:58 +0100
Message-ID: <87bjkpdxlx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> On 11/25/25 21:46, Peter Xu wrote:
>> This reverts commit 18eb55546a54e443d94a4c49286348176ad4b00a.  Discussion
>> can be seen at:
>> https://lore.kernel.org/r/aSWSLMi6ZhTCS_p2@redhat.com
>> Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>> Cc: C=C3=A9dric Le Goater <clg@redhat.com>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>  include/qapi/error.h | 2 --
>>  1 file changed, 2 deletions(-)
>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>> index b16c6303f8..f3ce4a4a2d 100644
>> --- a/include/qapi/error.h
>> +++ b/include/qapi/error.h
>> @@ -437,8 +437,6 @@ Error *error_copy(const Error *err);
>>   */
>>  void error_free(Error *err);
>>
>> -G_DEFINE_AUTOPTR_CLEANUP_FUNC(Error, error_free)
>> -
>>  /*
>>   * Convenience function to assert that *@errp is set, then silently fre=
e it.
>>   */
>
> Is that related to CID 1643463 issue ?

g_autoptr(Error) is a bad idea, as discussed in

    Subject: g_autoptr(Error) (was: [PATCH] migration: Fix double-free on e=
rror path)=20
    Date: Tue, 25 Nov 2025 08:40:07 +0100
    Message-ID: <871plmk1bc.fsf@pond.sub.org>

We have three instances of g_autoptr(Error) in master.  CID 1643463 made
me see them.

One is removed by my fix to CID 1643463:

    Subject: [PATCH] migration: Fix double-free on error path
    Date: Tue, 25 Nov 2025 08:05:54 +0100
    Message-ID: <20251125070554.2256181-1-armbru@redhat.com>

The remaining two get removed in PATCH 1.  This patch deletes the code
that makes g_autoptr(Error) work.

> anyhow,
>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Thank you!


