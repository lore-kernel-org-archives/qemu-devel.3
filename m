Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F52BCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 20:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcUVn-0000nR-Jj; Wed, 24 Jun 2026 16:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcUVj-0000n3-O6
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 16:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcUVh-0007pe-9b
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 16:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782334067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wlF2FAE63fjCpxbQDu1lhcuNq54SWZdqx5MLerXQXQI=;
 b=ciiw7+RYlGzGBfKPzhtNk0thWx9m6zhEP0XGKaR/lCdr3zpsANXrHS85hA4UeG8Z0xnvDH
 PNpVHdAJ5lgPQPvD1n79qWtWXBjILSWtgvHccsJyYW563xj9NJL2gZXE6DUsHHb4ru0395
 OEIES2dmqX1YFKj6eB5qeJKu4HCDqeA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-bHidcB2eOEqP7rIhp6w-GA-1; Wed,
 24 Jun 2026 16:47:43 -0400
X-MC-Unique: bHidcB2eOEqP7rIhp6w-GA-1
X-Mimecast-MFC-AGG-ID: bHidcB2eOEqP7rIhp6w-GA_1782334061
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05E9418052CE; Wed, 24 Jun 2026 20:47:41 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10CF01956041; Wed, 24 Jun 2026 20:47:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 32/35] monitor: add support for auto-deleting
 monitors upon close
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Krempa <pkrempa@redhat.com>
In-Reply-To: <20260624173752.2928717-33-berrange@redhat.com>
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-33-berrange@redhat.com>
Date: Thu, 25 Jun 2026 00:47:30 +0400
Message-Id: <178233405051.3955748.10990724544083287885.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=12943;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9njed6RM8Uge1MKbnhLnFSUQa0J3dgCgL6FZYg2eHMw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPEJmPlQ3qrrCW4wEmf3A0Y/M+kteXd0rhYOss
 zLeL4qSGb2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajxCZgAKCRDa6OEJdZac
 5crFD/49ye1gAALlI64tboTELFWEbCTsceXnvldRtg5lV0w3lsqO1bawW5YDACK7PHdX+omn8oB
 qg8SYAOTjriscPskHyqYitypuFSAARYcoy7Zg4INU/br3yUGhjaINMDfUNSCP98f1Bhe28I+gWE
 Vi5vQvwXc98gS04TXbLXY8StRdSf1gDg14j5+OjRXp/17azIqkcbCLqdRA8Q7ce5saw2jboEMWL
 5JDTRJXmXmTHxLEmjpjAB6bbydvBFqNRZkZof6FkA9tbFgG6Ru7nO8Fbc+lPYpigmqKWl0JhBAg
 cqAIQvYsrUDUX/hjBvkH6w3yULLmhMG/GvSTlk5geTUJ7pAXiqPGIAQ0An+m3sap/IIkjNdRZTi
 eGGorlURcnAo+Ut5p/8XtQrbDg8LW4MluHuXhTgF+3KkSRONN9ZTV1+Qr7i4nLjII9annc2BgmB
 tLdEXLUCiOUbbY2dwsbgH4FjJenC/G7U7jByq3jFlbbXaCbAbLyBYzlzMRZEcAt5yM3jmaBZW6i
 amC4M7RFsbXVeqx7iDP49FX6pGUalp8KCbO7Pad5lB72qGskyXhsANLIrYJK6Hc9t+DVNMiNL2F
 c69aNNLmmumCrRGz4f5hjzETCxTJ4+LhiyO3yRMbVz9LCTOTDOH5tNsIh6ogsaPB5OUzJmEaAId
 HAGgsJcqXp2hgBA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Tested-by: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20260624173752.2928717-33-berrange@redhat.com>
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 6affb70a594..b4c49a2e8b9 100644
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

should be "Since: 11.1" (worth a new check perhaps)

> +##
> +{ 'enum' : 'MonitorQMPCloseAction',

extra space, vs the usual '{ 'enum':'.

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
> index 5301927f09f..1057b0d12ba 100644
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
> @@ -550,11 +570,45 @@ static QDict *qmp_greeting(MonitorQMP *mon)
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
> +    if (!mon_id) {
> +        /* Another monitor raced & ran 'object-del' on 'mon'
> +         * before this BH got scheduled, so we have a ref on
> +         * mon but it is already unparented.
> +         */
> +        object_unref(mon);
> +        return;
> +    }
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
> @@ -577,6 +631,27 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
>          json_message_parser_init(&mon->parser, handle_qmp_command,
>                                   mon, NULL);
>          monitor_fdsets_cleanup();
> +        switch (mon->close_action) {
> +        case MONITOR_QMP_CLOSE_ACTION_NONE:
> +            break; /* nada */
> +        case MONITOR_QMP_CLOSE_ACTION_DELETE:
> +            mon->delete_pending = true;
> +            /*
> +             * Do NOT run in the AIO context associated with the
> +             * monitor. We need to run in the default AIO context
> +             * which is the same context in which 'qmp_object_del'
> +             * will execute
> +             *
> +             * Hold an extra ref in case a separate monitor races
> +             * with the BH by processing an explicit 'object-del'
> +             */
> +            object_ref(mon);
> +            aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                    monitor_qmp_self_delete_bh, mon);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
>          break;
>      case CHR_EVENT_BREAK:
>      case CHR_EVENT_MUX_IN:
> diff --git a/tests/functional/generic/test_monitor_hotplug.py b/tests/functional/generic/test_monitor_hotplug.py
> index 55af8a238f9..86092e781c9 100755
> --- a/tests/functional/generic/test_monitor_hotplug.py
> +++ b/tests/functional/generic/test_monitor_hotplug.py
> @@ -25,7 +25,7 @@ def setUp(self):
>          sock_dir = self.socket_dir()
>          self._sock_path = os.path.join(sock_dir.name, 'hotplug.sock')
>  
> -    def _add_monitor(self):
> +    def _add_monitor(self, autodelete=False):
>          """Create a chardev + monitor and return the socket path."""
>          sock = self._sock_path
>          self.vm.cmd('chardev-add', id='hotplug-chr', backend={
> @@ -39,9 +39,15 @@ def _add_monitor(self):
>                  'wait': False,
>              }
>          })
> -        self.vm.cmd('object-add', id='hotplug-mon',
> -                    qom_type='monitor-qmp',
> -                    chardev='hotplug-chr')
> +        if autodelete:
> +            self.vm.cmd('object-add', id='hotplug-mon',
> +                        qom_type='monitor-qmp',
> +                        chardev='hotplug-chr',
> +                        close_action='delete')
> +        else:
> +            self.vm.cmd('object-add', id='hotplug-mon',
> +                        qom_type='monitor-qmp',
> +                        chardev='hotplug-chr')
>          return sock
>  
>      def _remove_monitor(self):
> @@ -118,6 +124,75 @@ def test_self_removal(self):
>          # Clean up the chardev
>          self.vm.cmd('chardev-remove', id='hotplug-chr')
>  
> +    def test_auto_delete(self):
> +        """
> +        A dynamically-added monitor configured with 'close-action=delete'
> +        should see itself deleted when the client is closed.
> +        """
> +        self.set_machine('none')
> +        self.vm.add_args('-nodefaults')
> +        self.vm.launch()
> +
> +        sock = self._add_monitor(autodelete=True)
> +
> +        cdevs = [c["label"] for c in self.vm.cmd('query-chardev')]
> +        objs = [o["name"] for o in self.vm.cmd('qom-list', path='/objects')]
> +        assert ('hotplug-chr' in cdevs)
> +        assert ('hotplug-mon' in objs)
> +
> +        qmp = QEMUMonitorProtocol(sock)
> +        greeting = qmp.connect(negotiate=True)
> +        self.assertIn('QMP', greeting)
> +
> +        cdevs = [c["label"] for c in self.vm.cmd('query-chardev')]
> +        objs = [o["name"] for o in self.vm.cmd('qom-list', path='/objects')]
> +        assert ('hotplug-chr' in cdevs)
> +        assert ('hotplug-mon' in objs)
> +
> +        qmp.close()
> +
> +        # Wait upto 10 seconds max for chardev to auto-delete, which
> +        # is hopefully enough for reliability under high load
> +        for i in range(int(10 / 0.2)):
> +            cdevs = [c["label"] for c in self.vm.cmd('query-chardev')]
> +            if 'hotplug-chr' not in cdevs:
> +                break
> +            # Wait a little more then try again
> +            time.sleep(0.2)
> +
> +        cdevs = [c["label"] for c in self.vm.cmd('query-chardev')]
> +        objs = [o["name"] for o in self.vm.cmd('qom-list', path='/objects')]
> +        assert ('hotplug-chr' not in cdevs)
> +        assert ('hotplug-mon' not in objs)
> +
> +    def test_reconnect(self):
> +        """
> +        A dynamically-added monitor configured without 'close-action'
> +        should allow reconnects after the client is closed.
> +        """
> +        self.set_machine('none')
> +        self.vm.add_args('-nodefaults')
> +        self.vm.launch()
> +
> +        sock = self._add_monitor()
> +
> +        qmp = QEMUMonitorProtocol(sock)
> +        qmp.connect(negotiate=True)
> +
> +        resp = qmp.cmd_obj({'execute': 'query-chardev'})
> +        self.assertIn('return', resp)
> +
> +        qmp.close()
> +
> +        qmp = QEMUMonitorProtocol(sock)
> +        qmp.connect(negotiate=True)
> +
> +        resp = qmp.cmd_obj({'execute': 'query-chardev'})
> +        self.assertIn('return', resp)
> +
> +        qmp.close()
> +        self._remove_monitor()
> +
>      def test_large_response(self):
>          """
>          Send a command with a large response (query-qmp-schema) on a

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


