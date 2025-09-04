Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9515CCA1010
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 02:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu0AJ-0001Qm-Ih; Wed, 03 Sep 2025 22:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uu0AG-0001Q1-Nz; Wed, 03 Sep 2025 22:57:32 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uu0AF-0001Q7-3V; Wed, 03 Sep 2025 22:57:32 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-323266cdf64so360468a91.0; 
 Wed, 03 Sep 2025 19:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756954647; x=1757559447; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wcGY8/lyNOnDa+8Ee43172Au5C5YolnxWwM+ktO+Hz8=;
 b=EcLuyFmCEJQdzEh87JRWn+nMeTWKCWB5D3O0PTa948itNDjvEHdY9eUcvArE3vlqNg
 QUtkKfcNQQJvm9wiy2QeWoLLRwL0jJO4NjN4G4IJZbRhh97q6Ctebq+sOcKagsIjnZFC
 m1TeqWqhnfnKnKARbdlhuKb491GuYDa2/MS0JuQxk1PXrG9fIkBJvUkpJeSLQGun/3sC
 MojJOgTwzxYle2R2/vGgTtcFI5c3NC/XTpznPA/dIGwOnT0T895o0onkOa/PYLsat2pz
 w26lvn88saHw8PKF/4f1YopY4uTG9OZjEiPYhoYxMV7adakkZ5/KoQ73C698ZJ4e9i1N
 cPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756954647; x=1757559447;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wcGY8/lyNOnDa+8Ee43172Au5C5YolnxWwM+ktO+Hz8=;
 b=jZDWPlbCmU2WAZ2DBmo6NtMH391Li5lnX2V3agWKUvmJxulob6Fn9eorfpk6WsaTcc
 w5tVdAjB4yidrKUHyZjHBPvoTfbFlWNA4NlpOwy7YjvLsUSGZ3Fkx74glpRWQDj6VEFJ
 /BRFWqCmQ8lxums6jqMoOnmdL1IkEYtEIycfaJBwc6AsOR0jdZnpbMPSGFD/ZpQfq6bQ
 wkTqSlBOvaZg6SMP5jpQDPAqnJwBtjFvgRT5dfAu7ksIVgpZtPK4DaCSuV7EWgQ1SbAX
 N/hHl2zZi5afHD8PCAGPgGsqItv76/rczhRgC3ylOQxkasguZg6nyZ0fkEeqTmwCo+pw
 EwjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9R1ZqpiFYB1PA/9Bn04cPjkzaIrtB9Sxy8lwzCjqSs0xa2j3NXvGl0SjJGuVFS+WSlfdXzbSRq1Nefg==@nongnu.org,
 AJvYcCVYzcT7QKQYJ6+xoYMSk8YCLKHZEZ/XCXBAZin1tQxJKloGw3Z7Eck+xiYXe22YQEGBmJ76ou1KVIBl@nongnu.org
X-Gm-Message-State: AOJu0YwD94FLAaNwOAnDyAuvXmJys99Hmt589xOvh/k+K6Xw/8R0+zss
 GlyUh1y/8lgUbjJQxKSmJxy9ELj+OewUlDaI59dE8qpxdSvu2KXouF6N
X-Gm-Gg: ASbGncspZqmdOAjt5lTWZh+LxRUaaAz3Y+r7//EVJaISJpl9VKfU178CNhhnhNAnDQ3
 7mIKqXaZd+RE6cl/RrH0s2Q8SMdBZmw1dMBp5LpCJxFcFKWDJZ4qt1r6Bug+8ZuU5tc0nN3DrV2
 Sph/q2kwQ2TvzMpKPqXkLRE/it5NTYmcXaABch1wGO//XHNdP1J1/Ce4eW8e9yS1NJBLgcpGQuq
 UHjKSbdxLwMIkasDMjIag2RHqa2mVNwK2AhLLeTtHW4wLa/HaVAUkHJ+e/uOis8q3VFVgsmOfKb
 7aH4BzuN2FvZizmrlExMXMxgHfjL8BF9aQEwWzZWPUDVdGHu/HEFEOVd8i/SKU2iGO/d8CD0KeF
 WXHwduKdQZ9eGytKK8+qr+SLCAyjNo5WiCJ8m58phuclVr1s=
X-Google-Smtp-Source: AGHT+IEDGczASuHQE5zuVGP4AxDAFpzPYqHC8yzwO6kRd5AcUh9CKOWyHf9ai1GOgbwjtF9k3CrQKA==
X-Received: by 2002:a17:90b:17cd:b0:32a:e706:b7b6 with SMTP id
 98e67ed59e1d1-32ae706be21mr7083547a91.11.1756954647100; 
 Wed, 03 Sep 2025 19:57:27 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm18596788a91.25.2025.09.03.19.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 19:57:26 -0700 (PDT)
Message-ID: <593d87562d24498fead1467647966a7ea6545878.camel@gmail.com>
Subject: Re: [PATCH v3 3/5] hw/nvme: add NVMe Admin Security SPDM support
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, Keith Busch
 <kbusch@kernel.org>,  Jesper Devantier	 <foss@defmacro.it>, Fam Zheng
 <fam@euphon.net>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz	
 <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum	 <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Thu, 04 Sep 2025 12:57:20 +1000
In-Reply-To: <aLgNns-n6pODC4JT@AALNPWKJENSEN.aal.scsc.local>
References: <20250901034759.85042-2-wilfred.opensource@gmail.com>
 <20250901034759.85042-5-wilfred.opensource@gmail.com>
 <20250903024705.GA103624@fedora>
 <aLgNns-n6pODC4JT@AALNPWKJENSEN.aal.scsc.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pj1-x102b.google.com
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

On Wed, 2025-09-03 at 11:42 +0200, Klaus Jensen wrote:
> On Sep=C2=A0 2 22:47, Stefan Hajnoczi wrote:
> > On Mon, Sep 01, 2025 at 01:47:58PM +1000, Wilfred Mallawa wrote:
> > > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > >=20
[snip]
> > > +static uint16_t nvme_sec_prot_spdm_send(NvmeCtrl *n, NvmeRequest
> > > *req)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 StorageSpdmTransportHeader hdr =3D {0};
> > > +=C2=A0=C2=A0=C2=A0 g_autofree uint8_t *sec_buf =3D NULL;
> > > +=C2=A0=C2=A0=C2=A0 uint32_t transfer_len =3D le32_to_cpu(req->cmd.cd=
w11);
> > > +=C2=A0=C2=A0=C2=A0 uint32_t transport_transfer_len =3D transfer_len;
> > > +=C2=A0=C2=A0=C2=A0 uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
> > > +=C2=A0=C2=A0=C2=A0 uint32_t recvd;
> > > +=C2=A0=C2=A0=C2=A0 uint16_t nvme_cmd_status, ret;
> > > +=C2=A0=C2=A0=C2=A0 uint8_t secp =3D extract32(dw10, 24, 8);
> > > +=C2=A0=C2=A0=C2=A0 uint8_t spsp1 =3D extract32(dw10, 16, 8);
> > > +=C2=A0=C2=A0=C2=A0 uint8_t spsp0 =3D extract32(dw10, 8, 8);
> > > +=C2=A0=C2=A0=C2=A0 bool spdm_res;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 transport_transfer_len +=3D sizeof(hdr);
> > > +=C2=A0=C2=A0=C2=A0 if (transport_transfer_len >
> > > SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE) {
> >=20
> > An integer overflow check is needed since transfer_len comes from
> > the
> > untrusted guest. This will prevent the sec_buf buffer overflow
> > below
> > when nvme_h2c() is called.
> >=20
>=20
> And it should not be allowed to exceed MDTS (see nvme_check_mdts).
> MDTS
> may be configured as zero, so g_try_malloc should still be used.
Okay that makes sense, I will fix this in V4. Thanks for the pointer!

Cheers,
Wilfred

