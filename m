Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D16C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjaNf-0007hj-OG; Tue, 14 Jul 2026 06:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjaNe-0007hW-5w
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:28:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjaNb-0008N8-Rz
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:28:49 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SZDh4005247
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 10:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YiFJcnFuXmL
 OIJn1oCKwdqDls0pesaSGzGTz3COWyCs=; b=P5fxAdz5g2k473/t33F5RaHM3Wt
 AoYuP8yUooit/WRZyy01MxYv4vFsLFqwrjpTWjZMH69Q/meHKcitEndBuCssqkwf
 zKa6iSJiLvJOWfZ9EOdbyqEEwm7RaRqX9YwaxvuxF8XTncyt7rpH9MmFedK/EGat
 FfEttXTj5jRbTaujuq3qCW5NjC3RD0AY0eL1fK1YFodsoMDjcGXQ1Oaz5RXKTVRs
 MhdzGpVYQM+RkDwVZQ5E/IkdwiET1Uh6JBeCB3XPsTyqyhexxaR6hXUuHDV0QCHR
 f4Ck3nLRAgCjLtM/z9Y/5HgEmreyJPqaKR7qstx5ZrqFQSjNAboYuJQnt2w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44cu99r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 10:28:44 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca124bf0189so671917a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 03:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784024924; x=1784629724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YiFJcnFuXmLOIJn1oCKwdqDls0pesaSGzGTz3COWyCs=;
 b=b+DLL8OVlvFcmetkDm/w7GZ8LHqpR82BJbIOPopJ+kaT0ZiEQHCy+FHKdSaQ5bbd8v
 3hPrWb2XPxrBIgsWal/XjNQOHxp78LkRea1YCZR4jhyggCqj/8RxTX7jCTD8MVIDVUOn
 l6L1lICMREsddbr3clxQMVHR3gjyo7C9TyPbMXgseSfLibZhQdr+bmTpTH3aXsn2Khl8
 gnEGs7GnGV0viUTcgv2gLLVisR2Nw2LAj1kxd2XS+dHHVrB6oBIV7iX8A0ywx2aPN+d6
 hFr/Wk3QHkg3xmKNMtv+O1RUemMIPSljnaxgyly0AHNIe1swLUjIypCk1CJe7gAi3C/9
 qvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784024924; x=1784629724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YiFJcnFuXmLOIJn1oCKwdqDls0pesaSGzGTz3COWyCs=;
 b=tD48xIar6aGleRWQtcLT0bGaEHlH9Jn5rQbpqUjl4BNTjfkV1FemeuhJNWd2MKvJge
 3YmYLC6fZ5E73rI8j3YvO2gldfUiCD0hpaiWqJVv39o1ujN8ZsWmd7sI6kAdY2IRQhTD
 AhQVKT2RIQiu+7W70Cc99pgnsz6XQFszk3lCGviECSY0oXmv6b4SnVTZyQGs7zmiamnV
 jlQuVy+LGiKOA1mSHRENxya7jr8SlKOFgYo0xzCOfMpEISM6nj+u2YB+ArqvXYnTctf8
 9s0xipDondLk7jENofPtZHeOeltnHaUihi9OwDFTIbSYNdFIorykaZ2b+XFIolTYGK6K
 ziSA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoEXjP/3Mz7uTwx4ca8AUOVLbIVbBGhGVOLwhZ6viiseJUFQO9iBMRNgwrHGHbelUFnKm7GYrZ1ygbU@nongnu.org
X-Gm-Message-State: AOJu0YzSDGI90I30y1WnIdJhQkMR0jBB09zhV3h/DjBWhnHBmKTWPrE1
 LajB7wDiR2LVk9L4dWxOWBAlDWvHrM1O+rutO5PZELwVasmyd1fPoDRDMcwSpdoHxfXuIqKzsJh
 VlbV395oags9CGkkEz13PMLX8bW5/NZYKc4j+TR/MPD2sOIXDOmhhwQce7A==
X-Gm-Gg: AfdE7cn8RkYB+cdQMS3b6epWiWshQ8myhuBQHCWG7nB0vy0m+UA/gychZn+PD5aMFQZ
 FMyMpwfdbqbTiNsaWKWVG2pwksGEnT+DII2VQNafb3Ml33DgkAgODU8bTqv1MpCwK9yhIPqJ8IL
 6j/gYpReBoxl6O/J4leW/EDK+m1p233wNApkSad06VyssxEJpjig5uwNGNz1370/t8cRkNC+kbA
 TVIvLVVwfbgr5HU3lfJr/aN3EvoG4wlrlTRNe747gNK/3ZTdqxe5em7BBV2NrqyfHy5PIF6WLfY
 bIU0lME8yC8vkBDRFQEbUdsSmAVf6fvmT0LDWYfkpZM6IBdalXW0f9fIiLOkuZf7Y6PpJJkZhjJ
 SKqwC8KVKYWCFn8iZ/YKN6y6P4YAk+5rB2tzwsGBzJpO7hdzTDbSUI/UObh44oxHyq7n/Ii0XPw
 ==
X-Received: by 2002:a05:6a20:734f:b0:3bf:6763:f0d0 with SMTP id
 adf61e73a8af0-3c0f085657fmr20607681637.4.1784024924092; 
 Tue, 14 Jul 2026 03:28:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:734f:b0:3bf:6763:f0d0 with SMTP id
 adf61e73a8af0-3c0f085657fmr20607635637.4.1784024923501; 
 Tue, 14 Jul 2026 03:28:43 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b93ae3b45sm26419540c88.15.2026.07.14.03.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:28:43 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: pierrick.bouvier@oss.qualcomm.com
Cc: matheus.bernardino@oss.qualcomm.com, qemu-devel@nongnu.org,
 brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 th.huth+qemu@posteo.eu, philmd@mailo.com, berrange@redhat.com
Subject: Re: [PATCH 14/14] tests/functional: Add hexagon semihosting systests
Date: Tue, 14 Jul 2026 03:28:40 -0700
Message-Id: <20260714102840.624910-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <c80dd868-f943-4bd2-828a-4a81cc6a59c4@oss.qualcomm.com>
References: <c80dd868-f943-4bd2-828a-4a81cc6a59c4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VE-zoClDkBAkhT1y4hrUiakq-uPqSYc5
X-Proofpoint-ORIG-GUID: VE-zoClDkBAkhT1y4hrUiakq-uPqSYc5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwOSBTYWx0ZWRfX7NYTauT/XgFr
 RHCy8+uEdlKtFd/4z3YP1cw39XN9bRxD0ZC1Y0twWxX0aiOwEF3eJNykM2qTj9FU+luQ40aeCbB
 DV4WSmgZ+P+YZT21RjxFf4Yu4F6BTSU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwOSBTYWx0ZWRfX37rYhlYElJbG
 UNe4hhB2Iw6xeavniwTwX+7SNwvUTknaqHhcaIRiWtbX42kvycsJBub/aJVaHQh0Ek5iU4FL1zT
 8HIwpQqfDk9w9yqX5kFqFjxVT2KQt0gH6xvMsGWEKi9d/PTR0iXFlk2l3F237jUbR8vbmMlWNaU
 Fpgrqb8K66/Q6ztZtcsP+bSSyKTGGyeS+TsLVjG2tg59h7VcfU1F9cIcowE8BztWR0RBF+ccOqz
 lboWU3WEsG3CkvjH5YfO6Jz1jcWzcWoXF44oSi92TbsCY1mdPejFYR6TQlvnh1Uozn82L3Ayuji
 fS2/nmBB8NQTIMj2t0WFJQuN5GYq2GBiCd73DrGxywzzOSt4bGHX5wPXB/XHxh46H7S1bM1IOeC
 ppSX0+wU7RDThKQnAeTByUmoVvfNM+FbJnM/mJ6SLbQ3/gGCuaeGmSKKlcerZGoxj1Ndkq52mJK
 pbLdiO6AO4riBljlYoQ==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a560f5c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=5vFef2XoAAAA:20
 a=EUspDBNiAAAA:8 a=9JJDJaZ8BouSrPRQD4MA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140109
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Mon, 13 Jul 2026 15:28:46 -0700 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> > From: Brian Cain <brian.cain@oss.qualcomm.com>
> > 
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> > ---
> >  tests/functional/hexagon/meson.build      |   9 ++
> >  tests/functional/hexagon/test_systests.py | 133 ++++++++++++++++++++++
> >  tests/functional/meson.build              |   1 +
> >  3 files changed, 143 insertions(+)
> >  create mode 100644 tests/functional/hexagon/meson.build
> >  create mode 100644 tests/functional/hexagon/test_systests.py
> > 
> > diff --git a/tests/functional/hexagon/meson.build b/tests/functional/hexagon/meson.build
> > new file mode 100644
> > index 00000000000..6cd684b0df7
> > --- /dev/null
> > +++ b/tests/functional/hexagon/meson.build
> > @@ -0,0 +1,9 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +test_hexagon_timeouts = {
> > +  'systests': 180,
> > +}
> > +
> > +tests_hexagon_system_thorough = [
> > +  'systests',
> > +]
> > diff --git a/tests/functional/hexagon/test_systests.py b/tests/functional/hexagon/test_systests.py
> > new file mode 100644
> > index 00000000000..b20b9fc56cc
> > --- /dev/null
> > +++ b/tests/functional/hexagon/test_systests.py
> > @@ -0,0 +1,133 @@
> > +#!/usr/bin/env python3
> > +#
> > +# Copyright(c) Qualcomm Innovation Center, Inc. All Rights Reserved.
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +import os
> > +import re
> > +import time
> > +import unittest
> > +
> > +from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
> > +
> > +
> > +_TARBALL_BIN_PATH = os.path.join(
> > +    "systests_standalone_package",
> > +    "StandaloneSysTests_6.4.0.2_v68",
> > +    "bin",
> > +)
> > +
> > +
> > +class SysTestsStandaloneTests(QemuSystemTest):
> > +    SYSTEST_TIMEOUT_SEC = 30
> > +
> > +    ASSET_TARBALL = Asset(
> > +        "https://github.com/qualcomm/qemu-hexagon-testing/releases/download/v0.2.9/systests_standalone.tar.gz",
> > +        "db961ea3fcc389b478b3d5c2f3bac60bec87e7f3d7efef5e58a9ae8ee78d0e40",
> > +    )
> > +
> > +    def setUp(self):
> > +        super().setUp()
> > +        self.archive_extract(self.ASSET_TARBALL)
> > +        self.bin_dir = os.path.join(self.workdir, _TARBALL_BIN_PATH)
> > +        self._orig_cwd = os.getcwd()
> > +        os.chdir(self.workdir)
> > +        self.addCleanup(os.chdir, self._orig_cwd)
> > +
> > +    def tearDown(self):
> > +        if hasattr(self, "_orig_cwd"):
> > +            os.chdir(self._orig_cwd)
> > +        super().tearDown()
> > +
> > +    def binary(self, name):
> > +        """Return the full path to binary *name* inside bin_dir."""
> > +        return os.path.join(self.bin_dir, name)
> > +
> > +    def run_exit_zero(self, binary_name, *extra_args, machine="V66G_1024"):
> > +        """Launch *binary_name* and assert it exits with code 0.
> > +
> > +        :param binary_name: name of the binary inside bin_dir.
> > +        :param extra_args: optional pairs of (flag, value) strings passed
> > +            to set_vm_arg(), e.g. ('-append', 'myarg').
> > +        :param machine: QEMU machine type (default "V66G_1024").
> > +        """
> 
> 
> We could check self.binary(binary_name) exists to provide a useful error
> message.

Ok, good idea. I'll add the following:

diff --git a/tests/functional/hexagon/test_systests.py b/tests/functional/hexagon/test_systests.py
index b20b9fc56cc..692ec5ad2d5 100644
--- a/tests/functional/hexagon/test_systests.py
+++ b/tests/functional/hexagon/test_systests.py
@@ -42,7 +42,9 @@ def tearDown(self):

     def binary(self, name):
         """Return the full path to binary *name* inside bin_dir."""
-        return os.path.join(self.bin_dir, name)
+        path = os.path.join(self.bin_dir, name)
+        self.assertTrue(os.path.exists(path))
+        return path

     def run_exit_zero(self, binary_name, *extra_args, machine="V66G_1024"):
         """Launch *binary_name* and assert it exits with code 0

