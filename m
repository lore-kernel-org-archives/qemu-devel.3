Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488A5F45A0D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 23:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBLLS-0005i0-Jl; Fri, 10 Apr 2026 19:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wBLLN-0005hO-33; Fri, 10 Apr 2026 19:32:58 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wBLLK-0002k1-EH; Fri, 10 Apr 2026 19:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=YuQ4MgQGPWHlp48NbbbjWxCyQP5Q/VUz3jMzeRmXu5o=; b=FotV5q1i+TbpDdmH
 qnGCQFWuwWV9rqg6wVKUtR7J0Nu7TbLxuZfucmrVU/8aNHTXV5v/Wtc5ahoWzjeP2IPoAflesGRNr
 EKTH9ACv4d/5CsqD3sfWY6LNwUDtTcfdC03oPl2W0ysTnZRKcQC+OWsQxhkrzvp93pWAplNpeK/Tc
 mJzuTgDlNpm8kQqyctwiXPhASLx0Sjg+ugfqVqSy8QTOejU4sIQ524R/bqgpisklV3ZTOAjXlG3Wq
 V8mSNPD9wCNJoZNqNFlNmqykvOm1It/zAj/f5di1BZOfzwwQOUmiDrP6ocRe3mQIPW5KEYRBAGSEN
 RU5LC9YSgAuiw6KDTA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wBLLH-00000007Zo9-1MvW;
 Fri, 10 Apr 2026 23:32:51 +0000
Date: Fri, 10 Apr 2026 23:32:51 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 04/17] monitor: minimal conversion of monitors to QOM
Message-ID: <admIo3uTjcH2OOWH@gallifrey>
References: <20260410160458.3778874-1-berrange@redhat.com>
 <20260410160458.3778874-5-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410160458.3778874-5-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.74+deb13+1-amd64 (x86_64)
X-Uptime: 23:32:28 up 29 days, 45 min,  2 users,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> This introduces a Monitor QOM object, with MonitorHMP and
> MonitorQMP subclasses. This is the bare minimum conversion
> of just the type declarations and replacing g_new/g_free
> with object_new/object_unref.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Looks OK, but I'm not that familiar with QOM, so just:

Acked-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  include/monitor/monitor.h  | 11 ++++++++++-
>  monitor/hmp.c              | 18 ++++++++++++++++--
>  monitor/monitor-internal.h | 18 ++++++++++++++++--
>  monitor/monitor.c          | 18 ++++++++++++++++--
>  monitor/qmp-cmds.c         | 15 ++++++++-------
>  monitor/qmp.c              | 18 ++++++++++++++++--
>  6 files changed, 82 insertions(+), 16 deletions(-)
> 
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index bfbb440550..b349b12c34 100644
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
>  
> -typedef struct MonitorHMP MonitorHMP;
>  typedef struct MonitorOptions MonitorOptions;
>  
>  #define QMP_REQ_QUEUE_LEN_MAX 8
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 6dfeca84b5..614d9a3707 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -42,6 +42,20 @@
>  #include "system/block-backend.h"
>  #include "trace.h"
>  
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
> @@ -1518,10 +1532,10 @@ static void monitor_readline_flush(void *opaque)
>  
>  void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
>  {
> -    MonitorHMP *mon = g_new0(MonitorHMP, 1);
> +    MonitorHMP *mon = MONITOR_HMP(object_new(TYPE_MONITOR_HMP));
>  
>      if (!qemu_chr_fe_init(&mon->parent.chr, chr, errp)) {
> -        g_free(mon);
> +        object_unref(mon);
>          return;
>      }
>  
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 0922588ad9..25320928a7 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -92,7 +92,13 @@ typedef struct HMPCommand {
>      void (*command_completion)(ReadLineState *rs, int nb_args, const char *str);
>  } HMPCommand;
>  
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
> @@ -118,6 +124,10 @@ struct Monitor {
>      int reset_seen;
>  };
>  
> +struct MonitorHMPClass {
> +    MonitorClass parent_class;
> +};
> +
>  struct MonitorHMP {
>      Monitor parent;
>      bool use_readline;
> @@ -131,7 +141,11 @@ struct MonitorHMP {
>      ReadLineState *rs;
>  };
>  
> -typedef struct {
> +struct MonitorQMPClass {
> +    MonitorClass parent_class;
> +};
> +
> +struct MonitorQMP {
>      Monitor parent;
>      JSONMessageParser parser;
>      bool pretty;
> @@ -151,7 +165,7 @@ typedef struct {
>      QemuMutex qmp_queue_lock;
>      /* Input queue that holds all the parsed QMP requests */
>      GQueue *qmp_requests;
> -} MonitorQMP;
> +};
>  
>  /**
>   * Is @mon a QMP monitor?
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 393fb7795e..7936e2ab22 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -73,6 +73,20 @@ static GHashTable *coroutine_mon; /* Maps Coroutine* to Monitor* */
>  MonitorList mon_list;
>  static bool monitor_destroyed;
>  
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
>  
>      if (mon) {
>          monitor_data_destroy(mon);
> -        g_free(mon);
> +        object_unref(mon);
>      }
>  }
>  
> @@ -680,7 +694,7 @@ void monitor_cleanup(void)
>          monitor_flush(mon);
>          monitor_data_destroy(mon);
>          qemu_mutex_lock(&monitor_lock);
> -        g_free(mon);
> +        object_unref(mon);
>      }
>      qemu_mutex_unlock(&monitor_lock);
>  
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index 191eba1b3a..d0ed241d6a 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -166,12 +166,12 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>                                  int64_t cpu_index, Error **errp)
>  {
>      char *output = NULL;
> -    MonitorHMP hmp = {};
> +    MonitorHMP *hmp = MONITOR_HMP(object_new(TYPE_MONITOR_HMP));
>  
> -    monitor_data_init(&hmp.parent, false, true, false);
> +    monitor_data_init(&hmp->parent, false, true, false);
>  
>      if (has_cpu_index) {
> -        int ret = monitor_set_cpu(&hmp.parent, cpu_index);
> +        int ret = monitor_set_cpu(&hmp->parent, cpu_index);
>          if (ret < 0) {
>              error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
>                         "a CPU number");
> @@ -179,14 +179,15 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>          }
>      }
>  
> -    handle_hmp_command(&hmp, command_line);
> +    handle_hmp_command(hmp, command_line);
>  
> -    WITH_QEMU_LOCK_GUARD(&hmp.parent.mon_lock) {
> -        output = g_strdup(hmp.parent.outbuf->str);
> +    WITH_QEMU_LOCK_GUARD(&hmp->parent.mon_lock) {
> +        output = g_strdup(hmp->parent.outbuf->str);
>      }
>  
>  out:
> -    monitor_data_destroy(&hmp.parent);
> +    monitor_data_destroy(&hmp->parent);
> +    object_unref(hmp);
>      return output;
>  }
>  
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 9caee70624..36cb078f30 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -71,6 +71,20 @@ typedef struct QMPRequest QMPRequest;
>  
>  QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
>  
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
> @@ -515,10 +529,10 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
>  
>  void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
>  {
> -    MonitorQMP *mon = g_new0(MonitorQMP, 1);
> +    MonitorQMP *mon = MONITOR_QMP(object_new(TYPE_MONITOR_QMP));
>  
>      if (!qemu_chr_fe_init(&mon->parent.chr, chr, errp)) {
> -        g_free(mon);
> +        object_unref(mon);
>          return;
>      }
>      qemu_chr_fe_set_echo(&mon->parent.chr, true);
> -- 
> 2.53.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

