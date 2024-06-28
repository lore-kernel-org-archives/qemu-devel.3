Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2B5C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 18:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFun-0003zE-DN; Fri, 28 Jun 2024 14:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sNFuX-0003x2-Sj; Fri, 28 Jun 2024 14:01:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sNFuV-0001Vc-QW; Fri, 28 Jun 2024 14:01:25 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SHuvNe005730;
 Fri, 28 Jun 2024 18:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=7
 pWhTPkFR9dJnrmfCHgtJIYyrCUwVWBI+oSWQVviDJg=; b=azNSqaWYKxlCNLMmF
 iYiU21bZNKAgu97v9Nj0zoC07pK/31XdcyrN/x3D8rLGftJ5vllO0YKsyqUNxlSw
 b8nh9Lk6Ybh1GNlH0MDhHzjJfnRvTHbD/ckMjgV/37QnzmkBM1Yp3t0f2TJdzHf3
 NmLN+iLjMdk1T7lGbFiwGDqxcPgNgb2b4mnRTLM25n9F/ZpkY7dWwbbZ+miMsBjo
 tO2bjdjKdVmQ+uqY+Hdl3tk+CeBylWPVrXTXb6oc0NtduNknT4y7pdU27WYNmHax
 HGnFSHWNhgQKOoYI/sk0oEyPQv0rOF8DtO8+d3lD+alT0ujvvSokAF+R7RA9rK2d
 2gocQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401wn7ruf0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Jun 2024 18:01:20 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45SI1JjR014475;
 Fri, 28 Jun 2024 18:01:19 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401wn7ruex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Jun 2024 18:01:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45SFdhwe000428; Fri, 28 Jun 2024 18:01:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn3s8rq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Jun 2024 18:01:18 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45SI1FpJ27525654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Jun 2024 18:01:18 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C16A05803F;
 Fri, 28 Jun 2024 18:01:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 232805804E;
 Fri, 28 Jun 2024 18:01:14 +0000 (GMT)
Received: from [9.67.146.29] (unknown [9.67.146.29])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 28 Jun 2024 18:01:13 +0000 (GMT)
Message-ID: <d10e77d9-5905-4102-81b6-9cce6bdaae5c@linux.ibm.com>
Date: Fri, 28 Jun 2024 14:01:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] pc-bios/s390-ccw: Merge the netboot loader into
 s390-ccw.img
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Collin L . Walling" <walling@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240621082422.136217-1-thuth@redhat.com>
 <a3531d21082e3abf3132a4c95d6c54e8973dd27e.camel@linux.ibm.com>
 <77f2550a-fbb7-4bcf-a6b7-b9b31934daf1@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <77f2550a-fbb7-4bcf-a6b7-b9b31934daf1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N-PE0PgTCVdsX6QOk8fRbfMW9fv-93Wx
X-Proofpoint-ORIG-GUID: u0zNGLdbHOwvxCUzmF-cWgREAlECe4N1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_13,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 clxscore=1011
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280133
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/24/24 1:55 AM, Thomas Huth wrote:
> [...]
>
> I think it should be fine, both functions are basically just a wrapper 
> around the write() function in sclp.c, with sclp_print() being rather 
> dumb while printf() is doing the usual string formatting before 
> writing it out. I think in the long run, it would be nice to get rid 
> of sclp_print() and replace it by puts() or printf() in the whole 
> code, but doing that right now would likely cause quite some conflicts 
> for Jared with his patch series, so I'd rather postpone that to a 
> later point in time.

Hi Thomas,

Converting the panics to returns will require me to modify/move some of 
the sclp_print() calls.  Shall I go ahead and change them to printf() 
and puts() while I'm at it, or would you rather preserve the 
sclp_print() for now and then have a dedicated patch for the all 
replacements later?  I'm not sure if we want to try to maintain some 
amount of consistency until we do a total conversion, or if you are OK 
with a mix of sclp_print() and printf() throughout in the meantime.

Regards,

Jared Rossi

