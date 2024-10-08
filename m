Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95571CEF14A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 09:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy6s2-0004kj-37; Tue, 08 Oct 2024 05:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sy6rw-0004k3-Fd; Tue, 08 Oct 2024 05:51:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sy6rt-0001cp-Fz; Tue, 08 Oct 2024 05:51:03 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNB7q1w2sz6G9Mf;
 Tue,  8 Oct 2024 17:49:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 56C811402C6;
 Tue,  8 Oct 2024 17:50:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Oct
 2024 11:50:55 +0200
Date: Tue, 8 Oct 2024 10:50:53 +0100
To: Zhao Liu <zhao1.liu@intel.com>
CC: "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Ma?=
 =?ISO-8859-1?Q?thieu-Daud=E9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sergio Lopez <slp@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "Anthony
 PERARD" <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>, Eric Blake <eblake@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <qemu-arm@nongnu.org>,
 "Zhenyu Wang" <zhenyu.z.wang@intel.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [RFC v2 03/12] system/vl: Create CPU topology devices from CLI
 early
Message-ID: <20241008105053.000059ee@Huawei.com>
In-Reply-To: <20240919061128.769139-4-zhao1.liu@intel.com>
References: <20240919061128.769139-1-zhao1.liu@intel.com>
 <20240919061128.769139-4-zhao1.liu@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 19 Sep 2024 14:11:19 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> Custom topology will allow user to build CPU topology from CLI totally,
> and this replaces machine's default CPU creation process (*_init_cpus()
> in MachineClass.init()).
> 
> For the machine's initialization, there may be CPU dependencies in the
> remaining initialization after the CPU creation.
> 
> To address such dependencies, create the CPU topology device (including
> CPU devices) from the CLI earlier, so that the latter part of machine
> initialization can be separated after qemu_add_cli_devices_early().
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Other than question of type of category from previous patch this looks
fine to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

However, needs review from others more familiar with this code!
> ---
>  system/vl.c | 55 +++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 36 insertions(+), 19 deletions(-)
> 
> diff --git a/system/vl.c b/system/vl.c
> index c40364e2f091..8540454aa1c2 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1211,8 +1211,9 @@ static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
>  static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
>  {
>      DeviceState *dev;
> +    long *category = opaque;
>  
> -    dev = qdev_device_add(opts, NULL, errp);
> +    dev = qdev_device_add(opts, category, errp);
>      if (!dev && *errp) {
>          error_report_err(*errp);
>          return -1;
> @@ -2623,6 +2624,36 @@ static void qemu_init_displays(void)
>      }
>  }
>  
> +static void qemu_add_devices(long *category)
> +{
> +    DeviceOption *opt;
> +
> +    qemu_opts_foreach(qemu_find_opts("device"),
> +                      device_init_func, category, &error_fatal);
> +    QTAILQ_FOREACH(opt, &device_opts, next) {
> +        DeviceState *dev;
> +        loc_push_restore(&opt->loc);
> +        /*
> +         * TODO Eventually we should call qmp_device_add() here to make sure it
> +         * behaves the same, but QMP still has to accept incorrectly typed
> +         * options until libvirt is fixed and we want to be strict on the CLI
> +         * from the start, so call qdev_device_add_from_qdict() directly for
> +         * now.
> +         */
> +        dev = qdev_device_add_from_qdict(opt->opts, category,
> +                                         true, &error_fatal);
> +        object_unref(OBJECT(dev));
> +        loc_pop(&opt->loc);
> +    }
> +}
> +
> +static void qemu_add_cli_devices_early(void)
> +{
> +    long category = DEVICE_CATEGORY_CPU_DEF;
> +
> +    qemu_add_devices(&category);
> +}
> +
>  static void qemu_init_board(void)
>  {
>      /* process plugin before CPUs are created, but once -smp has been parsed */
> @@ -2631,6 +2662,9 @@ static void qemu_init_board(void)
>      /* From here on we enter MACHINE_PHASE_INITIALIZED.  */
>      machine_run_board_init(current_machine, mem_path, &error_fatal);
>  
> +    /* Create CPU topology device if any. */
> +    qemu_add_cli_devices_early();
> +
>      drive_check_orphaned();
>  
>      realtime_init();
> @@ -2638,8 +2672,6 @@ static void qemu_init_board(void)
>  
>  static void qemu_create_cli_devices(void)
>  {
> -    DeviceOption *opt;
> -
>      soundhw_init();
>  
>      qemu_opts_foreach(qemu_find_opts("fw_cfg"),
> @@ -2653,22 +2685,7 @@ static void qemu_create_cli_devices(void)
>  
>      /* init generic devices */
>      rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
> -    qemu_opts_foreach(qemu_find_opts("device"),
> -                      device_init_func, NULL, &error_fatal);
> -    QTAILQ_FOREACH(opt, &device_opts, next) {
> -        DeviceState *dev;
> -        loc_push_restore(&opt->loc);
> -        /*
> -         * TODO Eventually we should call qmp_device_add() here to make sure it
> -         * behaves the same, but QMP still has to accept incorrectly typed
> -         * options until libvirt is fixed and we want to be strict on the CLI
> -         * from the start, so call qdev_device_add_from_qdict() directly for
> -         * now.
> -         */
> -        dev = qdev_device_add_from_qdict(opt->opts, NULL, true, &error_fatal);
> -        object_unref(OBJECT(dev));
> -        loc_pop(&opt->loc);
> -    }
> +    qemu_add_devices(NULL);
>      rom_reset_order_override();
>  }
>  


