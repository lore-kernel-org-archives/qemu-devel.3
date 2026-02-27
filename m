Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A38C104891E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6Zr-0000jl-P3; Fri, 27 Feb 2026 17:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vw6Zq-0000e0-Pt
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:44:54 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vw6Zp-0003L6-4j
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:44:54 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D58BD5BD78;
 Fri, 27 Feb 2026 22:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772232292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RrZYcUPDWa5IAfWblroGNFzLrJjjnhs4/8E3Kh0lDcY=;
 b=BJGD3r6/KpqB8jMCCkQafv/E9ID8g0lV4ToD/Cvrgah4WOMHvODWnp3hHTbTa2GnCCz0cf
 EJRm84PgyFC8wP4V1zdsQ+BqHnwG9v9t0n4G99eLQdM/crqLWBgLQx2gwaEYJ4Mwqiey02
 a2yNpdBb5BqohPuEq+2Tib3U/PFSmDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772232292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RrZYcUPDWa5IAfWblroGNFzLrJjjnhs4/8E3Kh0lDcY=;
 b=zKtAMyZ8xMWcbkoxZ/7quv5nrBHvGOE5RgCFxqzSk9gKIwPzisybs9R4PqQ2HthwxvrwwB
 fILd/aaraNtObSBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sl0YSNLt;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BKuMX66u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772232291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RrZYcUPDWa5IAfWblroGNFzLrJjjnhs4/8E3Kh0lDcY=;
 b=sl0YSNLtAhz746HHJNNylT2s1EbO7A0owsu327tsk6TUN/ax9bf4ia4+FZKAAZojxl2vCd
 9MpTqjnR6awIFkrvs0UOQ92+w2UT8aCo+qi50NDlz3tnmzkAuXCGsgW7xG2q2PMUsW62A6
 gigv1/8WadeesplbrLevsUdJQ9kwxlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772232291;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RrZYcUPDWa5IAfWblroGNFzLrJjjnhs4/8E3Kh0lDcY=;
 b=BKuMX66uA5gfCBYT9iv1qo1QUhcGxzKKFzJH8TISis0n9JSmWrjEbim++f7cnFi8/gCOPx
 eYvPcWmWBFekRBBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 576263EA69;
 Fri, 27 Feb 2026 22:44:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iXLQBmMeomkCdAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Feb 2026 22:44:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: vsementsov@yandex-team.ru, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 05/16] migration: vmstate_save/load_state(): stop
 tracing errors
In-Reply-To: <20260220210214.800050-6-vsementsov@yandex-team.ru>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-6-vsementsov@yandex-team.ru>
Date: Fri, 27 Feb 2026 19:44:48 -0300
Message-ID: <878qcdu7q7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D58BD5BD78
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> We duplicate some of errors by trace points. That doesn't make
> real sense: we report the error through errp, and stop migration,
> no reason to duplicate the reported error by trace points, making
> error path more complicated.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/trace-events |  5 ++---
>  migration/vmstate.c    | 14 ++++++--------
>  2 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/migration/trace-events b/migration/trace-events
> index 90629f828f..e864d19c55 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -55,15 +55,14 @@ postcopy_pause_incoming_continued(void) ""
>  postcopy_page_req_sync(void *host_addr) "sync page req %p"
>  
>  # vmstate.c
> -vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
>  vmstate_load_state(const char *name, int version_id) "%s v%d"
> -vmstate_load_state_end(const char *name, const char *reason, int val) "%s %s/%d"
> +vmstate_load_state_end(const char *name) "%s"
>  vmstate_load_state_field(const char *name, const char *field, bool exists) "%s:%s exists=%d"
>  vmstate_n_elems(const char *name, int n_elems) "%s: %d"
>  vmstate_subsection_load(const char *parent) "%s"
>  vmstate_subsection_load_bad(const char *parent,  const char *sub, const char *sub2) "%s: %s/%s"
>  vmstate_subsection_load_good(const char *parent) "%s"
> -vmstate_save_state_pre_save_res(const char *name, int res) "%s/%d"
> +vmstate_save_state_pre_save_done(const char *name) "%s"
>  vmstate_save_state_loop(const char *name, const char *field, int n_elems) "%s/%s[%d]"
>  vmstate_save_state_top(const char *idstr) "%s"
>  vmstate_subsection_save_loop(const char *name, const char *sub) "%s/%s"
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index dd7cd27993..b07bbdd366 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -144,7 +144,6 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>          error_setg(errp, "%s: incoming version_id %d is too new "
>                     "for local version_id %d",
>                     vmsd->name, version_id, vmsd->version_id);
> -        trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
>          return -EINVAL;
>      }
>  
> @@ -152,7 +151,6 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>          error_setg(errp, "%s: incoming version_id %d is too old "
>                     "for local minimum version_id %d",
>                     vmsd->name, version_id, vmsd->minimum_version_id);
> -        trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
>          return -EINVAL;
>      }
>  
> @@ -245,7 +243,6 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>  
>                  if (ret < 0) {
>                      qemu_file_set_error(f, ret);
> -                    trace_vmstate_load_field_error(field->name, ret);
>                      return ret;
>                  }
>              }
> @@ -269,7 +266,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>              error_prepend(errp, "post load hook failed for: %s, version_id: "
>                            "%d, minimum_version: %d: ", vmsd->name,
>                            vmsd->version_id, vmsd->minimum_version_id);
> -            ret = -EINVAL;
> +            return -EINVAL;
>          }
>      } else if (vmsd->post_load) {
>          ret = vmsd->post_load(opaque, version_id);
> @@ -279,12 +276,13 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>                         "minimum_version: %d, ret: %d",
>                         vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
>                         ret);
> +            return ret;
>          }
>      }
>  
> -    trace_vmstate_load_state_end(vmsd->name, "end", ret);
> +    trace_vmstate_load_state_end(vmsd->name);
>  
> -    return ret;
> +    return 0;
>  }
>  
>  static int vmfield_name_num(const VMStateField *start,
> @@ -444,20 +442,20 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>  
>      if (vmsd->pre_save_errp) {
>          ret = vmsd->pre_save_errp(opaque, errp) ? 0 : -EINVAL;
> -        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
>          if (ret < 0) {
>              error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
>              return ret;
>          }
>      } else if (vmsd->pre_save) {
>          ret = vmsd->pre_save(opaque);
> -        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
>          if (ret) {
>              error_setg(errp, "pre-save failed: %s", vmsd->name);
>              return ret;
>          }
>      }
>  
> +    trace_vmstate_save_state_pre_save_done(vmsd->name);
> +
>      if (vmdesc) {
>          json_writer_str(vmdesc, "vmsd_name", vmsd->name);
>          json_writer_int64(vmdesc, "version", version_id);

One benefit of the traces is to be able to match with source code when
debugging a QEMU instance that cannot be rebuilt. Not so much about the
trace itself, but to be able to know _where_ the code exited.

However, I have no preference.

Acked-by: Fabiano Rosas <farosas@suse.de>

