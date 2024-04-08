Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B11CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtkil-0007OP-Ni; Mon, 08 Apr 2024 04:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtkik-0007Nv-Kz
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtkig-0005Dw-IP
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712566253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2PXEM0yyDgWwJs/AZqmvBVrqZFxQlhfzzAwi3nCDzJc=;
 b=dkMPHwbcY64fRt/h3qzVi36ZJgo5d57k49MumkavP3l7EALdLfE31w/2pqZamM9oSfmlEe
 pF0QdR+HdiUjCRji9KGl6COmpv39GVdMsrenvKcaIJROdGmrMysrVH5D3CH3Fqd4kZzFip
 SYNKo39HpRp58bWtiPNXVFJd+4i6Jrg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-f3cD1r8QOtSmJn21JwJJWw-1; Mon, 08 Apr 2024 04:50:51 -0400
X-MC-Unique: f3cD1r8QOtSmJn21JwJJWw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3418f237c0bso2836312f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 01:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712566250; x=1713171050;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2PXEM0yyDgWwJs/AZqmvBVrqZFxQlhfzzAwi3nCDzJc=;
 b=kmh5MIej9vE2rpx3smdMzu+DXYXkqx3s2/6zcIPuuV8VI4vo+lOsIZAEX5NXvfuoCV
 HoMkj2mBI156guFShL4r4fEWGPDOQtRWYzOOtbkcSKVL68wwe7iaFvF8neQdYn1feU+S
 iz6TeN3bHfHCC7agxc8c9dinpAtL4/Ji5kKVALKFIWn51pwDGGPHELylSUVH2oZHbP08
 eDo9aRN9f8iWkY73QuAyHus3RhK13Q5VNkdqpm30YVfO73YzjdiQE0V5TexDF5tdn+xF
 UeVSLfEqOgY+GSekxPKeDuR0pXEVJYrQCsQCChUBRsAK+pHXpaWe8jSxAQN0t8ksHTtP
 1E/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUHWqdg7+9hEDdPz/Fo6FlWkW51FvSjThy/NS9Rqor3hCZKd08zpRk+wE/PArLxyD2yWcEQnGAwK2gQfpmTyrrTY5J/N4=
X-Gm-Message-State: AOJu0YyDxoeVeOHIKQ0yLhjgvzbqcNMhB99tXTlaiaRhAfqYruH0gObK
 JqVpQiPOfG35qUGSW7wFl9TRAEQX8uOeSUDs9TgMSMtXvYOmMCEZ7WLN644vJ2gMEcuJTThLp5J
 5fIp2PksRryxond5sP4YRupT3tnSg5PCJanrZz/o+YPjnm5Is9wXfTm8wGhFKKlfwCJejUa+T9L
 BYOHrdnHzh6zw8bqozTkDDCjcq5kg=
X-Received: by 2002:a5d:64e9:0:b0:341:bf1e:45a5 with SMTP id
 g9-20020a5d64e9000000b00341bf1e45a5mr6764626wri.46.1712566250337; 
 Mon, 08 Apr 2024 01:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKRBHpLU7HBgh6ib0hlEVusWqa+BQJWsTTjN7bQpMFgUhVDKJCFJD3LbSu41O6REyyEhQBZqt4NMEcYbLVrTA=
X-Received: by 2002:a5d:64e9:0:b0:341:bf1e:45a5 with SMTP id
 g9-20020a5d64e9000000b00341bf1e45a5mr6764608wri.46.1712566249933; Mon, 08 Apr
 2024 01:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240404194757.9343-1-philmd@linaro.org>
 <20240404194757.9343-5-philmd@linaro.org>
In-Reply-To: <20240404194757.9343-5-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Apr 2024 10:50:38 +0200
Message-ID: <CABgObfbKjNe53MsYKPEK1QgMviTV9uGgkzGxv0K1JP3LwUyfsQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 4/7] util/qemu-config: Extract QMP commands to
 qemu-config-qmp.c
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Apr 4, 2024 at 9:48=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> QMP is irrelevant for user emulation. Extract the code
> related to QMP in a different source file, which won't
> be build for user emulation binaries. This avoid pulling
> pointless code.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/qemu/config-file.h |   3 +
>  util/qemu-config-qmp.c     | 206 +++++++++++++++++++++++++++++++++++++

This should go under monitor/.

Queued all except patch 2, please resubmit that and send it to
qemu-block@nongnu.org.

>  util/qemu-config.c         | 204 +-----------------------------------
>  util/meson.build           |   1 +
>  4 files changed, 212 insertions(+), 202 deletions(-)
>  create mode 100644 util/qemu-config-qmp.c
>
> diff --git a/include/qemu/config-file.h b/include/qemu/config-file.h
> index b82a778123..8b9d6df173 100644
> --- a/include/qemu/config-file.h
> +++ b/include/qemu/config-file.h
> @@ -8,6 +8,9 @@ QemuOptsList *qemu_find_opts(const char *group);
>  QemuOptsList *qemu_find_opts_err(const char *group, Error **errp);
>  QemuOpts *qemu_find_opts_singleton(const char *group);
>
> +extern QemuOptsList *vm_config_groups[48];
> +extern QemuOptsList *drive_config_groups[5];
> +
>  void qemu_add_opts(QemuOptsList *list);
>  void qemu_add_drive_opts(QemuOptsList *list);
>  int qemu_global_option(const char *str);
> diff --git a/util/qemu-config-qmp.c b/util/qemu-config-qmp.c
> new file mode 100644
> index 0000000000..24477a0e44
> --- /dev/null
> +++ b/util/qemu-config-qmp.c
> @@ -0,0 +1,206 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-misc.h"
> +#include "qapi/qmp/qlist.h"
> +#include "qemu/option.h"
> +#include "qemu/config-file.h"
> +#include "hw/boards.h"
> +
> +static CommandLineParameterInfoList *query_option_descs(const QemuOptDes=
c *desc)
> +{
> +    CommandLineParameterInfoList *param_list =3D NULL;
> +    CommandLineParameterInfo *info;
> +    int i;
> +
> +    for (i =3D 0; desc[i].name !=3D NULL; i++) {
> +        info =3D g_malloc0(sizeof(*info));
> +        info->name =3D g_strdup(desc[i].name);
> +
> +        switch (desc[i].type) {
> +        case QEMU_OPT_STRING:
> +            info->type =3D COMMAND_LINE_PARAMETER_TYPE_STRING;
> +            break;
> +        case QEMU_OPT_BOOL:
> +            info->type =3D COMMAND_LINE_PARAMETER_TYPE_BOOLEAN;
> +            break;
> +        case QEMU_OPT_NUMBER:
> +            info->type =3D COMMAND_LINE_PARAMETER_TYPE_NUMBER;
> +            break;
> +        case QEMU_OPT_SIZE:
> +            info->type =3D COMMAND_LINE_PARAMETER_TYPE_SIZE;
> +            break;
> +        }
> +
> +        info->help =3D g_strdup(desc[i].help);
> +        info->q_default =3D g_strdup(desc[i].def_value_str);
> +
> +        QAPI_LIST_PREPEND(param_list, info);
> +    }
> +
> +    return param_list;
> +}
> +
> +/* remove repeated entry from the info list */
> +static void cleanup_infolist(CommandLineParameterInfoList *head)
> +{
> +    CommandLineParameterInfoList *pre_entry, *cur, *del_entry;
> +
> +    cur =3D head;
> +    while (cur->next) {
> +        pre_entry =3D head;
> +        while (pre_entry !=3D cur->next) {
> +            if (!strcmp(pre_entry->value->name, cur->next->value->name))=
 {
> +                del_entry =3D cur->next;
> +                cur->next =3D cur->next->next;
> +                del_entry->next =3D NULL;
> +                qapi_free_CommandLineParameterInfoList(del_entry);
> +                break;
> +            }
> +            pre_entry =3D pre_entry->next;
> +        }
> +        cur =3D cur->next;
> +    }
> +}
> +
> +/* merge the description items of two parameter infolists */
> +static void connect_infolist(CommandLineParameterInfoList *head,
> +                             CommandLineParameterInfoList *new)
> +{
> +    CommandLineParameterInfoList *cur;
> +
> +    cur =3D head;
> +    while (cur->next) {
> +        cur =3D cur->next;
> +    }
> +    cur->next =3D new;
> +}
> +
> +/* access all the local QemuOptsLists for drive option */
> +static CommandLineParameterInfoList *get_drive_infolist(void)
> +{
> +    CommandLineParameterInfoList *head =3D NULL, *cur;
> +    int i;
> +
> +    for (i =3D 0; drive_config_groups[i] !=3D NULL; i++) {
> +        if (!head) {
> +            head =3D query_option_descs(drive_config_groups[i]->desc);
> +        } else {
> +            cur =3D query_option_descs(drive_config_groups[i]->desc);
> +            connect_infolist(head, cur);
> +        }
> +    }
> +    cleanup_infolist(head);
> +
> +    return head;
> +}
> +
> +static CommandLineParameterInfo *objprop_to_cmdline_prop(ObjectProperty =
*prop)
> +{
> +    CommandLineParameterInfo *info;
> +
> +    info =3D g_malloc0(sizeof(*info));
> +    info->name =3D g_strdup(prop->name);
> +
> +    if (g_str_equal(prop->type, "bool") || g_str_equal(prop->type, "OnOf=
fAuto")) {
> +        info->type =3D COMMAND_LINE_PARAMETER_TYPE_BOOLEAN;
> +    } else if (g_str_equal(prop->type, "int")) {
> +        info->type =3D COMMAND_LINE_PARAMETER_TYPE_NUMBER;
> +    } else if (g_str_equal(prop->type, "size")) {
> +        info->type =3D COMMAND_LINE_PARAMETER_TYPE_SIZE;
> +    } else {
> +        info->type =3D COMMAND_LINE_PARAMETER_TYPE_STRING;
> +    }
> +
> +    if (prop->description) {
> +        info->help =3D g_strdup(prop->description);
> +    }
> +
> +    return info;
> +}
> +
> +static CommandLineParameterInfoList *query_all_machine_properties(void)
> +{
> +    CommandLineParameterInfoList *params =3D NULL, *clpiter;
> +    CommandLineParameterInfo *info;
> +    GSList *machines, *curr_mach;
> +    ObjectPropertyIterator op_iter;
> +    ObjectProperty *prop;
> +    bool is_new;
> +
> +    machines =3D object_class_get_list(TYPE_MACHINE, false);
> +    assert(machines);
> +
> +    /* Loop over all machine classes */
> +    for (curr_mach =3D machines; curr_mach; curr_mach =3D curr_mach->nex=
t) {
> +        object_class_property_iter_init(&op_iter, curr_mach->data);
> +        /* ... and over the properties of each machine: */
> +        while ((prop =3D object_property_iter_next(&op_iter))) {
> +            if (!prop->set) {
> +                continue;
> +            }
> +            /*
> +             * Check whether the property has already been put into the =
list
> +             * (via another machine class)
> +             */
> +            is_new =3D true;
> +            for (clpiter =3D params; clpiter !=3D NULL; clpiter =3D clpi=
ter->next) {
> +                if (g_str_equal(clpiter->value->name, prop->name)) {
> +                    is_new =3D false;
> +                    break;
> +                }
> +            }
> +            /* If it hasn't been added before, add it now to the list */
> +            if (is_new) {
> +                info =3D objprop_to_cmdline_prop(prop);
> +                QAPI_LIST_PREPEND(params, info);
> +            }
> +        }
> +    }
> +
> +    g_slist_free(machines);
> +
> +    /* Add entry for the "type" parameter */
> +    info =3D g_malloc0(sizeof(*info));
> +    info->name =3D g_strdup("type");
> +    info->type =3D COMMAND_LINE_PARAMETER_TYPE_STRING;
> +    info->help =3D g_strdup("machine type");
> +    QAPI_LIST_PREPEND(params, info);
> +
> +    return params;
> +}
> +
> +CommandLineOptionInfoList *qmp_query_command_line_options(const char *op=
tion,
> +                                                          Error **errp)
> +{
> +    CommandLineOptionInfoList *conf_list =3D NULL;
> +    CommandLineOptionInfo *info;
> +    int i;
> +
> +    for (i =3D 0; vm_config_groups[i] !=3D NULL; i++) {
> +        if (!option || !strcmp(option, vm_config_groups[i]->name)) {
> +            info =3D g_malloc0(sizeof(*info));
> +            info->option =3D g_strdup(vm_config_groups[i]->name);
> +            if (!strcmp("drive", vm_config_groups[i]->name)) {
> +                info->parameters =3D get_drive_infolist();
> +            } else {
> +                info->parameters =3D
> +                    query_option_descs(vm_config_groups[i]->desc);
> +            }
> +            QAPI_LIST_PREPEND(conf_list, info);
> +        }
> +    }
> +
> +    if (!option || !strcmp(option, "machine")) {
> +        info =3D g_malloc0(sizeof(*info));
> +        info->option =3D g_strdup("machine");
> +        info->parameters =3D query_all_machine_properties();
> +        QAPI_LIST_PREPEND(conf_list, info);
> +    }
> +
> +    if (conf_list =3D=3D NULL) {
> +        error_setg(errp, "invalid option name: %s", option);
> +    }
> +
> +    return conf_list;
> +}
> diff --git a/util/qemu-config.c b/util/qemu-config.c
> index 42076efe1e..a90c18dad2 100644
> --- a/util/qemu-config.c
> +++ b/util/qemu-config.c
> @@ -1,16 +1,14 @@
>  #include "qemu/osdep.h"
>  #include "block/qdict.h" /* for qdict_extract_subqdict() */
>  #include "qapi/error.h"
> -#include "qapi/qapi-commands-misc.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qlist.h"
>  #include "qemu/error-report.h"
>  #include "qemu/option.h"
>  #include "qemu/config-file.h"
> -#include "hw/boards.h"
>
> -static QemuOptsList *vm_config_groups[48];
> -static QemuOptsList *drive_config_groups[5];
> +QemuOptsList *vm_config_groups[48];
> +QemuOptsList *drive_config_groups[5];
>
>  static QemuOptsList *find_list(QemuOptsList **lists, const char *group,
>                                 Error **errp)
> @@ -55,204 +53,6 @@ QemuOpts *qemu_find_opts_singleton(const char *group)
>      return opts;
>  }
>
> -static CommandLineParameterInfoList *query_option_descs(const QemuOptDes=
c *desc)
> -{
> -    CommandLineParameterInfoList *param_list =3D NULL;
> -    CommandLineParameterInfo *info;
> -    int i;
> -
> -    for (i =3D 0; desc[i].name !=3D NULL; i++) {
> -        info =3D g_malloc0(sizeof(*info));
> -        info->name =3D g_strdup(desc[i].name);
> -
> -        switch (desc[i].type) {
> -        case QEMU_OPT_STRING:
> -            info->type =3D COMMAND_LINE_PARAMETER_TYPE_STRING;
> -            break;
> -        case QEMU_OPT_BOOL:
> -            info->type =3D COMMAND_LINE_PARAMETER_TYPE_BOOLEAN;
> -            break;
> -        case QEMU_OPT_NUMBER:
> -            info->type =3D COMMAND_LINE_PARAMETER_TYPE_NUMBER;
> -            break;
> -        case QEMU_OPT_SIZE:
> -            info->type =3D COMMAND_LINE_PARAMETER_TYPE_SIZE;
> -            break;
> -        }
> -
> -        info->help =3D g_strdup(desc[i].help);
> -        info->q_default =3D g_strdup(desc[i].def_value_str);
> -
> -        QAPI_LIST_PREPEND(param_list, info);
> -    }
> -
> -    return param_list;
> -}
> -
> -/* remove repeated entry from the info list */
> -static void cleanup_infolist(CommandLineParameterInfoList *head)
> -{
> -    CommandLineParameterInfoList *pre_entry, *cur, *del_entry;
> -
> -    cur =3D head;
> -    while (cur->next) {
> -        pre_entry =3D head;
> -        while (pre_entry !=3D cur->next) {
> -            if (!strcmp(pre_entry->value->name, cur->next->value->name))=
 {
> -                del_entry =3D cur->next;
> -                cur->next =3D cur->next->next;
> -                del_entry->next =3D NULL;
> -                qapi_free_CommandLineParameterInfoList(del_entry);
> -                break;
> -            }
> -            pre_entry =3D pre_entry->next;
> -        }
> -        cur =3D cur->next;
> -    }
> -}
> -
> -/* merge the description items of two parameter infolists */
> -static void connect_infolist(CommandLineParameterInfoList *head,
> -                             CommandLineParameterInfoList *new)
> -{
> -    CommandLineParameterInfoList *cur;
> -
> -    cur =3D head;
> -    while (cur->next) {
> -        cur =3D cur->next;
> -    }
> -    cur->next =3D new;
> -}
> -
> -/* access all the local QemuOptsLists for drive option */
> -static CommandLineParameterInfoList *get_drive_infolist(void)
> -{
> -    CommandLineParameterInfoList *head =3D NULL, *cur;
> -    int i;
> -
> -    for (i =3D 0; drive_config_groups[i] !=3D NULL; i++) {
> -        if (!head) {
> -            head =3D query_option_descs(drive_config_groups[i]->desc);
> -        } else {
> -            cur =3D query_option_descs(drive_config_groups[i]->desc);
> -            connect_infolist(head, cur);
> -        }
> -    }
> -    cleanup_infolist(head);
> -
> -    return head;
> -}
> -
> -static CommandLineParameterInfo *objprop_to_cmdline_prop(ObjectProperty =
*prop)
> -{
> -    CommandLineParameterInfo *info;
> -
> -    info =3D g_malloc0(sizeof(*info));
> -    info->name =3D g_strdup(prop->name);
> -
> -    if (g_str_equal(prop->type, "bool") || g_str_equal(prop->type, "OnOf=
fAuto")) {
> -        info->type =3D COMMAND_LINE_PARAMETER_TYPE_BOOLEAN;
> -    } else if (g_str_equal(prop->type, "int")) {
> -        info->type =3D COMMAND_LINE_PARAMETER_TYPE_NUMBER;
> -    } else if (g_str_equal(prop->type, "size")) {
> -        info->type =3D COMMAND_LINE_PARAMETER_TYPE_SIZE;
> -    } else {
> -        info->type =3D COMMAND_LINE_PARAMETER_TYPE_STRING;
> -    }
> -
> -    if (prop->description) {
> -        info->help =3D g_strdup(prop->description);
> -    }
> -
> -    return info;
> -}
> -
> -static CommandLineParameterInfoList *query_all_machine_properties(void)
> -{
> -    CommandLineParameterInfoList *params =3D NULL, *clpiter;
> -    CommandLineParameterInfo *info;
> -    GSList *machines, *curr_mach;
> -    ObjectPropertyIterator op_iter;
> -    ObjectProperty *prop;
> -    bool is_new;
> -
> -    machines =3D object_class_get_list(TYPE_MACHINE, false);
> -    assert(machines);
> -
> -    /* Loop over all machine classes */
> -    for (curr_mach =3D machines; curr_mach; curr_mach =3D curr_mach->nex=
t) {
> -        object_class_property_iter_init(&op_iter, curr_mach->data);
> -        /* ... and over the properties of each machine: */
> -        while ((prop =3D object_property_iter_next(&op_iter))) {
> -            if (!prop->set) {
> -                continue;
> -            }
> -            /*
> -             * Check whether the property has already been put into the =
list
> -             * (via another machine class)
> -             */
> -            is_new =3D true;
> -            for (clpiter =3D params; clpiter !=3D NULL; clpiter =3D clpi=
ter->next) {
> -                if (g_str_equal(clpiter->value->name, prop->name)) {
> -                    is_new =3D false;
> -                    break;
> -                }
> -            }
> -            /* If it hasn't been added before, add it now to the list */
> -            if (is_new) {
> -                info =3D objprop_to_cmdline_prop(prop);
> -                QAPI_LIST_PREPEND(params, info);
> -            }
> -        }
> -    }
> -
> -    g_slist_free(machines);
> -
> -    /* Add entry for the "type" parameter */
> -    info =3D g_malloc0(sizeof(*info));
> -    info->name =3D g_strdup("type");
> -    info->type =3D COMMAND_LINE_PARAMETER_TYPE_STRING;
> -    info->help =3D g_strdup("machine type");
> -    QAPI_LIST_PREPEND(params, info);
> -
> -    return params;
> -}
> -
> -CommandLineOptionInfoList *qmp_query_command_line_options(const char *op=
tion,
> -                                                          Error **errp)
> -{
> -    CommandLineOptionInfoList *conf_list =3D NULL;
> -    CommandLineOptionInfo *info;
> -    int i;
> -
> -    for (i =3D 0; vm_config_groups[i] !=3D NULL; i++) {
> -        if (!option || !strcmp(option, vm_config_groups[i]->name)) {
> -            info =3D g_malloc0(sizeof(*info));
> -            info->option =3D g_strdup(vm_config_groups[i]->name);
> -            if (!strcmp("drive", vm_config_groups[i]->name)) {
> -                info->parameters =3D get_drive_infolist();
> -            } else {
> -                info->parameters =3D
> -                    query_option_descs(vm_config_groups[i]->desc);
> -            }
> -            QAPI_LIST_PREPEND(conf_list, info);
> -        }
> -    }
> -
> -    if (!option || !strcmp(option, "machine")) {
> -        info =3D g_malloc0(sizeof(*info));
> -        info->option =3D g_strdup("machine");
> -        info->parameters =3D query_all_machine_properties();
> -        QAPI_LIST_PREPEND(conf_list, info);
> -    }
> -
> -    if (conf_list =3D=3D NULL) {
> -        error_setg(errp, "invalid option name: %s", option);
> -    }
> -
> -    return conf_list;
> -}
> -
>  QemuOptsList *qemu_find_opts_err(const char *group, Error **errp)
>  {
>      return find_list(vm_config_groups, group, errp);
> diff --git a/util/meson.build b/util/meson.build
> index 247f55a80d..636b17a414 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -75,6 +75,7 @@ if have_system
>    if host_os =3D=3D 'linux'
>      util_ss.add(files('userfaultfd.c'))
>    endif
> +  util_ss.add(files('qemu-config-qmp.c'))
>    util_ss.add(files('yank.c'))
>  endif
>
> --
> 2.41.0
>


