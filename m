Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E29C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD7C-0007WD-Q0; Wed, 26 Aug 2026 08:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7A-0007Tt-6H; Wed, 26 Aug 2026 08:52:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD77-0002P0-Tu; Wed, 26 Aug 2026 08:52:23 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCW1Yt2877762; Wed, 26 Aug 2026 12:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=vChXzio9eDtHZSOpEWhZkM9YvnIh
 mlTwpjkSfTDxdpY=; b=c8RiynBnC3xDowf39pPolhEQXEI/6VZtpbKXwAXDSJVN
 BcERWBO82ErDkD9QigGH3Mvd/gnlXdQUEl+uEKD9VhmYGQz2iidgS6oIp9oLHXOr
 UWES3VSM1EaHEsqTqnLOTSn2ta6bQwk/jB1PTRYZOcBfJfOm+MsXeOjY3w5I+LDq
 G+M4bHkirGQ1mbW+xPLTtkD7FLucSXuvq/eFapXiBf4FYeAqC2qxbgkKVylv0F83
 Vy0BeAdnBWgU/oM2e5LZ2K5GNwd2crHGLhL5lL/+bSc2pKLTCCjCo0bJEAv4w2IO
 zoapRwcJcSHUzvkGpx79RlAZtIZVpJwV92GNoHC0FA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726epkj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfG6d032640;
 Wed, 26 Aug 2026 12:52:17 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh9vk8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCqGrW8127088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:52:16 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B4DB58059;
 Wed, 26 Aug 2026 12:52:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63C445805D;
 Wed, 26 Aug 2026 12:52:15 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:15 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 00/37] s390x queue
Date: Wed, 26 Aug 2026 08:51:35 -0400
Message-ID: <20260826125213.1901252-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8ee181 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=p0WdMEafAAAA:8
 a=MsItQQOMWyjzfmPdwrAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfXx9o0Sh0BeI9f
 DvAlhoYtvTgVln4CwXDH7jRqO0GzC1pjqH/3NEZc7DgenzN1l3rKH5segTJDzzx2QVRghsPpHgg
 2kPGE8Dup67+2Mm7SG3BpHn/j/4mGi8=
X-Proofpoint-GUID: TO-aANU_0fzaQSrj0-LpcvQiXb-0njkb
X-Proofpoint-ORIG-GUID: TO-aANU_0fzaQSrj0-LpcvQiXb-0njkb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX+oVccyIlhuNQ
 GkN71hJ/qEkO4BXBsUwR+bU9YTnyHE+DiFJlwLTyGUfNj0cmp+ZCNE8bnoMjVCNAratm7TJZtlU
 v86ima8qiu8TrpN/coyf2+a56FKH/K5plrNZzB05k/MH6ay/OR7dyIGpXXEk7mkH6WP98OnPP4m
 WrqxsaO4zhJz1CZOl4eppxkwuen5pAYoF6mQGBu9S0/d+7Gwj+hLj45WicpYn4SujcsjylxU8Ns
 tkNNKOys0ntZvp9TN0DnR4kKzVayRmwFLsqP3buaXL8WlW3Y272zue7AElLea/yDiPVLVOihRON
 a+N1hwAZ9jtBRaBF7e88iQFVitUuL3ixCZpVIiuOrymSZnWGK/CHQzfUS2EGA4OhJV8QIpxZ+Nm
 XU+Ayoye6pCPWqHXqJlQTaMQlX8ndGnwuj/XDu7ueYEx2j+i2k9/g/3UzjpvBlOszAUUsL+TJOv
 cV7fgU3AsK4AHB73oVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

The following changes since commit fe11f459f640cd08f35c21f9d403517951bfd671:

  Merge tag 'fixes-pr-v1' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-08-25 06:48:55 -0700)

are available in the Git repository at:

  https://gitlab.com/efarman/qemu.git tags/s390x-20260826

for you to fetch changes up to 5c3c500cddbdea58bb76515847d1d515621dcf0b:

  pc-bios/s390-ccw.img: update s390x bios (2026-08-26 07:05:48 -0400)

----------------------------------------------------------------
New s390x features for 11.2
 - hardening fixes in css/sclp code
 - enable secure IPL
 - regenerate s390-ccw.img

----------------------------------------------------------------

Christian Borntraeger (2):
  s390x/sclp: pv: only copy the original SCCB buffer
  s390x/css: Fix css stsch detection to go beyond 8192 devices

Collin L. Walling (2):
  s390x/diag: Introduce DIAG 508 for secure IPL operations
  s390x/diag: Implement DIAG 508 subcode 1 for signature verification

Eric Farman (1):
  pc-bios/s390-ccw.img: update s390x bios

Zhuoying Cai (32):
  Add boot-certs to s390-ccw-virtio machine type option
  crypto/x509-utils: Refactor with GNUTLS fallback
  crypto/x509-utils: Add helper functions for certificate store
  hw/s390x/ipl: Create certificate store
  s390x/diag: Introduce DIAG 320 for Certificate Store Facility
  s390x/diag: Refactor address validation check from diag308_parm_check
  s390x/diag: Implement DIAG 320 subcode 1
  crypto/x509-utils: Add helper functions for DIAG 320 subcode 2
  s390x/diag: Implement DIAG 320 subcode 2
  hw/s390x: Define finite size for single entry VCEntry
  crypto/x509-utils: Add helper functions for DIAG 508 subcode 1
  s390x/diag: Generalize s390_ipl_read/write to accept void *
  s390x/ipl: Introduce IPL Information Report Block (IIRB)
  pc-bios/s390-ccw: Define memory for IPLB and convert IPLB to pointers
  hw/s390x/ipl: Add IPIB flags to IPL Parameter Block
  hw/s390x/ipl: Rework s390_ipl_map_iplb_chain for certificate storage
  s390x: Guest support for Secure-IPL Facility
  pc-bios/s390-ccw: Refactor zipl_run()
  pc-bios/s390-ccw: Rework zipl_load_segment function
  pc-bios/s390-ccw: Introduce ZiplBootMode enum for IPL mode selection
  pc-bios/s390-ccw: Add signature verification for secure IPL in audit
    mode
  pc-bios/s390-ccw: Add signed component address overlap checks
  s390x: Guest support for Secure-IPL Code Loading Attributes Facility
    (SCLAF)
  pc-bios/s390-ccw: Add additional security checks for secure boot
  Add secure-boot to s390-ccw-virtio machine type option
  hw/s390x/ipl: Set IPIB flags for secure IPL
  pc-bios/s390-ccw: Handle true secure IPL mode
  hw/s390x/ipl: Handle secure boot with multiple boot devices
  tests/functional/s390x: Add secure IPL functional test
  docs/specs: Add secure IPL documentation
  docs/system/s390x: Add secure IPL documentation
  MAINTAINERS: Add secure IPL files to S390-ccw boot group

 MAINTAINERS                               |   5 +
 crypto/meson.build                        |   2 +-
 crypto/x509-utils.c                       | 409 +++++++++++++++
 docs/specs/index.rst                      |   1 +
 docs/specs/s390x-secure-ipl.rst           | 197 ++++++++
 docs/system/s390x/secure-ipl.rst          | 184 +++++++
 docs/system/target-s390x.rst              |   1 +
 hw/s390x/cert-store.c                     | 244 +++++++++
 hw/s390x/cert-store.h                     |  38 ++
 hw/s390x/css.c                            |   3 +-
 hw/s390x/ipl.c                            | 128 ++++-
 hw/s390x/ipl.h                            |  29 +-
 hw/s390x/meson.build                      |   1 +
 hw/s390x/s390-virtio-ccw.c                |  70 +++
 hw/s390x/sclp.c                           |   4 +-
 include/crypto/x509-utils.h               | 113 +++++
 include/hw/s390x/ipl/diag308.h            |  34 ++
 include/hw/s390x/ipl/diag320.h            | 118 +++++
 include/hw/s390x/ipl/diag508.h            |  45 ++
 include/hw/s390x/ipl/qipl.h               | 113 ++++-
 include/hw/s390x/s390-virtio-ccw.h        |   5 +
 include/hw/s390x/sclp.h                   |   6 +-
 pc-bios/s390-ccw.img                      | Bin 104216 -> 112408 bytes
 pc-bios/s390-ccw/Makefile                 |   2 +-
 pc-bios/s390-ccw/bootmap.c                | 108 +++-
 pc-bios/s390-ccw/bootmap.h                |  22 +
 pc-bios/s390-ccw/iplb.h                   |   9 +-
 pc-bios/s390-ccw/jump2ipl.c               |  13 +-
 pc-bios/s390-ccw/main.c                   |  59 ++-
 pc-bios/s390-ccw/netmain.c                |   8 +-
 pc-bios/s390-ccw/s390-ccw.h               |  27 +
 pc-bios/s390-ccw/sclp.c                   |  27 +
 pc-bios/s390-ccw/sclp.h                   |   7 +
 pc-bios/s390-ccw/secure-ipl.c             | 561 +++++++++++++++++++++
 pc-bios/s390-ccw/secure-ipl.h             | 183 +++++++
 qapi/machine-s390x.json                   |  23 +
 qapi/pragma.json                          |   1 +
 qemu-options.hx                           |  10 +-
 target/s390x/cpu_features.c               |   7 +
 target/s390x/cpu_features.h               |   1 +
 target/s390x/cpu_features_def.h.inc       |   5 +
 target/s390x/cpu_models.c                 |   7 +
 target/s390x/diag.c                       | 576 +++++++++++++++++++++-
 target/s390x/gen-features.c               |   7 +
 target/s390x/kvm/kvm.c                    |  34 ++
 target/s390x/s390x-internal.h             |   4 +
 target/s390x/tcg/misc_helper.c            |  14 +
 tests/functional/s390x/meson.build        |   2 +
 tests/functional/s390x/test_secure_ipl.py | 172 +++++++
 49 files changed, 3539 insertions(+), 100 deletions(-)
 create mode 100644 docs/specs/s390x-secure-ipl.rst
 create mode 100644 docs/system/s390x/secure-ipl.rst
 create mode 100644 hw/s390x/cert-store.c
 create mode 100644 hw/s390x/cert-store.h
 create mode 100644 include/hw/s390x/ipl/diag308.h
 create mode 100644 include/hw/s390x/ipl/diag320.h
 create mode 100644 include/hw/s390x/ipl/diag508.h
 create mode 100644 pc-bios/s390-ccw/secure-ipl.c
 create mode 100644 pc-bios/s390-ccw/secure-ipl.h
 create mode 100755 tests/functional/s390x/test_secure_ipl.py

-- 
2.55.0


