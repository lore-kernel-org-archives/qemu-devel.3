Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB3FD74EFA
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 16:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjJqz-0005qB-8L; Fri, 23 Jan 2026 11:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vjJqi-0005mm-5c
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 11:17:37 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vjJqf-0001Fm-0g
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 11:17:27 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dyNNX6CwqzHnGkJ;
 Sat, 24 Jan 2026 00:16:44 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id CE7A740563;
 Sat, 24 Jan 2026 00:17:22 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Jan
 2026 16:17:22 +0000
Date: Fri, 23 Jan 2026 16:17:20 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>, "Cleber
 Rosa" <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 06/13] scripts/qmp_helper: add support for a timeout
 logic
Message-ID: <20260123161720.000063ea@huawei.com>
In-Reply-To: <3633cf168519ef0ad02c7e493865b0a20257b695.1769175069.git.mchehab+huawei@kernel.org>
References: <cover.1769175069.git.mchehab+huawei@kernel.org>
 <3633cf168519ef0ad02c7e493865b0a20257b695.1769175069.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 23 Jan 2026 14:35:20 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> We can't inject a new GHES record to the same source before
> it has been acked. There is an async mechanism to verify when
> the Kernel is ready, which is implemented at QEMU's ghes
> driver.
>=20
> If error inject is too fast, QEMU may return an error. When
> such errors occur, implement a retry mechanism, based on a
> maximum timeout.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
One comment where I think you intended to make a comment clearer.

Not important though
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  scripts/qmp_helper.py | 47 +++++++++++++++++++++++++++++++------------
>  1 file changed, 34 insertions(+), 13 deletions(-)
>=20
> diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
> index 1587492807fe..d5ffd51f161e 100755
> --- a/scripts/qmp_helper.py
> +++ b/scripts/qmp_helper.py
> @@ -14,6 +14,7 @@
> =20
>  from datetime import datetime
>  from os import path as os_path
> +from time import sleep
> =20
>  try:
>      qemu_dir =3D os_path.abspath(os_path.dirname(os_path.dirname(__file_=
_)))
> @@ -324,7 +325,8 @@ class qmp:
>      Opens a connection and send/receive QMP commands.
>      """
> =20
> -    def send_cmd(self, command, args=3DNone, may_open=3DFalse, return_er=
ror=3DTrue):
> +    def send_cmd(self, command, args=3DNone, may_open=3DFalse, return_er=
ror=3DTrue,
> +                 timeout=3DNone):
>          """Send a command to QMP, optinally opening a connection"""
> =20
>          if may_open:
> @@ -336,12 +338,31 @@ def send_cmd(self, command, args=3DNone, may_open=
=3DFalse, return_error=3DTrue):
>          if args:
>              msg['arguments'] =3D args
> =20
> -        try:
> -            obj =3D self.qmp_monitor.cmd_obj(msg)
> -        # Can we use some other exception class here?
> -        except Exception as e:                         # pylint: disable=
=3DW0718
> -            print(f"Command: {command}")
> -            print(f"Failed to inject error: {e}.")
> +        if timeout and timeout > 0:
> +            attempts =3D int(timeout * 10)
> +        else:
> +            attempts =3D 1
> +
> +        # Try up to attempts
=46rom v1 thread:
https://lore.kernel.org/qemu-devel/20260122171357.00000747@huawei.com/T/#m5=
e70aed9fca30a24106ca39196bcf935da745722

I thought plan was to update this message?

> +        for i in range(0, attempts):
> +            try:
> +                obj =3D self.qmp_monitor.cmd_obj(msg)



