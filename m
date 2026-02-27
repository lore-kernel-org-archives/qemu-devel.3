Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B812A103FFAC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6Wo-0007o5-0H; Fri, 27 Feb 2026 17:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vw6Wl-0007l8-Oc
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:41:43 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vw6Wk-00037N-5D
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:41:43 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EFF5C3FACF;
 Fri, 27 Feb 2026 22:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772232101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gaOPPOlj5s0hp8QBw3l7ltl3O5glArSkXIMQ3oGE2v8=;
 b=V00P4to+GsR7xF5lcQ6dboR3SSq2ZIKTDFawgjKJasuUMfDSGjKpfhJQrVIeBoDSAN8yMt
 5PVqpOg+w/LOhfyIbYIomWJhPcc4EPqzgIeXPc++6h09JmEZqZPIkFhD5UiajrLtXMnhUo
 St5Zt4av91qQvGcyJZI+30KiH0JfHAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772232101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gaOPPOlj5s0hp8QBw3l7ltl3O5glArSkXIMQ3oGE2v8=;
 b=FgXtx1pmD5bNJ2fOmj47cPaSY8yobNV2bvir9jf5i6Zxa8qhuodOX3v2xcx5Zxu5mwnzB0
 yQMmbkpN2suHaiCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="PEti//Ud";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IKEvODFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772232100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gaOPPOlj5s0hp8QBw3l7ltl3O5glArSkXIMQ3oGE2v8=;
 b=PEti//UdPXg1wIkyXB20EcwquQUl+UejGaGxVQQuzQriDGaN7+E88MFJcnozRv4AEs1sgQ
 mOBNQ2Y+lhxb/V1mAjFSvNS6grlYNzJh3XKBOYAZoqKZ9JGrIyBs/18ly7oL0+ESdBvSd1
 L08ICLTwTvzH1ZGR+87EJei7ShPIe0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772232100;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gaOPPOlj5s0hp8QBw3l7ltl3O5glArSkXIMQ3oGE2v8=;
 b=IKEvODFCM3Q1aYcCb0tU7WU7hx6DnPMZg427YbHm8g71bRq3+FHozY+94ZEh9A6fte48m0
 pKM3Lxiclr9gsMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78A2E3EA69;
 Fri, 27 Feb 2026 22:41:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tKKoD6QdommkcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Feb 2026 22:41:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: vsementsov@yandex-team.ru, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 04/16] migration: vmstate_load_state(): add some
 newlines
In-Reply-To: <20260220210214.800050-5-vsementsov@yandex-team.ru>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-5-vsementsov@yandex-team.ru>
Date: Fri, 27 Feb 2026 19:41:37 -0300
Message-ID: <87bjh9u7vi.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EFF5C3FACF
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

> Split logical blocks by newlines, that simplify reading the code.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/vmstate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 5111e7a141..dd7cd27993 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -139,6 +139,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>      int ret = 0;
>  
>      trace_vmstate_load_state(vmsd->name, version_id);
> +
>      if (version_id > vmsd->version_id) {
>          error_setg(errp, "%s: incoming version_id %d is too new "
>                     "for local version_id %d",
> @@ -146,6 +147,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>          trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
>          return -EINVAL;
>      }
> +
>      if  (version_id < vmsd->minimum_version_id) {
>          error_setg(errp, "%s: incoming version_id %d is too old "
>                     "for local minimum version_id %d",
> @@ -153,6 +155,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>          trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
>          return -EINVAL;
>      }
> +
>      if (vmsd->pre_load_errp) {
>          if (!vmsd->pre_load_errp(opaque, errp)) {
>              error_prepend(errp, "pre load hook failed for: '%s', "
> @@ -171,9 +174,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>              return ret;
>          }
>      }
> +
>      while (field->name) {
>          bool exists = vmstate_field_exists(vmsd, field, opaque, version_id);
> +
>          trace_vmstate_load_state_field(vmsd->name, field->name, exists);
> +
>          if (exists) {
>              void *first_elem = opaque + field->offset;
>              int i, n_elems = vmstate_n_elems(opaque, field);
> @@ -184,6 +190,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>                  first_elem = *(void **)first_elem;
>                  assert(first_elem || !n_elems || !size);
>              }
> +
>              for (i = 0; i < n_elems; i++) {
>                  void *curr_elem = first_elem + size * i;
>                  const VMStateField *inner_field;
> @@ -235,6 +242,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>                                     vmsd->name, ret);
>                      }
>                  }
> +
>                  if (ret < 0) {
>                      qemu_file_set_error(f, ret);
>                      trace_vmstate_load_field_error(field->name, ret);
> @@ -249,11 +257,13 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>          field++;
>      }
>      assert(field->flags == VMS_END);
> +
>      ret = vmstate_subsection_load(f, vmsd, opaque, errp);
>      if (ret != 0) {
>          qemu_file_set_error(f, ret);
>          return ret;
>      }
> +
>      if (vmsd->post_load_errp) {
>          if (!vmsd->post_load_errp(opaque, version_id, errp)) {
>              error_prepend(errp, "post load hook failed for: %s, version_id: "
> @@ -271,7 +281,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>                         ret);
>          }
>      }
> +
>      trace_vmstate_load_state_end(vmsd->name, "end", ret);
> +
>      return ret;
>  }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

