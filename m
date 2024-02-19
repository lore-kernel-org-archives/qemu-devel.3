Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EBCC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Lo-0007SL-Ao; Mon, 19 Feb 2024 09:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc4Lk-0007Pv-B2
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:10:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc4Li-0007jp-Cf
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708351825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J789yVKcCYi/vQUrSEU1vQVQ5QYWBek3OG0+SnQ6aVk=;
 b=NkZxBUb4ynMGyTNcxis1Z5dobX9emhh7YEr0rYOgTP5SJprE/TyduGXBPy7H/0oO4dPSan
 9YPudAlYN7l5lE3kRoJfxdGN5/IERM03j46TGFldoBGhdFRiWNYFseL4sEHhdXEIZ24f1N
 M76R3CAy3kaXAU9rTzaaQaIXOjwc0sY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-QvqphAVFMHK3oMxn441ZwA-1; Mon,
 19 Feb 2024 09:10:19 -0500
X-MC-Unique: QvqphAVFMHK3oMxn441ZwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC6AE3CBD508;
 Mon, 19 Feb 2024 14:10:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F40F2C185C0;
 Mon, 19 Feb 2024 14:10:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B6FC821E66D0; Mon, 19 Feb 2024 15:10:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  eduardo@habkost.net,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 jsnow@redhat.com,  eblake@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  alxndr@bu.edu,  vsementsov@yandex-team.ru,
 alexander.ivanov@virtuozzo.com,  den@virtuozzo.com,
 michael.labiuk@virtuozzo.com
Subject: Re: [PATCH v8 2/4] qmp: add dump machine type compatibility properties
In-Reply-To: <20240125115610.23697-3-davydov-max@yandex-team.ru> (Maksim
 Davydov's message of "Thu, 25 Jan 2024 14:56:08 +0300")
References: <20240125115610.23697-1-davydov-max@yandex-team.ru>
 <20240125115610.23697-3-davydov-max@yandex-team.ru>
Date: Mon, 19 Feb 2024 15:10:14 +0100
Message-ID: <874je4lf3t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Maksim Davydov <davydov-max@yandex-team.ru> writes:

> To control that creating new machine type doesn't affect the previous
> types (their compat_props) and to check complex compat_props inheritance
> we need qmp command to print machine type compatibility properties.
> This patch adds the ability to get list of all the compat_props of the
> corresponding supported machines for their comparison via new optional
> argument of "query-machines" command.

Rationale for the argument, please.  You actually provided it during
review of v6: the additional output is hundreds of KiB.  I then asked
you to explain this briefly in the commit message, with suggested text:
"Since information on compatibility properties can increase the command
output by a factor of 40, add an argument to enable it, default off."

I still wonder whether a separate command would be better than
complicating query-machines.

> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/core/machine-qmp-cmds.c  | 23 ++++++++++++-
>  qapi/machine.json           | 64 +++++++++++++++++++++++++++++++++++--
>  tests/qtest/fuzz/qos_fuzz.c |  2 +-
>  3 files changed, 85 insertions(+), 4 deletions(-)
>
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index 3860a50c3b..a49d0dc362 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -66,7 +66,8 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
>      return head;
>  }
>  
> -MachineInfoList *qmp_query_machines(Error **errp)
> +MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
> +                                    Error **errp)
>  {
>      GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
>      MachineInfoList *mach_list = NULL;
> @@ -98,6 +99,26 @@ MachineInfoList *qmp_query_machines(Error **errp)
>              info->default_ram_id = g_strdup(mc->default_ram_id);
>          }
>  
> +        if (compat_props && mc->compat_props) {
> +            int i;
> +            info->compat_props = NULL;
> +            CompatPropertyList **tail = &(info->compat_props);
> +            info->has_compat_props = true;
> +
> +            for (i = 0; i < mc->compat_props->len; i++) {
> +                GlobalProperty *mt_prop = g_ptr_array_index(mc->compat_props,
> +                                                            i);
> +                CompatProperty *prop;
> +
> +                prop = g_malloc0(sizeof(*prop));
> +                prop->driver = g_strdup(mt_prop->driver);
> +                prop->property = g_strdup(mt_prop->property);
> +                prop->value = g_strdup(mt_prop->value);
> +
> +                QAPI_LIST_APPEND(tail, prop);
> +            }
> +        }
> +
>          QAPI_LIST_PREPEND(mach_list, info);
>      }
>  
> diff --git a/qapi/machine.json b/qapi/machine.json
> index b6d634b30d..15a1d62f42 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -135,6 +135,29 @@
>  ##
>  { 'command': 'query-cpus-fast', 'returns': [ 'CpuInfoFast' ] }
>  
> +##
> +# @CompatProperty:
> +#
> +# Machine type compatibility property that uses in machine
> +# definitions to specify default values.  It's based on representaion
> +# of properties in QEMU and created for machine type comparing
> +# (see scripts/compare-machine-types.py)

Suggest

   # Property default values specific to a machine type, for use by
   # scripts/compare-machine-types.

> +#
> +# @driver: name of the driver which default value of certain property
> +#     is changed in the machine type

Let's name this @qom-type.  Yes, I know it's called @driver in struct
GlobalProperty, but it has become a QOM type name.  Since object-add
calls it qom-type, so should query-machines.

> +#
> +# @property: property name
> +#
> +# @value: property value that will be assigned as default to
> +#     the driver by machine type

Suggest

   # @qom-type: name of the QOM type to which the default applies
   #
   # @property: name of its property to which the default applies
   #
   # @value: the default value

This is still rather terse.  For instance, it doesn't explain that
machine-specific defaults override the "default" default, and how to
query that "default" default.  It'll do for an experimental interface.

> +#
> +# Since: 9.0
> +##
> +{ 'struct': 'CompatProperty',
> +  'data': { 'driver': 'str',
> +            'property': 'str',
> +            'value': 'str' } }
> +
>  ##
>  # @MachineInfo:
>  #
> @@ -166,6 +189,13 @@
>  #
>  # @acpi: machine type supports ACPI (since 8.0)
>  #
> +# @compat-props: List of the machine type's compatibility properties.
> +#     (since 9.0)

Let's scratch "List of".

Must tell when the member is present.

Taken together:

   # @compat-props: The machine type's compatibility properties.  Only
   #     present when query-machines argument @compat-props is true.
   #     (since 9.0)

> +#
> +# Features:
> +#
> +# @unstable: Member @compat-props is experimental.
> +#
>  # Since: 1.2
>  ##
>  { 'struct': 'MachineInfo',
> @@ -173,18 +203,48 @@
>              '*is-default': 'bool', 'cpu-max': 'int',
>              'hotpluggable-cpus': 'bool',  'numa-mem-supported': 'bool',
>              'deprecated': 'bool', '*default-cpu-type': 'str',
> -            '*default-ram-id': 'str', 'acpi': 'bool' } }
> +            '*default-ram-id': 'str', 'acpi': 'bool',
> +            '*compat-props': { 'type': ['CompatProperty'],
> +                               'features': ['unstable'] } } }
>  
>  ##
>  # @query-machines:
>  #
>  # Return a list of supported machines
>  #
> +# @compat-props: if true return will contain information about
> +#     machine type compatibility properties (since 9.0)

Missing: (default false)

Perhaps

   # @compat-props: if true, also return compatibility properties.
   #     (default false)

> +#
>  # Returns: a list of MachineInfo
>  #
>  # Since: 1.2
> +#
> +# Example:
> +#
> +# -> { "execute": "query-machines", "arguments": { "compat-props": true } }
> +# <- { "return": [
> +#          {
> +#              "hotpluggable-cpus": true,
> +#              "name": "pc-q35-6.2",
> +#              "compat-props": [
> +#                  {
> +#                      "driver": "virtio-mem",
> +#                      "property": "unplugged-inaccessible",
> +#                      "value": "off"
> +#                   }
> +#               ],
> +#               "numa-mem-supported": false,
> +#               "default-cpu-type": "qemu64-x86_64-cpu",
> +#               "cpu-max": 288,
> +#               "deprecated": false,
> +#               "default-ram-id": "pc.ram"
> +#           },
> +#           ...
> +#    }
>  ##
> -{ 'command': 'query-machines', 'returns': ['MachineInfo'] }
> +{ 'command': 'query-machines',
> +  'data': { '*compat-props': 'bool' },

Make that

     'data': { '*compat-props': { 'type': 'bool',
                                  'features': [ 'unstable' ] } },

and add

   # Features:
   #
   # @unstable: Argument @compat-props is experimental.
   #

to the doc comment.

> +  'returns': ['MachineInfo'] }
>  
>  ##
>  # @CurrentMachineParams:
> diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
> index e403d373a0..b71e945c5f 100644
> --- a/tests/qtest/fuzz/qos_fuzz.c
> +++ b/tests/qtest/fuzz/qos_fuzz.c
> @@ -46,7 +46,7 @@ static void qos_set_machines_devices_available(void)
>      MachineInfoList *mach_info;
>      ObjectTypeInfoList *type_info;
>  
> -    mach_info = qmp_query_machines(&error_abort);
> +    mach_info = qmp_query_machines(false, false, &error_abort);
>      machines_apply_to_node(mach_info);
>      qapi_free_MachineInfoList(mach_info);


