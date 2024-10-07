Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C343CCFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 13:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxnqw-00041w-6y; Mon, 07 Oct 2024 09:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sxnqt-00041H-QV
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 09:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sxnqs-0003bd-AL
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 09:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728307961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFFf8CKcwYhnJ7SdLlxptlTyPvE7fzsa30udxbxBdTM=;
 b=BqcrfzeUkH+9jc0/6BY2cQu9TvH+DZPegXFNMG8syBEw5wnyBDEZDA7LuG0t2Ghq7C4QIF
 GsML0jl0ui2v/mKJ1WFmcVXGXhGUMEAPE4G4iXZMY4ZlpDapv+58lJKfDvY8BQcoyXAGMF
 lDYQ8ou3NMtuJVGMUPI0GuevJBGa8z4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-HwkPg68NMs29ET5vyECnnA-1; Mon, 07 Oct 2024 09:32:40 -0400
X-MC-Unique: HwkPg68NMs29ET5vyECnnA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37cd4acb55aso3764816f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 06:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728307959; x=1728912759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFFf8CKcwYhnJ7SdLlxptlTyPvE7fzsa30udxbxBdTM=;
 b=wWNFy9RJBE0zv0aAJclO2eM04wCZehfAO7UeSjkB4d26uEpXzVLz+vlTKlsdYGrjaF
 /mUQissHp72CcbN+7GKyyRlRD9CmGI9nR6VhxK2eeh6kiZejje47mcVS7A8IEnXf7v2G
 tsRzgpEeRWCR3aMnOTkg6E4mqOb5+H2jZ1YgGZRiQxPFTGymoyd+kPNUrrc1IOaHi5lD
 cJQ1EOvpFYiuVzRYbfAsS/D+4M3bqGqAvajSyhc6xuGjtJPIVK4/DAxSMvhMlrIoUxP8
 OKnXvL6IpUCzkfj5C7J0WSCuDUtsjOt4mW2bkoHunfuC5F08RZ9ePlzR6UC5FpSf/qnM
 WEoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYJ0HFPKG6B6gPFxF66LvA94I5ybkNnnMglIc3/WgV8cD2ZPSUr7qf1Q9ZqVcYLPtxfW7nN1ysexG7@nongnu.org
X-Gm-Message-State: AOJu0Ywf8H36zhlu1+V+n0fzrbtw/cImFP5yITYDbhhlwIBJJZJE0XwA
 8V8f527RBCTlMiTdPeZ4CnBRP9IIKQjRqDBhJJEH7uT9Sk18yrAeICIqaugs+i9ACdsSc3AsqEf
 kS9GWELJv9HqLp+x0tMs34+YIYpU6EsNI/eF84/9Lslko35hdppbY
X-Received: by 2002:a5d:5f54:0:b0:37c:cfdc:19ba with SMTP id
 ffacd0b85a97d-37d0e751784mr12994626f8f.28.1728307958973; 
 Mon, 07 Oct 2024 06:32:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE37YY4hg+by8KEj+eJFTShA9TuM6SbjsJi7CKLf7bms8eMevvMcOwOE0+DTYw5TZaQeyvO8Q==
X-Received: by 2002:a5d:5f54:0:b0:37c:cfdc:19ba with SMTP id
 ffacd0b85a97d-37d0e751784mr12994593f8f.28.1728307958487; 
 Mon, 07 Oct 2024 06:32:38 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1695eee7sm5749727f8f.82.2024.10.07.06.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 06:32:37 -0700 (PDT)
Date: Mon, 7 Oct 2024 15:32:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Annie Li <annie.li@oracle.com>
Cc: miguel.luis@oracle.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 dave@treblig.org, mst@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 eblake@redhat.com, armbru@redhat.com
Subject: Re: [RFC V2 PATCH 04/11] acpi: Support Control Method sleep button
 for x86
Message-ID: <20241007153236.2b4d3ad6@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240927183906.1248-5-annie.li@oracle.com>
References: <20240927183906.1248-1-annie.li@oracle.com>
 <20240927183906.1248-5-annie.li@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 27 Sep 2024 14:38:59 -0400
Annie Li <annie.li@oracle.com> wrote:

> Adding Control Method Sleep button and its GPE event handler for
> x86.
> 
> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>  hw/i386/acpi-build.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 5d4bd2b710..ee62333a03 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -40,6 +40,7 @@
>  #include "hw/acpi/acpi_aml_interface.h"
>  #include "hw/input/i8042.h"
>  #include "hw/acpi/memory_hotplug.h"
> +#include "hw/acpi/control_method_device.h"
>  #include "sysemu/tpm.h"
>  #include "hw/acpi/tpm.h"
>  #include "hw/acpi/vmgenid.h"
> @@ -1527,6 +1528,14 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      }
>      aml_append(dsdt, scope);
>  
> +    sb_scope = aml_scope("_SB");
> +    acpi_dsdt_add_sleep_button(sb_scope);
> +    aml_append(dsdt, sb_scope);
> +
> +    scope =  aml_scope("\\_GPE");

> +    acpi_dsdt_add_sleep_gpe_event_handler(scope);
instead of having 1-off function, it would be better to inline impl,
here, like we do elsewhere with _Exx methods.

Also given that, series doesn't support wake,
you don't need to copy example from spec related to operation region,
as dedicated GPE event by itself tells us that sleep was requested.

so all you need to do is sending Notify to sleep button device.


> +    aml_append(dsdt, scope);
> +
>      if (pcmc->legacy_cpu_hotplug) {
>          build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
>      } else {


