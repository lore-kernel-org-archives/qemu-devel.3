Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E848D6ED2B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 13:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE7Hh-0008EK-8Y; Thu, 21 Nov 2024 08:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tE7HW-0008Cl-7E
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 08:31:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tE7HQ-0007so-39
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 08:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732195890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X0YXp45s7vnoyQ3K0lsjcnH8rR5MKcGo4y9UEojEpHw=;
 b=I4UmwS1azLsfdYaBfYzbnIu5nm53ymD4ASvwZhIcJkYUH8F1N8woYp0gRAUGBKSbVa8chz
 osdsMP9i5mcsLTFerTuDhgiN25QgO/30dsV1xzb5/i+3e28pGcRTSO9sZo5Mj/B9fuCBkr
 zbuziR2M/yZ08Nu2eaJ0zSmtvi3mlDg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-j9f4avWZMJGuOA4vM7_ZHA-1; Thu,
 21 Nov 2024 08:31:27 -0500
X-MC-Unique: j9f4avWZMJGuOA4vM7_ZHA-1
X-Mimecast-MFC-AGG-ID: j9f4avWZMJGuOA4vM7_ZHA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED2121977321; Thu, 21 Nov 2024 13:31:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CAEF30000DF; Thu, 21 Nov 2024 13:31:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3706B21E6A28; Thu, 21 Nov 2024 14:31:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Peter
 Maydell <peter.maydell@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Juraj Marcin <jmarcin@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?C=C3=A9dri?=
 =?utf-8?Q?c?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 10/12] qom: Create system containers explicitly
In-Reply-To: <20241120215703.3918445-11-peterx@redhat.com> (Peter Xu's message
 of "Wed, 20 Nov 2024 16:57:01 -0500")
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-11-peterx@redhat.com>
Date: Thu, 21 Nov 2024 14:31:23 +0100
Message-ID: <87h680iuhg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> Always explicitly create QEMU system containers upfront.
>
> Root containers will be created when trying to fetch the root object the
> 1st time.

Which ones are affected?

Not a fan of creating stuff on first use, unless there may not be any
use.  But no worse than before.

>            Machine sub-containers will be created only until machine is
> being initialized.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/core/machine.c | 19 ++++++++++++++++---
>  qom/object.c      | 16 +++++++++++++++-
>  2 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index a35c4a8fae..a184dbf8f0 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1193,14 +1193,27 @@ static void machine_class_base_init(ObjectClass *oc, void *data)
>      }
>  }
>  
> +const char *machine_containers[] = {
> +    "unattached",
> +    "peripheral",
> +    "peripheral-anon"
> +};
> +
> +static void qemu_create_machine_containers(Object *machine)
> +{
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(machine_containers); i++) {
> +        container_create(machine, machine_containers[i]);
> +    }
> +}
> +
>  static void machine_initfn(Object *obj)
>  {
>      MachineState *ms = MACHINE(obj);
>      MachineClass *mc = MACHINE_GET_CLASS(obj);
>  
> -    container_get(obj, "/peripheral");
> -    container_get(obj, "/peripheral-anon");
> -
> +    qemu_create_machine_containers(obj);

We now additionally create "/machine/unattached" here.  

>      ms->dump_guest_core = true;
>      ms->mem_merge = (QEMU_MADV_MERGEABLE != QEMU_MADV_INVALID);
>      ms->enable_graphics = true;
> diff --git a/qom/object.c b/qom/object.c
> index 214d6eb4c1..810e6f2bd9 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1734,12 +1734,26 @@ const char *object_property_get_type(Object *obj, const char *name, Error **errp
>      return prop->type;
>  }
>  
> +static Object *object_root_initialize(void)
> +{
> +    Object *root = object_new(TYPE_CONTAINER);
> +
> +    /*
> +     * Create all QEMU system containers.  "machine" and its sub-containers
> +     * are only created when machine initializes (qemu_create_machine()).
> +     */
> +    container_create(root, "chardevs");
> +    container_create(root, "objects");
> +
> +    return root;
> +}
> +
>  Object *object_get_root(void)
>  {
>      static Object *root;
>  
>      if (!root) {
> -        root = object_new(TYPE_CONTAINER);
> +        root = object_root_initialize();

We now additonally create "/chardevs" and "/objects" here, not just "/".

>      }
>  
>      return root;


