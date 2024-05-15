Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DFEC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 19:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Jvj-0003Mv-9z; Wed, 15 May 2024 15:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s7Jvh-0003ML-E3
 for qemu-devel@nongnu.org; Wed, 15 May 2024 15:04:45 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s7Jvf-0000DQ-Pb
 for qemu-devel@nongnu.org; Wed, 15 May 2024 15:04:45 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D18CF20AF1;
 Wed, 15 May 2024 19:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715799881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxSB7Ta592V22OhScGGGVMu5Q3dhtHZRCEH2Xbo7uKQ=;
 b=VSIjfQuP7PV75oqeXK5Ix208OZzRS4IEEARKBcAI+CJzdsq6PiQSjV3WGRw2kTX5vS9c7s
 1t7pvLF5bP1wuIglP2LKakFo7qDjDLjQ5AKDq48wpol4tnFc1E3Z03cahsBJJVBgtXy7Tt
 YJ/wh5m6CBKCjR29tDoS9JPoyeYmVsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715799881;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxSB7Ta592V22OhScGGGVMu5Q3dhtHZRCEH2Xbo7uKQ=;
 b=qjc09vGgGEPgjCZ6Vp37yrLu4Xf4nFHiNqdFDC9AZcNuFDeTlOXkDt/rJ5WF9AQOX6PaSY
 2IDxW709bnLTvUAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715799880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxSB7Ta592V22OhScGGGVMu5Q3dhtHZRCEH2Xbo7uKQ=;
 b=v8xGzXOhYjmalmh3updhnFsTU0nmJ3tkadVyR8IBTPF0i0NNtZsjXOX7DRvxenMG9ofxc5
 zSpM2WdzaTKdBRzdUpybgBZ7QaZaxUhe9oupN//4uuNTPT5+q9K/twTMP8KqLZ1Ekg4LwH
 l7pqIiULqBgk5alPTgLNN/Q065K7Jv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715799880;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxSB7Ta592V22OhScGGGVMu5Q3dhtHZRCEH2Xbo7uKQ=;
 b=NlhW4OuDpbSnESqoZgmZ7j80lMT4hoZV6MX9pAyToNMGdMXVFRfwFCjTl/clh8OSJ2DTKZ
 /dkCb4Ux9wzwcrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BD16136A8;
 Wed, 15 May 2024 19:04:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +KYKCUgHRWZ0fAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 15 May 2024 19:04:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Li Zhijian via <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-devel@nongnu.org, Zhang
 Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 2/3] migration/colo: make colo_incoming_co() return void
In-Reply-To: <20240509033106.1321880-2-lizhijian@fujitsu.com>
References: <20240509033106.1321880-1-lizhijian@fujitsu.com>
 <20240509033106.1321880-2-lizhijian@fujitsu.com>
Date: Wed, 15 May 2024 16:04:37 -0300
Message-ID: <87le4aew1m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-3.43 / 50.00]; BAYES_HAM(-2.13)[95.83%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Li Zhijian via <qemu-devel@nongnu.org> writes:

> Currently, it always returns 0, no need to check the return value at all.
> In addition, enter colo coroutine only if migration_incoming_colo_enabled=
()
> is true.
> Once the destination side enters the COLO* state, the COLO process will
> take over the remaining processes until COLO exits.
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  migration/colo.c      | 9 ++-------
>  migration/migration.c | 6 +++---
>  2 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index 5600a43d78..991806c06a 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -929,16 +929,13 @@ out:
>      return NULL;
>  }
>=20=20
> -int coroutine_fn colo_incoming_co(void)
> +void coroutine_fn colo_incoming_co(void)
>  {
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>      QemuThread th;
>=20=20
>      assert(bql_locked());
> -
> -    if (!migration_incoming_colo_enabled()) {
> -        return 0;
> -    }
> +    assert(migration_incoming_colo_enabled());

FAILED: libcommon.fa.p/migration_colo.c.o
/usr/bin/gcc-13 ... ../migration/colo.c
../migration/colo.c:930:19: error: conflicting types for =E2=80=98colo_inco=
ming_co=E2=80=99; have =E2=80=98void(void)=E2=80=99
  930 | void coroutine_fn colo_incoming_co(void)
      |                   ^~~~~~~~~~~~~~~~
In file included from ../migration/colo.c:20:
... qemu/include/migration/colo.h:52:18: note: previous declaration of =E2=
=80=98colo_incoming_co=E2=80=99 with type =E2=80=98int(void)=E2=80=99
   52 | int coroutine_fn colo_incoming_co(void);
      |                  ^~~~~~~~~~~~~~~~

