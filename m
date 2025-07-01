Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2C2C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 08:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWWIl-000351-LK; Tue, 01 Jul 2025 04:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWWIj-00032o-Lg
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWWIf-0006KJ-Q0
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751358306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3zTgEh4BvEEzL46s1pc7IJS5mPWU8IieF8laSoNDYXw=;
 b=GJICd3aI89W4MtdDyLP3dnrE7Yuxfi6CXCzaKD+bersO2cCfpSEW/s7zyw0Yh64iBypLNx
 /gjuk2ZxlGu6YhpxU3vUfpjB3uoqMXy3jd0ZCKMYZ9AoqHgUV0y7hB8BqVIC6BCCRlApT6
 CsdUHUohuuRaAueweuFT5a11Rgw8Y+U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-FbtqZBpSOUWHSGNzZRZslA-1; Tue,
 01 Jul 2025 04:25:05 -0400
X-MC-Unique: FbtqZBpSOUWHSGNzZRZslA-1
X-Mimecast-MFC-AGG-ID: FbtqZBpSOUWHSGNzZRZslA_1751358305
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4CBA1800268; Tue,  1 Jul 2025 08:25:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 313A419560AB; Tue,  1 Jul 2025 08:25:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 81D8621E6A27; Tue, 01 Jul 2025 10:25:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Peter Xu
 <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 16/24] migration: Add capabilities into
 MigrationParameters
In-Reply-To: <20250630195913.28033-17-farosas@suse.de> (Fabiano Rosas's
 message of "Mon, 30 Jun 2025 16:59:05 -0300")
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-17-farosas@suse.de>
Date: Tue, 01 Jul 2025 10:25:01 +0200
Message-ID: <87jz4sz5b6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Add capabilities to MigrationParameters. This structure will hold all
> migration options. Capabilities will go away in the next patch.
>
> Also add capabilities to MigrationParameter as the enum needs to be
> kept in sync with MigrationParameters. This affects the parsing of
> migration HMP commands so make the necessary additions there too.
>
> From this point on, both QMP and HMP versions of
> migrate-set-parameters and query-migrate-parameters gain the ability
> to work with capabilities.
>
> With MigrationParameters now having members for each capability, the
> migration capabilities commands (query-migrate-capabilities,
> migrate-set-capabilities) will soon be deprecated. Add a set of
> helpers to convert between the old MigrationCapability representation
> and the new representation as members of MigrationParameters.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 40e00fb86e..3d3f5624c5 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -763,7 +763,14 @@
>             'vcpu-dirty-limit',
>             'mode',
>             'zero-page-detection',
> -           'direct-io'] }
> +           'direct-io', 'xbzrle', 'rdma-pin-all', 'auto-converge',
> +           'zero-blocks', 'events', 'postcopy-ram', 'x-colo',
> +           'release-ram', 'return-path', 'pause-before-switchover',
> +           'multifd', 'dirty-bitmaps', 'postcopy-blocktime',
> +           'late-block-activate', 'x-ignore-shared',
> +           'validate-uuid', 'background-snapshot',
> +           'zero-copy-send', 'postcopy-preempt',
> +           'switchover-ack', 'dirty-limit', 'mapped-ram' ] }

This is MigrateParameter.  Different order than in MigrationParameters.
Intentional?

>  
>  ##
>  # @migrate-set-parameters:
> @@ -934,10 +941,108 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @xbzrle: Migration supports xbzrle (Xor Based Zero Run Length
> +#     Encoding).  This feature allows us to minimize migration traffic
> +#     for certain work loads, by sending compressed difference of the
> +#     pages
> +#
> +# @rdma-pin-all: Controls whether or not the entire VM memory
> +#     footprint is mlock()'d on demand or all at once.  Refer to
> +#     docs/rdma.txt for usage.  Disabled by default.  (since 2.0)
> +#
> +# @zero-blocks: During storage migration encode blocks of zeroes
> +#     efficiently.  This essentially saves 1MB of zeroes per block on
> +#     the wire.  Enabling requires source and target VM to support
> +#     this feature.  To enable it is sufficient to enable the
> +#     capability on the source VM.  The feature is disabled by
> +#     default.  (since 1.6)
> +#
> +# @events: generate events for each migration state change (since 2.4)
> +#
> +# @auto-converge: If enabled, QEMU will automatically throttle down
> +#     the guest to speed up convergence of RAM migration.  (since 1.6)
> +#
> +# @postcopy-ram: Start executing on the migration target before all of
> +#     RAM has been migrated, pulling the remaining pages along as
> +#     needed.  The capacity must have the same setting on both source
> +#     and target or migration will not even start.  NOTE: If the

Make this

   #     and target or migration will not even start.  **Note:** if the

Crossed with commit 188b31ad425c (qapi: Use proper markup instead of
CAPS for emphasis in doc comments).

> +#     migration fails during postcopy the VM will fail.  (since 2.6)
> +#
> +# @x-colo: If enabled, migration will never end, and the state of the
> +#     VM on the primary side will be migrated continuously to the VM
> +#     on secondary side, this process is called COarse-Grain LOck
> +#     Stepping (COLO) for Non-stop Service.  (since 2.8)
> +#
> +# @release-ram: if enabled, qemu will free the migrated ram pages on

And this

   # @release-ram: if enabled, QEMU will free the migrated ram pages on

Crossed with commit 6263225492ba (qapi: Correct spelling of QEMU in doc
comments).

> +#     the source during postcopy-ram migration.  (since 2.9)
> +#
> +# @return-path: If enabled, migration will use the return path even
> +#     for precopy.  (since 2.10)
> +#
> +# @pause-before-switchover: Pause outgoing migration before
> +#     serialising device state and before disabling block IO (since
> +#     2.11)

   #     serialising device state and before disabling block IO
   #     (since 2.11)

Crossed with commit c1a6aa1d443e (qapi: Avoid breaking lines within
(since X.Y))

> +#
> +# @multifd: Use more than one fd for migration (since 4.0)
> +#
> +# @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.
> +#     (since 2.12)
> +#
> +# @postcopy-blocktime: Calculate downtime for postcopy live migration
> +#     (since 3.0)
> +#
> +# @late-block-activate: If enabled, the destination will not activate
> +#     block devices (and thus take locks) immediately at the end of
> +#     migration.  (since 3.0)
> +#
> +# @x-ignore-shared: If enabled, QEMU will not migrate shared memory
> +#     that is accessible on the destination machine.  (since 4.0)
> +#
> +# @validate-uuid: Send the UUID of the source to allow the destination
> +#     to ensure it is the same.  (since 4.2)
> +#
> +# @background-snapshot: If enabled, the migration stream will be a
> +#     snapshot of the VM exactly at the point when the migration
> +#     procedure starts.  The VM RAM is saved with running VM.
> +#     (since 6.0)
> +#
> +# @zero-copy-send: Controls behavior on sending memory pages on
> +#     migration.  When true, enables a zero-copy mechanism for sending
> +#     memory pages, if host supports it.  Requires that QEMU be
> +#     permitted to use locked memory for guest RAM pages.  (since 7.1)
> +#
> +# @postcopy-preempt: If enabled, the migration process will allow
> +#     postcopy requests to preempt precopy stream, so postcopy
> +#     requests will be handled faster.  This is a performance feature
> +#     and should not affect the correctness of postcopy migration.
> +#     (since 7.1)
> +#
> +# @switchover-ack: If enabled, migration will not stop the source VM
> +#     and complete the migration until an ACK is received from the
> +#     destination that it's OK to do so.  Exactly when this ACK is
> +#     sent depends on the migrated devices that use this feature.  For
> +#     example, a device can use it to make sure some of its data is
> +#     sent and loaded in the destination before doing switchover.
> +#     This can reduce downtime if devices that support this capability
> +#     are present.  'return-path' capability must be enabled to use
> +#     it.  (since 8.1)
> +#
> +# @dirty-limit: If enabled, migration will throttle vCPUs as needed to
> +#     keep their dirty page rate within @vcpu-dirty-limit.  This can
> +#     improve responsiveness of large guests during live migration,
> +#     and can result in more stable read performance.  Requires KVM
> +#     with accelerator property "dirty-ring-size" set.  (Since 8.1)
> +#
> +# @mapped-ram: Migrate using fixed offsets in the migration file for
> +#     each RAM page.  Requires a migration URI that supports seeking,
> +#     such as a file.  (since 9.0)
> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> -#     @x-vcpu-dirty-limit-period are experimental.
> +# @unstable: Members @x-checkpoint-delay, @x-vcpu-dirty-limit-period,
> +#     @x-colo and @x-ignore-shared are experimental.
> +# @deprecated: Member @zero-blocks is deprecated as being part of
> +#     block migration which was already removed.
>  #
>  # Since: 2.4
>  ##
> @@ -972,7 +1077,29 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*direct-io': 'bool' } }
> +            '*direct-io': 'bool',
> +            '*xbzrle': 'bool',
> +            '*rdma-pin-all': 'bool',
> +            '*auto-converge': 'bool',
> +            '*zero-blocks': { 'type': 'bool', 'features': [ 'deprecated' ] },
> +            '*events': 'bool',
> +            '*postcopy-ram': 'bool',
> +            '*x-colo': { 'type': 'bool', 'features': [ 'unstable' ] },
> +            '*release-ram': 'bool',
> +            '*return-path': 'bool',
> +            '*pause-before-switchover': 'bool',
> +            '*multifd': 'bool',
> +            '*dirty-bitmaps': 'bool',
> +            '*postcopy-blocktime': 'bool',
> +            '*late-block-activate': 'bool',
> +            '*x-ignore-shared': { 'type': 'bool', 'features': [ 'unstable' ] },
> +            '*validate-uuid': 'bool',
> +            '*background-snapshot': 'bool',
> +            '*zero-copy-send': 'bool',
> +            '*postcopy-preempt': 'bool',
> +            '*switchover-ack': 'bool',
> +            '*dirty-limit': 'bool',
> +            '*mapped-ram': 'bool' } }
>  
>  ##
>  # @query-migrate-parameters:


