Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392C9C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 11:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA5QU-0003Tn-IK; Wed, 30 Apr 2025 07:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1uA5QF-0003ST-BO; Wed, 30 Apr 2025 07:16:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1uA5QC-0008S0-Ar; Wed, 30 Apr 2025 07:16:14 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UA4Dx2006425;
 Wed, 30 Apr 2025 11:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=UiZDN4ieHNK2NFU4zb9jQfoCyosFsY
 zflROR2QiB/L8=; b=Zqc+iTeLE5Y1KdxxY0xZA2lBALBW6vabKXPCEzfY4JY/sw
 eWqi771YaVvvY+OuxoK0H3OAhrlfNfysk+L9j1RM+hRzfPeXd7A61k4p57fM/mIe
 Goiv9KTlOt/TpNSYxRlcjvhkJlu6E3T/n+PnVMxNMqkPOMNTQJmh5w+vvGhdnjV5
 +4YN288NzHHhAih+1izvhejUuUn9vzII7W11ICAhqSomrf9Pac5sdrEaFR/hm2sf
 wlsNLlcqDC6VFIi9XfxUJ0BsUZ60vZg/j+C5fFDVBFO9yAkCPqQn+sKLWvBEjizF
 cYLK8duWoWP2U39NBXBbV6k2Ud6GcQuZXqe4UKKQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46bhsjr9tu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 11:15:32 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53UB0f8B025696;
 Wed, 30 Apr 2025 11:15:32 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46bhsjr9tp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 11:15:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53U9Rwfm024607;
 Wed, 30 Apr 2025 11:15:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 469c1m7b0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 11:15:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53UBFRvw31130198
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Apr 2025 11:15:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9824A20043;
 Wed, 30 Apr 2025 11:15:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2F0020040;
 Wed, 30 Apr 2025 11:15:25 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown
 [9.124.221.86])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 30 Apr 2025 11:15:25 +0000 (GMT)
Date: Wed, 30 Apr 2025 16:45:23 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 pbonzini@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 vaibhav@linux.ibm.com
Subject: Re: [PATCH v2] hw/ppc/spapr_hcall: Return host mitigation
 characteristics in KVM mode
Message-ID: <3yhi7haaddnluzc5oy23nynywjeazkkngx47hwoymce6lmcitp@chtjm727vuz4>
References: <20250417111907.258723-1-gautam@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417111907.258723-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dcuA3WXe c=1 sm=1 tr=0 ts=68120654 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=pPNRN5iWhjdFy-iXWNUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: q49GvDOeZJPz3AGM5bALBlxmbci7SeQD
X-Proofpoint-ORIG-GUID: bRY-NMR0W81ELbhCsaXgLzU-rE2gsMAv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA3NSBTYWx0ZWRfX4AOrvpznDcyQ
 EavVYP9WyoA9/TfcLN3RwqIZfIQohrmanJfQFEDXOPHQ6uXsEkO//Y3VNmHmHutmZR/wrt7YRT1
 2U7jqWlTXKIiMcOake+F44NxJduoXDNvmkjWF5gyxaFYUoMOY0nqgsnhnG9BciLNTaCwkpC0NFJ
 sb42mNkKyie0GlJOlRVJtLHBwITIWDGsAzQToEnE/I/i/V+7UihOKs/MVniVKCCwTmvPc1iNxjS
 EW8psXKxRGVxvk3Udh8yoDSf1+sMuPrKuWdV7+/WkewSVWeHz0aQGifVbYDR7ga5FkQ2FKOyeSQ
 rbXgmYeVKChdROyr61Q5kRXeF3xcMn71aga2/vbLGx2hWuSPNa3McmDqxVLkJmMu6qzm6Onm4NU
 YyXmBo3CeW8vu2V59lS+INI5T9cROvXAgowuTG4KV9dzUymfgX0DovGyX5K3rRwmjl5To3kH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=556 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300075
Received-SPF: pass client-ip=148.163.156.1; envelope-from=gautam@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,

Please let me know if any changes are needed in this patch.

Thanks,
Gautam

