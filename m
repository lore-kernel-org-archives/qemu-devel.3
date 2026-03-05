Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8737F47CA9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyDZt-0007zz-Ru; Thu, 05 Mar 2026 13:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vyDZr-0007z3-BK; Thu, 05 Mar 2026 13:37:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vyDZp-0001Ix-6R; Thu, 05 Mar 2026 13:37:39 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 625EAWYT2094170; Thu, 5 Mar 2026 18:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ey9xKE
 fcSACWuqT8i71bmc+Ts/i8bkj1VTZEuredTQk=; b=Vi2ut7eZNf4xJv6iH3eya4
 3LTZVLOQd7wOAq+6UM98yBQo2jj/Q0fmqywJqYRA41GoSoMA9HqkzqDla4CCIqo6
 vVso6Ombjxr+8scwXkCtOG5d2kmdp3HfbvrCHemY/fV0ktlUXg0xIP3GlsZGICJC
 GjTQmENHTpb7zM83bXsk0214FH1IBD8Pj8XPyhlgUgrD73YZ5wm5o//NkcYtfmkn
 5JXOIou/VEd9karW0IVcLZS+Jud0pqAa+inE2YEU85kKFSL//Z3r/FgmJJIBIP2V
 nbPTJMUHccPw7PZ3OnCNlfp36wX5TXoiQYmWcYabp0NlG2yaBJtginFQ5qW2W9YA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskd55fb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 18:37:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 625ExAld010299;
 Thu, 5 Mar 2026 18:37:34 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6kchrc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 18:37:34 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 625IbWrZ46137618
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2026 18:37:32 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FC6C5803F;
 Thu,  5 Mar 2026 18:37:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85D4D5804E;
 Thu,  5 Mar 2026 18:37:31 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.45.8]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2026 18:37:31 +0000 (GMT)
Message-ID: <27c3de8b032b057a7f07d3bab96421cd0dc7a41d.camel@linux.ibm.com>
Subject: Re: [PATCH v4 11/15] pc-bios/s390-ccw: Introduce virtio-pci functions
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
Date: Thu, 05 Mar 2026 13:37:31 -0500
In-Reply-To: <20260304025917.2157032-12-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
 <20260304025917.2157032-12-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5Kw2znB1aC0dL17xq3paw9nM8mRnt1_w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE0OSBTYWx0ZWRfXwPi8dS+Db8LD
 go+W84JgJMd47/bD45thZLjKdY/TVjD64c4Zb5H1g7hXi9qZPmROhG/LXYcUbJoKiSWD+UmQer8
 NSQ4T7Hb0nFvsqQmfl6zRubQFxHCCRHW2XNagqwa5HzXf3sUFm2igAuHY+dvUFLPeChzxiWrJRB
 73/AlyJ15CL+uJ4Mr8JCh/RXyH64dl38eh6eYhqo9jyujvFG8cMpESUA66HTgCEKAYO5zgTc/pq
 bbwEYxU8LZGu90gIksZuQkZs2Fb/wOxCwlpcJ9ekAIfcErDABvHpdb9ZyR3EGmYFn6hVWJp7B/j
 mMojEQtPSJtPXMYxlrtqIxHsHsklv4ID7sY2yAqm8BwRcccvp/5DKg40oPYNch8l4Gtn69L1mH+
 ZH+6xaQ1jyynp35maTIahFT9Jz63ltM10CqqlOkBFM+QmNOpKeqOUG3HwfU0iJAz//yMOkiaM+3
 2LI8pISDLvIDN5hzahQ==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a9cd6f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=iATe2qbmW-lUHqBG5CMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5Kw2znB1aC0dL17xq3paw9nM8mRnt1_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_05,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050149
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 2026-03-03 at 21:59 -0500, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> Define common functionality for interacting with virtio-pci devices.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/Makefile     |   2 +-
>  pc-bios/s390-ccw/virtio-pci.c | 167 ++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio-pci.h |  80 ++++++++++++++++
>  pc-bios/s390-ccw/virtio.h     |   5 +
>  4 files changed, 253 insertions(+), 1 deletion(-)
>  create mode 100644 pc-bios/s390-ccw/virtio-pci.c
>  create mode 100644 pc-bios/s390-ccw/virtio-pci.h
>=20

...snip...
(Only comment I had in here was the s/0x1402/0x1042/ that Thomas pointed ou=
t.)


> diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.=
h
> new file mode 100644
> index 0000000000..54c524f698
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-pci.h
> @@ -0,0 +1,80 @@
> +/*
> + * Definitions for virtio-pci
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef VIRTIO_PCI_H
> +#define VIRTIO_PCI_H
> +
> +/* Common configuration */
> +#define VPCI_CAP_COMMON_CFG          1
> +/* Notifications */
> +#define VPCI_CAP_NOTIFY_CFG          2
> +/* ISR access */
> +#define VPCI_CAP_ISR_CFG             3
> +/* Device specific configuration */
> +#define VPCI_CAP_DEVICE_CFG          4
> +/* PCI configuration access */
> +#define VPCI_CAP_PCI_CFG             5
> +/* Additional shared memory capability */
> +#define VPCI_CAP_SHARED_MEMORY_CFG   8
> +/* PCI vendor data configuration */
> +#define VPCI_CAP_VENDOR_CFG          9
> +
> +/* Offsets within capability header */
> +#define VPCI_CAP_VNDR        0
> +#define VPCI_CAP_NEXT        1
> +#define VPCI_CAP_LEN         2
> +#define VPCI_CAP_CFG_TYPE    3
> +#define VPCI_CAP_BAR         4
> +#define VPCI_CAP_OFFSET      8
> +#define VPCI_CAP_LENGTH      12
> +
> +#define VPCI_N_CAP_MULT 16 /* Notify multiplier, VPCI_CAP_NOTIFY_CFG onl=
y */
> +
> +/* Common Area Offsets for virtio-pci queue */
> +#define VPCI_C_OFFSET_DFSELECT      0
> +#define VPCI_C_OFFSET_DF            4
> +#define VPCI_C_OFFSET_GFSELECT      8
> +#define VPCI_C_OFFSET_GF            12
> +#define VPCI_C_COMMON_NUMQ          18
> +#define VPCI_C_OFFSET_STATUS        20
> +#define VPCI_C_OFFSET_Q_SELECT      22
> +#define VPCI_C_OFFSET_Q_SIZE        24
> +#define VPCI_C_OFFSET_Q_ENABLE      28
> +#define VPCI_C_OFFSET_Q_NOFF        30
> +#define VPCI_C_OFFSET_Q_DESCLO      32
> +#define VPCI_C_OFFSET_Q_DESCHI      36
> +#define VPCI_C_OFFSET_Q_AVAILLO     40
> +#define VPCI_C_OFFSET_Q_AVAILHI     44
> +#define VPCI_C_OFFSET_Q_USEDLO      48
> +#define VPCI_C_OFFSET_Q_USEDHI      52
> +
> +#define VIRTIO_F_VERSION_1          1   /* Feature bit 32 */
> +
> +struct VirtioPciCap {
> +    uint8_t bar;     /* Which PCIAS it's in */
> +    uint32_t off;    /* Offset within bar */
> +};
> +typedef struct VirtioPciCap  VirtioPciCap;
> +
> +void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
> +int virtio_pci_reset(VDev *vdev);
> +long virtio_pci_notify(int vq_id);
> +
> +int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len);
> +int vpci_read_bswap64(uint64_t offset, uint8_t pcias, uint64_t *buf);
> +int vpci_read_bswap32(uint64_t offset, uint8_t pcias, uint32_t *buf);
> +int vpci_read_bswap16(uint64_t offset, uint8_t pcias, uint16_t *buf);
> +int vpci_read_byte(uint64_t offset, uint8_t pcias, uint8_t *buf);
> +
> +int vpci_bswap64_write(uint64_t offset, uint8_t pcias, uint64_t data);
> +int vpci_bswap32_write(uint64_t offset, uint8_t pcias, uint32_t data);
> +int vpci_bswap16_write(uint64_t offset, uint8_t pcias, uint16_t data);
> +int vpci_write_byte(uint64_t offset, uint8_t pcias, uint8_t data);

I know it's pedantic, but since the reads are vpci_read_bXXXX while the wri=
tes are vcpi_bXXXX_write
(except the single byte case) could we make them consistent, please? (Soft =
preference for
vpci_read/write_bXXXX, but I don't much care.)

> +
> +#endif
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index c3cb5a6ee3..0e7dbdb64c 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -18,6 +18,10 @@
>  #define VIRTIO_CONFIG_S_DRIVER          2
>  /* Driver has used its parts of the config, and is happy */
>  #define VIRTIO_CONFIG_S_DRIVER_OK       4
> +/* Feature negotiation complete */
> +#define VIRTIO_CONFIG_S_FEATURES_OK     8
> +/* Clear status byte */
> +#define VIRTIO_CONFIG_S_RESET           0x00

Heh, in v3 I wondered if you could add the new status bit(s) here. Buuuut..=
. :)

Virtio section 2.1 defines "NEEDS_RESET" as 64 (0x40). Of course it says th=
at the status field
starts as zero and is reinitialized to zero BY a reset, which is what you e=
nd up doing. Its
placement here between FEATURES_OK and FAILED with their spec-accurate defi=
nitions, but with a
different definition had me puzzled. Maybe move it to the top of this list,=
 and rename it to
..._S_INIT or ..._S_ZERO or something? (Or don't define it and just set it =
to zero in the code.)

>  /* We've given up on this device. */
>  #define VIRTIO_CONFIG_S_FAILED          0x80
> =20
> @@ -255,6 +259,7 @@ struct VDev {
>      uint8_t scsi_dev_heads;
>      bool scsi_device_selected;
>      ScsiDevice selected_scsi_device;
> +    uint32_t pci_fh;
>      uint32_t max_transfer;
>      uint32_t guest_features[2];
>  };

