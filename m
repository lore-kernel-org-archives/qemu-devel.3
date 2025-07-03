Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333A4C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 19:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXPhw-0001Hl-55; Thu, 03 Jul 2025 15:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uXPht-0001Gg-Lb
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 15:34:54 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uXPhr-0001Qo-3N
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 15:34:52 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1AEEA1F387;
 Thu,  3 Jul 2025 19:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751571288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KmHtXLyhwa2B8XjU67oCZv6SMY1I8hD0C03viSSKMBU=;
 b=rys5V1xYIQQzEM/EJ924xsD44Qkn1HwvO9kXbhFm3XQ4SUym3PQS6HLlKo6DeUnRAWuJS4
 /hfNcMlRFeIuPCx/lbL+PPFzpp+iHdQhPpUPrkAUsxidPPZ5u5dHWToCzAMkW18stX/4HK
 DQeDo0UwhlcvlnEVdmOTl/TZ8WM7DXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751571288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KmHtXLyhwa2B8XjU67oCZv6SMY1I8hD0C03viSSKMBU=;
 b=bJggfEQr3SowaIOV4NCtw1uxJYDlvbZro3JLk9fviN4GKh2ynpWfEqZX/DL+mFdMSYnkcI
 sImqTgTfnZ2lpEBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751571288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KmHtXLyhwa2B8XjU67oCZv6SMY1I8hD0C03viSSKMBU=;
 b=rys5V1xYIQQzEM/EJ924xsD44Qkn1HwvO9kXbhFm3XQ4SUym3PQS6HLlKo6DeUnRAWuJS4
 /hfNcMlRFeIuPCx/lbL+PPFzpp+iHdQhPpUPrkAUsxidPPZ5u5dHWToCzAMkW18stX/4HK
 DQeDo0UwhlcvlnEVdmOTl/TZ8WM7DXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751571288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KmHtXLyhwa2B8XjU67oCZv6SMY1I8hD0C03viSSKMBU=;
 b=bJggfEQr3SowaIOV4NCtw1uxJYDlvbZro3JLk9fviN4GKh2ynpWfEqZX/DL+mFdMSYnkcI
 sImqTgTfnZ2lpEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 876E713721;
 Thu,  3 Jul 2025 19:34:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sId9EFfbZmjCQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 03 Jul 2025 19:34:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Peter
 Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 04/24] migration: Remove MigrateSetParameters
In-Reply-To: <87jz4s1gt6.fsf@pond.sub.org>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-5-farosas@suse.de> <87jz4s1gt6.fsf@pond.sub.org>
Date: Thu, 03 Jul 2025 16:34:44 -0300
Message-ID: <87pleh3w6j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
>> Now that the TLS options have been made the same between
>> migrate-set-parameters and query-migrate-parameters, a single type can
>> be used. Remove MigrateSetParameters.
>>
>> The TLS options documentation from MigrationParameters were replaced
>> with the ones from MigrateSetParameters which was more complete.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> [...]
>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 97bb022c45..3788c39857 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -914,206 +914,10 @@
>>             'zero-page-detection',
>>             'direct-io'] }
>>  
>> -##
>> -# @MigrateSetParameters:
>
> [...]
>
>>  ##
>>  # @migrate-set-parameters:
>>  #
>> -# Set various migration parameters.
>> +# Set migration parameters.  All fields are optional.
>
> Use "arguments" instead of "fields".
>
>>  #
>>  # Since: 2.4
>>  #
>> @@ -1124,13 +928,11 @@
>>  #     <- { "return": {} }
>>  ##
>>  { 'command': 'migrate-set-parameters', 'boxed': true,
>> -  'data': 'MigrateSetParameters' }
>> +  'data': 'MigrationParameters' }
>>  
>>  ##
>>  # @MigrationParameters:
>>  #
>> -# The optional members aren't actually optional.
>> -#
>>  # @announce-initial: Initial delay (in milliseconds) before sending
>>  #     the first announce (Since 4.0)
>>  #
>> @@ -1148,12 +950,12 @@
>>  #     percentage.  The default value is 50.  (Since 5.0)
>>  #
>>  # @cpu-throttle-initial: Initial percentage of time guest cpus are
>> -#     throttled when migration auto-converge is activated.
>> -#     (Since 2.7)
>> +#     throttled when migration auto-converge is activated.  The
>> +#     default value is 20.  (Since 2.7)
>>  #
>>  # @cpu-throttle-increment: throttle percentage increase each time
>>  #     auto-converge detects that migration is not making progress.
>> -#     (Since 2.7)
>> +#     The default value is 10.  (Since 2.7)
>>  #
>>  # @cpu-throttle-tailslow: Make CPU throttling slower at tail stage.
>>  #     At the tail stage of throttling, the Guest is very sensitive to
>> @@ -1172,21 +974,25 @@
>>  #     for establishing a TLS connection over the migration data
>>  #     channel.  On the outgoing side of the migration, the credentials
>>  #     must be for a 'client' endpoint, while for the incoming side the
>> -#     credentials must be for a 'server' endpoint.  An empty string
>> -#     means that QEMU will use plain text mode for migration, rather
>> -#     than TLS.  (Since 2.7)
>> -#
>> -#     Note: 2.8 omits empty @tls-creds instead.
>> +#     credentials must be for a 'server' endpoint.  Setting this to a
>> +#     non-empty string enables TLS for all migrations.  An empty
>> +#     string means that QEMU will use plain text mode for migration,
>> +#     rather than TLS.  This is the default.  (Since 2.7)
>>  #
>>  # @tls-hostname: migration target's hostname for validating the
>>  #     server's x509 certificate identity.  If empty, QEMU will use the
>> -#     hostname from the migration URI, if any.  (Since 2.7)
>> +#     hostname from the migration URI, if any.  A non-empty value is
>> +#     required when using x509 based TLS credentials and the migration
>> +#     URI does not include a hostname, such as fd: or exec: based
>> +#     migration.  (Since 2.7)
>>  #
>> -#     Note: 2.8 omits empty @tls-hostname instead.
>> +#     Note: empty value works only since 2.9.
>>  #
>>  # @tls-authz: ID of the 'authz' object subclass that provides access
>>  #     control checking of the TLS x509 certificate distinguished name.
>> -#     (Since 4.0)
>> +#     This object is only resolved at time of use, so can be deleted
>> +#     and recreated on the fly while the migration server is active.
>> +#     If missing, it will default to denying access (Since 4.0)
>>  #
>>  # @max-bandwidth: maximum speed for migration, in bytes per second.
>>  #     (Since 2.8)
>> @@ -1205,8 +1011,8 @@
>>  # @downtime-limit: set maximum tolerated downtime for migration.
>>  #     maximum downtime in milliseconds (Since 2.8)
>>  #
>> -# @x-checkpoint-delay: the delay time between two COLO checkpoints.
>> -#     (Since 2.8)
>> +# @x-checkpoint-delay: the delay time between two COLO checkpoints in
>> +#     periodic mode.  (Since 2.8)
>>  #
>>  # @multifd-channels: Number of channels used to migrate data in
>>  #     parallel.  This is the same number that the number of sockets
>
> Please add
>
>    ##
>    # @query-migrate-parameters:
>    #
>   -# Return information about the current migration parameters
>   +# Return information about the current migration parameters.
>   +# Optional members of the return value are always present.
>    #
>    # Returns: @MigrationParameters
>    #
>    # Since: 2.4
>    #
>
> and double-check "always" is actually true.

It's not, block-bitmap-mapping needs to be kept optional for
compatibility.

What about:

# Return information about the current migration parameters.  Optional
# members of the return value are always present, except for
# block-bitmap-mapping that's only present if it has been previously
# set.

>
> With that, QAPI schema
> Acked-by: Markus Armbruster <armbru@redhat.com>

