Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FF8E95396
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncsV-0007eo-VG; Wed, 04 Feb 2026 08:25:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vncsU-0007d0-Ot
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:25:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vncsT-0003Xt-2y
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770211504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jO6Oag8JvgEdSrQFiblwJ20INZ+9aQQEIsf3Gd2bFMM=;
 b=X1p6TTIa05v6VBYH9xO3d6OU0D17uWn7w8RqhY6P6Aa8nPxfqo1ViJ3v/5vswSzbEZEjYp
 q2i7COwH94+Ou3SHFduPvUFRMzkgxLqxnNWsbV1imVIgSx1Zv9aEE3YyZ0Bcqj/v4ebWz2
 Qc7PC7xm0mwvK9/CrUZtWIpgBE8ARmU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-sbELeB7vP2C9Bh0gf0vnEQ-1; Wed,
 04 Feb 2026 08:25:01 -0500
X-MC-Unique: sbELeB7vP2C9Bh0gf0vnEQ-1
X-Mimecast-MFC-AGG-ID: sbELeB7vP2C9Bh0gf0vnEQ_1770211500
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE4DB1800454; Wed,  4 Feb 2026 13:24:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4701A1800465; Wed,  4 Feb 2026 13:24:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EADCF21E692D; Wed, 04 Feb 2026 14:24:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: <qemu-devel@nongnu.org>,  Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>,  Eric Blake <eblake@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Maor Gottlieb
 <maorg@nvidia.com>
Subject: Re: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
In-Reply-To: <87jywswslz.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 04 Feb 2026 14:22:48 +0100")
References: <20260202173406.13979-1-avihaih@nvidia.com>
 <87jywswslz.fsf@pond.sub.org>
Date: Wed, 04 Feb 2026 14:24:56 +0100
Message-ID: <87ecn0wsif.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Avihai Horon <avihaih@nvidia.com> writes:
>
>> The VFIO_MIGRATION event notifies users when a VFIO device transitions
>> to a new state.
>>
>> One use case for this event is to prevent timeouts for RDMA connections
>> to the migrated device. In this case, an external management application
>> (not libvirt) consumes the events and disables the RDMA timeout
>> mechanism when receiving the event for PRE_COPY_P2P state, which
>> indicates that the device is non-responsive.
>>
>> This is essential because RDMA connections typically have very low
>> timeouts (tens of milliseconds), which can be far below migration
>> downtime.
>>
>> However, under heavy resource utilization, the device transition to
>> PRE_COPY_P2P can take hundreds of milliseconds to complete. Since the
>> VFIO_MIGRATION event is currently sent only after the transition
>> completes, it arrives too late, after RDMA connections have already
>> timed out.
>>
>> To address this, send an additional "prepare" event immediately before
>> initiating the PRE_COPY_P2P transition. This guarantees timely event
>> delivery regardless of how long the actual state transition takes.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>
> [...]
>
>> diff --git a/qapi/vfio.json b/qapi/vfio.json
>> index a1a9c5b673..17b6046871 100644
>> --- a/qapi/vfio.json
>> +++ b/qapi/vfio.json
>> @@ -11,7 +11,13 @@
>>  ##
>>  # @QapiVfioMigrationState:
>>  #
>> -# An enumeration of the VFIO device migration states.
>> +# An enumeration of the VFIO device migration states.  In addition to
>> +# the regular states, there are prepare states (with 'prepare' suffix)
>> +# which indicate that the device is just about to transition to the
>> +# corresponding state.  Note that seeing a prepare state for state X
>> +# doesn't guarantee that the next state will be X, as the state
>> +# transition can fail and the device may transition to a different
>> +# state instead.
>>  #
>>  # @stop: The device is stopped.
>>  #
>> @@ -32,11 +38,14 @@
>>  #     tracking its internal state and its internal state is available
>>  #     for reading.
>>  #
>> +# @pre-copy-p2p-prepare: The device is just about to move to
>> +#     pre-copy-p2p state.  (since 11.0)
>> +#
>>  # Since: 9.1
>>  ##
>>  { 'enum': 'QapiVfioMigrationState',
>>    'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
>> -            'pre-copy', 'pre-copy-p2p' ] }
>> +            'pre-copy', 'pre-copy-p2p', 'pre-copy-p2p-prepare' ] }
>>  
>>  ##
>>  # @VFIO_MIGRATION:
>
> Acked-by: Markus Armbruster <armbru@redhat.com>

Except for the subject line: "vfio/migration: Send VFIO_MIGRATION event
before PRE_COPY_P2P transition" become misleading in v2.

>
> [...]


