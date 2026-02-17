Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA76E68151
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHWb-0007Nf-Qz; Tue, 17 Feb 2026 04:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vsHWW-0007MW-Gl; Tue, 17 Feb 2026 04:37:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vsHWU-00023C-4X; Tue, 17 Feb 2026 04:37:39 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61H6h40M3759249; Tue, 17 Feb 2026 09:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=7eGXtqs/XhyJmfZcUkVqf3SgV4UeNF
 fUaVxeMp34SE8=; b=QvCuhikyenJRdwecAeJ8s/FLvDkbvbJRdiLtYaGUCypGnf
 lL12zfaem/uCFzkKsUHN2QScOIZZ66ibxbfFqbWup9+2k++5NlZepG6ZGE8Fn2YK
 ShYh+OvgwLCwHMrTUn6Xdp+E9Nw5CtRLz+rWWJHR27ma+wZhS3XRuus2NkK+dZDx
 LjM8IEMZrx/GvZt4fwKZ9MTSNO55EevSi86x7Y1r0fb4ty7FVc5jp7E4+1kcoVw7
 AULKMzK0XKSTsMFHg1CHZ6eWrT5UL8Qxe3OfH1GaVGrjYi7yN+7InqnXKVOuirHN
 JaCvUM+akQ2DAitUCvt9Y7RBorp+KprFunAJVGDw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjah5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 09:37:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61H8uS1r015697;
 Tue, 17 Feb 2026 09:37:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb451vsq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 09:37:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61H9bU6X54395278
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Feb 2026 09:37:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0251E2004B;
 Tue, 17 Feb 2026 09:37:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D72D20043;
 Tue, 17 Feb 2026 09:37:28 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.210])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Feb 2026 09:37:28 +0000 (GMT)
Date: Tue, 17 Feb 2026 15:07:26 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 2/9] hw/ppc: Implement S0 SBE interrupt as cpu_pause
 then host reset
Message-ID: <aZQ2qJhGhdKo-cGI@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
 <20251206055648.1908734-3-adityag@linux.ibm.com>
 <9b6db774-cba5-49f7-b0ec-d56232cbeb99@linux.ibm.com>
 <aZQIJHZekWD-sWqI@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZQIJHZekWD-sWqI@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6hBvsOGkOMfB4iezuZuD_Mvx-sxDmF3a
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=699436de cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=c9tvyXZS9ylmDNhe8C4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA3NSBTYWx0ZWRfX65eyTccrSWOo
 X6XvEP8TlD366UiE9wlkvT6QWyCdeTSJahOjjS8GVLT1iseB06J9r5fWgTluQtO5k5OIX0awLov
 Ty7NjXnQ+vWUFx0iVycK8aKaYopQzR05jAA6x8lD5/aYYMXAusqMtrWiW7XNIvhqI6BJZ9cmsps
 tQRgR93k9aL7R8PHmrBkSkrsSgDZGm5TupiKERMzN98nSwZ0KpFmZZ4HmGdOpUjMh/i/neIk2wT
 dz/ePcvoscRC/TAuds6MK5pGYkCk8G7IB0fXYvNMJhHFHxlp8SOo92Vy5yjYA3tzmk+1Jgxan5j
 JpB9WUqDTg8KcNQzLKDPaqfQaUO/6xdvNP2iYA+BaHZH9GEe+Fve76jxT/J5SAYgtDpPIiHPjfa
 PojI/M8BxTJw3oCmN34tvIpCs7QWCnjB9kJDx+i0MQLmrZ4neQv5YOylCr39cnEvPVuOCc84Kr1
 q6hv8kUR2xxeiCsy/hQ==
X-Proofpoint-GUID: 6hBvsOGkOMfB4iezuZuD_Mvx-sxDmF3a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170075
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 26/02/17 11:48AM, Aditya Gupta wrote:
> On 26/01/19 01:11PM, Hari Bathini wrote:
> > 
> > 
> > On 06/12/25 11:26 am, Aditya Gupta wrote:
> > > During MPIPL (aka fadump), OPAL triggers the S0 SBE interrupt to trigger
> > > MPIPL.
> > 
> > As mentioned in cover letter, add more clarity by mentioning that
> > kernel initiates fadump with OPAL call. Skiboot then triggers S0
> > SBE interrupt...
> 
> Will add here also. Thanks Hari !

Does this look okay Hari ?

    During MPIPL (aka fadump), after a kernel crash, the kernel does
    opal_cec_reboot2 opal call, signifying an abnormal termination.
    When OPAL recieves this opal call, it further triggers SBE S0 interrupt,
    to trigger a MPIPL boot.

    Currently S0 interrupt is unimplemented in QEMU.


