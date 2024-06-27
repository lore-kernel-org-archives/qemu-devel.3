Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C949C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 09:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMl7C-0005pt-SM; Thu, 27 Jun 2024 05:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_asalama@quicinc.com>)
 id 1sMl7A-0005jP-DT; Thu, 27 Jun 2024 05:08:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_asalama@quicinc.com>)
 id 1sMl6v-00058u-Ht; Thu, 27 Jun 2024 05:08:24 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R0OMKm015158;
 Thu, 27 Jun 2024 09:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SgutWFQ5xizB8FZae9vq8wbziDGllkdv1mj9mgHIz6s=; b=MojdnZIf3drhoKXy
 8OzzMwK9TczGTIE55vT57qjdP1bQxQyORfPZ2F+QHCN9o3/XSI78RodW/kZapxUL
 xSm45rKvDSccmiwcC11WYhU2D5/4GsosaIp/cK0oahRxI/khcLJ9qE38DujQUuP5
 rDwYAl8bEnWMweqmlF6dxRWasptvV8R/lNfEReQ9WuLML7zphgf+CsL3oR6K1sr0
 3MzCBHW3OCXTVdntbiug6jFp1f828tUy9p6xY5pE3w++I/Li9FfBrFxNkkvzkhRg
 Y56i2q5W7rJftw5woPTbStYCReDzTRMl/LYuPr1OUV+3rzACS7Gi9yIAIdIHWgc3
 GADP0A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqshv1a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jun 2024 09:07:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 45R97owY005528
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jun 2024 09:07:50 GMT
Received: from [10.251.40.202] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Jun
 2024 02:07:45 -0700
Message-ID: <c42e7684-048f-437d-86ec-17b9ed0ad604@quicinc.com>
Date: Thu, 27 Jun 2024 11:07:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] plugins: fix inject_mem_cb rw masking
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, <kvm@vger.kernel.org>,
 <qemu-ppc@nongnu.org>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jamie Iles <quic_jiles@quicinc.com>,
 David Hildenbrand <david@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Mark Burton <mburton@qti.qualcomm.com>,
 "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 <qemu-arm@nongnu.org>, "Laurent Vivier" <lvivier@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, "Ilya Leoshkevich" <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 <qemu-s390x@nongnu.org>, Cameron Esfahani <dirty@apple.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Nicholas Piggin <npiggin@gmail.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, "Marcelo
 Tosatti" <mtosatti@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240620152220.2192768-1-alex.bennee@linaro.org>
 <20240620152220.2192768-12-alex.bennee@linaro.org>
Content-Language: en-US
From: Alwalid Salama <quic_asalama@quicinc.com>
In-Reply-To: <20240620152220.2192768-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: Tr3qpDV8DfKDFF0NjTBs1M5ySgj49JXq
X-Proofpoint-GUID: Tr3qpDV8DfKDFF0NjTBs1M5ySgj49JXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=933 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406270069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_asalama@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Alwalid Salama <quic_asalama@qualcomm.com>

On 6/20/2024 5:22 PM, Alex Bennée wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> These are not booleans, but masks.
> Issue found by Richard Henderson.
> 
> Fixes: f86fd4d8721 ("plugins: distinct types for callbacks")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Message-Id: <20240612195147.93121-3-pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 4 ++--
>   plugins/core.c         | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index cc1634e7a6..b6bae32b99 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -240,13 +240,13 @@ static void inject_mem_cb(struct qemu_plugin_dyn_cb *cb,
>   {
>       switch (cb->type) {
>       case PLUGIN_CB_MEM_REGULAR:
> -        if (rw && cb->regular.rw) {
> +        if (rw & cb->regular.rw) {
>               gen_mem_cb(&cb->regular, meminfo, addr);
>           }
>           break;
>       case PLUGIN_CB_INLINE_ADD_U64:
>       case PLUGIN_CB_INLINE_STORE_U64:
> -        if (rw && cb->inline_insn.rw) {
> +        if (rw & cb->inline_insn.rw) {
>               inject_cb(cb);
>           }
>           break;
> diff --git a/plugins/core.c b/plugins/core.c
> index badede28cf..9d737d8278 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -589,7 +589,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
>   
>           switch (cb->type) {
>           case PLUGIN_CB_MEM_REGULAR:
> -            if (rw && cb->regular.rw) {
> +            if (rw & cb->regular.rw) {
>                   cb->regular.f.vcpu_mem(cpu->cpu_index,
>                                          make_plugin_meminfo(oi, rw),
>                                          vaddr, cb->regular.userp);
> @@ -597,7 +597,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
>               break;
>           case PLUGIN_CB_INLINE_ADD_U64:
>           case PLUGIN_CB_INLINE_STORE_U64:
> -            if (rw && cb->inline_insn.rw) {
> +            if (rw & cb->inline_insn.rw) {
>                   exec_inline_op(cb->type, &cb->inline_insn, cpu->cpu_index);
>               }
>               break;

