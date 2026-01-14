Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418DBD29FF8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfzy3-0003zS-AD; Wed, 14 Jan 2026 07:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vfzy0-0003rU-E9
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:27:16 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vfzxy-0001PG-QV
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:27:16 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 367DD33F78;
 Wed, 14 Jan 2026 12:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768393633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sRMSSYF29uwoE3xWQxZAQM6x+zsNwy9vKE9KXEsjmLM=;
 b=g7k1zgVSQhq855K7ZJFwyk/rZraq/d/Z+7AAl8OEQXNCJyT8b2VLhIRNEy/LxbG1ib0NFH
 V3u047tSDuz8M8Vmfrbj0tJc+PcDF/3tNEZp66U7beCoIimpx1V1DfSXvMODeocmg5WHZt
 FF1ZpcYlhLQupcrJ8KCJ0HLhUub8xk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768393633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sRMSSYF29uwoE3xWQxZAQM6x+zsNwy9vKE9KXEsjmLM=;
 b=RZDd0kfkVlyG0/vhQTw/bEeELqKlEXvF1wAU5IRc5zcURC0BQO3kMfYXcntRjEwcHlMLF7
 40T6a41aHOi69nCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768393633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sRMSSYF29uwoE3xWQxZAQM6x+zsNwy9vKE9KXEsjmLM=;
 b=g7k1zgVSQhq855K7ZJFwyk/rZraq/d/Z+7AAl8OEQXNCJyT8b2VLhIRNEy/LxbG1ib0NFH
 V3u047tSDuz8M8Vmfrbj0tJc+PcDF/3tNEZp66U7beCoIimpx1V1DfSXvMODeocmg5WHZt
 FF1ZpcYlhLQupcrJ8KCJ0HLhUub8xk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768393633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sRMSSYF29uwoE3xWQxZAQM6x+zsNwy9vKE9KXEsjmLM=;
 b=RZDd0kfkVlyG0/vhQTw/bEeELqKlEXvF1wAU5IRc5zcURC0BQO3kMfYXcntRjEwcHlMLF7
 40T6a41aHOi69nCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A84713EA66;
 Wed, 14 Jan 2026 12:27:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iLc7GqCLZ2mJSgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Jan 2026 12:27:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, dtalexundeer@yandex-team.ru,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: Re: [PATCH 1/5] vmstate-types: get_fd(): handle qemu_file_get_fd()
 failure
In-Reply-To: <20260114064710.176268-2-vsementsov@yandex-team.ru>
References: <20260114064710.176268-1-vsementsov@yandex-team.ru>
 <20260114064710.176268-2-vsementsov@yandex-team.ru>
Date: Wed, 14 Jan 2026 09:27:09 -0300
Message-ID: <87y0m0nzvm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> qemu_file_get_fd() may fail, and return -1 in this case.
> We don't support passing "invalid" file descriptors (like -1),
> so we should not interpret error here like invalid descriptor.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/vmstate-types.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 4b01dc19c2..e34bf4486e 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -321,12 +321,21 @@ const VMStateInfo vmstate_info_uint64 = {
>  static int get_fd(QEMUFile *f, void *pv, size_t size,
>                    const VMStateField *field)
>  {
> +    int fd;
>      int32_t *v = pv;
> +
>      if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>          qemu_get_sbe32s(f, v);
>          return 0;
>      }
> -    *v = qemu_file_get_fd(f);
> +
> +    fd = qemu_file_get_fd(f);
> +    if (fd < 0) {
> +        return -1;
> +    }
> +
> +    *v = fd;
> +
>      return 0;
>  }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

