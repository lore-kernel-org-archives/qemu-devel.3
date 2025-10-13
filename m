Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F31CCCD190
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 10:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Fdx-0003Rb-2v; Mon, 13 Oct 2025 06:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1v8Fdo-0003QM-6a; Mon, 13 Oct 2025 06:18:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1v8Fdl-0004G4-7m; Mon, 13 Oct 2025 06:18:55 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D309UJ024843;
 Mon, 13 Oct 2025 10:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4xAZvQ
 MWCiPLCOaAkwYfhpQ8b3Lu5ChfqzqzYe65oLI=; b=PgkRN7M9++pRYQOxlHqWjx
 TsSolSNuhu15zF/FpsrVtrK34LmATlMFnm++Nhlp8c/H6xy1pziJpXJ+vX2rS6uY
 y1NnG/yFrzKhXttVNy19G5Mb7PrTHa6/SgC056DAkGi9d/ejI3LRJCyjuyzHJ1kK
 5kDD3pWtmt+IMT+nOKCFrIsH6HEYAYRjLw8VLmkWrZ2ANmV59q2GsyGlusAXl5RI
 k660GdO0if1ZgOmAgJo9RUo0YW4GzXKjOiczAhrxawEEfpnB+yTdZglAZ5LJjiyU
 aDWQUPrfPjO0awCHFLJeqjH11mRNsHCnJTMArFimTV+obMczMZkisQEuWgw00TlA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qevyr3u2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 10:18:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59D6R4na016705;
 Mon, 13 Oct 2025 10:18:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32jn77d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 10:18:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59DAIgNm31589042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Oct 2025 10:18:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 959F82004D;
 Mon, 13 Oct 2025 10:18:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B3E72004B;
 Mon, 13 Oct 2025 10:18:42 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.38.192])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 13 Oct 2025 10:18:41 +0000 (GMT)
Date: Mon, 13 Oct 2025 12:18:40 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, farman@linux.ibm.com, thuth@redhat.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, alifm@linux.ibm.com,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3] s390x/pci: set kvm_msi_via_irqfd_allowed
Message-ID: <20251013121840.2056babb.pasic@linux.ibm.com>
In-Reply-To: <20251008203350.354121-1-mjrosato@linux.ibm.com>
References: <20251008203350.354121-1-mjrosato@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LGz8y5YWoYYd-VCGoGBBTCUOrUtgJIlC
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68ecd208 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=bf3z2jQr7r-_6UqURtQA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX/MGKayV35iPW
 aVftUCngIdhlnLcvWcyDaZPGvd0I+pMBBt7w3o2uoW4soSJ51qC3S5MT2zVuimOj7NEh/yV0IF9
 E61In+Huyeej7iEGtBu4mC8TDW9qoHUMzgm0Is+yuXFxv31HDlZ9OBuoL47SN9gia4U7BWe4G5A
 WiiSkQxl5IF8DENcs1+TJ9Qv5dPj4HGh10pQkzgFpuzyKSjLr/FBGJukZqeLPyc/yjvn1JeQB+8
 EWB6F2ddf5U2+eXPMiSE3nNYy3FiTdrAfZdKKGcdn/76irXcpwvkfEeYV/iDx13PTiZgVHxUTi4
 IPSqSh6EWo7Y39YRJLBOMkc28bpMYwKuHugBazWZW1s3vz24fucyvciIoZtCGn4LEkQBYBV3ueZ
 IE/sqWSSrPO3SyPn3quKz9UbkBxOaA==
X-Proofpoint-GUID: LGz8y5YWoYYd-VCGoGBBTCUOrUtgJIlC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed,  8 Oct 2025 16:33:50 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Allow irqfd to be used for virtio-pci on s390x if the kernel supports
> it.  This improves s390x virtio-pci performance when using kvm
> acceleration by allowing kvm to deliver interrupts instead of QEMU.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

