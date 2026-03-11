Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACA91125858
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Nng-0006cr-Ni; Wed, 11 Mar 2026 13:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0Nnd-0006Uz-0P; Wed, 11 Mar 2026 13:56:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0Nnb-0006yi-AZ; Wed, 11 Mar 2026 13:56:48 -0400
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWJN54GjMzHnGjB;
 Thu, 12 Mar 2026 01:56:37 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id B1EE14056F;
 Thu, 12 Mar 2026 01:56:45 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Mar
 2026 17:56:45 +0000
Date: Wed, 11 Mar 2026 17:56:43 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 56/65] hw/arm/virt: Remember CPU phandles rather than
 looking them up by name
Message-ID: <20260311175643.000040b4@huawei.com>
In-Reply-To: <20260223170212.441276-57-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-57-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 23 Feb 2026 17:02:03 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> In fdt_add_cpu_nodes(), we currently add phandles for each CPU node
> if we are going to add a topology description, and when we do, we
> re-look-up the phandle by node name when creating the topology
> description.
>=20
> For GICv5 we will also want to refer to the CPU phandles; so always
> add a phandle, and keep track of those phandles in the
> VirtMachineState so we don't have to look them up by name in the dtb
> every time.
>=20
> The phandle property is extra data in the final DTB, but only a tiny
> amount, so it's not worth trying to carefully track the conditions
> when we're going to need them so we only emit them when required.
>=20
> (We need to change the smp_cpus variable to unsigned because
> otherwise gcc thinks that we might be passing a negative number to
> g_new0() and produces an error:
>=20
> /usr/include/glib-2.0/glib/gmem.h:270:19: error: argument 1 range [184467=
44071562067968, 18446744073709551615] exceeds maximum object size 922337203=
6854775807 [-Werror=3Dalloc-size-larger-than=3D]
>   270 |             __p =3D g_##func##_n (__n, __s);                     =
 \
>       |                   ^~~~~~~~~~~~~~~~~~~~~~~
> /usr/include/glib-2.0/glib/gmem.h:332:57: note: in expansion of macro =E2=
=80=98_G_NEW=E2=80=99
>   332 | #define g_new0(struct_type, n_structs)                  _G_NEW (s=
truct_type, n_structs, malloc0)
>       |                                                         ^~~~~~
> ../../hw/arm/virt.c:469:25: note: in expansion of macro =E2=80=98g_new0=
=E2=80=99
>   469 |     vms->cpu_phandles =3D g_new0(uint32_t, smp_cpus);
>       |                         ^~~~~~
>=20
> )
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

