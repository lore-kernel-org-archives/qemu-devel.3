Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC51DC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 12:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMR7w-0006Io-7J; Tue, 03 Jun 2025 08:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMR7s-0006IH-09
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMR7m-0002fv-92
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748955130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=trUsKMFwJz0c6UejqsMV3LgBjDPpBFT6soa7gKNzj40=;
 b=ckvMXbSgg4wBmjgdBQXhGYFB+57EJeE7K80XQAR2yt9MU+X532njiOgAAyL+66tt/5GlW4
 lURB04A7ORrfgNk5SD4O4nW7EML8kheUmDor9cXJ1jiRXJpGntfCCoefzXnLPeNndICd9m
 75AgbVQaUbvUbEWJAcKow0RUASFnzTs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-oR3mgnhtOR2vT4VOwf7nnA-1; Tue, 03 Jun 2025 08:52:09 -0400
X-MC-Unique: oR3mgnhtOR2vT4VOwf7nnA-1
X-Mimecast-MFC-AGG-ID: oR3mgnhtOR2vT4VOwf7nnA_1748955128
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450d290d542so29765615e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 05:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748955128; x=1749559928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=trUsKMFwJz0c6UejqsMV3LgBjDPpBFT6soa7gKNzj40=;
 b=M6iJ4PWaBRnn7XzhY/37DSLch7ZtS0NskCSjV/F8N/U/HL76BopQ9lnqEHmcEd3vfA
 jXEbleRDDHCJh18cblwuZn7SCE0DzKGFupY8sPYSzve8VouXPAMrdOFwkJaNAluOHAy/
 qhXi9rB2ANgqqU9pIWyzJ0050bmC5yA5oNnUi4cujbA5QgXKT6WBIIcBzf8rdI9P1H6C
 YLH1evTOkAmSZfrk1blcUwAL/75m/vG7gGNisphLP2Xv4mUjU1habfCkQyCHCQnffjxB
 FP1Hw2QYu2DE+qOP0m6zRsaogX6GsdbuNL72pAO/pcCVeObScIARzc1eE6OUS4shdw9U
 kzVw==
X-Gm-Message-State: AOJu0YxK/KuyMuxaQfxgeR7v48EFcJj0UxUIvzS7AgOlgrLVcfk4gOFG
 9mPe+Tv8EmXuPZNK7DyxvaajOYtcZyq9H3zDgx+scqmlXm1CR9nc4Fg7dOpnRndGIj8lSpOf9Ii
 TvBylnJ7LdcEcVENamcVaM62xX74oSk2spHPbqnReTgrt49S5MXLA1cjo
X-Gm-Gg: ASbGncuGKRUSr9jYoCVGF/4ROpOrQgECa4Gl00k9MJxoOdgb7Aht4ZBifcsyLYJNBMu
 xKKyMXum29fC3YyNrEwAB3kr0lBAsCjyfmjceAMMAHvGDSkV8vgz2DVthEzxw9OprRzW2Z+ekVA
 BVLZ+PpDzj4AEkpIjhJ7a7i3hqgEkB5sq3mM6GpBGZn1SvqnVFKHeIwzl9Op4Ryb/SOu/AsAZ2a
 3fb2OaYMqcexCf8EKDa8BEo6QS6/R75eENcfmMe0iO8g95fT+BvMQAGqSgOk7+9cLk7I9eWnFBr
 sp3/cHKuCnM3aFLG5/mjxzoKLB6MF0aA
X-Received: by 2002:a05:600c:8119:b0:450:cc79:676 with SMTP id
 5b1f17b1804b1-450d6544787mr140689115e9.20.1748955128303; 
 Tue, 03 Jun 2025 05:52:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBXtlPAf5PbN9PnCx+aWOAAMkaQyr9CTMa9Btz4ekrvbB68QYM9g3+9EjCnhvS26XEw4Xfrw==
X-Received: by 2002:a05:600c:8119:b0:450:cc79:676 with SMTP id
 5b1f17b1804b1-450d6544787mr140688835e9.20.1748955127929; 
 Tue, 03 Jun 2025 05:52:07 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa23f4sm167858745e9.14.2025.06.03.05.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 05:52:07 -0700 (PDT)
Date: Tue, 3 Jun 2025 14:52:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Annie Li <annie.li@oracle.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
Subject: Re: [PATCH 03/13] acpi: Support Control Method sleep button for x86
Message-ID: <20250603145206.4e54876e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250528163917.2167-1-annie.li@oracle.com>
References: <20250528163545.2143-1-annie.li@oracle.com>
 <20250528163917.2167-1-annie.li@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 28 May 2025 12:39:17 -0400
Annie Li <annie.li@oracle.com> wrote:

> Add Control Method Sleep button and its GPE event handler for
> x86 platform. The GPE event handler notifies OSPM when the
> Sleep button event is triggered.
> 
> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>  hw/i386/acpi-build.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 3fffa4a332..2ddf669006 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -40,6 +40,7 @@
>  #include "hw/acpi/acpi_aml_interface.h"
>  #include "hw/input/i8042.h"
>  #include "hw/acpi/memory_hotplug.h"
> +#include "hw/acpi/control_method_device.h"
>  #include "system/tpm.h"
>  #include "hw/acpi/tpm.h"
>  #include "hw/acpi/vmgenid.h"
> @@ -1359,7 +1360,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                                                       NULL);
>      Object *q35 = object_resolve_type_unambiguous(TYPE_Q35_HOST_DEVICE, NULL);
>      CrsRangeEntry *entry;
> -    Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs;
> +    Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs, *condition;
>      CrsRangeSet crs_range_set;
>      PCMachineState *pcms = PC_MACHINE(machine);
>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
> @@ -1465,6 +1466,27 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      }
>      aml_append(dsdt, scope);
>  
> +    sb_scope = aml_scope("_SB");
> +    acpi_dsdt_add_sleep_button(sb_scope);
> +    aml_append(dsdt, sb_scope);
> +
> +    /*
> +     * The event handler for the control method sleep button is generated
> +     * for notifying OSPM (ACPI v6.5, Section 4.8.2.2.2.2).
> +     */
> +    scope =  aml_scope("\\_GPE");
> +    method = aml_method("_L07", 0, AML_NOTSERIALIZED);
> +    condition = aml_if(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE".SBP"));
       s/condition/if_ctx/
also use full form 'if something == something' for condtion

> +    aml_append(condition,
> +               aml_store(aml_int(1),
> +                         aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE".SBP")));

so what is handling this write on qemu side?
and why it's here to begin with? (commit says that it sends event to OSMP but nothing about this write)

> +    aml_append(condition,
> +               aml_notify(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE),
> +                                    aml_int(0x80)));
> +    aml_append(method, condition);
> +    aml_append(scope, method);
> +    aml_append(dsdt, scope);
> +
>      if (pcmc->legacy_cpu_hotplug) {
>          build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
>      } else {


