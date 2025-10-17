Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8DECCD19A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 11:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9j3c-0004v2-KG; Fri, 17 Oct 2025 07:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v9j3X-0004uZ-0I; Fri, 17 Oct 2025 07:55:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v9j3L-0000Zp-Qm; Fri, 17 Oct 2025 07:55:34 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HBVW9w021058;
 Fri, 17 Oct 2025 11:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=tHucUvuNgC8BqWVhqqxhh4i8iKwn0m
 m9Apj+t2bt9rA=; b=ZvIVLB3Ck19/w/5Lh8QlMtlHLDVMZ6LpLIxTDVRcmhQ2aU
 RskinmqFcsY5mkh/8CRMHrZRes6AZK1saabMTxYUUiIC6sE9AB4hYno7+kTsf1Ov
 rcjBsC+3nMaARYgYnJWlWNlRtDSk05Z8dj7FAnN1NqmqeYToA+isOgXHSpWUU+AT
 mI3ZSnW5G2SliwgkEnQ9ZeuLARM2nHMrnLfVtqIzKQPUNE/qWpz+OaRHD8S4bOeV
 USmVSIOtYBwIN6bBOpSDSz+N3I6DRz855UtjiWduiHXy6K5UCehah2kpFAgRk0LT
 DMrKZjiLjIVCbK4Lxru4sq8uIiKMWynDCtuFXUHg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0h0g3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:55:15 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59HBoiGx025092;
 Fri, 17 Oct 2025 11:55:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0h0g1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:55:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9NKFT016759;
 Fri, 17 Oct 2025 11:55:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32kd0y7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:55:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59HBt9N118219472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 11:55:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3B3320067;
 Fri, 17 Oct 2025 11:55:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 789C02006C;
 Fri, 17 Oct 2025 11:55:07 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.26.210]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 17 Oct 2025 11:55:07 +0000 (GMT)
Date: Fri, 17 Oct 2025 17:25:04 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v4 2/8] hw/ppc: Implement fadump register command
Message-ID: <uziuoaz7tt6q5ravfgyodjp2c6pt7w7smxhjl4xvqjkkloxv6u@5juayehkqjzt>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-3-adityag@linux.ibm.com>
 <c57386c9-4f55-4ab0-bf3a-082c4c010dc4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c57386c9-4f55-4ab0-bf3a-082c4c010dc4@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GM1BKLrU8nlTCnB7foSGZa04fyyVmBv6
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f22ea3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=UJa3zHhObrYYrVZ936cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX4seznkOFlpX1
 IIENnn8thyRKkjjdLz3LkKN30QKvQLCykQN3weD9IY/XTy6YSWlDWD8ok07UdsUq9iqCVECFeLk
 W2oRpYII4xtPb50u+Ue/jWlbOrsRGIQNR3WJAicFPi3WReIVZ6LfAcHiq2C9tn278MPaRk/ri1a
 vG1ZZWpOpwLWS3JyZR4T7enGwpG7PC4SRuw0iFud+FXlYtmd0QRbscmiWmo+NczozThyqkcaDjp
 kXjPcDKv0JaYiDYLX2ua/eJdY1757PBbzLJFPYRnxvhjLfhg9abKRrbauwbfTNyQw233IfxXBcb
 dDF8X/g9hE5ZiD4m8ayxWkwN8hG/tfYoF6IrZ3Fj/tdhC75QfMdZfqPT/uhTU3V9PHqCQ5YRf1Z
 oz1EWjEJKK4riT+xDQaIIhTFotl2VQ==
X-Proofpoint-GUID: Fd0A_O8kyqctTbAtXI16uxMFpqW6iz9I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 25/10/17 03:24PM, Sourabh Jain wrote:
> 
> 
> On 23/03/25 23:10, Aditya Gupta wrote:
> > Implement the register command of "ibm,configure-kernel-dump" RTAS call.
> > The register just verifies the structure of the fadump memory structure
> > passed by kernel, and set fadump_registered in spapr state to true.
> > 
> > We also store the passed fadump memory structure, which will later be
> > used for preserving memory for fadump boot in case of a crash.
> > 
> > The fadump memory structure isn't modified (other than .dump_status_flag
> > after the fadump is triggered, that is in a later patch).
> > So if the structure needs to updated, the kernel should first
> > de-register and re-register the structure again.
> > 
> > Relevant section for the register command in PAPR is:
> >      Section 7.3.30: "ibm,configure-kernel-dump RTAS call" (PAPR v2.13)
> > 
> > Note: The fadump registration is done, but triggering fadump on an
> > os-term rtas call is done in later patches. Hence QEMU will just shutdown
> > on a kernel crash due to no special handling for fadump in ibm,os-term
> > 
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---
> >   hw/ppc/spapr_fadump.c         | 111 ++++++++++++++++++++++++++++++++--
> >   hw/ppc/spapr_rtas.c           |   2 +-
> >   include/hw/ppc/spapr_fadump.h |   2 +-
> >   3 files changed, 108 insertions(+), 7 deletions(-)
> > 
> > diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
> > index 20b7b804c485..9c7fb9e12b16 100644
> > --- a/hw/ppc/spapr_fadump.c
> > +++ b/hw/ppc/spapr_fadump.c
> > @@ -5,18 +5,119 @@
> >    */
> >   #include "qemu/osdep.h"
> > +#include "qemu/log.h"
> >   #include "hw/ppc/spapr.h"
> >   /*
> >    * Handle the "FADUMP_CMD_REGISTER" command in 'ibm,configure-kernel-dump'
> >    *
> > + * Note: Any changes made by the kernel to the fadump memory struct won't
> > + * reflect in QEMU after the 'ibm,configure-kernel-dump' RTAS call has returned,
> > + * as we store the passed fadump memory structure passed during fadump
> passed fadump memory structure passed... is not easy to understand; how
> about?
> 
> Note: Any modifications made by the kernel to the fadump memory structure
> after the 'ibm,configure-kernel-dump' RTAS call returns will not be
> reflected
> in QEMU as QEMU retains the fadump memory structure that was provided
> during fadump registration.
> 
> The kernel must invalidate and re-register fadump to apply any changes
> to the fadump memory structure.

Makes sense. Will use the suggested text.

> 
> > + * registration.
> > + * Kernel has to invalidate & re-register fadump, if it intends to make any
> > + * changes to the fadump memory structure
> > + *
> >    * Returns:
> > - *  * RTAS_OUT_HW_ERROR: Not implemented/Misc issue such as memory access
> > - *                       failures
> > + *  * RTAS_OUT_SUCCESS: On successful registration
> > + *  * RTAS_OUT_PARAM_ERROR: If parameters are not correct, eg. too many
> > + *                          sections, invalid memory addresses that we are
> > + *                          unable to read, etc
> > + *  * RTAS_OUT_DUMP_ALREADY_REGISTERED: Dump already registered
> > + *  * RTAS_OUT_HW_ERROR: Misc issue such as memory access failures
> >    */
> > -uint32_t do_fadump_register(void)
> > +uint32_t do_fadump_register(SpaprMachineState *spapr, target_ulong args)
> >   {
> > -    /* WIP: FADUMP_CMD_REGISTER implemented in future patch */
> > +    FadumpSectionHeader header;
> > +    FadumpSection regions[FADUMP_MAX_SECTIONS] = {0};
> > +    target_ulong fdm_addr = rtas_ld(args, 1);
> > +    target_ulong fdm_size = rtas_ld(args, 2);
> > +    AddressSpace *default_as = &address_space_memory;
> > +    MemTxResult io_result;
> > +    MemTxAttrs attrs;
> > +    uint64_t next_section_addr;
> > +    uint16_t dump_num_sections;
> > +
> > +    /* Mark the memory transaction as privileged memory access */
> > +    attrs.user = 0;
> > +    attrs.memory = 1;
> > +
> > +    if (spapr->fadump_registered) {
> > +        /* FADump already registered */
> > +        return RTAS_OUT_DUMP_ALREADY_REGISTERED;
> > +    }
> > +
> > +    if (spapr->fadump_dump_active == 1) {
> 
> fadump_dump_active is bool, so comparing with an integer is not needed.

Will remove == 1.

> 
> > +        return RTAS_OUT_DUMP_ACTIVE;
> > +    }
> > +
> > +    if (fdm_size < sizeof(FadumpSectionHeader)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +            "FADump: Header size is invalid: %lu\n", fdm_size);
> > +        return RTAS_OUT_PARAM_ERROR;
> > +    }
> > +
> > +    /* Ensure fdm_addr points to a valid RMR-memory/RMA-memory buffer */
> > +    if ((fdm_addr <= 0) || ((fdm_addr + fdm_size) > spapr->rma_size)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +            "FADump: Invalid fdm address: %ld\n", fdm_addr);
> > +        return RTAS_OUT_PARAM_ERROR;
> > +    }
> > +
> > +    /* Try to read the passed fadump header */
> > +    io_result = address_space_read(default_as, fdm_addr, attrs,
> > +            &header, sizeof(header));
> > +    if (io_result != MEMTX_OK) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +            "FADump: Unable to read fdm address: %ld\n", fdm_addr);
> > +
> > +        return RTAS_OUT_HW_ERROR;
> > +    }
> > +
> > +    /* Verify that we understand the fadump header version */
> > +    if (header.dump_format_version != cpu_to_be32(FADUMP_VERSION)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +            "FADump: Unknown fadump header version: 0x%x\n",
> > +            header.dump_format_version);
> > +        return RTAS_OUT_PARAM_ERROR;
> > +    }
> > +
> > +    /* Reset dump status flags */
> > +    header.dump_status_flag = 0;
> > +
> > +    dump_num_sections = be16_to_cpu(header.dump_num_sections);
> > +
> > +    if (dump_num_sections > FADUMP_MAX_SECTIONS) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +            "FADump: Too many sections: %d sections\n", dump_num_sections);
> > +        return RTAS_OUT_PARAM_ERROR;
> > +    }
> > +
> > +    next_section_addr =
> > +        fdm_addr +
> > +        be32_to_cpu(header.offset_first_dump_section);
> > +
> > +    for (int i = 0; i < dump_num_sections; ++i) {
> > +        /* Read the fadump section from memory */
> > +        io_result = address_space_read(default_as, next_section_addr, attrs,
> > +                &regions[i], sizeof(regions[i]));
> > +        if (io_result != MEMTX_OK) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                "FADump: Unable to read fadump %dth section\n", i);
> > +            return RTAS_OUT_PARAM_ERROR;
> > +        }
> > +
> > +        next_section_addr += sizeof(regions[i]);
> > +    }
> > +
> > +    spapr->fadump_registered = true;
> > +    spapr->fadump_dump_active = false;
> 
> Setting fadump_dump_active is not really required. Ideally, we shouldn't
> reach here
> if it is set to true, or am I missing something?

True, with current change it's not really needed. But to be on safe
side, it's better to keep valid values hence ensuring dump_active is
false, after register.

> 
> > +
> > +    /* Store the registered fadump memory struct */
> > +    spapr->registered_fdm.header = header;
> > +    for (int i = 0; i < dump_num_sections; ++i) {
> > +        spapr->registered_fdm.rgn[i] = regions[i];
> > +    }
> > -    return RTAS_OUT_HW_ERROR;
> > +    return RTAS_OUT_SUCCESS;
> >   }
> > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > index b8bfa9c33fb5..0454938a01e9 100644
> > --- a/hw/ppc/spapr_rtas.c
> > +++ b/hw/ppc/spapr_rtas.c
> > @@ -366,7 +366,7 @@ static void rtas_configure_kernel_dump(PowerPCCPU *cpu,
> >       switch (cmd) {
> >       case FADUMP_CMD_REGISTER:
> > -        ret_val = do_fadump_register();
> > +        ret_val = do_fadump_register(spapr, args);
> >           if (ret_val != RTAS_OUT_SUCCESS) {
> >               rtas_st(rets, 0, ret_val);
> >               return;
> > diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
> > index 45109fd9e137..6abbcb44f353 100644
> > --- a/include/hw/ppc/spapr_fadump.h
> > +++ b/include/hw/ppc/spapr_fadump.h
> > @@ -65,5 +65,5 @@ struct FadumpMemStruct {
> >       FadumpSection       rgn[FADUMP_MAX_SECTIONS];
> >   };
> > -uint32_t do_fadump_register(void);
> > +uint32_t do_fadump_register(struct SpaprMachineState *, target_ulong);
> 
> Seems like the forward declaration of struct SpaprMachineState done in 01/08
> is
> because of the above change. Should we do there forward declaration here
> instead?

Yes, it was for this.
Merging patch 1 and 2 in v5, then this will be fine.

Thanks Sourabh !
- Aditya G

> 
> >   #endif /* PPC_SPAPR_FADUMP_H */
> 

