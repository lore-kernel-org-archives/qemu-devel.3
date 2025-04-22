Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0942DC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 04:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u75Yy-00028T-Nx; Tue, 22 Apr 2025 00:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1u75Yx-000287-Kz; Tue, 22 Apr 2025 00:48:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1u75Yv-0003gD-Rz; Tue, 22 Apr 2025 00:48:51 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M4bJVc028145;
 Tue, 22 Apr 2025 04:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=PG9IMgmhu+JP9PBqdMuMxX1P9zkoFA
 DHZAygrIS2l8c=; b=dqMGTDwqQOOafuE21VqqF41q5hlvyXZOLAVke/qaoT5v5x
 zceMdiNdL8WkYx0U9yd3lrisUJjvQ3dkDXAHtTy0lSGrSCEHltNP55M2LPIGsofO
 HE/pHbtt+lr13xdJUioIKAiljuQ5f7t2K/Nmb1GczjaVrOOE/6S7zp7/zGzwXhPr
 /tKT88VPkXk5n7fiREqjBU1k0JI3LAHriWkHm/CSIA/9O3gOTD3tnOU79tcEU7LA
 TfiMfZQFCtkBLsj/3JcYzFsuiTdhV8rXq65O9ovOp+TSk9IQFAY6YR/ODzuZYQ2d
 NXqJZExLYiZTRKmlKwklr9E+lt63EhJhlW9XpSww==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4664878140-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 04:48:47 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53M4mi6E019489;
 Tue, 22 Apr 2025 04:48:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466487813t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 04:48:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M218cu002904;
 Tue, 22 Apr 2025 04:48:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 464q5nha85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 04:48:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53M4mfiJ15270198
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 04:48:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAFD22004D;
 Tue, 22 Apr 2025 04:48:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89C8620043;
 Tue, 22 Apr 2025 04:48:38 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.215.117])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 22 Apr 2025 04:48:38 +0000 (GMT)
Date: Tue, 22 Apr 2025 10:18:35 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v4 1/8] hw/ppc: Implement skeleton code for fadump in
 PSeries
Message-ID: <heczlspvfxlt3z7jbzm3dfgli45s5ceqh3y2glmrgqj6f6wkqb@kziihqae6od7>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-2-adityag@linux.ibm.com>
 <040afb75-6434-4f66-a241-b522ed7724dd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <040afb75-6434-4f66-a241-b522ed7724dd@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uuUDkW9mdnfdK5QDRHdr-nd4EtSh4dna
X-Authority-Analysis: v=2.4 cv=LMFmQIW9 c=1 sm=1 tr=0 ts=68071faf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=aM-W4C0H6x_Zq6nrnuEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: PMwr-50Z0u3vDbq0eDfQQ44ud4g4ASNC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_02,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504220033
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Hi Harsh,

Thanks for reviewing.

On 25/04/21 04:21PM, Harsh Prateek Bora wrote:
> 
> 
> On 3/23/25 23:10, Aditya Gupta wrote:
> > <...snip...>
> >
> > +    switch (cmd) {
> > +    case FADUMP_CMD_REGISTER:
> > +        ret_val = do_fadump_register();
> > +        if (ret_val != RTAS_OUT_SUCCESS) {
> > +            rtas_st(rets, 0, ret_val);
> > +            return;
> > +        }
> > +        break;
> 
> I would suggest to keep the first patch as implementing the logic for
> FADUMP_CMD_REGISTER (and _UNREGISTER) handling.

Tried that, but that is either introducing an unused function or would
mean squashing this patch and the subsequent patch implementing register
command.

I am preferring to keep current patch split.

What do you think ?

> 
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
> >
> > <...snip...>
> >
> > +/* ibm,configure-kernel-dump header. */
> > +struct FadumpSectionHeader {
> > +    __be32    dump_format_version;
> > +    __be16    dump_num_sections;
> > +    __be16    dump_status_flag;
> > +    __be32    offset_first_dump_section;
> > +
> > +    /* Fields for disk dump option. */
> > +    __be32    dd_block_size;
> > +    __be64    dd_block_offset;
> > +    __be64    dd_num_blocks;
> > +    __be32    dd_offset_disk_path;
> > +
> > +    /* Maximum time allowed to prevent an automatic dump-reboot. */
> > +    __be32    max_time_auto;
> > +};
> 
> Also, you may introduce struct members in the patches as they are
> used/accessed. No need to have entire struct introduced in the first patch
> unless the members are being used/accessed.

Did that. The FadumpMemStruct gets used in SpaprMachineState and by
unregister command.

Agree with you about introducing fields as they are used, but kept the
complete structure with all fields to be compliant with PAPR, as having
the complete structure ensures the fields are at correct offsets as per
PAPR.

Thanks,
- Aditya G

> 
> regards,
> Harsh
> 
> > +
> > +/* Note: All the data in these structures is in big-endian */
> > +struct FadumpMemStruct {
> > +    FadumpSectionHeader header;
> > +    FadumpSection       rgn[FADUMP_MAX_SECTIONS];
> > +};
> > +
> > +uint32_t do_fadump_register(void);
> > +#endif /* PPC_SPAPR_FADUMP_H */

