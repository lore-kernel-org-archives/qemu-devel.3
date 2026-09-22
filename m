Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902F6C982FE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8tni-00075z-3w; Tue, 22 Sep 2026 02:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x8tnb-00074B-K3
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 02:16:16 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x8tnZ-0004Lu-UB
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 02:16:15 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a6056ac81fso6652343a12.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790057772; cv=none;
 d=google.com; s=arc-20260327;
 b=kbh4WohUdHKTXnDXDfG9cr0f5xinW9Hq+HXoJdwTHnJuFVA5P7VcaXgi+nkBUZXo2y
 48mfBRZZ+sE7hEW3aYmHOlis7pKHZcGbc65esODMoCi2rHnFapzDacS1gNX5o5pZe5no
 a0s3YvN72ZxEfZap8ogYcDMvk1ER5Aje5L1IGUMzI4TC3UY7h6MiQv4IGhWd/a6CGCrH
 8MDX24UkMyd+GB0Phl/XhP0hJ08yoTX4D/uYzupVhx5jeePh3iFQNh1k7yDEx+3MtDn6
 NPyOumoOFYYEnxHTnqCqUqKc5w2EAgx6nmJC6kChRimelNZ1eyZ6eQWrzQiYLRT3tdpK
 HQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c0qpbC83G7f8nPAK8zpQhaV3gDolsSop/oHiCkp8FmE=;
 fh=oR6KT4T9R4DzEe393lAnUFWLAI2XD1MXqDS3E+1BJZc=;
 b=GKXRcVG6axpcLjCcaYIVmafTKdPzPNTjVOpV7fL9gTyQpi1gmyg0H2Tx+vO1lcaxYv
 PVMDwsI4d2dqjNexTkqHjh0rHjJKPK8FITxgTYZELmQAjwxYXUz7bmoora1OgKZ7AVcs
 /Six82XLWFoQRTu38YkPqLLIqDNIQgKTXnlkeo0873thHjIXJUcHVDaTok+C8F64w0CF
 vhi9iZEoMSuCYkC685B0mI/h1m0yEFB8iN6L1v+njL1jZfIJDZx/PrCA7najAEr+FX9X
 X+rO4mZznWRatzFoNa94YL7Cm/rpOCUIFLTBXM3kiG2Sak6iGjfYC40KMYwA71fWNB51
 vyxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790057772; x=1790662572; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c0qpbC83G7f8nPAK8zpQhaV3gDolsSop/oHiCkp8FmE=;
 b=kl5rVons1nKnRnUEwftOEdNoAFaNygs3uKYGarsLIEiLWEtlvvBAjOkTfhsGtLQ8Zv
 Nzxo78t5cFCBk0ciTKhZg75Jzu0q5o5I8PuuejrxeHDw+/4nyTgazNyj7Fx8JDhvBuod
 unYc57Eq/zSsIVlYU6LPC1hT38j/buubIcbj96ff2IL7b8BG6nysnOqFz7hbOaqydd1+
 zqDglJ4oxm+Xy+yKwxxmyW4YcOkeYQ2lbVhnJ3Q9qkNFKQDa4OHZz+bdQwujzwqbPO4D
 IotNOLXPhb6TweLajnqlNNepSy/F9ynr6zzrKfPbGB/I4K9YIzChIJc1KLzEuhhL3El+
 AM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790057772; x=1790662572;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c0qpbC83G7f8nPAK8zpQhaV3gDolsSop/oHiCkp8FmE=;
 b=G8zLxXr9H8xbpcfIUhb5Tpkzh9oBNhUme/r+USyYVC+8aotoZRQerwnSaEtL5leFpC
 mgPEx9tqbA1ASW1gvb8EuLmyFcU0I45MjarUMe7ZZXvvn9OeDRQVFEx8EgeJpG869VQr
 xxJZPWe1uDLvgKu6YWn21pF5LyTWWv/vOJ/sv/m0kflxfDjdhBWuxMoBeMyhd63B68Ic
 3LjTeZOrwYaHMI1bi03T9Sc3HZ+f928F/Ak9pmGeuPSKZ3ER2f26PGivSvouzge/EVKz
 KCaiGpDLtK5Rwp/DHoWLXjlVIncgAAQcsRGGKCXpoSAceukmbp0wM8pRgwYoBzIEqPKC
 Y+yg==
X-Gm-Message-State: AFuF++msvfNgM19DRWHiY/wEXE/aGMIdMBFBWRbXNaT0524JkTMymxtA
 peCd2lK+jgGHYxkNcz2LHOUAjCSCWf9VNZQ4WXfW57RR9HkvO/pAwZ/yVJ8tHhp5kamaGKluy8A
 befEV6fg6lxDntucuv9S81g07pUXan2M=
X-Gm-Gg: AYBFou3fIy1N6iyx7aD/fs00fpov1wqVxvtOWHFe4XgVwGrW78VakVyVlD37XoNSMXX
 dkFpSPPeBI2jxBPAsqCtwA3POm88dltfyRfMnsKENjBNCjnS1H/k6oumNNum4g5Zy4bbIiaHv6A
 luV3c3xCascLBFk9LMXP20BCoqteg0TP/7wfQwSVgP6JM9sAMFHiuzgspXNxmtPEeFcaVcUN2IB
 0E28Fxk7zm/olznUwsvEJI9FApeKSSWbFZUqwIfPXFhQsmTIJsBTR6KShVw9t/d/ZeAuFT4N6u0
 2gcCVyhZ8iwaoSCFV1wUeBfYj/rxuAXwitnBVMI3nS33JGlPmuTlavwPGngYHxN4OUU=
X-Received: by 2002:a05:6402:20c1:10b0:6aa:9185:6eac with SMTP id
 4fb4d7f45d1cf-6aa91857001mr2455503a12.33.1790057772031; Mon, 21 Sep 2026
 23:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260915101655.3216101-1-zhangckid@gmail.com>
 <20260915101655.3216101-10-zhangckid@gmail.com>
 <20260916195426.GF162769@fedora>
In-Reply-To: <20260916195426.GF162769@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 22 Sep 2026 14:15:34 +0800
X-Gm-Features: AcwNN1V97BCuZ87zcM2r-xUNrlpSOsQgRdvps_ib2P9k0w4UOtWoMaAO6qF49nE
Message-ID: <CAK3tnvK1_EMLZbdA_CiOWNeBe3PzkLVo91_6jmQ3G89ffCbpsQ@mail.gmail.com>
Subject: Re: [PATCH V17 09/13] vfio-user/proxy: Update tracking iothread users
 with holder name
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=zhangckid@gmail.com; helo=mail-ed2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 21, 2026 at 9:37=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Sep 15, 2026 at 06:16:51PM +0800, Zhang Chen wrote:
> > @@ -917,6 +918,11 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress=
 *addr, Error **errp)
> >      proxy =3D g_malloc0(sizeof(VFIOUserProxy));
> >      proxy->sockname =3D g_strdup_printf("unix:%s", sockname);
> >      proxy->ioc =3D ioc;
> > +    path =3D object_get_canonical_path(OBJECT(proxy->ioc));
>
> What does this path look like when you test this? I took a quick look at
> the code and it looks like this object has no parent, so path will be
> NULL?


Thanks for catching this. I incorrectly assumed that being a QOM object
guaranteed a canonical path. This IOChannel has no QOM parent, so the
path is actually NULL.

The local fix uses the owning PCI device's path and saves it for
disconnect(), since the device may already be unparented by then.
Initialization-failure cleanup and repeated device creation tests pass
with this change.

Thanks
Chen

