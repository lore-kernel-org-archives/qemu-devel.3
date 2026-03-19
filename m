Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E79B1075275
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38Q3-0000wc-M3; Thu, 19 Mar 2026 04:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w38Pu-0000w5-Dg
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w38Pq-0003Bu-U2
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773907657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8DptJJkQ5FyTDuynpyfL8rqAIEITG6Bp2o47IXPbZM=;
 b=IKYodbrix8DCiAaznOLZqK3LZxCfWRHPfEsiVcO4sVm6hFnDDI1dSHrKtKOibRvPGLO36+
 qOaLdWKO8WdFI5ktjUgQosa8IvKyj62iLVCnuMLqMkM60ltV8I1jiINPLObZf9jOCF0vn7
 XIElRIEVTwEANW0KwP1zEOb9un/bIlA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-nG0_3HgmM663_V92YmyCaQ-1; Thu, 19 Mar 2026 04:07:34 -0400
X-MC-Unique: nG0_3HgmM663_V92YmyCaQ-1
X-Mimecast-MFC-AGG-ID: nG0_3HgmM663_V92YmyCaQ_1773907654
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b069bfa817so10984485ad.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 01:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773907654; x=1774512454; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8DptJJkQ5FyTDuynpyfL8rqAIEITG6Bp2o47IXPbZM=;
 b=d6F1CKAYllzVoHa2pXPl141CVP6hochErKQcMA5++Atu1xfhH+VeSE8zVPjBbpjg3c
 fWgn0yVlvOWEWhMZax2V/35nxrqv7b64fNwJUFt7F/LQLK9IPrY2vjNLCU/+9tH3fMNO
 yhahOCmHdtaV0b7CD7d6A2HD7eYFDFzgHPMUtuduGnAOWZYY2KRuUkpVaARyxZ3bHVNS
 l+M43zq7zukrQzZ/lEZS/OuBPUTIJPdxDfsTFyGpQEmNQ1kVuiasZX8WUOZbym+t+/5d
 ncj5qR1nflt+IZ3Nlht8PgIA6HJD7st1Vdy0LqgDaKWBcvIWIoOxOT6Z4Z9V8YCUpUxi
 ZS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773907654; x=1774512454;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j8DptJJkQ5FyTDuynpyfL8rqAIEITG6Bp2o47IXPbZM=;
 b=lqsJ5Wqhuw8pLa76ErVBpDLjNdvgTi+BBV3d3qe9lbOYlvJqt9HjvX3GBgi3K+vAEu
 k9cLdY3gTaUNfphoqWUEEv1UutNI3xAlxm1uQELYRjG6oBGXcu/+GLnFfgZo8QAluU2g
 LG7zSDsXQ3gs5Q3MUbCGhniy6q94U7Sj3aWXKwdHKuWpTH6gm5OIl5RT1PL2PCJqT4oh
 tfcwca8y0QeaoA169aVKcU49atazfMl02o1Q7+N2ykFsRXnxFfqK3LCZM3YvIWZA5uMg
 U8E1MsfvfJ1iSOOMy2Sgf4zyMp509opY6O5OBOPuPVsb1V3tuSg4xbeOZmRGDIPnHXqV
 xNtA==
X-Gm-Message-State: AOJu0Yx5ZyJUUKIlx4lkWVi2P/bU9SB+BTYIfxAfkaLD+hA+gTfD7wtK
 JKFpthjBVZnpZcffbTGhQ3y5sKcn3TWKWEfWnhn9Tp8KjsD1NsNad7SC8UK6pShKnpqf1XREmiI
 fbP5Z4FnDn9HdOpB6RcB66aiL+bSIgONj4zAAIgtqJRYGa/kRlGLtV9a/
X-Gm-Gg: ATEYQzzgrgntJYmC0HTeTidzKugwnMnGmdF0EImh9rQYRhg2ESrEIZd3nTXNNCvtvLM
 LVt4a/chRImovkHp4BRfh/6dQKbWYwO7UZtUyDuaan0oPQ3fNn5mVXsuRqkkKXAt5s5q7tsLw0V
 tJW3uiV/CDNRC9TGB2PvZ224uD8iIhPLWhqFA2mMiLLIB0duL8a56rUJa/pT5cpbvARWi/wdbUY
 KYyLLajHISFvmx2ZVp7ijTFU+FzBKc67h9uWZvBrz6oGepV8wL2BlN7ALkWoUAu1TAbSsOZEwET
 R7JVPSQktPTgZIkprDPZl15DBQoX22PgKG7YDaTsnsBSp1whkLg3tPiY80fwb5ntWwFkOK98T9h
 aqjFvirroVnHqhX1jqz5z05woCoOLLTQS4bp2JmSH5ygNNeWY3pMKzAkMkU+6dNMUpG2E0w==
X-Received: by 2002:a17:902:c94f:b0:2b0:700d:83c7 with SMTP id
 d9443c01a7336-2b0700d86a9mr55618115ad.32.1773907653685; 
 Thu, 19 Mar 2026 01:07:33 -0700 (PDT)
X-Received: by 2002:a17:902:c94f:b0:2b0:700d:83c7 with SMTP id
 d9443c01a7336-2b0700d86a9mr55617895ad.32.1773907653303; 
 Thu, 19 Mar 2026 01:07:33 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e445075sm59081355ad.31.2026.03.19.01.07.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Mar 2026 01:07:32 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: minimal microvm build: undefined hyperv_is_synic_enabled
 x86_firmware_configure
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <7393fb31-0def-4558-b051-68de672a4395@tls.msk.ru>
Date: Thu, 19 Mar 2026 13:37:18 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <18D2FE1E-5E9E-41D2-83B7-F8CB3FF3CD82@redhat.com>
References: <7393fb31-0def-4558-b051-68de672a4395@tls.msk.ru>
To: Michael Tokarev <mjt@tls.msk.ru>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 19 Mar 2026, at 1:06=E2=80=AFPM, Michael Tokarev <mjt@tls.msk.ru> =
wrote:
>=20
> Hi!
>=20
> Building a minmal qemu for microvm (the idea is to have small =
footprint
> binary for fastest loading and being light on resources).  It ends up
> with:
>=20
> cc -m64 @qemu-system-x86_64.rsp
> ld: libqemu-x86_64-softmmu.a.p/target_i386_kvm_kvm.c.o: in function =
`hyperv_init_vcpu':
> target/i386/kvm/kvm.c:1757:(.text+0x5d83): undefined reference to =
`hyperv_is_synic_enabled'
> ld: libqemu-x86_64-softmmu.a.p/hw_i386_x86-common.c.o: in function =
`x86_bios_rom_reload':
> hw/i386/x86-common.c:1104:(.text+0x240d): undefined reference to =
`x86_firmware_configure'
> collect2: error: ld returned 1 exit status
>=20
> The build is done with the devices file:
>=20
> CONFIG_PCI_DEVICES=3Dn
> CONFIG_MICROVM=3Dy
> CONFIG_VIRTIO_BLK=3Dy
> CONFIG_VIRTIO_SERIAL=3Dy
> CONFIG_VIRTIO_INPUT=3Dy
> CONFIG_VIRTIO_INPUT_HOST=3Dy
> CONFIG_VHOST_USER_INPUT=3Dy
> CONFIG_VIRTIO_NET=3Dy
> CONFIG_VIRTIO_SCSI=3Dy
> CONFIG_VIRTIO_RNG=3Dy
> CONFIG_VIRTIO_CRYPTO=3Dy
> CONFIG_VIRTIO_BALLOON=3Dy
> CONFIG_VIRTIO_GPU=3Dy
> CONFIG_VHOST_USER_GPU=3Dy
>=20
> and with these confiure options:
>=20
> ../../configure ${common_configure_opts} \
>               --without-default-features \
>               --target-list=3Dx86_64-softmmu --enable-kvm =
--disable-tcg \
>               --enable-pixman --enable-vnc \
>               --enable-virtfs \
>               --enable-linux-aio --enable-linux-io-uring \
>               --enable-numa \
>               --enable-attr \
>               --enable-coroutine-pool \
>               --audio-drv-list=3D"" \
>               --without-default-devices \
>               --with-devices-x86_64=3Dmicrovm \
>               --enable-vhost-kernel --enable-vhost-net \
>               --enable-vhost-vdpa \
>               --enable-vhost-user --enable-vhost-user-blk-server \
>               --enable-vhost-crypto \
>               --enable-seccomp \
>=20
>=20
>=20
> For the first one, hyperv_is_synic_enabled() - it looks like the whole
> hyperv thing in target/i386/kvm/kvm.c should have #ifdef CONFIG_HYPERV
> guard - not just the call to hyperv_is_synic_enabled() but whole
> hyperv_init_vcpu() and related callsite, because =
hyperv_is_synic_enabled
> is only included when CONFIG_HYPERV=3D1.  There are hyperv stubs - =
just a
> few of them, - maybe it's better to actually #ifdef in the actual code
> which call hyperv functions?
>=20
> For the second, it looks like it's been added when adding confidential
> guest support.  This code, too, looks like it should be conditional on
> CONFIG_X86_FW_OVMF, like pc_sysfw_ovmf.c, - or alternatively,
> x86_firmware_configure should be included in stubs.

Yes since x86_firmware_configure() depends on =
pc_system_parse_ovmf_flash() which will be stubbed out for =
non-CONFIG_X86_FW_OVMF cases.
I will send a patch.

>=20
> Overall, I'm seeing less and less reasons to continue building and
> shipping this light microvm binary.
>=20
> Thanks,
>=20
> /mjt
>=20


