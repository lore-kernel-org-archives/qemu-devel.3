Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16371C71134
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 12:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPKG2-0005so-0i; Wed, 11 Jun 2025 08:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uPKFq-0005ov-70
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:08:33 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uPKFg-0005j1-0I
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:08:24 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A92C1F38E;
 Wed, 11 Jun 2025 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749643692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j7YGwkL6hVWJxVU/ZQYd9fDffuO7gFwpCbwldDt/19s=;
 b=zJ8ayVMRgwKweU+4v31/uFWcQFPpmYAyQ2Tb6CVS978wfwAbbqt7ELpT2FJrpOQCmo+mt0
 hI0oXJ24nlWyUu4FOQCLKXzbGNq1NJRs2XlyVgEnEb3MiD1Jm9+NRtBsm3V2F76O1a3Qyv
 8vov1ARKLCEWCLgqcVuwNEMbAhvavWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749643692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j7YGwkL6hVWJxVU/ZQYd9fDffuO7gFwpCbwldDt/19s=;
 b=20jX3ah5ti0fifAlckPRSHtsJAjDNUAnorDrJWhQbOlcq5W0mVJsV9hxuGXzXB/NAnUv0v
 C4vYTwe0BasScsAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zJ8ayVMR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=20jX3ah5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749643692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j7YGwkL6hVWJxVU/ZQYd9fDffuO7gFwpCbwldDt/19s=;
 b=zJ8ayVMRgwKweU+4v31/uFWcQFPpmYAyQ2Tb6CVS978wfwAbbqt7ELpT2FJrpOQCmo+mt0
 hI0oXJ24nlWyUu4FOQCLKXzbGNq1NJRs2XlyVgEnEb3MiD1Jm9+NRtBsm3V2F76O1a3Qyv
 8vov1ARKLCEWCLgqcVuwNEMbAhvavWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749643692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j7YGwkL6hVWJxVU/ZQYd9fDffuO7gFwpCbwldDt/19s=;
 b=20jX3ah5ti0fifAlckPRSHtsJAjDNUAnorDrJWhQbOlcq5W0mVJsV9hxuGXzXB/NAnUv0v
 C4vYTwe0BasScsAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBE48139CE;
 Wed, 11 Jun 2025 12:08:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8fW2JqtxSWgNMwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 11 Jun 2025 12:08:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Jaehoon Kim <jhkim@linux.ibm.com>, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, steven.sistare@oracle.com, peterx@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com, Jaehoon Kim <jhkim@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] tests/migration: Setup pre-listened cpr.sock to
 remove race-condition.
In-Reply-To: <20250610223342.553744-1-jhkim@linux.ibm.com>
References: <20250610223342.553744-1-jhkim@linux.ibm.com>
Date: Wed, 11 Jun 2025 09:08:09 -0300
Message-ID: <87h60mv5ue.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6A92C1F38E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid]
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

Jaehoon Kim <jhkim@linux.ibm.com> writes:

Hi,

These patches should be the other way around, first add the support,
then add the test.

> When the source VM attempts to connect to the destination VM's Unix
> domain socket (cpr.sock) during a cpr-transfer test, race conditions can
> occur if the socket file isn't ready. This can lead to connection
> failures when running tests.
>
> This patch creates and listens on the socket in advance, and passes the
> pre-listened FD directly. This avoids timing issues and improves the
> reliability of CPR tests.
>
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> ---
>  tests/qtest/migration/cpr-tests.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> index 5536e14610..145860c24c 100644
> --- a/tests/qtest/migration/cpr-tests.c
> +++ b/tests/qtest/migration/cpr-tests.c
> @@ -60,13 +60,12 @@ static void test_mode_transfer_common(bool incoming_defer)
>      g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
>      g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
>      g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
> +    g_autofree char *opts_target;
>  
>      const char *opts = "-machine aux-ram-share=on -nodefaults";
>      g_autofree const char *cpr_channel = g_strdup_printf(
>          "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
>          cpr_path);
> -    g_autofree char *opts_target = g_strdup_printf("-incoming %s %s",
> -                                                   cpr_channel, opts);
>  
>      g_autofree char *connect_channels = g_strdup_printf(
>          "[ { 'channel-type': 'main',"
> @@ -75,6 +74,17 @@ static void test_mode_transfer_common(bool incoming_defer)
>          "              'path': '%s' } } ]",
>          mig_path);
>  
> +    /*
> +     * Set up a UNIX domain socket for the CPR channel before
> +     * launching the destination VM, to avoid timing issues
> +     * during connection setup.
> +     */
> +    int cpr_sockfd = qtest_socket_server(cpr_path);
> +    g_assert(cpr_sockfd >= 0);
> +
> +    opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
> +                                  "addr.type=fd,addr.str=%s %s",
> +                                  g_strdup_printf("%d", cpr_sockfd), opts);

The sockfd string will leak.

>      MigrateCommon args = {
>          .start.opts_source = opts,
>          .start.opts_target = opts_target,

