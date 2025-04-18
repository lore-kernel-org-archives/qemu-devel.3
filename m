Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23BAC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 06:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5fOo-0008T4-UH; Fri, 18 Apr 2025 02:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u5fOh-0008Ro-UV
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 02:40:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u5fOc-0001MP-6c
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 02:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744958415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yn4Y6/iyIohik6Hiuq4Mfx7LRi0wb/kzUBF2OR4PYFo=;
 b=G0B/wy1SxY2SoFBfE5EmAuH3+Hw38bnfDH36eiuZdhoBSjUWOkoektC+vcqfwXXJnx+azY
 AlFMkiM4Q2GL+fvwNqh8wmR8Z1aw121RbatSFMoOmnn9poru7NtL5xj1i9vQmnox/5l8cC
 9VbMEg9qkcUndk3n//iGIxeIwC4tobc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-YNzcno7UPq2bJD4WY5Ay_A-1; Fri,
 18 Apr 2025 02:40:11 -0400
X-MC-Unique: YNzcno7UPq2bJD4WY5Ay_A-1
X-Mimecast-MFC-AGG-ID: YNzcno7UPq2bJD4WY5Ay_A_1744958411
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D99E21956086; Fri, 18 Apr 2025 06:40:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4783E18001EA; Fri, 18 Apr 2025 06:40:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 92A5D21E66C3; Fri, 18 Apr 2025 08:40:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [RFC PATCH 05/13] migration: Reduce a bit of duplication in
 migration.json
In-Reply-To: <87zfgefwzx.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 17 Apr 2025 20:45:06 +0200")
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-6-farosas@suse.de> <87zfgefwzx.fsf@pond.sub.org>
Date: Fri, 18 Apr 2025 08:40:06 +0200
Message-ID: <87r01qdlbt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Introduce a new MigrationConfigBase, to allow most of the duplication
>> in migration.json to be eliminated.
>>
>> The reason we need MigrationParameters and MigrationSetParameters is
>> that the internal parameter representation in the migration code, as
>> well as the user-facing return of query-migrate-parameters use one
>> type for the TLS options (tls-creds, tls-hostname, tls-authz), while
>> the user-facing input from migrate-set-parameters uses another.
>>
>> The difference is in whether the NULL values is accepted. The former
>> considers NULL as invalid, while the latter doesn't.
>>
>> Move all other (non-TLS) options into the new type and make it a base
>> type for the two diverging types so that each child type can declare
>> the TLS options in its own way.
>>
>> Nothing changes in the user API, nothing changes in the internal
>> representation, but we save several lines of duplication in
>> migration.json.
>
> I double-checked the external interface.  There's a new member @tls, but
> you already told us it's an accident.
>
> Documentation does change.  More on that below.
>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  qapi/migration.json | 358 +++++++++++++-------------------------------
>>  1 file changed, 108 insertions(+), 250 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 8b9c53595c..5a4d5a2d3e 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -914,202 +914,6 @@
>>             'zero-page-detection',
>>             'direct-io'] }
>>  
>> -##
>> -# @MigrateSetParameters:
>> -#
>> -# @announce-initial: Initial delay (in milliseconds) before sending
>> -#     the first announce (Since 4.0)
>> -#
>> -# @announce-max: Maximum delay (in milliseconds) between packets in
>> -#     the announcement (Since 4.0)
>> -#
>> -# @announce-rounds: Number of self-announce packets sent after
>> -#     migration (Since 4.0)
>> -#
>> -# @announce-step: Increase in delay (in milliseconds) between
>> -#     subsequent packets in the announcement (Since 4.0)
>> -#
>> -# @throttle-trigger-threshold: The ratio of bytes_dirty_period and
>> -#     bytes_xfer_period to trigger throttling.  It is expressed as
>> -#     percentage.  The default value is 50.  (Since 5.0)
>> -#
>> -# @cpu-throttle-initial: Initial percentage of time guest cpus are
>> -#     throttled when migration auto-converge is activated.  The
>> -#     default value is 20.  (Since 2.7)
>> -#
>> -# @cpu-throttle-increment: throttle percentage increase each time
>> -#     auto-converge detects that migration is not making progress.
>> -#     The default value is 10.  (Since 2.7)
>> -#
>> -# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage At
>> -#     the tail stage of throttling, the Guest is very sensitive to CPU
>> -#     percentage while the @cpu-throttle -increment is excessive
>> -#     usually at tail stage.  If this parameter is true, we will
>> -#     compute the ideal CPU percentage used by the Guest, which may
>> -#     exactly make the dirty rate match the dirty rate threshold.
>> -#     Then we will choose a smaller throttle increment between the one
>> -#     specified by @cpu-throttle-increment and the one generated by
>> -#     ideal CPU percentage.  Therefore, it is compatible to
>> -#     traditional throttling, meanwhile the throttle increment won't
>> -#     be excessive at tail stage.  The default value is false.  (Since
>> -#     5.1)
>> -#
>> -# @tls-creds: ID of the 'tls-creds' object that provides credentials
>> -#     for establishing a TLS connection over the migration data
>> -#     channel.  On the outgoing side of the migration, the credentials
>> -#     must be for a 'client' endpoint, while for the incoming side the
>> -#     credentials must be for a 'server' endpoint.  Setting this to a
>> -#     non-empty string enables TLS for all migrations.  An empty
>> -#     string means that QEMU will use plain text mode for migration,
>> -#     rather than TLS.  This is the default.  (Since 2.7)
>> -#
>> -# @tls-hostname: migration target's hostname for validating the
>> -#     server's x509 certificate identity.  If empty, QEMU will use the
>> -#     hostname from the migration URI, if any.  A non-empty value is
>> -#     required when using x509 based TLS credentials and the migration
>> -#     URI does not include a hostname, such as fd: or exec: based
>> -#     migration.  (Since 2.7)
>> -#
>> -#     Note: empty value works only since 2.9.
>> -#
>> -# @tls-authz: ID of the 'authz' object subclass that provides access
>> -#     control checking of the TLS x509 certificate distinguished name.
>> -#     This object is only resolved at time of use, so can be deleted
>> -#     and recreated on the fly while the migration server is active.
>> -#     If missing, it will default to denying access (Since 4.0)
>> -#
>> -# @max-bandwidth: maximum speed for migration, in bytes per second.
>> -#     (Since 2.8)
>> -#
>> -# @avail-switchover-bandwidth: to set the available bandwidth that
>> -#     migration can use during switchover phase.  NOTE!  This does not
>> -#     limit the bandwidth during switchover, but only for calculations
>> -#     when making decisions to switchover.  By default, this value is
>> -#     zero, which means QEMU will estimate the bandwidth
>> -#     automatically.  This can be set when the estimated value is not
>> -#     accurate, while the user is able to guarantee such bandwidth is
>> -#     available when switching over.  When specified correctly, this
>> -#     can make the switchover decision much more accurate.
>> -#     (Since 8.2)
>> -#
>> -# @downtime-limit: set maximum tolerated downtime for migration.
>> -#     maximum downtime in milliseconds (Since 2.8)
>> -#
>> -# @x-checkpoint-delay: The delay time (in ms) between two COLO
>> -#     checkpoints in periodic mode.  (Since 2.8)
>> -#
>> -# @multifd-channels: Number of channels used to migrate data in
>> -#     parallel.  This is the same number that the number of sockets
>> -#     used for migration.  The default value is 2 (since 4.0)
>> -#
>> -# @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
>> -#     needs to be a multiple of the target page size and a power of 2
>> -#     (Since 2.11)
>> -#
>> -# @max-postcopy-bandwidth: Background transfer bandwidth during
>> -#     postcopy.  Defaults to 0 (unlimited).  In bytes per second.
>> -#     (Since 3.0)
>> -#
>> -# @max-cpu-throttle: maximum cpu throttle percentage.  Defaults to 99.
>> -#     (Since 3.1)
>> -#
>> -# @multifd-compression: Which compression method to use.  Defaults to
>> -#     none.  (Since 5.0)
>> -#
>> -# @multifd-zlib-level: Set the compression level to be used in live
>> -#     migration, the compression level is an integer between 0 and 9,
>> -#     where 0 means no compression, 1 means the best compression
>> -#     speed, and 9 means best compression ratio which will consume
>> -#     more CPU.  Defaults to 1.  (Since 5.0)
>> -#
>> -# @multifd-qatzip-level: Set the compression level to be used in live
>> -#     migration. The level is an integer between 1 and 9, where 1 means
>> -#     the best compression speed, and 9 means the best compression
>> -#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
>> -#
>> -# @multifd-zstd-level: Set the compression level to be used in live
>> -#     migration, the compression level is an integer between 0 and 20,
>> -#     where 0 means no compression, 1 means the best compression
>> -#     speed, and 20 means best compression ratio which will consume
>> -#     more CPU.  Defaults to 1.  (Since 5.0)
>> -#
>> -# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
>> -#     aliases for the purpose of dirty bitmap migration.  Such aliases
>> -#     may for example be the corresponding names on the opposite site.
>> -#     The mapping must be one-to-one, but not necessarily complete: On
>> -#     the source, unmapped bitmaps and all bitmaps on unmapped nodes
>> -#     will be ignored.  On the destination, encountering an unmapped
>> -#     alias in the incoming migration stream will result in a report,
>> -#     and all further bitmap migration data will then be discarded.
>> -#     Note that the destination does not know about bitmaps it does
>> -#     not receive, so there is no limitation or requirement regarding
>> -#     the number of bitmaps received, or how they are named, or on
>> -#     which nodes they are placed.  By default (when this parameter
>> -#     has never been set), bitmap names are mapped to themselves.
>> -#     Nodes are mapped to their block device name if there is one, and
>> -#     to their node name otherwise.  (Since 5.2)
>> -#
>> -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
>> -#     limit during live migration.  Should be in the range 1 to
>> -#     1000ms.  Defaults to 1000ms.  (Since 8.1)
>> -#
>> -# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
>> -#     Defaults to 1.  (Since 8.1)
>> -#
>> -# @mode: Migration mode.  See description in @MigMode.  Default is
>> -#     'normal'.  (Since 8.2)
>> -#
>> -# @zero-page-detection: Whether and how to detect zero pages.
>> -#     See description in @ZeroPageDetection.  Default is 'multifd'.
>> -#     (since 9.0)
>> -#
>> -# @direct-io: Open migration files with O_DIRECT when possible.  This
>> -#     only has effect if the @mapped-ram capability is enabled.
>> -#     (Since 9.1)
>> -#
>> -# Features:
>> -#
>> -# @unstable: Members @x-checkpoint-delay and
>> -#     @x-vcpu-dirty-limit-period are experimental.
>> -#
>> -# TODO: either fuse back into MigrationParameters, or make
>> -#     MigrationParameters members mandatory
>> -#
>> -# Since: 2.4
>> -##
>> -{ 'struct': 'MigrateSetParameters',
>> -  'data': { '*announce-initial': 'size',
>> -            '*announce-max': 'size',
>> -            '*announce-rounds': 'size',
>> -            '*announce-step': 'size',
>> -            '*throttle-trigger-threshold': 'uint8',
>> -            '*cpu-throttle-initial': 'uint8',
>> -            '*cpu-throttle-increment': 'uint8',
>> -            '*cpu-throttle-tailslow': 'bool',
>> -            '*tls-creds': 'StrOrNull',
>> -            '*tls-hostname': 'StrOrNull',
>> -            '*tls-authz': 'StrOrNull',
>> -            '*max-bandwidth': 'size',
>> -            '*avail-switchover-bandwidth': 'size',
>> -            '*downtime-limit': 'uint64',
>> -            '*x-checkpoint-delay': { 'type': 'uint32',
>> -                                     'features': [ 'unstable' ] },
>> -            '*multifd-channels': 'uint8',
>> -            '*xbzrle-cache-size': 'size',
>> -            '*max-postcopy-bandwidth': 'size',
>> -            '*max-cpu-throttle': 'uint8',
>> -            '*multifd-compression': 'MultiFDCompression',
>> -            '*multifd-zlib-level': 'uint8',
>> -            '*multifd-qatzip-level': 'uint8',
>> -            '*multifd-zstd-level': 'uint8',
>> -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>> -            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>> -                                            'features': [ 'unstable' ] },
>> -            '*vcpu-dirty-limit': 'uint64',
>> -            '*mode': 'MigMode',
>> -            '*zero-page-detection': 'ZeroPageDetection',
>> -            '*direct-io': 'bool' } }
>> -
>>  ##
>>  # @migrate-set-parameters:
>>  #
>> @@ -1127,9 +931,7 @@
>>    'data': 'MigrateSetParameters' }
>>  
>>  ##
>> -# @MigrationParameters:
>> -#
>> -# The optional members aren't actually optional.
>> +# @MigrationConfigBase:
>>  #
>>  # @announce-initial: Initial delay (in milliseconds) before sending
>>  #     the first announce (Since 4.0)
>> @@ -1168,26 +970,6 @@
>>  #     be excessive at tail stage.  The default value is false.  (Since
>>  #     5.1)
>>  #
>> -# @tls-creds: ID of the 'tls-creds' object that provides credentials
>> -#     for establishing a TLS connection over the migration data
>> -#     channel.  On the outgoing side of the migration, the credentials
>> -#     must be for a 'client' endpoint, while for the incoming side the
>> -#     credentials must be for a 'server' endpoint.  An empty string
>> -#     means that QEMU will use plain text mode for migration, rather
>> -#     than TLS.  (Since 2.7)
>> -#
>> -#     Note: 2.8 omits empty @tls-creds instead.
>> -#
>> -# @tls-hostname: migration target's hostname for validating the
>> -#     server's x509 certificate identity.  If empty, QEMU will use the
>> -#     hostname from the migration URI, if any.  (Since 2.7)
>> -#
>> -#     Note: 2.8 omits empty @tls-hostname instead.
>> -#
>> -# @tls-authz: ID of the 'authz' object subclass that provides access
>> -#     control checking of the TLS x509 certificate distinguished name.
>> -#     (Since 4.0)
>> -#
>>  # @max-bandwidth: maximum speed for migration, in bytes per second.
>>  #     (Since 2.8)
>>  #
>> @@ -1277,45 +1059,121 @@
>>  #     only has effect if the @mapped-ram capability is enabled.
>>  #     (Since 9.1)
>>  #
>> +# @tls: Whether to use TLS. If this is set the options @tls-authz,
>> +#     @tls-creds, @tls-hostname are mandatory and a valid string is
>> +#     expected. (Since 10.1)
>> +#
>>  # Features:
>>  #
>>  # @unstable: Members @x-checkpoint-delay and
>>  #     @x-vcpu-dirty-limit-period are experimental.
>>  #
>> +# Since: 10.1
>> +##
>> +{ 'struct': 'MigrationConfigBase',
>> +  'data': { '*announce-initial': 'size',
>> +            '*announce-max': 'size',
>> +            '*announce-rounds': 'size',
>> +            '*announce-step': 'size',
>> +            '*throttle-trigger-threshold': 'uint8',
>> +            '*cpu-throttle-initial': 'uint8',
>> +            '*cpu-throttle-increment': 'uint8',
>> +            '*cpu-throttle-tailslow': 'bool',
>> +            '*max-bandwidth': 'size',
>> +            '*avail-switchover-bandwidth': 'size',
>> +            '*downtime-limit': 'uint64',
>> +            '*x-checkpoint-delay': { 'type': 'uint32',
>> +                                     'features': [ 'unstable' ] },
>> +            '*multifd-channels': 'uint8',
>> +            '*xbzrle-cache-size': 'size',
>> +            '*max-postcopy-bandwidth': 'size',
>> +            '*max-cpu-throttle': 'uint8',
>> +            '*multifd-compression': 'MultiFDCompression',
>> +            '*multifd-zlib-level': 'uint8',
>> +            '*multifd-qatzip-level': 'uint8',
>> +            '*multifd-zstd-level': 'uint8',
>> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>> +            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>> +                                            'features': [ 'unstable' ] },
>> +            '*vcpu-dirty-limit': 'uint64',
>> +            '*mode': 'MigMode',
>> +            '*zero-page-detection': 'ZeroPageDetection',
>> +            '*direct-io': 'bool',
>> +            '*tls': 'bool' } }
>> +
>> +##
>> +# @MigrationParameters:
>> +#
>> +# The optional members of the base type aren't actually optional.
>> +#
>> +# @tls-creds: ID of the 'tls-creds' object that provides credentials
>> +#     for establishing a TLS connection over the migration data
>> +#     channel.  On the outgoing side of the migration, the credentials
>> +#     must be for a 'client' endpoint, while for the incoming side the
>> +#     credentials must be for a 'server' endpoint.  Setting this to a
>> +#     non-empty string enables TLS for all migrations.  An empty
>> +#     string means that QEMU will use plain text mode for migration,
>> +#     rather than TLS.  (Since 2.7)
>> +#
>> +# @tls-hostname: migration target's hostname for validating the
>> +#     server's x509 certificate identity.  If empty, QEMU will use the
>> +#     hostname from the migration URI, if any.  A non-empty value is
>> +#     required when using x509 based TLS credentials and the migration
>> +#     URI does not include a hostname, such as fd: or exec: based
>> +#     migration.  (Since 2.7)
>> +#
>> +#     Note: empty value works only since 2.9.
>> +#
>> +# @tls-authz: ID of the 'authz' object subclass that provides access
>> +#     control checking of the TLS x509 certificate distinguished name.
>> +#     This object is only resolved at time of use, so can be deleted
>> +#     and recreated on the fly while the migration server is active.
>> +#     If missing, it will default to denying access (Since 4.0)
>> +#
>>  # Since: 2.4
>>  ##
>>  { 'struct': 'MigrationParameters',
>> -  'data': { '*announce-initial': 'size',
>> -            '*announce-max': 'size',
>> -            '*announce-rounds': 'size',
>> -            '*announce-step': 'size',
>> -            '*throttle-trigger-threshold': 'uint8',
>> -            '*cpu-throttle-initial': 'uint8',
>> -            '*cpu-throttle-increment': 'uint8',
>> -            '*cpu-throttle-tailslow': 'bool',
>> -            '*tls-creds': 'str',
>> -            '*tls-hostname': 'str',
>> -            '*tls-authz': 'str',
>> -            '*max-bandwidth': 'size',
>> -            '*avail-switchover-bandwidth': 'size',
>> -            '*downtime-limit': 'uint64',
>> -            '*x-checkpoint-delay': { 'type': 'uint32',
>> -                                     'features': [ 'unstable' ] },
>> -            '*multifd-channels': 'uint8',
>> -            '*xbzrle-cache-size': 'size',
>> -            '*max-postcopy-bandwidth': 'size',
>> -            '*max-cpu-throttle': 'uint8',
>> -            '*multifd-compression': 'MultiFDCompression',
>> -            '*multifd-zlib-level': 'uint8',
>> -            '*multifd-qatzip-level': 'uint8',
>> -            '*multifd-zstd-level': 'uint8',
>> -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>> -            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>> -                                            'features': [ 'unstable' ] },
>> -            '*vcpu-dirty-limit': 'uint64',
>> -            '*mode': 'MigMode',
>> -            '*zero-page-detection': 'ZeroPageDetection',
>> -            '*direct-io': 'bool' } }
>> +  'base': 'MigrationConfigBase',
>> +  'data': { 'tls-creds': 'str',
>> +            'tls-hostname': 'str',
>> +            'tls-authz': 'str' } }
>> +
>> +##
>> +# @MigrateSetParameters:
>> +#
>> +# Compatibility layer to accept null values for the TLS options.
>> +#
>> +# @tls-creds: ID of the 'tls-creds' object that provides credentials
>> +#     for establishing a TLS connection over the migration data
>> +#     channel.  On the outgoing side of the migration, the credentials
>> +#     must be for a 'client' endpoint, while for the incoming side the
>> +#     credentials must be for a 'server' endpoint.  Setting this to a
>> +#     non-empty string enables TLS for all migrations.  An empty
>> +#     string means that QEMU will use plain text mode for migration,
>> +#     rather than TLS.  This is the default.  (Since 2.7)
>> +#
>> +# @tls-hostname: migration target's hostname for validating the
>> +#     server's x509 certificate identity.  If empty, QEMU will use the
>> +#     hostname from the migration URI, if any.  A non-empty value is
>> +#     required when using x509 based TLS credentials and the migration
>> +#     URI does not include a hostname, such as fd: or exec: based
>> +#     migration.  (Since 2.7)
>> +#
>> +#     Note: empty value works only since 2.9.
>> +#
>> +# @tls-authz: ID of the 'authz' object subclass that provides access
>> +#     control checking of the TLS x509 certificate distinguished name.
>> +#     This object is only resolved at time of use, so can be deleted
>> +#     and recreated on the fly while the migration server is active.
>> +#     If missing, it will default to denying access (Since 4.0)
>> +#
>> +# Since: 2.4
>> +##
>> +{ 'struct': 'MigrateSetParameters',
>> +  'base': 'MigrationConfigBase',
>> +  'data': { '*tls-creds': 'StrOrNull',
>> +            '*tls-hostname': 'StrOrNull',
>> +            '*tls-authz': 'StrOrNull' } }
>>  
>>  ##
>>  # @query-migrate-parameters:
>
> Your change is fairly simple, but that's not obvious from the diff.
>
> 1. Move everything but the TLS stuff from MigrationParameters to its new
>    base type MigrationConfigBase.
>
>    No change to the interface, obviously.
>
>    Introspection hides the base type, and shows members of
>    MigrationParameters in a different order, but order doesn't matter.
>
>    The doc generator isn't smart enough (yet) to hide the base type.
>    Apart from that, documentation is unchanged.
>
> 2. Replace everything but the TLS stuff from MigrateSetParameters by
>    base type MigrateSetParameters.
>
>    Because the base type's members are identical to the members it
>    replaces, no change to the interface.
>
>    Introspection hides the base type, and shows members of
>    MigrateSetParameters in a different order, but order doesn't matter.
>
>    The base type's member documentation is *not* identical to the member
>    documentation it replaces.  To see the differences, I ran
>    sphinx-build with -b text before and after, and fed its output to
>    diff:
>
>        * **cpu-throttle-initial** ("int", *optional*) -- Initial
>          percentage of time guest cpus are throttled when migration
> -        auto-converge is activated.  The default value is 20.  (Since
> -        2.7)
> +        auto-converge is activated.  (Since 2.7)
>
>    We no longer document the default value.  This is wrong.
>
>    The difference before the patch makes some sense.  The members of
>    MigrateSetParameters are actually optional command arguments, and
>    their defaults must be documented.  The members of
>    MigrationParameters aren't actually optional, and talking about
>    defaults is misleading there.  We do it anyway in a few places.
>
>    Factoring out MigrationConfigBase leads to a conflict: in its role as
>    base of MigrationParameters, it shouldn't talk about defaults, and in
>    its role as base of MigrateSetParameters, it should document the
>    defaults supplied by migrate-set-parameters.
>
>    There is no perfectly satisfactory solution with our current
>    infrastructure.
>
>    We can elect to ignore the problem for now.  Point it out in a TODO
>    comment.
>
>    We can try to explain in the doc text that default values apply only
>    to migrate-set-parameters.  I expect this to be awkward.  More
>    awkward once the doc generator inlines stuff.
>
>        * **cpu-throttle-increment** ("int", *optional*) -- throttle
>          percentage increase each time auto-converge detects that
> -        migration is not making progress. The default value is 10.
> -        (Since 2.7)
> +        migration is not making progress. (Since 2.7)
>  
>     Likewise.
>  
> -      * **x-checkpoint-delay** ("int", *optional*) -- The delay time
> -        (in ms) between two COLO checkpoints in periodic mode.  (Since
> -        2.8)
> +      * **x-checkpoint-delay** ("int", *optional*) -- the delay time
> +        between two COLO checkpoints. (Since 2.8)
>  
>     Inconsistent before the patch.  The deleted version is better.  Easy
>     enough to fix.
>  
> +      * **tls** ("boolean", *optional*) -- Whether to use TLS. If this
> +        is set the options "tls-authz", "tls-creds", "tls-hostname"
> +        are mandatory and a valid string is expected. (Since 10.1)
> +
>
>     Accident.

I missed

>    base type MigrateSetParameters.
>
>    Because the base type's members are identical to the members it
>    replaces, no change to the interface.
>
>    Introspection hides the base type, and shows members of
>    MigrateSetParameters in a different order, but order doesn't matter.
>
>    The base type's member documentation is *not* identical to the member
>    documentation it replaces.  To see the differences, I ran
>    sphinx-build with -b text before and after, and fed its output to
>    diff:
>
>        * **cpu-throttle-initial** ("int", *optional*) -- Initial
>          percentage of time guest cpus are throttled when migration
> -        auto-converge is activated.  The default value is 20.  (Since
> -        2.7)
> +        auto-converge is activated.  (Since 2.7)
>
>    We no longer document the default value.  This is wrong.
>
>    The difference before the patch makes some sense.  The members of
>    MigrateSetParameters are actually optional command arguments, and
>    their defaults must be documented.  The members of
>    MigrationParameters aren't actually optional, and talking about
>    defaults is misleading there.  We do it anyway in a few places.
>
>    Factoring out MigrationConfigBase leads to a conflict: in its role as
>    base of MigrationParameters, it shouldn't talk about defaults, and in
>    its role as base of MigrateSetParameters, it should document the
>    defaults supplied by migrate-set-parameters.
>
>    There is no perfectly satisfactory solution with our current
>    infrastructure.
>
>    We can elect to ignore the problem for now.  Point it out in a TODO
>    comment.
>
>    We can try to explain in the doc text that default values apply only
>    to migrate-set-parameters.  I expect this to be awkward.  More
>    awkward once the doc generator inlines stuff.
>
>        * **cpu-throttle-increment** ("int", *optional*) -- throttle
>          percentage increase each time auto-converge detects that
> -        migration is not making progress. The default value is 10.
> -        (Since 2.7)
> +        migration is not making progress. (Since 2.7)
>  
>     Likewise.
>  
> -      * **x-checkpoint-delay** ("int", *optional*) -- The delay time
> -        (in ms) between two COLO checkpoints in periodic mode.  (Since
> -        2.8)
> +      * **x-checkpoint-delay** ("int", *optional*) -- the delay time
> +        between two COLO checkpoints. (Since 2.8)
>  
>     Inconsistent before the patch.  The deleted version is better.  Easy
>     enough to fix.
>  
> +      * **tls** ("boolean", *optional*) -- Whether to use TLS. If this
> +        is set the options "tls-authz", "tls-creds", "tls-hostname"
> +        are mandatory and a valid string is expected. (Since 10.1)
> +
>
>     Accident.

I missed

  3. Make @tls-creds, @tls-hostname, @tls-authz non-optional in
     MigrationParameters.
  
     Compatible change to the interface.

When my description of what a patch does goes 1. 2. 3., then splitting
it up could be in order.  Especially when I miss 3. initially :)


