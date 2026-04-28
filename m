Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00EDFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 19:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHniB-0005kV-L8; Tue, 28 Apr 2026 15:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wHni9-0005kA-UQ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 15:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wHni4-00076F-Tn
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 15:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777402983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YgUTlVKAShtA+D1Da87VVQkpTlhdqEvfQ5MMPGCLSSs=;
 b=UXZ0/g6KkEhNDmPYW/P+6P4zm9ujsQTCewr+EBkkzR4l+nO2thuFEGrsltcr02MU887FJz
 wGA+NWL84oFg0LoEk1bz0nS+zk0G+aO+KkegX0PgeFe+po2H3vz6+mcawkNXR9ObN1J+wI
 98aoDUrRv8xHZkkM1JFGcHxLf5ZqQro=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-LUAbZjORMm2gskZzqNRvYA-1; Tue,
 28 Apr 2026 15:03:00 -0400
X-MC-Unique: LUAbZjORMm2gskZzqNRvYA-1
X-Mimecast-MFC-AGG-ID: LUAbZjORMm2gskZzqNRvYA_1777402978
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26F1718002C0; Tue, 28 Apr 2026 19:02:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B8B719560AB; Tue, 28 Apr 2026 19:02:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5553721E6A28; Tue, 28 Apr 2026 21:02:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Joao
 Martins <joao.m.martins@oracle.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Prasad Pandit
 <ppandit@redhat.com>,  Alex Williamson <alex@shazbot.org>,  Kirti Wankhede
 <kwankhede@nvidia.com>,  Zhiyi Guo <zhguo@redhat.com>,  "Maciej S .
 Szmigiero" <mail@maciej.szmigiero.name>,  Juraj Marcin
 <jmarcin@redhat.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v2 14/16] migration/qapi: Introduce system-wise
 "remaining" reports
In-Reply-To: <afDRlNtG7wlmXchB@x1.local> (Peter Xu's message of "Tue, 28 Apr
 2026 11:26:12 -0400")
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-15-peterx@redhat.com>
 <87cxzovncu.fsf@pond.sub.org> <aeuJCI0OCW-ohJih@x1.local>
 <87jytvoam2.fsf@pond.sub.org> <afDRlNtG7wlmXchB@x1.local>
Date: Tue, 28 Apr 2026 21:02:52 +0200
Message-ID: <87wlxqzz4z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Sat, Apr 25, 2026 at 07:46:45AM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:

[...]

>> > The complete new version of patch is here (I updated quite a few places on
>> > the commit message):
>> >
>> > https://gitlab.com/peterx/qemu/-/commit/86d973360890cecc564a4a5bcf9a01b9efde368a
>> >
>> > Thanks,
>> 
>> I read the commit message.  No surprises except
>> 
>>     It should be the same value as RAM's remaining report when VFIO is not
>>     involved, and it should report more than that when VFIO is involved.
>> 
>>     One note is that this field will be an estimate and may not be sampled the
>>     exact same time versus the RAM remaining section.  So it may report
>>     slightly different values even if only RAM is involved.  The difference
>>     shouldn't matter though to mgmt to make correct decisions.
>> 
>> The second paragraph is new.  The first paragraph says they "should be
>> the same", the second that they "may [be] slightly different".
>> Suboptimal.
>
> Yes, it is misleading, I overlooked that. :(
>
>> 
>> Here's my try:
>> 
>>     It should be approximately the same value ...
>> 
>>     Only approximately, because this field will be ...
>> 
>> It's just a commit message, though.  Up to you.
>
> New version:
>
>     When VFIO is not involved, the value reported in the new field should
>     be approximately the same as reported in the "remaining" field of the
>     RAM section.  It is only an approximate value because the system-wide
>     remaining data is a cached value, which gets frequently updated by
>     migration core.  OTOH, the RAM's remaining data is accurate.
>     
>     When VFIO is involved, the new value reported should normally be
>     larger, because it will include the size of VFIO remaining data too.

Looks good to me, thanks!

>> QAPI schema
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>
> Thanks, I will at least wait for 1-2 days if it still needs update.


