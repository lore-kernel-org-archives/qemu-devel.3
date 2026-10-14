Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A02CC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8QP-0003vY-CK; Wed, 14 Oct 2026 19:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xH8QI-0003vI-IZ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:30:15 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xH8QG-0004u6-MI
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:30:14 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0FBD321E81;
 Wed, 14 Oct 2026 23:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792020611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPHH/NImkdPoz0NmMtS1FY16Vu2ZuP0TvSk+DW8VSJg=;
 b=PSCpfY4wfhWpQX5RiV1v8juuJlzoLlrTNhhJ5X6DSUZCeDM9kEcJebL8JBcbgg3yIaQk1H
 KSUcHYSFqmpGUFzMuthng56XLpmSpW7AC6jBamC2RKc2+Z32TixbAjxR59NodZJDPlYbx9
 5deC119oEurLAbcQ3v9qYkxr9J4lOLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792020611;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPHH/NImkdPoz0NmMtS1FY16Vu2ZuP0TvSk+DW8VSJg=;
 b=17pgAnfVycJCvc6m1wcuNadX5Nbce4pPS6HIfGY38q7dw1sW1wHMf4GtboX0CQkq5WVu8h
 nCSH2SlNnHTAv9BQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PSCpfY4w;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=17pgAnfV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792020611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPHH/NImkdPoz0NmMtS1FY16Vu2ZuP0TvSk+DW8VSJg=;
 b=PSCpfY4wfhWpQX5RiV1v8juuJlzoLlrTNhhJ5X6DSUZCeDM9kEcJebL8JBcbgg3yIaQk1H
 KSUcHYSFqmpGUFzMuthng56XLpmSpW7AC6jBamC2RKc2+Z32TixbAjxR59NodZJDPlYbx9
 5deC119oEurLAbcQ3v9qYkxr9J4lOLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792020611;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPHH/NImkdPoz0NmMtS1FY16Vu2ZuP0TvSk+DW8VSJg=;
 b=17pgAnfVycJCvc6m1wcuNadX5Nbce4pPS6HIfGY38q7dw1sW1wHMf4GtboX0CQkq5WVu8h
 nCSH2SlNnHTAv9BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF3C2133F1;
 Wed, 14 Oct 2026 23:30:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v1A2EIEQ0Gr6SAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Oct 2026 23:30:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 09/10] system/cpus: add bql-watchdog-abort
In-Reply-To: <20260915203455.580999-10-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
 <20260915203455.580999-10-den@openvz.org>
Date: Wed, 14 Oct 2026 20:30:02 -0300
Message-ID: <875wz3n9mt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,qualcomm.com:email,linaro.org:email,intel.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 0FBD321E81
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

"Denis V. Lunev" <den@openvz.org> writes:

> From: Denis V. Lunev <den@openvz.org>
>
> The report says where each thread was when the watchdog looked, not
> how it got there. A core carries every thread's whole stack, at the
> price of the guest. A qemu whose BQL has been held this long is not
> running its vCPUs anyway, so on a host where the answer is worth more
> than the guest, abort after the report.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  hw/core/machine.c     | 17 +++++++++++++++++
>  include/system/cpus.h |  4 ++++
>  qemu-options.hx       |  5 +++++
>  system/cpus.c         | 19 +++++++++++++++++++
>  4 files changed, 45 insertions(+)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index b55af89516..2abb9e6295 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -403,6 +403,17 @@ static void machine_set_bql_watchdog_ms(Object *obj,=
 Visitor *v,
>      bql_watchdog_set_timeout_ms(value, errp);
>  }
>=20=20
> +static bool machine_get_bql_watchdog_abort(Object *obj, Error **errp)
> +{
> +    return bql_watchdog_get_abort();
> +}
> +
> +static void machine_set_bql_watchdog_abort(Object *obj, bool value,
> +                                           Error **errp)
> +{
> +    bql_watchdog_set_abort(value);
> +}
> +
>  static bool machine_get_new_accel_vmfd_on_reset(Object *obj, Error **err=
p)
>  {
>      MachineState *ms =3D MACHINE(obj);
> @@ -1174,6 +1185,12 @@ static void machine_class_init(ObjectClass *oc, co=
nst void *data)
>          "Watchdog deadline for a Big QEMU Lock hold, in ms. "
>          "Default: 0 (disabled)");
>=20=20
> +    object_class_property_add_bool(oc, "bql-watchdog-abort",
> +        machine_get_bql_watchdog_abort, machine_set_bql_watchdog_abort);
> +    object_class_property_set_description(oc, "bql-watchdog-abort",
> +        "Abort after the bql-watchdog-ms report, to leave a core dump. "
> +        "Default: off");
> +
>      object_class_property_add_bool(oc, "x-change-vmfd-on-reset",
>          machine_get_new_accel_vmfd_on_reset,
>          machine_set_new_accel_vmfd_on_reset);
> diff --git a/include/system/cpus.h b/include/system/cpus.h
> index 0e1e63bd85..14dbc8ff0d 100644
> --- a/include/system/cpus.h
> +++ b/include/system/cpus.h
> @@ -44,4 +44,8 @@ void cpu_synchronize_all_pre_loadvm(void);
>  bool bql_watchdog_set_timeout_ms(uint64_t ms, Error **errp);
>  uint64_t bql_watchdog_get_timeout_ms(void);
>=20=20
> +/* Abort after reporting, to leave a core behind. */
> +void bql_watchdog_set_abort(bool enable);
> +bool bql_watchdog_get_abort(void);
> +
>  #endif
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9600620d34..f43d8ca480 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -33,6 +33,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "                dump-guest-core=3Don|off include guest memory in a =
core dump (default=3Don)\n"
>      "                mem-merge=3Don|off controls memory merge support (d=
efault: on)\n"
>      "                bql-watchdog-ms=3Dms report a Big QEMU Lock held lo=
nger than ms (default: 0, off)\n"
> +    "                bql-watchdog-abort=3Don|off abort after the bql-wat=
chdog-ms report (default: off)\n"
>      "                aes-key-wrap=3Don|off controls support for AES key =
wrapping (default=3Don)\n"
>      "                dea-key-wrap=3Don|off controls support for DEA key =
wrapping (default=3Don)\n"
>      "                suppress-vmdesc=3Don|off disables self-describing m=
igration (default=3Doff)\n"
> @@ -94,6 +95,10 @@ SRST
>          milliseconds, up to a minute. The default is 0, which disables t=
he
>          watchdog.
>=20=20
> +    ``bql-watchdog-abort=3Don|off``
> +        Abort after the ``bql-watchdog-ms`` report, to leave a core dump.
> +        The default is off.
> +
>      ``aes-key-wrap=3Don|off``
>          Enables or disables AES key wrapping support on s390-ccw hosts.
>          This feature controls whether AES wrapping keys will be created
> diff --git a/system/cpus.c b/system/cpus.c
> index 03a07e4824..a200a07707 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -398,6 +398,7 @@ static int bql_this_tid(void)
>  static QemuThread bql_watchdog_thread;
>  static QemuSemaphore bql_watchdog_sem;
>  static uint64_t bql_watchdog_timeout_ms;
> +static bool bql_watchdog_abort;
>=20=20
>  static void bql_report_thread_states(void)
>  {
> @@ -411,6 +412,16 @@ static void bql_report_thread_states(void)
>      qemu_funlockfile(stderr);
>  }
>=20=20
> +bool bql_watchdog_get_abort(void)
> +{
> +    return qatomic_read(&bql_watchdog_abort);
> +}
> +
> +void bql_watchdog_set_abort(bool enable)
> +{
> +    qatomic_set(&bql_watchdog_abort, enable);
> +}
> +
>  static void *bql_watchdog_fn(void *opaque)
>  {
>      unsigned int last =3D qatomic_read(&bql_seq);
> @@ -456,6 +467,14 @@ static void *bql_watchdog_fn(void *opaque)
>                       when ?: "", when ? " " : "", timeout_ms,
>                       qatomic_read(&bql_owner_tid));
>          bql_report_thread_states();
> +        if (!qatomic_read(&bql_watchdog_abort)) {
> +            continue;
> +        }
> +        /*
> +         * A core carries the whole of every stack, and a qemu whose BQL=
 has
> +         * been held this long has stopped running its vCPUs anyway.
> +         */
> +        abort();
>      }
>  }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

