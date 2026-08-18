Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74FEC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 21:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwR3Y-0006Um-49; Tue, 18 Aug 2026 17:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wwR3A-0006SR-IJ; Tue, 18 Aug 2026 17:08:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wwR39-00057s-0t; Tue, 18 Aug 2026 17:08:48 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJWCqc1151947; Tue, 18 Aug 2026 21:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yqBV3+
 9CPOHNp06DQNfZu2LrhC+tM7QVCMIKhUrJkWI=; b=HYMqJPbsqTW9XtoEzw9F5a
 WfYohDiS6BaWygmhcaCHmWzIWU9YRLqrcnKj5cIxQ8hbwy+7vZqF/SsBRo9/CA7H
 sKHeBYe8oB3SPi8XvkzV1RSi0/zJhFjfQMEBWGBm+DViKmNg0K8pMl2Gi3iYG1HO
 qHvXGsP6YJHPW00CIEFXN7EzMn3bNrRIBdSoQzgV28vBScOGRQ96qnf96C5bzEAt
 J14tbZbSWVFxNzPHBOFNWOlukhZKP1dYvpRnKRHCajl79fDT4gJTMjwna8pFKo4d
 pPDhxVUGIDlE4aWLpojcJPVw1tYgzPAzsIlaM7tj0XV1H1J89xP/XD6v/Sf3w4Mg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhm2pvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 21:08:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IKuI5o032713;
 Tue, 18 Aug 2026 21:08:44 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw5m0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 21:08:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IL7RDf54657384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 21:07:27 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4756A5805F;
 Tue, 18 Aug 2026 21:07:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5954F5805A;
 Tue, 18 Aug 2026 21:07:26 +0000 (GMT)
Received: from [9.61.131.241] (unknown [9.61.131.241])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 21:07:26 +0000 (GMT)
Message-ID: <d49f3a72-1c4d-40c5-a581-bd773641861d@linux.ibm.com>
Date: Tue, 18 Aug 2026 17:07:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x/sclp: pv: only copy the original SCCB buffer
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260814125857.1729543-1-borntraeger@de.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260814125857.1729543-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE1NCBTYWx0ZWRfXyG8FmVIh5UFp
 WvZEcf++WVuJGW15FThOl5osCe7W+tkkLtIjyEunyJfAVJ8AVRUT8na3VMPtgzbV0d9DxnISdoL
 RAfF9t1uUNr2RXbAXv4FDRrmRJEB+azPrAgJ4h18TSYJtxbDt2E/bQhZwjZ9b76dcQR+5ZnZHia
 tmiAKRynAByz9QlJGE4mIPGIqe5glVb6jpyrEpvrrQoFrI77IxSPC6puiCCIEae8qUE6HaJHQGR
 /kT1n6v4qvLYW1jrPa/2vMN/DY3OYw3me960dxrDrhLVNXCVs40dKTWNP3k7eTRhkdRYdw4zGIo
 Iehf7O9FSJEYxrzm9+pYuSmHCCnzyrxoioGshHFI9sK+LjTZl8crEM18cb2tXxLcCsbJ5R+Z/Dh
 IoK0ZeIxGiDBPjXMjq0PZjdVy0a+FZGVtFFmB7x5E+fhNCqaExEZ/LKqyArCPu76JZ0zTfTmANI
 MgHJtFTX0bjYv1NetXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE1NCBTYWx0ZWRfX9DNHIzm0dG2a
 tjgL4OUUTO1BauqYQdE8lO3SI+J5Okdimrom2jJ3h1UvoesWs1U8g+9ObLPjqKuttUS5en+L3Kj
 ZKiYoCqYJJy0zfc5wyw7LkAPvQiLIxU=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a84c9dd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=7XKqtF_WH49KvPqE1nQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RH5BQRwP3fHa_36fYdj9jteDBOJR5EpD
X-Proofpoint-GUID: RH5BQRwP3fHa_36fYdj9jteDBOJR5EpD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180154
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 8/14/26 8:58 AM, Christian Borntraeger wrote:
> From: Christian Borntraeger <borntraeger@linux.ibm.com>
> 
> With variable length and EXTENDED_LENGTH_SCCB, some callbacks might
> change the length field. For example read SCP info might write a new
> length into the SCCB header. We must not use that new length for the
> buffer copy, since the buffer was allocated with the original length.
> Only the length field in the work SCCB is changed, to indicate the
> "necessary" size. Using the new length reads past the allocation, so
> tools like ASAN might detect a buffer overrun.
> 
> Secure guests do not have EXTENDED_LENGTH_SCCB, and the ultravisor checks
> and sanitizes the length field, so no qemu heap contents are exposed to
> the guest and the non pv-path already has the same header.length.
> 
> Fixes: 0f73c5b30b8b ("s390x: protvirt: SCLP interpretation")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



