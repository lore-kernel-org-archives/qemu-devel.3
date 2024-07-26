Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444D4C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 10:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXIOa-00060M-19; Fri, 26 Jul 2024 06:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXIOY-0005z0-AN
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 06:41:54 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXIOV-0001eb-Fm
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 06:41:54 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVkm06B4lz6K8rl;
 Fri, 26 Jul 2024 18:40:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 9D959140B2F;
 Fri, 26 Jul 2024 18:41:44 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 11:41:44 +0100
Date: Fri, 26 Jul 2024 11:41:43 +0100
To: Hendrik Wuethrich <whendrik@google.com>
CC: <qemu-devel@nongnu.org>, <eduardo@habkost.net>,
 <richard.henderson@linaro.org>, <marcel.apfelbaum@gmail.com>,
 <mst@redhat.com>, <pbonzini@redhat.com>, <peternewman@google.com>
Subject: Re: [PATCH v1 3/9] Add init and realize funciontality for RDT device.
Message-ID: <20240726114143.0000154e@Huawei.com>
In-Reply-To: <20240719162929.1197154-4-whendrik@google.com>
References: <20240719162929.1197154-1-whendrik@google.com>
 <20240719162929.1197154-4-whendrik@google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 19 Jul 2024 16:29:23 +0000
Hendrik Wuethrich <whendrik@google.com> wrote:

> From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>
>=20
> Add code to initialize all necessary state for the RDT device.
>=20
> Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
> ---
>  hw/i386/rdt.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
> index cf246ab835..259dafc963 100644
> --- a/hw/i386/rdt.c
> +++ b/hw/i386/rdt.c
> @@ -62,10 +62,38 @@ static void rdt_init(Object *obj)
> =20
>  static void rdt_realize(DeviceState *dev, Error **errp)
>  {
> +    CPUState *cs =3D first_cpu;
> +

No blank line here.

> +    RDTState *rdtDev =3D RDT(dev);

blank line here.

> +    rdtDev->rdtInstances =3D g_array_new(false, true, sizeof(RDTStateIns=
tance));
> +    g_array_set_size(rdtDev->rdtInstances, cs->nr_cores);
> +    CPU_FOREACH(cs) {
> +        RDTStateInstance *rdt =3D &g_array_index(rdtDev->rdtInstances, R=
DTStateInstance, cs->cpu_index);
> +
No blank line here. Also wrap this long line somewhere.

> +        X86CPU *cpu =3D X86_CPU(cs);
blank line here.

> +        rdt->rdtstate =3D rdtDev;
> +        cpu->rdt =3D rdt;
> +
> +        rdt->monitors =3D g_array_new(false, true, sizeof(RDTMonitor));
> +        rdt->rdtstate->allocations =3D g_array_new(false, true, sizeof(R=
DTAllocation));
> +
> +        g_array_set_size(rdt->monitors, rdtDev->rmids);
> +        g_array_set_size(rdt->rdtstate->allocations, rdtDev->rmids);

Are these g_array's going to change size? If not, why go through this dance=
 when
a simple pointer will do?


> +    }
>  }
> =20
>  static void rdt_finalize(Object *obj)
>  {
> +    CPUState *cs;
> +    RDTState *rdt =3D RDT(obj);
> +
> +    CPU_FOREACH(cs) {
> +        RDTStateInstance *rdtInstance =3D &g_array_index(rdt->rdtInstanc=
es, RDTStateInstance, cs->cpu_index);

Long line. Wrap that.  Worth running checkpatch which I think
will moan about things like this.



> +        g_array_free(rdtInstance->monitors, true);
> +        g_array_free(rdtInstance->rdtstate->allocations, true);
> +    }
> +
> +    g_array_free(rdt->rdtInstances, true);
>  }
> =20
>  static void rdt_class_init(ObjectClass *klass, void *data)


