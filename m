Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB0AC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfdlr-0000x8-Jc; Fri, 03 Jul 2026 09:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfdll-0000uT-FK
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:17:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfdlj-0007p8-LJ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783084641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyfhA19MjQd2ohJedRIzqoH4SSddpDteTmZirxHlc1g=;
 b=VtnQTVLT7/7JzEcAyCniDv5AxQ1KaPjMtGLuFuJiQ/WGNQ62Lf+O4tQ7V7C7OOL2uXLDbj
 qemaC3dP9v1l46NRCYymOwPCLR6bOdOOpGcA1G6Zj74iUNGHumyJK7fbhUJWybFVZcoCEy
 lueyoagh8rwxII4PRJGj6CYqSTJY5yE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-_YWGWJteOZaBmBjB1X2pUw-1; Fri,
 03 Jul 2026 09:17:17 -0400
X-MC-Unique: _YWGWJteOZaBmBjB1X2pUw-1
X-Mimecast-MFC-AGG-ID: _YWGWJteOZaBmBjB1X2pUw_1783084636
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 816E1188E196; Fri,  3 Jul 2026 13:17:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CB6A30030D6; Fri,  3 Jul 2026 13:17:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 101B521E6920; Fri, 03 Jul 2026 15:17:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr. David
 Alan Gilbert" <dave@treblig.org>,  Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Christian Brauner <brauner@kernel.org>,  devel@lists.libvirt.org,  Peter
 Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v6 06/34] monitor: add 'chardev' property to Monitor
 base class
In-Reply-To: <20260702160337.1910921-7-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 2 Jul 2026 17:03:09
 +0100")
References: <20260702160337.1910921-1-berrange@redhat.com>
 <20260702160337.1910921-7-berrange@redhat.com>
Date: Fri, 03 Jul 2026 15:17:11 +0200
Message-ID: <87zf08usa0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This is associates both QMP and HMP monitors with a character
> device backend.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Tested-by: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  chardev/char.c             |  3 ++-
>  gdbstub/system.c           |  4 ++--
>  include/monitor/monitor.h  |  4 ++--
>  monitor/hmp.c              | 10 ++++++--
>  monitor/monitor-internal.h |  2 ++
>  monitor/monitor.c          | 47 ++++++++++++++++++++++++++++++--------
>  monitor/qmp.c              | 18 ++++++++++-----
>  stubs/monitor-internal.c   |  2 +-
>  8 files changed, 67 insertions(+), 23 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index c71ffa7963..22e5bae388 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -804,8 +804,9 @@ static Chardev *qemu_chr_new_from_name(const char *la=
bel, const char *filename,
>      }
>=20=20
>      if (qemu_opt_get_bool(opts, "mux", 0)) {
> +        const char *chardev_id =3D qemu_opts_id(opts);
>          assert(permit_mux_mon);
> -        monitor_new_hmp(NULL, chr, true, &err);
> +        monitor_new_hmp(NULL, chardev_id, true, &err);
>          if (err) {
>              error_report_err(err);
>              object_unparent(OBJECT(chr));
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index fda8ef9352..d681476f5e 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -387,9 +387,9 @@ bool gdbserver_start(const char *device, Error **errp)
>          qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
>=20=20
>          /* Initialize a monitor terminal for gdb */
> -        mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
> +        mon_chr =3D qemu_chardev_new("gdbchrdev0", TYPE_CHARDEV_GDB,
>                                     NULL, NULL, &error_abort);

This chardev now gets ID "gdbchrdev0" instead of id_generate(ID_CHR).

If you truly need this, you have to mention it in the commit message.

> -        monitor_new_hmp(NULL, mon_chr, false, &error_abort);
> +        monitor_new_hmp(NULL, "gdbchrdev0", false, &error_abort);

If you don't, then passing mon_chr->label here should do the trick.

>      } else {
>          qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
>          mon_chr =3D gdbserver_system_state.mon_chr;
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 83723f705a..bfbeedec9b 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -29,9 +29,9 @@ bool monitor_cur_is_qmp(void);
>  void monitor_init_globals(void);
>  void monitor_init_globals_core(void);
>  char *monitor_compat_id(void);
> -void monitor_new_qmp(const char *id, Chardev *chr,
> +void monitor_new_qmp(const char *id, const char *chardev_id,
>                       bool pretty, Error **errp);
> -void monitor_new_hmp(const char *id, Chardev *chr,
> +void monitor_new_hmp(const char *id, const char *chardev_id,
>                       bool use_readline, Error **errp);
>  int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp);
>  int monitor_new_opts(QemuOpts *opts, Error **errp);
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index da11e56854..be59b6ca65 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -23,6 +23,7 @@
>   */
>=20=20
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include <dirent.h>
>  #include "hw/core/qdev.h"
>  #include "hw/core/sysemu-cpu-ops.h"
> @@ -1538,22 +1539,27 @@ static void monitor_readline_flush(void *opaque)
>      monitor_flush(&mon->parent_obj);
>  }
>=20=20
> -void monitor_new_hmp(const char *id, Chardev *chr,
> +void monitor_new_hmp(const char *id, const char *chardev_id,
>                       bool use_readline, Error **errp)

You now pass a chardev ID instead of a Chardev *.

I *guess* that's possible because chardev_new() asserts it's passed an
ID.

I should now check all callers of monitor_new_hmp() to make sure they
pass the correct ID.  On a Friday afternoon.  I hoist the white flag.

Such refactorings should be mentioned in the commit message.  Even
better would be a separate patch.

>  {
> +    ERRP_GUARD();
>      MonitorHMP *mon;
>      g_autofree char *autoid =3D id ? NULL : monitor_compat_id();
>      Object *obj =3D object_new_with_props(TYPE_MONITOR_HMP,
>                                          object_get_objects_root(),
>                                          id ? id : autoid,
>                                          errp,
> +                                        "chardev", chardev_id,
>                                          NULL);
> +
>      if (!obj) {
>          return;
>      }
> +
>      mon =3D MONITOR_HMP(obj);
>=20=20
> -    if (!qemu_chr_fe_init(&mon->parent_obj.chr, chr, errp)) {
> +    monitor_complete(MONITOR(mon), errp);
> +    if (*errp) {
>          object_unparent(OBJECT(mon));
>          return;
>      }

[...]


