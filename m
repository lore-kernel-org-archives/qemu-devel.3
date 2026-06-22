Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA7DCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbeNn-0000as-1w; Mon, 22 Jun 2026 09:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbeNi-0000aY-4O
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 09:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbeNf-0004PO-8g
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 09:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782133681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2+EBD+WgePFVDDRAX6LMxPxMEH/G8HCaWTjGtY7cyLo=;
 b=V18A2YFqr0PG0d5fGbVEHLFAJqArmz0Shv1kzUX9IZ4zd4n2TZi1X9oRniWZqFzuFA+jRy
 EUjzoxyVx+DOe2NiF5JmhqD0N3PL16jnJe4946htcRXtOD4FsnVio/BPExirSI3DOZG7Wl
 VH6CfsfB+REC0yg9OZ8PauN2WmjZJgE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-rkSC6gUBMxGGxBDUPiWpag-1; Mon, 22 Jun 2026 09:07:59 -0400
X-MC-Unique: rkSC6gUBMxGGxBDUPiWpag-1
X-Mimecast-MFC-AGG-ID: rkSC6gUBMxGGxBDUPiWpag_1782133678
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490afe64f26so18153465e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 06:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782133678; x=1782738478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+EBD+WgePFVDDRAX6LMxPxMEH/G8HCaWTjGtY7cyLo=;
 b=qvTG+T55SF1GTGsBHt2HPP9uZLV8HhS4Sgw5dlSfLhc+VvzR7YAjS21ovFi16YKYbk
 lDiJ7oXVkQrmVrnvUs+J2B27HYUFNHKoo/qOwJtylFY0N3s705w6WCYRfNKCfCKHqzx3
 OUP5h5DZRqnTJxtuvT3QdaEjTHhGB2VrfiAtIEGOKZWu1kxA6SMKUKfXMQPfs5kI68Me
 sllDGQQdpssmgF/kq7ZqEe4Euh39BvFSaW3we3jJtrFwnMAmMlmkwvP06l1NYKbwNav6
 7ybJ3S5SGieuChGf3QaKkHW5+CROsO0h2Ek/qF1gUaZLmWp8dzMfzU2/q7Cxsiivolq8
 vYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782133678; x=1782738478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2+EBD+WgePFVDDRAX6LMxPxMEH/G8HCaWTjGtY7cyLo=;
 b=N2IQX8NUB9IUwV4g8yecCav6sakLgBQONFyAW3krnBsJlyrVr7pBIKElsyZW7Xq2vx
 4vBuq5JJAS1666LLH859lwNe0Gpcd9Z4K0zpAkVeXfzoH49Cft1OGmIuslke103esARz
 55Q+jd6gv926l0AcJH8vAfTFiOhLG1uCsC1C5HroFBbyBSFuQBmIfM9Z06X8kf/YPBq7
 oC0jqsdoHrwX26gH58ywC2+qOaN6p4h68Z6edDkH85D2JiHSs2nzIkFUKZ5dqt/9wOV7
 e6ixZWuPFxgR0aHs0BQ3tNnt+GAOrz5AYkqt5Dr3v7zI0PEFQZ/8/PzMJdIUSMCHsgBx
 FEfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/s0bQiS3QS2jMJMAkIP+xSLxzV3NHl3BnSuvfXB2V8fzMj4zfsSP8GTqB++gOJmh49An60zjJTEUGl@nongnu.org
X-Gm-Message-State: AOJu0YwIH31zJp9nxHhw0L0LV4hAHsgGdBy/cyKu+O7LJ7oJb5fUMN5n
 Rw7DURxMaRpsVkunLoB0f+iI0QKbcUwcKZtcbw48tBDsvcP3htCmvTQzQojgfhJEDxh9meUwewT
 F4/m9+gR0+uouvLSVlqLfzCYyL2mWWjsVII30KkbmUZo0Iu/btyTQSLTy
X-Gm-Gg: AfdE7ckZqWDUMJ+AlHOToBmlTV4lxGKkuXXFQ27SaUAcma+0cCC869N27eWIhnG/5Fv
 aATvLvfrBwN41ib9TjnMjcV/4BcAIzKk/Z7Q7R/cOeWg4Ei1H7qeqOVUcJSofhrUXZx3l5mqKRl
 DcCLEoZzQOB/qvekOaXMj+KHwlFNam912YYIlwlxbYbbEbqDpeEycpuDOorrPxyvFgb/eGhg0E7
 0gnryqkYNvwwCA/qHNp6z6rKixK7mTl8yRyEZRlEn1YA0/IuFbxoYs0m5jpNsOT9pRf5FsDTgDO
 9NsxQcAdKLQijJbfMDXycjIf1SHMOphf7CfaazwSpYlpquKircgI9FijjanG0ZjS+sWVCew=
X-Received: by 2002:a05:600c:1d19:b0:492:38c9:b265 with SMTP id
 5b1f17b1804b1-49240a448edmr196319035e9.15.1782133677930; 
 Mon, 22 Jun 2026 06:07:57 -0700 (PDT)
X-Received: by 2002:a05:600c:1d19:b0:492:38c9:b265 with SMTP id
 5b1f17b1804b1-49240a448edmr196318535e9.15.1782133677521; 
 Mon, 22 Jun 2026 06:07:57 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fe7b9e5sm286067255e9.10.2026.06.22.06.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:07:57 -0700 (PDT)
Date: Mon, 22 Jun 2026 15:07:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: fanhuang <FangSheng.Huang@amd.com>, qemu-devel@nongnu.org,
 david@kernel.org, mst@redhat.com, gourry@gourry.net, philmd@mailo.com,
 peterx@redhat.com, Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
Subject: Re: [PATCH v13 02/10] qapi, hmp: introspection for the sp-mem device
Message-ID: <20260622150754.2fa1e457@imammedo>
In-Reply-To: <ajkwrj9DncqDzWoN@redhat.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
 <20260619111136.3481329-3-FangSheng.Huang@amd.com>
 <ajkwrj9DncqDzWoN@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 22 Jun 2026 13:55:10 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Jun 19, 2026 at 07:11:28PM +0800, fanhuang wrote:
> > Add a SpMemDeviceInfo variant to MemoryDeviceInfo so `query-memory-devi=
ces`
> > reports each sp-mem instance (id, addr, size, node, memdev), and print =
it
> > from HMP `info memory-devices`.
> >=20
> > Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
> > ---
> >  qapi/machine.json          | 43 ++++++++++++++++++++++++++++++++++++--
> >  hw/core/machine-hmp-cmds.c | 11 ++++++++++
> >  hw/mem/sp-mem.c            | 19 +++++++++++++++++
> >  3 files changed, 71 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 685e4e29b8..777cfc81e1 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -1413,6 +1413,32 @@
> >            }
> >  }
> > =20
> > +##
> > +# @SpMemDeviceInfo:
> > +#
> > +# sp-mem device state information
> > +#
> > +# @id: device's ID
> > +#
> > +# @addr: physical address, where device is mapped
> > +#
> > +# @size: size of memory that the device provides =20
>=20
> Is this bytes ? Please include the units in the comment.

we don't do that with any of memory devices,
given it's QAPI - I guess bytes are implied for 'size' type
(i.e. no suffix massaging)=20

> > +#
> > +# @node: NUMA proximity domain to which the device is assigned
> > +#
> > +# @memdev: memory backend linked with device
> > +#
> > +# Since: 11.1
> > +##
> > +{ 'struct': 'SpMemDeviceInfo',
> > +  'data': { '*id': 'str',
> > +            'addr': 'size',
> > +            'size': 'size',
> > +            'node': 'int',
> > +            'memdev': 'str'
> > +          }
> > +}
> > + =20
>=20
> With regards,
> Daniel


