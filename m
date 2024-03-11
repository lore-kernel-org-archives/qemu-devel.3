Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8C3C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjzV-0006be-3G; Mon, 11 Mar 2024 14:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rjjzS-0006T6-1E
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:03:11 -0400
Received: from out-177.mta0.migadu.com ([2001:41d0:1004:224b::b1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rjjzQ-00039r-EO
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:03:09 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1710180185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=532Bly24dAkPDfCh/ajEVhrTnlO4X5i2GXHVVlk7cuE=;
 b=pSjkLRS0CO1d0SJ3z3N4jvpr30OGuQYXNGNIoNJi1W0WuYdz7tuOqecdDqRsVMfSGKaR67
 traekH6tYbSsMAt8JnEnWMCq6tAa3M98iyJYCQbUT1CRYN6beIIUF7+h0IIvZs3WVqW/qp
 h+3seZ/bNfRSDgC443Ir9uiyYljFeKI=
Date: Mon, 11 Mar 2024 18:02:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: hao.xiang@linux.dev
Message-ID: <02ab6d811c5022b049f5dbea15396dca0c21b28d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v4 3/7] migration/multifd: Implement
 ram_save_target_page_multifd to handle multifd version of
 MigrationOps::ram_save_target_page.
To: "Peter Xu" <peterx@redhat.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
In-Reply-To: <Ze8FDnvkPtYNjCbk@x1n>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-4-hao.xiang@bytedance.com>
 <ZeV8WaKyKEfw-em-@x1n>
 <CAAYibXhCzozRhHxp2Dk3L9BMhFhZtqyvgbwkj+8ZGMCHURZGug@mail.gmail.com>
 <821fba91ac7c0d4cd481d91b8fc91c94304a677f@linux.dev>
 <Ze8FDnvkPtYNjCbk@x1n>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::b1;
 envelope-from=hao.xiang@linux.dev; helo=out-177.mta0.migadu.com
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

March 11, 2024 at 6:20 AM, "Peter Xu" <peterx@redhat.com> wrote:



>=20
>=20On Sat, Mar 09, 2024 at 02:06:33AM +0000, hao.xiang@linux.dev wrote:
>=20
>=20>=20
>=20> > @@ -1122,10 +1122,6 @@ static int save_zero_page(RAMState *rs, Pa=
geSearchStatus *pss,
> >=20
>=20>  > QEMUFile *file =3D pss->pss_channel;
> >=20
>=20>  > int len =3D 0;
> >=20
>=20>  >
> >=20
>=20>  > - if (migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_N=
ONE) {
> >=20
>=20>  > - return 0;
> >=20
>=20>  > - }
> >=20
>=20>  >=20
>=20>=20
>=20>  > We need to keep this to disable zero-page-detect on !multifd?
> >=20
>=20>=20=20
>=20>=20
>=20>  So if multifd is enabled, the new parameter takes effect. If multi=
fd is
> >=20
>=20>  not enabled, zero page checking will always be done in the main th=
read,
> >=20
>=20>  which is exactly the behavior it is now. I thought legacy migratio=
n is a
> >=20
>=20>  deprecated feature so I am trying to not add new stuff to it.
> >=20
>=20
> There's no plan to deprecate legacy migrations, I think there was a pla=
n to
>=20
>=20make multifd the default, but I don't yet think it all thorougly yet,=
 and
>=20
>=20even if it happens it doesn't mean we'll remove legacy migration code=
.
>=20
>=20When repost please still make sure this parameter works for both mult=
ifd
>=20
>=20and !multifd.
>=20
>=20Thanks,
>=20
>=20--=20
>=20
> Peter Xu


Sure. Fixed the issue now and reposted a new patchset.

>

