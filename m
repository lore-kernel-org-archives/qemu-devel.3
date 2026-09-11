Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA65CC88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x532h-0006kI-NR; Fri, 11 Sep 2026 11:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x532b-0006jH-TV; Fri, 11 Sep 2026 11:19:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x532a-0003nb-26; Fri, 11 Sep 2026 11:19:49 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BF1bpo971348; Fri, 11 Sep 2026 15:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=OgBzUz
 gixRcCu3f006tpzWNgULgtNquG9uvNV43lu6I=; b=BH0d2Om2jXEB5kxiNdRnlC
 uNQefE6nR0NzS5DHZ4qCkzEVcX0GQ1BdIn7r2j5zTKPEnsh/AIHeJh1DjQb2h5cO
 EN/nJnfrBg+wfdZH1N9U6UIuXeiq/QXBn8TdR/uor0ZQtFZKhi1Tr4/lZ7X7Bo3v
 snnXqDVwRrUi8Hvt4FBZ4cgHDX0uAmiwDfjbHWqfwn73XINcRDeSSxBhKiueWEBD
 ObSWyIfpJ4MuDvdNVNRI6kyv6krCl493QX1cqgGhSBqZdKFtucW/yBS/Hb0u9EGc
 vkgcju9p9Zdk9cNTFsP0jLuMRIcjNVtC9wxIiJSI0id6Ke9wmXdIxv02CQYOFIEw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qc8r1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:19:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEoEtG1802660; Fri, 11 Sep 2026 15:19:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvtff22p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:19:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68BFJg0s36962968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2026 15:19:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73F325805D;
 Fri, 11 Sep 2026 15:19:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C53C58052;
 Fri, 11 Sep 2026 15:19:41 +0000 (GMT)
Received: from [9.61.94.186] (unknown [9.61.94.186])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 11 Sep 2026 15:19:41 +0000 (GMT)
Message-ID: <5e9f48e3-2c3a-4259-be3a-654fe13ba285@linux.ibm.com>
Date: Fri, 11 Sep 2026 11:19:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] pc-bios/s390-ccw: Introduce virtio_tswap helpers
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 jdaley@linux.ibm.com, pbonzini@redhat.com
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
 <20260903162449.2588271-4-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260903162449.2588271-4-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eMKc31iSq-Z4QY8EwcX3VBY2M_-nzSZq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfXw+e40zF1OAd8
 IB/ti36dDx9JF4ZvnP1xWCdgiWpuAUu6e4evMF8CDZEyOlpg+s8ZvxwTuBmXL+0X9iefPDjhyhE
 96WClZJt0wtJT0A3xAK9Iz7WABG+/0g=
X-Authority-Analysis: v=2.4 cv=E/dYNqdl c=1 sm=1 tr=0 ts=6aa41c10 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=oSvTa84OmGCE6nrsjowA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX/kM/3LSGx0Dq
 QGfcbfoUlc2kje0p7S7141OKLyl/Tmt0uHwIHVzzFiCcTssw6sWuKO0d6YFWjStAD/zygxPCc2x
 VF0X3p2hfqjiQOccU99GFPT/+yfaOeBUtJokczzrn0BNfNUm6DF1VjEQhCJvi6IT7bdPdT5qiFj
 F8rySj/4C7368VGQUfCQaZxvGZPzhXpbfYTYsNpSBZnREMYlmlSBG4jNbMoMfuVmaP/3CWYIc5F
 tleLdpP7I8hdB5dmR9sLeksN0u7xi2olGL+RUCaQHRm3J7h2g9OwAVIGVrCJxys1fv/xOJysD74
 /qC/o5LqJ+2kqGtZ0rENJtxiZqDLeBq7RKOfVz/V9V1bokyz9ITXwLQhcPants3/AKvjJjuRrlG
 kQOBQRuGnf5lCCl9UIZ046TODfZTZzDR21xBGVuehDafgMKIVML5YzMp15IX1RYQDcFYjXVmYR6
 79vBXP4PY9MFUkguvmg==
X-Proofpoint-GUID: eMKc31iSq-Z4QY8EwcX3VBY2M_-nzSZq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110210
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 9/3/26 12:24 PM, Zhuoying Cai wrote:
> Replace the repeated pattern:
>
>      be_ipl() ? x : bswapN(x)
>
> with helpers that conditionally byte-swap based on the virtio transport
> endianness.
>
> While only the 16-bit helper is used immediately, the 32-bit and 64-bit
> variants are added here for later use.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

>   pc-bios/s390-ccw/virtio.c | 27 +++++++++++++++++++++------
>   pc-bios/s390-ccw/virtio.h |  4 ++++
>   2 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index a0d249db24..037c00a3e1 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -97,7 +97,7 @@ void vring_init(VRing *vr, VqInfo *info)
>       vr->avail->idx = 0;
>   
>       /* We're running with interrupts off anyways, so don't bother */
> -    vr->used->flags = be_ipl() ? VRING_USED_F_NO_NOTIFY : bswap16(VRING_USED_F_NO_NOTIFY);
> +    vr->used->flags = virtio_tswap16(VRING_USED_F_NO_NOTIFY);
>       vr->used->idx = 0;
>       vr->used_idx = 0;
>       vr->next_idx = 0;
> @@ -140,6 +140,22 @@ bool be_ipl(void)
>       }
>   }
>   
> +/* Conditionally byte-swap between virtio-endian and s390x native big-endian. */
> +uint16_t virtio_tswap16(uint16_t x)
> +{
> +    return be_ipl() ? x : bswap16(x);
> +}
> +
> +uint32_t virtio_tswap32(uint32_t x)
> +{
> +    return be_ipl() ? x : bswap32(x);
> +}
> +
> +uint64_t virtio_tswap64(uint64_t x)
> +{
> +    return be_ipl() ? x : bswap64(x);
> +}
> +
>   /*
>    * Format the virtio ring descriptor endianness
>    * Return the available index increment in the appropriate endianness
> @@ -156,12 +172,11 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
>   {
>       uint16_t avail_idx;
>   
> -    avail_idx = be_ipl() ? vr->avail->idx : bswap16(vr->avail->idx);
> +    avail_idx = virtio_tswap16(vr->avail->idx);
>   
>       /* For follow-up chains we need to keep the first entry point */
>       if (!(flags & VRING_HIDDEN_IS_CHAIN)) {
> -        vr->avail->ring[avail_idx % vr->num] = be_ipl() ? vr->next_idx :
> -                                                          bswap16(vr->next_idx);
> +        vr->avail->ring[avail_idx % vr->num] = virtio_tswap16(vr->next_idx);
>       }
>   
>       vr->desc[vr->next_idx].addr = (unsigned long)p;
> @@ -179,7 +194,7 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
>       /* Chains only have a single ID */
>       if (!(flags & VRING_DESC_F_NEXT)) {
>           avail_idx++;
> -        vr->avail->idx = be_ipl() ? avail_idx : bswap16(avail_idx);
> +        vr->avail->idx = virtio_tswap16(avail_idx);
>       }
>   }
>   
> @@ -187,7 +202,7 @@ int vr_poll(VRing *vr)
>   {
>       uint16_t used_idx;
>   
> -    used_idx = be_ipl() ? vr->used->idx : bswap16(vr->used->idx);
> +    used_idx = virtio_tswap16(vr->used->idx);
>       if (used_idx == vr->used_idx) {
>           vring_notify(vr);
>           yield();
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index aa307025e0..645dc288b1 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -287,6 +287,10 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd);
>   int virtio_reset(VDev *vdev);
>   int virtio_setup_ccw(VDev *vdev);
>   
> +uint16_t virtio_tswap16(uint16_t x);
> +uint32_t virtio_tswap32(uint32_t x);
> +uint64_t virtio_tswap64(uint64_t x);
> +
>   /* virtio-net.c */
>   int virtio_net_init(void *mac_addr);
>   void virtio_net_deinit(void);


