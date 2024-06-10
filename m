Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703B2C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 09:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGav7-0004rk-Dw; Mon, 10 Jun 2024 05:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGav6-0004rM-56
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 05:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGav3-0008Ec-U1
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 05:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718010144;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+JSYGuRegmpqCz+HnfRypcib4fJGwvRzVYUqZwPq2/c=;
 b=HVchO1Qpgs8xjQ0Xc/W7KhKSMxD8hSCgkVlcJ98nWzuIUHgtXl5U8KSiEf622IjDGlvQhG
 DpTd+AJuCQGPIVVkQtgrCcsD5FCNwG/iRO1tm3CfAOMAztgSb+sYAG7Mxl9BkhMOKVUCWl
 81EM00m7QHUQhuxmyOlUiLvZC/xIZv0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-RaRHkI_HMnSRA9NKLlj7xQ-1; Mon, 10 Jun 2024 05:02:22 -0400
X-MC-Unique: RaRHkI_HMnSRA9NKLlj7xQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 304F6101A528
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 09:02:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 146D4C158D4;
 Mon, 10 Jun 2024 09:02:16 +0000 (UTC)
Date: Mon, 10 Jun 2024 10:02:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] tests/qtest/libqtest: add qtest_has_cpu() api
Message-ID: <ZmbBElz4clEuZ1zp@redhat.com>
References: <20240606044419.8806-1-anisinha@redhat.com>
 <20240606044419.8806-3-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240606044419.8806-3-anisinha@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 06, 2024 at 10:14:18AM +0530, Ani Sinha wrote:
> Added a new test api qtest_has_cpu() in order to check availability of some
> cpu models in the current QEMU binary. The specific architecture of the QEMU
> binary is selected using the QTEST_QEMU_BINARY environment variable. This api
> would be useful to run tests against some older cpu models after checking if
> QEMU actually supported these models.
> 
> CC: thuth@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/qtest/libqtest.c | 84 ++++++++++++++++++++++++++++++++++++++++++
>  tests/qtest/libqtest.h |  8 ++++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index d8f80d335e..135a607728 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -37,6 +37,7 @@
>  #include "qapi/qmp/qjson.h"
>  #include "qapi/qmp/qlist.h"
>  #include "qapi/qmp/qstring.h"
> +#include "qapi/qmp/qbool.h"
>  
>  #define MAX_IRQ 256
>  
> @@ -1471,6 +1472,12 @@ struct MachInfo {
>      char *alias;
>  };
>  
> +struct CpuInfo {
> +    char *name;
> +    char *alias_of;
> +    bool deprecated;
> +};
> +
>  static void qtest_free_machine_list(struct MachInfo *machines)
>  {
>      if (machines) {
> @@ -1550,6 +1557,83 @@ static struct MachInfo *qtest_get_machines(const char *var)
>      return machines;
>  }
>  
> +static struct CpuInfo *qtest_get_cpus(void)
> +{
> +    static struct CpuInfo *cpus;
> +    QDict *response, *minfo;
> +    QList *list;
> +    const QListEntry *p;
> +    QObject *qobj;
> +    QString *qstr;
> +    QBool *qbool;
> +    QTestState *qts;
> +    int idx;
> +
> +    if (cpus) {
> +        return cpus;
> +    }
> +
> +    silence_spawn_log = !g_test_verbose();
> +
> +    qts = qtest_init_with_env(NULL, "-machine none");
> +    response = qtest_qmp(qts, "{ 'execute': 'query-cpu-definitions' }");
> +    g_assert(response);
> +    list = qdict_get_qlist(response, "return");
> +    g_assert(list);
> +
> +    cpus = g_new(struct CpuInfo, qlist_size(list) + 1);

Just use g_new0 here.

> +
> +    for (p = qlist_first(list), idx = 0; p; p = qlist_next(p), idx++) {
> +        minfo = qobject_to(QDict, qlist_entry_obj(p));
> +        g_assert(minfo);
> +
> +        qobj = qdict_get(minfo, "name");
> +        g_assert(qobj);
> +        qstr = qobject_to(QString, qobj);
> +        g_assert(qstr);
> +        cpus[idx].name = g_strdup(qstring_get_str(qstr));
> +
> +        qobj = qdict_get(minfo, "alias_of");
> +        if (qobj) { /* old machines do not report aliases */
> +            qstr = qobject_to(QString, qobj);
> +            g_assert(qstr);
> +            cpus[idx].alias_of = g_strdup(qstring_get_str(qstr));
> +        } else {
> +            cpus[idx].alias_of = NULL;
> +        }
> +
> +        qobj = qdict_get(minfo, "deprecated");
> +        qbool = qobject_to(QBool, qobj);
> +        g_assert(qbool);
> +        cpus[idx].deprecated = qbool_get_bool(qbool);
> +    }
> +
> +    qtest_quit(qts);
> +    qobject_unref(response);
> +
> +    silence_spawn_log = false;
> +
> +    memset(&cpus[idx], 0, sizeof(struct CpuInfo)); /* Terminating entry */

Not required with g_new0 usage.

> +    return cpus;
> +}

With the minor change

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


