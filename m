Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06119C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CoM-00061x-Dw; Thu, 03 Sep 2026 15:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x2CoI-0005yv-F4; Thu, 03 Sep 2026 15:09:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x2CoG-0004zG-GP; Thu, 03 Sep 2026 15:09:17 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2qwV2292334; Thu, 3 Sep 2026 19:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tjuDoc
 fjiefQgoyIsOolMNXUk9/0MTXkBau2O/HYIEk=; b=pLbetTOokHOW0KAMb5JOl9
 jiBIshZkNRkjz0By+2yPcnXvhmShLikSvrJmaolEwCoutENxbkCg5p2a08fwkg03
 BS+EvhoD9Uwa4OnwQFvCCut/TTD6I0rkQE1M0kX+swZt60RWkmkKet4Dt6oNmGf4
 LQ+QTiOU1STC+ncq4+9JlZ88+KKlpsyI7/KpKtRuVGk3URmAX6nEUNzk+x7GQlLT
 OUPanAZG206/psOk1ikOCD+noXNKlKDuANgKZzsLjNjvTnGSzL+h/DeV6XPfurEG
 HkyrlHrZKcgoOLYRdV2YAOZFCh08DuBKf1FsolPVcS85dBl/T2Q6Bn5Nv4MuVAFA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue66xa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 19:09:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683IuL66019078;
 Thu, 3 Sep 2026 19:09:12 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjasgky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 19:09:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683J9AOg28705300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 19:09:11 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C87E558051;
 Thu,  3 Sep 2026 19:09:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 582395805C;
 Thu,  3 Sep 2026 19:09:10 +0000 (GMT)
Received: from [9.61.21.65] (unknown [9.61.21.65])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 19:09:10 +0000 (GMT)
Message-ID: <7085d713-a5a0-4dec-bb32-5d5e34b98af4@linux.ibm.com>
Date: Thu, 3 Sep 2026 10:55:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] pc-bios/s390-ccw: Abstract virtio_run() for
 generic use
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, zycai@linux.ibm.com
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
 <20260831194919.3830270-6-jrossi@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260831194919.3830270-6-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TvUhidBJyWhwecmiObdzG_pyLhBkX3Ok
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NiBTYWx0ZWRfX9uCgwy9EIWnz
 UzA6SIvA3RbBHGBD+dHGnwziLBp5E7fiBIm1hAA7EXN7zEDvhEIFNIb12adJctGdkE/eqr4Cyir
 GRYJTy1Is4xDYslVbNv/UjZlwS+HOESV70b0MLQax90VtaOs/LgFRofBfDUVtjiTlKj0t/GGdO5
 ifsFHQjZT3vd781AQn9eXXGNkB/VgOMEF8Q7zLaIckuyrFu3/Dpm7OslDPxBcPBJQ80tmkPsqQ0
 KSDFMln0lo4L3PX8xZ6c4FuTINrNzBtU8L/Uh4oaCgjsccrUVq36i64I4+LluRBePsksMJCZqbt
 HQrGx/loDqPik1Cx0tmQIGdsMI5R1naugTm5XERAeGxITSJC5GkhzujK2vCbWWqujWP80GzoFnD
 WPUHo/H8DdaXFF7aHUSY8Ng0aNlqqrer++W8RTjhhhZin3Wp0RZokKHlZXRl2FLMkagTI7e0LYu
 TwEWrcohHjJwPLDVBIw==
X-Proofpoint-ORIG-GUID: TvUhidBJyWhwecmiObdzG_pyLhBkX3Ok
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NiBTYWx0ZWRfX8a/pZjeWz2Ak
 aLfCZaZfAK7YIFVTH0cvJrsjdWBqK6/DQhYCflRfypTBRzlENdK3GLNJ1uI6rvUCFLg5FdV0Xzq
 xwYC1T80jWyk6KKMUUo2vEyi5OZg6RA=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a99c5d8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=96O0hvHzs7WlAFbs44YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030166
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jjherne@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 8/31/26 3:49 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> The existing virtio_ccw_run() actually has no dependency on CCW.  Rather
> than add a case for non-ccw devices, we can just put the main logic right in
> the virtio_run() call so that it can be used for other bus types directly.
> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/virtio-ccw.c | 17 -----------------
>   pc-bios/s390-ccw/virtio-ccw.h |  1 -
>   pc-bios/s390-ccw/virtio.c     | 16 +++++++++++-----
>   3 files changed, 11 insertions(+), 23 deletions(-)
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

