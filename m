Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2DD107BCE2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 20:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w18gQ-0001qS-Jd; Fri, 13 Mar 2026 16:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1w18gP-0001pV-27; Fri, 13 Mar 2026 16:00:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1w18gN-0000Gp-In; Fri, 13 Mar 2026 16:00:28 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DILwTo2581002; Fri, 13 Mar 2026 20:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=O6Tr4i
 m9TyADfrN8la2UNoLhMDI7e2VOt0WEtOhdg4w=; b=NAfIUEGuPW0YWJxw2C2XFY
 kQuEytpWWMqjPXNJdkd//YaIrTKyHYLxDCUZb5lnmoJO+XPkMm5K0QdULCtgIgOO
 KLkyWTi4EdVl7AZILfm6J6XSAYEfgmxroeuEjQ2Z2UG7GtYcC2xE99V+XgplzQHp
 wG+LJ72AmrX5IVYpSJx/ue5o8lbYxfZhgZcdVO1FK+YFbx8DmMwBXZerjy6dhugg
 WQRjKxlVjbAdaUrXXEaeSB1CdDVVlhvYVRmGpGaelYAVLCEEnC1CPAvA+zE4YgyL
 PtPN5v9+47zFIKxjX55wc8ssv60ylYZ9EaivSwaNaf84zrm+yCd2WjTZVL5kBBWw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh951jxb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 20:00:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DIxIuo006031;
 Fri, 13 Mar 2026 20:00:18 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9r47b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 20:00:18 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62DK0Hpn7865072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 20:00:18 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A43FF58068;
 Fri, 13 Mar 2026 20:00:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4FF25805A;
 Fri, 13 Mar 2026 20:00:15 +0000 (GMT)
Received: from [9.67.17.67] (unknown [9.67.17.67])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 13 Mar 2026 20:00:15 +0000 (GMT)
Message-ID: <d46beb5f-b5ce-44a9-833d-cf0d32516452@linux.ibm.com>
Date: Fri, 13 Mar 2026 16:00:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/30] s390x/ipl: Introduce IPL Information Report
 Block (IIRB)
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260305224146.664053-1-zycai@linux.ibm.com>
 <20260305224146.664053-14-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260305224146.664053-14-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69b46cd3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=A0tMd9DopOBf3iaNJbsA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE1NSBTYWx0ZWRfX1srFa4Vns8tg
 Ly0V3Y8zmB0vqaJOJmGQg7q0Hyxjnt1HmOiK2tB6BlZdy4cUMtO0lp7tihZQih6ENDQRnXHPtqr
 iq5O/nFQw0QpuX6TngCSNjXqswvInW9Pu44Gx8T6OtCPLa6L8vXN54gy/hGG/fOkBfbFZnz0V+4
 MtggwHRfIIy6E9p0byapFwdXMWTk/xIE6ZQhcB8eZWqL80KjhLl1junTUXBz0CpYgPVnwapU/Kd
 Egr4TD9UA4hcUFFhlJwF6qUvTDtXR5Dh1lHoW5EoA568VsWRHMBI1B5Um6RxmpSehqESFDYXqtD
 7ac70lB1+ysGBq8YLNbZ/22j4D2Wfo2NdkgKKGa760h4CQ53zneoghOj9FTQZbeeu1Tkfw8x4kM
 DufgaFaqOz4BiRilren0YruG4Tlazdl+1hgFnJOqO+z+S25vQjmV+03LxxcxD5pYOLfcHrHaPCL
 DafoxobqrX45thSiDEA==
X-Proofpoint-ORIG-GUID: rig0YKV8KkxiB0he_-bfI6mkNuGCwV-B
X-Proofpoint-GUID: rig0YKV8KkxiB0he_-bfI6mkNuGCwV-B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/5/26 17:41, Zhuoying Cai wrote:
> The IPL information report block (IIRB) contains information used
> to locate IPL records and to report the results of signature verification
> of one or more secure components of the load device.
> 
> IIRB is stored immediately following the IPL Parameter Block. Results on
> component verification in any case (failure or success) are stored.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>

Reviewed-by: Collin Walling <walling@linux.ibm.com>

