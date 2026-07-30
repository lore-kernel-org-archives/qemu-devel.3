Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52099C55160
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpPkJ-0000yS-Mn; Thu, 30 Jul 2026 08:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1wpPkI-0000x4-1I; Thu, 30 Jul 2026 08:20:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1wpPkG-0000Qi-8Z; Thu, 30 Jul 2026 08:20:17 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UAHWTJ2741743; Thu, 30 Jul 2026 12:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ijpt3/
 ArpcawwY5b3FQXsk1MA1HSNQYl5W5OKOxWoVA=; b=btSLLeh3h22c2kbiAJwLoS
 sTOw2kU6lvsWlg7ruPUpsVOu7tOBW5AM0e5MsAzp3HOU1gnnss0WlI4qxNeIEdRk
 xxilLsvoLuhy5pnrnXeu8QVSN2Ku7vEoUOU5+wgC2hzzYiZosNXg5j2ngYkYEjJy
 a+eWyoHbkyeFetzPPkvbLbSTf5LvpiHmujzzL3qdJzfql4fy+qA9EfqkCurpqX3f
 JdEQrqak98aeU+Zu7A5mrTe6xKub3uTwqJSPXvUlUzmaB+QvfN+UH2/gEsPu8bPk
 OFZhvhC6RlqJa0tQW6CNRMbs2TYY+FWIe8XyazWBlQXU/kvf5KgrgCw+B2lc5C8w
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xynmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 12:20:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UCBNGq029795;
 Thu, 30 Jul 2026 12:20:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwbcmp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 12:20:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66UCK3rC50987304
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 12:20:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F80F2004E;
 Thu, 30 Jul 2026 12:20:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 614F620040;
 Thu, 30 Jul 2026 12:20:03 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
 Thu, 30 Jul 2026 12:20:03 +0000 (GMT)
Date: Thu, 30 Jul 2026 14:20:01 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com,
 frankja@linux.ibm.com, pasic@linux.ibm.com, mhartmay@linux.ibm.com,
 david@kernel.org, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v2 1/1] target/s390x: Allow 2G hugepages guest backing
Message-ID: <20260730142001.760e057c@p-imbrenda>
In-Reply-To: <d186d6e1-a820-490e-b616-2ac521d3a20e@linux.ibm.com>
References: <20260729163043.843517-1-imbrenda@linux.ibm.com>
 <20260729163043.843517-2-imbrenda@linux.ibm.com>
 <d186d6e1-a820-490e-b616-2ac521d3a20e@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e-o6k8t0uKCDWDL3uAxnNm00tcSuXLbq
X-Proofpoint-ORIG-GUID: e-o6k8t0uKCDWDL3uAxnNm00tcSuXLbq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5MyBTYWx0ZWRfX5MN+72SPC8O6
 igotXblKSgXtEiuQx10uFW/mG/7xy1sn5JWLGyjDKugAej3eJiPpJDlG24SKD9aebdoJGyfjQRh
 iaciM+0C+/UMbCuKLOuPfwfKsytOGrA=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6b417b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=HTWikn-NoDX072xUEvEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5MyBTYWx0ZWRfX/zkmslJvDMtM
 qhrOCQJ3lOpvf5ly1Ll8EmBmNLJRAu6Qf/LNTRYY/cNiHGQnQy8POZlz6JBH8Jb8DarvC/nCFe/
 yj7I0C3WCoxYgIdFBgDDlrRUIWKfTMUlHL3KEM2xSmdORBodvu8S3Frtz1XYWEkhtd3pwqNZkk3
 TwvniV/kp8g/9Fqek/ie0NUG2QEVrgIaQ24DA9OtC5GZqCHwkh0iClZ7+76Ot6jm4jpJcLKi4NZ
 tnoRA68np0SAGByyhHO+r5FEZQbnRGfCmdFEjxVMtDmwJRK7eREawa/rgfbbIVI1QRiRqNeBOOj
 TWoJsir84BfploJis1HlVWUEnnL4/GhxD9LplmG1PmOY4pZ0ahcQkw2+hbga+gzdyUMveDtLF+U
 W4LxT7kP8f7TP7yzZ/Vgj53mjk6Y+aS5vHkuiwneBqB651pTrcvu31NR/wfgou3IbImMRN5+wsA
 s8vTgyGbH0q+CSLbwvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300093
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

On Wed, 29 Jul 2026 13:53:01 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> > -        if (kvm_enabled() && kvm_s390_get_hpage_1m()) {
> > +        if (kvm_enabled() && kvm_s390_get_hpage()) {  
> 
> ...
> 
> >  
> > -    cap_hpage_1m = 1;
> > +int kvm_s390_get_hpage(void)
> > +{
> > +    return cap_hpage;
> >  }
> >  
> >  int kvm_s390_get_hpage_1m(void)
> >  {
> > -    return cap_hpage_1m;
> > +    return cap_hpage == 1;
> > +}
> > +
> > +int kvm_s390_get_hpage_2g(void)
> > +{
> > +    return cap_hpage == 2;
> >  }  
> 
> Hey Claudio,
> 
> Thanks for changing things to differentiate between 1m and 2g for the cap.
> 
> Overall LGTM but this patch now makes kvm_s390_get_hpage_1m() dead code
> (not referenced anywhere) as well as introduces a new function
> kvm_s390_get_hpage_2g() that is also unused.
> 
> Since this patch is by itself, why not just remove the functions
> until/if they are needed and only provide kvm_s390_get_hpage()?
> 
> Do you have planned future patches that you are confident will soon make
> use of these get_hpage_1m() and get_hpage_2g() helpers?

yes, which is why I put them there :)

but I understand that dead code is annoying, if you want I can simply
respin without the unused functions, and introduce them later when they
are actually needed.

> 
> Thanks,
> Matt
> 
> 
> 


