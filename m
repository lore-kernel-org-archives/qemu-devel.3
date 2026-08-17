Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE50C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvv0l-0003yQ-3w; Mon, 17 Aug 2026 06:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wvv0e-0003Ys-RT
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:56:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wvv0c-0006C6-8h
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:56:04 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H9djV81932191
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 10:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EVB6iwJXUSO
 lmyMdMzCUVLy7ZQwQiUGcEHKB8v/DuME=; b=ZpT+6FIacRAXNLh+lIsco2F5LHp
 hyR+DVfzi+LFDbF3nE8aFJx9pvSdVXRuPSQozVYKWNcEBqWgEKmcc4yOtrZ9KJ4c
 bEy/FRAU9+pxxLBjOtsnyQvN/e+RZPFqv2dfqtZd+TcmQrTuR/bLaW0EsJ18NV/l
 n1Qf38jQz+IodkSpIhEGLh3dhVr0uOXbPSZE2yPNjg3rP7mqPro/QI92ADNPX8b4
 310gaAA2+UlmZVtTLp8Soi0/BJkxwZbAOI/rws0J4/p2adO+brRpErzUdrQTfLVL
 vm4uxftbR00mksA/G+z/+K+LDs0KMXhcT+K9tNfBPTVQZhRadvoOhvaNqSw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3txy9fs8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 10:56:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc98d6a88bso7879245ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786964160; x=1787568960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EVB6iwJXUSOlmyMdMzCUVLy7ZQwQiUGcEHKB8v/DuME=;
 b=UnEg7EP1+b8ceWGl6mnkyg22zPocqwrX5qlG8VvR8oykh8orC3KKRBArp1C9gheHix
 FOQCeV3HYtHH0UfUpSRbYnMnVwk5Roy3h3vQ2I8M/GPmGAybbMEss/jyigyQ8iFX0iSx
 VP//Cct2LBygwexvh+zoN3mzz8yTlG4SDRq20RUzcoEkh+U2dD6VN+mGgMXuQtAG9GQU
 wGQ79ce6Z3/6eEtzvPqC/dAQZ//G104oNm+q16KBS/RQ6JpFyuUtHYUHgz7W2ZJo3B9d
 91U1jYOvgSNswZUq2pfh38nj+taprGYNbvprA9H1J5fTrtp50drFICsSF4r8gnhmFOIJ
 Y0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786964160; x=1787568960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EVB6iwJXUSOlmyMdMzCUVLy7ZQwQiUGcEHKB8v/DuME=;
 b=TwpxQDARW9crY6OBTailMCwBSU9cYHQy0IaL16VhAmA6QdEdBy7Wnh07b8uNJ1OpXg
 m2eD3RBD3QeZkon0TupItWc1FT9XU9/6G/sp8UJdTKa1JtyOqP5nI+fe+M7W6d1GZjyN
 TkMYBqlhgl3VI8uolyzEd5Ip5nygLFh4k9NPM54dgdY4/Ddl51JWLO8frNoXQiRYvmNH
 LUtEkrIL4LmnpKe09yRSyKWoWNgpzhIE4UQs+TJkqUuB2rUPXkZTcW63OSF6Xm0ywB/K
 MDrczRQ1Ipg2i1AQdsaII1cOWTnVUOi2f4pKFboyGpxIg7TZJKLSJtjBhKvztYHKTAXE
 KurA==
X-Gm-Message-State: AOJu0YzTIdvpv+MQcp0VAafm1t0ioue560hYaAZ8ElKY28L9HpVVtXZ3
 +kaRO+ioS2AZLB/uiFaxz4zP+7jtVyH4gtuwVUtPofUUL0CZD3d67DwIfbXKWF9siJZudZuFaRv
 gbAprjlnmeWdaFKD1pYrD9MJXYQnzxuFYvBXDJuL665BX3xKYjCsIm9jBs+LXsHOlYnxd
X-Gm-Gg: AR+sD12gDeoFrJY4ttiZWcFWJ5HGq3n43yv1moDaBfpCIuquBK8hj+TkacPuBmf+BLf
 aFJuw2ro4rfrVmNNMtnyCWtcYP/jdgdivmEDi8Ea/0UKgLNmEnP2wNmpXvsscWEU/pooKJ4sjaz
 +xaEKgDHFZAdLyVbFMIHTquuU+UF6if9+n7JLv9JXfZFNomEk083FYzV9DH9xu8CRu8FgTblZ7E
 1IO+2cdDtbPSQ4jcaeIDbAEIoK0SnryvYCtvjuyWSvLSvNNpEA59EE/ZG/RlhO/ZmbQx8bJE9vG
 O1nesZXUbN6KLPhI8RZ5SKWQ7sdHjpoeQDJKh16vlV8ey7x22lekqnmcbqRarQ/+PwfiNVVmCRn
 ssZSvKA2TeYXk43OpsQfnic3yAv4En9AK9IQTdBz1y4eRpH9Xef5SMiYwT1Hn7jhjccNkfsjmPc
 lEPMb8Okt11J7CnAqyDML0iY52lVgKUn8=
X-Received: by 2002:a17:902:c944:b0:2c9:e846:a582 with SMTP id
 d9443c01a7336-2d3b04fdcb2mr193012725ad.0.1786964160131; 
 Mon, 17 Aug 2026 03:56:00 -0700 (PDT)
X-Received: by 2002:a17:902:c944:b0:2c9:e846:a582 with SMTP id
 d9443c01a7336-2d3b04fdcb2mr193012395ad.0.1786964159647; 
 Mon, 17 Aug 2026 03:55:59 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c389363sm5431136eec.23.2026.08.17.03.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 03:55:59 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v9 08/10] docs/system/riscv: document initial virt RPMI support
Date: Mon, 17 Aug 2026 16:25:02 +0530
Message-ID: <20260817105505.2607506-9-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817105505.2607506-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260817105505.2607506-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4MSBTYWx0ZWRfXy82Bs7giLBqN
 EJ8oiA9TwUOIkXmne7ZfAi28P5xM9vnD8l5fqr6C59gfOcaSdqB1wZ0YO6fix4riILoDgy8oKCZ
 cs/f/PsEvMREBdPAo3MgqgFvkCsd50w=
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a82e8c0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=bNRx8rSjxjkR0t5bZ0UA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4MSBTYWx0ZWRfX1HHtAxQedBdq
 WTJxSVTfm0HKxdNpk36BTxNl5SfwyaqUeasAFr2kNlPdCKcWyqtt4PmqATwOnTKsELVGBDDYaVz
 WbDFeMZB5p2/XjoSv2bXaxpq+LqDdElu0uWPL9Pg4PfrwTocxyRv0+gugJa+ERLOh01MT6RDAa7
 Cjz0D1bX9hPMeZ7LNqruDneCXxTc6WqpvgNZvvW1KqyfLnQ+/rlO1VQjDbW16hIVBG2EvehaEYT
 M5QKhOeuraP5DCd9fn09KZ4uiDmwWgrDJH0QIL07PpO5NGfXeoSH6uUhC+XEO3JPvkBuV/CE+Vt
 eO/uFYzz1YRwYMNEEobwvLJ4di2Az8ZyDjnFwMOfM71kV9y5HFbidwGMVUvXqDvA92XJ9rll6oq
 dek2sThT3L5h4rKtzWyfpEifWb57N7n5/UA+c5VinXdaa98Mefiqa7x/qbXxom1LiPRjLYdYD0g
 xGyw6Ojva3P3bwm9mpg==
X-Proofpoint-GUID: QeOIOxFDUgMcRdEpo8tYYPA-rxJ6QCQ7
X-Proofpoint-ORIG-GUID: QeOIOxFDUgMcRdEpo8tYYPA-rxJ6QCQ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170081
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Document the opt-in virt RPMI transport and the initial HSM, system
reset, and system suspend service groups.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 docs/system/riscv/virt.rst | 80 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 60850970ce..0b5b2d4718 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -146,6 +146,86 @@ The following machine-specific options are supported:
 
   Enables the riscv-iommu-sys platform device. Defaults to 'off'.
 
+- rpmi=[on|off]
+
+  Enables the RISC-V RPMI shared-memory transport. This option defaults to
+  "off", is TCG-only, and is available only when QEMU is built with librpmi
+  support. This support targets the RISC-V Platform Management Interface
+  (RPMI) Specification v1.0 Ratified (`RPMI v1.0 specification`_). The initial
+  ``virt`` implementation exposes RPMI system reset, system suspend, and HSM
+  service groups. System reset can request shutdown or cold reboot through
+  RPMI. HSM uses the ``virt`` hart IDs and supports hart discovery, status,
+  start, stop, and suspend commands. System suspend uses QEMU's suspend and
+  wakeup path. Migration is currently blocked while RPMI transport and service
+  VMState support is being designed.
+
+  The build dependency is provided by `librpmi`_. QEMU requires librpmi 1.0.0
+  or newer. If the host distribution does not provide a librpmi development
+  package, build and install it from the upstream source tree so that
+  ``pkg-config`` can find ``librpmi.pc``:
+
+  .. code-block:: bash
+
+    $ git clone https://github.com/riscv-software-src/librpmi.git
+    $ cd librpmi
+    $ make
+    $ make install I=/usr/local
+    $ export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
+    $ pkg-config --modversion librpmi
+
+  The librpmi repository can also generate installable ``librpmi-dev`` Debian
+  packages with ``make deb-pkg`` and ``librpmi-devel`` RPM packages with
+  ``make rpm-pkg``. After installing librpmi, configure QEMU with
+  ``--enable-librpmi`` or ``-Dlibrpmi=enabled``.
+
+.. _RPMI v1.0 specification: https://github.com/riscv-non-isa/riscv-rpmi/releases/download/v1.0/riscv-rpmi.pdf
+.. _librpmi: https://github.com/riscv-software-src/librpmi
+
+RPMI qtest coverage
+-------------------
+
+QEMU includes qtest coverage for the RPMI transport and the initial service
+groups in ``tests/qtest/riscv-rpmi-test.c``. To run the qtest from a build
+configured with librpmi support and the ``riscv64-softmmu`` target:
+
+.. code-block:: bash
+
+  $ meson test -C build qemu:qtest-riscv64/riscv-rpmi-test
+
+The qtest covers Base service discovery, System Reset, HSM, System Suspend,
+negative transport cases, reset behavior, and migration blocking while RPMI
+VMState support is being designed.
+
+RPMI firmware and guest smoke
+-----------------------------
+
+A firmware-level RPMI smoke test can be run with OpenSBI, a Linux kernel, and a
+RISC-V disk image:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 \
+      -machine virt,rpmi=on \
+      -cpu rv64 -smp 4 -m 4G -nographic \
+      -bios /path/to/fw_jump.bin \
+      -kernel /path/to/Image \
+      -append "root=/dev/vda rw console=ttyS0 earlycon=sbi" \
+      -drive file=/path/to/rootfs.img,format=raw,if=virtio,snapshot=on
+
+The OpenSBI banner should report RPMI-backed HSM and system suspend support.
+After the guest reaches a shell, normal guest reboot/poweroff commands exercise
+the RPMI system reset path.
+
+RPMI device tree policy
+-----------------------
+
+RPMI is currently described through FDT only; no ACPI representation is emitted
+for the RPMI transport or service groups. The ``virt`` machine uses the
+``riscv,rpmi-shmem-mbox`` shared-memory mailbox node plus child service nodes
+with ``riscv,rpmi-*`` compatible strings. These binding names are part of the
+RPMI RFC surface and may be revised if the RISC-V RPMI bindings change during
+review.
+
 Running Linux kernel
 --------------------
 
-- 
2.43.0


