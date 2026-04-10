Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8A0F45A0D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBIvy-0002NE-NG; Fri, 10 Apr 2026 16:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wBIvw-0002Ls-Qx; Fri, 10 Apr 2026 16:58:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wBIvv-0000k4-9x; Fri, 10 Apr 2026 16:58:32 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AF1f952316587; Fri, 10 Apr 2026 20:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xXdWol
 WSKm731L9m9hRYU8gowOKhxDE4GPPkt8FLQWA=; b=lXb7L0F34dvNX3qD+84XYt
 kQIwE4bXhBhAxbuTXLJXWmi2EVXwPj46G9yB/mYt1itLAJKHxIzwdeFOFFxgmM/N
 BhEmdXIELKYOKq9uE5Wmaac1jPHurmbYB5FFP1rL5gm6rml11AkiF0xnuKL1nbsN
 2c1k+XlJFLd6m8q605fBWzYKJGCvdFv4Gb2CtD0euRiEVgo8Bgd6497ubnuKdbB2
 I5itkt35O/e2O1qUi1BbvKaAXB9l0d4QuUnj87SCYeSDaiIjOyMwvNj+73Oz6jKf
 bzbra8nfcyxWqVQ7lk9oATnLK+UA8+5rdoB/064mm6J1kOQIVU0zS7gxJq3cBjaA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2gc5x3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 20:58:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63AKCLqC007887;
 Fri, 10 Apr 2026 20:58:25 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2t24b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 20:58:25 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63AKwOLO31392456
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2026 20:58:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 596995805C;
 Fri, 10 Apr 2026 20:58:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2517158051;
 Fri, 10 Apr 2026 20:58:23 +0000 (GMT)
Received: from [9.67.17.158] (unknown [9.67.17.158])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 10 Apr 2026 20:58:23 +0000 (GMT)
Message-ID: <8bc4e2a9-88cd-42e8-a993-80c77067ced0@linux.ibm.com>
Date: Fri, 10 Apr 2026 16:58:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 22/30] pc-bios/s390-ccw: Add additional security
 checks for secure boot
From: Collin Walling <walling@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-23-zycai@linux.ibm.com>
 <7525fd12-c5a2-45c0-bcb3-cf8b0956b988@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <7525fd12-c5a2-45c0-bcb3-cf8b0956b988@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FKArAeos c=1 sm=1 tr=0 ts=69d96472 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=4Y6IY6x4-x7QRFFaB_wA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UcsrJEG4fz1AOH6HWnkBa8AkzvznvwoE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE5NSBTYWx0ZWRfX+BMzBrQMSRLK
 todXzon3J3PmQ8fHqcajutek3el3X1dDkQR2HAMkrl55fbbH8P877aUCRlans+JXhsRPYRpDNuG
 sKjtgZPgPJTxM+eIzrl0QQwWylpVrwCed9+y0364qfp3Lod0pKapYiDSa4bi42UncVVWSIsobCK
 tqrVt7IthCLYPG0Ew6CP7KztT6qgwXndPbD0KllODDhVcQs60afDNQkdkJtXiyhfyb2xFN9pWlf
 +8klLCj1ta2hKwpwMDxDB/1wGCDdaQXzXddwTp6iZ249k1n3V9hsYiL9srhKa2ahUtgyxpieSL/
 Bp9VMrGchu8yRqJcaShAD0RYXr9SL84E388eS/wz1D/3mtOVCHT++HfjKu4oYkUHXWYKA6R/e/Q
 qvifqQH7Ycr1o6KZ1B4uaxpdO3GZnng/HquqdVMRUJeHjhioJ8ghqb0IEooQkxI01ti78THFPGn
 K/5N/X4rWzRx9P3JQ1Q==
X-Proofpoint-GUID: UcsrJEG4fz1AOH6HWnkBa8AkzvznvwoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100195
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

On 4/10/26 16:51, Collin Walling wrote:
> ```
> validate_comp(sclab_info.count > 0, &comp_list->ipl_info_header.iiei,
> 	      S390_IIEI_NO_SCLAB, "No recognizable SCLAB");
> ```

On second thought, calling this `zipl_secure_validate` or something
might look better.  It follows the naming scheme of `zipl_secure_handle`
which conditionally resumes/aborts based on the boot mode.

-- 
Regards,
  Collin

