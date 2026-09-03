Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238B2C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 20:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DiC-0005EX-1y; Thu, 03 Sep 2026 16:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1x2DiA-0005Du-8A; Thu, 03 Sep 2026 16:07:02 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1x2Di8-0003PZ-Ph; Thu, 03 Sep 2026 16:07:02 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4EF08220A8;
 Thu,  3 Sep 2026 20:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788466014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QpEYrqsUofrgcCuWzFcaCUCY8HAMWdJt2amNVRMPyv8=;
 b=yycAeXsfToikj9E/B1IJWbWXggnJV+G5NcQDg+8Hj8TyaePSviv+Ld+ZqifWPjk0CgSJgy
 xhzDCWo6ZEh/XXY5aV59QsKLa8+husx6Q4G48kC4VYjU35kSbIkw/4gbKlDZY2cz+nS98y
 FIuIqcmHJ67UvRX3zcn+NcjDNp9IrtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788466014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QpEYrqsUofrgcCuWzFcaCUCY8HAMWdJt2amNVRMPyv8=;
 b=OXqM6OrpfPPuXuJ9hbrXWDG8AfTh0P/nPD3VACHEgKYpKgh2JLTxj/HsFDaG9BIWmN4Wf8
 E6KVnPLlszwhe+CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wbi5R3o1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lD8Xhq8K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788466010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QpEYrqsUofrgcCuWzFcaCUCY8HAMWdJt2amNVRMPyv8=;
 b=wbi5R3o1f5fF9O8YE2mlkDebIUx/VlHI0MRQKlU9aOvPNuPi3t//Ju5NppBsPZ+34G+SVm
 vit7x7qpjNWve8W2uOUBYtbvst8XZWdsxu/UBtfpG29IxcJ4LkWpZ2j9YZB4cxGIizr8D6
 mUSvYx5gtW+uMY9nWf7GUNS7/bC7/XQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788466010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QpEYrqsUofrgcCuWzFcaCUCY8HAMWdJt2amNVRMPyv8=;
 b=lD8Xhq8Kl5u52k9A6/bjo7z1jlUePrAev1wNR2Z1MPrtzt50CYgBlUJoegtgAQByr0PXcl
 AqiBj9H13Lu4HUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3A9A136E6;
 Thu,  3 Sep 2026 20:06:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6MzZJFnTmWprYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 03 Sep 2026 20:06:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Markus
 Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>, Eric Blake
 <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 3/5] qapi: convert simple event intros for migration.json
In-Reply-To: <20260903200008.729791-4-jsnow@redhat.com>
References: <20260903200008.729791-1-jsnow@redhat.com>
 <20260903200008.729791-4-jsnow@redhat.com>
Date: Thu, 03 Sep 2026 17:06:47 -0300
Message-ID: <8733vq85go.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4EF08220A8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[14];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,mailo.com,intel.com,nongnu.org];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/migration.json | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index e3beaea87bb..5fbd604f995 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1708,11 +1708,10 @@
>  
>  ##
>  # @UNPLUG_PRIMARY:
> -#
> -# Emitted from source side of a migration when migration state is
> -# WAIT_UNPLUG.  Device was unplugged by guest operating system.
> -# Device resources in QEMU are kept on standby to be able to re-plug
> -# it in case of migration failure.
> +#     Emitted from source side of a migration when migration state is
> +#     WAIT_UNPLUG.  Device was unplugged by guest operating system.
> +#     Device resources in QEMU are kept on standby to be able to
> +#     re-plug it in case of migration failure.
>  #
>  # @device-id: QEMU device id of the unplugged device
>  #

Acked-by: Fabiano Rosas <farosas@suse.de>

