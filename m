Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F2C606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U905zsen
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3Qe-0003Ac-CM; Tue, 20 Oct 2026 02:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3QT-00039H-PV
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3QP-0007y7-9z
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792478056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gk+j2kR35WV9CWofDpkz9kXmkcILoVecBlFatEbCoas=;
 b=U905zsenW/ZMcAzUqlbRip3Gk89Q02Q0gawaMC+LTdM0La5n/wb5refMJMX7LFtA6NBbJ7
 piXIMnhGmzPK/eXhGpiryafY4bu18UNQi5U3bOBtjU1XbOBEGYp68Fee1PawjarUs6RgQH
 HtToGGvEVY4mPGGE+7uOnFhDHXiMvb8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-GkHt51huNqGdOudy-DVCkA-1; Tue,
 20 Oct 2026 06:34:13 +0000
X-MC-Unique: GkHt51huNqGdOudy-DVCkA-1
X-Mimecast-MFC-AGG-ID: GkHt51huNqGdOudy-DVCkA_1792478052
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3171195604C; Tue, 20 Oct 2026 06:34:11 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20DA341B; Tue, 20 Oct 2026 06:34:10 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 20/65] qom: convert struct properties to QAPI-aware
 registration
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, michael.roth@amd.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 kkostiuk@redhat.com, alistair.francis@wdc.com, amachhiw@linux.ibm.com
In-Reply-To: <20261019141929.1594337-21-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
 <20261019141929.1594337-21-armbru@redhat.com>
Date: Tue, 20 Oct 2026 10:33:32 +0400
Message-Id: <179247801298.2782576.16099849941002810961.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10034;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oV1q7UXooUMKqUp5p4BX4CSrL8EYc14YXT22+hfeOmI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq1wtCalJMagWifiYnu1HnB1QJuy6x6kdqWjNKx
 aPTvPFsex6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatcLQgAKCRDa6OEJdZac
 5aYfD/9/bQqt8ArCP+Z/wUndD5G9zH7JkkrqLkA7BVupMLHXU650HRnIZUC2CrX8RYRaTJf25Ty
 XrgEsNth2/lz4n4bpT0gM3hZpVzCiwS7jJ0quR5qK4d0qBBo77Cw1yAXBO+f9alNVKPhdU31N2h
 9MYFFz0rC5qAeco+FR7CVaVk14ElWe6htX8bKiBYaMWV5KjKenxB8JBrplylciZoE1gRyUjzMlT
 z7SvzGWHMAK5ZFudSY6bLAkoNYKuXpuIQzctiazXPSI5hvfn1Dc8VYe2wreE+5djlKkce+RRCDs
 ikn8yA9VUlwK2EGEqy/W2CJGzYErIbo3u7GjA9iyuxGQGXL4wBEW59WYWQFQQo4KIYPKBv/weuT
 ov6z5OWvUiEFyFHu6rTVuT8ZzwOnT1p2jAMIcISNmOJ/etFc2e9A/fonjHe77WpxliMJZLcm8/U
 RhFb/ZuS65rVXMGjL5ZlWKluPEclNAqb6LI1AoSgmkAhh3Xt6qbVkgsyBeh/+7uUtN/IQO0zNLO
 luj9GwoPIS6Fpf8JksJ2aNcyh7DWeQ3cYw2HfTdVkA3GzU2VkWA1KXU2Vg5VUwJR9+MSrtUw158
 /yywWzGnKUsVuLl0a62fVOXPi4+vheqcJcWe9LiHeq11vE40935/rUFOxJs5/wHhtRxQOVH8n+s
 iZ56vX+xwJ8Lquw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Convert all callers of object_property_add() and
> object_class_property_add() that register struct-typed properties with
> QAPI visitor-based getters/setters to use object_property_add_qapi() and
> object_class_property_add_qapi() instead.
> 
> This replaces the manual string type name with a reference to the
> generated QAPITypeInfo constant, enabling QMP introspection to report
> accurate QAPI type information for struct properties. Existing
> getters/setters are preserved unchanged.
> 
> The cxl-fmw property type is corrected from "CXLFixedMemoryWindow"
> (not a real QAPI type) to "CXLFixedMemoryWindowOptions".
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-ID: <20261019141929.1594337-21-armbru@redhat.com>
> ---
>  authz/list.c              |  2 +-
>  block/throttle-groups.c   |  5 +++--
>  chardev/char-socket.c     |  3 ++-
>  hw/core/machine.c         | 11 +++++++----
>  hw/cxl/cxl-host.c         |  4 +++-
>  hw/remote/vfio-user-obj.c |  5 +++--
>  hw/vfio-user/pci.c        |  5 +++--
>  target/i386/cpu.c         | 11 ++++++++---
>  target/i386/kvm/tdx.c     |  4 +++-
>  target/s390x/cpu-system.c |  4 +++-
>  10 files changed, 36 insertions(+), 18 deletions(-)
>
> diff --git a/authz/list.c b/authz/list.c
> index 363b2ee12c98..ed3d346004c2 100644
> --- a/authz/list.c
> +++ b/authz/list.c
> @@ -128,7 +128,7 @@ qauthz_list_class_init(ObjectClass *oc, const void *data)
>          .set = qauthz_list_prop_set_policy,
>      ));
>  
> -    object_class_property_add(oc, "rules", "QAuthZListRule",
> +    object_class_property_add_qapi(oc, "rules", &QAuthZListRule_type_info,

It should be actually &QAuthZListRuleList_type_info

>                                qauthz_list_prop_get_rules,
>                                qauthz_list_prop_set_rules,
>                                NULL, NULL);
> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index 37814b84fe09..987867477acc 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -31,6 +31,7 @@
>  #include "qemu/thread.h"
>  #include "system/qtest.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-type-infos-block-core.h"
>  #include "qapi/qapi-visit-block-core.h"
>  #include "qom/object.h"
>  #include "qom/object_interfaces.h"
> @@ -993,8 +994,8 @@ static void throttle_group_obj_class_init(ObjectClass *klass,
>      }
>  
>      /* ThrottleLimits */
> -    object_class_property_add(klass,
> -                              "limits", "ThrottleLimits",
> +    object_class_property_add_qapi(klass,
> +                              "limits", &ThrottleLimits_type_info,
>                                throttle_group_get_limits,
>                                throttle_group_set_limits,
>                                NULL, NULL);
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 81bac42a1587..8e0e5d4343aa 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -31,6 +31,7 @@
>  #include "qemu/option.h"
>  #include "qapi/error.h"
>  #include "qapi/clone-visitor.h"
> +#include "qapi/qapi-type-infos-sockets.h"
>  #include "qapi/qapi-visit-sockets.h"
>  #include "qemu/yank.h"
>  #include "trace.h"
> @@ -1568,7 +1569,7 @@ static void char_socket_class_init(ObjectClass *oc, const void *data)
>      cc->chr_listener_cleanup = tcp_chr_listener_cleanup;
>      cc->chr_get_filename = tcp_chr_get_filename;
>  
> -    object_class_property_add(oc, "addr", "SocketAddress",
> +    object_class_property_add_qapi(oc, "addr", &SocketAddress_type_info,
>                                char_socket_get_addr, NULL,
>                                NULL, NULL);
>  
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index d9ac4b419a36..94737e17e66f 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -18,6 +18,7 @@
>  #include "hw/core/loader.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-type-infos-machine.h"
>  #include "qapi/qapi-visit-machine.h"
>  #include "qapi/qapi-commands-machine.h"
>  #include "qemu/madvise.h"
> @@ -1118,19 +1119,20 @@ static void machine_class_init(ObjectClass *oc, const void *data)
>      object_class_property_set_description(oc, "dumpdtb",
>          "Dump current dtb to a file and quit");
>  
> -    object_class_property_add(oc, "boot", "BootConfiguration",
> +    object_class_property_add_qapi(oc, "boot", &BootConfiguration_type_info,
>          machine_get_boot, machine_set_boot,
>          NULL, NULL);
>      object_class_property_set_description(oc, "boot",
>          "Boot configuration");
>  
> -    object_class_property_add(oc, "smp", "SMPConfiguration",
> +    object_class_property_add_qapi(oc, "smp", &SMPConfiguration_type_info,
>          machine_get_smp, machine_set_smp,
>          NULL, NULL);
>      object_class_property_set_description(oc, "smp",
>          "CPU topology");
>  
> -    object_class_property_add(oc, "smp-cache", "SmpCachePropertiesWrapper",
> +    object_class_property_add_qapi(oc, "smp-cache",
> +        &SmpCachePropertiesWrapper_type_info,
>          machine_get_smp_cache, machine_set_smp_cache, NULL, NULL);
>      object_class_property_set_description(oc, "smp-cache",
>          "Cache properties list for SMP machine");
> @@ -1212,7 +1214,8 @@ static void machine_class_init(ObjectClass *oc, const void *data)
>                                            "Set RAM backend"
>                                            "Valid value is ID of hostmem based backend");
>  
> -    object_class_property_add(oc, "memory", "MemorySizeConfiguration",
> +    object_class_property_add_qapi(oc, "memory",
> +        &MemorySizeConfiguration_type_info,
>          machine_get_mem, machine_set_mem,
>          NULL, NULL);
>      object_class_property_set_description(oc, "memory",
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index e279ce5fe3ae..41b1ee58bbf3 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -13,6 +13,7 @@
>  #include "system/qtest.h"
>  #include "hw/core/boards.h"
>  
> +#include "qapi/qapi-type-infos-machine.h"
>  #include "qapi/qapi-visit-machine.h"
>  #include "hw/cxl/cxl.h"
>  #include "hw/cxl/cxl_host.h"
> @@ -616,7 +617,8 @@ void cxl_machine_init(Object *obj, CXLState *state)
>                                      "Set on/off to enable/disable "
>                                      "CXL instantiation");
>  
> -    object_property_add(obj, "cxl-fmw", "CXLFixedMemoryWindow",
> +    object_property_add_qapi(obj, "cxl-fmw",
> +                        &CXLFixedMemoryWindowOptions_type_info,

here &CXLFixedMemoryWindowOptionsList_type_info

>                          machine_get_cfmw, machine_set_cfmw,
>                          NULL, state);
>      object_property_set_description(obj, "cxl-fmw",
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index a0498d218faf..7e6819f670b5 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -47,6 +47,7 @@
>  #include "hw/core/boards.h"
>  #include "hw/remote/machine.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-type-infos-sockets.h"
>  #include "qapi/qapi-visit-sockets.h"
>  #include "qapi/qapi-events-misc.h"
>  #include "qemu/notify.h"
> @@ -931,8 +932,8 @@ static void vfu_object_class_init(ObjectClass *klass, const void *data)
>  
>      k->nr_devs = 0;
>  
> -    object_class_property_add(klass, "socket", "SocketAddress", NULL,
> -                              vfu_object_set_socket, NULL, NULL);
> +    object_class_property_add_qapi(klass, "socket", &SocketAddress_type_info,
> +                              NULL, vfu_object_set_socket, NULL, NULL);
>      object_class_property_set_description(klass, "socket",
>                                            "SocketAddress "
>                                            "(ex: type=unix,path=/tmp/sock). "
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index 983e1d4ad470..f58c4a0f3965 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -8,6 +8,7 @@
>  
>  #include "qemu/osdep.h"
>  #include <sys/ioctl.h>
> +#include "qapi/qapi-type-infos-sockets.h"
>  #include "qapi-visit-sockets.h"
>  #include "qemu/error-report.h"
>  
> @@ -471,8 +472,8 @@ static void vfio_user_pci_class_init(ObjectClass *klass, const void *data)
>      device_class_set_legacy_reset(dc, vfio_user_pci_reset);
>      device_class_set_props(dc, vfio_user_pci_properties);
>  
> -    object_class_property_add(klass, "socket", "SocketAddress", NULL,
> -                              vfio_user_pci_set_socket, NULL, NULL);
> +    object_class_property_add_qapi(klass, "socket", &SocketAddress_type_info,
> +                              NULL, vfio_user_pci_set_socket, NULL, NULL);
>      object_class_property_set_description(klass, "socket",
>                                            "SocketAddress (UNIX sockets only)");
>  
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 74eebeabd7a7..d15966062494 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -35,6 +35,8 @@
>  #include "sev.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> +#include "qapi/qapi-type-infos-machine.h"
> +#include "qapi/qapi-type-infos-run-state.h"
>  #include "qapi/qapi-visit-machine.h"
>  #include "standard-headers/asm-x86/kvm_para.h"
>  #include "hw/core/qdev-properties.h"
> @@ -10539,10 +10541,12 @@ static void x86_cpu_initfn(Object *obj)
>  
>      x86_cpu_init_default_topo(cpu);
>  
> -    object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
> +    object_property_add_qapi(obj, "feature-words",
> +                        &X86CPUFeatureWordInfo_type_info,


and &X86CPUFeatureWordInfoList_type_info

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


