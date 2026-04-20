Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B185CF5A8B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 19:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEuFk-0004fa-0w; Mon, 20 Apr 2026 15:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wEuFh-0004fN-Ov
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:25:49 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wEuFg-0001vC-4V
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:25:49 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 379946A7D5;
 Mon, 20 Apr 2026 19:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776713146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yuw1/GC1KMNy1p7x+U/wfwFZQlY1xT0q2AosFIOLjcM=;
 b=QDrrq+En8nlUGZ0x024JyFcFlo2WVl70HksTgdhjMEfZAfqt+Ha/mjobbQfwLLXiNPbr6X
 X24XsvsKbEsbK0EvSVh5CNj2K8HmWhgYG32w6t8M4Ftf467Ka56wvMtNPIPzqv+HLM4R4X
 FvbRestlO5XAIZr2rXATNqDZj4z94jU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776713146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yuw1/GC1KMNy1p7x+U/wfwFZQlY1xT0q2AosFIOLjcM=;
 b=fBFvSPstDnE0/lNVO8tOs798d4IBuYvZ8VcRugT5jjTIp8SSlwI5LIKJuyvxSS0hvlloZQ
 rh6DKyOl57SQ3MCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776713146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yuw1/GC1KMNy1p7x+U/wfwFZQlY1xT0q2AosFIOLjcM=;
 b=QDrrq+En8nlUGZ0x024JyFcFlo2WVl70HksTgdhjMEfZAfqt+Ha/mjobbQfwLLXiNPbr6X
 X24XsvsKbEsbK0EvSVh5CNj2K8HmWhgYG32w6t8M4Ftf467Ka56wvMtNPIPzqv+HLM4R4X
 FvbRestlO5XAIZr2rXATNqDZj4z94jU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776713146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yuw1/GC1KMNy1p7x+U/wfwFZQlY1xT0q2AosFIOLjcM=;
 b=fBFvSPstDnE0/lNVO8tOs798d4IBuYvZ8VcRugT5jjTIp8SSlwI5LIKJuyvxSS0hvlloZQ
 rh6DKyOl57SQ3MCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA2F6593AE;
 Mon, 20 Apr 2026 19:25:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vcQCIbl95mm4BgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 20 Apr 2026 19:25:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Alexander Mikhalitsyn
 <alexander@mihalicyn.com>, Peter Xu <peterx@redhat.com>, Alexander
 Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>, Philippe =?utf-8?Q?Ma?=
 =?utf-8?Q?thieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 01/11] vmstate: Pass in struct itself for
 VMSTATE_ARRAY_OF_POINTER
In-Reply-To: <20260401202844.673494-2-peterx@redhat.com>
References: <20260401202844.673494-1-peterx@redhat.com>
 <20260401202844.673494-2-peterx@redhat.com>
Date: Mon, 20 Apr 2026 16:25:43 -0300
Message-ID: <871pg9fn7s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Peter Xu <peterx@redhat.com> writes:

> Passing in a pointer almost never helps.  Convert it to pass in struct for
> further refactoring on VMS_ARRAY_OF_POINTER.
>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/vmstate.h | 6 +++---
>  tests/unit/test-vmstate.c   | 2 +-
>  roms/seabios-hppa           | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index d4a39aa794..d4880e75c2 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -547,9 +547,9 @@ extern const VMStateInfo vmstate_info_qlist;
>      .version_id =3D (_version),                                        \
>      .num        =3D (_num),                                            \
>      .info       =3D &(_info),                                          \
> -    .size       =3D sizeof(_type),                                     \
> +    .size       =3D sizeof(_type *),                                   \
>      .flags      =3D VMS_ARRAY|VMS_ARRAY_OF_POINTER,                    \
> -    .offset     =3D vmstate_offset_array(_state, _field, _type, _num), \
> +    .offset     =3D vmstate_offset_array(_state, _field, _type *, _num),=
 \
>  }
>=20=20
>  #define VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(_f, _s, _n, _v, _vmsd, _type)=
 { \
> @@ -1093,7 +1093,7 @@ extern const VMStateInfo vmstate_info_qlist;
>      VMSTATE_TIMER_PTR_V(_f, _s, 0)
>=20=20
>  #define VMSTATE_TIMER_PTR_ARRAY(_f, _s, _n)                             =
 \
> -    VMSTATE_ARRAY_OF_POINTER(_f, _s, _n, 0, vmstate_info_timer, QEMUTime=
r *)
> +    VMSTATE_ARRAY_OF_POINTER(_f, _s, _n, 0, vmstate_info_timer, QEMUTime=
r)
>=20=20
>  #define VMSTATE_TIMER_TEST(_f, _s, _test)                             \
>      VMSTATE_SINGLE_TEST(_f, _s, _test, 0, vmstate_info_timer, QEMUTimer)
> diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
> index cadbab3c5e..6a42cc1a4e 100644
> --- a/tests/unit/test-vmstate.c
> +++ b/tests/unit/test-vmstate.c
> @@ -668,7 +668,7 @@ const VMStateDescription vmsd_arpp =3D {
>      .minimum_version_id =3D 1,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_ARRAY_OF_POINTER(ar, TestArrayOfPtrToInt,
> -                AR_SIZE, 0, vmstate_info_int32, int32_t*),
> +                AR_SIZE, 0, vmstate_info_int32, int32_t),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> diff --git a/roms/seabios-hppa b/roms/seabios-hppa
> index cf3a472f4d..1a8ada1fb7 160000
> --- a/roms/seabios-hppa
> +++ b/roms/seabios-hppa
> @@ -1 +1 @@
> -Subproject commit cf3a472f4ddea30d2d483a8ba4b005505f0dabb3
> +Subproject commit 1a8ada1fb70643172e251aacbac673c9ecda99e9

May I delete this hunk?

