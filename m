Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAC9C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm61K-0001It-Ol; Tue, 21 Jul 2026 04:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wm61K-0001Il-13
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wm61I-0004Wn-3a
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784623207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1+3mmICKSXr7PfAtflwEbwDlN/hD/1oxnaHEUk7fiek=;
 b=LIaSeRqEmnM8H9wRvBQ7mGG4b34S4sO63T1A28NllvK5ZK5Ert89SeJnZDDMk+W6CfF7Hr
 j2zlKIq5kDytCWEQTWUwTvL2yd1rUSTPX5/oleDG+VnhfNoHOn2B84DziV4/NdDIj8U9mG
 3DhutsU11DAufTz+pYz+qZGUGCDu1IU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-aswJzXNtP1C_ywZ_TSy57w-1; Tue, 21 Jul 2026 04:40:05 -0400
X-MC-Unique: aswJzXNtP1C_ywZ_TSy57w-1
X-Mimecast-MFC-AGG-ID: aswJzXNtP1C_ywZ_TSy57w_1784623205
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca124bf0189so3302057a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:40:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784623204; cv=none;
 d=google.com; s=arc-20260327;
 b=g1P4i6LpMUh+iQp70dRSLZ1hzLWv/lmLj5scWMbxlkzX91ytIhdP7tIkVkjTMjsb1/
 +W9fPBFRhEsTNyrBZ4P6MSYUFfEMopH0OsbviCQpiiUQfs5wTRLMhxfq1sBNrw7MfVtK
 tEGlav6vzQzZfnCKGdUziOlMxibBgoz04PxFErPbP/ZZkzKlmJjfzP0UcfuBdJacwoVl
 T89nTfxepYAc7rNrVL5iCMYx8rPzwO7S/Ntn9ukedhBrgQSmcejt3I7kuZkeYDqbOwyv
 C1Qb7J7cxX6yzki0bZ/mhvIwFABxOw1b1akAajcS5uDnXy1yG3zk/Bpf7g+QJppfBnY2
 T5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1+3mmICKSXr7PfAtflwEbwDlN/hD/1oxnaHEUk7fiek=;
 fh=psxz2jTyB2Gkkq/pspSW/oHl41en5ZXIOFwATMgFy6c=;
 b=kgKyoJdw6zZBy9vtpkLhVMOqiEjR4cRzlqhYs8yJ9nvfwsuidVTvt4X8La1P9G1gRj
 DyYt8ypk7K286yg/sudlobWIeLkpRLDM7d6D6W/3hw6n+kXmDXMdmBtwhrhZjK2o7IEm
 cQ66l88uGoLNf75aXVX/bDbj2prEao64DvomXWe1KRnmpf8SSWhwCMMJUlNpVltRFDVd
 PqzAyvkuFgVHK06oLvsoafHpF7BQEaQCzzX6YLihfyDrPxApAe861hwQsxebYDcn4Ivi
 XQS2UGTy+M+zu5G+XFAVDnQik8pZdFwcGOD1DEluN0CzoIOQNTw8Ykmh/lF8nkUSAzoJ
 5bDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784623204; x=1785228004; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1+3mmICKSXr7PfAtflwEbwDlN/hD/1oxnaHEUk7fiek=;
 b=mKQmOPb6WdsrWEiUeGsbTlIwJ1J3T965k1BkhrJXdjNwbe1VGYO8NLNPko3BM0knBg
 ZOTldKbS0njghAp6sxc93dxDUsY0at430T04uhZ7zzxg7bZzmuZBfWaNSJWR3J4w8n0m
 LYQ8XejLZOWxYnLa6NJWzYLJEqyaYSfmWahaAfV3wcDvQU73Nc5SXKF0/7ECCCq/ZI6Y
 esxLoqPvwH1jq3ICGAStOzGBC3MIkZgpzf04G/s8XQl+INTyoAa3FOTUSIJ1fqJQyp3V
 0aegz+7rys/IWh5bjvbW/bhBbFLkIsQkLcd+WNhgdzZf58xNldbZKluAJtcNqgUCrjkJ
 EmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623204; x=1785228004;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1+3mmICKSXr7PfAtflwEbwDlN/hD/1oxnaHEUk7fiek=;
 b=bOxW8vIgYkcXY6cAuuqpWNQSOYyD2CMNvnjCbv8GRiBChdvoKporweqrCOWFjE6/62
 TJ3OH/jGQm2KSYhTzLer9eUSDhStbo3rzg1gkkvYRk5P5AD9Jr78npvU4jTnKNMfMFQB
 QzpEnm/ezr7VzBeCHM9eFm6ltRejrKHDPCun4hEeQGE6zk4Hzc0wtQGWcOIf0+Syxa02
 UzxICadkF5+aRRlPY7mA6Llof4cIT7G/RxpDs4Sg6cy9RV1OnwEyrmcU0KwwiqG/zh/r
 efLkHxELnEEUT7TjEDsNUGzdlXRRSMe+boiEa5xLX89ZvSB3hp0iAI68rIH5Fe5xHGhh
 XZng==
X-Gm-Message-State: AOJu0Yx/yJVYvJFagiwx5YluCUfNaVDwtrQHaMoMwzM1UCRafOvPoFdr
 5wo4dWhMLFkF1tpAmr8vjJMGSjG+R+64MLBXmlauEKlbI/46j8YcoT+hiBxFjXRooiH8Bq069ro
 jI8UasGClXFigZ0u+SmwL85Krf2dnuPxdHqT2NHw0OGfsqZz0YxjBr5Eibf/SjlEn9k7ss2Dq/r
 ju9c+Lk1KM7lbC6joaSXN5Y4IkxFGzLuQ=
X-Gm-Gg: AfdE7cnuuteb0BU6Sd8bCwqmMScsYvbWOEERgiYFajaJavJRhxldElGxUVrwfI2SFFJ
 oJeQH+75pskW8sikEK8UkpuGOOPYA55udMtI5fK6NKW+StbSyljS/Ax549cGCCSjptrqzTqirZY
 vTnnayPGKw84mEjI5w76oiYZJH0Xb1HOz320r7MnkV+6vqHZEfzNXRrBKvZbnHYbGe5BEXSvNAE
 I7aJ+WB9znv5DwAWSQll8v/fmj8H+CgnabTnSpem1j9cKC1TGwzk/xG/3O1dBeWR7tQt2241mJE
 VA==
X-Received: by 2002:a05:6a21:3e02:b0:3c3:d92b:29be with SMTP id
 adf61e73a8af0-3c3d92b29dfmr8974178637.25.1784623204579; 
 Tue, 21 Jul 2026 01:40:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:3e02:b0:3c3:d92b:29be with SMTP id
 adf61e73a8af0-3c3d92b29dfmr8974154637.25.1784623204145; Tue, 21 Jul 2026
 01:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
 <CAMxuvaySONs4r=1Bmsao1f1cZdviGGwPVM8+1Q+1vdY0X-pYVw@mail.gmail.com>
 <af19f823-234c-462d-8c52-4d8cf4b93c4c@oss.qualcomm.com>
 <6287083.lOV4Wx5bFT@weasel>
In-Reply-To: <6287083.lOV4Wx5bFT@weasel>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Jul 2026 12:39:52 +0400
X-Gm-Features: AUfX_mxRdL-DqzkjpYIAmbj-FBmtHJVc5VSImiqMsANjDJqpsxKJSZx6GWIMBMY
Message-ID: <CAMxuvay01r=EchTO=PocqPtdtZtxcJs+AJZExRA8rBao31mH7w@mail.gmail.com>
Subject: Re: [PATCH 7/8] hw/9pfs: annotate V9fsTransport callbacks as
 coroutine_fn
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Denis V. Lunev" <den@openvz.org>, 
 Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, xen-devel@lists.xenproject.org,
 Li Zhijian <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=mlureau@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Tue, Jul 21, 2026 at 12:38=E2=80=AFPM Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> On Tuesday, 21 July 2026 10:25:34 CEST Philippe Mathieu-Daud=C3=A9 wrote:
> > On 21/7/26 10:06, Marc-Andr=C3=83=C2=A9 Lureau wrote:
> > > Hi
> > >
> > > On Tue, Jul 21, 2026 at 11:58=E2=80=AFAM Marc-Andr=C3=A9 Lureau
> > >
> > > <marcandre.lureau@redhat.com> wrote:
> [...]
> > >> most of them are "return-type co_annotation fn(..)"
> > >> we even have scripts/block-coroutine-wrapper.py that relies and
> > >> produce this order..
> > >> a bit late to change the style imho...
> > >>
> > >> At least, let's not make this a requirement for this series, please
> >
> > Not a requirement on my side, but if we had to pick a style,
> > I'd vote for "attribute before return type".
>
> Yep, because that's a) the most compiler-friendly option (all compilers a=
llow
> it, including MSC) and b) it's the most diff-noise friendly solution (can=
 be
> prepended on its own line without touching any of the existing line(s) at
> all).
>

ok, what should I do? Send a preliminary patch to fix all annotation
positions? or just change the position in this patch or series?


