Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA80CD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 14:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLiz7-0003uU-QS; Sat, 09 May 2026 10:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLiz6-0003uE-Td; Sat, 09 May 2026 10:48:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLiz5-00039R-G3; Sat, 09 May 2026 10:48:52 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6490NrDK2818367; Sat, 9 May 2026 14:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=KrpMPdiQemC9W/dK824fTvbgK3xD8+
 iPtssJQafSWfg=; b=Cqy5D9LlpOdPP0H41cPR2kEBcTThrp/TgzquD2Tx5mZAiH
 /Sm12iojxQuD8/rTHOrjf4TqduwpWnWZPIhQiZdTvYgXsMPWx9Z0h0RFN5LW1ELI
 EquQOdb9UdYv3Bj3SgbONoB6o0/pEc0ESblCj5HRVU5ybjnAuKPSZCnKygs+ArE0
 mpjHCUg22zkoZgWyL+44Qbhpm6MAGLbNJ1VJwydbqOtrqg2wtrG6x3nyNC5oIsyt
 0SN+w2aMjHCik3Vqml4qZ8zdgr37wkO89Bw3zdiBh1MflEWK+/oMZV10lV6DxbPW
 /X+vIq3IlVZqSWJkz5sBQmSBfshQ+PEtPK4JLjaQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1tbhj39f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 14:48:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 649EdUR7008462;
 Sat, 9 May 2026 14:48:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e10077xk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 14:48:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 649EmaaX43581850
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 9 May 2026 14:48:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEE8820043;
 Sat,  9 May 2026 14:48:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F90C20040;
 Sat,  9 May 2026 14:48:30 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.25.188]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat,  9 May 2026 14:48:29 +0000 (GMT)
Date: Sat, 9 May 2026 20:18:26 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnuvw@linux.ibm.com
Subject: Re: [PATCH v4 3/9] pnv/phb4: Implement sticky reset logic in PHB4
Message-ID: <af9I8BUI0v1LgK-L@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-4-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305060923.3753402-4-saif.abrar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ZdQt8MVA c=1 sm=1 tr=0 ts=69ff4949 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=sFlWH-87I1gIMj7nZk0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: SlrAfH9_9z8qRPaCTLE5vja5VI17OI1v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE1OSBTYWx0ZWRfX2S15zc9j9tZq
 G81LT0jxC2DX+i107lLVvDLmyPnwIk3b5gUHj8WWOxFjwIyO5C2m5wJsl12hnGR86aZMJoo9bXb
 5fMVYIqoNvCD04LP3xO4RoqdDRwlUDaV93wFOkD5cHbQbOw+VMxXUIjYiMcyJWZSoMFjAP7eJg+
 l2RaG57qrTRadkZJPPujqiAQMm82Q6KmKb9EhaRpHQUTpth94tQ0IeFDCLb3U2GxqCdELPU/oEI
 X3IbqkyneWI+Tr3aUCwz3q5pXKEaND0b+pklb4zlK2scOD0NxIJx7jGRorMr3TFu6OtEIA4D/jK
 lOCTEehQ5qHYsBsZtiimU6ZJC35a3HhfTR63Fx12AdrkxUiHgPiuVpxG5zXa1E9aNU+QQBTmBXg
 bL7ll8MkIB6QDB/qtU5OmaNbw1JUJKLMBhDVGk4PbvtU20ADaW611WsOfKJvbjDMPFRf4PaAjpT
 cx3uCSKUiaKR7k97khw==
X-Proofpoint-GUID: 0XEoJoHTOW8WvDZMKx0krDhhTXsMFdUw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090159
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 26/03/05 12:09AM, Saif Abrar wrote:
> <...snip...>
> +/*
> + * Apply sticky-mask 's' to the reset-value 'v' and write to the address 'a'.
> + * RC-config space values and masks are LE.
> + * Method pnv_phb4_rc_config_read() returns BE, hence convert to LE.
> + * Compute new value in LE domain.
> + * New value computation using sticky-mask is in LE.
> + * Convert the computed value from LE to BE before writing back.
> + */
> +#define RC_CONFIG_STICKY_RESET(a, v, s) \
> +    (pci_set_word(conf + (a), bswap32( \
> +                     (bswap32(pci_get_word(conf + (a))) & (s)) | ((v) & ~(s)))))

should be32_to_cpu be used here instead of bswap32 ?

- Aditya G

