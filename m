Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D715EC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnIUK-0008HI-Ss; Fri, 24 Jul 2026 12:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1wnIUI-0008Ge-S3; Fri, 24 Jul 2026 12:11:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1wnIUH-0008Ph-03; Fri, 24 Jul 2026 12:11:02 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ODfdtb1992733; Fri, 24 Jul 2026 16:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YXujBu
 ApX5Cv8RXvJONYW+viPftekUMlczig0pdN/gg=; b=X5z1VOBXbbkRvmGipoIDqh
 ye0vJe09wZo6gshK+vRxyhTkYssy53fFY1W7ZCE/Ugs2+NS3TpecuUeyCeJsn9oz
 DJk8DZpMazLiovNNyxD1p966gaP4NKadKu9OatPxQrgDtquGygc8Iq8VCQnwQw58
 6egl2zvFxY6XfVSlP0/dU6Hp100Y73DfXEOETf9Mg2hrcdjNKodP9COt2oHWzLMJ
 Y6SLv1TcHyEItvO6AckQadFG0iCJb3AcreF6Hdr8fKGyBGIMcQnH8kvyPC+mRrnw
 VBXMCyeyE1RJ4ZqAWOnzdDOA5uTPpKS6nQ6QXKvtJ4Y82S9S/BW/l5ZysK4jaBQg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h00tg6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 16:10:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OG4h6k026045;
 Fri, 24 Jul 2026 16:10:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6whqq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 16:10:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66OGAmVT47579486
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 16:10:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84C8B201F7;
 Fri, 24 Jul 2026 16:10:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EA54201F6;
 Fri, 24 Jul 2026 16:10:48 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 24 Jul 2026 16:10:48 +0000 (GMT)
Date: Fri, 24 Jul 2026 18:10:46 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com,
 frankja@linux.ibm.com, pasic@linux.ibm.com, mhartmay@linux.ibm.com,
 david@kernel.org, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v1 1/1] target/s390x: Allow 2G hugepages guest backing
Message-ID: <20260724181046.3f8466a3@p-imbrenda>
In-Reply-To: <e0ff56b0-42dd-4075-8f36-edf877cf777b@linux.ibm.com>
References: <20260713155212.287444-1-imbrenda@linux.ibm.com>
 <e0ff56b0-42dd-4075-8f36-edf877cf777b@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LdcMLDfi c=1 sm=1 tr=0 ts=6a638e90 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=mnLLtHRCtmUpyWjtGDAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: rCb332niPWqGPXpZ-_gLtwia5Yg6m2u0
X-Proofpoint-GUID: rCb332niPWqGPXpZ-_gLtwia5Yg6m2u0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0MSBTYWx0ZWRfX1JgmSlDoht38
 6P+/d5fVFAeq4uZXNWFCJom7e+Lu9w05b81An7u6jX2XWy7AjojocHHqAuPzun7LhxS3U3BRpzc
 ZgQOc+O2wX4hV5BBpdMjnk1mQdHx/kcU739d9MVMK5u7oOpg5zxpOw5DbSTbO9Zvo9hJh7kNNwd
 rpI6JOYcrKXfp6jwJnJ2WVY0dTMSvXPyvzkQh03yL6sO1dVcBt1JBNdnrv9lABwPeuRfNRByy4y
 +r6a8AfajwLl2Ep3u2LyknJAOLgy9Qrx3dzkJwvLtB8jxxVQY3ysgT+GJCNTSXzPa2oXRS/Z/VA
 FCUkGbJzCJb5Nug1jxZgZNfGng0cZm2RvpD75V3SuOTo3Ufcb5pmC9yJEwEC8oGUSqZXzoevwZH
 p+XNMJJBOxv6gUV3igKu548TMGIQsWSXmOOvd3Og4//H0LMVuPt5bOa+xNgYtW9/eaPfe9YQ0IS
 m9ytTFZRzGcqFmq1WEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0MSBTYWx0ZWRfXxE00PULv4nUe
 eaVcvzcTnuhAUITkQB+BMt+1o8qdEDFPbokj3TLD8xXGGZgUsVU54s3J/AwUJUSNpJer6Bc+o6G
 ZgJeXFtgYAZXi2VBE0RybDV+Fyeeags=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240141
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

On Fri, 24 Jul 2026 09:10:49 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 7/13/26 11:52 AM, Claudio Imbrenda wrote:
> > Allow mapping guest with 2G hugepages on hosts that support it.
> > 
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---
> >  target/s390x/kvm/kvm.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> > index 72031a5714..23fa714b69 100644
> > --- a/target/s390x/kvm/kvm.c
> > +++ b/target/s390x/kvm/kvm.c
> > @@ -298,13 +298,13 @@ void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp)
> >          return;
> >      }
> >  
> > -    if (pagesize != 1 * MiB) {
> > +    if ((pagesize == 2 * GiB) &&
> > +        kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_HPAGE_2G, 0)) {
> >          error_setg(errp, "Memory backing with 2G pages was specified, "
> >                     "but KVM does not support this memory backing");
> >          return;
> > -    }
> > -
> > -    if (kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_HPAGE_1M, 0)) {
> > +    } else if ((pagesize == MiB) &&
> > +               kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_HPAGE_1M, 0)) {
> >          error_setg(errp, "Memory backing with 1M pages was specified, "
> >                     "but KVM does not support this memory backing");
> >          return;  
> 
> Just double-checking -- If you successfully take the 2G path here you
> will still set cap_hpage_1m = 1;
> 
> I suspect it's intentional to fence diag 308?  But then IMO

I was more thinking of cmma and similar, but yes it's intentional

> 
> s/kvm_s390_get_hpage_1m/kvm_s390_get_hpage/
> and
> s/ cap_hpage_1m/ cap_hpage_any/
> or something like that

Yeah, makes sense. I wanted to keep my changes minimal, hence why I
left the old names.




