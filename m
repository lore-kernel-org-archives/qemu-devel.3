Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33868C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 13:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txQgF-0008K6-85; Wed, 26 Mar 2025 09:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1txQgB-0008Ir-Ri; Wed, 26 Mar 2025 09:20:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1txQgA-0006wV-4p; Wed, 26 Mar 2025 09:20:23 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q8OIB6011284;
 Wed, 26 Mar 2025 13:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3s8TbJ
 frwe/5PkfIXZ9j9BfIJOtMfWmkprnj9htbYw8=; b=LuQ9YARAM/Gxd0sXgSHnkU
 YWszEtqY1Y/t86eBWfSZWwS+ydZeFeZiquwtLgNQOxbDmhqLju/eKKZgGqmQP6tX
 1TApp7KIYlAs4sZtXzn2Vy37MFeVrrKalfy/prE3XunOaOcbqdeh72E8pSbup7NB
 b4WzyrsE8PLU2WSxnEdLk/qXcg74BupB4xV+Ymf1p79/5ZUCJ1Mge8VVEIPwglwI
 8MeVDBf4jqG9s+OhL2gej8AGFUrclZFylyXzsyNgdhVrD51DlGST5zA+iz/jtDSl
 i6KkepYWbu15xcLoP6MxwlgzeGUJb3yA/qp3E2pXkVY+O9Ed78eOpHFi46T5AXtA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45m3nqkv7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 13:20:09 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52QDC1LI020947;
 Wed, 26 Mar 2025 13:20:09 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45m3nqkv7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 13:20:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q9GUOh025443;
 Wed, 26 Mar 2025 13:20:08 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7x08m0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 13:20:08 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52QDK7f637225060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Mar 2025 13:20:07 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 525E458051;
 Wed, 26 Mar 2025 13:20:07 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CEC125805A;
 Wed, 26 Mar 2025 13:20:05 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.118.127]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Mar 2025 13:20:05 +0000 (GMT)
Message-ID: <6653951fe8afed27c217e44aeed70a6d3798a818.camel@linux.ibm.com>
Subject: Re: [PATCH v3 5/7] target/s390x: Declare
 s390_set_qemu_cpu_model/cpu_list in cpu_models.h
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Daniel Henrique
 Barboza <danielhb413@gmail.com>, David Hildenbrand <david@redhat.com>,
 Christian Borntraeger	 <borntraeger@linux.ibm.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost
 <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>, Richard
 Henderson	 <richard.henderson@linaro.org>, qemu-ppc@nongnu.org, Nicholas
 Piggin	 <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Mark
 Cave-Ayland	 <mark.cave-ayland@ilande.co.uk>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Date: Wed, 26 Mar 2025 09:20:05 -0400
In-Reply-To: <20250324185837.46506-6-philmd@linaro.org>
References: <20250324185837.46506-1-philmd@linaro.org>
 <20250324185837.46506-6-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2Vcl4f4W1J9HB6vxr2x1wTyciqUyQdDv
X-Proofpoint-GUID: nDdXLDUDcvfcirkYF8U5-3mCV-zaX580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1011 mlxlogscore=602 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260079
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 2025-03-24 at 19:58 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> Both s390_cpu_list() and s390_set_qemu_cpu_model() are
> defined in cpu_models.c, move their declarations in the
> related "cpu_models.h" header. Use full path to header
> in s390-virtio-ccw.c file.
>=20
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/s390x/cpu.h         | 4 ----
>  target/s390x/cpu_models.h  | 3 +++
>  hw/s390x/s390-virtio-ccw.c | 2 +-
>  3 files changed, 4 insertions(+), 5 deletions(-)

(resending with reply-all)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

