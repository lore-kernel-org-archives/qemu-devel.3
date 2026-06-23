Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FA1CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 19:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6tx-0001Sw-S8; Tue, 23 Jun 2026 15:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wc6tv-0001PT-Tm; Tue, 23 Jun 2026 15:35:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wc6ts-0007Ae-Gt; Tue, 23 Jun 2026 15:35:15 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBmjGY1915047; Tue, 23 Jun 2026 19:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WaO5q5
 YQ0mB2XaghF1fzjOAGM2q4SeH2rCRBk/hiFvs=; b=Wuk+V+sgCz7FJlREfhRqCB
 2bnor0fLdN1nZ9A13eV2Ge/T/vsD/vmbLJS0O102NoXqFi+JrM/hwJcbHDWup7RM
 Bnn3K3OnCqOKMzlOFIVNKPQMjX9VrTtcODTCVp1CBh+B+sM8uRVqNLPMXlLx1wos
 ZVRQtO94NoST7mCVuRMKhcxGBOoFuwHwkuyySyFDdP5FL11tGpDPSVJAJ/KkqRTJ
 coKJL0RVubtXCudAcp++jm778GlmNcUgFcbxbSJSS3gkST/UqAhXbMhVvYq+xZ2i
 CjGPnyyB1bPK/tnbtUHIQu79pcR7nD08BKEPiENbAHbiD3/4F3Tdagge77jIHi6Q
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4ghn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 19:35:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NJYjvv012270;
 Tue, 23 Jun 2026 19:35:07 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vymrpj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 19:35:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NJZ6Jl17629944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 19:35:06 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22E705804B;
 Tue, 23 Jun 2026 19:35:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02EBC58055;
 Tue, 23 Jun 2026 19:35:05 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.119.138]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 19:35:04 +0000 (GMT)
Message-ID: <53c8270a6bb9dee4e26516d3ca29a3084286d259.camel@linux.ibm.com>
Subject: Re: [PATCH 5/5] s390x: Enable boot menu for virtio pci device
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com, jdaley@linux.ibm.com, jjherne@linux.ibm.com,
 nrb@linux.ibm.com, Jared Rossi <jrossi@us.ibm.com>
Date: Tue, 23 Jun 2026 15:35:04 -0400
In-Reply-To: <20260623002539.126124-6-jrossi@linux.ibm.com>
References: <20260623002539.126124-1-jrossi@linux.ibm.com>
 <20260623002539.126124-6-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1OSBTYWx0ZWRfX3uo5QZAIQdnD
 bALESc2sDtKJbQuyiNFAKzD+Y7koUthRGkIHtI4Go7Hy39M0ooiMgexWW7EeENR/Hb22X3Bfjlm
 IpYbOSFfAPeLKU7LabLFMk7igj5c3hc=
X-Proofpoint-ORIG-GUID: fdS-hv0Hu-bmoY0X8G1KuE1RFne3DZob
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3adfec cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=sE9LAG50w_MMDgMmH7gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1OSBTYWx0ZWRfX3nMprGvkAMox
 mhfGGHheCuFL46KTP7rtk6dI4DC5hXs87uaHpOs43Gj7OIb1DkT932e2qyyEna+tujG9t3Ve30+
 KKQizJdky73JgzENMgrrUe44X+Cy3RIJNzRWCME51iiJtVizTKDkAePmnYOaa+gnozQ8xBtSeZl
 QAQdZFdNy7gaPz4nDkCp4j5NKSD9ypFGmaDy3NIi0ViVUwh79WmZWxqsU7snB3BvLJNV3UXcORQ
 gXw13ewyjcHLRH/JUmjjqvANeKlcr7FzUoEAdgaixiBN09UJE90/iNOuH84xbuhTMTGlOUgN1Tv
 nWRPeoPb0FxtHVUPy2HhroU+ix6PPQhg1Jz10qd4wBfBi5Alt/CAD8gLnMnkp6O54EoY0TBpmFe
 YNvy3inTZXLNHZ1nit8W1ioO0B3aW62kL76fAPpky+llcAqxrJnmAhQthrC1lrAO0UusT+PsQDO
 OiaEyCpN6p+2WuNXTEA==
X-Proofpoint-GUID: fdS-hv0Hu-bmoY0X8G1KuE1RFne3DZob
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230159
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 2026-06-22 at 20:25 -0400, jrossi@linux.ibm.com wrote:
> From: Zhuoying Cai <zycai@linux.ibm.com>
>=20
> Add S390_IPL_TYPE_PCI to the boot menu handling logic to enable
> interactive boot menu support for virtio PCI devices on s390x.
>=20
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> signed-off-by: Jared Rossi <jrossi@us.ibm.com>
> ---
>  hw/s390x/ipl.c          | 1 +
>  pc-bios/s390-ccw/main.c | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

