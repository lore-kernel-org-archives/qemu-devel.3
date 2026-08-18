Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C185EC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQKC-0001er-Tl; Tue, 18 Aug 2026 16:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwQKA-0001eT-K0
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwQK8-0001Xp-MV
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787084536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGABP0knMNio4VzmlCxysKTZNYO7d574Ba2utQOCq8U=;
 b=MRSqBxCQYnb8Pl/gbeOknefUcKa60ZJjt9nHeMoeezb+GvcC0dVr7vxXlC4NlL2QRsC2Is
 qwPHUuuH8e1mULThOBa6hLZ3QPPs9tKVjjAOH0wddXH8l/74KO4b0QI7grJ4OzuBefz9F6
 VPGDqUdlAnFv6zrbVZ+7YY5ph8HBJeQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-EUrjB-NzPYydN_jg2KUneQ-1; Tue,
 18 Aug 2026 16:22:11 -0400
X-MC-Unique: EUrjB-NzPYydN_jg2KUneQ-1
X-Mimecast-MFC-AGG-ID: EUrjB-NzPYydN_jg2KUneQ_1787084530
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6A4D19560A7; Tue, 18 Aug 2026 20:22:10 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D003423; Tue, 18 Aug 2026 20:22:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 24/32] hw/net: mark most non-virtio NICs as insecure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20250926140144.1998694-25-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-25-berrange@redhat.com>
Date: Wed, 19 Aug 2026 00:21:49 +0400
Message-Id: <178708450916.1320462.4504261233231347825.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7259;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=v4wX5+pWv8MUKi6Fw+8XFXXu4WFgVaE4Wpq4Mbd3KIU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhL7gxpTMTD/IboyKa7cl+F7kk5mnnD4Ib+NIB
 N0bnyrE6hSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoS+4AAKCRDa6OEJdZac
 5WnrD/41q4fHL8xJ/bZ+1jUgiSoq0uJCAfUXpLbox+QA0g0QYGJRT+IioEBDGeEJ1MBDvc28cdg
 fRNkJMw2XTvLaISdwgtvJjsC583WbAoEStiOUaGlNJJAn8SuDsvCKNum2jZUutC4UOmjF5d6VdJ
 MvZWuTePzDRWYEkGXuZ0mO4/drUEI3D6D7pDd1Xzm89igsLx/Y/5WHWzux35+gNYAOIV8z+tjVD
 FdMflIbCXrbb4ui0HOmo8PUHE8PCSX34Ri3YYYrPv8NL1u3y2bcFVPIBNpoqzY4wMrMIuyMMawl
 RdZYD5k0IDn33XHBOmmHkBHh5yxR0+epHwUO+xYUAOpuZqqXz2IuOLLMlfDRx0+RHthVYA1Xt06
 Jh/pEixjNygn3EGhegjAI9PgIo2m9k/wxCCVY6WlKJIzhUvTwELztueuIXICgNGMNus1OPCFCCA
 3fW2QMxm/CiGJzU5rHDjh9BCQqqLV5VMBX6xqOjoZKTSD+Ec6HP+U+0wx4RbW+kNaZDMhD9CQkW
 6gJeTD2+2O4M/E10je2qBzgAjUOcw1fgagGXYaE0vg6eoSgwOYhXKDGsRy/IncL2SMj792gj9qu
 VrYLKQTxSJCBYGZ/+67+DC/75ltK3HJ8vOXH096y3/uSyIw6X1uvU8+cbwAlsD6j4Abdtm2Gbk6
 CKRHV4u9ZgLFmpQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

> Historically most NICs are only interesting for non-virtualization
> use cases and have not been written with malicious guests in mind.
> 
> As a general rule either virtio-net or xen-net should be used in
> all virtualized guests requiring a security boundary.
> 
> There are a handful of exceptions resulting from historical usage
> in the x86 world, to support virtualized guests lacking virtio
> support.
> 
> Thus the rtl8139, e1000 & e1000e NICs are declared to provide a
> security boundary.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20250926140144.1998694-25-berrange@redhat.com>
>
> diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
> index 30a81576b4ce..b03a917aa3ae 100644
> --- a/hw/net/allwinner-sun8i-emac.c
> +++ b/hw/net/allwinner-sun8i-emac.c
> @@ -892,6 +892,7 @@ static const TypeInfo allwinner_sun8i_emac_info = {
>      .instance_size  = sizeof(AwSun8iEmacState),
>      .instance_init  = allwinner_sun8i_emac_init,
>      .class_init     = allwinner_sun8i_emac_class_init,
> +    .secure         = false,
>  };
>  
>  static void allwinner_sun8i_emac_register_types(void)
> diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
> index 77d089d9887a..836138bba370 100644
> --- a/hw/net/allwinner_emac.c
> +++ b/hw/net/allwinner_emac.c
> @@ -528,8 +528,9 @@ static const TypeInfo aw_emac_info = {
>      .name           = TYPE_AW_EMAC,
>      .parent         = TYPE_SYS_BUS_DEVICE,
>      .instance_size  = sizeof(AwEmacState),
> -    .instance_init   = aw_emac_init,
> +    .instance_init  = aw_emac_init,
>      .class_init     = aw_emac_class_init,
> +    .secure         = false,
>  };
>  
>  static void aw_emac_register_types(void)
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 44446666deb2..760e0d5e9985 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -1833,6 +1833,7 @@ static const TypeInfo gem_info = {
>      .instance_size  = sizeof(CadenceGEMState),
>      .instance_init = gem_init,
>      .class_init = gem_class_init,
> +    .secure   = false,
>  };
>  
>  static void gem_register_types(void)
> diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
> index be16769de29c..7764c29ced6e 100644
> --- a/hw/net/can/can_kvaser_pci.c
> +++ b/hw/net/can/can_kvaser_pci.c
> @@ -305,6 +305,7 @@ static const TypeInfo kvaser_pci_info = {
>      .instance_size = sizeof(KvaserPCIState),
>      .class_init    = kvaser_pci_class_init,
>      .instance_init = kvaser_pci_instance_init,
> +    .secure        = false,
>      .interfaces = (const InterfaceInfo[]) {
>          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>          { },
> diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
> index 44f3ba370dc2..3e1c5eda1981 100644
> --- a/hw/net/can/can_mioe3680_pci.c
> +++ b/hw/net/can/can_mioe3680_pci.c
> @@ -248,6 +248,7 @@ static const TypeInfo mioe3680_pci_info = {
>      .instance_size = sizeof(Mioe3680PCIState),
>      .class_init    = mioe3680_pci_class_init,
>      .instance_init = mioe3680_pci_instance_init,
> +    .secure        = false,
>      .interfaces = (const InterfaceInfo[]) {
>          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>          { },
> diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
> index 7296d63be794..964e074a3699 100644
> --- a/hw/net/can/can_pcm3680_pci.c
> +++ b/hw/net/can/can_pcm3680_pci.c
> @@ -249,6 +249,7 @@ static const TypeInfo pcm3680i_pci_info = {
>      .instance_size = sizeof(Pcm3680iPCIState),
>      .class_init    = pcm3680i_pci_class_init,
>      .instance_init = pcm3680i_pci_instance_init,
> +    .secure        = false,
>      .interfaces = (const InterfaceInfo[]) {
>          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>          { },
> diff --git a/hw/net/can/ctucan_pci.c b/hw/net/can/ctucan_pci.c
> index bed6785433e7..1530959ea8c9 100644
> --- a/hw/net/can/ctucan_pci.c
> +++ b/hw/net/can/ctucan_pci.c
> @@ -262,6 +262,7 @@ static const TypeInfo ctucan_pci_info = {
>      .instance_size = sizeof(CtuCanPCIState),
>      .class_init    = ctucan_pci_class_init,
>      .instance_init = ctucan_pci_instance_init,
> +    .secure        = false,
>      .interfaces = (const InterfaceInfo[]) {
>          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>          { },
> diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
> index 3eb111949f89..0073812e3c21 100644
> --- a/hw/net/can/xlnx-versal-canfd.c
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -2068,6 +2068,7 @@ static const TypeInfo canfd_info = {
>      .instance_size = sizeof(XlnxVersalCANFDState),
>      .class_init    = canfd_class_init,
>      .instance_init = canfd_init,
> +    .secure        = false,
>  };
>  
>  static void canfd_register_types(void)
> diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
> index ca9edd4a5b88..e859e447af2f 100644
> --- a/hw/net/can/xlnx-zynqmp-can.c
> +++ b/hw/net/can/xlnx-zynqmp-can.c
> @@ -1194,6 +1194,7 @@ static const TypeInfo can_info = {
>      .instance_size = sizeof(XlnxZynqMPCANState),
>      .class_init    = xlnx_zynqmp_can_class_init,
>      .instance_init = xlnx_zynqmp_can_init,
> +    .secure        = false,
>  };
>  
>  static void can_register_types(void)
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index d49032059bb1..b508b6f77979 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -956,6 +956,7 @@ static const TypeInfo dp8393x_info = {
>      .instance_size = sizeof(dp8393xState),
>      .instance_init = dp8393x_instance_init,
>      .class_init    = dp8393x_class_init,
> +    .secure        = false,
>  };
>  
>  static void dp8393x_register_types(void)
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index a80a7b0cdb40..684350557f20 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -1759,6 +1759,7 @@ static void e1000_register_types(void)
>          type_info.parent = TYPE_E1000_BASE;
>          type_info.class_data = info;
>          type_info.class_init = e1000_class_init;
> +        type_info.secure = true,

, -> ;

>  
>          type_register_static(&type_info);
>      }
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index 89e6d52ba0f2..83cf3cf643a7 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -721,6 +721,7 @@ static const TypeInfo e1000e_info = {
>      .instance_size = sizeof(E1000EState),
>      .class_init = e1000e_class_init,
>      .instance_init = e1000e_instance_init,
> +    .secure = true,
>      .interfaces = (const InterfaceInfo[]) {
>          { INTERFACE_PCIE_DEVICE },
>          { }
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index d47df5a97fd1..3bc232d3c2a6 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -2094,6 +2094,7 @@ static void eepro100_register_types(void)
>          type_info.class_init = eepro100_class_init;
>          type_info.instance_size = sizeof(EEPRO100State);
>          type_info.instance_init = eepro100_instance_init;
> +        type_info.secure   = false,

same

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


