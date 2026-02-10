Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC54EA811B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vposH-0006k4-Jx; Tue, 10 Feb 2026 09:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vposH-0006jm-03; Tue, 10 Feb 2026 09:37:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vposF-0007xl-Il; Tue, 10 Feb 2026 09:37:56 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61A90brH476050; Tue, 10 Feb 2026 14:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=a60M+p
 qYej39p3Nps2Ap7htRrs1OxtGDimZ2Z5qbvJA=; b=HhV3xzeK3rT4pytxed5xca
 Ka5lrcHVC6S8PQhlppKWUwn1zBDomCtm6Oq4C6oczsgQ6Oxjt/j7WgbVfZKumMQd
 BqHpQQntyLn6URYKxi9vIjHRbWG5bL/Qam1hcGjgHxh8vthJGMrsFrn5QnLQxdKv
 FziLMzFraRVPxTdseEUcrMwigQfvJrp+QrrDxhXzU93JBzNEImVn9mB6PPTxqwuU
 H/vzeBnRyrhtKXKPDFnOzJbFnpjGQ5mXo8W+GSZhfpwma1wnBi0kVuX76HV0Udsa
 Aq8B2y8PWUxKEY6lQIfSUFmTnhCD3SZnfGPcCvISjQSUQwiCJP/dT/ox6ciklEog
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696v2ghg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 14:37:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61ADpI3a008378;
 Tue, 10 Feb 2026 14:37:51 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3y9s8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 14:37:51 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61AEboqk57213340
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 14:37:50 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54A9358045;
 Tue, 10 Feb 2026 14:37:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 293AC58050;
 Tue, 10 Feb 2026 14:37:49 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.141.124]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 14:37:49 +0000 (GMT)
Message-ID: <53579daa5965759101be36e90c4bfa93b59ed901.camel@linux.ibm.com>
Subject: Re: [PATCH v1] s390x/pci: Fix endianness for zPCI BAR values.
From: Eric Farman <farman@linux.ibm.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@kernel.org,
 iii@linux.ibm.com
Date: Tue, 10 Feb 2026 09:37:48 -0500
In-Reply-To: <20260206164645.1845366-1-jhkim@linux.ibm.com>
References: <20260206164645.1845366-1-jhkim@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2hQ92JagPk36S4TIV3OA8Iz8T8QgrTsE
X-Proofpoint-ORIG-GUID: 2hQ92JagPk36S4TIV3OA8Iz8T8QgrTsE
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=698b42c0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=Dn1iWEI3DQaagfHZ2RsA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEyMCBTYWx0ZWRfXyyduzDULNwMw
 L0eAJe1TOzi+JEDm+6W/ERQMXflsnjmQVVXdZtIKmH+BpXjGaXOv7fdcCl1V/RHFjAFqNZe9+su
 KeCoDHURppspucUQhXtxaQaZzegkFJkoBqAp2+9Qb2F6XVHqUfmFUBiRW7fcBLGWWm1rX4avYcR
 lo65EJvJJItHBKFYeFdgKpFzl7oMKIJWLKKah20dfNB7BZtdw3IdeWYKA1wRQZkP4P4alnuexme
 ByR34979PMso1qH4JlUynxTQzaF7VEZ/FuqKsfrjkUZARdnGut2uxeHLAUFfrstRl+bTmlKZk6A
 rg2QSrupalABMYZhiSt9K6dftn+RB5AIYbKSJpQLKdiPPbvN9pY+5QvY7n2v+n+Jiuk3gJ283Ys
 az6xpm9EBkZIIDKoWx7SD3aieNcU5LTIhp6OCkOGpsHWh9D81zDZXJ4wwmAD6epv4IO5gR2jJVB
 TGr0eIRgHr39LfnbiWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100120
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Fri, 2026-02-06 at 10:46 -0600, Jaehoon Kim wrote:
> During zPCI scan, BAR configuration data retrieved via CLP Query was
> misinterpreted due to an endianness mismatch between QEMU and the guest
> kernel.
>=20
> The guest kernel's clp_store_query_pci_fn() expects BAR values in
> little-endian format and converts them with le32_to_cpu(). However, QEMU
> was incorrectly sending them in big-endian format, not following the
> architecture specification. This caused incorrect bit-swapping in the
> kernel, leading zpci_setup_bus_resources() to perform registration checks
> against invalid flags, making the process ineffective.
>=20
> Observation values for zPCI device (NVMe passthrough):
> LPAR from real CLP:
> [    0.865595] Resource: PCI Bus 0000:00 -> zdev->bar[0].val: 0x4
> [    0.865597]  start: 0x4000000000000000
> [    0.865598]  end:   0x4000000000003fff
> [    0.865600]  flags: 0x100200
>=20
> QEMU before fix (wrong):
> [    0.601083] Resource: PCI Bus 0001:00 -> zdev->bar[0].val: 0x4000000
> [    0.601085]  start: 0x4003000000000000
> [    0.601086]  end:   0x4003000000003fff
> [    0.601087]  flags: 0x200
>=20
> QEMU after fix (correct):
> [    0.601116] Resource: PCI Bus 0001:00 -> zdev->bar[0].val: 0x4
> [    0.601117]  start: 0x4003000000000000
> [    0.601118]  end:   0x4003000000003fff
> [    0.601119]  flags: 0x100200
>=20
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-inst.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

