Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3AFD37485
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 13:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1QMa-00037O-9w; Thu, 17 Oct 2024 09:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t1QMY-000372-5z; Thu, 17 Oct 2024 09:16:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t1QMW-0003AR-DX; Thu, 17 Oct 2024 09:16:21 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTpBl0XCzz6LDG1;
 Thu, 17 Oct 2024 21:11:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id A46701400C9;
 Thu, 17 Oct 2024 21:16:14 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 15:16:13 +0200
Date: Thu, 17 Oct 2024 14:16:11 +0100
To: Zhao Liu <zhao1.liu@intel.com>
CC: "Daniel P =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Ma?=
 =?ISO-8859-1?Q?thieu-Daud=E9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, "Michael S.Tsirkin " <mst@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eric Blake <eblake@redhat.com>, "Markus
 Armbruster" <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, <qemu-devel@nongnu.org>,
 <kvm@vger.kernel.org>, <qemu-riscv@nongnu.org>, <qemu-arm@nongnu.org>,
 "Zhenyu Wang" <zhenyu.z.wang@intel.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v3 7/7] i386/cpu: add has_caches flag to check smp_cache
 configuration
Message-ID: <20241017141611.00007566@Huawei.com>
In-Reply-To: <20241012104429.1048908-8-zhao1.liu@intel.com>
References: <20241012104429.1048908-1-zhao1.liu@intel.com>
 <20241012104429.1048908-8-zhao1.liu@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.174.164]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RESEND as rejected by server (header issue, hopefully fixed)

On Sat, 12 Oct 2024 18:44:29 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> From: Alireza Sanaee <alireza.sanaee@huawei.com>
> 
> Add has_caches flag to SMPCompatProps, which helps in avoiding
> extra checks for every single layer of caches in x86 (and ARM in
> future).
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Note: Picked from Alireza's series with the changes:
>  * Moved the flag to SMPCompatProps with a new name "has_caches".
>    This way, it remains consistent with the function and style of
>    "has_clusters" in SMPCompatProps.
>  * Dropped my previous TODO with the new flag.
> ---
> Changes since Patch v2:
>  * Picked a new patch frome Alireza's ARM smp-cache series.
> ---
>  hw/core/machine-smp.c | 2 ++
>  include/hw/boards.h   | 3 +++
>  target/i386/cpu.c     | 9 ++++-----
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index f3edbded2e7b..16e456678cb6 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -367,6 +367,8 @@ bool machine_parse_smp_cache(MachineState *ms,
>          return false;
>      }
>  
> +    mc->smp_props.has_caches = true;
> +
>      return true;
>  }
>  
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index e4a1035e3fa1..af62b09c89d1 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -153,6 +153,8 @@ typedef struct {
>   * @modules_supported - whether modules are supported by the machine
>   * @cache_supported - whether cache (l1d, l1i, l2 and l3) configuration are
>   *                    supported by the machine
> + * @has_caches - whether cache properties are explicitly specified in the
> + *               user provided smp-cache configuration
>   */
>  typedef struct {
>      bool prefer_sockets;
> @@ -163,6 +165,7 @@ typedef struct {
>      bool drawers_supported;
>      bool modules_supported;
>      bool cache_supported[CACHE_LEVEL_AND_TYPE__MAX];
> +    bool has_caches;
>  } SMPCompatProps;
>  
>  /**
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c8a04faf3764..6f711e98b527 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7853,12 +7853,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>  
>  #ifndef CONFIG_USER_ONLY
>      MachineState *ms = MACHINE(qdev_get_machine());
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>  
> -    /*
> -     * TODO: Add a SMPCompatProps.has_caches flag to avoid useless Updates
> -     * if user didn't set smp_cache.
> -     */
> -    x86_cpu_update_smp_cache_topo(ms, cpu);
> +    if (mc->smp_props.has_caches) {
> +        x86_cpu_update_smp_cache_topo(ms, cpu);
> +    }
>  
>      qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
>  


