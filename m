Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9101ACC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHNpY-0007Zb-8h; Thu, 15 Oct 2026 11:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1xHNpV-0007XO-8N
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:57:17 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1xHNpR-0006dl-HE
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=5DkVqtLl1i2gf2jHVa0L3rsN+EoMZS2YxefuCff2jtU=; b=YtpwX27u+wtwEEG3
 katq778mkTG8VgvwNuTaSft4hB0oZal7246bys9IvhF2khUT087aEqtG2+ry16tVitU/qbqeRxgKO
 RefRJ5k35ZbvvE8b//jA0bgIY+DZJiLUX2YMKUg2rB/E9lGoSCiU7fWoRfcAEPs4Xxp6CrDySUqWJ
 2MtmYBsbtBbW61m1Enqz99ChrJi4aJfLhhrFdPtwpH6JRTGVrfwiiedFqSfvuSF2Se/PVgJJVCvb5
 Jb/VljvADI1xQwo4aq2nmog6UAVTri9CE/YYy1sR91VDTKIoijv0gA2LHNbCE4wVi3vc+4JvDzEri
 oD2Wq2gr6mbqUtfX+Q==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1xHNpN-00000004c7P-1so2;
 Thu, 15 Oct 2026 15:57:09 +0000
Date: Thu, 15 Oct 2026 15:57:09 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 17/21] monitor: capture monitor commands and events in
 data recorder
Message-ID: <atD31Q9B9FgDWXeO@gallifrey>
References: <20261015112044.1999748-1-berrange@redhat.com>
 <20261015112044.1999748-18-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015112044.1999748-18-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.111+deb13-amd64 (x86_64)
X-Uptime: 15:55:40 up 16 days,  1:17,  2 users,  load average: 0.05, 0.07, 0.02
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
> QMP monitor commands which change system state (ie not query-XXX
> commands) are relevant to the data recorder, as they reflect what
> has been done to QEMU at runtime by the mgmt application.

Do you have any filters for avoiding capturing passwords/keys
(which admitedly they should be doing by files, but hmm).

Dave

> QMP monitor events are relevant to the data recorder, as they
> reflect a combination of what has been done to QEMU at runtime by
> the mgmt application, as well as changes triggered by the guest OS.
> 
> QMP error responses are relevant either to reveal mistakes in mgmt
> apps, or to reveal problems in QEMU. If the associated QMP command
> was not already recorded, it will be recorded for any error
> response to provide context to the failure.
> 
> QMP normal responses are skipped since the data can be volumous
> and thus result in poor signal/noise ratio.
> 
> The QMP commands are never captured to a string buffer as input
> is streamed into the JSON parser and the result is spat out as
> a QObject. Thus, the commands need to be formatted back into JSON
> string format for the data recorder. This is a mild but acceptable
> performance overhead, in the overall context of handling a QMP
> command.
> 
> The QMP events are captured immediately before they are written
> back on the wire where already in string format.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  monitor/qmp.c | 67 +++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 59 insertions(+), 8 deletions(-)
> 
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index ccb39a48d4c..659ad23d832 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -34,6 +34,7 @@
>  #include "qobject/qjson.h"
>  #include "qobject/qlist.h"
>  #include "qom/object_interfaces.h"
> +#include "qemu/tldr.h"
>  #include "trace.h"
>  
>  /*
> @@ -80,7 +81,8 @@ static MonitorQMP *qmp_dispatcher_current_mon;
>  OBJECT_DEFINE_TYPE(MonitorQMP, monitor_qmp, MONITOR_QMP, MONITOR);
>  
>  static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon);
> -static void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
> +static void qmp_send_response(MonitorQMP *mon, const QDict *rsp,
> +                              const QObject *ctx);
>  
>  static void monitor_qmp_finalize(Object *obj)
>  {
> @@ -169,7 +171,7 @@ static void monitor_qmp_emit_event(Monitor *mon, QAPIEvent event, QDict *qdict)
>          }
>      }
>  
> -    qmp_send_response(qmp, qdict);
> +    qmp_send_response(qmp, qdict, NULL);
>  }
>  
>  static bool monitor_qmp_requires_iothread(const Monitor *mon)
> @@ -243,7 +245,8 @@ static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *mon)
>  
>  }
>  
> -static void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
> +static void qmp_send_response(MonitorQMP *mon, const QDict *rsp,
> +                              const QObject *ctx)
>  {
>      const QObject *data = QOBJECT(rsp);
>      GString *json;
> @@ -252,6 +255,30 @@ static void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
>      assert(json != NULL);
>      trace_monitor_qmp_respond(mon, json->str);
>  
> +    /*
> +     * Errors are always useful to record. We recorded the
> +     * command in the caller in many cases, but if not, then
> +     * 'ctx' will be non-NULL and we should record it now
> +     * for context.
> +     */
> +    if (qtldr_msg_enabled(QTLDR_MSG_BUCKET_TYPE_COMMAND) &&
> +        qdict_haskey(rsp, "error")) {
> +        if (ctx) {
> +            g_autoptr(GString) ctxstr = qobject_to_json(ctx);
> +            qtldr_msg_record(QTLDR_MSG_BUCKET_TYPE_COMMAND, ctxstr->str);
> +        }
> +        qtldr_msg_record(QTLDR_MSG_BUCKET_TYPE_COMMAND, json->str);
> +    }
> +
> +    /*
> +     * Capture events, since they represent changes
> +     * in state or behaviour
> +     */
> +    if (qtldr_msg_enabled(QTLDR_MSG_BUCKET_TYPE_EVENT) &&
> +        qdict_haskey(rsp, "event")) {
> +        qtldr_msg_record(QTLDR_MSG_BUCKET_TYPE_EVENT, json->str);
> +    }
> +
>      g_string_append_c(json, '\n');
>      monitor_puts(&mon->parent_obj, json->str);
>  
> @@ -263,10 +290,10 @@ static void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
>   * Null @rsp can only happen for commands with QCO_NO_SUCCESS_RESP.
>   * Nothing is emitted then.
>   */
> -static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
> +static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp, QObject *ctx)
>  {
>      if (rsp) {
> -        qmp_send_response(mon, rsp);
> +        qmp_send_response(mon, rsp, ctx);
>      }
>  }
>  
> @@ -276,9 +303,33 @@ static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
>   */
>  static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
>  {
> +    QObject *ctx = req;
>      QDict *rsp;
>      QDict *error;
>  
> +    /*
> +     * Capture commands which are liable to change state,
> +     * i.e. exclude purely information query comamnds
> +     */
> +    if (qtldr_msg_enabled(QTLDR_MSG_BUCKET_TYPE_COMMAND)) {
> +        QDict *cmd = qobject_to(QDict, req);
> +        if (cmd != NULL) {
> +            const char *cmdname = qdict_get_try_str(cmd, "execute")
> +                ?: qdict_get_try_str(cmd, "exec-oob");
> +            if (cmdname != NULL &&
> +                !g_str_has_prefix(cmdname, "query-") &&
> +                !g_str_has_prefix(cmdname, "qom-list")) {
> +                g_autoptr(GString) cmdstr = qobject_to_json(req);
> +                qtldr_msg_record(QTLDR_MSG_BUCKET_TYPE_COMMAND, cmdstr->str);
> +                /*
> +                 * Prevent recording cmd twice if the later response
> +                 * is an error
> +                 */
> +                ctx = NULL;
> +            }
> +        }
> +    }
> +
>      rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon),
>                         &mon->parent_obj);
>  
> @@ -294,7 +345,7 @@ static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
>          }
>      }
>  
> -    monitor_qmp_respond(mon, rsp);
> +    monitor_qmp_respond(mon, rsp, ctx);
>      qobject_unref(rsp);
>  }
>  
> @@ -455,7 +506,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
>              trace_monitor_qmp_err_in_band(error_get_pretty(req_obj->err));
>              rsp = qmp_error_response(req_obj->err);
>              req_obj->err = NULL;
> -            monitor_qmp_respond(mon, rsp);
> +            monitor_qmp_respond(mon, rsp, NULL);
>              qobject_unref(rsp);
>          }
>  
> @@ -623,7 +674,7 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
>              monitor_qmp_caps_reset(mon);
>          }
>          data = qmp_greeting(mon);
> -        qmp_send_response(mon, data);
> +        qmp_send_response(mon, data, NULL);
>          qobject_unref(data);
>          break;
>      case CHR_EVENT_CLOSED:
> -- 
> 2.56.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

