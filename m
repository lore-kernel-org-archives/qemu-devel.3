Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E51C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 08:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhye-00053c-A9; Thu, 26 Jun 2025 04:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uUhyU-0004x2-Ow; Thu, 26 Jun 2025 04:28:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uUhyO-0002FG-UU; Thu, 26 Jun 2025 04:28:50 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4AZma015779;
 Thu, 26 Jun 2025 08:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CMm4w+
 CatWrXkAEKyyBGFaaMid+JMX0Gc3jPMEwPV2w=; b=tIGRvyGrV6dLibmxwR3kKO
 dw0B/BVdMDcsT+5RqaP26pM+jnbTY6r94D9gxcHbz/GUheWZuXIQXBI6oyk89/1T
 cEYqdXJy1hYMUfgANvrm7p7rHLbRfYOlfP6Dd2MG81Et2kjguVvyIOYCYUvlW/M/
 k8HKOITZGsCJLthwsKFWr+PY8UzWZf4ye/AiT3+dh3sn4wpH1RFIFwAcrPlGLqjI
 kcORw2VTdWD8bbRBJYk7W4I0c485G5ltWngyHhU6D8RzF4xQ0exphz1NVRMMs8kl
 w+o+JnJinKCKUwk830Agi2oAQpgrekFwgIaAk+R6hy9nTEb9w7vG93rLpdggUkJA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jn5uw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Jun 2025 08:28:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q5xLiR014769;
 Thu, 26 Jun 2025 08:28:37 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s2nksc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Jun 2025 08:28:37 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55Q8SaEi33358460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Jun 2025 08:28:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6143358059;
 Thu, 26 Jun 2025 08:28:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B24A58058;
 Thu, 26 Jun 2025 08:28:36 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Jun 2025 08:28:35 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 26 Jun 2025 10:28:35 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Daniel Berrange
 <berrange@redhat.com>, qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Subject: Re: [PATCH v6 0/3] Add SCLP event type CPI
In-Reply-To: <146a0cb2-e75d-4f2b-a1ef-c681185a6c16@redhat.com>
References: <20250616140107.990538-1-shalini@linux.ibm.com>
 <146a0cb2-e75d-4f2b-a1ef-c681185a6c16@redhat.com>
Message-ID: <8b65246e403c7adc9b560b580e986b65@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA2OCBTYWx0ZWRfX3udxexiOGjqY
 mqG4LqYiw87WzHTb/boa2cjEADKrfPwCwVEYPwdQnXS3HvDr+69El2SkWU0PVWyqqiIqNwKRJ09
 YcnCuEDAtp2/6a0vMZZlUIbZN51qe/hfBEI5KpFRqN0nnDp7GIpwYnb6TzAbIAUsv0N8njLk+gQ
 xnJ+xkRoenlntLe6CnMcSM8nA+mrzdMRo/9BN79vn9GN95S6+Ld8xol/aOMlFk5UAHQIf8Od4dH
 nwZX6qbqUdfN30Q2ONpWvz2hanYmd6HiJ6pMhN8FOKMp6OQlZ9LzYHxIc2eE7AGUaXoG+u7cDOR
 UavXSeXj2Onhpde+TscswujIw4q5kgIw5etlsmVX4Gy8Vv0ctTwCZYwK3B78R5F/tU9uzo3Hj5T
 GI3ZUz+HaO0Ydk4cqS7HZlaHbfRHSDXTneEvph7Siwbp4ZKSHl+m3VBwtwaBso1Ui0DKGLSP
X-Proofpoint-GUID: bB1SnAgGqDWunPxe2PmWsVYUg1_rXV1k
X-Proofpoint-ORIG-GUID: bB1SnAgGqDWunPxe2PmWsVYUg1_rXV1k
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685d04b6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=FbzPmqBgP5TGeBcYFOsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_04,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=883 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260068
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2025-06-24 12:25, Thomas Huth wrote:
> On 16/06/2025 16.01, Shalini Chellathurai Saroja wrote:
>> Implement the Service-Call Logical Processor (SCLP) event
>> type Control-Program Identification (CPI) in QEMU.
>> 
>> Changed since v5:
>> - Add identifiers as class properties instead of object properties
>> - Add description for all the class properties
>> - Remove S390ControlProgramId as it is not needed anymore
>> - Update description of system_level identifier
>> - Add Reviewed-by tags
> 
>  Hi Shalini!
> 
> Thanks, I've picked this up for my next pull request.
> 
> If you've got some spare time, could you maybe also look into writing
> a regression test for this, e.g. by extending one of the tests in
> tests/functional/test_s390x_ccw_virtio.py to see whether the guests
> provide the expected information via CPI there? (I hope the guests in
> that test are recent enough for this feature, otherwise we might want
> to update them)
> 

Hello Thomas,

Thank you very much. Yes, I will do so.

>  Thanks,
>   Thomas

-- 
Mit freundlichen Grüßen / Kind regards
Shalini Chellathurai Saroja
Software Developer
Linux on IBM Z & KVM Development
IBM Deutschland Research & Development GmbH
Dept 1419, Schoenaicher Str. 220, 71032 Boeblingen
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht 
Stuttgart, HRB 243294

