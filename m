Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25E3C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 16:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUU7R-0006hu-2A; Thu, 18 Jul 2024 12:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sUU7N-0006hJ-CV
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 12:36:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sUU7K-0004uB-Mm
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 12:36:33 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPz080hr9z6K9fn;
 Fri, 19 Jul 2024 00:34:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 0CF201400D3;
 Fri, 19 Jul 2024 00:36:16 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 17:36:15 +0100
Date: Thu, 18 Jul 2024 17:36:14 +0100
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
CC: <fan.ni@samsung.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH] mem/cxl_type3: Fix overlapping region validation error
Message-ID: <20240718173614.00006d13@Huawei.com>
In-Reply-To: <20240718090753.59163-1-yaoxt.fnst@fujitsu.com>
References: <20240718090753.59163-1-yaoxt.fnst@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Thu, 18 Jul 2024 05:07:53 -0400
Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:

> When injecting a new poisoned region through qmp_cxl_inject_poison(),
> the newly injected region should not overlap with existing poisoned
> regions.
>=20
> The current validation method does not consider the following
> overlapping region:
> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=
=94=90
> =E2=94=82a  =E2=94=82  b(a) =E2=94=82a  =E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=
=94=98
> (a is a newly added region, b is an existing region, and b is a
>  subregion of a)
>=20
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Looks correct to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
I've queued it on my local branch.
I need to put together an updated public one.

No huge rush to queue this up though I think as the effects
are minor.

Jonathan

> ---
>  hw/mem/cxl_type3.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 35ac59883a5b..8e32de327908 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1331,9 +1331,7 @@ void qmp_cxl_inject_poison(const char *path, uint64=
_t start, uint64_t length,
>      ct3d =3D CXL_TYPE3(obj);
> =20
>      QLIST_FOREACH(p, &ct3d->poison_list, node) {
> -        if (((start >=3D p->start) && (start < p->start + p->length)) ||
> -            ((start + length > p->start) &&
> -             (start + length <=3D p->start + p->length))) {
> +        if ((start < p->start + p->length) && (start + length > p->start=
)) {
>              error_setg(errp,
>                         "Overlap with existing poisoned region not suppor=
ted");
>              return;


