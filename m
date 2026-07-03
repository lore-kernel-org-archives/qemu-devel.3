Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B971BC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfdJn-00028d-Dj; Fri, 03 Jul 2026 08:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfdJh-00021u-6D
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfdJe-00065T-NC
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783082901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wSKE0kCaaJqtzMyQQhIsIx2kt4BzhMJHyOU896FW/P4=;
 b=MFpsVHPHdn+Yx85/4ylXL2VhUVNzaTU7uTwS3Qhnq2nofLe0Z/CRXHUNOBOWRSXl7Wp1wI
 SazO/5vfgeoWw26wbESCoplU/Ol4q0QqHy2+quDmLbJ056AtxjsmjSKETDQM+7HF76XHMh
 rJstHFdeUpYhcduL7/WeGBYXlQIbM1E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-IIl8emJ5PvySPOZC-zecQw-1; Fri,
 03 Jul 2026 08:48:20 -0400
X-MC-Unique: IIl8emJ5PvySPOZC-zecQw-1
X-Mimecast-MFC-AGG-ID: IIl8emJ5PvySPOZC-zecQw_1783082898
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AC1B1921EF3; Fri,  3 Jul 2026 12:48:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60AC436F24; Fri,  3 Jul 2026 12:48:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EE86721E6920; Fri, 03 Jul 2026 14:48:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr. David
 Alan Gilbert" <dave@treblig.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Christian
 Brauner <brauner@kernel.org>,  devel@lists.libvirt.org
Subject: Re: [PATCH v6 05/34] monitor: minimal conversion of monitors to QOM
In-Reply-To: <20260702160337.1910921-6-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 2 Jul 2026 17:03:08
 +0100")
References: <20260702160337.1910921-1-berrange@redhat.com>
 <20260702160337.1910921-6-berrange@redhat.com>
Date: Fri, 03 Jul 2026 14:48:14 +0200
Message-ID: <87echkw86p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> This introduces a Monitor QOM object, with MonitorHMP and
> MonitorQMP subclasses. This is the bare minimum conversion
> of just the type declarations and replacing g_new/g_free
> with object_new/object_unref. The Monitor base class is
> abstract since only the HMP/QMP variants should ever be
> created.
>
> When created through the existing QemuOpts interfaces, the
> new internal QOM object will get assigned a dynamic ID with
> the format "compat_monitorNNN" which is the historical
> QemuOpts ID naming pattern.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  chardev/char.c             |  2 +-
>  gdbstub/system.c           |  2 +-
>  include/monitor/monitor.h  | 18 +++++++++++++++---
>  monitor/hmp.c              | 31 ++++++++++++++++++++++++++++---
>  monitor/monitor-internal.h | 18 ++++++++++++++++--
>  monitor/monitor.c          | 31 +++++++++++++++++++++++++++----
>  monitor/qmp-cmds.c         | 15 ++++++++-------
>  monitor/qmp.c              | 31 ++++++++++++++++++++++++++++---
>  stubs/monitor-internal.c   |  3 ++-
>  system/vl.c                |  7 +++----
>  10 files changed, 129 insertions(+), 29 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 813c04d953..c71ffa7963 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -805,7 +805,7 @@ static Chardev *qemu_chr_new_from_name(const char *la=
bel, const char *filename,
>=20=20
>      if (qemu_opt_get_bool(opts, "mux", 0)) {
>          assert(permit_mux_mon);
> -        monitor_new_hmp(chr, true, &err);
> +        monitor_new_hmp(NULL, chr, true, &err);

Yet another way to create a monitor, not covered by the commit message.

We get here for legacy chardev syntax "mon:...", I think.  Where exactly
in the external interface this is accepted I'm not sure.  It's
documented for -serial.  See qemu-options.hx.

There is no "mon" QemuOpts.

You pass NULL to monitor_new_hmp(), which makes it create the object as
/objects/compat_monitorNNN.


>          if (err) {
>              error_report_err(err);
>              object_unparent(OBJECT(chr));
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index 18f6a62b2e..fda8ef9352 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -389,7 +389,7 @@ bool gdbserver_start(const char *device, Error **errp)
>          /* Initialize a monitor terminal for gdb */
>          mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
>                                     NULL, NULL, &error_abort);
> -        monitor_new_hmp(mon_chr, false, &error_abort);
> +        monitor_new_hmp(NULL, mon_chr, false, &error_abort);

And yet another, also no "mon" QemuOpts, and also
/objects/compat_monitorNNN.

>      } else {
>          qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
>          mon_chr =3D gdbserver_system_state.mon_chr;
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index b9642b58ba..83723f705a 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -5,8 +5,17 @@
>  #include "qapi/qapi-types-misc.h"
>  #include "qemu/readline.h"
>  #include "exec/hwaddr.h"
> +#include "qom/object.h"
> +
> +#define TYPE_MONITOR "monitor"
> +OBJECT_DECLARE_TYPE(Monitor, MonitorClass, MONITOR);
> +
> +#define TYPE_MONITOR_HMP "monitor-hmp"
> +OBJECT_DECLARE_TYPE(MonitorHMP, MonitorHMPClass, MONITOR_HMP);
> +
> +#define TYPE_MONITOR_QMP "monitor-qmp"
> +OBJECT_DECLARE_TYPE(MonitorQMP, MonitorQMPClass, MONITOR_QMP);
>=20=20
> -typedef struct MonitorHMP MonitorHMP;
>  typedef struct MonitorOptions MonitorOptions;
>=20=20
>  #define QMP_REQ_QUEUE_LEN_MAX 8
> @@ -19,8 +28,11 @@ bool monitor_cur_is_qmp(void);
>=20=20
>  void monitor_init_globals(void);
>  void monitor_init_globals_core(void);
> -void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp);
> -void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp);
> +char *monitor_compat_id(void);
> +void monitor_new_qmp(const char *id, Chardev *chr,
> +                     bool pretty, Error **errp);
> +void monitor_new_hmp(const char *id, Chardev *chr,
> +                     bool use_readline, Error **errp);
>  int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp);
>  int monitor_new_opts(QemuOpts *opts, Error **errp);
>  void monitor_cleanup(void);
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 4e4468424a..da11e56854 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -43,6 +43,20 @@
>  #include "system/block-backend.h"
>  #include "trace.h"
>=20=20
> +OBJECT_DEFINE_TYPE(MonitorHMP, monitor_hmp, MONITOR_HMP, MONITOR);
> +
> +static void monitor_hmp_finalize(Object *obj)
> +{
> +}
> +
> +static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
> +{
> +}
> +
> +static void monitor_hmp_init(Object *obj)
> +{
> +}
> +
>  static void monitor_command_cb(void *opaque, const char *cmdline,
>                                 void *readline_opaque)
>  {
> @@ -1524,12 +1538,23 @@ static void monitor_readline_flush(void *opaque)
>      monitor_flush(&mon->parent_obj);
>  }
>=20=20
> -void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
> +void monitor_new_hmp(const char *id, Chardev *chr,
> +                     bool use_readline, Error **errp)
>  {
> -    MonitorHMP *mon =3D g_new0(MonitorHMP, 1);
> +    MonitorHMP *mon;
> +    g_autofree char *autoid =3D id ? NULL : monitor_compat_id();
> +    Object *obj =3D object_new_with_props(TYPE_MONITOR_HMP,
> +                                        object_get_objects_root(),
> +                                        id ? id : autoid,
> +                                        errp,
> +                                        NULL);
> +    if (!obj) {
> +        return;
> +    }
> +    mon =3D MONITOR_HMP(obj);
>=20=20
>      if (!qemu_chr_fe_init(&mon->parent_obj.chr, chr, errp)) {
> -        g_free(mon);
> +        object_unparent(OBJECT(mon));
>          return;
>      }
>=20=20
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 4da2b2a677..05c1f2f5e0 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -101,7 +101,13 @@ typedef struct HMPCommand {
>      bool coroutine;
>  } HMPCommand;
>=20=20
> +
> +struct MonitorClass {
> +    ObjectClass parent_class;
> +};
> +
>  struct Monitor {
> +    Object parent;
>      CharFrontend chr;
>      int suspend_cnt;            /* Needs to be accessed atomically */
>      bool is_qmp;
> @@ -127,6 +133,10 @@ struct Monitor {
>      int reset_seen;
>  };
>=20=20
> +struct MonitorHMPClass {
> +    MonitorClass parent_class;
> +};
> +
>  struct MonitorHMP {
>      Monitor parent_obj;
>      bool use_readline;
> @@ -140,7 +150,11 @@ struct MonitorHMP {
>      ReadLineState *rs;
>  };
>=20=20
> -typedef struct {
> +struct MonitorQMPClass {
> +    MonitorClass parent_class;
> +};
> +
> +struct MonitorQMP {
>      Monitor parent_obj;
>      JSONMessageParser parser;
>      bool pretty;
> @@ -160,7 +174,7 @@ typedef struct {
>      QemuMutex qmp_queue_lock;
>      /* Input queue that holds all the parsed QMP requests */
>      GQueue *qmp_requests;
> -} MonitorQMP;
> +};
>=20=20
>  /**
>   * Is @mon a QMP monitor?
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index a87597e606..18a1d8ddde 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -73,6 +73,22 @@ static GHashTable *coroutine_mon; /* Maps Coroutine* t=
o Monitor* */
>  MonitorList mon_list;
>  static bool monitor_destroyed;
>=20=20
> +int monitor_device_index;
> +
> +OBJECT_DEFINE_ABSTRACT_TYPE(Monitor, monitor, MONITOR, OBJECT);
> +
> +static void monitor_finalize(Object *obj)
> +{
> +}
> +
> +static void monitor_class_init(ObjectClass *cls, const void *data)
> +{
> +}
> +
> +static void monitor_init(Object *obj)
> +{
> +}
> +
>  Monitor *monitor_cur(void)
>  {
>      Monitor *mon;
> @@ -598,7 +614,7 @@ void monitor_list_append(Monitor *mon)
>=20=20
>      if (mon) {
>          monitor_data_destroy(mon);
> -        g_free(mon);
> +        object_unparent(OBJECT(mon));
>      }
>  }
>=20=20
> @@ -680,7 +696,7 @@ void monitor_cleanup(void)
>          monitor_flush(mon);
>          monitor_data_destroy(mon);
>          qemu_mutex_lock(&monitor_lock);
> -        g_free(mon);
> +        object_unparent(OBJECT(mon));
>      }
>      qemu_mutex_unlock(&monitor_lock);
>=20=20
> @@ -715,6 +731,13 @@ void monitor_init_globals(void)
>      aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
>  }
>=20=20
> +char *monitor_compat_id(void)
> +{
> +    static int monitor_device_index;
> +
> +    return g_strdup_printf("compat_monitor%d", monitor_device_index++);
> +}
> +
>  int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
>  {
>      ERRP_GUARD();
> @@ -732,7 +755,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp,=
 Error **errp)
>=20=20
>      switch (opts->mode) {
>      case MONITOR_MODE_CONTROL:
> -        monitor_new_qmp(chr, opts->pretty, errp);
> +        monitor_new_qmp(opts->id, chr, opts->pretty, errp);
>          break;
>      case MONITOR_MODE_READLINE:
>          if (!allow_hmp) {
> @@ -743,7 +766,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp,=
 Error **errp)
>              error_setg(errp, "'pretty' is not compatible with HMP monito=
rs");
>              return -1;
>          }
> -        monitor_new_hmp(chr, true, errp);
> +        monitor_new_hmp(opts->id, chr, true, errp);
>          break;
>      default:
>          g_assert_not_reached();
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index aa9ee8a391..bfde769ef0 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -166,12 +166,12 @@ char *qmp_human_monitor_command(const char *command=
_line, bool has_cpu_index,
>                                  int64_t cpu_index, Error **errp)
>  {
>      char *output =3D NULL;
> -    MonitorHMP hmp =3D {};
> +    MonitorHMP *hmp =3D MONITOR_HMP(object_new(TYPE_MONITOR_HMP));
>=20=20
> -    monitor_data_init(&hmp.parent_obj, false, true, false);
> +    monitor_data_init(&hmp->parent_obj, false, true, false);
>=20=20
>      if (has_cpu_index) {
> -        int ret =3D monitor_set_cpu(&hmp.parent_obj, cpu_index);
> +        int ret =3D monitor_set_cpu(&hmp->parent_obj, cpu_index);
>          if (ret < 0) {
>              error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
>                         "a CPU number");
> @@ -179,14 +179,15 @@ char *qmp_human_monitor_command(const char *command=
_line, bool has_cpu_index,
>          }
>      }
>=20=20
> -    handle_hmp_command(&hmp, command_line);
> +    handle_hmp_command(hmp, command_line);
>=20=20
> -    WITH_QEMU_LOCK_GUARD(&hmp.parent_obj.mon_lock) {
> -        output =3D g_strdup(hmp.parent_obj.outbuf->str);
> +    WITH_QEMU_LOCK_GUARD(&hmp->parent_obj.mon_lock) {
> +        output =3D g_strdup(hmp->parent_obj.outbuf->str);
>      }
>=20=20
>  out:
> -    monitor_data_destroy(&hmp.parent_obj);
> +    monitor_data_destroy(&hmp->parent_obj);
> +    object_unref(hmp);
>      return output;
>  }
>=20=20
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index cb28a95efd..1ef09352fc 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -71,6 +71,20 @@ typedef struct QMPRequest QMPRequest;
>=20=20
>  QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
>=20=20
> +OBJECT_DEFINE_TYPE(MonitorQMP, monitor_qmp, MONITOR_QMP, MONITOR);
> +
> +static void monitor_qmp_finalize(Object *obj)
> +{
> +}
> +
> +static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
> +{
> +}
> +
> +static void monitor_qmp_init(Object *obj)
> +{
> +}
> +
>  static bool qmp_oob_enabled(MonitorQMP *mon)
>  {
>      return mon->capab[QMP_CAPABILITY_OOB];
> @@ -513,12 +527,23 @@ static void monitor_qmp_setup_handlers_bh(void *opa=
que)
>      monitor_list_append(&mon->parent_obj);
>  }
>=20=20
> -void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
> +void monitor_new_qmp(const char *id, Chardev *chr,
> +                     bool pretty, Error **errp)
>  {
> -    MonitorQMP *mon =3D g_new0(MonitorQMP, 1);
> +    MonitorQMP *mon;
> +    g_autofree char *autoid =3D id ? NULL : monitor_compat_id();
> +    Object *obj =3D object_new_with_props(TYPE_MONITOR_QMP,
> +                                        object_get_objects_root(),
> +                                        id ? id : autoid,
> +                                        errp,
> +                                        NULL);
> +    if (!obj) {
> +        return;
> +    }
> +    mon =3D MONITOR_QMP(obj);
>=20=20
>      if (!qemu_chr_fe_init(&mon->parent_obj.chr, chr, errp)) {
> -        g_free(mon);
> +        object_unparent(OBJECT(mon));
>          return;
>      }
>      qemu_chr_fe_set_echo(&mon->parent_obj.chr, true);
> diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
> index 23d58da184..20367b7e9a 100644
> --- a/stubs/monitor-internal.c
> +++ b/stubs/monitor-internal.c
> @@ -8,6 +8,7 @@ int monitor_get_fd(Monitor *mon, const char *name, Error =
**errp)
>      return -1;
>  }
>=20=20
> -void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
> +void monitor_new_hmp(const char *id, Chardev *chr,
> +                     bool use_readline, Error **errp)
>  {
>  }
> diff --git a/system/vl.c b/system/vl.c
> index 6643242729..4737c03872 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1252,7 +1252,6 @@ static int mon_init_func(void *opaque, QemuOpts *op=
ts, Error **errp)
>=20=20
>  static void monitor_parse(const char *str, const char *mode, bool pretty)
>  {
> -    static int monitor_device_index =3D 0;
>      QemuOpts *opts;
>      const char *p;
>      char label[32];
> @@ -1260,8 +1259,9 @@ static void monitor_parse(const char *str, const ch=
ar *mode, bool pretty)
>      if (strstart(str, "chardev:", &p)) {
>          snprintf(label, sizeof(label), "%s", p);
>      } else {
> -        snprintf(label, sizeof(label), "compat_monitor%d",
> -                 monitor_device_index);
> +        g_autofree char *id =3D monitor_compat_id();
> +        assert(strlen(id) < sizeof(label));
> +        memcpy(label, id, strlen(id) + 1);
>          opts =3D qemu_chr_parse_compat(label, str, true);
>          if (!opts) {
>              error_report("parse error: %s", str);
> @@ -1277,7 +1277,6 @@ static void monitor_parse(const char *str, const ch=
ar *mode, bool pretty)
>      } else {
>          assert(pretty =3D=3D false);
>      }
> -    monitor_device_index++;

Before the patch, we increment the NNN in "compat_monitorNNN" exactly
here.

Afterwards, we increment it in monitor_compat_id(), which gets called
from here and several additional places.

If any of the additional places execute before an execution of the
original place, NNN change.

Feels tolerable, but needs a mention in the commit message.

>  }
>=20=20
>  struct device_config {


