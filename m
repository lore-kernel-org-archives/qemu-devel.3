Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E967EF513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyH8n-0004se-Hf; Thu, 05 Mar 2026 17:25:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vyH8l-0004ry-CQ; Thu, 05 Mar 2026 17:25:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vyH8j-00050n-QL; Thu, 05 Mar 2026 17:25:55 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 625IifZ12165137; Thu, 5 Mar 2026 22:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AOTE1+
 DyYzY8fax7gV7ZoYK0ePRk7KWHaW/kwOJ1GvU=; b=YVoYlenbC42eAKbLDEIXlj
 K8FZhbAGoKTqhGtz5RtkyK6IoTGrFBVoqR5FWkhKZYWFjGRVdMRk4TKEAp9ogrCF
 AwJazMaOl6cMySvstaYjlU9Y2DnTkVCre0wrK/YAXieT4bNGpi5GgiTAwy0Mul5m
 ABvb4ssQVHJSdhCSPAEkVCoga1WX8nsX1f6mP9XE19Kjqkb54JWo6CSR5rB5Di34
 CRDQxGxVORk7enA+3sWU/j8FAWUX5CMC0t9eT+QPrIFBDNFnlIemHluyvpO7B/wu
 8dujOlNoVwGOIVgYqhnZTbX6clcxgrXNZun9b7/mKpTRX8LtGLxNaHMu1uZRAvQA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjdnvyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 22:25:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 625Ic6bC010299;
 Thu, 5 Mar 2026 22:25:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6kd98h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 22:25:50 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 625MPnQM29885162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2026 22:25:49 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1050858051;
 Thu,  5 Mar 2026 22:25:49 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B315B5805A;
 Thu,  5 Mar 2026 22:25:47 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.185.126]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2026 22:25:47 +0000 (GMT)
Message-ID: <f866382015b332c83c7b1e65de74883f01f3852d.camel@linux.ibm.com>
Subject: Re: [PATCH v4 12/15] pc-bios/s390-ccw: Add support for
 virtio-blk-pci IPL
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
In-Reply-To: <20260304025917.2157032-13-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
 <20260304025917.2157032-13-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date: Thu, 05 Mar 2026 17:25:32 -0500
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69aa02ef cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=IB1eNz0_M4T_B0VYkJUA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8TpMtybVj79Ofqr5IQdmhfAA7SdwTVhp
X-Proofpoint-GUID: 8TpMtybVj79Ofqr5IQdmhfAA7SdwTVhp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE4OSBTYWx0ZWRfX3lGSMACCuAMd
 DIce66Tr7z/vteRdKxO1uwEiwhuKmuFjly/hAttPwioIkmfZq7jW9gOP5DYnf+8wVg/6BZdpJab
 F8bP1Ds80znkW36OrK7tM28B9gMSuyerg6827RLUx6l3k+01wTNSuRcW8Qj3sK3Tjku/1rXbXXw
 2xm/nsD/Sc/y8NTRJmru2LuLPPsF3U3XiE5YWGuAwDiyeqM7N5TEx3lGgll/Qmqz0VuClhtsyJE
 VmFv+2aqrwlEGMhtMZ5tx/o5gi+PKj0DA6KY1gg1MSUq912YSrAymoPfYU5ScRd9Eom3ZI0ArKi
 JM7Wj25pWbRAg4MNrHIbz1SZpGz4VoaBHOuzYrzlWlW8hba0wr/83nMd9UnLulqts+JLrQi4Stl
 A8VpaVp1UK8TaDyj7F/zXi0xW/JuHeTszBoDV1Q2WdVwqz4LiJ40mT00t/mFHW9fi9yywBDE/Tw
 7dy7NlDESfNYbl6LRDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050189
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
> Add little-endian virt-queue configuration and support for virtio-blk-pci=
 IPL
> devices.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c          |  61 ++++++-
>  pc-bios/s390-ccw/pci.h           |   3 +
>  pc-bios/s390-ccw/virtio-blkdev.c |  18 +++
>  pc-bios/s390-ccw/virtio-pci.c    | 265 +++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio-pci.h    |   2 +
>  pc-bios/s390-ccw/virtio.c        |  54 ++++++-
>  pc-bios/s390-ccw/virtio.h        |   1 +
>  7 files changed, 399 insertions(+), 5 deletions(-)

I realize this makes use of vpci_bswapXX_write routines that I made a comme=
nt on earlier. Feel free
to disregard that.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

