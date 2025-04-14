Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AEFC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 13:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4JxO-0003VZ-SO; Mon, 14 Apr 2025 09:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1u4JxL-0003VI-Jp; Mon, 14 Apr 2025 09:34:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1u4JxI-00060l-67; Mon, 14 Apr 2025 09:34:35 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EAvjVR011560;
 Mon, 14 Apr 2025 13:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=SBMcRSpilNqcPQGH2zilpy5yZW1iZ8
 O/0pT68SJ9RFU=; b=gq55Bm5ZzW0v87OkSfm5IZHvsmbCAoWKZ1EYQXIJbme9Pg
 z6sQ32D7zLO1avFwGT7RRh1s5/4/hdkBCYvn+dxg+muroUL0/n9vJ473UM5Dw44Q
 xJdXj4rAS7YYdPPHiLqtcJ+G0jlPKLT68tW7Hk7gvfU2nEP9IMceAbbYiuCx8V2V
 pchqMTrEkkuACfAjEqd/ECJqMuIGdDhjd2g7JUDbKALxbshureeIChEFanS64Qm+
 gOSGpqRtldD5ra9ce76wrP3L/ZE5nnoRIp+7U7Smz0olB6q6JozSQgQbJUHxuN6n
 93OP42f5oNsF/rYgMy5R+loQ+9edV12otm05xt8g==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460mufunjv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 13:34:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53E9ZpvV010392;
 Mon, 14 Apr 2025 13:34:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qjx4ca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 13:34:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53EDYOTd41419130
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 13:34:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85AA62004B;
 Mon, 14 Apr 2025 13:34:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6249020043;
 Mon, 14 Apr 2025 13:34:24 +0000 (GMT)
Received: from osiris (unknown [9.155.199.163])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Apr 2025 13:34:24 +0000 (GMT)
Date: Mon, 14 Apr 2025 15:34:23 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Gautam Gala <ggala@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v1 1/3] target/s390x: Introduce constant when checking if
 PV header couldn't be decrypted
Message-ID: <20250414133423.61624-C-seiden@linux.ibm.com>
References: <20250411092233.418164-1-ggala@linux.ibm.com>
 <20250411092233.418164-2-ggala@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411092233.418164-2-ggala@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wvJZa0LzFiV9fBEs1yAFn5xw54afOuHi
X-Proofpoint-ORIG-GUID: wvJZa0LzFiV9fBEs1yAFn5xw54afOuHi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=760 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140098
Received-SPF: pass client-ip=148.163.156.1; envelope-from=seiden@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 11, 2025 at 11:22:31AM +0200, Gautam Gala wrote:
> Introduce a named constant when checking the Set Secure Configuration parameters
> UV call return code for the case where no valid host key was found and therefore
> the PV header couldn't be decrypted (0x108).
> 
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>


