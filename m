Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D780CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDl2Z-0001DW-8P; Mon, 05 Oct 2026 11:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1xDl2V-0001DA-5C; Mon, 05 Oct 2026 11:55:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1xDl2S-0005gK-Ly; Mon, 05 Oct 2026 11:55:42 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695EZbOK884341; Mon, 5 Oct 2026 15:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=YXO5Vyd8pgNs3iLwKpqRQiVI5EC1ua
 zyBULOgUWm5jE=; b=GhvPDr+tOQtVoFUoujJ+//D1iydfsM7dGUXG9z7HQtYZOF
 wT5O4uoVVV1Zqz6mFNT8i1Bo8wR8ADh8TlS5bOBKNzEMOWHSzG7B4VeaLH8MJx+X
 pT1BzYD1oVEY/tPF9UGF2aq/LgCcQuekTSXTN130+1uFAmkkrJCXfjV+lorZZVNY
 Xui9fp4aKgJvBBua0BLRRyoFOIttOkIxoEYL4RHz1SMD34562fhX40vhFQZBFgfa
 ZzqOWLe2br+20J2hZ9fBVf5/ShSIRhVj6VjXw0cD6kl/IeFNVmueAaEQAF3sFHr/
 6K+yfQlRT9duihtcH5o+1NHUteIf+EL/v4B7zRXg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5b58k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 15:55:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695ElRTN3042160; Mon, 5 Oct 2026 15:55:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvp77h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 15:55:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695FtSlc38404352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 15:55:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B80D320040;
 Mon,  5 Oct 2026 15:55:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D38FB20043;
 Mon,  5 Oct 2026 15:55:26 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown
 [9.39.24.232]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  5 Oct 2026 15:55:26 +0000 (GMT)
Date: Mon, 5 Oct 2026 21:25:23 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 npiggin@gmail.com, amachhiw@linux.ibm.com, jasowangio@gmail.com,
 Lazymio <mio@lazym.io>
Subject: Re: [PATCH] hw/net/spapr_llan: validate RxBufPool fields on
 migration load
Message-ID: <asPIR7Hyv9a6vAYf@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20260917202854.288439-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917202854.288439-1-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MSBTYWx0ZWRfX3H1KgbGnGM1U
 gbSWQWMVn1lpixgDkE88OPipck1MuB5luQYZkxjFY6v28Ll+pcMawK8ViPhJuggqw18j/9N65fL
 BVUVgAzZuFWV2UAqq6BsDnes2Fie0MA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MSBTYWx0ZWRfXyIJjIaSWm0C0
 1FSX9YDxZL5MXN5y0/uBOISWNYNujaQYegc41nfkQvm/+BPtLApP/1eilhscOQAOsp9j45SC0DZ
 TckQgkrc1OBzuzr2CPUF4rab1ftG0JXL4Clgh+IUeVnBqA9HYYaTs5K1zZYBlfpiBxTfeLO50Gr
 VLkeHiqDhV6GUiPajzS1lxLU0VY7cRXROT6ggbQCR2WUULMcgm4HtxXZO0da0zZKe44Z7uex2ei
 LCphFSvIARBXEQzBT5lCpRM192UN3cwsUXDwya07gVJKXX9mzoJKRfkzkYpIpW0iic+B3B5lYWg
 Yd4ovgdsUgtN8MpY+fE57JrmZK0VrxsQBgGADD5CFYIuEiO0+4kS2biYA/CyhEjPsQCLuiF4EwK
 6nyyAST74VfNs0AaXP5KvMP3CdGWFGxKai15HlBfVHi/xt8EIze53xtOyNgFxkMlUFpefDsHj0V
 /d0H65JU7WGihHbMJdw==
X-Proofpoint-GUID: EomeZRtlpi5e64mAz7ozoqlKaCd45Iua
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac3c876 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=SUwFEnplq87QwEMo9KUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: n0IwojkrR89j8bJNhrxoSlUooQyQa3Ir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050061
Received-SPF: pass client-ip=148.163.156.1; envelope-from=gautam@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Fri, Sep 18, 2026 at 01:58:41AM +0530, Chinmay Rath wrote:
> vmstate_rx_buffer_pool restores count and bufsize as raw int32 values
> with no bounds checking.  A crafted migration stream can set count to
> any int32 value.  spapr_vlan_get_rx_bd_from_pool() then passes the
> count > 0 guard, decrements count, and uses the result as an array
> index into bds[], a 4096-entry fixed heap allocation:
> 
>     dev->rx_pool[pool]->count--;
>     bd  = dev->rx_pool[pool]->bds[dev->rx_pool[pool]->count];  /* OOB read  */
>     dev->rx_pool[pool]->bds[dev->rx_pool[pool]->count] = 0;    /* OOB write */
> 
> With count == INT32_MAX this lands ~17 GiB past the start of a 32 KiB
> heap object.  Additionally, a negative bufsize silently compares as a
> huge value when widened to size_t, defeating the bufsize >= size + 8
> pool-selection guard.
> 
> The hypercall path (spapr_vlan_add_rxbuf_to_pool) already enforces
> 0 <= count < RX_POOL_MAX_BDS; add a post_load hook to
> vmstate_rx_buffer_pool that rejects any stream violating the same
> invariant, failing the incoming migration.
> 
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4147
> Reported-by: Lazymio <mio@lazym.io>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  hw/net/spapr_llan.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> index 550848307d..a5b8906849 100644
> --- a/hw/net/spapr_llan.c
> +++ b/hw/net/spapr_llan.c
> @@ -800,11 +800,29 @@ static bool spapr_vlan_rx_buffer_pools_needed(void *opaque)
>      return (dev->compat_flags & SPAPRVLAN_FLAG_RX_BUF_POOLS) != 0;
>  }
>  
> +static int spapr_vlan_rx_buffer_pool_post_load(void *opaque, int version_id)
> +{
> +    RxBufPool *rxp = opaque;
> +
> +    if (rxp->count < 0 || rxp->count > RX_POOL_MAX_BDS) {
> +        return -EINVAL;
> +    }
> +    /*
> +     * bufsize is compared against a size_t in spapr_vlan_get_rx_bd_from_pool(),
> +     * so a negative value would compare as huge.
> +     */
> +    if (rxp->bufsize < 0) {
> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_rx_buffer_pool = {
>      .name = "spapr_llan/rx_buffer_pool",
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .needed = spapr_vlan_rx_buffer_pools_needed,
> +    .post_load = spapr_vlan_rx_buffer_pool_post_load,
>      .fields = (const VMStateField[]) {
>          VMSTATE_INT32(bufsize, RxBufPool),
>          VMSTATE_INT32(count, RxBufPool),
> -- 
> 2.55.0


Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>

