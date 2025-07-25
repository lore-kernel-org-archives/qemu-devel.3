Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01458C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 08:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufDtF-0005T4-TK; Fri, 25 Jul 2025 04:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufDtC-0005OW-7d
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:34:50 -0400
Received: from p-west3-cluster2-host3-snip4-2.eps.apple.com ([57.103.74.65]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufDt9-0003LN-NP
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:34:49 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-2 (Postfix) with ESMTPS id
 2DC0B180017A; Fri, 25 Jul 2025 08:34:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=d6Y0v3JmhbVH8a1yrcqq1A0CM6+1c1neXJ8NeseTam0=;
 h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version:x-icloud-hme;
 b=RhNYDcV37W91JHdoglLYE3nG5qqeQxGNKbk1ckZ62QiZOP5HpaVfj+Sq6WcfTToyS9n25K0lGh/92NYc2HO4C4wmpHpPTgWCbJwfkLC21oAoJYdosgN9tTbBRh2g2/N1Djl+ukc7uFZpI/xFRBiGoXJOdVgy6u5at6n9NwGgvsKhO03l+eSMYUv1v4Q6YnF1deLsPlQj8Kswtyz7NhrWsb93MSy+5JyCht6mtSWVwJNoUNQOQvyNGZrehbm0gIAp5i+4KfDZCUXCvyzWhPDOPSA4JdVPc3nw5m7Z9kyOOD4fGjdMbUPbT981StxyGjcawKPi6uPLYApnWD8j7XlZOw==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (ms-asmtp-me-k8s.p00.prod.me.com
 [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-2 (Postfix) with ESMTPSA id
 EFF0F180030D; Fri, 25 Jul 2025 08:34:34 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 0/9] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Fri, 25 Jul 2025 10:34:22 +0200
Message-Id: <20250725083431.91450-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: k3HL4L1UKtPHbkD4MF3qEouoDQK11pPk
X-Proofpoint-ORIG-GUID: k3HL4L1UKtPHbkD4MF3qEouoDQK11pPk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3MiBTYWx0ZWRfX2To1LoNDqCtu
 XswwVwbr/B/JdKwludFe2/mcJj/RuRnP6tXpu3xWPTnzGL2hFTgh1J4T+4o9gEcFLH74i7u3CH5
 L6e2kjR1D/J40cTOt4a2d9MxzUc13Bfjl5MQ//C5hn82b8SKVGvfHKW6PEUEjk3s9O4qrCFfm1d
 pOHK6mcaPa3WO2JfAgc0MHy7eM5ID4w9kVIFdgv3+yYTjGA0PecMfaedIHw/jCbEiYoyHI9kjvE
 M6pwbAe3KWf/ZDWBVAWZ6x5CsFbGHf3lN+Ocr4GJjJ8UEpA+6nfKMqTCgC0mhysF+cPkKP9VM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 malwarescore=0 mlxlogscore=770 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507250072
Received-SPF: pass client-ip=57.103.74.65;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Early series.

Known issues:
- when nested virt is enabled, no UI response within EDK2
and a permanent wait. Workaround: -boot menu=on,splash-time=0
- Save/restore of GIC state isn't complete yet.
- Save/restore of HVF state when EL2 is enabled isn't complete yet.
- This series doesn't contain EL2 physical timer emulation, which is
needed if not leveraging the Apple vGIC.

However, this is usable and there seems to be some interest for it. Hopefully
it'll be at least somewhat useful.

PS: I can step up to maintain HVF support if needed. WHPX arm64 patch series
is coming soon too.

Mohamed Mediouni (9):
  target/arm: hvf: stubbing writes to LORC_EL1
  accel, hw/arm, include/system/hvf: plumbing changes for HVF vGIC
  target/arm: hvf: instantiate GIC early
  target/arm: add asserts for code paths not leveraged when using the
    vGIC
  hw/intc: Add hvf vGIC interrupt controller support
  hw/arm, target/arm: nested virtualisation on HVF
  target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
  hw/arm: virt: add GICv2m for the case when ITS is not available
  target/arm: hvf: use LOG_UNIMP for CNTP_CVAL_EL0/SYSREG_CNTP_CTL_EL0

 accel/hvf/hvf-all.c        |  44 +++
 accel/stubs/hvf-stub.c     |   1 +
 hw/arm/virt-acpi-build.c   |   4 +-
 hw/arm/virt.c              |  31 +-
 hw/intc/arm_gicv3_common.c |   3 +
 hw/intc/arm_gicv3_hvf.c    | 624 +++++++++++++++++++++++++++++++++++++
 hw/intc/meson.build        |   1 +
 include/hw/arm/virt.h      |   2 +
 include/system/hvf.h       |   3 +
 system/vl.c                |   2 +
 target/arm/hvf-stub.c      |  15 +
 target/arm/hvf/hvf.c       |  91 ++++++
 target/arm/hvf_arm.h       |   3 +
 13 files changed, 814 insertions(+), 10 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c

-- 
2.39.5 (Apple Git-154)


