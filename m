Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95D0CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqyO-0008Vr-F7; Mon, 20 Oct 2025 10:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vAqyJ-0008RK-VD
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:34:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vAqyG-0002CP-Nf
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760970882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OiN+B8uqfQZYBsbiXa9pzqFCbbF6xjyDMzUPPSA8U2A=;
 b=YNLBDqBar4akA3G+1whpw3BxH5Q5GJw2Q0gx50rfpJTizN95iZ8LhFZavX6x24OMFHE+7V
 XZ8OzObcNQIS1GVL8GKRjCbM6Qf5HgIjCQcCcsxlJkd5baV4VXloYgdUoLYfnstdinlUP8
 KAchNFA5HW3HsQiHvn8jvHDigIcY/mM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-1SvGQVIbMQSQfO05OGoRgg-1; Mon,
 20 Oct 2025 10:34:36 -0400
X-MC-Unique: 1SvGQVIbMQSQfO05OGoRgg-1
X-Mimecast-MFC-AGG-ID: 1SvGQVIbMQSQfO05OGoRgg_1760970876
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 743641956076; Mon, 20 Oct 2025 14:34:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9D1118002AD; Mon, 20 Oct 2025 14:34:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 38A2021E6A27; Mon, 20 Oct 2025 16:34:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com,  stefanb@linux.vnet.ibm.com,  farosas@suse.de,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: vmsd errp handlers: return bool
In-Reply-To: <aPYfqzljT3q2noDb@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 20 Oct 2025 12:40:27 +0100")
References: <20251020091907.2173711-1-vsementsov@yandex-team.ru>
 <87347d7s0j.fsf@pond.sub.org>
 <0ce2f913-36c2-44a2-8141-256ff847529d@yandex-team.ru>
 <aPYfqzljT3q2noDb@redhat.com>
Date: Mon, 20 Oct 2025 16:34:31 +0200
Message-ID: <871pmxskug.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> On Mon, Oct 20, 2025 at 02:22:22PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> On 20.10.25 14:05, Markus Armbruster wrote:
>> > Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> >=20
>> > > Recently we moved to returning errp. Why to keep int return value?
>> > > Generally it doesn't help: you can't use in a logic of handling
>> > > an error, as you are never sure, that in future the logic in
>> > > the stack will not change: it may start to return another error
>> > > code in the same case, or return same error code in another case.
>> > >=20
>> > > Actually, we can only rely on concrete errno code when get it
>> > > _directly_ from documented library function or syscall. This way we
>> > > handle for example EINTR. But later in a stack, we can only add
>> > > this errno to the textual error by strerror().
>> >=20
>> > It's a matter of the function's contract, actually.
>> >=20
>> > If the contract is "Return negative value on failure", checking for
>> > failure is all you can do with it.  Same information as "Return false =
on
>> > failure".
>> >=20
>> > If the contract is "Return negative errno on failure", the function is
>> > responsible for returning values that make sense.  Ideally, the contra=
ct
>> > spells them all out.
>> >=20
>>=20
>> Do you know an example in code where we have both errno return value
>> and errp, and the return value make sense and used by callers?
>
> If there are examples of that, I would generally consider them to be
> bugs.
>
> IMHO if a method is using "Error **errp", then it should be considered
> forbidden to return 'errno' values.

Several subsystems disagree :)

Quick & dirty search without a claim to accuracy or completeness:

    $ git-ls-files \*.[ch] | xargs awk '/, Error \*\*errp/ { on=3D1 } on &&=
 /return -E/ { print FILENAME ":" FNR ":" $0 } /^}/ { on=3D0 }'

> If there is a need for distinguishing some cases from others, then keep
> with int '0/-1' example, but turn it into a multi-value return such as
> 1/0/-1, or 0/-1/-2/-3/..., etc with named constants for the unusual
> scenarios. An example of that would be QIOChannel were we introduced
> "#define QIO_CHANNEL_ERR_BLOCK -2" to replace the need for EAGAIN checks
> in callers.

Defining your own error codes is fine.

Reusing errno codes can also be fine.

In both cases, the function contract is a load-bearing component.


