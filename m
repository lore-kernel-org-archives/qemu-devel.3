Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EE9CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbzhi-0002Mz-2J; Tue, 23 Jun 2026 07:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbzhh-0002Mr-7r
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbzhf-0004Ny-Cx
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782215646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i3iyhtyI+LYda5p0ZwKJvIBQilZkxH9ydnh9GZQ2pvg=;
 b=beiaoNKqqJlhRuAWmcUx3zkNrYIU6y1meQikTaLZh56Pxf/BImwvRFr0Gwuw3yljM9gtpc
 mzMlmpitUTU6XEHK59jedsFbgVBABoU7s6ZwXHTRQr2vSzlsIJ/AJTwWju8IMrc3Z2a0A4
 X23W5H8p8yam7kPriYSg0HFAHp3wIBc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-YD-R0mZPOwiN0mEUUBKIQg-1; Tue,
 23 Jun 2026 07:54:03 -0400
X-MC-Unique: YD-R0mZPOwiN0mEUUBKIQg-1
X-Mimecast-MFC-AGG-ID: YD-R0mZPOwiN0mEUUBKIQg_1782215642
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EF4B1955E90; Tue, 23 Jun 2026 11:54:01 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B13881800591; Tue, 23 Jun 2026 11:53:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 32/35] monitor: add support for auto-deleting
 monitors upon close
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
In-Reply-To: <20260623095551.2106712-33-berrange@redhat.com>
References: <20260623095551.2106712-1-berrange@redhat.com>
 <20260623095551.2106712-33-berrange@redhat.com>
Date: Tue, 23 Jun 2026 15:53:37 +0400
Message-Id: <178221561777.3416386.3900546214136378913.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8324;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=08JLV29yZoc5XTmpFr8xVJboGLTkN8J4DUsfGO8sj24=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOnPEVPd1QoIPISvB4OopOMUOfEWv7CjlSZS9Q
 mSKpiiNkaGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajpzxAAKCRDa6OEJdZac
 5YkcD/0bzE3u8loNFbDXvmXC/LdSyKQJT2KDuAGim2pHEcJt7ezPjEmiPChfsPRlGcHIZE8B9pJ
 5qrOnkpXDNuKnI+//7rZjwh8RtilGZxPeuUwKa16mU/AJuCWjMQAj/BlgnjsbUbE3ETM59UGbfA
 gi+Rtu72is0k0VM4cgO1h/lbP6ptHzO/gwxDNb016CxjeDsWYxdvzAQzih5u8x/v4IwGMumUfgr
 37WHZXI4poL5UtHoR3uPrCobvYQ/gN/Nlc8r4YK298rrdKqesyanSttZTgjinOXEKVgsUzeASyu
 gQCGgpmBgSzONmMQepe/OYzRpzrpUP5EuaD4eJZJD+vT8b/jOO4cvbIFdx3PGU9QvEL/y9Sk5hT
 K8cQFq6T95ig9eC/z7tJuvzWdrW9IB8SXKXuGU0IsDE8a6PC6YDnXThqbR0PTPgklja9umOWlC+
 iykNtNj3yBEp89FbAntI4sJrHGbiWJKQXOa4f0v0TPn9VkgmXDpUPkVKHFbwTqg7ADIdnHyMEDM
 cqamFZ2LdxZ1SrMyA7iowf1B545E6KWhFO0wZ053xu+LDu4+DP1Vmw7658s3d1MT2XXPnbYE/VT
 eJ7Q4x6Xhk0AQzRpYaaQWIZDcCh0UWwwsh3ZWY0SkDmlzPTHlWK6uF4g8ihitt3YQBMcv9DoeK2
 kHFMgDbi4zMubOA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

> The default monitor is usually a long lived object that will exist for
> the entire lifetime of the VM. A monitor can only service a single
> client at a time though, and so it might be desirable to hotplug
> additional monitors at runtime for specific tasks. If doing that,
> however, there is a need to remove the monitor when it is no longer
> needed.
> 
> Allowing a client to run "object-del" against its own monitor adds
> complex edge cases, as it would be desirable to send the QMP response
> despite the monitor sending it being deleted. Doing "object-del" alone
> will also result in orphaning a character device backend instance, as
> there is no opportunity to run the companion "chardev-del" command.
> 
> A simpler way to ensure cleanup is to add the concept of auto-deleting
> monitor objects. Specifically when the "CHR_EVENT_CLOSED" event is
> emitted, the equivalent of "object-del" + "chardev-del" can be run
> internally. Since the transient client has already droppped its
> monitor connection, there is no synchronization to be concerned about.
> 
> This is implemented via a new "close-action=none|delete" property on
> the 'monitor-qmp' object. This concept could be extended with further
> actions in future, for example:
> 
>  * close-action=shutdown - graceful guest shutdown
>  * close-action=terminate - immediate guest poweroff
>  * close-action=stop - pause guest CPUs while the monitor is not
>                        connected to any client
> 
> This is left as an exercise for future interested contributors.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20260623095551.2106712-33-berrange@redhat.com>
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 6ed510858e1..63335b8fd09 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1213,18 +1213,37 @@
>    'base': 'MonitorProperties',
>    'data': { '*readline': 'bool' } }
>  
> +
> +##
> +# @MonitorQMPCloseAction:
> +#
> +# Action to take when the character device backend is
> +# closed.
> +#
> +# @none: take no action (the default)
> +# @delete: delete both the 'monitor-qmp' object and its associated
> +#          character device backend object
> +#
> +# Since 11.1
> +##
> +{ 'enum' : 'MonitorQMPCloseAction',
> +  'data': ['none', 'delete'] }
> +
>  ##
>  # @MonitorQMPProperties:
>  #
>  # Properties for the QMP monitor
>  #
>  # @pretty: whether to pretty print JSON responses (default: disabled)
> +# @close-action: action to take when the character device backend
> +#                is closed (default: none)
>  #
>  # Since: 11.1
>  ##
>  { 'struct': 'MonitorQMPProperties',
>    'base': 'MonitorProperties',
> -  'data': { '*pretty': 'bool' } }
> +  'data': { '*pretty': 'bool',
> +            '*close-action': 'MonitorQMPCloseAction' } }
>  
>  ##
>  # @ObjectType:
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 5522e05464b..23829f32f9a 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -28,6 +28,7 @@
>  #include "chardev/char-fe.h"
>  #include "monitor/monitor.h"
>  #include "qapi/qapi-types-control.h"
> +#include "qapi/qapi-types-qom.h"
>  #include "qapi/qmp-registry.h"
>  #include "qobject/json-parser.h"
>  #include "qemu/readline.h"
> @@ -178,7 +179,9 @@ struct MonitorQMP {
>      Monitor parent_obj;
>      JSONMessageParser parser;
>      bool pretty;
> +    MonitorQMPCloseAction close_action;
>      bool setup_pending; /* iothread BH has not yet set up chardev handlers */
> +    bool delete_pending; /* close_action has started 'delete' process */
>      /*
>       * When a client connects, we're in capabilities negotiation mode.
>       * @commands is &qmp_cap_negotiation_commands then.  When command
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 5301927f09f..f6b7fe65bbf 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -28,6 +28,7 @@
>  #include "monitor-internal.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-control.h"
> +#include "qapi/qapi-commands-char.h"
>  #include "qobject/qdict.h"
>  #include "qobject/qjson.h"
>  #include "qobject/qlist.h"
> @@ -103,6 +104,20 @@ static void monitor_qmp_set_pretty(Object *obj, bool val, Error **errp)
>      mon->pretty = val;
>  }
>  
> +static int monitor_qmp_get_close_action(Object *obj, Error **errp)
> +{
> +    MonitorQMP *mon = MONITOR_QMP(obj);
> +
> +    return mon->close_action;
> +}
> +
> +static void monitor_qmp_set_close_action(Object *obj, int val, Error **errp)
> +{
> +    MonitorQMP *mon = MONITOR_QMP(obj);
> +
> +    mon->close_action = val;
> +}
> +
>  static void monitor_qmp_emit_event(Monitor *mon, QAPIEvent event, QDict *qdict);
>  static bool monitor_qmp_requires_iothread(const Monitor *mon);
>  static void monitor_qmp_complete(UserCreatable *uc, Error **errp);
> @@ -117,6 +132,11 @@ static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
>      object_class_property_add_bool(cls, "pretty",
>                                     monitor_qmp_get_pretty,
>                                     monitor_qmp_set_pretty);
> +    object_class_property_add_enum(cls, "close-action",
> +                                   "MonitorQMPCloseAction",
> +                                   &MonitorQMPCloseAction_lookup,
> +                                   monitor_qmp_get_close_action,
> +                                   monitor_qmp_set_close_action);
>  
>      moncls->emit_event = monitor_qmp_emit_event;
>      moncls->requires_iothread = monitor_qmp_requires_iothread;
> @@ -550,11 +570,38 @@ static QDict *qmp_greeting(MonitorQMP *mon)
>          ver, cap_list);
>  }
>  
> +static void monitor_qmp_self_delete_bh(void *opaque)
> +{
> +    MonitorQMP *mon = opaque;
> +    g_autofree char *mon_id = object_property_get_child_name(
> +        object_get_objects_root(), OBJECT(mon));
> +    g_autofree char *chardev_id = g_strdup(mon->parent_obj.chardev_id);
> +    Error *local_error = NULL;
> +
> +    g_assert(mon_id);

If object-del beats this BH, mon_id might be NULL. Return silently?

> +
> +    user_creatable_del(mon_id, &local_error);
> +    object_unref(mon);
> +    if (local_error != NULL) {
> +        error_report_err(local_error);
> +    } else {
> +        qmp_chardev_remove(chardev_id, NULL);
> +    }
> +}
> +
>  static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
>  {
>      QDict *data;
>      MonitorQMP *mon = opaque;
>  
> +    /* Protect against race if a client drops & quickly
> +     * reconnects - we'll have the delete BH scheduled
> +     * so must not honour a new open request
> +     */
> +    if (mon->delete_pending) {
> +        return;
> +    }
> +
>      switch (event) {
>      case CHR_EVENT_OPENED:
>          WITH_QEMU_LOCK_GUARD(&mon->parent_obj.mon_lock) {
> @@ -566,6 +613,7 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
>          qobject_unref(data);
>          break;
>      case CHR_EVENT_CLOSED:
> +        mon->delete_pending = true;

Shouldn't it be set in the MONITOR_QMP_CLOSE_ACTION_DELETE case only?

>          /*
>           * Note: this is only useful when the output of the chardev
>           * backend is still open.  For example, when the backend is
> @@ -577,6 +625,26 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
>          json_message_parser_init(&mon->parser, handle_qmp_command,
>                                   mon, NULL);
>          monitor_fdsets_cleanup();
> +        switch (mon->close_action) {
> +        case MONITOR_QMP_CLOSE_ACTION_NONE:
> +            break; /* nada */
> +        case MONITOR_QMP_CLOSE_ACTION_DELETE:
> +            /*
> +             * Do NOT run in the AIO context associated with the
> +             * monitor. We need to run in the default AIO context
> +             * which is the same context in which 'qmp_object_del'
> +             * will execute
> +             *
> +             * Hold an extra ref in case a separate monitor races
> +             * with the BH by processing an expliciti 'object-del'

"expliciti" -> "explicit"

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


