Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D79C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 08:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiUYx-0007z3-Hi; Thu, 13 Feb 2025 03:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tiUYv-0007yS-2f
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 03:27:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tiUYt-0008Ml-Ai
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 03:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739435225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ix/AoNDQzhQCFiA1uAy1Iea2FXWb7pi6teoegkrP5M=;
 b=R+RbMjnYBlpWMTvSN0IYATFREaSufptfqL0W81t5vw86TRRDqqpohqbcPcN2kZp/JTHaH7
 Y2MdlwLIqqmi2nVWv8gwaA49rJd4E4UI0a2quA53X3sXJ1d2zFPi4JjFnVtHLyhnpNZpM+
 yv2DFKWTVYaz6w13P0BB+b+Dchuc2qM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-pqvS5D7GNY-pgITCzsga3Q-1; Thu,
 13 Feb 2025 03:27:03 -0500
X-MC-Unique: pqvS5D7GNY-pgITCzsga3Q-1
X-Mimecast-MFC-AGG-ID: pqvS5D7GNY-pgITCzsga3Q_1739435223
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8752D180034E; Thu, 13 Feb 2025 08:27:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A37531800359; Thu, 13 Feb 2025 08:27:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E889E21E6A28; Thu, 13 Feb 2025 09:26:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org,  qemu-devel@nongnu.org,  hreitz@redhat.com,
 kwolf@redhat.com
Subject: Re: [PATCH] qapi: merge common parts of NbdServerOptions and
 nbd-server-start data
In-Reply-To: <ky3eygomndpcfsxvcwt3aqdnyqmkerzx6zzmusj432gpof4gge@tsxlpcqazel4>
 (Eric Blake's message of "Wed, 12 Feb 2025 16:12:46 -0600")
References: <20250212143351.274931-1-vsementsov@yandex-team.ru>
 <ky3eygomndpcfsxvcwt3aqdnyqmkerzx6zzmusj432gpof4gge@tsxlpcqazel4>
Date: Thu, 13 Feb 2025 09:26:58 +0100
Message-ID: <875xlel06l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Eric Blake <eblake@redhat.com> writes:

> On Wed, Feb 12, 2025 at 05:33:51PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Instead of comment
>> "Keep this type consistent with the nbd-server-start arguments", we
>> can simply merge these things.
>> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>> 
>> No problem for me to rebase on top of
>> [PATCH 0/2] nbd: Allow debugging tuning of handshake limit
>> if it goes earlier.
>
> I just sent the pull request for that, so this will indeed need
> rebasing.  But it's still worth reviewing as written.
>
>> 
>> Also, not that order of nbd-server-start is changed. I think the order

s/not/note/, I presume.

>> could not be a contract of JSON interface.
>
> Correct - QMP does not mandate wire ordering, so although the change
> causes C paramter rearrangement, it is not a breaking change.

Correct.

>> We could instead of making common base structure go another way
>> and define two structures with same data=NbdServerOptionsCommon, and
>> different bases (will have to define additional base strucutres with
>> SocketAddress and SocketAddressLegacy fields). But it would look a bit
>> unusual in QAPI.
>> 
>>  blockdev-nbd.c         |  4 +--
>>  qapi/block-export.json | 57 ++++++++++++++++++++----------------------
>>  2 files changed, 29 insertions(+), 32 deletions(-)
>> 
>> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
>> index 9e61fbaf2b..b0b8993a1b 100644
>> --- a/blockdev-nbd.c
>> +++ b/blockdev-nbd.c
>> @@ -215,10 +215,10 @@ void nbd_server_start_options(NbdServerOptions *arg, Error **errp)
>>                       arg->max_connections, errp);
>>  }
>>  
>> -void qmp_nbd_server_start(SocketAddressLegacy *addr,
>> -                          const char *tls_creds,
>> +void qmp_nbd_server_start(const char *tls_creds,
>>                            const char *tls_authz,
>>                            bool has_max_connections, uint32_t max_connections,
>> +                          SocketAddressLegacy *addr,
>>                            Error **errp)
>>  {
>>      SocketAddress *addr_flat = socket_address_flatten(addr);
>> diff --git a/qapi/block-export.json b/qapi/block-export.json
>> index 117b05d13c..5eb94213db 100644
>> --- a/qapi/block-export.json
>> +++ b/qapi/block-export.json
>> @@ -9,13 +9,7 @@
>>  { 'include': 'block-core.json' }
>>  
>>  ##
>> -# @NbdServerOptions:
>> -#
>> -# Keep this type consistent with the nbd-server-start arguments.  The
>> -# only intended difference is using SocketAddress instead of
>> -# SocketAddressLegacy.
>> -#
>> -# @addr: Address on which to listen.
>> +# @NbdServerOptionsBase:
>>  #
>>  # @tls-creds: ID of the TLS credentials object (since 2.6).
>>  #
>> @@ -30,14 +24,35 @@
>>  #     server from advertising multiple client support (since 5.2;
>>  #     default: 100)
>>  #
>> -# Since: 4.2
>> +# Since: 10.0
>
> Markus, when refactoring types like this, should Since stay at the
> point in time where the fields were first introduced (4.2) or at the
> time where the refactoring introduced the new type (10.0)?  Or does
> type inlining make it all moot if this tag never shows up in the docs?

To answer this, we need to consider what doc comments are for:
documenting our external QMP interface for its users.

Types are not part of this QMP interface, only their members can be,
namely as arguments of commands and events, possibly nested into other
arguments.  Types can change in ways that do not affect the interface.
Like in this patch.

Since only members are part of the interface, only members need since
information.

Having to write down since information member by member all the time
would be onerous, so we provide a shorthand: write it down for the type,
and any members without explicit since use that.

This leads us to the answer to your question.  When you refactor types,
take care to preserve the interface documentation's since information,
just like you preserve the actual interface.

Much of the time, this is as trivial as "don't mess with since".

Sometimes, it involves things like adding a new type with an old since.

Occasionally, there's a conflict.  Say you unify two similar types into
one, a perfectly sane refactoring.  But the two types can have
conflicting since information.  Perhaps one type's member @foo goes back
to 4.2, and the other's goes back only to 9.1.  We don't have good
solutions for that.  We do our best in prose.

Maintaining accurate since information is bothersome and error prone.
It should be done by the machine, not us.  John and I have pondered ways
to do this, but we have other projects to finish first.

Questions?

[...]


