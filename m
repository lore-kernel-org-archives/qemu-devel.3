Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F76C02198
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 05:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfuqz-0000lc-9h; Thu, 06 Feb 2025 00:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfuqu-0000hX-9h
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 00:55:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfuqq-0007vS-Es
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 00:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738821298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dIYDusc2XcNruvmjjRc5suAl1eeNqwdGNMyK8ZsRFEg=;
 b=L/R0yUPqJzhQ/xjUNakRIDIOb4K5p/v6PSsd7EgJpLwpOvLR9UXE9MLnIhH4w1AdZfeoNn
 55hTnP4x6FZXogFy46fQi+33iFWj7NQUOawv9SYbrbzbquJWDoXe67gFlAKOSBOOn3Sa3W
 6qN9PoRlaqgD5Vt83EzhnXFW+dpezZE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-vFEVTo55OgKUCExPPCipNA-1; Thu,
 06 Feb 2025 00:54:54 -0500
X-MC-Unique: vFEVTo55OgKUCExPPCipNA-1
X-Mimecast-MFC-AGG-ID: vFEVTo55OgKUCExPPCipNA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC1ED1955D82; Thu,  6 Feb 2025 05:54:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20026195608D; Thu,  6 Feb 2025 05:54:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 056DF21E6A28; Thu, 06 Feb 2025 06:54:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 2/2] nbd/server: Allow users to adjust handshake limit
 in QMP
In-Reply-To: <ia55sowaqjkpwbq7yum42m5vuw5octffzx6sqsvwsnsueqaf54@cetnceyik5op>
 (Eric Blake's message of "Wed, 5 Feb 2025 14:36:05 -0600")
References: <20250203222722.650694-4-eblake@redhat.com>
 <20250203222722.650694-6-eblake@redhat.com>
 <87h6587udf.fsf@pond.sub.org>
 <ia55sowaqjkpwbq7yum42m5vuw5octffzx6sqsvwsnsueqaf54@cetnceyik5op>
Date: Thu, 06 Feb 2025 06:54:48 +0100
Message-ID: <87ikpnvcrb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Eric Blake <eblake@redhat.com> writes:

> On Wed, Feb 05, 2025 at 07:55:56AM +0100, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>> > Although defaulting the handshake limit to 10 seconds was a nice QoI
>> > change to weed out intentionally slow clients, it can interfere with
>> > integration testing done with manual NBD_OPT commands over 'nbdsh
>> > --opt-mode'.  Expose a QMP knob 'handshake-max-secs' to allow the user
>> > to alter the timeout away from the default.
>> >
>> > The parameter name here intentionally matches the spelling of the
>> > constant added in commit fb1c2aaa98, and not the command-line spelling
>> > added in the previous patch for qemu-nbd; that's because in QMP,
>> > longer names serve as good self-documentation, and unlike the command
>> > line, machines don't have problems generating longer spellings.
>> >
>
>> >  { 'struct': 'NbdServerOptions',
>> >    'data': { 'addr': 'SocketAddress',
>> > +            '*handshake-max-secs': 'uint32',
>> >              '*tls-creds': 'str',
>> >              '*tls-authz': 'str',
>> >              '*max-connections': 'uint32' } }
>> 
>> Standard question on time: are we confident the granularity will
>> suffice?
>
> The default if this is unspecified is 10 seconds.  Anything subsecond
> requires a fast negotiation between client and server; the more likely
> use of this parameter is setting it extremely large (or to 0 to
> disable) in order to allow lengthy gdb sessions without the timeout
> cutting things short.  So I think seconds is okay.

ACK

>> On naming...  We use "seconds" (StatsUnit in qapi/stats.json), and "sec"
>> (SnapshotInfo in qapi/block-core.json), but not "secs".  Do we care?
>
> Avoiding abbreviations and using 'seconds' is fine by me, especially
> since this won't be typed by many users but remains more of a tool for
> use in a debugging arsenel.  I can respin with the longer name, but
> will wait for any other review comments first.

I like "seconds".

Thanks!


