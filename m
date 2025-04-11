Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91C8C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 18:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3JFp-0006UB-Br; Fri, 11 Apr 2025 14:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1u3JFm-0006Tc-Ts; Fri, 11 Apr 2025 14:37:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1u3JFk-0000Dl-Tj; Fri, 11 Apr 2025 14:37:26 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BII3RO022890;
 Fri, 11 Apr 2025 18:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hbVOEp
 lqOyzxRn5S+zftbmfk7sP/D7RtCc2E1FQf83k=; b=r/wz0Whpi7ft0WjmYQHP0s
 +9scJe4yIYBfCulu6vYAeA8RLiaa7WvuL4wsIGsMBK32Y4tYPlenYH0L5hmXPvK6
 rY0gZB3EiUXsuQXR0PUKMK5KeO9lbnUwpfHfQtbs5vqw3q8vnUk0jleeW2lzUh76
 OPw8SUyjvMySjhNBculDAfUugwuzjoLqPccLsZsvyrR+HTBMZ6Cp2ZCUjRLr45BJ
 mm2ur4Qb4QyU0KbLTguW6yb6N7Tn4jAwaOI2GBSXq42PWIkLR9CA1jZMG1HXYdKM
 XMTzy2E7L8PZt0sxuE/zekWKyn/VW/Gp89GO6oBIZNtpp9wHLQ12oVSwdKOBd10Q
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45y78x0dn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 18:37:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BFN6Xn017447;
 Fri, 11 Apr 2025 18:37:21 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2m44jq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 18:37:21 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53BIbLJT15663696
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 18:37:21 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAE2458062;
 Fri, 11 Apr 2025 18:37:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BF9658059;
 Fri, 11 Apr 2025 18:37:20 +0000 (GMT)
Received: from [9.67.45.136] (unknown [9.67.45.136])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 11 Apr 2025 18:37:20 +0000 (GMT)
Message-ID: <5fa2f84d-87e5-49b8-9906-0d36648d70a8@linux.ibm.com>
Date: Fri, 11 Apr 2025 14:37:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/24] s390x/diag: Introduce DIAG 320 for certificate
 store facility
To: Thomas Huth <thuth@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com
Cc: jjherne@linux.ibm.com, jrossi@linux.ibm.com, fiuczy@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-5-zycai@linux.ibm.com>
 <e0839e81-eab8-48cf-b55b-64d83f7633a3@redhat.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <e0839e81-eab8-48cf-b55b-64d83f7633a3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o-VUxoM95OCn1c-L9dgVGA34UMhsxTc_
X-Proofpoint-ORIG-GUID: o-VUxoM95OCn1c-L9dgVGA34UMhsxTc_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 mlxlogscore=888 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110118
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 4/11/25 9:43 AM, Thomas Huth wrote:
> On 08/04/2025 17.55, Zhuoying Cai wrote:
>> From: Collin Walling <walling@linux.ibm.com>
> ...
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> 
> So the patch is from Collin, but S-o-b only by you? Looks weird, this should 
> either have an additional S-o-b by Collin, too, or not have that "From:" 
> line at all?
> 

Joy took over the bulk of this item as I had to shift priorities.  The
initial version of this patch was mine, but the work now reflects hers.
The "from" line should not be there.

@Joy, when you go through your rebasing/patch fixup, make sure this gets
a `git commit ... --reset-author` so it reflects you as the proper owner.

[...]

-- 
Regards,
  Collin

