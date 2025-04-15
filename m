Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2805C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 09:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4cH8-00086f-JA; Tue, 15 Apr 2025 05:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1u4cH1-00084s-3f; Tue, 15 Apr 2025 05:08:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1u4cGy-0000GJ-Jb; Tue, 15 Apr 2025 05:08:05 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ELgMtd029696;
 Tue, 15 Apr 2025 09:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=Bs060k4XWuQUhw6XRzVMzSLCmEk9NU
 SjA9n+VaBKEiw=; b=D8x3+DreW3k3V64rpWPO2p86ZYdfsyg4eOpjiXJJowRZ5Q
 VeOngnK4MsNXjsQHoz7zYyn1mrfeKSWiIX2Hb2GY+pMvEmEr3HC5/2AV2/UeO3hg
 0kHTyN3PlKNU+hMpXY8yHFr4pAiqY7JKeF6SsaztC+wzWPd2ViYxLtuVd3BWiifh
 uJhr5YnKw3uOHvudeKKKyTCwComdFP5oJVDlh58geJB1jW8WWSdnv1mun07GO1Ir
 NTAxb5gEDLms18y0T0rxhb6pCDpVPO0PdUTKQZ29/ID+6I/rzMmVjo8cqgzqdp8j
 0FRIsTUA82IsV/Mb0gI/u+fX2NsdTmwPGBgctxUg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461agt2e10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 09:08:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53F5dD51030910;
 Tue, 15 Apr 2025 09:08:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gnjep1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 09:08:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53F97wjf52625686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Apr 2025 09:07:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A68A20040;
 Tue, 15 Apr 2025 09:07:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1338420043;
 Tue, 15 Apr 2025 09:07:58 +0000 (GMT)
Received: from osiris (unknown [9.155.199.163])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 15 Apr 2025 09:07:58 +0000 (GMT)
Date: Tue, 15 Apr 2025 11:07:56 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Gautam Gala <ggala@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 2/3] target/s390x: introduce function when exiting PV
Message-ID: <20250415090756.20550-A-seiden@linux.ibm.com>
References: <20250414154838.556265-1-ggala@linux.ibm.com>
 <20250414154838.556265-3-ggala@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414154838.556265-3-ggala@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CioeFaY6TzjIPSW7Tiqct-_lfOAv5Uzh
X-Proofpoint-GUID: CioeFaY6TzjIPSW7Tiqct-_lfOAv5Uzh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=522 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150062
Received-SPF: pass client-ip=148.163.158.5; envelope-from=seiden@linux.ibm.com;
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

On Mon, Apr 14, 2025 at 05:48:37PM +0200, Gautam Gala wrote:
> introduce a static function when exiting PV. The function replaces an
> existing macro (s390_pv_cmd_exit).
> 

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>

Nit:
start with capital letters at beginning of sentences and after a colon.

...
 

