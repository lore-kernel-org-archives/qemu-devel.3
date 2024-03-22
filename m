Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852B9C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 14:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfTF-0000Vb-IG; Fri, 22 Mar 2024 10:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rnfTA-0000Uo-VU
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:02:05 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rnfT8-0001XM-Rj
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:02:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A607B5FF03;
 Fri, 22 Mar 2024 14:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711116117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vvYUKZGTveTr3RrdpYpEdn46UOkJWBD6/QiLcontVBs=;
 b=uT3eeSz6xITQGC54fFY4NpM90ut3qcLHMRbM7q6DzXAqy+6E6ZqS9+iiWpJKnRVNriJShK
 VMl/LK1z2cCLi6RlHrA2aP2ekV6H5fmw+F37TtEFCBnXvU9CtlSVEguGxNhSzbiZvZLArZ
 oKiGu8Xh3n2dZujCGirHj4atVg9O6+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711116117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vvYUKZGTveTr3RrdpYpEdn46UOkJWBD6/QiLcontVBs=;
 b=+5Ho6lt9w7/6gf+1C0ue+qrH/7ANJO3cNjloVktzMDB11Wd35I84go20JFswQpKkZBXBz9
 1B4vy8X69nEdydCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711116117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vvYUKZGTveTr3RrdpYpEdn46UOkJWBD6/QiLcontVBs=;
 b=uT3eeSz6xITQGC54fFY4NpM90ut3qcLHMRbM7q6DzXAqy+6E6ZqS9+iiWpJKnRVNriJShK
 VMl/LK1z2cCLi6RlHrA2aP2ekV6H5fmw+F37TtEFCBnXvU9CtlSVEguGxNhSzbiZvZLArZ
 oKiGu8Xh3n2dZujCGirHj4atVg9O6+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711116117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vvYUKZGTveTr3RrdpYpEdn46UOkJWBD6/QiLcontVBs=;
 b=+5Ho6lt9w7/6gf+1C0ue+qrH/7ANJO3cNjloVktzMDB11Wd35I84go20JFswQpKkZBXBz9
 1B4vy8X69nEdydCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32253136AD;
 Fri, 22 Mar 2024 14:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tj4rOlSP/WWHKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 22 Mar 2024 14:01:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, berrange@redhat.com
Subject: Re: [PATCH 1/3] qapi: Improve migration TLS documentation
In-Reply-To: <20240322135117.195489-2-armbru@redhat.com>
References: <20240322135117.195489-1-armbru@redhat.com>
 <20240322135117.195489-2-armbru@redhat.com>
Date: Fri, 22 Mar 2024 11:01:54 -0300
Message-ID: <875xxemkkt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-3.00)[100.00%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.de:dkim]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 NEURAL_SPAM_LONG(3.50)[1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uT3eeSz6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+5Ho6lt9
X-Rspamd-Queue-Id: A607B5FF03
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> MigrateSetParameters is about setting parameters, and
> MigrationParameters is about querying them.  Their documentation of
> @tls-creds and @tls-hostname has residual damage from a failed attempt
> at de-duplicating them (see commit de63ab61241 "migrate: Share common
> MigrationParameters struct" and commit 1bda8b3c695 "migration: Unshare
> MigrationParameters struct for now").
>
> MigrateSetParameters documentation issues:
>
> * It claims plain text mode "was reported by omitting tls-creds"
>   before 2.9.  MigrateSetParameters is not used for reporting, so this
>   is misleading.  Delete.
>
> * It similarly claims hostname defaulting to migration URI "was
>   reported by omitting tls-hostname" before 2.9.  Delete as well.
>
> Rephrase the remaining @tls-hostname contents for clarity.
>
> Enum MigrationParameter mirrors the members of struct
> MigrateSetParameters.  Differences to MigrateSetParameters's member
> documentation are pointless.  Copy the new text to MigrationParameter.
>
> MigrationParameters documentation issues:
>
> * @tls-creds runs the two last sentences together without punctuation.
>   Fix that.
>
> * Much of the contents on @tls-hostname only applies to setting
>   parameters, resulting in confusion.  Replace by a suitable abridged
>   version of the new MigrateSetParameters text, and a note on
>   @tls-hostname omission in 2.8.
>
> Additional damage is due to flawed doc fix commit
> 66fcb9d651d (qapi/migration: Add missing tls-authz documentation):
> since it copied the missing MigrateSetParameters text from
> MigrationParameters instead of MigrationParameter, the part on
> recreating @tls-authz on the fly is missing.  Copy that, too.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/migration.json | 63 +++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 31 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index aa1b39bce1..cbcc6946eb 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -809,16 +809,19 @@
>  #     for establishing a TLS connection over the migration data
>  #     channel.  On the outgoing side of the migration, the credentials
>  #     must be for a 'client' endpoint, while for the incoming side the
> -#     credentials must be for a 'server' endpoint.  Setting this will
> -#     enable TLS for all migrations.  The default is unset, resulting
> -#     in unsecured migration at the QEMU level.  (Since 2.7)
> +#     credentials must be for a 'server' endpoint.  Setting this to a
> +#     non-empty string enables TLS for all migrations.  An empty
> +#     string means that QEMU will use plain text mode for migration,
> +#     rather than TLS.  (Since 2.7)
>  #
> -# @tls-hostname: hostname of the target host for the migration.  This
> -#     is required when using x509 based TLS credentials and the
> -#     migration URI does not already include a hostname.  For example
> -#     if using fd: or exec: based migration, the hostname must be
> -#     provided so that the server's x509 certificate identity can be
> -#     validated.  (Since 2.7)
> +# @tls-hostname: migration target's hostname for validating the
> +#     server's x509 certificate identify.  If empty, QEMU will use the

identity

> +#     hostname from the migration URI, if any.  A non-empty value is
> +#     required when using x509 based TLS credentials and the migration
> +#     URI does not include a hostname, such as fd: or exec: based
> +#     migration.  (Since 2.7)
> +#
> +#     Note: empty value works only since 2.9.
>  #
>  # @tls-authz: ID of the 'authz' object subclass that provides access
>  #     control checking of the TLS x509 certificate distinguished name.
> @@ -1006,22 +1009,22 @@
>  #     credentials must be for a 'server' endpoint.  Setting this to a
>  #     non-empty string enables TLS for all migrations.  An empty
>  #     string means that QEMU will use plain text mode for migration,
> -#     rather than TLS (Since 2.9) Previously (since 2.7), this was
> -#     reported by omitting tls-creds instead.
> +#     rather than TLS.  This is the default.  (Since 2.7)
>  #
> -# @tls-hostname: hostname of the target host for the migration.  This
> -#     is required when using x509 based TLS credentials and the
> -#     migration URI does not already include a hostname.  For example
> -#     if using fd: or exec: based migration, the hostname must be
> -#     provided so that the server's x509 certificate identity can be
> -#     validated.  (Since 2.7) An empty string means that QEMU will use
> -#     the hostname associated with the migration URI, if any.  (Since
> -#     2.9) Previously (since 2.7), this was reported by omitting
> -#     tls-hostname instead.
> +# @tls-hostname: migration target's hostname for validating the
> +#     server's x509 certificate identify.  If empty, QEMU will use the

same here

> +#     hostname from the migration URI, if any.  A non-empty value is
> +#     required when using x509 based TLS credentials and the migration
> +#     URI does not include a hostname, such as fd: or exec: based
> +#     migration.  (Since 2.7)
> +#
> +#     Note: empty value works only since 2.9.
>  #
>  # @tls-authz: ID of the 'authz' object subclass that provides access
>  #     control checking of the TLS x509 certificate distinguished name.
> -#     (Since 4.0)
> +#     This object is only resolved at time of use, so can be deleted
> +#     and recreated on the fly while the migration server is active.
> +#     If missing, it will default to denying access (Since 4.0)
>  #
>  # @max-bandwidth: to set maximum speed for migration.  maximum speed
>  #     in bytes per second.  (Since 2.8)
> @@ -1240,17 +1243,15 @@
>  #     must be for a 'client' endpoint, while for the incoming side the
>  #     credentials must be for a 'server' endpoint.  An empty string
>  #     means that QEMU will use plain text mode for migration, rather
> -#     than TLS (Since 2.7) Note: 2.8 reports this by omitting
> -#     tls-creds instead.
> +#     than TLS.  (Since 2.7)
>  #
> -# @tls-hostname: hostname of the target host for the migration.  This
> -#     is required when using x509 based TLS credentials and the
> -#     migration URI does not already include a hostname.  For example
> -#     if using fd: or exec: based migration, the hostname must be
> -#     provided so that the server's x509 certificate identity can be
> -#     validated.  (Since 2.7) An empty string means that QEMU will use
> -#     the hostname associated with the migration URI, if any.  (Since
> -#     2.9) Note: 2.8 reports this by omitting tls-hostname instead.
> +#     Note: 2.8 omits empty @tls-creds instead.
> +#
> +# @tls-hostname: migration target's hostname for validating the
> +#     server's x509 certificate identify.  If empty, QEMU will use the

and here

> +#     hostname from the migration URI, if any.  (Since 2.7)
> +#
> +#     Note: 2.8 omits empty @tls-hostname instead.
>  #
>  # @tls-authz: ID of the 'authz' object subclass that provides access
>  #     control checking of the TLS x509 certificate distinguished name.

