Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F47CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 09:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCEK3-0003ZV-F9; Fri, 24 Oct 2025 05:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vCEJv-0003Y4-OE; Fri, 24 Oct 2025 05:42:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vCEJq-0005hL-PF; Fri, 24 Oct 2025 05:42:48 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NJElai031196;
 Fri, 24 Oct 2025 09:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=dMidzIPKwxZmTGngRu3rvlfdcE/9Mv
 LfLzOfa61lEEw=; b=e/tQc4UbSkhepLqpU0/JY3P23TaytFw3rZU+mCYP3ktbva
 oRk0xVDqa1MesK+vu7vUX0RmOaPrVe8sSXiZotTY0yW0UcOlLsKMM3g9JnaEO9o1
 i79IQIjusXR3wt2jQNB+eeeA97DTDxiQWdyFsHiQmqOuy2WL2oVjOjKje1cimFf4
 0qAEgQO3O8E+8Zo7B93PNZ/ucr3Y87A/6NSYTLLO2Klz4igyuVSatMlSyxoJEJ6j
 LPaG8CmyTng54KLJGItrnhoUC/K3Dq2tgcVhnjpANTEIU7c/44be1dTWc5pA0jDY
 FyAzo3AcU8g7pzdnToYIvGqabqV7fla1il/5sXrQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3276nhj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:42:38 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59O9bvYY023482;
 Fri, 24 Oct 2025 09:42:37 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3276nhg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:42:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O8Ie0Y014650;
 Fri, 24 Oct 2025 09:42:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sjp1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:42:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59O9gX6N9044478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 09:42:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02A8920043;
 Fri, 24 Oct 2025 09:42:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B64820040;
 Fri, 24 Oct 2025 09:42:30 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.221.189])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 24 Oct 2025 09:42:29 +0000 (GMT)
Date: Fri, 24 Oct 2025 15:12:28 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 peter.maydell@linaro.org, alistair23@gmail.com, balaton@eik.bme.hu,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com
Subject: Re: [Patch v9 3/6] core/loader: improve error handling in image
 loading functions
Message-ID: <7y52t3e2gviykegmuw6ix6zktibzeracud77x5uocyyly4oxvk@m3hof2t7cunh>
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-6-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024092616.1893092-6-vishalc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fb4a0e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Fw0X0W9bkjom2bvzy80A:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX2H7u1A2p7J7G
 tMsdjyLI9XDjaILnoIM3liXw6HJotWZ4zIjKdLdAycogowl6nVALQ3OyAkn1OhAw2U/A4gvPWt4
 tC65L3xc99+iEHKI1TtNtFTdyvkEHKEIBAAaLkRkptBxRf2bRQwpGlNuG5xZ8yQJ/N6cFxj5nRm
 6GXKcP3NPRL6xM0hlQWedC5CmIUN/0aS7SC1A/jSM2yXRtYefLYaLfp1FIwgLUB+2VGifN3Zbko
 xCMPeLXjR3bMma0ytLtqUgmsCIDGJ8FFN89PMK3HM7UAUAO7qXuR+R5SNfUimprmvvO85A8vOmJ
 guQF79q6fBWhEHKqbf/xjwobAXt6Dt92alDPEfQ+AAGertMC2d3kD30J7r6itSzLAk21Pi0eti5
 IlKe219cTHMcx+tBHmZ39B1zuKIgvg==
X-Proofpoint-GUID: FrWx2lrTfIrMIP0COXM12c3fU1hAFvQQ
X-Proofpoint-ORIG-GUID: 6UE_sqwP5IUaw0EXPq5mosVkWdQdJ4iM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

On 25/10/24 02:56PM, Vishal Chourasia wrote:
> Add error checking for lseek() failure and provide better error
> messages when image loading fails, including filenames and addresses.
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G


