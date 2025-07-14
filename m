Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEAEC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSGj-00043A-Dx; Mon, 14 Jul 2025 19:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGC-00039Z-Vs
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSG7-0005Pm-Ta
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f0tptr6+DBk/1t6IxS7PRmBfpvVQbdhJXMgxOw/JOQw=;
 b=M4KcEEggi37GB4xbNJ7w9MNCbGls/hvVjM6zRhf0qliCRAldsXaD/+36vPU0kGcMraddVX
 h2frAXntl3HLeM8N7eI8XrcOGnlbvo2IgMG0SMSKB3dTRLVg2BODrzhZFH+mxRYNqeHwir
 F55SedHP1XAYsDoKi1qfLUXdnlSakp0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-RxlxYS-DO4eExP6LdI-IsQ-1; Mon, 14 Jul 2025 19:06:53 -0400
X-MC-Unique: RxlxYS-DO4eExP6LdI-IsQ-1
X-Mimecast-MFC-AGG-ID: RxlxYS-DO4eExP6LdI-IsQ_1752534413
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f3796779so2162881f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534412; x=1753139212;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0tptr6+DBk/1t6IxS7PRmBfpvVQbdhJXMgxOw/JOQw=;
 b=SCA7jaqufbklRi+gTgwMxP1c8qZoEy0qK2s1+GEC7In4dzCJAl3u07bsgv7e3vwcza
 JmG0zrfuOllHt/8g3vkz4V0qaeIMZfYdisLq9hebY3+GippAeQlHnBA+7ovLTuRs1MTc
 j4TzyqY9TgyLkmzZ3QHwOD6XelJzpmo/e0Kgr4JthIuq6dgM4EzUBSbDsLXSALVOhiXQ
 l64ceJsFMDfGyF1vOdp8cXlbkD9JM+D2mgJN2FH02xEIo/tZI57szEN7vwnXinIp9+SS
 kwHnjML1RpBS3wnWGE15R4xlRGlEUd1HoUBNmAmrQ7m0p+V8FoYrw/VsKw5tDy/i4Fnj
 viow==
X-Gm-Message-State: AOJu0Yz5dL9q/7Gdf3Va7gBspG68fn1onjmrXxIAykLtE+bjDBx0+jup
 HWxcTNGOILj+Ulw3mK7W3o4dQeprYec8DKaUciHtfAE2qfmkrmHryeIx/fnKgYxK8sVOu2FtE+p
 e5JGq9Hc+dCtdHtBJjehKDvrvqjLj5alFT6iSuJxa7TfIJnSiOumbZ4HWZrZS9mmBMrc7CRLgjb
 sXpvGPpAPAE2RBTvjCamm52DFoTnkp5QCnQw==
X-Gm-Gg: ASbGncuMHXM++xbgiMoy03u0ugV6xjAuu1lDg3o3TlD547sTCJ5/sKxS7DtYqQBY3CQ
 nR9tNVRxMQzTZ0GQah4z5WQgzyca6hzV6/zNDeQkyIZ+lOiVJFMTN+WCjTUpqrTYT4iVkJU/8ng
 01XpobXka37jSn2COP4znN7lvGiSnKNHyFjxh7mr2s8LmxnIGTHYKdasSIOMyS2HwkXhx+fwxaH
 ge00UQo4+PJpvq8qNfYDT2hr1Xra0w6Pgw52dZNqXRorMoDRswOopMp52iwPKxIMsRgl4P8cMXq
 gZ4IsKkuywzXDrO9Z4V4cGmLJMidPdOQ
X-Received: by 2002:adf:f3c5:0:b0:3a5:8abe:a264 with SMTP id
 ffacd0b85a97d-3b60a195cb3mr215492f8f.37.1752534411930; 
 Mon, 14 Jul 2025 16:06:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ4XwGsCx7wDaGh00qAYUA459URf4A9gVhZSNEWT/lJQ0ZuSdM1xJQrnaUI8Vt7he6E522Lw==
X-Received: by 2002:adf:f3c5:0:b0:3a5:8abe:a264 with SMTP id
 ffacd0b85a97d-3b60a195cb3mr215475f8f.37.1752534411279; 
 Mon, 14 Jul 2025 16:06:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45626c9ac1dsm3518045e9.0.2025.07.14.16.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:50 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 14/97] tests/acpi: Fill acpi table data for LoongArch
Message-ID: <67fbf12288df10eb1ea76d4f48d6a8efa46ae65c.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

The acpi table data is filled for LoongArch virt machine with the
following command:
  tests/data/acpi/rebuild-expected-aml.sh

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20250612090321.3416594-5-maobibo@loongson.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/loongarch64/virt/APIC          | Bin 0 -> 108 bytes
 tests/data/acpi/loongarch64/virt/APIC.topology | Bin 0 -> 153 bytes
 tests/data/acpi/loongarch64/virt/DSDT          | Bin 0 -> 4641 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp    | Bin 0 -> 5862 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem  | Bin 0 -> 4647 bytes
 tests/data/acpi/loongarch64/virt/DSDT.topology | Bin 0 -> 4943 bytes
 tests/data/acpi/loongarch64/virt/FACP          | Bin 0 -> 268 bytes
 tests/data/acpi/loongarch64/virt/MCFG          | Bin 0 -> 60 bytes
 tests/data/acpi/loongarch64/virt/PPTT          | Bin 0 -> 76 bytes
 tests/data/acpi/loongarch64/virt/PPTT.topology | Bin 0 -> 176 bytes
 tests/data/acpi/loongarch64/virt/SLIT.numamem  | Bin 0 -> 48 bytes
 tests/data/acpi/loongarch64/virt/SPCR          | Bin 0 -> 80 bytes
 tests/data/acpi/loongarch64/virt/SRAT          | Bin 0 -> 104 bytes
 tests/data/acpi/loongarch64/virt/SRAT.memhp    | Bin 0 -> 144 bytes
 tests/data/acpi/loongarch64/virt/SRAT.numamem  | Bin 0 -> 144 bytes
 tests/data/acpi/loongarch64/virt/SRAT.topology | Bin 0 -> 152 bytes
 16 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/data/acpi/loongarch64/virt/APIC.topology
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.memhp
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.numamem
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.topology
 create mode 100644 tests/data/acpi/loongarch64/virt/PPTT.topology
 create mode 100644 tests/data/acpi/loongarch64/virt/SLIT.numamem
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.memhp
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.numamem
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.topology

diff --git a/tests/data/acpi/loongarch64/virt/APIC b/tests/data/acpi/loongarch64/virt/APIC
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..3477789f422cad54f16734b3ec9ad1ff5135165d 100644
GIT binary patch
literal 108
zcmZ<^@N~{$U|?YU>g4b25v<@85#X$#prF9Wz`y`vgJ=){(SrOi9+)e_%gD^||35@t
fRG5*0;e$Si<G{ecaDah<K}-;&TmURD01^fOGLQ@b

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/APIC.topology b/tests/data/acpi/loongarch64/virt/APIC.topology
new file mode 100644
index 0000000000000000000000000000000000000000..da0089d57f608aca230a76b67e72f9f0ad8e71f2
GIT binary patch
literal 153
zcmXwxK?=h#3<O8<xx}Vv&-y{Xkl2^zlt7^LYyC~1lpnZk6APBrNXt&^Tt0xk@=~6g
y=l5FN-3`z#*T_@fsG+zi_0|E>84iFX94;29^(ebt4fcm%1irvMDHZ?!sPhj~I1B**

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..f32e732b11a557ae01c7f383625d3b6f459ac9f7 100644
GIT binary patch
literal 4641
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

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.memhp b/tests/data/acpi/loongarch64/virt/DSDT.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..f19eae7d00f9c0eefc9e92de2c8a24863bf309d6
GIT binary patch
literal 5862
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

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.numamem b/tests/data/acpi/loongarch64/virt/DSDT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..9b462869cd4911714e7c2a22025c465afa2a7d52
GIT binary patch
literal 4647
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
BB|QKD

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.topology b/tests/data/acpi/loongarch64/virt/DSDT.topology
new file mode 100644
index 0000000000000000000000000000000000000000..65111aa822663a907b83487cb496be38a4bdff05
GIT binary patch
literal 4943
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

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/FACP b/tests/data/acpi/loongarch64/virt/FACP
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..04d8d4c26fa2be24af40cd7a72959ec6b12790e5 100644
GIT binary patch
literal 268
zcmZ>BbPnKQWME+Ra`Jcf2v%^42yj+VP*7lGU|;~TK{QnXivR-y2Lpo~1D^oMTqmj;
RP9)%9V32{@4`Rzg*#Io}2LS*8

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/MCFG b/tests/data/acpi/loongarch64/virt/MCFG
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..5f93b05abe1669fe4239edbba8aaf4fe666f5b95 100644
GIT binary patch
literal 60
tcmeZuc5}C3U|?XJ<K*w`5v<@85#X$#prF9Wz`y`vgJ>k60A<&MXaFUp2LS*8

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/PPTT b/tests/data/acpi/loongarch64/virt/PPTT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..7a1258ecf123555b24462c98ccbb76b4ac1d0c2b 100644
GIT binary patch
literal 76
zcmWFt2nq3FU|?Wc;pFe^5v<@85#X$#prF9Wz`y`vgJ=d31_m&V3`7_hxEL51RFK2~
DqXGv3

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/PPTT.topology b/tests/data/acpi/loongarch64/virt/PPTT.topology
new file mode 100644
index 0000000000000000000000000000000000000000..d91e55b2399d9949dbb8e4c8cf634af1a0e56df4
GIT binary patch
literal 176
zcmWFt2npH1z`($y@8s|75v<@85#X$#prF9Wz`y`vgJ=d31_m&V3`8It6*MtE1_lNT
b9Aa=Ykn|#pf%KMu+yc`t!T=XzhKd0IvU~{v

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SLIT.numamem b/tests/data/acpi/loongarch64/virt/SLIT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..67f00813af7b2356fe74eed943ab8dcf2291578b
GIT binary patch
literal 48
ucmWIc@eDCwU|?W;;pFe^5v<@85#X$#prF9Wz`y`vgJ>oO2;dSG<pKcYv<CqI

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..3cc9bbcfb8051e632592d9db0fe3dba0af53ed8d 100644
GIT binary patch
literal 80
zcmXYnu@QhU48&w87=xe1Zs_olhIQE_o0v;L&Fk;fGOh%c$Im#L{LYXh1BQ>C2<z7O
O?>MkwuvS(5#pDG+#ti`g

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SRAT b/tests/data/acpi/loongarch64/virt/SRAT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..ff234ce45cbdd32f57fc0668aba135992e5ca887 100644
GIT binary patch
literal 104
zcmWFzatz5}U|?We=j89~5v<@85#X$#prF9Wz`y`vgJ=+j0|8V%qXt|C1~_00WPJc=
C#|Hrb

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SRAT.memhp b/tests/data/acpi/loongarch64/virt/SRAT.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..525321890138de509ceaf9723f0a4565048e823f
GIT binary patch
literal 144
zcmWFzatxWkz`(%h<>c?|5v<@85#X$#prF9Wz`y`vgJ=+j0|8V%qXt|C1~_00WPM2L
PVDd1Uff=TOfq?-4Y8D3p

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SRAT.numamem b/tests/data/acpi/loongarch64/virt/SRAT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..2972a9abdcface5b943078d61b4946da80176ea2
GIT binary patch
literal 144
zcmWFzatxWkz`(#5?&R<65v<@85#X$#prF9Wz`y`vgJ=+j0|8V%qXt|C23TMWWPOYp
Ma2`w^Mx&?$0B=JF0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SRAT.topology b/tests/data/acpi/loongarch64/virt/SRAT.topology
new file mode 100644
index 0000000000000000000000000000000000000000..4a44831f475b5fda1db9bed12c2e63a79d6d6e71
GIT binary patch
literal 152
zcmWFzatxWlz`(%h>g4b25v<@85#X$#prF9Wz`y`vgJ=+j0|5*^Bbq!D8lM@N&!_=6
L2?jV|3}kfxpjih2

literal 0
HcmV?d00001

-- 
MST


