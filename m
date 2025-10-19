Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803CECCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 11:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vARcp-0003KE-Aq; Sun, 19 Oct 2025 07:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vARck-0003Jx-9A; Sun, 19 Oct 2025 07:30:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vARci-0006vY-08; Sun, 19 Oct 2025 07:30:54 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JAgFF5016406;
 Sun, 19 Oct 2025 11:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=517nP2+/TCMkjuIIsMQ5wGWxY6iFTm
 kqKDynO3jQNBQ=; b=AYTn/djHaksTN6GGGhwkvJauHMEErShzoS+9qsqSIW6H8M
 dW6RsVJX34Zfblc8Sp+7N2k6MQBjEBP2WLnTf1/EQarrPDNSsrGp50Wk4Xz4Zb6M
 8cANzwsiJT+7cjTp2L6tUoGKx/kyWgsLSWehlYP4UE7+VSV38WYPZ51wkEH0u/mF
 B1KzuWon+yU3Jg/SxJRZ92dwg3iFxKLvAdGSXelnAMd949NOCS1LhdMFORxYy9wb
 +ijgEImeqcdMXGLzKv5D8utZQkj9nDZAh/Xo4jK9uOlIJ9z5bQr8lj9wdNxPpput
 1fTdVCvfruB0Szm/ZYijdRwSJaJ/bpBBw3tFH1xQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32h48t4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 19 Oct 2025 11:30:47 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59JBUk3m005544;
 Sun, 19 Oct 2025 11:30:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32h48t1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 19 Oct 2025 11:30:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59J81Dj3024686;
 Sun, 19 Oct 2025 11:30:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqjhc3j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 19 Oct 2025 11:30:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59JBUgLq28377596
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 19 Oct 2025 11:30:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F7352004B;
 Sun, 19 Oct 2025 11:30:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE58320040;
 Sun, 19 Oct 2025 11:30:39 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.26.42]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sun, 19 Oct 2025 11:30:39 +0000 (GMT)
Date: Sun, 19 Oct 2025 17:00:37 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v4 1/8] hw/ppc: Implement skeleton code for fadump in
 PSeries
Message-ID: <u6e2n2ocb2kskrhwwgzdxmq57yodzcou3eqw34ebxwsgopkkaj@kvbeuydlfn64>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-2-adityag@linux.ibm.com>
 <b0d6ce61-7e8e-4bf5-99b7-59e434ae0c48@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0d6ce61-7e8e-4bf5-99b7-59e434ae0c48@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX8NjQcURAPqNa
 V5VdDZ/f59dai8/SzD2GWWtTfM1kgwChMwM6S99kzEfNd0P+wwqGl5G7kLTDTLYeCB+ZdIaFJcq
 iRsRCV7q6G3fsuXq87LuBdCgFneTQdmGajTlRkbQJFZyzF8iawpYLzdPAHtmIcUxBZ8zCHZStFS
 V3cym+Hew8scJMkBS6nfZeUd4wdp74R3IEkCvKK1Tb/GXSTqZTJyg0sx6+HXB8jPklIEIFhHUN6
 zOFmhuPVHiDzHaxNAq+z7DkRiKeWv/NuGYXjvGM6z9GXW5PKoQrFAiXl58cou46SBktWucIRWOe
 H2+XUOOdmNfhnQ6AuNvOn6QfIYLCM4JDsVWalTNRPQau1NnTkaNlxBPZ0SjWwXTw+iG1PNTTlmz
 ABJ4O+D94g9TAF3CC8xfmxD1GsYE7A==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68f4cbe7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P5uEQtg_e8BJcDpjrlcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: u5WI9AanqWqF6HBOuT-q7tWc2uHGkU08
X-Proofpoint-ORIG-GUID: eQL4FxIvQaVB37Pr-RTF5i5sYRacLORH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 25/10/18 05:20PM, Sourabh Jain wrote:
> 
> > <...snip...>
> > +    switch (cmd) {
> > +    case FADUMP_CMD_REGISTER:
> > +        ret_val = do_fadump_register();
> > +        if (ret_val != RTAS_OUT_SUCCESS) {
> > +            rtas_st(rets, 0, ret_val);
> > +            return;
> > +        }
> > +        break;
> > +    case FADUMP_CMD_UNREGISTER:
> > +        if (spapr->fadump_dump_active == 1) {
> > +            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);
> > +            return;
> > +        }
> > +
> > +        spapr->fadump_registered = false;
> > +        spapr->fadump_dump_active = false;
> > +        memset(&spapr->registered_fdm, 0, sizeof(spapr->registered_fdm));
> > +        break;
> > +    case FADUMP_CMD_INVALIDATE:
> > +        if (spapr->fadump_dump_active) {
> > +            spapr->fadump_registered = false;
> > +            spapr->fadump_dump_active = false;
> > +            memset(&spapr->registered_fdm, 0, sizeof(spapr->registered_fdm));
> 
> I hope the above actions are good enough to make qemu ready for fadump
> registration.

I believe so. The various flags are set in do_fadump_register for
register command, maybe that's why that switch case might not look
enough, but I think the current one makes sense.

> 
> > +        } else {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                "FADump: Nothing to invalidate, no dump active\n");
> > +        }
> 
> No error code if the kernel issues an invalidate and fadump_dump_active is
> false?
> 
> As per the current kernel code, this situation should not occur, but to be
> on the safe side,
> QEMU should not return RTAS_OUT_SUCCESS.

Makes sense. PAPR doesn't say anything about this, but I guess we can
return PARAM_ERROR (for lack of any better error) in this case.
Will do.

Thanks,
- Aditya G


