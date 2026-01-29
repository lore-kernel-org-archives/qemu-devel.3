Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF540D73E9B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 21:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlZwV-0001ih-Nf; Thu, 29 Jan 2026 16:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vlZwG-0001cR-Fn; Thu, 29 Jan 2026 16:52:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vlZwE-000403-Dz; Thu, 29 Jan 2026 16:52:31 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TDtbk5012571;
 Thu, 29 Jan 2026 21:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8RfhTw
 nOhzYzfkNpW3ANfcYkZOggNIyL5hA+ReZvCTU=; b=ZetIbIikTY2tVduOhKoqCU
 NSnOA2w28SyhWHB32ch9v2amaw25rXvx5cAE/uTS6U+uLbBeCmCZMslrLm0o/6Z9
 Nn81wTDcjwIVeGki728/MrUM8+mrOK5nAF3Vcoqio01RylNwWaNuT5d5ROrFJemF
 L5N6lVcooLa2vbj54wmOhoNrdJf6/qFXpzkYT6dDdBnNCMnbxvM8i3DMp4486/F7
 w/5/UGcy/ZEMLdHSR5dmGQtNy7Iq28bZchmqSHGBz6CsZNYqwBGHQ9NbBepv75rD
 kUyehUicUEfx0lMqHbZp6QDGurErC6iChiWKYW2OIkSUjeNNClPV9xJZpCAdOk2Q
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk7b81s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 21:52:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TJNXGC019653;
 Thu, 29 Jan 2026 21:52:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9dnbtjn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 21:52:27 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TLqPGk26280622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 21:52:26 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A72165805D;
 Thu, 29 Jan 2026 21:52:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87ED858057;
 Thu, 29 Jan 2026 21:52:24 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.53.37]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jan 2026 21:52:24 +0000 (GMT)
Message-ID: <0ac34654614bc76112ebab10bd4d610443dfdcc0.camel@linux.ibm.com>
Subject: Re: [PATCH v3 07/14] pc-bios/s390-ccw: Introduce CLP Architecture
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
Date: Thu, 29 Jan 2026 16:52:24 -0500
In-Reply-To: <20260127161547.459443-8-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-8-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JBbBNImglRpMwJTXPnSPUm3kNBoQj9DV
X-Proofpoint-ORIG-GUID: JBbBNImglRpMwJTXPnSPUm3kNBoQj9DV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDE1OSBTYWx0ZWRfX6vECJxe0huj8
 pBDeL+moGyZFIKCoZ1wYtUprB/bsyXemz8Cx7Tnkdc/LiXmbpFzvtrWhbmtkQbLVPjJQDBGjbpD
 j/FSlLS2iZ+M3PNb2twnGsQxLud+l9jaVNCY50RaZUH50hynAGLaKLRqKKTqba34nVzYx3ujp+6
 HlvXuFsE3f99cK5PNAP5jvJehmbBHf8EEMdFm7uoGdOLLFx8fLRSdAyGULFLiu6x6GehSHKGMqi
 VsOMBIzt0hsWz4aSQx5TPU/nEmqvV2l4SHqfWyZp7Yyn9yFXjzSUqKOd8XYS2Blz0AHiVQUGMVj
 SiA7ET55aKcDnY5/NcojhO2qwP/aBWQ1i7w+y02kxaaWuFShBwL6T+9M/lktcU0I11WsVdSl81E
 hzuv6yxdtWN7M7v+UP6hCQcoXbNs7Stpbqg5BTTOp/hyMfCxloVpA+OXy66FxwIpr8ca+z6qjGy
 VihYSrPNUBZEUWozWsQ==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=697bd69c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=eg3GhxO6QQJttQrM36AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601290159
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2026-01-27 at 11:15 -0500, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> Call Logical Processor (CLP) Architecture is used for managing PCI functi=
ons on
> s390x. Define and include the structures and routines needed to interact =
with
> PCI devices during IPL.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/Makefile |  2 +-
>  pc-bios/s390-ccw/clp.c    | 96 +++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/clp.h    | 24 ++++++++++
>  3 files changed, 121 insertions(+), 1 deletion(-)
>  create mode 100644 pc-bios/s390-ccw/clp.c
>  create mode 100644 pc-bios/s390-ccw/clp.h

First off, this looks like correct according to my reading.

My only question is whether we need any breadcrumbs in case things fail? Du=
mping the requested FID
in case of an enable, or the response code in either case? (I haven't gotte=
n to the later patches
yet, just looking at the puts here has me wondering if that's enough of a c=
lue.)

>=20
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 259cff09db..9c29548f84 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -35,7 +35,7 @@ QEMU_DGFLAGS =3D -MMD -MP -MT $@ -MF $(@D)/$(*F).d
> =20
>  OBJECTS =3D start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o =
\
>  	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o =
\
> -	  virtio-ccw.o
> +	  virtio-ccw.o clp.o
> =20
>  SLOF_DIR :=3D $(SRC_PATH)/../../roms/SLOF
> =20
> diff --git a/pc-bios/s390-ccw/clp.c b/pc-bios/s390-ccw/clp.c
> new file mode 100644
> index 0000000000..2a14bb9b73
> --- /dev/null
> +++ b/pc-bios/s390-ccw/clp.c
> @@ -0,0 +1,96 @@
> +/*
> + * Call Logical Processor (CLP) architecture
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "clp.h"
> +#include <stdio.h>
> +#include <string.h>
> +
> +int clp_pci(void *data)
> +{
> +    struct { uint8_t _[2048]; } *req =3D data;
> +    int cc =3D 3;
> +
> +    asm volatile (
> +        "     .insn   rrf,0xb9a00000,0,%[req],0,2\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "+d" (cc), "+m" (*req)
> +        : [req] "a" (req)
> +        : "cc");
> +    return cc;
> +}
> +
> +/*
> + * Get the PCI function entry for a given function ID
> + * Return 0 on success, 1 if the FID is not found, or a negative RC on e=
rror
> + */
> +int find_pci_function(uint32_t fid, ClpFhListEntry *entry)
> +{
> +    int count =3D 0;
> +    int limit =3D PCI_MAX_FUNCTIONS;
> +    ClpReqRspListPci rrb;
> +
> +    rrb.request.hdr.len =3D 32;
> +    rrb.request.hdr.cmd =3D 0x02;
> +    rrb.request.resume_token =3D 0;
> +    rrb.response.hdr.len =3D sizeof(ClpRspListPci);
> +
> +    do {
> +        if (clp_pci(&rrb) || rrb.response.hdr.rsp !=3D 0x0010) {
> +            puts("Failed to list PCI functions");
> +            return -1;
> +        }
> +
> +        /* Resume token set when max enteries are returned */
> +        if (rrb.response.resume_token) {
> +            count =3D CLP_FH_LIST_NR_ENTRIES;
> +            rrb.request.resume_token =3D rrb.response.resume_token;
> +        } else {
> +            count =3D (rrb.response.hdr.len - 32) / sizeof(ClpFhListEntr=
y);
> +        }
> +
> +        limit -=3D count;
> +
> +        for (int i =3D 0; i < count; i++) {
> +            if (rrb.response.fh_list[i].fid =3D=3D fid) {
> +                memcpy(entry, &rrb.response.fh_list[i], sizeof(ClpFhList=
Entry));
> +                return 0;
> +            }
> +        }
> +
> +    } while (rrb.request.resume_token && limit > 0);
> +
> +    puts("No function entry found for FID!");
> +
> +    return 1;
> +}
> +
> +/*
> + * Enable the PCI function associated with a given handle
> + * Return 0 on success or a negative RC on error
> + */
> +int enable_pci_function(uint32_t *fhandle)
> +{
> +    ClpReqRspSetPci rrb;
> +
> +    rrb.request.hdr.len =3D 32;
> +    rrb.request.hdr.cmd =3D 0x05;
> +    rrb.request.fh =3D *fhandle;
> +    rrb.request.oc =3D 0;
> +    rrb.request.ndas =3D 1;
> +    rrb.response.hdr.len =3D 32;
> +
> +    if (clp_pci(&rrb) || rrb.response.hdr.rsp !=3D 0x0010) {
> +        puts("Failed to enable PCI function");
> +        return -1;
> +    }
> +
> +    *fhandle =3D rrb.response.fh;
> +    return 0;
> +}
> diff --git a/pc-bios/s390-ccw/clp.h b/pc-bios/s390-ccw/clp.h
> new file mode 100644
> index 0000000000..1ac2f8c177
> --- /dev/null
> +++ b/pc-bios/s390-ccw/clp.h
> @@ -0,0 +1,24 @@
> +/*
> + * Call Logical Processor (CLP) architecture definitions
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef CLP_H
> +#define CLP_H
> +
> +#ifndef QEMU_PACKED
> +#define QEMU_PACKED __attribute__((packed))
> +#endif
> +
> +#include <stdint.h>
> +#include <s390-pci-clp.h>
> +
> +int clp_pci(void *data);
> +int find_pci_function(uint32_t fid, ClpFhListEntry *entry);
> +int enable_pci_function(uint32_t *fhandle);
> +
> +#endif

