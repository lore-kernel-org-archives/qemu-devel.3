Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1C3CCA476
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 15:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7bOU-0006CF-MQ; Sat, 11 Oct 2025 11:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1v7bOS-0006C7-N5
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 11:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1v7bOF-0002f5-Ne
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 11:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760196006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gfeRhHLeX6RD0Xwvn6mUghsv4L7Bf+JEAgprBttqw6s=;
 b=dLSvXan5/zn1YRsswkl6bVvcZSSH8cPHoO3wCCQgQ8Xa1Yku4gcBIBqaFt2euUmh0JqhP0
 RNol0Q2XxTIhYola4l0JC+4hGqpJ6lsBUh0b4IBRmxj8pzkx3xZpif3G9n8g2n2Dji1BTd
 apHFFxSitRCxW2V7pCzHVcs/4E4wl8s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-adYwf52oMR-NV9giwU4JHQ-1; Sat, 11 Oct 2025 11:20:04 -0400
X-MC-Unique: adYwf52oMR-NV9giwU4JHQ-1
X-Mimecast-MFC-AGG-ID: adYwf52oMR-NV9giwU4JHQ_1760196003
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b56f1c14b71so97389166b.2
 for <qemu-devel@nongnu.org>; Sat, 11 Oct 2025 08:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760196003; x=1760800803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gfeRhHLeX6RD0Xwvn6mUghsv4L7Bf+JEAgprBttqw6s=;
 b=If1nzBtq/VMbbEsExU8oqaa0AQF1E58Kg3jOC9XPUiNMhKLi2uFNFnzBkKf4qeKbeM
 vfDVGFM5uZbTVcRxRmmioV6YkqyiJ3SWySMylylL0ntIAZffBGXZ9wt7JbSM8LrmhUuG
 sT0r8nIsGnYB64E15j6JbQb2Y4fvhZEhTPvzfaZsb7VO1qxLBvFxuCGCoWM5mpcx9YEP
 6qGLV7/Td2zpJGSFwlmFEGKVgtc4u/yOwTSQ3ehjQG9l9XBcmuVrgH1v+YqZxY6fut21
 fM9CczFxcOaTYIZ/4CN59dTbfr2KfcBbH3hr9HvwH9Nn8DAkawJ/ky9z8fYzvwh7g5mP
 AU+w==
X-Gm-Message-State: AOJu0Yx/mNCZPtmFyge0rDtYyFwzMJkOFomZ2I6Whnje0YTOvnZW98ZD
 RH4TSxmkqh36/JbcfTI2xV787ErT5UdV3I8TTLqCn4qqLR+j2wjTgaq7DAbprbT68srYzx5Xdkz
 sUostIhjc1HKcvgSLB86L9FIcp1gJ4MWiM2L2Qd5peoA4ySsX9JMjGWBL8HI5pCVDmSodpaox/Z
 AEoL/QKSJPXPbxEg22193Wl9jSQE3NvaQ=
X-Gm-Gg: ASbGnctmAitkZmspehWcKIcFMvYg+n9GFHgv+oZ/zxYPfklOhIEOgsWG9gteU9m/i7q
 jKEc3B13mpaqT5b/pBppPV9SLe08RGS5D/tz60CYAD/Mmr/z1ObZDakAtSH5a36QJUPwElUgWu0
 0aCmHM+Fs0TCr/hbGEMHuASA==
X-Received: by 2002:a17:907:c28:b0:b46:3f98:6ba5 with SMTP id
 a640c23a62f3a-b50aa48e3a6mr1792953366b.11.1760196003446; 
 Sat, 11 Oct 2025 08:20:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7MPoPo29oph392rQnkgwLRREP17nxp20Qtx2Woj8JJSmpBb+MWYKNWwwoa7x8KUt+K7OIFIirL55/C8ztI9A=
X-Received: by 2002:a17:907:c28:b0:b46:3f98:6ba5 with SMTP id
 a640c23a62f3a-b50aa48e3a6mr1792951166b.11.1760196003084; Sat, 11 Oct 2025
 08:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <9c500fbcd2cf29afd1826b1ac906f9d5beac3601.1760104079.git.pabeni@redhat.com>
 <CACGkMEt4YLAS7a-j-7t2ogoN=TWvsmBzDwJGVqvjbrt30orYTg@mail.gmail.com>
In-Reply-To: <CACGkMEt4YLAS7a-j-7t2ogoN=TWvsmBzDwJGVqvjbrt30orYTg@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Sat, 11 Oct 2025 23:19:26 +0800
X-Gm-Features: AS18NWAe9ibbFKs8yBxChWMBVoJ7rEazvaNGhuDtrLS27tyGDs_-jUUyZWm_fAE
Message-ID: <CAPpAL=wkRSftdvrUk-EE1=3B729ZKAFC_Z36F6k24ta5JX6fQA@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Advertise UDP tunnel GSO support by default
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sat, Oct 11, 2025 at 12:58=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Fri, Oct 10, 2025 at 10:13=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> > Allow bidirection aggregated traffic for UDP encapsulated flows.
>
> bidirectional ?
>
> >
> > Add the needed compatibility entries to avoid migration issues
> > vs older QEMU instances.
> >
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
>
> Other than that.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
>


