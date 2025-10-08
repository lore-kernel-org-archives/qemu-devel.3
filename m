Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C34CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 12:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6TSB-0003KQ-PR; Wed, 08 Oct 2025 08:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mburton@quicinc.com>)
 id 1v6TS6-0003JX-NR
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 08:39:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mburton@quicinc.com>)
 id 1v6TRv-0007dA-JI
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 08:39:30 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Mcc021114;
 Wed, 8 Oct 2025 12:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=DeAO8UNX2XSokITIooVSzC
 OHV9PjVZYE1+zbarmEOkY=; b=YtRu9BubERy3/lF5KFYEFSXwOUXBwbUzs9VSdJ
 nPgTb/sfUxYIXECT8xBW3CyNtXpxQ/7b1H8KY9P2hzIKZudQALaSSMlHKNjqSgH8
 DF8Dj2YaHBujS8cta+YGNAIzjbUYXIsHrVXSQ9ujehVkfdvP76VU95CQYzWDk0T0
 HOEelaWLcdUFRd80CsV5bMaREeOhZkMujsdQyjr5x7rMJ+xgW+Nev8qwLW698b1R
 t3HifnfSnCJ6Tum+yTPCB9g1e7g92FtrRL/d2zVBkU4sa+iac3vSw9SdBFJMawbt
 dRlKYYmbcf+ybxOH7jcYSlrVWT1Mxr79QCLnO9aO3oXEjwFw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1tesq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 12:39:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 598Cd37S009846
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 8 Oct 2025 12:39:04 GMT
Received: from smtpclient.apple (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Wed, 8 Oct
 2025 05:39:00 -0700
From: Mark Burton <quic_mburton@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: MMIO through IOMMU from a TCG processor
Message-ID: <1C343F6E-05E2-4EA0-A338-0C48A97FF263@quicinc.com>
Date: Wed, 8 Oct 2025 14:38:48 +0200
To: QEMU Developers <qemu-devel@nongnu.org>, <peterx@redhat.com>,
 <eric.auger@redhat.com>, <zhenzhong.duan@intel.com>,
 <alejandro.j.jimenez@oracle.com>, <peter.maydell@linaro.org>,
 <jasowang@redhat.com>, <pbonzini@redhat.com>, <tjeznach@rivosinc.com>,
 <steven.sistare@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <joao.m.martins@oracle.com>, <ean-philippe@linaro.org>,
 <jean-philippe@linaro.org>, <sarunkod@amd.com>,
 =?utf-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: wJYcaNT_clLp-Wips1JcwHWO0OyC7qPf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfX/9USMxqkKvqm
 ZfM+qzj+9tFstTqYfGQ/LThBSMrgkeyN4M0oog5aV9VtrN8L9w6bLycQK50+XzmGipyaknOWbyz
 7DSowZbzKOibBW4Nr1Sh3mqjHmoGUZgaOM9K3qz3sKJYFaIrVn2sfPHpq0ESctgetDHVyXydSJq
 rUr1wLwQMAf+LDuHnCHEov6umSSObtKvbvFfwXFWAsa13ZtFSiLvyLjCZH9l7UjdB2HzFGeEqK9
 3lcrWjONu2WBTa+RSDK6dy7/FaWMFjrWAzA1G4VfAirMjy40Fg+Y3JoTkW08YO+DrQlrowEq+BR
 vOo37l9wKCMsWS/PVhBw3rqzWZjlK1/8yKzJ/09od4pWEP+rhcWA7pkYNduAA1qnJDH/yIbTKiT
 b5VnfzK0/YQvNCXJ/hhOls2HcccMkw==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e65b68 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=IwR0v29mHd8DpTKDBTcA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: wJYcaNT_clLp-Wips1JcwHWO0OyC7qPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1011 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_mburton@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

All, sorry for the wide CC, I=E2=80=99m trying to find somebody who =
understands this corder of the code=E2=80=A6. This is perhaps a obscure, =
but I think it should work.
I am trying to access an MMIO region through an IOMMU, from TCG.
The IOMMU translation has provided an address space that is different =
from the CPU=E2=80=99s own address space.

In address_space_translate_for_iotlb the section is calculated using the =
address space provide by the IOMMU translation.
> d =3D =
flatview_to_dispatch(address_space_to_flatview(iotlb.target_as));
>=20
Later, we come to do the actual access (via e.g. do_st_mmio_leN), and at =
this point we pick up the cpu=E2=80=99s address spaces in =
iotlb_to_section, which is different, and the recorded section therefore =
seems to be incorrect.

> CPUAddressSpace *cpuas =3D &cpu->cpu_ases[asidx];
> AddressSpaceDispatch *d =3D cpuas->memory_dispatch;
> int section_index =3D index & ~TARGET_PAGE_MASK;
> MemoryRegionSection *ret;
>=20
> assert(section_index < d->map.sections_nb);
> ret =3D d->map.sections + section_index;

What I don=E2=80=99t fully understand is how this is supposed to =
work=E2=80=A6.?

Have I missed something obvious?

Cheers
Mark.

