Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF24F4613D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w51Jk-0005Fq-6p; Tue, 24 Mar 2026 08:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w51Je-0005FG-Rd
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w51Jc-0005CN-Sc
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774357019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SbVzfoDvgGv435UJwj4U4ck/dmt/LM2DPHQHVK2BMR0=;
 b=E0Vrk4m+tgG8TTqCpJZtu6pxUaBP1+9rFEKmJE13SswO65dH9GQCOyJMTZPPdYZtfKQ5xa
 4U45/z3BwqmHaEeQKiiAT5h9Z9/kYX/JnjzAJxQN9dsDiVgYq9i6VXAcRUrUEPdu9aertt
 L8/RVhtGBSmXML8dbnpBdmcmg9olGHA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-wftC_P2UPT-8mIUWnBBZLQ-1; Tue,
 24 Mar 2026 08:56:55 -0400
X-MC-Unique: wftC_P2UPT-8mIUWnBBZLQ-1
X-Mimecast-MFC-AGG-ID: wftC_P2UPT-8mIUWnBBZLQ_1774357014
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2D861955E79; Tue, 24 Mar 2026 12:56:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E444E30002D6; Tue, 24 Mar 2026 12:56:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 89DAE21E6937; Tue, 24 Mar 2026 13:56:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH-for-11.1 v6 3/6] monitor: Have MonitorDef::get_value()
 always return int64_t type
In-Reply-To: <20260320091019.59902-4-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 20 Mar 2026 10:10:15
 +0100")
References: <20260320091019.59902-1-philmd@linaro.org>
 <20260320091019.59902-4-philmd@linaro.org>
Date: Tue, 24 Mar 2026 13:56:50 +0100
Message-ID: <87pl4ts7vx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Simplify MonitorDef::get_value() handler by having it always
> return a int64_t type. Truncate to 32-bit in the single caller.
>
> Note, this handler is only implemented once for the x86 targets.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/monitor/hmp-target.h | 6 +-----
>  monitor/hmp-target.c         | 5 ++++-
>  target/i386/monitor.c        | 4 ++--
>  3 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
> index 56322ceddd4..6364c94edf8 100644
> --- a/include/monitor/hmp-target.h
> +++ b/include/monitor/hmp-target.h
> @@ -27,15 +27,11 @@
>=20=20
>  typedef struct MonitorDef MonitorDef;
>=20=20
> -#ifdef COMPILING_PER_TARGET
> -#include "cpu.h"
>  struct MonitorDef {
>      const char *name;
>      int offset;
> -    target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
> -                             int val);
> +    int64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int =
offset);
>  };
> -#endif
>=20=20
>  const MonitorDef *target_monitor_defs(void);
>  int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pva=
l);
> diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
> index 3f019ae2a28..155caedd784 100644
> --- a/monitor/hmp-target.c
> +++ b/monitor/hmp-target.c
> @@ -23,6 +23,7 @@
>   */
>=20=20
>  #include "qemu/osdep.h"
> +#include "qemu/target-info.h"
>  #include "monitor-internal.h"
>  #include "monitor/qdev.h"
>  #include "net/slirp.h"
> @@ -33,6 +34,7 @@
>  #include "qapi/qapi-commands-control.h"
>  #include "qapi/qapi-commands-misc.h"
>  #include "qapi/qapi-commands-machine.h"
> +#include "exec/target_long.h"
>=20=20
>  #if defined(TARGET_S390X)
>  #include "hw/s390x/storage-keys.h"
> @@ -78,7 +80,8 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const =
char *name)
>      for(; md->name !=3D NULL; md++) {
>          if (hmp_compare_cmd(name, md->name)) {
>              if (md->get_value) {
> -                *pval =3D md->get_value(mon, md, md->offset);
> +                int64_t val =3D md->get_value(mon, md, md->offset);
> +                *pval =3D target_long_bits() =3D=3D 32 ? (int32_t)val : =
val;

This assumes target_long_bits() returns either 32 or 64, doesn't it?

Is this true today?

Will it remain true?

Could we use something like

    val & ((1 << target_long_bits()) - 1)

to truncate to target_long_bits() bits?

>              } else {
>                  CPUArchState *env =3D mon_get_cpu_env(mon);
>                  ptr =3D (uint8_t *)env + md->offset;
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 977f65fe16c..b128334e571 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -593,8 +593,8 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
>      }
>  }
>=20=20
> -static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef =
*md,
> -                                  int val)
> +static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
> +                              int offset)
>  {
>      CPUArchState *env =3D mon_get_cpu_env(mon);
>      return env->eip + env->segs[R_CS].base;


