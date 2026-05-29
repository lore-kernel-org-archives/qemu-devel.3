Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3022CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 13:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSxFL-0004nR-QT; Fri, 29 May 2026 09:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wSxFE-0004mx-6d
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:27:25 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wSxFA-0000QO-8U
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:27:23 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F34C6A86F;
 Fri, 29 May 2026 13:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780061235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9kHCnKg4iX3CQpptD5bQ3DzjAJoDA8iMhJDQvpVvLI=;
 b=Gj3ncgtMAwmCyWE2Vq2O9LKobY2EGFCuXCjJo5mxwctWHAtpOE+ZyNdEW2WMbBIx5PYvog
 XZFvSzcM/QOpMVETofSSDFefIn/4+p2OlsGAyztzvL3mdTLS/VsQKoCidpqXqlX0rJhav+
 N1JpR2TLANRwgYfyvxrRk+gZKzTK3ps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780061235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9kHCnKg4iX3CQpptD5bQ3DzjAJoDA8iMhJDQvpVvLI=;
 b=azovT6or/YcqB/w2P151nwpijV7m2wKxeBhCs6s3/93z0lKT7x3IJy5iDdu0mgUHHQuNCq
 joLsgMYCa0Cq+iAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Fo15qovv;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="77/Ts5aK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780061234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9kHCnKg4iX3CQpptD5bQ3DzjAJoDA8iMhJDQvpVvLI=;
 b=Fo15qovv4W7Z/Liunst4PXXUsljNkI/w4TrjM97s18Xs6DH9UKc2PBGblMh43tkfCoT9sy
 PyvjpO3cQ7hRDg2RCY4RhiL3ksviSkY4BXVtkaSTT9/y0TyFNBU+5fu8/nKFW3E8YI3r5B
 eXjtfbAJbgW8EBtZ79l/wPVYuHa0ZT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780061234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9kHCnKg4iX3CQpptD5bQ3DzjAJoDA8iMhJDQvpVvLI=;
 b=77/Ts5aKDOrYnaq+rhC5gNO7bm068o4avXi9+Kcr/cg2C7kMZLzvssFIfPo3wIkmzfAvwC
 XkaAmFoe40ZHp4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30C54779A7;
 Fri, 29 May 2026 13:27:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YbLiCzGUGWqmQwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 29 May 2026 13:27:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Laurent Vivier
 <lvivier@redhat.com>, Alex Williamson <alex@shazbot.org>, =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater
 <clg@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 03/32] irq: add per-IRQ observer to fix
 qemu_irq_intercept_in leak
In-Reply-To: <20260529-b4-ui-v1-3-8db3068421ef@redhat.com>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
 <20260529-b4-ui-v1-3-8db3068421ef@redhat.com>
Date: Fri, 29 May 2026 10:27:01 -0300
Message-ID: <87ik86tkgq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5F34C6A86F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,suse.de:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> qemu_irq_intercept_in() saves original IRQ handlers by allocating
> new QOM objects, which are never freed. On a PC machine, this leaks
> IRQ objects (one per IOAPIC pin) on every qtest run.
>
> Rather than tracking allocations to free later, avoid them: add an
> "observer" field to IRQState, called by qemu_set_irq() after the
> real handler. Interception sets the observer instead of rewriting
> handlers, so there's nothing to save and nothing to leak.
>
> Fix qemu_notirq() to route through qemu_set_irq() so inverted IRQs
> trigger observers too. Drop the LSan suppression.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/core/irq.h         |  1 +
>  hw/core/irq.c                 | 10 +++++-----
>  system/qtest.c                |  3 ---
>  scripts/lsan_suppressions.txt |  8 --------
>  4 files changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/include/hw/core/irq.h b/include/hw/core/irq.h
> index 291fdd67df4..93d5710a73e 100644
> --- a/include/hw/core/irq.h
> +++ b/include/hw/core/irq.h
> @@ -14,6 +14,7 @@ struct IRQState {
>      qemu_irq_handler handler;
>      void *opaque;
>      int n;
> +    qemu_irq_handler observer;
>  };
>=20=20
>  void qemu_set_irq(qemu_irq irq, int level);
> diff --git a/hw/core/irq.c b/hw/core/irq.c
> index 106805e2417..fa11e9bc0aa 100644
> --- a/hw/core/irq.c
> +++ b/hw/core/irq.c
> @@ -32,6 +32,9 @@ void qemu_set_irq(qemu_irq irq, int level)
>          return;
>=20=20
>      irq->handler(irq->opaque, irq->n, level);
> +    if (unlikely(irq->observer)) {
> +        irq->observer(irq->opaque, irq->n, level);
> +    }
>  }
>=20=20
>  static void init_irq_fields(IRQState *irq, qemu_irq_handler handler,
> @@ -111,7 +114,7 @@ static void qemu_notirq(void *opaque, int line, int l=
evel)
>  {
>      IRQState *irq =3D opaque;
>=20=20
> -    irq->handler(irq->opaque, irq->n, !level);
> +    qemu_set_irq(irq, !level);
>  }
>=20=20
>  qemu_irq qemu_irq_invert(qemu_irq irq)
> @@ -124,11 +127,8 @@ qemu_irq qemu_irq_invert(qemu_irq irq)
>  void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, =
int n)
>  {
>      int i;
> -    qemu_irq *old_irqs =3D qemu_allocate_irqs(NULL, NULL, n);
>      for (i =3D 0; i < n; i++) {
> -        *old_irqs[i] =3D *gpio_in[i];
> -        gpio_in[i]->handler =3D handler;
> -        gpio_in[i]->opaque =3D &old_irqs[i];
> +        gpio_in[i]->observer =3D handler;
>      }
>  }
>=20=20
> diff --git a/system/qtest.c b/system/qtest.c
> index a79d10d1361..b359a3e1c84 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -324,9 +324,6 @@ void qtest_sendf(CharFrontend *chr, const char *fmt, =
...)
>=20=20
>  static void qtest_irq_handler(void *opaque, int n, int level)
>  {
> -    qemu_irq old_irq =3D *(qemu_irq *)opaque;
> -    qemu_set_irq(old_irq, level);
> -
>      if (irq_levels[n] !=3D level) {
>          CharFrontend *chr =3D &qtest->qtest_chr;
>          irq_levels[n] =3D level;
> diff --git a/scripts/lsan_suppressions.txt b/scripts/lsan_suppressions.txt
> index f88bbab18b8..30256bc6d01 100644
> --- a/scripts/lsan_suppressions.txt
> +++ b/scripts/lsan_suppressions.txt
> @@ -16,11 +16,3 @@ leak:/lib64/libxkbcommon.so.0
>  # https://github.com/GNOME/glib/blob/main/tools/glib.supp
>  # This avoids false positive leak reports for the qga-ssh-test.
>  leak:g_set_user_dirs
> -
> -# qemu_irq_intercept_in is only used by the qtest harness, and
> -# its API inherently involves a leak.
> -# While we could keep track of the old IRQ data structure
> -# in order to free it, it doesn't seem very important to fix
> -# since it is only used by the qtest test harness.
> -# Just ignore the leak, at least for the moment.
> -leak:qemu_irq_intercept_in

Reviewed-by: Fabiano Rosas <farosas@suse.de>

