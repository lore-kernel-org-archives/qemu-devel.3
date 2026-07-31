Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218C5C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wposV-0004u3-Go; Fri, 31 Jul 2026 11:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1wposU-0004tJ-61; Fri, 31 Jul 2026 11:10:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1wposS-0003n5-IR; Fri, 31 Jul 2026 11:10:25 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VBlcSK1730395; Fri, 31 Jul 2026 15:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lXLxEA
 HCnjW0fmgzDBTUJ7UWP1rLkRZMJAsvxH0PsZ8=; b=Wr4th+0TKrk6IqcVJVeo+x
 K8NcUEx473NsoB2zHRFUhXcOfdWgHJLFFqWg2SdV7ciu0xqGDEBkA/eogoTERVIr
 kFbwCVwCqe8PvbtbF1FRo+c6sQ/IOOiP/SzH2DyvWzk0pVVwYw0p2MLo1b5KH0Gb
 M3odJedjpw81NMvhj9cMo9eosTh5gsuUQfFNW1gbxrvPrBRiI8k4FBIMdSkUDHUj
 I/Wz3mX+Hld4fL6tyei0PCNBy+iOEORdXRbkHTUCxyJeNi435MHir1Mv8wJjmo2c
 MSawtBjFpch0DFjrqzGvuaTqDZmZz8+m5lJXxCWndDLYe5tlZIhymdFPgJxbQ0Sw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7wnyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jul 2026 15:10:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VEfIF6019716;
 Fri, 31 Jul 2026 15:10:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yg4y4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jul 2026 15:10:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66VFAA1X31916378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2026 15:10:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 905842004B;
 Fri, 31 Jul 2026 15:10:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B077E20043;
 Fri, 31 Jul 2026 15:10:09 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.4.62])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 31 Jul 2026 15:10:09 +0000 (GMT)
Date: Fri, 31 Jul 2026 17:10:06 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com,
 frankja@linux.ibm.com, pasic@linux.ibm.com, mhartmay@linux.ibm.com,
 david@kernel.org, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v2 1/1] target/s390x: Allow 2G hugepages guest backing
Message-ID: <20260731171006.26bb1d4b@p-imbrenda>
In-Reply-To: <43521ee6-6fa1-48ae-a72f-94e304bfe3fb@linux.ibm.com>
References: <20260729163043.843517-1-imbrenda@linux.ibm.com>
 <20260729163043.843517-2-imbrenda@linux.ibm.com>
 <d186d6e1-a820-490e-b616-2ac521d3a20e@linux.ibm.com>
 <20260730142001.760e057c@p-imbrenda>
 <43521ee6-6fa1-48ae-a72f-94e304bfe3fb@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MWrWtykTmc5jw1w9hu3JbAhg9ZJlzgnL
X-Proofpoint-ORIG-GUID: MWrWtykTmc5jw1w9hu3JbAhg9ZJlzgnL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExMyBTYWx0ZWRfX4/jB3Pw6lmHt
 jNSGTixTyGl8x1RJxv3TN2cW6V4JkLKGah/6KjaRF1kwsQbVnrWAe/sx7wYXq3nfbqZLCbsv0AS
 rkEUBYE/z6tpcA9tnyOqU61JhLBoiTG0SMIgyvoIniTOJftFaeiewwApkLR3KEDVPgXnrTegfOw
 jvIY1EhD9GjOWb8AhLz9ZaFTgndbBZCvtY+bakRza8lpg4EVBwsG2zFdK2Katg4xf2B4+zrf8nt
 G3sTSNu5rIwHyhYnEXCXifG+qji6UJKCNib6AH6oMXlmzBfiwSUemkEZbxD1KWkzLTPYHvzPimc
 3vc27rn05HAmnBmDu8evhIVWz4clGNItEkyZ/l7jd/GkJDYkWsz0keNHS2nXvJS5pr5Mpq4it+9
 qwNIO6iGwfOoEGw16aSWYW15yFZrMsWd3aKaQbDi1HQz57DTslY/rzORBeZMbnTvD6zC7nQJ1wl
 Fx4np4K3xMxAeEugr5A==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6cbad9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=x421397KOkagA9VlIqoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExMyBTYWx0ZWRfX7HhN0QsrtyKf
 nLZBeWaF3V7OvbEBCBf8ooFw6hA+OggEcU+hxTR5Q20zD64uq6btIc6zLwa7T+IVOmECgd9Saq7
 Wsr3anpmCu0yZQwdVKdYAhtNiFEVZLo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310113
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Thu, 30 Jul 2026 14:59:19 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> >>
> >> Do you have planned future patches that you are confident will soon make
> >> use of these get_hpage_1m() and get_hpage_2g() helpers?  
> > 
> > yes, which is why I put them there :)
> >  
> OK, I won't ask for a respin if you're planning to use them soon.
> 
> Thanks!
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

aaaand I just realized I can simplify things further... I
think I will need to do a respin anyway

