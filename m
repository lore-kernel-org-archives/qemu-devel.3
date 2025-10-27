Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04585CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMPO-0000OQ-Bk; Mon, 27 Oct 2025 08:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDMPI-0000Gq-VA
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:33:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDMP8-0005TR-LH
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761568366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4ncRf/0CarRVql8Q2m7Oho3QJpPObE7t+oR9qSe5M4=;
 b=cgB2XnZaJeCBIPnMmzz4x/H06A8f52jYR4hT8Aa0WhG2TeDfDSiASg5//uwNiKvB+6Dr4y
 Fackk9c7Fo+1cL9ANFNpwVFVr8qL2Ab1lb8jQf6S/nag1CH/of91i0X0GYCzQltWemxB1R
 twZHEn8naxCK9H0BIkrFfcJtAPtOJ1w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-3dy1ZJuQMtmXUJBUmMKWnw-1; Mon,
 27 Oct 2025 08:32:43 -0400
X-MC-Unique: 3dy1ZJuQMtmXUJBUmMKWnw-1
X-Mimecast-MFC-AGG-ID: 3dy1ZJuQMtmXUJBUmMKWnw_1761568362
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D49B180034C; Mon, 27 Oct 2025 12:32:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 810C01955F1B; Mon, 27 Oct 2025 12:32:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CD12921E6A27; Mon, 27 Oct 2025 13:32:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  Peter Xu <peterx@redhat.com>,  Bin Guo
 <guobin@linux.alibaba.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Don't free the reason after calling
 migrate_add_blocker
In-Reply-To: <aP9IqYzAea1DUjqp@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 27 Oct 2025 10:25:45 +0000")
References: <20251024092821.82220-1-guobin@linux.alibaba.com>
 <87o6pw1rfn.fsf@pond.sub.org> <aPtim8ZACUWyje2o@redhat.com>
 <874irozabw.fsf@pond.sub.org> <87v7k4xuhk.fsf@pond.sub.org>
 <aPumkKBx4PoGSwNv@x1.local> <aPup9BzTf-uk8cUf@redhat.com>
 <87a51gdv4m.fsf@suse.de> <aP9IqYzAea1DUjqp@redhat.com>
Date: Mon, 27 Oct 2025 13:32:38 +0100
Message-ID: <87ecqomsnt.fsf@pond.sub.org>
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Oct 24, 2025 at 03:15:05PM -0300, Fabiano Rosas wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> > IMHO we should not even be using an Error object for the the blocker.
>> > AFAICT, internally all we care about is the formatted string. The main
>> > reason for using an Error object appears to be to have a convenient
>> > pointer to use as an identifier to later pass to del_blocker.
>> >
>> > I'd be inclined to just have passed in a fixed string, and return an
>> > integer identifier for the blocker. eg
>> >
>> >     int64 migrate_add_blocker(const char *reason, Error **errp);
>> >
>> >     void migrate_del_blocker(int64 blockerid);
>> >
>> > The migrate_add_blocker method would strdup(reason) to keep its own
>> > copy.
>> >
>> > The usage would thus be clear & simple:
>> >
>> >     int64 blockerid =3D migrate_add_blocker("cannot migrate vfio", err=
p);
>> >     if (!blockerid) {
>> >          return;
>> >     }
>> >
>> >     ... some time later...
>> >
>> >     migrate_del_blocker(blockerid);
>> >
>> >
>> > In some cases we needed dynamically formatted strings, which could have
>> > been achieved thus:
>> >
>> >     g_autofree char *msg =3D g_strdup_printf("cannot migrate vfio %d",=
 blah);
>> >     int64 blockerid =3D migrate_add_blocker(msg, errp);
>> >     ...the rest as above...
>> >
>> > yes, this costs an extra strdup(), but that is an acceptable & negligi=
ble
>> > overhead in the context in which we're doing this.
>> >
>>=20
>> Hmm, I must disagree. This is more complex than what we have
>> today. Calling error_setg(err, "msg") is pretty standard, already gives
>> us formatting and keeps all (potentially) user-facing messages uniform.
>
> IMHO this usage in migration is not really about error reporting
> though, and the lifecycle ownership of the Error objects in this
> migration usage is very diferent from the typical lifecycle
> ownership of Error objects used in reporting errors, which I think
> leads to a surprising / unusual API.

I think a blocker interface where you pass the error to use when the
blocker blocks something is defensible.

Passing an error message or even a text snippet to be interpolated into
the error message would also be defensible.

We're using the former, and it has turned out to be confusing.  Less so
in the block layer, where we sensibly pass Error *.  More so in
migration, where we pass Error **.  Error ** is almost always used to
receive an error, so when we use it for something else, we risk
confusion.

>> Asking for people to deal with strings and storing an int64 in their
>> code is not improving the situation. Besides, the Error is already used
>> by the block layer when blocking operations, for instance. If anything
>> we should be integrating the two usages instead of inventing yet another
>> for the migration code. See:
>
> Yes, having a common API for these two similar use cases would be
> a useful thing. I'm just not convinced we should be (mis|re)using
> the Error object for either of these two situations.

I guess we could have a generic Blocker object instead of using Error
for the purpose.

In addition to an error message, an Error object has an error class
(rarely used remnant of the past), where in the source code the Error
object was created (reported to the user when handling &error_abort),
and an optional hint.  Is any of this useful for blockers?

>> replication.c:
>>   error_setg(&s->blocker,
>>              "Block device is in use by internal backup job");
>>   ...
>>   bdrv_op_block_all(top_bs, s->blocker);
>>=20
>> block.c:
>>   void bdrv_op_block(BlockDriverState *bs, BlockOpType op, Error *reason)
>>   {
>>       BdrvOpBlocker *blocker;
>>       assert((int) op >=3D 0 && op < BLOCK_OP_TYPE_MAX);
>>=20
>>       blocker =3D g_new0(BdrvOpBlocker, 1);
>>       blocker->reason =3D reason;
>>       QLIST_INSERT_HEAD(&bs->op_blockers[op], blocker, list);
>> }
>
>
> With regards,
> Daniel


