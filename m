Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB568CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 09:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6mgR-0005KY-C8; Thu, 09 Oct 2025 05:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mburton@quicinc.com>)
 id 1v6mgO-0005K1-0r
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 05:11:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mburton@quicinc.com>)
 id 1v6mgK-0006em-Cz
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 05:11:31 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EPf2005152;
 Thu, 9 Oct 2025 09:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JYTvXQ0uwjgKwnsflHBLGDh9pEmUlCWwgmXA6R3C6/U=; b=XceGXUNueDLJqxvj
 BbL4xGULA79Zn1mHdB7MLwbmr4M249jJbe7f2Jp/lDEL0jvy5q8R8WLIEcXMiz2H
 /pke7q0/Xd7xiGkI3FIpuYt1fe+eAqDXmr7uPHnE2vLbns94gn4upVNhl7t2SAGd
 tLqtR8zODv6mvqNWHgO45815udV64omeBKIxFvb2QL3Qq83xuoD1UHOHuBtmf0Ph
 71Golm+PCTN+hqJ2sqe6TA2DE/ci3oL2IdyPm/oWYSbwhmtf4+t7od7vDXjx3RJ/
 N7lu+Z/jr7w6BbeqPHRZZeKPpYzuHDQOmIJZYG+okxPiN3UwUytcO7PfJORWDSt3
 e0BAgA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u26ex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 09:11:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5999BFLv023031
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 9 Oct 2025 09:11:15 GMT
Received: from smtpclient.apple (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Thu, 9 Oct
 2025 02:11:11 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: MMIO through IOMMU from a TCG processor
From: Mark Burton <quic_mburton@quicinc.com>
In-Reply-To: <db2ca904-5d1c-4c96-8950-d3d943940d64@nutanix.com>
Date: Thu, 9 Oct 2025 11:10:58 +0200
CC: QEMU Developers <qemu-devel@nongnu.org>, <peterx@redhat.com>,
 <eric.auger@redhat.com>, <zhenzhong.duan@intel.com>,
 <alejandro.j.jimenez@oracle.com>, <peter.maydell@linaro.org>,
 <jasowang@redhat.com>, <pbonzini@redhat.com>, <tjeznach@rivosinc.com>,
 <steven.sistare@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <joao.m.martins@oracle.com>, <ean-philippe@linaro.org>,
 <jean-philippe@linaro.org>, <sarunkod@amd.com>,
 =?utf-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-ID: <D7DA7B85-2439-4CC2-A852-604154ABDC99@quicinc.com>
References: <1C343F6E-05E2-4EA0-A338-0C48A97FF263@quicinc.com>
 <db2ca904-5d1c-4c96-8950-d3d943940d64@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e77c34 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=p0WdMEafAAAA:8
 a=64Cc0HZtAAAA:8 a=SsrUhwFMDyuMi7dro90A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-GUID: sFKnW9FoDAn4JJBQzig_7utFu04sF0bk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX0gVWJm187e/5
 hi1yo1Sn4YYDz8zMQDpFzpM4q/8lenjAJ8NVTiMXL7mqE9ut3VsbkyxwFdi96CfE+KRsocRl6Lg
 mMHpXjYmfOhwe9z09Q/4Cq2Bcnr3JNzmEvty6b8Uhh1U7ql8qNm6dmKZ7BzufaKXz9q/+Np/gZf
 RspmW9kCc7yMSNRF+JOhvXC7W6yptdhc+izwg5upn+WoxjijiIXvDURYE+OA/zuqOrmaOWmWtFL
 SSVpZQ/2IaeVYxHeTCfmrqtQyLkcCY9kLaVtPLyp3HrKI4zyx2dv2fqWitXZCpbSoPVmc9Dkio0
 SediOdT7bieZTeeDUkZ7/Jt59Enbs0/6HMgyJxBrLJkt0cyiuYNoDSUwVk7JHSHJUoEvkE0R3i5
 O/yMghvOEINgabsROcugebmnpIRXng==
X-Proofpoint-ORIG-GUID: sFKnW9FoDAn4JJBQzig_7utFu04sF0bk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1011 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mburton@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


(Adding Pierrick)
Thanks for getting back to me Mark.

I initially thought the same, and I think I have seen that issue, I have =
also taken that patch, However =E2=80=A6..

For MMIO access, as best I can tell, the initial calculation of the =
despatch is based on the iotlb reported by the translate function =
(correct), while the subsequent use of the section number uses the =
dispatch table from the CPU=E2=80=99s address space=E2=80=A6.. which =
gives you the wrong section.

I would very happily do a live debug with you (or anybody) if it would =
help=E2=80=A6 I=E2=80=99m more than willing to believe I=E2=80=99ve made =
a mistake, but I just don=E2=80=99t see how it=E2=80=99s supposed to =
work.

I have been looking at solutions, and right now, I don=E2=80=99t see =
anything obvious. As best I can tell, we =E2=80=9Cloose=E2=80=9D the =
address space that has been returned by the translate function - so, =
either we would need a way to hold onto that, or, we would have to =
re-call the function, or=E2=80=A6.
All of those options look really really nasty to me.

The issue is going to be systems where SMMU=E2=80=99s are used all over =
the place, specifically, in front of MMIO. (Memory works OK because we =
get the memory pointer itself, all is fine, the issue seems only be with =
MMIO accesses through IOMMU regions).

Cheers
Mark.


> On 9 Oct 2025, at 10:43, Mark Cave-Ayland =
<mark.caveayland@nutanix.com> wrote:
>=20
> On 08/10/2025 13:38, Mark Burton wrote:
>=20
>> All, sorry for the wide CC, I=E2=80=99m trying to find somebody who =
understands this corder of the code=E2=80=A6. This is perhaps a obscure, =
but I think it should work.
>> I am trying to access an MMIO region through an IOMMU, from TCG.
>> The IOMMU translation has provided an address space that is different =
from the CPU=E2=80=99s own address space.
>> In address_space_translate_for_iotlb the section is calculated using =
the address space provide by the IOMMU translation.
>>> d =3D =
flatview_to_dispatch(address_space_to_flatview(iotlb.target_as));
>>>=20
>> Later, we come to do the actual access (via e.g. do_st_mmio_leN), and =
at this point we pick up the cpu=E2=80=99s address spaces in =
iotlb_to_section, which is different, and the recorded section therefore =
seems to be incorrect.
>>> CPUAddressSpace *cpuas =3D &cpu->cpu_ases[asidx];
>>> AddressSpaceDispatch *d =3D cpuas->memory_dispatch;
>>> int section_index =3D index & ~TARGET_PAGE_MASK;
>>> MemoryRegionSection *ret;
>>>=20
>>> assert(section_index < d->map.sections_nb);
>>> ret =3D d->map.sections + section_index;
>> What I don=E2=80=99t fully understand is how this is supposed to =
work=E2=80=A6.?
>> Have I missed something obvious?
>> Cheers
>> Mark.
>=20
> What version of QEMU are you using? I'm wondering if you're getting =
caught out by a variant of this: =
https://gitlab.com/qemu-project/qemu/-/issues/3040.
>=20
>=20
> ATB,
>=20
> Mark.
>=20


