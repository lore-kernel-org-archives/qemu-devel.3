Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA19C47E49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 13:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSd6V-000850-UX; Wed, 24 Jan 2024 08:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1rSd6S-00082P-UD
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:15:41 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1rSd6Q-0005WF-GD
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=c1iAhEM5d1m8JJrIm9rLS7yKHU+F9vmNlWCPnvr4dhA=; b=nNDSr/5/Y7t4xcfxQ3CNrMLJDk
 Zw1wdzf9p7iYCggnOWzgvf2ukfpBs9/KIr/yFU1BmNTywEbK6n/rp+6bEysiZfkM4cv155btV6uxU
 vzKzNr1lcWN9SyuovqQ4dN49WSlqXhhvNZKADb1YrCycn15iBtoKp8U3DNK1FUQKPsvbRjhma4B+r
 MODsNvM7rbHsIn++ZHHjcQMu1XHWfr0Gga28+4O8dwUhkPeKfuzk+igQ7JorC6sZ5z4stNMZm3M1t
 hCQMAKiCL1qcaI4SIm2V/pa7Y15hNNb3a5wMIJROhA8dH2ESF0pVQ3O6Ry28Jo1YQrPQ1EMo1jhAQ
 fwiZJWq2FAlOyp1UiIX23d1tpMAWkTZbrHypWgeio8Gb06rP9ohuqft4DVdYsYzX67x8YZsmuWWKZ
 IqFjIUNQKo5ZAGwtf5HCv+VommtR3zgaUel7DvBKZQ4fCV4PAL5H14Y7OS/LkH/IZu0EfW6fJ6BO7
 E+o0l24apptrROBIXmS3BfUpt0ScAic+eKCcYHw3qlYNeX1BHncgB7YkBPRagHVmv6rnED2wHeNTY
 6K16RePt8FcPaDgxwBjfO3C0Yh5aFYIsRcd4CCx291rT1yvyyMMxnYcWLIOzmTpIeCuxoyBIrksGV
 3e3gJxwtD75IzQIN853tNIGl54XZFbun2RDbP/Hpc=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>, Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/6] hw/9pfs/9p-synth: Use RCU_READ macro
Date: Wed, 24 Jan 2024 14:15:31 +0100
Message-ID: <6538277.BgTanuEaLT@silver>
In-Reply-To: <20240124074201.8239-3-philmd@linaro.org>
References: <20240124074201.8239-1-philmd@linaro.org>
 <20240124074201.8239-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wednesday, January 24, 2024 8:41:57 AM CET Philippe Mathieu-Daud=E9 wrot=
e:
> Replace the manual rcu_read_(un)lock calls by the
> WITH_RCU_READ_LOCK_GUARD macro (See commit ef46ae67ba
> "docs/style: call out the use of GUARD macros").
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---

Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

>  hw/9pfs/9p-synth.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index 0ac79a500b..419ea69e3a 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -241,15 +241,15 @@ static struct dirent *synth_get_dentry(V9fsSynthNod=
e *dir,
>      int i =3D 0;
>      V9fsSynthNode *node;
> =20
> -    rcu_read_lock();
> -    QLIST_FOREACH(node, &dir->child, sibling) {
> -        /* This is the off child of the directory */
> -        if (i =3D=3D off) {
> -            break;
> +    WITH_RCU_READ_LOCK_GUARD() {
> +        QLIST_FOREACH(node, &dir->child, sibling) {
> +            /* This is the off child of the directory */
> +            if (i =3D=3D off) {
> +                break;
> +            }
> +            i++;
>          }
> -        i++;
>      }
> -    rcu_read_unlock();
>      if (!node) {
>          /* end of directory */
>          return NULL;
> @@ -494,13 +494,13 @@ static int synth_name_to_path(FsContext *ctx, V9fsP=
ath *dir_path,
>          goto out;
>      }
>      /* search for the name in the children */
> -    rcu_read_lock();
> -    QLIST_FOREACH(node, &dir_node->child, sibling) {
> -        if (!strcmp(node->name, name)) {
> -            break;
> +    WITH_RCU_READ_LOCK_GUARD() {
> +        QLIST_FOREACH(node, &dir_node->child, sibling) {
> +            if (!strcmp(node->name, name)) {
> +                break;
> +            }
>          }
>      }
> -    rcu_read_unlock();
> =20
>      if (!node) {
>          errno =3D ENOENT;
>=20



