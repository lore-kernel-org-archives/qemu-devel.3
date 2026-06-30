Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADFBC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weX4Q-0004MB-UI; Tue, 30 Jun 2026 07:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weX4P-0004Lz-8l
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weX4N-0002Fw-0A
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782820561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dertizESOFp05RgaimZvRhWFHk930vb3+O0HybsxMK4=;
 b=KpNJbNWvL/9I84125X/rMoMcOdxLiNesImZOl2eoMgbOATMgSI9g0WHWWBygsQy3GSbZuq
 b0xiQo7wsEjiUk1kPuvYwI8Xn2Xxtln7H3l8inCxkNmpRjWZ+CToDi1YRNc1GwxbfzP9h2
 9VB9pCmBbL9ypJarTpkqmGW57KQmO5M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-ncIGXh49OqGrKvtWjbyIUQ-1; Tue,
 30 Jun 2026 07:55:57 -0400
X-MC-Unique: ncIGXh49OqGrKvtWjbyIUQ-1
X-Mimecast-MFC-AGG-ID: ncIGXh49OqGrKvtWjbyIUQ_1782820556
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 639801800A3B; Tue, 30 Jun 2026 11:55:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E32E36926; Tue, 30 Jun 2026 11:55:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C6F4921E6920; Tue, 30 Jun 2026 13:55:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  devel@lists.libvirt.org,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Peter Krempa
 <pkrempa@redhat.com>
Subject: Re: [PATCH v5 05/35] monitor: minimal conversion of monitors to QOM
In-Reply-To: <20260624173752.2928717-6-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 24 Jun 2026 18:37:21
 +0100")
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-6-berrange@redhat.com>
Date: Tue, 30 Jun 2026 13:55:52 +0200
Message-ID: <87o6gs1buf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

> This introduces a Monitor QOM object, with MonitorHMP and
> MonitorQMP subclasses. This is the bare minimum conversion
> of just the type declarations and replacing g_new/g_free
> with object_new/object_unref.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Tested-by: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/monitor/monitor.h  | 11 ++++++++++-
>  monitor/hmp.c              | 29 +++++++++++++++++++++++++++--
>  monitor/monitor-internal.h | 18 ++++++++++++++++--
>  monitor/monitor.c          | 18 ++++++++++++++++--
>  monitor/qmp-cmds.c         | 15 ++++++++-------
>  monitor/qmp.c              | 29 +++++++++++++++++++++++++++--
>  6 files changed, 104 insertions(+), 16 deletions(-)
>
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index b9642b58ba..2e9f9e12e9 100644
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
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 4e4468424a..81047d2513 100644
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
> @@ -1526,10 +1540,21 @@ static void monitor_readline_flush(void *opaque)
>=20=20
>  void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
>  {
> -    MonitorHMP *mon =3D g_new0(MonitorHMP, 1);
> +    MonitorHMP *mon;
> +    static int counter;
> +    g_autofree char *id =3D g_strdup_printf("hmpcompat%d", counter++);

Hmm.  The system picking IDs is problematic when they can clash with the
user's IDs.  If we had an ounce of common sense, we'd restrict both
across the board so they cannot clash.  But we don't.

We need an ID here, because we need to make the new object the child of
something (actually: child of /objects/), which requires a child name.

Non-problem with -object / object-add, because @id is mandatory there.

Non-problem with -device / device_add, because we use separate parents
for devices with and without @id (/machine/peripheral/ and
/machine/peripheral-anon/, plus the /machine/unattached/ orphanage).

Example for an existing problem:

    $ qemu-system-x86_64 -nodefaults -monitor stdio -chardev null,id=3Dchr0=
 -mon id=3Dcompat_monitor0,chardev=3Dchr0
    qemu-system-x86_64: -mon id=3Dcompat_monitor0,chardev=3Dchr0: Duplicate=
 ID 'compat_monitor0' for mon

Example for a problem created by this series:

    $  qemu-system-x86_64 -nodefaults -display none -S -monitor stdio -char=
dev null,id=3Dchr0 -object monitor-hmp,id=3Dhmpcompat0,chardev=3Dchr0
    qemu-system-x86_64: -monitor stdio: attempt to add duplicate property '=
hmpcompat0' to object (type 'container')

I readily admit that these clashes are *unlikely*.  Still, do we really
want to define an interface that claims to let you pick any ID, then
rejects some of them sometimes?  Feels rather 1990s to me.  At the very
least, cover the wart in the commit message.

This existing problem example leads me to the next mess: interaction
with monitors' *other* ID.

qemu-system-FOO's -mon accepts an optional "id" parameter.  It goes into
its QemuOpts, and from there into MonitorOptions member @id.

qemu-storage-daemon's --monitor is similar, except it bypasses QemuOpts.

qemu-system-FOO provides convenience options -monitor, -qmp,
-qmp-pretty.

Their argument may refer to an existing chardev by ID, like
"chardev:ID".  This creates a monitor with that same[*] QemuOpts and
MonitorOptions ID.

Else, their argument is character device configuration in legacy syntax,
like "stdio".  This creates both a monitor and a character device, with
ID "compat_monitorN", where N counts up from zero.  The character device
is visible in "info chardev", as always.

Aside: in both cases we use the same ID for two different objects, which
feels unadvisable.

Aside: we have code checking whether a QemuOpts or character device ID
starts with "compat_monitor", which is horryfying.

Your series does not mess with this at all.  Understandable; I stay out
of this swamp when I can, too.

However, it results in monitors having two IDs, namely the one in
MonitorOptions, and the one in /object/.  This is confusing.

Perhaps we should we'd get rid of the one in MonitorOptions.  May well
be more trouble than it's worth.

Could we at least make the two IDs the same?

> +    Object *obj =3D object_new_with_props(TYPE_MONITOR_HMP,
> +                                        object_get_objects_root(),
> +                                        id,
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
> index a87597e606..a497c25c54 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -73,6 +73,20 @@ static GHashTable *coroutine_mon; /* Maps Coroutine* t=
o Monitor* */
>  MonitorList mon_list;
>  static bool monitor_destroyed;
>=20=20
> +OBJECT_DEFINE_TYPE(Monitor, monitor, MONITOR, OBJECT);
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
> @@ -598,7 +612,7 @@ void monitor_list_append(Monitor *mon)
>=20=20
>      if (mon) {
>          monitor_data_destroy(mon);
> -        g_free(mon);
> +        object_unparent(OBJECT(mon));
>      }
>  }
>=20=20
> @@ -680,7 +694,7 @@ void monitor_cleanup(void)
>          monitor_flush(mon);
>          monitor_data_destroy(mon);
>          qemu_mutex_lock(&monitor_lock);
> -        g_free(mon);
> +        object_unparent(OBJECT(mon));
>      }
>      qemu_mutex_unlock(&monitor_lock);
>=20=20

Hmm...

    {"execute": "qom-list-types", "arguments": {"implements": "monitor"}}
    {"return": [{"name": "monitor-hmp", "parent": "monitor"}, {"name": "mon=
itor-qmp", "parent": "monitor"}, {"name": "monitor", "parent": "object"}]}

Shouldn't type "monitor" be abstract?

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
> index cb28a95efd..5231ed506a 100644
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
> @@ -515,10 +529,21 @@ static void monitor_qmp_setup_handlers_bh(void *opa=
que)
>=20=20
>  void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
>  {
> -    MonitorQMP *mon =3D g_new0(MonitorQMP, 1);
> +    MonitorQMP *mon;
> +    static int counter;
> +    g_autofree char *id =3D g_strdup_printf("qmpcompat%d", counter++);
> +    Object *obj =3D object_new_with_props(TYPE_MONITOR_QMP,
> +                                        object_get_objects_root(),
> +                                        id,
> +                                        errp,
> +                                        NULL);

See discussion of monitor_new_hmp() above.

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


[*] Silently truncated to 31 characters.  I kid you not.


