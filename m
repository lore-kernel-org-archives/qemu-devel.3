Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA47ECA0EE9
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 06:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoGBV-0006Vk-C8; Tue, 19 Aug 2025 02:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1uoGBQ-0006VJ-FZ; Tue, 19 Aug 2025 02:51:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1uoGBN-0002yF-Og; Tue, 19 Aug 2025 02:50:59 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ILM1iq007399;
 Tue, 19 Aug 2025 06:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=iRV+W6QThysfrvizo3/8uV92ybjKwP
 HoJJoCE2aPg3A=; b=KW/L5a+B//T54gIoa2AwzE51GHJWR+/t4BNzO3fs65qtTS
 oiuh2L6dPVPjDBZvLcqvvbEeKYCLxZbv4DU6CUrB8KxETE/L+0Y5fRcL5s1zolzj
 LBAtKSGoU43J8wzCEdOJtP29ZfDHj0D80UXtW4e9J1CO5qldqpggGVj2QIsfS+Bv
 xCK5IrVj01LP12L+Unl2JQsMGTbF+InHuuiV68RSrnd/Y9YiBxCB16sngPZCOsWr
 cQLwEQLm5XmYPo2OVfbYZVWd7sD89KjBYTYJtKMy7jaCI56Ll05CGrLVirsYtD6Z
 azst833QA+QuCKhkepMahOznvKDffTWwKUkrMAJg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jge3w1xs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 06:50:54 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57J6kUln006346;
 Tue, 19 Aug 2025 06:50:54 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jge3w1xp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 06:50:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57J6WVYB002381;
 Tue, 19 Aug 2025 06:50:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k7130ttt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 06:50:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57J6onpG15860042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Aug 2025 06:50:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A091D2004B;
 Tue, 19 Aug 2025 06:50:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 683742004D;
 Tue, 19 Aug 2025 06:50:47 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown
 [9.204.207.58])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 19 Aug 2025 06:50:47 +0000 (GMT)
Date: Tue, 19 Aug 2025 12:20:43 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 pbonzini@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 vaibhav@linux.ibm.com, nicholas@linux.ibm.com
Subject: Re: [PATCH v2] hw/ppc/spapr_hcall: Return host mitigation
 characteristics in KVM mode
Message-ID: <aKQew7Qh9Zog5V3N@li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com>
References: <20250417111907.258723-1-gautam@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417111907.258723-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FcM3xI+6 c=1 sm=1 tr=0 ts=68a41ece cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=KCARQexVgrCxVkT0HaQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: pCL6XuMGsFdL9rSV4hKe_Zt_e9CgYx8V
X-Proofpoint-ORIG-GUID: ld_xxx9nNh7kqZXUdmB7ysp6gQMDzNJE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAxMSBTYWx0ZWRfX35XdXQksfCYQ
 uUhFqrsssBaRz5d6AKDvoq4OUj8C7TOtbZcLA9LlJgu5bH18rIdhiHb6l+pVE1MmI1sXXBfSzTa
 4oXfNmnpOp+NyoJbA+4sftk66PVqFuWXM5kHOpPDUPInEGYcvAttG3lPhqHtJ6ADvynD8N7M3Rk
 V5pPasVFXdxvrAVYo3gPr397Jvdx6HEdd/JCP8GaLmjwZtpDIBF8VUf4cK7YsOkDxFNGS27SA/b
 EyyQVHw8CTaWdhmdFuE9jSwqtD6XyAlhF3aERRD0OwFD8D6FW/Pin3nWEbS0ivQdGkGb9Jd9TCf
 GXj6ye64wayb2zU94B8ALZtfjCvngPfiFtObO1m5qp2Waz+5X/SD1OdPvSSztH/FjD6Ryu9EtM9
 qJr4rcqZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1011 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160011
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gautam@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

+ Nicholas

