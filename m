Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16578CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8IkD-000657-R6; Mon, 13 Oct 2025 09:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v8Ik9-00064k-Mv; Mon, 13 Oct 2025 09:37:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v8Ik7-0006V8-Ih; Mon, 13 Oct 2025 09:37:41 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DBdDXi004084;
 Mon, 13 Oct 2025 13:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=d+Utfx
 IdbaojW9XEX8wGTeXy37LttiuIHLiqUSugnvg=; b=l881Mf7P+bggNBwM+vcVzT
 rIXYmqk1tWHA2WjYe/JeHHwaxquftqtFxFlkUt2mb+3t5hFY8LLjpj25q0FTlq4f
 O54ILnyJmh8nvpm4ViD+lq6Xicu+nL+wbgLCtjnMlw6nLl/+R+ZU+6b76L3hvXF1
 fFV9ez4HLHsCVUGspnj1BURNAxdftk7jrdJEQoV+xp7sgo+NUjgnmkbkuOycwySh
 Sa99d7R6qh0hUKIvkGzCFY3QmDB/NkxUx9rfaD4+BTGnhoi2YBxczHVG4K8XYSI8
 Bp3fHbR6AlRMGojgYQnBIeaXzHeOtq/Rm4qwG+qRVXBsVXXVuhPj7LknPtn89eFg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8h5d0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 13:37:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59DBtF4R003745;
 Mon, 13 Oct 2025 13:37:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r490wq8f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 13:37:35 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59DDbX8I11534848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Oct 2025 13:37:34 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF2375804B;
 Mon, 13 Oct 2025 13:37:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38A3B58055;
 Mon, 13 Oct 2025 13:37:33 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Oct 2025 13:37:33 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 13 Oct 2025 15:37:32 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Daniel Berrange
 <berrange@redhat.com>, qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Subject: Re: [PATCH RFC] tests/functional: add tests for SCLP event CPI
In-Reply-To: <7b1222ef-df18-4770-b218-b71cacb441e9@redhat.com>
References: <20250812123124.382696-1-shalini@linux.ibm.com>
 <7b1222ef-df18-4770-b218-b71cacb441e9@redhat.com>
Message-ID: <f2e6f791b2b8abf026d51acf8b6718bb@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Vx-0i3JJ3NklQDKqF_OpiHXulM54MEC0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfXwV7ccXdRBXDN
 xweJGxApmXsm01VTYp08epXecEpr93h3N0U3/N6lyZXes70MNQdGC/qc55iXe32SPDjaU4L356M
 QbVi6zqYDf1tss7MxlCZUcSRK0FZCSE37eZ51JpOZLz12UlRpcnIJb8R5+9eISW4Sb8Kles5nma
 ojscE3bBG3XpAfufH+TX5JuGcMoBDjh3px3YvNuR9FKyaMFzyy2wSt2jnkunHPSiAVXpRlfBpY1
 VnPGR8G0hWRCpTs2oMIj1EVLTIzvKQXuHf6l1Zg2+X/dAfn8XhVbh4DZncU1HHnbLL82x80jqvP
 R400sZMbiIvt9lv0LnEwvJKscfpV/TW2dic5f3AT043xoaNwYwsgzxFxMPXDIcGLG8TV1mNE2vU
 n0YbjPESSPRCuoqO4/8v+Ze8MHKKdw==
X-Proofpoint-GUID: Vx-0i3JJ3NklQDKqF_OpiHXulM54MEC0
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68ed00a0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=Y5VVuhZViNCqZGoXaTAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 2025-08-25 13:30, Thomas Huth wrote:
> On 12/08/2025 14.31, Shalini Chellathurai Saroja wrote:
>> Add tests for SCLP event type Control-Program Identification
>> (CPI) to s390x CCW virtio tests.
>> 
>> Please note that these tests are skipped as the guest OS does not
>> trigger the SCLP event type CPI when the command
>> 'echo 1 > /sys/firmware/cpi/set' is executed in the guest. I
>> believe that the guest OS must to be updated to support the SCLP
>> event type CPI.
>> 
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> Suggested-by: Thomas Huth <thuth@redhat.com>
>> ---
> ...
>> +        try:
>> +            event = self.vm.event_wait('SCLP_EVENT_CTRL_PGM_ID')
> 
> As far as I can tell, SCLP_EVENT_CTRL_PGM_ID is an *SCLP* event only,
> but you're trying to wait for a *QAPI* event here instead. That's two
> completely different things, SCLP events are something between the
> guest and QEMU, while QAPI events are between QEMU and the monitoring
> program (i.e. in this case the test).
> 
> If you want that QEMU generates such QAPI events for the monitoring
> program, you have to do something similar to commit 1cfe52b78240679
> and add the qapi_event_send_... function to the right spot in your
> code.
> 

Hello Thomas,

I have added the QAPI event and have sent the v2 of this patch.
Thank you very much.


>  HTH,
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

