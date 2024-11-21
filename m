Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E16D7877D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 15:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE8zI-0002n5-8A; Thu, 21 Nov 2024 10:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tE8zG-0002mD-3w
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:20:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tE8zE-0005Gw-B0
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732202451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NsgngFd0oKM3uJ0uRCOdxMUjEO3tFe3+cW3jqA5wdlY=;
 b=Qgz9U/aJf9HW30n4SSjywqGQCC6hAN4lsfeqiOoj084R+Kt0gJhTfQ6iRjhwHw+LNXEPoi
 0XqufoZ6HL61FoFFjsWVY/yaxmBIaA47kYsiBUHpiHTe89CJmBNubbUatcegTMf+J7k8aE
 YbQdiFRm2jtxDyMUh8oowAXQczyFWWA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-dBrYlWb7PhaNd5Wwk9X-4Q-1; Thu,
 21 Nov 2024 10:20:48 -0500
X-MC-Unique: dBrYlWb7PhaNd5Wwk9X-4Q-1
X-Mimecast-MFC-AGG-ID: dBrYlWb7PhaNd5Wwk9X-4Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E36C61956096; Thu, 21 Nov 2024 15:20:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.95])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC9B319560A3; Thu, 21 Nov 2024 15:20:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 89E5921E6A28; Thu, 21 Nov 2024 16:20:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  pbonzini@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  qemu-stable@nongnu.org
Subject: Re: [PATCH] qdev: Fix set_pci_devfn() to visit option only once
In-Reply-To: <20241119120353.57812-1-kwolf@redhat.com> (Kevin Wolf's message
 of "Tue, 19 Nov 2024 13:03:53 +0100")
References: <20241119120353.57812-1-kwolf@redhat.com>
Date: Thu, 21 Nov 2024 16:20:42 +0100
Message-ID: <87plmohaut.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Kevin Wolf <kwolf@redhat.com> writes:

> pci_devfn properties accept either a string or an integer as input. To
> implement this, set_pci_devfn() first tries to visit the option as a
> string, and if that fails, it visits it as an integer instead. While the
> QemuOpts visitor happens to accept this, it is invalid according to the
> visitor interface. QObject input visitors run into an assertion failure
> when this is done.
>
> QObject input visitors are used with the JSON syntax version of -device
> on the command line:
>
> $ ./qemu-system-x86_64 -enable-kvm -M q35 -device pcie-pci-bridge,id=pci.1,bus=pcie.0 -blockdev null-co,node-name=disk -device '{ "driver": "virtio-blk-pci", "drive": "disk", "id": "virtio-disk0", "bus": "pci.1", "addr": 1 }'
> qemu-system-x86_64: ../qapi/qobject-input-visitor.c:143: QObject *qobject_input_try_get_object(QObjectInputVisitor *, const char *, _Bool): Assertion `removed' failed.
>
> The proper way to accept both strings and integers is using the
> alternate mechanism, which tells us the type of the input before it's
> visited. With this information, we can directly visit it as the right
> type.
>
> This fixes set_pci_devfn() by using the alternate mechanism.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/core/qdev-properties-system.c | 54 +++++++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 18 deletions(-)
>
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 35deef05f3..91d3ff4719 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -790,39 +790,57 @@ static void set_pci_devfn(Object *obj, Visitor *v, const char *name,
>                            void *opaque, Error **errp)
>  {
>      Property *prop = opaque;
> +    GenericAlternate *alt;
>      int32_t value, *ptr = object_field_prop_ptr(obj, prop);
>      unsigned int slot, fn, n;
> -    char *str;
> +    g_autofree char *str = NULL;
> +
> +    if (!visit_start_alternate(v, name, &alt, sizeof(*alt), errp)) {
> +        return;
> +    }
> +
> +    switch (alt->type) {
> +    case QTYPE_QSTRING:
> +        if (!visit_type_str(v, name, &str, errp)) {
> +            goto out;
> +        }
>  
> -    if (!visit_type_str(v, name, &str, NULL)) {
> +        if (sscanf(str, "%x.%x%n", &slot, &fn, &n) != 2) {
> +            fn = 0;
> +            if (sscanf(str, "%x%n", &slot, &n) != 1) {
> +                goto invalid;
> +            }
> +        }
> +        if (str[n] != '\0' || fn > 7 || slot > 31) {
> +            goto invalid;
> +        }
> +        *ptr = slot << 3 | fn;
> +        break;
> +
> +    case QTYPE_QNUM:
>          if (!visit_type_int32(v, name, &value, errp)) {
> -            return;
> +            goto out;
>          }
>          if (value < -1 || value > 255) {
>              error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>                         name ? name : "null", "a value between -1 and 255");
> -            return;
> +            goto out;
>          }
>          *ptr = value;
> -        return;
> -    }
> +        break;
>  
> -    if (sscanf(str, "%x.%x%n", &slot, &fn, &n) != 2) {
> -        fn = 0;
> -        if (sscanf(str, "%x%n", &slot, &n) != 1) {
> -            goto invalid;
> -        }
> -    }
> -    if (str[n] != '\0' || fn > 7 || slot > 31) {
> -        goto invalid;
> +    default:
> +        error_setg(errp, "Invalid parameter type for '%s', expected int or str",
> +                   name ? name : "null");
> +        goto out;

This goto is redundant.

>      }
> -    *ptr = slot << 3 | fn;
> -    g_free(str);
> -    return;
> +
> +    goto out;
>  
>  invalid:
>      error_set_from_qdev_prop_error(errp, EINVAL, obj, name, str);
> -    g_free(str);
> +out:
> +    visit_end_alternate(v, (void **) &alt);
>  }
>  
>  static int print_pci_devfn(Object *obj, Property *prop, char *dest,

Ugly control flow, but cleaning that up is not the patch's goal.
Instead, it aims to just fix the bug.  Fair.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


