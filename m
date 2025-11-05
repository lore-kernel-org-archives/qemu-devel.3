Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D99CCFA07
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 09:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGZoR-0000P6-Il; Wed, 05 Nov 2025 04:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vGZoP-0000OV-DL
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 04:28:17 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vGZoL-0007HW-K1
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 04:28:17 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-640e970598cso320437a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 01:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1762334891; x=1762939691; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RL/GkzN+BdSgnYyqE9w64Oebo5HaMthIF0e7iIXbv9c=;
 b=QGicb+j253H8TlZD4faS/QwfhlNw5onrbmDElwwx1WL8LOgLiJOcS2LUdJDMNulTuA
 r+v+y/w86DfZBiMM2NM40s8mK8doBK3tHcqh492FFD7YkigS2nwuCVoNeyerwlolKH8R
 CgWKm2EvYyRfwwqlqNA5xU8bEQwYlR8Lg0ncSzPppSDM9OMZvliv8/yjHx2Ac62pLP5t
 03WjKGShMLBC8M3PNpElJmwJaXKgG6bJ68pmS9CRh7wROJmW1sDx5ccjqkqVvP4oVZqm
 crK8kq/hXuDDypohT+ynGC3WAkRJj3xpJhjtOInmp3qG9rH+O0mwgWy5wbd5GAGQHa89
 aU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762334891; x=1762939691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RL/GkzN+BdSgnYyqE9w64Oebo5HaMthIF0e7iIXbv9c=;
 b=kygk8Txr5E809XRyGr1rZD4FMVCI7/kQW2uw4r2kVVyNGLGu1zueXtDJ6gjsnn8cBs
 53pTQh5yawDjtTEe+LwKBqWLz5Hkeat7J7Xoxb6w/phzO9hPbyUVqkzsfGJ9GfRDWioX
 okvicLb4bn5qnGZJbSYtk2Sy6vTncY1TVD3+ci1sHGByDfPEJzw7EgjYhz5vBVrlfnbL
 thr0uaR23YgeYTaoU1x4m6f079Zy8lcWeFqeCgFq9tQxyViZohKhQ+34FfIIFeszq0uR
 7IuQS1JsqZbGp3ExRih9Ta65pcR1qUgwxjRmmjeJnPJwxgtmEafMjrPOd9xvrf6KPlTC
 sDnA==
X-Gm-Message-State: AOJu0YzO6+ROVqbbhVtdITy91TB0g93SzbEKC0mF7fzMWVBZqo9KyXW6
 0oY8yc9oXYT0bgBGir94y6wgNGt4dGi4BHHtjgnFfWX/wytsz8nrGt7r7mWeoxmTb670PJxk2UH
 TePLQjkpm2DwfN2FycSSVBe2pZ1sXJoCpgFX6R5fSWw==
X-Gm-Gg: ASbGncvtRKsj9+0+7lw4KfuNaOwBosTUf6+BPkMxTMR5JASQPLRZgWzixSfneYZIzPx
 12UeNHUQyjEHp1LmlOKIEbfHWRAPSMaPQNw5Eczgm1u+JjD2vD6zwvEQrJMmbg5gOuMhSPikhAU
 oqvHX11OuJYP0yAcLOBZ1TQWtEamtV3Ia92W0dLw+4itBLUxM3h0L6P1kvLhIE/w8PbYqgBoW2Z
 ntfIXGaznoZNriilA5rSvI5cSL2QRUDvX+FdTKL5AlLzVGH12Dl4JuDZvps
X-Google-Smtp-Source: AGHT+IHitLFaaobP416PHdXKsFH1sbXzLpjVOzQOMyZSuuCoH72yx3oxAzfu4A8rA3yESED4u9weuKB9kPEkkuVYX1w=
X-Received: by 2002:a05:6402:51d1:b0:640:7529:b8c4 with SMTP id
 4fb4d7f45d1cf-6410588c5e5mr1161176a12.1.1762334891268; Wed, 05 Nov 2025
 01:28:11 -0800 (PST)
MIME-Version: 1.0
References: <CAMGffE=cZ_TgG=Ae+oVE+emWwuDNssozKNDsidS1+yTrh=cZXQ@mail.gmail.com>
 <CACGkMEtUx0PigJrJSWY8n2N7+znc02aqotNq+Y5w3aOMOvUvjQ@mail.gmail.com>
In-Reply-To: <CACGkMEtUx0PigJrJSWY8n2N7+znc02aqotNq+Y5w3aOMOvUvjQ@mail.gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 5 Nov 2025 10:27:59 +0100
X-Gm-Features: AWmQ_bkbDx4xPqiMof_vkKK6kUXulXOVR46jP3DaTjR6WpqKJynp2xB7ChMVmYA
Message-ID: <CAMGffE=cqr1awRmhAMg3V82_g1-2aM36oV+hWPuczs6VUCQkgw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BBUG=5D_Migration_failure_between_QEMU_9=2E2=2E4_=E2=86=92_8?=
 =?UTF-8?Q?=2E2=2E10_due_to_virtio=2Dnet_feature_mismatch_=28VIRTIO=5FF=5FRING=5FRESE?=
 =?UTF-8?Q?T_=2F_USO_features=29?=
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 qemu-stable@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Yu Zhang <yu.zhang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::52b;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Jason,

Thank you for reply.
On Wed, Nov 5, 2025 at 9:59=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Nov 5, 2025 at 4:49=E2=80=AFPM Jinpu Wang <jinpu.wang@ionos.com> =
wrote:
> >
> > Hello QEMU developers,
> >
> > I=E2=80=99m encountering a migration failure when trying to live-migrat=
e a VM
> > from a newer host (kernel 6.12 + QEMU 9.2.4) to an older one (kernel
> > 6.1 + QEMU 8.2.10).
> > Migration in the forward direction (old =E2=86=92 new) works fine, but =
after
> > rebooting the guest on the new host, migration back to the old host
> > fails.
> >
> > ________________________________
> >
> > Issue summary
> >
> > Source host: kernel 6.12, QEMU 9.2.4
> >
> > Destination host: kernel 6.1, QEMU 8.2.10
> >
> > VM type: pc-q35-8.2, using virtio-net-pci with vhost backend
> >
> > Symptom: Migration from 9.2.4 =E2=86=92 8.2.10 fails with virtio-net lo=
ad error.
> >
> > Error log (destination):
> >
> > 2025-09-23T07:06:14.915708Z qemu-8.2: Features 0x1c0010130afffa7
> > unsupported. Allowed features: 0x179bfffe7
> > 2025-09-23T07:06:14.915843Z qemu-8.2: Failed to load virtio-net:virtio
> > 2025-09-23T07:06:14.915851Z qemu-8.2: error while loading state for
> > instance 0x0 of device '0000:00:02.0:06.0/virtio-net'
> > 2025-09-23T07:06:14.917894Z qemu-8.2: load of migration failed:
> > Operation not permitted
> >
> > ________________________________
> >
> > Analysis
> >
> > It appears that virtio-net feature bits differ between the two versions=
.
> > On QEMU 9.2.4, virtio-net reports additional features:
> >
> > VIRTIO_F_RING_RESET
> >
> > VIRTIO_NET_F_HOST_USO
> >
> > VIRTIO_NET_F_GUEST_USO4
> >
> > VIRTIO_NET_F_GUEST_USO6
> >
> > These are not present (or not supported) on QEMU 8.2.10, which causes
> > the migration state load to fail.
>
> Interesting, we've already done the compat work:
>
> GlobalProperty hw_compat_8_1[] =3D {
>     { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
>     { "ramfb", "x-migrate", "off" },
>     { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
>     { "igb", "x-pcie-flr-init", "off" },
>     { TYPE_VIRTIO_NET, "host_uso", "off"},
>     { TYPE_VIRTIO_NET, "guest_uso4", "off"},
>     { TYPE_VIRTIO_NET, "guest_uso6", "off"},
> };
> const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
Yeah, I noticed the same.
>
> >
> > The issue seems related to the introduction of these features and how
> > they are handled during incoming migration when the target QEMU does
> > not recognize them.
> >
> > ________________________________
> >
> > Reproduction steps
> >
> > Start VM on host with QEMU 8.2.10 (kernel 6.1).
> >
> > Migrate to host with QEMU 9.2.4 (kernel 6.12).
> > =E2=86=92 Migration succeeds.
> >
> > Reboot the guest on the 9.2.4 host.
> >
> > Attempt to migrate back to QEMU 8.2.10 host.
> > =E2=86=92 Migration fails with virtio-net load error (see log above).
> >
> > ________________________________
> >
> > Expected behavior
> >
> > Migration from newer QEMU to older version should either:
> >
> > gracefully ignore unsupported virtio-net features, or
> >
> > fail with a clear compatibility message before starting migration.
> >
> > Currently, migration starts and fails during device state load.
> >
> > ________________________________
> >
> > Related patch
> >
> > I found this commit that looks relevant but is already included in
> > both 8.2.10 and 9.2.4:
> >
> > https://lore.kernel.org/qemu-devel/20240527072435.52812-15-mjt@tls.msk.=
ru/
> >
> > ________________________________
> >
> > VM configuration
> >
> > -uuid dbaf0b1f-4dc5-4462-86b1-d82107b58599
> > -name Serverwittchendbaf0b1f-4dc5-4462-86b1-d82107b58599
> > -M pc-q35-8.2
>
> Could you double check if this is used in both source and destination?
>
> > -accel kvm,kernel-irqchip=3Dsplit
> > -cpu SierraForest-v2
> > -smp 7,sockets=3D128,cores=3D1,maxcpus=3D128,threads=3D1
> > -m 4096,slots=3D252,maxmem=3D256G
> > -bios /usr/share/ovmf/OVMF.fd
> > -device virtio-net-pci,netdev=3Dhostnet6,id=3Dnet6,mac=3D02:01:17:9b:9a=
:35,bus=3Dpci.0,addr=3D0x6
> > -netdev tap,ifname=3Dn0201179b9a35,id=3Dhostnet6,script=3Dno,downscript=
=3Dno
> >
> > ________________________________
> >
> > Question
> >
> > Is this expected behavior (i.e. migration incompatibility due to newer
> > virtio-net feature bits)?
>
> No.
>
> Could you check if
>
> 1) those features were enabled or not via "info qtree" when using pc-q35-=
8.2.
here is output on the machine with 9.2.4, all uso features are enabled:
jwang@ps404a-16.stg:~$ nc -U
/opt/profitbricks/vcb/pbkvm/mon/791776d3-72cc-4392-8603-bb5bdc537011.sock
{"QMP": {"version": {"qemu": {"micro": 4, "minor": 2, "major": 9},
"package": ""}, "capabilities": ["oob"]}}
{'execute':'qmp_capabilities'}
{"return": {}}
{'execute':'human-monitor-command','arguments':{'command-line':'info virtio=
'}}
{"return": "/machine/peripheral-anon/device[1]/virtio-backend
[virtio-rng]\r\n/machine/peripheral/virtio-disk5/virtio-backend
[virtio-blk]\r\n/machine/peripheral/virtio-disk7/virtio-backend
[virtio-blk]\r\n/machine/peripheral/net6/virtio-backend
[virtio-net]\r\n"}
{'execute':'human-monitor-command','arguments':{'command-line':'info qtree'=
}
}
{"return": "bus: main-system-bus\r\n  type System\r\n  dev: ps2-mouse,
id \"\"\r\n    gpio-out \"\" 1\r\n  dev: ps2-kbd, id \"\"\r\n
gpio-out \"\" 1\r\n  dev: hpet, id \"\"\r\n    gpio-in \"\" 2\r\n
gpio-out \"\" 1\r\n    gpio-out \"sysbus-irq\" 32\r\n    timers =3D 3
(0x3)\r\n    msi =3D false\r\n    hpet-intcap =3D 16711940 (0xff0104)\r\n
  hpet-offset-saved =3D true\r\n    mmio
00000000fed00000/0000000000000400\r\n  dev: ioapic, id \"\"\r\n
gpio-in \"\" 24\r\n    version =3D 32 (0x20)\r\n    mmio
00000000fec00000/0000000000001000\r\n  dev: q35-pcihost, id \"\"\r\n
 MCFG =3D 3758096384 (0xe0000000)\r\n    pci-hole64-size =3D 34359738368
(32 GiB)\r\n    below-4g-mem-size =3D 2147483648 (2 GiB)\r\n
above-4g-mem-size =3D 2147483648 (2 GiB)\r\n    smm-ranges =3D true\r\n
x-pci-hole64-fix =3D true\r\n    x-config-reg-migration-enabled =3D
true\r\n    bypass-iommu =3D false\r\n    bus: pcie.0\r\n      type
PCIE\r\n      dev: pcie-root-port, id \"rp.2\"\r\n
x-migrate-msix =3D true\r\n        bus-reserve =3D 4294967295
(0xffffffff)\r\n        io-reserve =3D 18446744073709551615 (16 EiB)\r\n
       mem-reserve =3D 18446744073709551615 (16 EiB)\r\n
pref32-reserve =3D 18446744073709551615 (16 EiB)\r\n
pref64-reserve =3D 18446744073709551615 (16 EiB)\r\n        x-speed =3D
\"16\"\r\n        x-width =3D \"32\"\r\n        power_controller_present
=3D true\r\n        disable-acs =3D false\r\n        chassis =3D 0 (0x0)\r\=
n
       slot =3D 1 (0x1)\r\n        hotplug =3D true\r\n
x-do-not-expose-native-hotplug-cap =3D false\r\n        port =3D 0
(0x0)\r\n        aer_log_max =3D 8 (0x8)\r\n
x-pci-express-writeable-slt-bug =3D false\r\n        addr =3D 04.0\r\n
   romfile =3D \"\"\r\n        romsize =3D 4294967295 (0xffffffff)\r\n
   rombar =3D 1 (0x1)\r\n        multifunction =3D false\r\n
x-pcie-lnksta-dllla =3D true\r\n        x-pcie-extcap-init =3D true\r\n
    failover_pair_id =3D \"\"\r\n        acpi-index =3D 0 (0x0)\r\n
x-pcie-err-unc-mask =3D true\r\n        x-pcie-ari-nextfn-1 =3D false\r\n
      x-max-bounce-buffer-size =3D 4096 (4 KiB)\r\n
x-pcie-ext-tag =3D false\r\n        busnr =3D 0 (0x0)\r\n        class PCI
bridge, addr 00:04.0, pci id 1b36:000c (sub 0080:0000)\r\n        bar
0: mem at 0x88644000 [0x88644fff]\r\n        bus: rp.2\r\n
type PCIE\r\n      dev: pcie-root-port, id \"rp.1\"\r\n
x-migrate-msix =3D true\r\n        bus-reserve =3D 4294967295
(0xffffffff)\r\n        io-reserve =3D 18446744073709551615 (16 EiB)\r\n
       mem-reserve =3D 18446744073709551615 (16 EiB)\r\n
pref32-reserve =3D 18446744073709551615 (16 EiB)\r\n
pref64-reserve =3D 18446744073709551615 (16 EiB)\r\n        x-speed =3D
\"16\"\r\n        x-width =3D \"32\"\r\n        power_controller_present
=3D true\r\n        disable-acs =3D false\r\n        chassis =3D 0 (0x0)\r\=
n
       slot =3D 0 (0x0)\r\n        hotplug =3D true\r\n
x-do-not-expose-native-hotplug-cap =3D false\r\n        port =3D 0
(0x0)\r\n        aer_log_max =3D 8 (0x8)\r\n
x-pci-express-writeable-slt-bug =3D false\r\n        addr =3D 03.0\r\n
   romfile =3D \"\"\r\n        romsize =3D 4294967295 (0xffffffff)\r\n
   rombar =3D 1 (0x1)\r\n        multifunction =3D false\r\n
x-pcie-lnksta-dllla =3D true\r\n        x-pcie-extcap-init =3D true\r\n
    failover_pair_id =3D \"\"\r\n        acpi-index =3D 0 (0x0)\r\n
x-pcie-err-unc-mask =3D true\r\n        x-pcie-ari-nextfn-1 =3D false\r\n
      x-max-bounce-buffer-size =3D 4096 (4 KiB)\r\n
x-pcie-ext-tag =3D false\r\n        busnr =3D 0 (0x0)\r\n        class PCI
bridge, addr 00:03.0, pci id 1b36:000c (sub 0080:0000)\r\n        bar
0: mem at 0x88645000 [0x88645fff]\r\n        bus: rp.1\r\n
type PCIE\r\n      dev: pcie-pci-bridge, id \"pci.0\"\r\n        msi =3D
\"auto\"\r\n        x-pci-express-writeable-slt-bug =3D false\r\n
addr =3D 02.0\r\n        romfile =3D \"\"\r\n        romsize =3D 4294967295
(0xffffffff)\r\n        rombar =3D 1 (0x1)\r\n        multifunction =3D
false\r\n        x-pcie-lnksta-dllla =3D true\r\n
x-pcie-extcap-init =3D true\r\n        failover_pair_id =3D \"\"\r\n
 acpi-index =3D 0 (0x0)\r\n        x-pcie-err-unc-mask =3D true\r\n
x-pcie-ari-nextfn-1 =3D false\r\n        x-max-bounce-buffer-size =3D 4096
(4 KiB)\r\n        x-pcie-ext-tag =3D false\r\n        busnr =3D 0
(0x0)\r\n        class PCI bridge, addr 00:02.0, pci id 1b36:000e (sub
0080:0000)\r\n        bar 0: mem at 0x8000100000 [0x80001000ff]\r\n
    bus: pci.0\r\n          type PCI\r\n          dev: virtio-blk-pci,
id \"virtio-disk7\"\r\n            disable-legacy =3D \"off\"\r\n
    disable-modern =3D false\r\n            class =3D 0 (0x0)\r\n
  ioeventfd =3D true\r\n            vectors =3D 3 (0x3)\r\n
virtio-pci-bus-master-bug-migration =3D false\r\n
migrate-extra =3D true\r\n            modern-pio-notify =3D false\r\n
      x-disable-pcie =3D false\r\n            page-per-vq =3D false\r\n
        x-ignore-backend-features =3D false\r\n            ats =3D
false\r\n            x-ats-page-aligned =3D true\r\n
x-pcie-deverr-init =3D true\r\n            x-pcie-lnkctl-init =3D true\r\n
           x-pcie-pm-init =3D true\r\n
x-pcie-pm-no-soft-reset =3D false\r\n            x-pcie-flr-init =3D
true\r\n            aer =3D false\r\n            addr =3D 07.0\r\n
   romfile =3D \"\"\r\n            romsize =3D 4294967295 (0xffffffff)\r\n
           rombar =3D 1 (0x1)\r\n            multifunction =3D false\r\n
         x-pcie-lnksta-dllla =3D true\r\n            x-pcie-extcap-init
=3D true\r\n            failover_pair_id =3D \"\"\r\n
acpi-index =3D 0 (0x0)\r\n            x-pcie-err-unc-mask =3D true\r\n
       x-pcie-ari-nextfn-1 =3D false\r\n
x-max-bounce-buffer-size =3D 4096 (4 KiB)\r\n            x-pcie-ext-tag
=3D false\r\n            busnr =3D 1 (0x1)\r\n            class SCSI
controller, addr 01:07.0, pci id 1af4:1001 (sub 1af4:0002)\r\n
   bar 0: i/o at 0x6000 [0x607f]\r\n            bar 1: mem at
0x88400000 [0x88400fff]\r\n            bar 4: mem at 0x8000000000
[0x8000003fff]\r\n            bus: virtio-bus\r\n              type
virtio-pci-bus\r\n              dev: virtio-blk-device, id \"\"\r\n
            drive =3D \"drive-virtio-disk7\"\r\n
backend_defaults =3D \"auto\"\r\n                logical_block_size =3D
512 (512 B)\r\n                physical_block_size =3D 512 (512 B)\r\n
             min_io_size =3D 0 (0 B)\r\n                opt_io_size =3D 0
(0 B)\r\n                discard_granularity =3D 4294967295 (4 GiB)\r\n
              write-cache =3D \"auto\"\r\n                share-rw =3D
false\r\n                account-invalid =3D \"auto\"\r\n
account-failed =3D \"auto\"\r\n                rerror =3D \"auto\"\r\n
           werror =3D \"auto\"\r\n                cyls =3D 16383
(0x3fff)\r\n                heads =3D 16 (0x10)\r\n                secs
=3D 63 (0x3f)\r\n                lcyls =3D 0 (0x0)\r\n
lheads =3D 0 (0x0)\r\n                lsecs =3D 0 (0x0)\r\n
serial =3D \"b663a1b71b486d62\"\r\n                config-wce =3D true\r\n
               request-merging =3D true\r\n                num-queues =3D
2 (0x2)\r\n                queue-size =3D 256 (0x100)\r\n
seg-max-adjust =3D true\r\n                iothread-vq-mapping =3D
<null>\r\n                discard =3D false\r\n
report-discard-granularity =3D true\r\n                write-zeroes =3D
true\r\n                max-discard-sectors =3D 4194303 (0x3fffff)\r\n
             max-write-zeroes-sectors =3D 4194303 (0x3fffff)\r\n
       x-enable-wce-if-config-wce =3D true\r\n
indirect_desc =3D true\r\n                event_idx =3D true\r\n
     notify_on_empty =3D true\r\n                any_layout =3D true\r\n
             iommu_platform =3D false\r\n                packed =3D
false\r\n                queue_reset =3D true\r\n
in_order =3D false\r\n                use-started =3D true\r\n
   use-disabled-flag =3D true\r\n                x-disable-legacy-check
=3D false\r\n          dev: virtio-blk-pci, id \"virtio-disk5\"\r\n
      disable-legacy =3D \"off\"\r\n            disable-modern =3D
false\r\n            class =3D 0 (0x0)\r\n            ioeventfd =3D
true\r\n            vectors =3D 3 (0x3)\r\n
virtio-pci-bus-master-bug-migration =3D false\r\n
migrate-extra =3D true\r\n            modern-pio-notify =3D false\r\n
      x-disable-pcie =3D false\r\n            page-per-vq =3D false\r\n
        x-ignore-backend-features =3D false\r\n            ats =3D
false\r\n            x-ats-page-aligned =3D true\r\n
x-pcie-deverr-init =3D true\r\n            x-pcie-lnkctl-init =3D true\r\n
           x-pcie-pm-init =3D true\r\n
x-pcie-pm-no-soft-reset =3D false\r\n            x-pcie-flr-init =3D
true\r\n            aer =3D false\r\n            addr =3D 05.0\r\n
   romfile =3D \"\"\r\n            romsize =3D 4294967295 (0xffffffff)\r\n
           rombar =3D 1 (0x1)\r\n            multifunction =3D false\r\n
         x-pcie-lnksta-dllla =3D true\r\n            x-pcie-extcap-init
=3D true\r\n            failover_pair_id =3D \"\"\r\n
acpi-index =3D 0 (0x0)\r\n            x-pcie-err-unc-mask =3D true\r\n
       x-pcie-ari-nextfn-1 =3D false\r\n
x-max-bounce-buffer-size =3D 4096 (4 KiB)\r\n            x-pcie-ext-tag
=3D false\r\n            busnr =3D 1 (0x1)\r\n            class SCSI
controller, addr 01:05.0, pci id 1af4:1001 (sub 1af4:0002)\r\n
   bar 0: i/o at 0x6080 [0x60ff]\r\n            bar 1: mem at
0x88402000 [0x88402fff]\r\n            bar 4: mem at 0x8000008000
[0x800000bfff]\r\n            bus: virtio-bus\r\n              type
virtio-pci-bus\r\n              dev: virtio-blk-device, id \"\"\r\n
            drive =3D \"drive-virtio-disk5\"\r\n
backend_defaults =3D \"auto\"\r\n                logical_block_size =3D
512 (512 B)\r\n                physical_block_size =3D 512 (512 B)\r\n
             min_io_size =3D 0 (0 B)\r\n                opt_io_size =3D 0
(0 B)\r\n                discard_granularity =3D 4294967295 (4 GiB)\r\n
              write-cache =3D \"auto\"\r\n                share-rw =3D
false\r\n                account-invalid =3D \"auto\"\r\n
account-failed =3D \"auto\"\r\n                rerror =3D \"auto\"\r\n
           werror =3D \"auto\"\r\n                cyls =3D 16383
(0x3fff)\r\n                heads =3D 16 (0x10)\r\n                secs
=3D 63 (0x3f)\r\n                lcyls =3D 0 (0x0)\r\n
lheads =3D 0 (0x0)\r\n                lsecs =3D 0 (0x0)\r\n
serial =3D \"2ea4900a095b1012\"\r\n                config-wce =3D true\r\n
               request-merging =3D true\r\n                num-queues =3D
2 (0x2)\r\n                queue-size =3D 256 (0x100)\r\n
seg-max-adjust =3D true\r\n                iothread-vq-mapping =3D
<null>\r\n                discard =3D false\r\n
report-discard-granularity =3D true\r\n                write-zeroes =3D
true\r\n                max-discard-sectors =3D 4194303 (0x3fffff)\r\n
             max-write-zeroes-sectors =3D 4194303 (0x3fffff)\r\n
       x-enable-wce-if-config-wce =3D true\r\n
indirect_desc =3D true\r\n                event_idx =3D true\r\n
     notify_on_empty =3D true\r\n                any_layout =3D true\r\n
             iommu_platform =3D false\r\n                packed =3D
false\r\n                queue_reset =3D true\r\n
in_order =3D false\r\n                use-started =3D true\r\n
   use-disabled-flag =3D true\r\n                x-disable-legacy-check
=3D false\r\n          dev: virtio-net-pci, id \"net6\"\r\n
disable-legacy =3D \"off\"\r\n            disable-modern =3D false\r\n
       ioeventfd =3D true\r\n            vectors =3D 4 (0x4)\r\n
 virtio-pci-bus-master-bug-migration =3D false\r\n
migrate-extra =3D true\r\n            modern-pio-notify =3D false\r\n
      x-disable-pcie =3D false\r\n            page-per-vq =3D false\r\n
        x-ignore-backend-features =3D false\r\n            ats =3D
false\r\n            x-ats-page-aligned =3D true\r\n
x-pcie-deverr-init =3D true\r\n            x-pcie-lnkctl-init =3D true\r\n
           x-pcie-pm-init =3D true\r\n
x-pcie-pm-no-soft-reset =3D false\r\n            x-pcie-flr-init =3D
true\r\n            aer =3D false\r\n            addr =3D 06.0\r\n
   romfile =3D \"efi-virtio.rom\"\r\n            romsize =3D 262144
(0x40000)\r\n            rombar =3D 1 (0x1)\r\n            multifunction
=3D false\r\n            x-pcie-lnksta-dllla =3D true\r\n
x-pcie-extcap-init =3D true\r\n            failover_pair_id =3D \"\"\r\n
         acpi-index =3D 0 (0x0)\r\n            x-pcie-err-unc-mask =3D
true\r\n            x-pcie-ari-nextfn-1 =3D false\r\n
x-max-bounce-buffer-size =3D 4096 (4 KiB)\r\n            x-pcie-ext-tag
=3D false\r\n            busnr =3D 1 (0x1)\r\n            class Ethernet
controller, addr 01:06.0, pci id 1af4:1000 (sub 1af4:0001)\r\n
   bar 0: i/o at 0x6100 [0x611f]\r\n            bar 1: mem at
0x88401000 [0x88401fff]\r\n            bar 4: mem at 0x8000004000
[0x8000007fff]\r\n            bar 6: mem at 0xffffffffffffffff
[0x3fffe]\r\n            bus: virtio-bus\r\n              type
virtio-pci-bus\r\n              dev: virtio-net-device, id \"\"\r\n
            csum =3D true\r\n                guest_csum =3D true\r\n
         gso =3D true\r\n                guest_tso4 =3D true\r\n
     guest_tso6 =3D true\r\n                guest_ecn =3D true\r\n
       guest_ufo =3D true\r\n                guest_announce =3D true\r\n
             host_tso4 =3D true\r\n                host_tso6 =3D true\r\n
              host_ecn =3D true\r\n                host_ufo =3D true\r\n
             mrg_rxbuf =3D true\r\n                status =3D true\r\n
           ctrl_vq =3D true\r\n                ctrl_rx =3D true\r\n
        ctrl_vlan =3D true\r\n                ctrl_rx_extra =3D true\r\n
             ctrl_mac_addr =3D true\r\n
ctrl_guest_offloads =3D true\r\n                mq =3D false\r\n
     rss =3D false\r\n                hash =3D false\r\n
ebpf-rss-fds =3D <null>\r\n                guest_rsc_ext =3D false\r\n
           rsc_interval =3D 300000 (0x493e0)\r\n                mac =3D
\"02:01:51:df:1b:c5\"\r\n                netdev =3D \"hostnet6\"\r\n
           x-txtimer =3D 150000 (0x249f0)\r\n                x-txburst =3D
256 (0x100)\r\n                tx =3D \"\"\r\n
rx_queue_size =3D 256 (0x100)\r\n                tx_queue_size =3D 256
(0x100)\r\n                host_mtu =3D 0 (0x0)\r\n
x-mtu-bypass-backend =3D true\r\n                speed =3D -1
(0xffffffffffffffff)\r\n                duplex =3D \"\"\r\n
  failover =3D false\r\n                guest_uso4 =3D true\r\n
    guest_uso6 =3D true\r\n                host_uso =3D true\r\n
     indirect_desc =3D true\r\n                event_idx =3D true\r\n
          notify_on_empty =3D true\r\n                any_layout =3D
true\r\n                iommu_platform =3D false\r\n
packed =3D false\r\n                queue_reset =3D true\r\n
 in_order =3D false\r\n                use-started =3D true\r\n
    use-disabled-flag =3D true\r\n                x-disable-legacy-check
=3D false\r\n          dev: virtio-rng-pci, id \"\"\r\n
disable-legacy =3D \"off\"\r\n            disable-modern =3D false\r\n
       ioeventfd =3D true\r\n            vectors =3D 2 (0x2)\r\n
 virtio-pci-bus-master-bug-migration =3D false\r\n
migrate-extra =3D true\r\n            modern-pio-notify =3D false\r\n
      x-disable-pcie =3D false\r\n            page-per-vq =3D false\r\n
        x-ignore-backend-features =3D false\r\n            ats =3D
false\r\n            x-ats-page-aligned =3D true\r\n
x-pcie-deverr-init =3D true\r\n            x-pcie-lnkctl-init =3D true\r\n
           x-pcie-pm-init =3D true\r\n
x-pcie-pm-no-soft-reset =3D false\r\n            x-pcie-flr-init =3D
true\r\n            aer =3D false\r\n            addr =3D 03.0\r\n
   romfile =3D \"\"\r\n            romsize =3D 4294967295 (0xffffffff)\r\n
           rombar =3D 1 (0x1)\r\n            multifunction =3D false\r\n
         x-pcie-lnksta-dllla =3D true\r\n            x-pcie-extcap-init
=3D true\r\n            failover_pair_id =3D \"\"\r\n
acpi-index =3D 0 (0x0)\r\n            x-pcie-err-unc-mask =3D true\r\n
       x-pcie-ari-nextfn-1 =3D false\r\n
x-max-bounce-buffer-size =3D 4096 (4 KiB)\r\n            x-pcie-ext-tag
=3D false\r\n            busnr =3D 1 (0x1)\r\n            class Class
00ff, addr 01:03.0, pci id 1af4:1005 (sub 1af4:0004)\r\n
bar 0: i/o at 0x6120 [0x613f]\r\n            bar 1: mem at 0x88403000
[0x88403fff]\r\n            bar 4: mem at 0x800000c000
[0x800000ffff]\r\n            bus: virtio-bus\r\n              type
virtio-pci-bus\r\n              dev: virtio-rng-device, id \"\"\r\n
            max-bytes =3D 1024 (0x400)\r\n                period =3D 1000
(0x3e8)\r\n                indirect_desc =3D true\r\n
event_idx =3D true\r\n                notify_on_empty =3D true\r\n
       any_layout =3D true\r\n                iommu_platform =3D false\r\n
               packed =3D false\r\n                queue_reset =3D
true\r\n                in_order =3D false\r\n
use-started =3D true\r\n                use-disabled-flag =3D true\r\n
           x-disable-legacy-check =3D false\r\n      dev: qxl-vga, id
\"\"\r\n        ram_size =3D 67108864 (0x4000000)\r\n        vram_size =3D
67108864 (0x4000000)\r\n        revision =3D 5 (0x5)\r\n        debug =3D
0 (0x0)\r\n        guestdebug =3D 0 (0x0)\r\n        cmdlog =3D 0
(0x0)\r\n        ram_size_mb =3D 4294967295 (0xffffffff)\r\n
vram_size_mb =3D 4294967295 (0xffffffff)\r\n        vram64_size_mb =3D
4294967295 (0xffffffff)\r\n        vgamem_mb =3D 16 (0x10)\r\n
surfaces =3D 1024 (0x400)\r\n        max_outputs =3D 0 (0x0)\r\n
xres =3D 0 (0x0)\r\n        yres =3D 0 (0x0)\r\n        global-vmstate =3D
false\r\n        addr =3D 01.0\r\n        romfile =3D
\"vgabios-qxl.bin\"\r\n        romsize =3D 65536 (0x10000)\r\n
rombar =3D 1 (0x1)\r\n        multifunction =3D false\r\n
x-pcie-lnksta-dllla =3D true\r\n        x-pcie-extcap-init =3D true\r\n
    failover_pair_id =3D \"\"\r\n        acpi-index =3D 0 (0x0)\r\n
x-pcie-err-unc-mask =3D true\r\n        x-pcie-ari-nextfn-1 =3D false\r\n
      x-max-bounce-buffer-size =3D 4096 (4 KiB)\r\n
x-pcie-ext-tag =3D false\r\n        busnr =3D 0 (0x0)\r\n        class VGA
controller, addr 00:01.0, pci id 1b36:0100 (sub 1af4:1100)\r\n
bar 0: mem at 0x84000000 [0x87ffffff]\r\n        bar 1: mem at
0x80000000 [0x83ffffff]\r\n        bar 2: mem at 0x88640000
[0x88641fff]\r\n        bar 3: i/o at 0x70c0 [0x70df]\r\n        bar
6: mem at 0xffffffffffffffff [0xfffe]\r\n      dev: ICH9-SMB, id
\"\"\r\n        addr =3D 1f.3\r\n        romfile =3D \"\"\r\n
romsize =3D 4294967295 (0xffffffff)\r\n        rombar =3D 1 (0x1)\r\n
  multifunction =3D true\r\n        x-pcie-lnksta-dllla =3D true\r\n
 x-pcie-extcap-init =3D true\r\n        failover_pair_id =3D \"\"\r\n
  acpi-index =3D 0 (0x0)\r\n        x-pcie-err-unc-mask =3D true\r\n
 x-pcie-ari-nextfn-1 =3D false\r\n        x-max-bounce-buffer-size =3D
4096 (4 KiB)\r\n        x-pcie-ext-tag =3D false\r\n        busnr =3D 0
(0x0)\r\n        class SMBus, addr 00:1f.3, pci id 8086:2930 (sub
1af4:1100)\r\n        bar 4: i/o at 0x7000 [0x703f]\r\n        bus:
i2c\r\n          type i2c-bus\r\n          dev: smbus-eeprom, id
\"\"\r\n            address =3D 87 (0x57)\r\n          dev:
smbus-eeprom, id \"\"\r\n            address =3D 86 (0x56)\r\n
dev: smbus-eeprom, id \"\"\r\n            address =3D 85 (0x55)\r\n
    dev: smbus-eeprom, id \"\"\r\n            address =3D 84 (0x54)\r\n
        dev: smbus-eeprom, id \"\"\r\n            address =3D 83
(0x53)\r\n          dev: smbus-eeprom, id \"\"\r\n            address
=3D 82 (0x52)\r\n          dev: smbus-eeprom, id \"\"\r\n
address =3D 81 (0x51)\r\n          dev: smbus-eeprom, id \"\"\r\n
    address =3D 80 (0x50)\r\n      dev: ich9-usb-uhci3, id \"\"\r\n
  masterbus =3D \"usb-bus.0\"\r\n        firstport =3D 4 (0x4)\r\n
bandwidth =3D 1280 (0x500)\r\n        maxframes =3D 128 (0x80)\r\n
addr =3D 1d.2\r\n        romfile =3D \"\"\r\n        romsize =3D 4294967295
(0xffffffff)\r\n        rombar =3D 1 (0x1)\r\n        multifunction =3D
true\r\n        x-pcie-lnksta-dllla =3D true\r\n
x-pcie-extcap-init =3D true\r\n        failover_pair_id =3D \"\"\r\n
 acpi-index =3D 0 (0x0)\r\n        x-pcie-err-unc-mask =3D true\r\n
x-pcie-ari-nextfn-1 =3D false\r\n        x-max-bounce-buffer-size =3D 4096
(4 KiB)\r\n        x-pcie-ext-tag =3D false\r\n        busnr =3D 0
(0x0)\r\n        class USB controller, addr 00:1d.2, pci id 8086:2936
(sub 1af4:1100)\r\n        bar 4: i/o at 0x7060 [0x707f]\r\n      dev:
ich9-usb-uhci2, id \"\"\r\n        masterbus =3D \"usb-bus.0\"\r\n
 firstport =3D 2 (0x2)\r\n        bandwidth =3D 1280 (0x500)\r\n
maxframes =3D 128 (0x80)\r\n        addr =3D 1d.1\r\n        romfile =3D
\"\"\r\n        romsize =3D 4294967295 (0xffffffff)\r\n        rombar =3D
1 (0x1)\r\n        multifunction =3D true\r\n        x-pcie-lnksta-dllla
=3D true\r\n        x-pcie-extcap-init =3D true\r\n
failover_pair_id =3D \"\"\r\n        acpi-index =3D 0 (0x0)\r\n
x-pcie-err-unc-mask =3D true\r\n        x-pcie-ari-nextfn-1 =3D false\r\n
      x-max-bounce-buffer-size =3D 4096 (4 KiB)\r\n
x-pcie-ext-tag =3D false\r\n        busnr =3D 0 (0x0)\r\n        class USB
controller, addr 00:1d.1, pci id 8086:2935 (sub 1af4:1100)\r\n
bar 4: i/o at 0x7080 [0x709f]\r\n      dev: ich9-usb-uhci1, id
\"\"\r\n        masterbus =3D \"usb-bus.0\"\r\n        firstport =3D 0
(0x0)\r\n        bandwidth =3D 1280 (0x500)\r\n        maxframes =3D 128
(0x80)\r\n        addr =3D 1d.0\r\n        romfile =3D \"\"\r\n
romsize =3D 4294967295 (0xffffffff)\r\n        rombar =3D 1 (0x1)\r\n
  multifunction =3D true\r\n        x-pcie-lnksta-dllla =3D true\r\n
 x-pcie-extcap-init =3D true\r\n        failover_pair_id =3D \"\"\r\n
  acpi-index =3D 0 (0x0)\r\n        x-pcie-err-unc-mask =3D true\r\n
 x-pcie-ari-nextfn-1 =3D false\r\n        x-max-bounce-buffer-size =3D
4096 (4 KiB)\r\n        x-pcie-ext-tag =3D false\r\n        busnr =3D 0
(0x0)\r\n        class USB controller, addr 00:1d.0, pci id 8086:2934
(sub 1af4:1100)\r\n        bar 4: i/o at 0x70a0 [0x70bf]\r\n      dev:
ich9-usb-ehci1, id \"\"\r\n        maxframes =3D 128 (0x80)\r\n
addr =3D 1d.7\r\n        romfile =3D \"\"\r\n        romsize =3D 4294967295
(0xffffffff)\r\n        rombar =3D 1 (0x1)\r\n        multifunction =3D
true\r\n        x-pcie-lnksta-dllla =3D true\r\n
x-pcie-extcap-init =3D true\r\n        failover_pair_id =3D \"\"\r\n
 acpi-index =3D 0 (0x0)\r\n        x-pcie-err-unc-mask =3D true\r\n
x-pcie-ari-nextfn-1 =3D false\r\n        x-max-bounce-buffer-size =3D 4096
(4 KiB)\r\n        x-pcie-ext-tag =3D false\r\n        busnr =3D 0
(0x0)\r\n        class USB controller, addr 00:1d.7, pci id 8086:293a
(sub 1af4:1100)\r\n        bar 0: mem at 0x88643000 [0x88643fff]\r\n
     bus: usb-bus.0\r\n          type usb-bus\r\n          dev:
usb-tablet, id \"input0\"\r\n            usb_version =3D 2 (0x2)\r\n
       display =3D \"\"\r\n            head =3D 0 (0x0)\r\n
port =3D \"\"\r\n            serial =3D \"\"\r\n            msos-desc =3D
true\r\n            pcap =3D \"\"\r\n            addr 0.0, port 1, speed
480, name QEMU USB Tablet, attached\r\n      dev: ich9-ahci, id
\"\"\r\n        addr =3D 1f.2\r\n        romfile =3D \"\"\r\n
romsize =3D 4294967295 (0xffffffff)\r\n        rombar =3D 1 (0x1)\r\n
  multifunction =3D true\r\n        x-pcie-lnksta-dllla =3D true\r\n
 x-pcie-extcap-init =3D true\r\n        failover_pair_id =3D \"\"\r\n
  acpi-index =3D 0 (0x0)\r\n        x-pcie-err-unc-mask =3D true\r\n
 x-pcie-ari-nextfn-1 =3D false\r\n        x-max-bounce-buffer-size =3D
4096 (4 KiB)\r\n        x-pcie-ext-tag =3D false\r\n        busnr =3D 0
(0x0)\r\n        class SATA controller, addr 00:1f.2, pci id 8086:2922
(sub 1af4:1100)\r\n        bar 4: i/o at 0x7040 [0x705f]\r\n
bar 5: mem at 0x88642000 [0x88642fff]\r\n        bus: ide.5\r\n
  type IDE\r\n        bus: ide.4\r\n          type IDE\r\n        bus:
ide.3\r\n          type IDE\r\n        bus: ide.2\r\n          type
IDE\r\n        bus: ide.1\r\n          type IDE\r\n        bus:
ide.0\r\n          type IDE\r\n      dev: ICH9-LPC, id \"\"\r\n
gpio-out \"gsi\" 24\r\n        noreboot =3D false\r\n        smm-compat
=3D false\r\n        smm-enabled =3D true\r\n        x-smi-broadcast =3D
true\r\n        x-smi-cpu-hotplug =3D true\r\n
x-smi-cpu-hotunplug =3D true\r\n        x-smi-swsmi-timer =3D false\r\n
    x-smi-periodic-timer =3D false\r\n        addr =3D 1f.0\r\n
romfile =3D \"\"\r\n        romsize =3D 4294967295 (0xffffffff)\r\n
rombar =3D 1 (0x1)\r\n        multifunction =3D true\r\n
x-pcie-lnksta-dllla =3D true\r\n        x-pcie-extcap-init =3D true\r\n
    failover_pair_id =3D \"\"\r\n        acpi-index =3D 0 (0x0)\r\n
x-pcie-err-unc-mask =3D true\r\n        x-pcie-ari-nextfn-1 =3D false\r\n
      x-max-bounce-buffer-size =3D 4096 (4 KiB)\r\n
x-pcie-ext-tag =3D false\r\n        busnr =3D 0 (0x0)\r\n        class ISA
bridge, addr 00:1f.0, pci id 8086:2918 (sub 1af4:1100)\r\n        bus:
isa.0\r\n          type ISA\r\n          dev: isa-serial, id
\"serial0\"\r\n            index =3D 0 (0x0)\r\n            iobase =3D
1016 (0x3f8)\r\n            irq =3D 4 (0x4)\r\n          dev: pvpanic,
id \"\"\r\n            ioport =3D 1285 (0x505)\r\n            events =3D 7
(0x7)\r\n          dev: port92, id \"\"\r\n            gpio-out
\"a20\" 1\r\n          dev: vmmouse, id \"\"\r\n          dev: vmport,
id \"\"\r\n            x-read-set-eax =3D true\r\n
x-signal-unsupported-cmd =3D true\r\n            x-report-vmx-type =3D
true\r\n            x-cmds-v2 =3D true\r\n            vmware-vmx-version
=3D 6 (0x6)\r\n            vmware-vmx-type =3D 2 (0x2)\r\n          dev:
i8042, id \"\"\r\n            gpio-in \"ps2-mouse-input-irq\" 1\r\n
        gpio-in \"ps2-kbd-input-irq\" 1\r\n            gpio-out \"\"
2\r\n            gpio-out \"a20\" 1\r\n            extended-state =3D
true\r\n            kbd-throttle =3D false\r\n            kbd-irq =3D 1
(0x1)\r\n            mouse-irq =3D 12 (0xc)\r\n          dev: isa-pcspk,
id \"\"\r\n            audiodev =3D \"\"\r\n            iobase =3D 97
(0x61)\r\n            migrate =3D true\r\n          dev: isa-pit, id
\"\"\r\n            gpio-in \"\" 1\r\n            gpio-out \"\" 1\r\n
          iobase =3D 64 (0x40)\r\n          dev: isa-i8259, id \"\"\r\n
          gpio-in \"\" 8\r\n            gpio-out \"\" 1\r\n
iobase =3D 160 (0xa0)\r\n            elcr_addr =3D 1233 (0x4d1)\r\n
    elcr_mask =3D 222 (0xde)\r\n            master =3D false\r\n
dev: isa-i8259, id \"\"\r\n            gpio-in \"\" 8\r\n
gpio-out \"\" 1\r\n            iobase =3D 32 (0x20)\r\n
elcr_addr =3D 1232 (0x4d0)\r\n            elcr_mask =3D 248 (0xf8)\r\n
       master =3D true\r\n          dev: mc146818rtc, id \"\"\r\n
    gpio-out \"\" 1\r\n            base_year =3D 0 (0x0)\r\n
iobase =3D 112 (0x70)\r\n            irq =3D 8 (0x8)\r\n
lost_tick_policy =3D \"discard\"\r\n          dev: i8257, id \"\"\r\n
        base =3D 192 (0xc0)\r\n            page-base =3D 136 (0x88)\r\n
        pageh-base =3D -1 (0xffffffffffffffff)\r\n            dshift =3D 1
(0x1)\r\n          dev: i8257, id \"\"\r\n            base =3D 0
(0x0)\r\n            page-base =3D 128 (0x80)\r\n            pageh-base
=3D -1 (0xffffffffffffffff)\r\n            dshift =3D 0 (0x0)\r\n
dev: mch, id \"\"\r\n        extended-tseg-mbytes =3D 16 (0x10)\r\n
  smbase-smram =3D true\r\n        addr =3D 00.0\r\n        romfile =3D
\"\"\r\n        romsize =3D 4294967295 (0xffffffff)\r\n        rombar =3D
1 (0x1)\r\n        multifunction =3D false\r\n
x-pcie-lnksta-dllla =3D true\r\n        x-pcie-extcap-init =3D true\r\n
    failover_pair_id =3D \"\"\r\n        acpi-index =3D 0 (0x0)\r\n
x-pcie-err-unc-mask =3D true\r\n        x-pcie-ari-nextfn-1 =3D false\r\n
      x-max-bounce-buffer-size =3D 4096 (4 KiB)\r\n
x-pcie-ext-tag =3D false\r\n        busnr =3D 0 (0x0)\r\n        class
Host bridge, addr 00:00.0, pci id 8086:29c0 (sub 1af4:1100)\r\n  dev:
fw_cfg_io, id \"\"\r\n    dma_enabled =3D true\r\n    x-file-slots =3D 32
(0x20)\r\n    acpi-mr-restore =3D true\r\n  dev: kvmclock, id \"\"\r\n
 x-mach-use-reliable-get-clock =3D true\r\n  dev: kvmvapic, id
\"\"\r\n"}


> 2) whether the migration with if you disabled those features explicitly i=
n 9.2.4
Could you tell me, how to disable these features?
I tried this change on both source  and target qemu, but still see the
same error, althrough info virtio-status no longer report these
features.
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3984,11 +3984,11 @@ static Property virtio_net_properties[] =3D {
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
     DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
     DEFINE_PROP_BIT64("guest_uso4", VirtIONet, host_features,
-                      VIRTIO_NET_F_GUEST_USO4, true),
+                      VIRTIO_NET_F_GUEST_USO4, false),
     DEFINE_PROP_BIT64("guest_uso6", VirtIONet, host_features,
-                      VIRTIO_NET_F_GUEST_USO6, true),
+                      VIRTIO_NET_F_GUEST_USO6, false),
     DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
-                      VIRTIO_NET_F_HOST_USO, true),
+                      VIRTIO_NET_F_HOST_USO, false),
     DEFINE_PROP_END_OF_LIST(),
 };


>
> > Or should QEMU handle such feature mismatches more gracefully (e.g.,
> > automatically disable unsupported virtio features during migration)?
>
> This would break guests as it could be noticed by guests.
understood.
>
> >
> > Any guidance on how to make migration between these versions work
> > would be appreciated.
> >
> > ________________________________
> >
> > Thanks,
> > Jinpu Wang @ IONOS Cloud
> >
>
> Thanks
>

