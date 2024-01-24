Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD12C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 07:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSY0w-0000TJ-W7; Wed, 24 Jan 2024 02:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1rSY0u-0000Sw-MB
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:49:36 -0500
Received: from smtpout2.mo529.mail-out.ovh.net ([79.137.123.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1rSY0s-0004BL-T5
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:49:36 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.176.217])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id D268C1FE80;
 Wed, 24 Jan 2024 07:49:28 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 08:49:28 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004ea801654-e808-4f91-a435-c88f77206fc8,
 0ED406C19502FBF3C2DC2EF69BD13A9A4E04451C) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Wed, 24 Jan 2024 08:49:27 +0100
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Christian
 Schoenebeck" <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>, "Richard
 Henderson" <richard.henderson@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH 2/6] hw/9pfs/9p-synth: Use RCU_READ macro
Message-ID: <20240124084927.60214dc7@bahia>
In-Reply-To: <20240124074201.8239-3-philmd@linaro.org>
References: <20240124074201.8239-1-philmd@linaro.org>
 <20240124074201.8239-3-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 6b593415-a42f-4d0a-b5b4-a120d5df6e35
X-Ovh-Tracer-Id: 13909367451474303410
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepueeuieejtdelleeutdfhteejffeiteffueevffeffeetvdeifeeujefgudegteeunecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutddupdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehgrhhouhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpphgsohhniihinhhisehrvgguhhgrthdrtghomhdpqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhfrghmsegvuhhphhhonhdrnhgvthdprhhitghhrghrugdrhhgvnhguvghrshhonheslhhinhgrrhhordhorhhgpdhmshhtsehrvgguhhgrthdrtghomhdpkhhrrgigvghlsehrvgguhhgrthdrtghomhdprghlvgigrdifihhllhhirg
 hmshhonhesrhgvughhrghtrdgtohhmpdgtlhhgsehrvgguhhgrthdrtghomhdpoffvtefjohhsthepmhhohedvledpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout2.mo529.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 24 Jan 2024 08:41:57 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Replace the manual rcu_read_(un)lock calls by the
> WITH_RCU_READ_LOCK_GUARD macro (See commit ef46ae67ba
> "docs/style: call out the use of GUARD macros").
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/9pfs/9p-synth.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>=20

Acked-by: Greg Kurz <groug@kaod.org>

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



--=20
Greg

