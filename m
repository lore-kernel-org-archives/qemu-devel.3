Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44272D1CDAB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 07:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t39Pw-0001HE-0C; Tue, 22 Oct 2024 03:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t39Ps-0001BQ-Vt
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 03:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t39Pr-0002lE-FL
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 03:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729582494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=13g2M84bVSHppRkf/bYpOAVsWnVt2LnpaOUTTn6v6iE=;
 b=CEEdDDbu6TfLPgumvUkE0fdIYMotQUKq8hmx6OGcEtxOK94tDX7BYx9r3pKM9oZJ37en+H
 /A70K9C1FOPST3EcP1jzFEhV6iB3oZujcMxBb0HguGrJa/pHPpZ1as/RE+9NfkdB7YjCho
 9UYQangDf7yq2k85jGgeL4RAZGoZ+N0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-tr-hzOSpOAmzf4lx10EjMA-1; Tue, 22 Oct 2024 03:34:52 -0400
X-MC-Unique: tr-hzOSpOAmzf4lx10EjMA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5606250aso2265434f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 00:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729582491; x=1730187291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=13g2M84bVSHppRkf/bYpOAVsWnVt2LnpaOUTTn6v6iE=;
 b=YD4C0L6HQv3as53tKh7WIAtQpZeF6GUL8a5+dgaeQKccwlO+8pALXM1OVA7tNE3Rhz
 QtO0KYfqUAnZl4nLK8HkkJcbnDiEus570QI9aCZh650BMGU6moW6esSx60eVfplPnZlv
 FUbMe+lIjucVYAzs8I4jK0tc1vYFWzITz1Awym22VaxdtFbwtmB4ymYdvrt03jUUDWhb
 k3Ky6t9nPJuprXfbWpe/LTad109lHf9JY2+fMDM8b3tLBHYS8iNCO6DsRfL8CrF9Lo/y
 xDJ6gyrwED8rNqFwgHYKZd+Bt6tPzNH8xfjPbowqX03fca0Rjg3IQqQNM3d3xruB+jiY
 3NGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgpNmbV1HbkMGpSWWwfpuY2A9GJg1iRzfcrsc8FQDMtMVb/x3T4oBNh2nPO7ImtgqGBgwflyIHkQ1z@nongnu.org
X-Gm-Message-State: AOJu0YwWIgS+NI8hlaFM7eNvaGcoGs9JaJDxzrrjh6C0UnoywNWQUeL2
 C69sC58B+As8gK0lKa//QKBMX5cxrBXaP0EppzYM5IuEetWozWojJuNqMoWOTNGLuss7Ab262DL
 Wz1JrUTVzIjynDw9RGRfDH/YiR0uhvggYmP19+5kvKlprNZsIzlx9
X-Received: by 2002:a5d:4d92:0:b0:37d:4527:ba1c with SMTP id
 ffacd0b85a97d-37eb48a0950mr10075123f8f.49.1729582491120; 
 Tue, 22 Oct 2024 00:34:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHydTnKkFY7FYseeJP6Cz0thA7NPaUfukeEuS10LzLVmhz4doywLuu4Wl7iWbyKyQbwNiLDaA==
X-Received: by 2002:a5d:4d92:0:b0:37d:4527:ba1c with SMTP id
 ffacd0b85a97d-37eb48a0950mr10075109f8f.49.1729582490736; 
 Tue, 22 Oct 2024 00:34:50 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9cd48sm5971780f8f.111.2024.10.22.00.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 00:34:50 -0700 (PDT)
Date: Tue, 22 Oct 2024 09:34:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] pcie: enable Extended tag field capability
Message-ID: <20241022093449.04c007cb@imammedo.users.ipa.redhat.com>
In-Reply-To: <560a13ec-3954-45b6-a3b7-85c106b36eaf@linaro.org>
References: <20241017-pcie-extend-v1-1-03eb1029f4ca@linaro.org>
 <20241017125724-mutt-send-email-mst@kernel.org>
 <560a13ec-3954-45b6-a3b7-85c106b36eaf@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 18 Oct 2024 12:24:05 +0200
Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org> wrote:

> W dniu 17.10.2024 o=C2=A018:58, Michael S. Tsirkin pisze:
> >> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> >> index 4b2f0805c6..54c0f1ec67 100644
> >> --- a/hw/pci/pcie.c
> >> +++ b/hw/pci/pcie.c
> >> @@ -86,7 +86,8 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8=
_t type, uint8_t version)
> >>        * Specification, Revision 1.1., or subsequent PCI Express Base
> >>        * Specification revisions.
> >>        */
> >> -    pci_set_long(exp_cap + PCI_EXP_DEVCAP, PCI_EXP_DEVCAP_RBER);
> >> +    pci_set_long(exp_cap + PCI_EXP_DEVCAP, PCI_EXP_DEVCAP_RBER |
> >> +                 PCI_EXP_DEVCAP_EXT_TAG);
> >>  =20
> >>       pci_set_long(exp_cap + PCI_EXP_LNKCAP,
> >>                    (port << PCI_EXP_LNKCAP_PN_SHIFT) | =20
> >=20
> > We can't change capabilities unconditionally.
> > It needs at least a machine type compat thing. =20
>=20
> Started looking and wonder how to pass it from MachineClass level down=20
> to pcie.c/pcie_cap_v1_fill() level.

see as an example:
  fa905f65c5549 hw/nvme: add machine compatibility parameter to enable msix=
 exclusive bar
=20
> hw/arm/sbsa-ref.c (the machine I know best) has create_pcie() which=20
> allocates PCI_HOST_BRIDGE and then creates 2 pcie devices (default_nic=20
> (e1000e) and bochs-display gfx).
>=20
> If I add "pcie_uses_ext_tags =3D true" to SBSAMachineState then I need to=
=20
> have it stored in PCIBus structure so pci_create_simple() will know.=20
> This function would copy it into "dev" (PCIDevice) to make it pass to=20
> pcie_cap_v1_fill() function.
>=20
> But that's not right way because other PCIe devices are created in other=
=20
> places.
>=20
> Need to dig deeper.
>=20


