Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5B7CFD36C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 06:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNmyy-0005El-F6; Tue, 25 Nov 2025 01:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vNmyv-0005DD-Ht
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:56:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vNmys-0007mh-1Y
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764053812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zo9YLpz3SfIDn+v9cji/mY6j++es4tMO/19kEPH8aTs=;
 b=IRpfu1EGsY/PTGvel/ujbb5hxIMppbNqvzLBPyZOPOEtlAqNZKvP7w4Wq+pQQSU/6+6IJm
 AUs06paUlgWDV2XZ2tomiUzVqqrbSwHUnmBP/Bkoz0PK9M9gyrdSm+jD3mxNoAFAv6w72R
 vVhqePuc/2O7Bom1zKB4XKqy4YiFOt4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-Nb1yqBRLPf2DuOOf3mBMdA-1; Tue,
 25 Nov 2025 01:56:49 -0500
X-MC-Unique: Nb1yqBRLPf2DuOOf3mBMdA-1
X-Mimecast-MFC-AGG-ID: Nb1yqBRLPf2DuOOf3mBMdA_1764053809
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E064195606D; Tue, 25 Nov 2025 06:56:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 110451800947; Tue, 25 Nov 2025 06:56:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9128721E6A27; Tue, 25 Nov 2025 07:56:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PULL 4/9] migration: Use warn_reportf_err() where appropriate
In-Reply-To: <CAFEAcA9K8sFKSV+nbQ9UKJW5PNnnQwLNuuyQY7gX2LMEk8ui-g@mail.gmail.com>
 (Peter Maydell's message of "Mon, 24 Nov 2025 21:22:31 +0000")
References: <20251122002656.687350-1-peterx@redhat.com>
 <20251122002656.687350-5-peterx@redhat.com>
 <CAFEAcA9K8sFKSV+nbQ9UKJW5PNnnQwLNuuyQY7gX2LMEk8ui-g@mail.gmail.com>
Date: Tue, 25 Nov 2025 07:56:45 +0100
Message-ID: <87ldjuk3bm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Sat, 22 Nov 2025 at 02:02, Peter Xu <peterx@redhat.com> wrote:
>>
>> From: Markus Armbruster <armbru@redhat.com>
>>
>> Replace
>>
>>     warn_report("...: %s", ..., error_get_pretty(err));
>>
>> by
>>
>>     warn_reportf_err(err, "...: ", ...);
>>
>> Prior art: commit 5217f1887a8 (error: Use error_reportf_err() where
>> appropriate).
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> Link: https://lore.kernel.org/r/20251115083500.2753895-3-armbru@redhat.com
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>  migration/multifd.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index a529c399e4..6210454838 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -464,8 +464,8 @@ static void migration_ioc_shutdown_gracefully(QIOChannel *ioc)
>>           */
>>          migration_tls_channel_end(ioc, &local_err);
>>          if (local_err) {
>> -            warn_report("Failed to gracefully terminate TLS connection: %s",
>> -                        error_get_pretty(local_err));
>> +            warn_reportf_err(local_err,
>> +                        "Failed to gracefully terminate TLS connection: ");
>>          }
>>      }
>
> Hi; Coverity points out (CID 1643463) that this introduces a double-free
> of local_err. In this function local_err is marked up as g_autoptr()
> so it is automatically freed when it goes out of scope. This was needed
> because error_get_pretty() doesn't free its argument. But
> warn_reportf_err() *does* free its error argument, so now we free it twice.
>
> Dropping the g_autoptr markup would be enough, I think.

I'll take care of it.  Hand me the brown paper bag, please.

> The "prior art" commit 5217f1887a8 also seemed to introduce
> some double-frees in hw/usb/dev-mtp.c, but it looks like we
> fixed those in 562a55864 (but with a Fixes: tag that didn't
> point at the commit that introduced them but at a different
> blameless one).

You're right, it's the one that added the error_free(), which only
became wrong later.

I re-checked all of commit 5217f1887a8, and could not find lingering
double-frees.

Thanks!


