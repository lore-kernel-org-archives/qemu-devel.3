Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22E2CF3196
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsOV-0007wn-Av; Wed, 02 Oct 2024 01:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svsOP-0007p9-3D
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svsON-0005OT-K1
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727848757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0AMb/Hh/Wj5DDVpqPxcI9SO65BGEzu2ChwEglgq8vg4=;
 b=ZBMWOepW0Ce/KhV1M8uht0deQmfuiI/f8IXalVZmxJAzhaMgP1KK8QtZz15cpKnJNGtYEq
 sZmo+CFHrjN3wUA5NNBO6UoF6FCJX3A/YtkraQJvc3k5mjwKUuxjl5lzKv5/KqZq2S++1H
 K6dN+GA0NZdLqeBn/IkMhD2o+n748DQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-tTePpOpjNnaVWdliVZPdPw-1; Wed,
 02 Oct 2024 01:59:08 -0400
X-MC-Unique: tTePpOpjNnaVWdliVZPdPw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 193A719560A2; Wed,  2 Oct 2024 05:59:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80BF93000198; Wed,  2 Oct 2024 05:59:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 508F021E6A28; Wed,  2 Oct 2024 07:58:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Jiang Jiacheng
 <jiangjiacheng@huawei.com>,  qemu-devel@nongnu.org,  Prasad Pandit
 <ppandit@redhat.com>,  Julia Suvorova <jusual@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Juraj Marcin <jmarcin@redhat.com>,  "Dr . David Alan
 Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 0/7] migration: query-migrationthreads enhancements and
 cleanups
In-Reply-To: <ZvwQB1Calv407MH0@x1n> (Peter Xu's message of "Tue, 1 Oct 2024
 11:06:47 -0400")
References: <20240930195837.825728-1-peterx@redhat.com>
 <87o744e5pa.fsf@pond.sub.org> <ZvwGSgDnW8KfgFEh@redhat.com>
 <ZvwQB1Calv407MH0@x1n>
Date: Wed, 02 Oct 2024 07:58:48 +0200
Message-ID: <87h69vavvr.fsf@pond.sub.org>
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
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Oct 01, 2024 at 03:25:14PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Tue, Oct 01, 2024 at 07:46:09AM +0200, Markus Armbruster wrote:
>> > Command query-migrationthreads went in without a QAPI ACK.  Issues
>> > review should have caught:
>> >=20
>> > * Flawed documentation.  Fixed in commit e6c60bf02d1.
>> >=20
>> > * It should have been spelled query-migration-threads.  Not worth fixi=
ng
>> >   now, I guess.
>> >=20
>> > * What are the use cases?  The commit message doesn't tell!  If it's
>> >   just for debugging, the command should be marked unstable.
>>=20
>> It is hard to use too.
>>=20
>> Lets say a mgmt app wants to restrict migration threads to some
>> certain pCPUs. It can't call query-migrationthreads beforehand
>> as the threads don't exist until migration is started. If it
>> calls after migration is started, then there's a window where
>> threads are running on arbitrary pCPUs that QEMU has access
>> to. There's no synchronization point where threads have been
>> created & can be queried, but are not yet sending data (and
>> thus burning CPU time)
>
> Indeed, I suppose tricks needed if to work with such model, e.g., mgmt
> needs to turn bw=3D0, start migration, query TIDs, then restore bw.
>
> However that still lacks at least the dest multifd threads, as currently =
it
> only reports src multifd threads TIDs.  I don't see why a serious mgmt
> would like to pin and care only src threads, not dest threads, which can
> also eat as much (or even more) pCPU resources.

Sounds like there's a use case for management applications querying
TIDs, but query-migrationthreads falls short of serving it.

> For real debugging purpose, I actually don't see a major value out of it
> either, because GDB can provide all information that this API wants to
> provide, and only better with thread stacks if we want.

True.

> Since I don't see how this can be used right, it didn't get proper QAPI
> reviews, and further I highly suspect whether this API is consumed by
> anyone at all.. in any serious way.  Shall we remove this API (with/witho=
ut
> going through the deprecation process)?

If we decide we want to serve the management application use case now,
we should provide a suitable interface, then deprecate
query-migrationthreads.

If we decide not now or not at all, we can deprecate it right away.
Removal without deprecation is also possible, but I doubt breaking our
compatibility promise is justified.

> I added the author Jiacheng too.

Users of query-migrationthreads, please speak up!


