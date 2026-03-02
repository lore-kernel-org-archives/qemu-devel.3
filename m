Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959F5D58E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 06:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwwgV-00007A-3N; Mon, 02 Mar 2026 01:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vwwgT-00006h-NE
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:23:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vwwgS-0005n1-Am
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772432591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QgWw+isek8kFfE9dkzO4TYosXavsTf2b/dCLNhjOzoM=;
 b=Sp5ZhIbKDMr2Rbqv38z9GSxOo/5/IS7c1hWo0UOSXsXixpzc9XNNDewIyGkjPTIWf5EWm+
 bwmD9shHtM2e4cC6qXS7weWe9KBvrRSc/jlEj4mIkn8Hgw8xYV7ZnX0PiTCmx44kXENWSB
 L1c0O9qVIq0g/4hcX9iXOBJnRnGvlzQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-dcKIJnpNMeuHLjErfVbc8Q-1; Mon, 02 Mar 2026 01:23:08 -0500
X-MC-Unique: dcKIJnpNMeuHLjErfVbc8Q-1
X-Mimecast-MFC-AGG-ID: dcKIJnpNMeuHLjErfVbc8Q_1772432587
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439b5346b6cso660554f8f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 22:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772432587; x=1773037387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgWw+isek8kFfE9dkzO4TYosXavsTf2b/dCLNhjOzoM=;
 b=Kat3B0iHZ65pYxEQ13YL9sGclG5YprP7mag1CbgX2p7z3hwtSDU0vV3aF8O9uQKeen
 qPZk3zsS0didPPC8LNO9WHVMkfidigtQDOssUE9U086qFe2VkkvMwnCqzYM9X+N9EuXg
 jMi7461x3JyKaBTGFo92yqCMxxxk6y6PH8m6z9Jr+iqnE40PgmpMAsStkcApmYIxyKbE
 gw8Ba7WxRJKhqLvOgc/KIUXw69DmSx7RonjxeptLvc3/BwMrrskrGwKuF7dqRKU6lcje
 C+TVjfee1zYcNqaJDQOK40oc92rgAgVFLitLXVCviaigta/aVlNiu0Udt97YOjGXsNGD
 aZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772432587; x=1773037387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QgWw+isek8kFfE9dkzO4TYosXavsTf2b/dCLNhjOzoM=;
 b=J0zU9nVrHkKK4CKJclEB30XfjBB2boR/pIy6vJKjOMDMW4y0QT/V14caft965evgRl
 4dlZs+KwLb6crza3LtDVt511rCbvB1Wc7I3SISwO18QqRrcwgpr5EQJL0hrF6cZYrGis
 QmVBlV+RB7f6gTXNR9iHNaXY0Z8D90FMFAOy25Ri55BMHhvuKAVMbQxLS/aH5AryTNiq
 SE2hMGFboN7+rpfA20tGaM0SfY8gKOmdpcKIejBjByvy0G5pfQdbs3TXxQl1p/TN7lNZ
 UNo9wQo+EcGYCV+xtN0S340hOWDtIMxbsPcKVprCaXGCmHrTS2peo8vXsK+webnR74tu
 NXTQ==
X-Gm-Message-State: AOJu0YwrmraStHK5bn9D+0fZUBWI/RwOBrmWOs37lTsI3RYr6uSGuDCg
 P3HvyRNCjEJID4al0sM5ZP+e0s4bwC7QGnI18oUPkLySBnzYr7nKeR3RMWz7qTaO3tGPtJXkPyp
 Qz9rlAqWiZSumgjGpX5cK34PnvEphUb91f6VaBQ7wretiPsTnUJ7UQ0Hh
X-Gm-Gg: ATEYQzyul38AVwNKIUuP6KPxsKf75Bt+cSf12v+Y48Hv/6dUvDKWpg+Bur/8KeoUjTF
 +d8uvwmo8UeYPEsXdxDY8q+n35Dh8eUeIeRoK2Vb53fzvIlLJYzjEJw25sC/WT7d1VJ4p4KZYJe
 HomDRFkFvFWI0QRiORRdtWM14O15LQmzP4cfWU96/LIKvI8xocdUvfwzPSYBrkwCH7ANnld5IRs
 A0aWXd58D2Ao44xlgLG9siIz6j7sRdddSo7xe+7UtnpBgvYqg3cprl+0W2QDiiu/wJgWNiNVSI3
 f/fVba2EyjiIZcA8umRmHx/F7udmfBkHmIHkChbH1Xj8yQMmqHNye/dD8yafDuOkkrD+fo/qdXP
 doybnhw==
X-Received: by 2002:a05:6000:40c8:b0:439:b8e5:5c13 with SMTP id
 ffacd0b85a97d-439b8e5654bmr2511820f8f.53.1772432586993; 
 Sun, 01 Mar 2026 22:23:06 -0800 (PST)
X-Received: by 2002:a05:6000:40c8:b0:439:b8e5:5c13 with SMTP id
 ffacd0b85a97d-439b8e5654bmr2511798f8f.53.1772432586608; 
 Sun, 01 Mar 2026 22:23:06 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439ba2a58dasm2512219f8f.27.2026.03.01.22.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 22:23:06 -0800 (PST)
Date: Mon, 2 Mar 2026 07:23:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 03/11] hw/acpi: Move qbus_build_aml() function out of
 acpi_interface.c
Message-ID: <20260302072303.6406669b@imammedo>
In-Reply-To: <20260225035739.42848-4-philmd@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
 <20260225035739.42848-4-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 25 Feb 2026 04:57:31 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> acpi_interface.c should only register QOM interfaces. Move
> the qbus_build_aml() function to aml-build.c with the other
> AML build-related helpers.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/acpi_interface.c | 10 ----------
>  hw/acpi/aml-build.c      | 11 +++++++++++
>  2 files changed, 11 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/acpi/acpi_interface.c b/hw/acpi/acpi_interface.c
> index e58e8aaee23..a44679017ea 100644
> --- a/hw/acpi/acpi_interface.c
> +++ b/hw/acpi/acpi_interface.c
> @@ -2,16 +2,6 @@
>  #include "hw/acpi/acpi_dev_interface.h"
>  #include "hw/acpi/acpi_aml_interface.h"
>  #include "qemu/module.h"
> -#include "qemu/queue.h"
> -
> -void qbus_build_aml(BusState *bus, Aml *scope)
> -{
> -    BusChild *kid;
> -
> -    QTAILQ_FOREACH(kid, &bus->children, sibling) {
> -        call_dev_aml_func(DEVICE(kid->child), scope);
> -    }
> -}
> =20
>  static void register_types(void)
>  {
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index ea1c415b211..4b374050881 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -25,12 +25,14 @@
>  #include "hw/acpi/acpi.h"
>  #include "qemu/bswap.h"
>  #include "qemu/bitops.h"
> +#include "qemu/queue.h"
>  #include "system/numa.h"
>  #include "hw/core/boards.h"
>  #include "hw/acpi/tpm.h"
>  #include "hw/pci/pci_host.h"
>  #include "hw/pci/pci_bus.h"
>  #include "hw/pci/pci_bridge.h"
> +#include "hw/acpi/acpi_aml_interface.h"
>  #include "qemu/cutils.h"
> =20
>  static GArray *build_alloc_array(void)
> @@ -2647,3 +2649,12 @@ Aml *aml_error_device(void)
> =20
>      return dev;
>  }
> +
> +void qbus_build_aml(BusState *bus, Aml *scope)
> +{
> +    BusChild *kid;
> +
> +    QTAILQ_FOREACH(kid, &bus->children, sibling) {
> +        call_dev_aml_func(DEVICE(kid->child), scope);
> +    }
> +}


