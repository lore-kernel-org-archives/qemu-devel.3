Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF93D3F07A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7PH-0000tP-6P; Wed, 28 Jan 2026 10:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl7Oq-0000hc-IL
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:24:11 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl7Oo-0003UW-Cp
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:24:08 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F7BD5BCD1;
 Wed, 28 Jan 2026 15:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769613840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zLYwJfnhZbn7nD2J2Tu61OUH7HefaFhZ6XfQhzCJDMU=;
 b=Zr765SKEp+n0yvINC1sKpsTr7e6SYovp+2dSWdM5YOYjpbQdU4E/WxwusUV9IKFtG6t2L1
 X8QBBHWNzWaT2ix+v1WWh1QUD4J5tqD84Tk4ksm6hkNuzMe6n42cPu6tqIC5BbH+lSFqmW
 rHPMeLi/ZqDROEBD9A5AGsGbA3xG2iU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769613840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zLYwJfnhZbn7nD2J2Tu61OUH7HefaFhZ6XfQhzCJDMU=;
 b=d0nBiSAgH7KVAnfFZS5gG24d8eRSrUVHqlwbLlcKYjYQ1ouFYf4fc1cFrawEL+Cy+fR/9u
 QDznJIhTK9oHrdAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LdsQuT1v;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=U+skJGK9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769613834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zLYwJfnhZbn7nD2J2Tu61OUH7HefaFhZ6XfQhzCJDMU=;
 b=LdsQuT1vTXR0s6NDVa/ucMrUi7+spoCvER+wePSiUaRr0gtTh6ImSrEnlG+8w9TFUaxAgk
 v39zt2Zee7hvG++VdwkPPGs9u4oa1/YQLXQhUSj8Kz5ZFvMzF8JhmptqdrLE7/8WiDkk27
 DIOe0O75o/iBClx5ElXbAlX1DkzwNTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769613834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zLYwJfnhZbn7nD2J2Tu61OUH7HefaFhZ6XfQhzCJDMU=;
 b=U+skJGK9uKbDtH56z+FavD9x78dxav1z0caTxPaQ2163OBn9PPg2AJwJHuaVuUXQRyJ+1z
 OIfQbycpVMXeEAAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B2893EA61;
 Wed, 28 Jan 2026 15:23:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zGI7FwUqemnxNwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Jan 2026 15:23:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>, Prasad Pandit
 <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 18/24] migration: Cleanup error propagates in
 qemu_savevm_state_setup()
In-Reply-To: <20260127185254.3954634-19-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
 <20260127185254.3954634-19-peterx@redhat.com>
Date: Wed, 28 Jan 2026 12:23:46 -0300
Message-ID: <87zf5xep6l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_CC(0.00)[redhat.com,web.de];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RSPAMD_EMAILBL_FAIL(0.00)[peterx.redhat.com:server fail];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 2F7BD5BCD1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> We did two unnecessary error propagations in qemu_savevm_state_setup(), on
> either propagate it to MigrationState*, or set qemufile with error.
>
> Error propagation is not needed because:
>
>   - Two live migration callers ([bg_]migration_thread) will propagate error
>     if this function returned with an error.
>
>   - Save snapshot (qemu_savevm_state) doesn't need to persist error; it got
>     returned directly from save_snapshot().
>
> QEMUFile set error is not needed because the callers always check for
> errors explicitly.
>

Nice

Reviewed-by: Fabiano Rosas <farosas@suse.de>

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/savevm.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 830d8e5988..0683a103c8 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1385,8 +1385,6 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
>          if (se->vmsd && se->vmsd->early_setup) {
>              ret = vmstate_save(f, se, vmdesc, errp);
>              if (ret) {
> -                migrate_error_propagate(ms, error_copy(*errp));
> -                qemu_file_set_error(f, ret);
>                  break;
>              }
>              continue;
> @@ -1405,7 +1403,6 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
>          ret = se->ops->save_setup(f, se->opaque, errp);
>          save_section_footer(f, se);
>          if (ret < 0) {
> -            qemu_file_set_error(f, ret);
>              break;
>          }
>      }

