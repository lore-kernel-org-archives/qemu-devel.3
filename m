Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ED4C98315
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9keU-0005lX-G9; Thu, 24 Sep 2026 10:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x9keN-0005Vm-Bs; Thu, 24 Sep 2026 10:42:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x9keJ-0004hd-NO; Thu, 24 Sep 2026 10:42:14 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC65jW314544; Thu, 24 Sep 2026 14:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=oBKYApOJ0bdDEDEUaKMcVEYW7DEPb3
 1TKvFFk7FO36I=; b=H864S9mpuVGfozLvYGiOvbVuye776RqCqQaqCH1yX2eFGz
 omi9WYLneXgsTpYKwemmOrDNS5KCN4koNyIH/CtssD0tLjrQyMaMPa9RfPZvsgjr
 ZT13jtIuLIARKg7lMfzv5olrezJOlEZR22IjgAkR3Z9I+yfA1ZiszIgUooI3J6nB
 0XzwB31CSf+GX2LiU6aUrXstqglhQgr4BrbLUn/YW6T+NM4qvKHk6QUOLe8POwq7
 ZCiH9tJEdsOYUKWG6h0FlR4EdU7luWpDNYqewGguC2h9emkZBauuyfNkmbekpl+p
 cn3jElHou9Dc+SklWcLbAkLKmuHgm9LDOWL9KVqw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske21qxc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:42:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OENek52245134; Thu, 24 Sep 2026 14:42:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jxacx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:42:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OEg1TZ44499354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 14:42:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1277820043;
 Thu, 24 Sep 2026 14:42:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6779220040;
 Thu, 24 Sep 2026 14:41:58 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 24 Sep 2026 14:41:58 +0000 (GMT)
Date: Thu, 24 Sep 2026 20:12:09 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sourabhjain@linux.ibm.com,
 rathc@linux.ibm.com, npiggin@gmail.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, adityag@linux.ibm.com,
 richard.henderson@linaro.org, mkchauras@gmail.com,
 sshegde@linux.ibm.com, srikar@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH] target/ppc: Stop vCPU thread before calling
 parent_unrealize
Message-ID: <20260924200552.2eab89e8-e2-amachhiw@linux.ibm.com>
Mail-Followup-To: Shivang Upadhyay <shivangu@linux.ibm.com>, 
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sourabhjain@linux.ibm.com, 
 rathc@linux.ibm.com, npiggin@gmail.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, 
 adityag@linux.ibm.com, richard.henderson@linaro.org, mkchauras@gmail.com, 
 sshegde@linux.ibm.com, srikar@linux.ibm.com
References: <20260923121444.154175-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923121444.154175-1-shivangu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: t1xyXz8yN4uPVblQAAhcqqMZwV7Me-hQ
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab536bd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=swho5EqsanefJ7Gy4D0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX7m9Ho53afKiN
 UciOaOi0Nir5vxSyJfd4M3tD7GP28aG87au2LCGUKCtMn0MHH9vgiuyIXLabQ9MyB4eeAodRdKq
 PiB1rbADL9UNJ9g74e+E2UiBhi+6I1Y=
X-Proofpoint-GUID: HD5-A7ZadI2TFbdP5cQMylGwLpfL8HOT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX0l50IXwljgFB
 +81ZQmLcElDj23uLKnxJnhEzcYrAor5cpgavbdyYr9zhRWtTokBgQ7wx6QAt97PFe7vblQ2vFmJ
 nxf15E5IvnYCcr03Tr+ScS1XMP6cEwUgxWz/CUm9AxPxUTJNdG3uHaWBhzHZA9WZtQgVZegfA3d
 HVNmNn9dNEq4MKxguxTO+tkaiSN0YT9FGwY8Jk+JvSwtsNnCE4lYLpOevAsGXui+in0/A0IcN3B
 KjkaIDyOesYd6a0x1hsx5zlD/fYLZ0qFMhlC34valtMdrJfQn3vMvrYj6LwQ4SV/whM/M7ozaK1
 O1THSOXfbqhvT973LJMfM2K3zKvvuZWsjXt954LJ5QsHb3xIRoSK4B8WjjAbJ4GxGsMtil3R3jv
 QJVR9w365ynq8mUy6E5CYXCjJCFYP7utLAZopg2qyC69oChDa6dy4ywrIE7th079Q6QLVcqtEsz
 8oRS2LSEpHHI7OADD7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240060
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 2026/09/23 05:44 PM, Shivang Upadhyay wrote:
> During CPU hot-unplug (e.g. via dynamic reconfiguration unplug),
> ppc_cpu_unrealize() invoked pcc->parent_unrealize(dev) before calling
> cpu_remove_sync(CPU(cpu)).
> 
> pcc->parent_unrealize() calls cpu_common_unrealize(), which triggers
> accel_cpu_common_unrealize() -> tcg_exec_unrealizefn() -> tlb_destroy().
> This immediately frees the CPU's TLB tables and structures. Because the
> vCPU thread had not yet been stopped and joined via cpu_remove_sync(),
> the vCPU thread was still actively running its event loop and processing
> queued CPU work (such as tcg_commit_cpu / tlb_flush).
> 
> This resulted in a race where the running vCPU thread accessed and freed
> already-destroyed TLB tables concurrently with tlb_destroy(), leading to
> Segfault (due to heap corruption).
> 
> AddressSanitizer build reported a double-free:
> 
> =================================================================
> ==121930==ERROR: AddressSanitizer: attempting double-free on 0x7ef8f3438800 in thread T14:
>     #0 0x7fe8f74e5beb in free.part.0 (/lib64/libasan.so.8+0xe5beb)
>     #1 0x7fe8f6cb8f84 in g_free (/lib64/libglib-2.0.so.0+0x41f84)
>     #2 0x558bf6a391b1 in tlb_mmu_resize_locked accel/tcg/cputlb.c:249
>     #3 0x558bf6a396b5 in tlb_flush_one_mmuidx_locked accel/tcg/cputlb.c:296
>     #4 0x558bf6a39f91 in tlb_flush_by_mmuidx_async_work accel/tcg/cputlb.c:390
>     #5 0x558bf6a3a200 in tlb_flush_by_mmuidx accel/tcg/cputlb.c:417
>     #6 0x558bf6a3a22a in tlb_flush accel/tcg/cputlb.c:422
>     #7 0x558bf73f31ac in tcg_commit_cpu system/physmem.c:3068
>     #8 0x558bf6987c55 in process_queued_cpu_work cpu-common.c:378
>     #9 0x558bf73a9913 in qemu_process_cpu_events_common system/cpus.c:402
>     #10 0x558bf73a9a46 in qemu_process_cpu_events system/cpus.c:421
>     #11 0x558bf6a65974 in mttcg_cpu_thread_fn accel/tcg/tcg-accel-ops-mttcg.c:90
> 
> 0x7ef8f3438800 is located 0 bytes inside of 65536-byte region [0x7ef8f3438800,0x7ef8f3448800)
> freed by thread T9 here:
>     #0 0x7fe8f74e5beb in free.part.0 (/lib64/libasan.so.8+0xe5beb)
>     #1 0x7fe8f6cb8f84 in g_free (/lib64/libglib-2.0.so.0+0x41f84)
>     #2 0x558bf6a39a91 in tlb_destroy accel/tcg/cputlb.c:345
>     #3 0x558bf6a16354 in tcg_exec_unrealizefn accel/tcg/cpu-exec.c:1094
>     #4 0x558bf693d073 in accel_cpu_common_unrealize accel/accel-common.c:117
>     #5 0x558bf6980e37 in cpu_common_unrealize hw/core/cpu-common.c:279
>     #6 0x558bf6980dfa in cpu_common_unrealizefn hw/core/cpu-common.c:267
>     #7 0x558bf763ef65 in ppc_cpu_unrealize target/ppc/cpu_init.c:6965
>     #8 0x558bf7872199 in device_set_realized hw/core/qdev.c:618
>     #14 0x558bf756068f in spapr_unrealize_vcpu hw/ppc/spapr_cpu_core.c:209
> 
> Fix this by moving cpu_remove_sync() before pcc->parent_unrealize(dev)
> in ppc_cpu_unrealize(), ensuring the vCPU thread is stopped, has
> finished processing its events, and is joined before CPU resources
> and accelerator state are destroyed.
> 
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>  target/ppc/cpu_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 6c626843c9..b711f9c0a8 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6962,10 +6962,10 @@ static void ppc_cpu_unrealize(DeviceState *dev)
>      PowerPCCPU *cpu = POWERPC_CPU(dev);
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>  
> -    pcc->parent_unrealize(dev);
> -
>      cpu_remove_sync(CPU(cpu));
>  
> +    pcc->parent_unrealize(dev);
> +

The fix is correct and the commit message is well written.  The ASan trace makes
the race unambiguous: tlb_destroy() frees fast->table and desc->fulltlb while
the MTTCG thread is still running tlb_mmu_resize_locked() on the same structures
via the queued tcg_commit_cpu work.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Minor: I think a short comment above cpu_remove_sync() would make the ordering
constraint self-documenting, e.g.:

    /*
     * Stop and join the vCPU thread before tearing down accelerator
     * state (TLB tables etc.) to prevent the running thread from
     * accessing freed resources.
     */
    cpu_remove_sync(CPU(cpu));

Thanks,
Amit

