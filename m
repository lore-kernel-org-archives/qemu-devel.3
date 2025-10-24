Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994CACCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 09:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCE4q-0005f4-Ej; Fri, 24 Oct 2025 05:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCE4Z-0005ct-HJ; Fri, 24 Oct 2025 05:27:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCE4V-0003nA-G0; Fri, 24 Oct 2025 05:26:58 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NJ9CGG007736;
 Fri, 24 Oct 2025 09:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=qFViomamrR7fuu80hgGWtko3WKvm
 sMUSb2T6J8VntHw=; b=ME8jlqAquUtx2rFOTCDI9GJFIqSe1cX5FeFrn+aF0pe6
 HdjD6D6vCibfvN2QtET/ixoKJ+BOWo89NYYaLkq3SK7LZFY2o9fqKafCkLcPGS8i
 gWIMmi5gSNJLNHv4hGnpKHdSyUD9u9dPYeQ9IaNSRu6u1KFEMl72zejwRoVvGLlb
 pUwDME+K1LLLQmWgKuKzZehYj6sObqINM+s72RftI74zmGwQvY+nI9MA+lVMtwp7
 ZXqwbC5tUvwmi4hMhq4Ad0jdvN4WV4JYBVe1Nm3e7nhVb6DreuM02q0lssrbgEPR
 i+ArYft81HI2N3d62+f1n2Got8z+bS2QCDPNK3WCSw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3276ksp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:26:33 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59O9QXeg029472;
 Fri, 24 Oct 2025 09:26:33 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3276ksm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:26:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O7mOgM014663;
 Fri, 24 Oct 2025 09:26:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sjmfk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:26:32 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59O9QS2n52887880
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 09:26:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BFD020049;
 Fri, 24 Oct 2025 09:26:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C280F20040;
 Fri, 24 Oct 2025 09:26:25 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.24.189])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 09:26:25 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v9 0/6] core/loader: capture Error from load_image_targphys
Date: Fri, 24 Oct 2025 14:56:11 +0530
Message-ID: <20251024092616.1893092-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fb4649 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=eNy0KRMLFTeRC40QrVoA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/Mj0cv95PtmC
 Z/KdFiMD+B/APKin3aP6RqmLbYpXCfZ4C8D0y+kKvimcypW6SkuUwlkGZYa+Ac0T7N8XFRiDtBR
 0zC62QbNEVzeIrYO0pLUdvOzkO+JTBfInZdIJzdlbqI/7Ew4AT42KB1GsH56JNsU7WqW3Zq2jPk
 SjC2EiZiCdBeD/aCIgyLCY7BQ6+JtYCJ0PKKgYsAEDF3rvi5RbNRfmefiOL4PtAkP26zKEfJbFF
 IE/vw7+Aovt2DMhbpgtS6HK2BDfXAhyRUdlyoqjF5ywoQW3x4IAMxWcRzPtZ+qXTvIdC3bNdxg7
 6td/gL3a9kHycRSCv9pHVj/ncbUiwPWl5LQVYm/fXsYLG+dCXv48j2RYqU6vfkZD8JjCRT5oxVu
 8Z10pkvPpDEAq5plskUk1UGC38MZzw==
X-Proofpoint-GUID: diM0yVKCqHf6CGBTTTyyaRs6LeNEJ-AM
X-Proofpoint-ORIG-GUID: furI48HFc9Bk2z78-2H4_0miqxYi61na
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Currently, when QEMU fails to load images (kernel, BIOS, initrd) via
load_image_targphys(), the error messages are not descriptive enough
for users to understand why the loading failed. This series adds the
ability to add Error information through the loader functions to
provide more detailed error reporting.

v9:
- Split Patch 2 from v8 into two patches.
- Included RB from Aditya Gupta.

v8:
- Rebased on latest master.
- Modified commit message for Patch 5.

v7:
- Dropped the patch [hw/ppc/spapr: Rename resize_hpt_err to errp].
  already merged. Rebased on latest master.

v6:
- Pass error_fatal instead of errp where caller exits right after
  load_image_targphys() fails.
- Include filename in error messages.

v5:
- Moved the patch which replaces open() with qemu_open() earlier in the
  series.
- Incorporated minor changes in the error messages requested by Balaton.
- Moved check for size zero in load_image_targphys_as() into it's
  separate patch.

v4:
- Reject empty files (`size == 0`) with an appropriate error. [1/5]
- Populate error when `rom_add_file_fixed_as()` fails. [1/5]
- Add missing check in hw/ppc/virtex_ml507.c [5/5]
- Fixed checkpatch warnings [5/5]
- Check errp for failures from load_image_targphys/load_image_targphys_as [3,5/5]
- Remove unused variables [5/5]

v3:
- Use qemu_open() instead of open() in get_image_size() (danpb)
- Remove redundant error_setg_file_open() call (danpb)
- Use error_prepend()/error_reportf_err() to preserve underlying
  error details (danpb)

[v8]: https://lore.kernel.org/all/20251024052707.1852358-1-vishalc@linux.ibm.com
[v7]: https://lore.kernel.org/all/20251022192717.1644251-1-vishalc@linux.ibm.com
[v6]: https://lore.kernel.org/qemu-devel/20251022132507.1597232-2-vishalc@linux.ibm.com
[v5]: https://lore.kernel.org/all/20251021105442.1474602-2-vishalc@linux.ibm.com
[v4]: https://lore.kernel.org/all/20251017181250.1421446-2-vishalc@linux.ibm.com
[v3]: https://lore.kernel.org/all/20251016173502.1261674-1-vishalc@linux.ibm.com
[v2]: https://lore.kernel.org/all/20251015134716.1099351-2-vishalc@linux.ibm.com
[v1]: https://lore.kernel.org/all/20251007091214.403430-2-vishalc@linux.ibm.com

Vishal Chourasia (6):
  core/loader: Use qemu_open() instead of open() in get_image_size()
  core/loader: capture Error from load_image_targphys
  core/loader: split error handling in image loading functions
  core/loader: add check for zero size in load_image_targphys_as
  core: Pass errp to load_image_targphys_as()
  ppc: Pass error_fatal to load_image_targphys()

 hw/alpha/dp264.c         |  4 ++--
 hw/arm/armv7m.c          |  2 +-
 hw/arm/boot.c            |  5 +++--
 hw/arm/digic_boards.c    |  2 +-
 hw/arm/highbank.c        |  3 ++-
 hw/arm/raspi.c           |  2 +-
 hw/arm/vexpress.c        |  2 +-
 hw/core/generic-loader.c |  8 +++++---
 hw/core/guest-loader.c   |  7 ++++---
 hw/core/loader.c         | 37 +++++++++++++++++++++++++++++--------
 hw/hppa/machine.c        |  5 +++--
 hw/i386/multiboot.c      |  2 +-
 hw/i386/x86-common.c     |  4 ++--
 hw/ipmi/ipmi_bmc_sim.c   |  2 +-
 hw/loongarch/boot.c      |  5 ++---
 hw/m68k/an5206.c         |  2 +-
 hw/m68k/mcf5208.c        |  4 ++--
 hw/m68k/next-cube.c      |  2 +-
 hw/m68k/q800.c           |  7 ++++---
 hw/m68k/virt.c           |  4 ++--
 hw/microblaze/boot.c     |  5 +++--
 hw/mips/boston.c         |  2 +-
 hw/mips/fuloong2e.c      |  9 +++++----
 hw/mips/jazz.c           |  2 +-
 hw/mips/loongson3_virt.c | 10 ++++++----
 hw/mips/malta.c          |  9 +++++----
 hw/nubus/nubus-device.c  |  2 +-
 hw/openrisc/boot.c       |  5 +++--
 hw/pci/pci.c             |  2 +-
 hw/ppc/amigaone.c        | 13 ++-----------
 hw/ppc/e500.c            | 20 ++++----------------
 hw/ppc/mac_newworld.c    | 19 ++++++-------------
 hw/ppc/mac_oldworld.c    | 19 ++++++-------------
 hw/ppc/pegasos2.c        | 10 +++-------
 hw/ppc/pnv.c             | 27 ++++++---------------------
 hw/ppc/ppc440_bamboo.c   |  9 ++-------
 hw/ppc/prep.c            | 19 ++++++-------------
 hw/ppc/sam460ex.c        |  8 ++------
 hw/ppc/spapr.c           | 17 ++++-------------
 hw/ppc/virtex_ml507.c    | 11 +++--------
 hw/riscv/boot.c          |  7 ++++---
 hw/rx/rx-gdbsim.c        |  2 +-
 hw/s390x/ipl.c           |  8 +++++---
 hw/sh4/r2d.c             |  8 +++++---
 hw/smbios/smbios.c       |  2 +-
 hw/sparc/leon3.c         |  4 ++--
 hw/sparc/sun4m.c         |  8 +++++---
 hw/sparc64/sun4u.c       |  7 ++++---
 hw/xtensa/xtfpga.c       |  3 ++-
 include/hw/loader.h      |  8 +++++---
 system/device_tree.c     |  2 +-
 51 files changed, 173 insertions(+), 213 deletions(-)

-- 
2.51.0


