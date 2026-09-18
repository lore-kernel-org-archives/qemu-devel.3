Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B577DC88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7TpX-0006uf-RZ; Fri, 18 Sep 2026 04:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7TpS-0006uN-9p
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 04:20:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7TpP-0003jC-Nh
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 04:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789719613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l+nW1m+5xJZL918Ewt0PNVZ9gHF4RYb87c5kkBqHO3k=;
 b=Bhw8uNUYUvMgF72GAQSprYGS4uvYG2eRPxmTt0JzgH4fNEccKgxOMI9HuQ+rACcW36lGAZ
 oRuZgALwaaRmUTwfGfeJhw8qgNtsjcdJD9ZdVutDLw3Y+XlhPBHLBa+4twGcdqylzxkDng
 VoG3C4KmAvJl1j4VWGLg1mtIB/7du2U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-IrAn0d-WOQKHa6J7eOtFLQ-1; Fri,
 18 Sep 2026 04:20:10 -0400
X-MC-Unique: IrAn0d-WOQKHa6J7eOtFLQ-1
X-Mimecast-MFC-AGG-ID: IrAn0d-WOQKHa6J7eOtFLQ_1789719609
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E58B91805A1C; Fri, 18 Sep 2026 08:20:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32AEA1956047; Fri, 18 Sep 2026 08:20:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E49321E6A04; Fri, 18 Sep 2026 10:20:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Peter Xu <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 14/20] migration: Use output visitor in info command
In-Reply-To: <aqxUMH9Q3OtkV9oW@gallifrey> (David Alan Gilbert's message of
 "Thu, 17 Sep 2026 20:57:20 +0000")
References: <20260915000209.3692668-1-farosas@suse.de>
 <20260915000209.3692668-15-farosas@suse.de>
 <87zexg2ix9.fsf@pond.sub.org>
 <aqw0anGmdLfHtv3q@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <aqxUMH9Q3OtkV9oW@gallifrey>
Date: Fri, 18 Sep 2026 10:20:05 +0200
Message-ID: <87h5jnnf7u.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

"Dr. David Alan Gilbert" <dave@treblig.org> writes:

> * Peter Xu (peterx@redhat.com) wrote:
>> On Thu, Sep 17, 2026 at 01:53:22PM +0200, Markus Armbruster wrote:
>> > Fabiano Rosas <farosas@suse.de> writes:
>> > 
>> > > The hmp_info_migrate_parameters function currently open-codes the
>> > > mon_printf calls for each migration parameter. As with the set command
>> > > in the last patch, this should not be necessary as the QAPI
>> > > infrastructure already has generated code that takes type and struct
>> > > member names into account, including converting _ from C into the '-'
>> > > character as part of parameter names strings.
>> > >
>> > > The current code is also quite painful to rebase if a series has been
>> > > carried for a long time while parameters have been added in master.
>> > >
>> > > Replace all of this with a conversion from MigrationParameters to
>> > > QDict using an output visitor and a loop over the QDict that prints
>> > > per-QAPI-type formatted strings.
>> > >
>> > > Modelled after block/qapi.c:dump_qobject, but with some changes to
>> > > keep the migration command output formatting.
>> > >
>> > > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > 
>> > Old output of info migrate_parameters for me:
>> > 
>> >     announce-initial: 50
>> >     announce-max: 550
>> >     announce-rounds: 5
>> >     announce-step: 100
>> >     throttle-trigger-threshold: 50
>> >     cpu-throttle-initial: 20
>> >     cpu-throttle-increment: 10
>> >     cpu-throttle-tailslow: off
>> >     max-cpu-throttle: 99
>> >     tls-creds: 
>> >     tls-hostname: 
>> >     tls-authz: 
>> >     max-bandwidth: 134217728
>> >     avail-switchover-bandwidth: 0
>> >     max-postcopy-bandwidth: 0
>> >     downtime-limit: 300
>> >     x-checkpoint-delay: 20000
>> >     multifd-channels: 2
>> >     multifd-compression: none
>> >     zero-page-detection: multifd
>> >     xbzrle-cache-size: 67108864
>> >     x-vcpu-dirty-limit-period: 1000
>> >     vcpu-dirty-limit: 1
>> >     mode: normal
>> >     direct-io: off
>> >     x-rdma-chunk-size: 1048576
>> >     cpr-exec-command:
>> > 
>> > New output:
>> > 
>> >     cpu-throttle-tailslow: off
>> >     xbzrle-cache-size: 67108864
>> >     cpu-throttle-initial: 20
>> >     announce-max: 550
>> >     direct-io: off
>> >     avail-switchover-bandwidth: 0
>> >     local: off
>> >     zero-page-detection: multifd
>> >     multifd-qatzip-level: 1
>> >     x-rdma-chunk-size: 1048576
>> >     multifd-channels: 2
>> >     mode: normal
>> >     multifd-zstd-level: 1
>> >     announce-initial: 50
>> >     downtime-limit: 300
>> >     tls-authz: 
>> >     cpr-exec-command:
>> > 
>> >     vcpu-dirty-limit: 1
>> >     multifd-compression: none
>> >     announce-rounds: 5
>> >     announce-step: 100
>> >     tls-creds: 
>> >     x-vcpu-dirty-limit-period: 1000
>> >     multifd-zlib-level: 1
>> >     max-cpu-throttle: 99
>> >     max-postcopy-bandwidth: 0
>> >     tls-hostname: 
>> >     throttle-trigger-threshold: 50
>> >     max-bandwidth: 134217728
>> >     x-checkpoint-delay: 20000
>> >     cpu-throttle-increment: 10
>> > 
>> > New output has an unwanted blank line after "cpr-exec-command:".
>> > 
>> > New output adds @local, @multifd-qatzip-level, @multifd-zlib-level,
>> > @multifd-zstd-level.  Commit message should point that out.
>> > 
>> > Order of parameters changes, and not for the better.  Hmm.
>> 
>> Good point.. it might start to be awkward to users looking for tls-*,
>> multifd-*, announce-* or cpu-throttle*, etc. after this change, expecting
>> them grouped.
>> 
>> Maybe we can sort them by name with inserting top level to a QList first
>> from the QDict.
>
> Are there any filter visitors in qemu's visitor system - e.g. something that
> sorts?

No.  Visitors walk members in source order.  Source order is good as
long as we care to make it good.  But it doesn't help us here, because
we use the visitor only to convert to QObject, then walk that.  This
loses order.

If QDict iterated in insertion order, we'd be fine.  Python dict do.
Could be a fun little project for someone with time to spare.

The other solution is to iterate over sorted QDict keys, as Peter says.

> Dave
>
>> We won't be able to keep all relevant fields together, for example, we used
>> to have max-cpu-throttle together with cpu-throttle-*, now also separate
>> even with alphabetical order, but it's a special case of bad name since the
>> start.. where it could have been "cpu-throttle-max".  Meanwhile, as another
>> good side effect, we can finally have max-* fields together too.
>> 
>> -- 
>> Peter Xu
>> 


