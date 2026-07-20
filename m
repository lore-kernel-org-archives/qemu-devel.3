Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1533C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wllwt-00027I-6t; Mon, 20 Jul 2026 07:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wllwr-00026L-16
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:14:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wllwn-0004f8-VE
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:14:12 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAw3bL2377675
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LEyZ0VdPI8qnN7qztrOzNewuskZWQ+USZWImNtQQ40s=; b=BqL7tkQeQqusRhq+
 JLPWCpe1oct5DCWPRtEUvGoqATJ/NTKnDZV7bd+TWlX5EsU2mfLDwGUTzJSeNWgB
 fj7CUo5VS9/BP+qOHgBy3G34b3Ku8OLQxUaw6EBkFUtIPZDy4let22diMtXZTYpJ
 +hRg6rDl8rNWBT4qLzuE/xc4r4q3XtPGHq6Aia5tW9wkNpEhc3NG9frquF6DVM1o
 rYLvFDKJ/pRaP4pqmkkOyY8KK9QE5SxtPPUs5FB+P2zSLnOy80QfJ0w6PLTqJXH8
 U+mjoSG+RO8ZhvqKY2boJSTiR1o8HHbVLxiU5wtgQ6tAlmHfFKxHh7LDQOeKJTEF
 fQncKQ==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgre8kh3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:14:08 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6678923f351so1338113d50.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784546048; cv=none;
 d=google.com; s=arc-20260327;
 b=GXZJa0EA3hidU5rBR5InQ9eqzHTSJRqxJRx4KYzayUXIUS/fibhMw9l5PjM3C5WVn4
 vb6WvpvuxXM9SKysTr9cbkelgpaJTzvsY1WS7GtxW2BlcBxa7sqJDeJI3Lm8EHkMpgj0
 Wrqlsy3kiLmzr24Ni7lrIe15zlJGnppeYM7/G0fp/DB/tLxVKWz0/Jn2r9hHV12yvquk
 zMuPHaLW3CWT8x2g8Lbp6M8P1MKSh6bfALjlSSfb7AhsgULxnZe2tns7H7H0Z/OY3dRp
 RBvCiUwvmpkoyMl3fHSyuTSgML7KZro0/9sRTSX7I8P9Wrm0IgC8Pn2SViwip9MoJ4tP
 vMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LEyZ0VdPI8qnN7qztrOzNewuskZWQ+USZWImNtQQ40s=;
 fh=x/1v+VkfFtXaMG7zPgYrl14s+/Aa+2wmalG6x+2MYvY=;
 b=nvM7IUlNb9gXM1cVfSSOIxo45SfnCVN1tVnRucIXj53LoHhQ/6yjd2IV4ye5at2ze1
 g0+9/CFSMbJY8XPE5FmWqc3vv85LmRHJQdCSBacCP4QmJ4F/jO0iABYY4ZKkyx4Evqdi
 CVW09YTrnciGbD2JYviXra+TaIQsO1fwviMPkNyEpGcTw67v9RG14XDyHVhnbrqhlXby
 9v1Dn1yMp8wOsNQGYDJ30qEfxflD3mHL00tbPbOXJqelLQ+NgQuYsxcuNPYfDEr5FUqf
 THEIYGV1Ar6Da6otaOm7xG08xltHTmaEJx2Z1K3S8CaXn6ML2AFSAZ58uqiJYtWkfKhF
 56Hg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784546048; x=1785150848; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LEyZ0VdPI8qnN7qztrOzNewuskZWQ+USZWImNtQQ40s=;
 b=QM0PHSYnPIHRRdHua5S6fy6AVE0jqHgzuXIe8aDLiL8/NU/CLKjL9xGLdvmgWdL+52
 OJ7gKmmvcgjCDHQmRyVRKMdbIN/BXTJEvc7Se07YDvMfevJkF4afHcmaclfzYYoq5Lix
 wBQp2EhqdidAMwtLD10kAtdXbWXyHnfeT+mWN4ffxgf0Lgc+1/4v2vnmY9WpJZEj3RCu
 ZYoVrgc71HTY9/tHJSRI00IcANOhpE4l0gwvoZxAdRlIC//eobjNkcycsZ64Qnwt2z7r
 cUdTJ8uApIAX0qBT22agRKev6Cv3vPUwe6uqsNelpVTBKBnI5BMZdvweiKxNtv3O/I1U
 4Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784546048; x=1785150848;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LEyZ0VdPI8qnN7qztrOzNewuskZWQ+USZWImNtQQ40s=;
 b=Y73JWRlPpwqzpwkx1AvOgB+4ZKxxFFnwfeNvFMvUvn5/ba3PM9Pg6scEb92J3NPlDQ
 nITQoR7xpzIupq4kHuN3bk9Qwp1DYv1enRRlUDyUrwzT+SjuUo1z9FjXPbNY1PJErjuB
 lJ+sTRBz3CB92mvRAa3NBlRQ4Gzl9Ba6pzfwyBkklEVoCU44yJUexV5QR6+s2vAPxdaa
 ss3mG0aU/UZjdg2JM6+HYvlqR4dQX7W01g6jKKF0I1jAd29kCxaacQUZN7SJpKVhF7n7
 tmgTKXbnb1fckaFgPtsqzlgHbuecD3TNsGfaq88YmV4O/PrQyJHxMh4/byluxfal1hGi
 5C6w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/veRhaP5VxA0f901pW2hu90LB+JF5GKQ3lFyh9nixnv40MJt3B4fKg3PwFyy4xdR6Kq4nsUkS/tY3@nongnu.org
X-Gm-Message-State: AOJu0YxtQTK6JAcaPL37Ws260NpLVMZ50Rwi0Ok77np6bQKkEqzyYk6N
 YYY6T4kmU4DgRkkufxHgYnuB6mo+iVaUwlegFiEbGHY/WtgqWKVVZuSM8Ym+rTdTFrVc0m+zhlZ
 TDmdm4dLdNwtFtoZQKtwZjiRhzAOTI6d4bnQ4yQaDPeC4yqe4km4631L2seO4RH3FekVU/D2qsx
 ethrnH718PS6vR1ubyvPn8ho+9ABaw/7Fh
X-Gm-Gg: AR+sD10GYkJWvR4suNQRKLYhXjFVFhn8AtV4FXArbc34Lvlgwj1c46+7MtkCZXE8Ems
 /L1mLrTbfEq6Ew274GczVBB8jV1PZ/xKOw5rFHbj/xUAXeVpeF5rSTSd72C5noFb+LJgNNSPJEp
 ehWEzfcP5bgVAVKY6r6ZrfRezSerwH6ChsXfRBng+sK9slWExWfFkphcQl330=
X-Received: by 2002:a05:690c:6893:b0:7fd:6d19:5a8d with SMTP id
 00721157ae682-81f21008e09mr543867b3.8.1784546047880; 
 Mon, 20 Jul 2026 04:14:07 -0700 (PDT)
X-Received: by 2002:a05:690c:6893:b0:7fd:6d19:5a8d with SMTP id
 00721157ae682-81f21008e09mr543737b3.8.1784546047350; Mon, 20 Jul 2026
 04:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260714075659.2258023-11-subrahmanya.lingappa@oss.qualcomm.com>
 <e4c52a4d-9464-4a8b-92ea-7ab1197e9bea@oss.qualcomm.com>
In-Reply-To: <e4c52a4d-9464-4a8b-92ea-7ab1197e9bea@oss.qualcomm.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:43:55 +0530
X-Gm-Features: AUfX_mxKa0Y_Ys_6l9bKdYHHXcCEaCAU--9sypnglTQp7XklBh7C0sLsqFImwrY
Message-ID: <CAPxK-6dqqCSpN1e1u7W1mCvYzj8cgo7YyuGtALMOHH_wW+kYOA@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] tests/functional: add initial RPMI virt guest
 smoke
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyNSBTYWx0ZWRfXygtrr9I8y/rO
 MPZNIlqQKEx+yz2IfyAddE/PonQrbyiT+MkEwwpIzTp7sQGj7BEgcydSm+ctxkXDJ+yTKMmLTuA
 bBg0UunptnVP+5FuAJiU2kBb9+60/ic=
X-Proofpoint-GUID: pms7bTFIXSUquoX2i_I87ddWroMjpl41
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyNSBTYWx0ZWRfX/lhhNHoNVACe
 jvbH3HttZle6wMU76XK27Sskr7H7bsKeOIzm2R0ZyH5s4KTvAQNF+gEdvVBq7vC7kxlMXn3dcpH
 no5B0ycIjDXozSc3xk7vITdGZ/mQfEIQ9CDvJq/uWcYVuoPAPUnz233tVL0BZPKaGAEcKMYQ+4v
 EsZrmJMHbcTaq3j/j+Mfw3tO9k8xy1fg7i+lQ5UN1GBNoEWt/6wNf0acNxKVUZ6ShDr3gZ7oi9U
 kammVwZxItkWgOF5MepQPuopzUCXGt6lk4zagR9FxI/Hvy3TlNsz5jZQWgZsf4G457VPskMoLUA
 xuvx69E81g3/9XPCUeiWXUT4N2ZAXXt+CHlOJ49Qdbg86GgtjBW9s2SmmuLijzRn7uFSu1rCatu
 qC0kTdZ4WcAZS+A4Hz/oBibNKo9AQPtvW8E2fXwOZERgThXz4va8aJ9QFDp8PQ3G94VN62jK9wl
 dFFn0PTcESooxXtQdrQ==
X-Proofpoint-ORIG-GUID: pms7bTFIXSUquoX2i_I87ddWroMjpl41
X-Authority-Analysis: v=2.4 cv=foLsol4f c=1 sm=1 tr=0 ts=6a5e0300 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=Ayrw5RST0pfP7v9F7AAA:9
 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200125
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Daniel

On Fri, Jul 17, 2026 at 6:56=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
>
>
> On 7/14/2026 4:56 AM, Subrahmanya Lingappa wrote:
> > Boot an RPMI-enabled RISC-V virt guest and exercise the initial HSM,
> > system suspend, and system reset paths.
> >
> > Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.=
com>
> > ---
> >   tests/functional/riscv64/meson.build       |   2 +
> >   tests/functional/riscv64/test_rpmi_virt.py | 172 ++++++++++++++++++++=
+
> >   2 files changed, 174 insertions(+)
> >   create mode 100644 tests/functional/riscv64/test_rpmi_virt.py
> >
> > diff --git a/tests/functional/riscv64/meson.build b/tests/functional/ri=
scv64/meson.build
> > index 5871211e89..619a0735fa 100644
> > --- a/tests/functional/riscv64/meson.build
> > +++ b/tests/functional/riscv64/meson.build
> > @@ -3,6 +3,7 @@
> >   test_riscv64_timeouts =3D {
> >     'boston' : 120,
> >     'tuxrun' : 120,
> > +  'rpmi_virt' : 300,
> >   }
> >
> >   tests_riscv64_system_quick =3D [
> > @@ -15,4 +16,5 @@ tests_riscv64_system_thorough =3D [
> >     'boston',
> >     'sifive_u',
> >     'tuxrun',
> > +  'rpmi_virt',
> >   ]
> > diff --git a/tests/functional/riscv64/test_rpmi_virt.py b/tests/functio=
nal/riscv64/test_rpmi_virt.py
> > new file mode 100644
> > index 0000000000..c0f96f7d8d
> > --- /dev/null
> > +++ b/tests/functional/riscv64/test_rpmi_virt.py
> > @@ -0,0 +1,172 @@
> > +#!/usr/bin/env python3
> > +#
> > +# RISC-V virt RPMI Linux guest integration tests
> > +#
> > +# Copyright (c) 2026 Ventana Micro Systems Inc.
>
> We can't add a Ventana copyright dated 2026.  Ventana as an entity ceased=
 to
> exist December 2025.
>
>
> Everything else LGTM.  Thanks,
> Daniel
>
 missed it before,  Fixed in v4. I dropped the stale Ventana Micro
Systems Inc. copyright
  line from the functional test.

thanks,
subbu

>
> > +# Copyright (c) 2026 Qualcomm Technologies, Inc.
> > +#
> > +# Author:
> > +#  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +import os
> > +from pathlib import Path
> > +import subprocess
> > +import time
> > +
> > +from qemu_test import QemuSystemTest
> > +from qemu_test import exec_command
> > +from qemu_test import exec_command_and_wait_for_pattern
> > +from qemu_test import get_qemu_img
> > +from qemu_test import wait_for_console_pattern
> > +
> > +
> > +class RiscvVirtRpmiGuestTest(QemuSystemTest):
> > +    """Boot Linux and exercise RPMI-backed services through guest APIs=
.
> > +
> > +    This test intentionally keeps guest artifacts external. Set:
> > +
> > +      QEMU_TEST_RPMI_OPENSBI=3D/path/to/fw_jump.bin
> > +      QEMU_TEST_RPMI_KERNEL=3D/path/to/Image
> > +      QEMU_TEST_RPMI_ROOTFS=3D/path/to/rootfs.ext4
> > +
> > +    Exact RPMI packet command-ID coverage remains in riscv-rpmi qtests=
. This
> > +    functional test verifies Linux/OpenSBI integration paths visible f=
rom a
> > +    real guest without adding probe hooks to production RPMI sources.
> > +    """
> > +
> > +    timeout =3D 360
> > +    PROMPT =3D 'root@tuxtest:~#'
> > +
> > +    def _require_path(self, env_name):
> > +        value =3D os.getenv(env_name)
> > +        if not value:
> > +            self.skipTest(f'{env_name} is required')
> > +        path =3D Path(value)
> > +        if not path.exists():
> > +            self.skipTest(f'{env_name} does not exist: {path}')
> > +        return path
> > +
> > +    def setUp(self):
> > +        super().setUp()
> > +        self.opensbi =3D self._require_path('QEMU_TEST_RPMI_OPENSBI')
> > +        self.kernel =3D self._require_path('QEMU_TEST_RPMI_KERNEL')
> > +        self.rootfs =3D self._require_path('QEMU_TEST_RPMI_ROOTFS')
> > +        self.qemu_img =3D get_qemu_img(self)
> > +
> > +    def _create_rootfs_overlay(self):
> > +        overlay =3D Path(self.scratch_file('rootfs.qcow2'))
> > +        subprocess.run([
> > +            self.qemu_img, 'create', '-q', '-f', 'qcow2', '-F', 'raw',
> > +            '-b', str(self.rootfs), str(overlay),
> > +        ], check=3DTrue)
> > +        return overlay
> > +
> > +    def _boot_guest(self, smp=3D4):
> > +        self.set_machine('virt')
> > +        self.machine =3D 'virt,rpmi=3Don,aia=3Daplic-imsic'
> > +        rootfs_overlay =3D self._create_rootfs_overlay()
> > +
> > +        self.vm.set_console()
> > +        self.vm.add_args(
> > +            '-cpu', 'rv64',
> > +            '-smp', str(smp),
> > +            '-m', '1G',
> > +            '-bios', str(self.opensbi),
> > +            '-kernel', str(self.kernel),
> > +            '-append', 'printk.time=3D0 root=3D/dev/vda rw console=3Dt=
tyS0 '
> > +                       'earlycon=3Dsbi loglevel=3D8 no_console_suspend=
',
> > +            '-blockdev', 'driver=3Dqcow2,file.driver=3Dfile,'
> > +                         f'file.filename=3D{rootfs_overlay},node-name=
=3Dhd0',
> > +            '-device', 'virtio-blk-device,drive=3Dhd0',
> > +        )
> > +        self.vm.launch()
> > +
> > +    def _expect_rpmi_firmware_and_linux(self):
> > +        patterns =3D [
> > +            'Platform HSM Device         : rpmi-hsm',
> > +            'Platform Suspend Device     : rpmi-system-suspend',
> > +            'Standard SBI Extensions',
> > +            'susp',
> > +            'tuxtest login:',
> > +        ]
> > +        for pattern in patterns:
> > +            wait_for_console_pattern(self, pattern)
> > +        exec_command_and_wait_for_pattern(self, 'root', self.PROMPT)
> > +
> > +    def _run_marker_command(self, command, marker, failure_marker=3DNo=
ne):
> > +        out =3D exec_command_and_wait_for_pattern(self, command, marke=
r,
> > +                                                failure_message=3Dfail=
ure_marker)
> > +        self.assertIn(marker.encode(), out)
> > +        return out
> > +
> > +    def _validate_hsm_boot_start(self, online_cpus):
> > +        self._run_marker_command(
> > +            'echo RPMI_LINUX_HSM_START_BEGIN; '
> > +            'cat /sys/devices/system/cpu/present; '
> > +            'online=3D$(cat /sys/devices/system/cpu/online); '
> > +            'echo "$online"; '
> > +            f'if [ "$online" =3D "{online_cpus}" ]; '
> > +            'then echo RPMI_LINUX_HSM_START_PASS; '
> > +            'else echo RPMI_LINUX_HSM_START_FAIL; fi',
> > +            'RPMI_LINUX_HSM_START_PASS', 'RPMI_LINUX_HSM_START_FAIL')
> > +
> > +    def _validate_hsm_stop(self):
> > +        self._run_marker_command(
> > +            'echo RPMI_LINUX_HSM_STOP_BEGIN; '
> > +            'if [ -w /sys/devices/system/cpu/cpu1/online ]; then '
> > +            'echo 0 > /sys/devices/system/cpu/cpu1/online && '
> > +            '[ "$(cat /sys/devices/system/cpu/online)" =3D 0 ] && '
> > +            'echo RPMI_LINUX_HSM_STOP_PASS || echo RPMI_LINUX_HSM_STOP=
_FAIL; '
> > +            'else echo RPMI_LINUX_HSM_STOP_FAIL; fi',
> > +            'RPMI_LINUX_HSM_STOP_PASS', 'RPMI_LINUX_HSM_STOP_FAIL')
> > +
> > +    def _validate_system_suspend(self):
> > +        exec_command(
> > +            self,
> > +            'echo RPMI_LINUX_SUSPEND_BEGIN; '
> > +            'if grep -qw mem /sys/power/state; then '
> > +            'echo mem > /sys/power/state; '
> > +            'else echo RPMI_LINUX_SUSPEND_FAIL; fi')
> > +        wait_for_console_pattern(self, 'RPMI_LINUX_SUSPEND_BEGIN')
> > +        wait_for_console_pattern(self, 'PM: suspend entry')
> > +        self.vm.event_wait('SUSPEND', 10)
> > +        self.vm.qmp('system_wakeup')
> > +        self.vm.event_wait('WAKEUP', 10)
> > +        wait_for_console_pattern(self, 'PM: suspend exit')
> > +        wait_for_console_pattern(self, self.PROMPT)
> > +        self._run_marker_command(
> > +            'marker=3DRPMI_LINUX_WAKEUP; echo ${marker}_PASS',
> > +            'RPMI_LINUX_WAKEUP_PASS')
> > +
> > +    def _validate_reset_poweroff(self):
> > +        exec_command(self, 'echo RPMI_LINUX_RESET_POWEROFF_BEGIN; powe=
roff -f')
> > +        wait_for_console_pattern(self, 'RPMI_LINUX_RESET_POWEROFF_BEGI=
N')
> > +        wait_for_console_pattern(self, 'reboot: Power down')
> > +        self.vm.wait()
> > +
> > +    def test_linux_guest_service_enumeration(self):
> > +        self._boot_guest(smp=3D4)
> > +        self._expect_rpmi_firmware_and_linux()
> > +        self._validate_hsm_boot_start('0-3')
> > +
> > +    def test_linux_guest_hsm_stop(self):
> > +        self._boot_guest(smp=3D2)
> > +        self._expect_rpmi_firmware_and_linux()
> > +        self._validate_hsm_boot_start('0-1')
> > +        self._validate_hsm_stop()
> > +
> > +    def test_linux_guest_suspend(self):
> > +        self._boot_guest(smp=3D1)
> > +        self._expect_rpmi_firmware_and_linux()
> > +        self._validate_system_suspend()
> > +
> > +    def test_linux_guest_reset_poweroff(self):
> > +        self._boot_guest(smp=3D1)
> > +        self._expect_rpmi_firmware_and_linux()
> > +        self._validate_reset_poweroff()
> > +
> > +
> > +if __name__ =3D=3D '__main__':
> > +    QemuSystemTest.main()
>

