Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D324ACCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 19:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAvnn-0007CE-0j; Mon, 20 Oct 2025 15:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vAvnk-0007BV-4J; Mon, 20 Oct 2025 15:44:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vAvnh-0007PW-W8; Mon, 20 Oct 2025 15:44:15 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KDOebk004702;
 Mon, 20 Oct 2025 19:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=Bn/fhjxfklOL1FGBkzhnnxSTvVE9nK
 idd7DDXrjTAbs=; b=LF3Ev4zmLEq6bQfk4tnziPLKiH8/YlSZYHGQmM/0QrXdsl
 S5G82ueHReVLBBROK4bu5P7FfrhSYChMyBMjoj5HNCm3ymQiYR1pwORkInZ9E+FD
 Bda34lwT3ESwr2TkDOLckmtY4NHPEPUC2ecRN4JxFJE7CWmS+9P/+1LamNJEsl0R
 KVCwP4q0lZhg8QE2//YdNVtdtEfteyTtvqP34cs3Cy6erjmpYVfVuAr6iZuObrCH
 LUlh/zF3fRDjxZGZE0OyTWsYHq1GCaXpiXt7cCuJ3oRUg+K26BxYctcKJzXeDhBp
 q0msJR7iRzh5d8v9R1yyjlmlkKKzOSFcV11/1GyA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31c27jj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 19:44:10 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59KJhwQH032032;
 Mon, 20 Oct 2025 19:44:09 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31c27jf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 19:44:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KJ25Kf002320;
 Mon, 20 Oct 2025 19:44:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqej74wp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 19:44:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59KJi5Ms26280234
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Oct 2025 19:44:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EEA120043;
 Mon, 20 Oct 2025 19:44:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAFF020040;
 Mon, 20 Oct 2025 19:44:02 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.220.224])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 20 Oct 2025 19:44:02 +0000 (GMT)
Date: Tue, 21 Oct 2025 01:14:00 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v4 7/8] hw/ppc: Enable fadump for PSeries
Message-ID: <xorza3ueibrlphfam2zd6y5lqfbcb3pigkagdd7s7f7iftdu7c@5x5qq56bii4v>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-8-adityag@linux.ibm.com>
 <1d3f2a26-73be-4c09-814e-92e2933a04a0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d3f2a26-73be-4c09-814e-92e2933a04a0@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q9cimp00x3NkMKaWMjA_9ut1iCVozgD1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXyGEfOhpyTeDv
 LjvnjNGciC02TnZq4t+eHIdA3y9Ynx5Z75K1JJXmNfpgx16HcgcYnJHM6p+HjPxw0iKVrllDdRW
 pJl1fl+VmuA182fnpkf0Sq0KINCXN6dbi7KaWOY/QJSdYy3FBbZvlNjsPkeaN5RgpSAM0kkVXKu
 0sQJATJhnhy5unY+jRkCOZM1bvfjmjBrQu6/YfY/K+UDVRiTClPahZjqBqoyWlhapk/Nwnx4Dql
 0JI5c8T+5iMHFbOxpPN+hzDuZF/pwFAWa2JViPoQN5dmxYhVm/jc5+aOe5FLfk47m55B8oNtf+v
 FY/wua2kLGPEIXHxWsSGcAsx43wgXuEzPebbCMr0iLosDOSQbzfUnaIfNPoJVkM/1oGPa/giiN5
 IjXzPXHVITk27FgUSVhzYerA22hNwQ==
X-Proofpoint-GUID: x5Mib331ZVWdsegZMXyz7m_VbdafEI83
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f6910a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Qf_wr7Qep9whXJSVnEEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
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

Hello Sourabh,

On 25/10/18 05:34PM, Sourabh Jain wrote:
> 
> 
> > <...snip...>
> > The fadump boot after crash:
> > 
> >      [    0.000000] rtas fadump: Firmware-assisted dump is active.
> >      [    0.000000] fadump: Updated cmdline: debug fadump=on crashkernel=1G
> >      [    0.000000] fadump: Firmware-assisted dump is active.
> 
> Kernel is printing twice about fadump is active. :)

Yeah i noticed, that seems to be the case atleast with 6.14

> 
> > <...snip...>
> >       MachineState *ms = MACHINE(spapr);
> >       MachineClass *mc = MACHINE_GET_CLASS(ms);
> > +    FadumpMemStruct *fdm = &spapr->registered_fdm;
> > +    uint16_t dump_status_flag;
> > +    bool     is_next_boot_fadump;
> >       uint32_t max_possible_cpus = mc->possible_cpu_arch_ids(ms)->len;
> >       uint64_t fadump_cpu_state_size = 0;
> > @@ -953,6 +956,18 @@ static void spapr_dt_rtas_fadump(SpaprMachineState *spapr, void *fdt, int rtas)
> >                       fadump_versions, sizeof(fadump_versions))));
> >       _FDT((fdt_setprop(fdt, rtas, "ibm,configure-kernel-dump-sizes",
> >                       fadump_rgn_sizes, sizeof(fadump_rgn_sizes))));
> > +
> > +    dump_status_flag = be16_to_cpu(fdm->header.dump_status_flag);
> > +    is_next_boot_fadump =
> 
> Do we really need is_next_boot_fadump variable?

Agreed, not needed now, will remove it in v5.

> 
> > +        (dump_status_flag & FADUMP_STATUS_DUMP_TRIGGERED) != 0;
> > +    if (is_next_boot_fadump) {
> > +        uint64_t fdm_size =
> > +            sizeof(struct FadumpSectionHeader) +
> > +            (be16_to_cpu(fdm->header.dump_num_sections) *
> > +            sizeof(struct FadumpSection));
> > +
> > +        _FDT((fdt_setprop(fdt, rtas, "ibm,kernel-dump", fdm, fdm_size)));
> 
> Is this common in QEMU to call _FDT to add prop to the FDT? Feels odd.

Yes, that's just a wrapper for error checking in QEMU, used extensively
atleast in hw/ppc

Thanks for your reviews Sourabh !

- Aditya G

> 
> > +    }
> >   }
> >   static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
> 

