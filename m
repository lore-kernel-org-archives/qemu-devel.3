Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54AEC5475B
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 02:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rim6s-0000sB-U9; Fri, 08 Mar 2024 21:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rim6j-0000q9-R6
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 21:06:43 -0500
Received: from out-188.mta1.migadu.com ([95.215.58.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rim6g-0007o9-R0
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 21:06:41 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1709949996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pd08xPQhVaQ6pGBKUUmd8iemC2yjD7nMIhgWZ3CZ5CE=;
 b=kdBR5uKEU7u+hN5Hj/hcSUpq+tkPMjN8q5p9cqsq0VNyAgR4nWHDQglH1BrL6cwxz1h/K4
 lSWSnKuxlf5WlLWEMwxBwUz9WwdIqci0ZjVQ1QNTPT6j5IkuVUkG4/eEC9HTWbTcyd4tNH
 6GLo+T3poKbsg3dJIef4/3qCSu0eDvM=
Date: Sat, 09 Mar 2024 02:06:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: hao.xiang@linux.dev
Message-ID: <821fba91ac7c0d4cd481d91b8fc91c94304a677f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v4 3/7] migration/multifd: Implement
 ram_save_target_page_multifd to handle multifd version of
 MigrationOps::ram_save_target_page.
To: peterx@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
In-Reply-To: <CAAYibXhCzozRhHxp2Dk3L9BMhFhZtqyvgbwkj+8ZGMCHURZGug@mail.gmail.com>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-4-hao.xiang@bytedance.com>
 <ZeV8WaKyKEfw-em-@x1n>
 <CAAYibXhCzozRhHxp2Dk3L9BMhFhZtqyvgbwkj+8ZGMCHURZGug@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.188; envelope-from=hao.xiang@linux.dev;
 helo=out-188.mta1.migadu.com
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

>=20
>=20On Sun, Mar 3, 2024 at 11:46 PM Peter Xu <peterx@redhat.com> wrote:
>=20
>=20>=20
>=20> On Fri, Mar 01, 2024 at 02:28:25AM +0000, Hao Xiang wrote:
> >=20
>=20>  1. Add a dedicated handler for MigrationOps::ram_save_target_page =
in
> >=20
>=20>  multifd live migration.
> >=20
>=20>  2. Refactor ram_save_target_page_legacy so that the legacy and mul=
tifd
> >=20
>=20>  handlers don't have internal functions calling into each other.
> >=20
>=20>  Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> >=20
>=20>  Reviewed-by: Fabiano Rosas <farosas@suse.de>
> >=20
>=20>  Message-Id: <20240226195654.934709-4-hao.xiang@bytedance.com>
> >=20
>=20>  ---
> >=20
>=20>  migration/ram.c | 43 ++++++++++++++++++++++++++++++-------------
> >=20
>=20>  1 file changed, 30 insertions(+), 13 deletions(-)
> >=20
>=20>  diff --git a/migration/ram.c b/migration/ram.c
> >=20
>=20>  index e1fa229acf..f9d6ea65cc 100644
> >=20
>=20>  --- a/migration/ram.c
> >=20
>=20>  +++ b/migration/ram.c
> >=20
>=20>  @@ -1122,10 +1122,6 @@ static int save_zero_page(RAMState *rs, Pag=
eSearchStatus *pss,
> >=20
>=20>  QEMUFile *file =3D pss->pss_channel;
> >=20
>=20>  int len =3D 0;
> >=20
>=20>  - if (migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_NON=
E) {
> >=20
>=20>  - return 0;
> >=20
>=20>  - }
> >=20
>=20>  We need to keep this to disable zero-page-detect on !multifd?

So if multifd is enabled, the new parameter takes effect. If multifd is n=
ot enabled, zero page checking will always be done in the main thread, wh=
ich is exactly the behavior it is now. I thought legacy migration is a de=
precated feature so I am trying to not add new stuff to it.

> >=20
>=20>  -
> >=20
>=20>  if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
> >=20
>=20>  return 0;
> >=20
>=20>  }
> >=20
>=20>  @@ -2045,7 +2041,6 @@ static bool save_compress_page(RAMState *rs,=
 PageSearchStatus *pss,
> >=20
>=20>  */
> >=20
>=20>  static int ram_save_target_page_legacy(RAMState *rs, PageSearchSta=
tus *pss)
> >=20
>=20>  {
> >=20
>=20>  - RAMBlock *block =3D pss->block;
> >=20
>=20>  ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
> >=20
>=20>  int res;
> >=20
>=20>  @@ -2061,17 +2056,34 @@ static int ram_save_target_page_legacy(RAM=
State *rs, PageSearchStatus *pss)
> >=20
>=20>  return 1;
> >=20
>=20>  }
> >=20
>=20>  + return ram_save_page(rs, pss);
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  +/**
> >=20
>=20>  + * ram_save_target_page_multifd: send one target page to multifd =
workers
> >=20
>=20>  + *
> >=20
>=20>  + * Returns 1 if the page was queued, -1 otherwise.
> >=20
>=20>  + *
> >=20
>=20>  + * @rs: current RAM state
> >=20
>=20>  + * @pss: data about the page we want to send
> >=20
>=20>  + */
> >=20
>=20>  +static int ram_save_target_page_multifd(RAMState *rs, PageSearchS=
tatus *pss)
> >=20
>=20>  +{
> >=20
>=20>  + RAMBlock *block =3D pss->block;
> >=20
>=20>  + ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BIT=
S;
> >=20
>=20>  +
> >=20
>=20>  /*
> >=20
>=20>  - * Do not use multifd in postcopy as one whole host page should b=
e
> >=20
>=20>  - * placed. Meanwhile postcopy requires atomic update of pages, so=
 even
> >=20
>=20>  - * if host page size =3D=3D guest page size the dest guest during=
 run may
> >=20
>=20>  - * still see partially copied pages which is data corruption.
> >=20
>=20>  + * Backward compatibility support. While using multifd live
> >=20
>=20>  We can also avoid mentioning "compatibility support" here - it's a
> >=20
>=20>  parameter, user can legally set it to anything.

Will drop that.

> >=20
>=20>  + * migration, we still need to handle zero page checking on the
> >=20
>=20>  + * migration main thread.
> >=20
>=20>  */
> >=20
>=20>  - if (migrate_multifd() && !migration_in_postcopy()) {
> >=20
>=20>  - return ram_save_multifd_page(block, offset);
> >=20
>=20>  + if (migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_LEG=
ACY) {
> >=20
>=20>  + if (save_zero_page(rs, pss, offset)) {
> >=20
>=20>  + return 1;
> >=20
>=20>  + }
> >=20
>=20>  }
> >=20
>=20>  - return ram_save_page(rs, pss);
> >=20
>=20>  + return ram_save_multifd_page(block, offset);
> >=20
>=20>  }
> >=20
>=20>  /* Should be called before sending a host page */
> >=20
>=20>  @@ -2983,7 +2995,12 @@ static int ram_save_setup(QEMUFile *f, void=
 *opaque)
> >=20
>=20>  }
> >=20
>=20>  migration_ops =3D g_malloc0(sizeof(MigrationOps));
> >=20
>=20>  - migration_ops->ram_save_target_page =3D ram_save_target_page_leg=
acy;
> >=20
>=20>  +
> >=20
>=20>  + if (migrate_multifd()) {
> >=20
>=20>  + migration_ops->ram_save_target_page =3D ram_save_target_page_mul=
tifd;
> >=20
>=20>  + } else {
> >=20
>=20>  + migration_ops->ram_save_target_page =3D ram_save_target_page_leg=
acy;
> >=20
>=20>  + }
> >=20
>=20>  bql_unlock();
> >=20
>=20>  ret =3D multifd_send_sync_main();
> >=20
>=20>  --
> >=20
>=20>  2.30.2
> >=20
>=20>  --
> >=20
>=20>  Peter Xu
> >
>

