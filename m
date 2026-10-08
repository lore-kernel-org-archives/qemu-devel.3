Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BC4CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 02:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEe0p-00013z-UJ; Wed, 07 Oct 2026 22:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xEe0p-00013F-4A
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 22:37:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xEe0n-0000mJ-FX
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 22:37:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6981hO6Q1430961
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 02:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MBY+aIIaAzpXS+KhuooLDIV0TmBRduUNY/3VyE6ugsM=; b=eeRIQYKjKUFci728
 Mzaq+lRC+SoKe/YZo5W9vX62QeWEw0z5vOcVdL7b44lCpVFEG7SlWpFnDVGFthqn
 d2yYvzWhM+iTFl7/9h+icqLcM9sp7aj2iECqIbEH9E2FR/cgQqhAhxy5EMIw9YKN
 izEEQbQRobcrbp5qNKdackj9aLx3BhDd+Dxgp+nLLWGBLMR4M9cewjzrMW4QCjCK
 qEwtSlwcZqDTvdQE6BL9uGSUV/no3hl6RF0vB3Lo84taRdDrPXI5CkE7Uy7Q91mE
 Hhv5rgkJP0oOvuCke0ZZzMPjgEHmuMKHR9QIH+qgxS/y+LNNRpthlNU77pzbT8gS
 eredrA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2rvbx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 02:37:36 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9179743a76eso7303736d6.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 19:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791427056; x=1792031856; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MBY+aIIaAzpXS+KhuooLDIV0TmBRduUNY/3VyE6ugsM=;
 b=BsxYFEnvInZ24bz4eW0lECXItoSudsFlmBRSuPBCE7kJP2y2MtTNo2N/dSaB/aZkun
 rJx7BxNomFB7Eu/2Iw7j3Fob3QiXb+w7VL8mHFcEScn7NgUr3MSC07SppZCeoKcQ6n/v
 HB3eQgYGHNrXviofIcZpc1FW+fHhjIjwfCw+jYIQ7+2VfLBizo/tnu8scL76cm/9URJo
 r3EXKTQEMkM+m5qZaLq2/Tm+w/OvpnSExWu2OVWlyBNe7hgvPJigaEnklhSmKNtV6iSS
 xiY+/A0nRYMGi0AjKnMHKfdVlDhPNTcAt3xev8/KTBJNaY+bQxA+zA1sNfJ4tfkYUpA+
 reuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791427056; x=1792031856;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MBY+aIIaAzpXS+KhuooLDIV0TmBRduUNY/3VyE6ugsM=;
 b=QYSvVSSOybfbdfx1Sh8xHGIxhi4kMtRLU0aZM0sbuJlSw7M+DqT0ibsdwRBVkwSna8
 cCuONX1D4tkLseY3uvFaALiNRDRXT0EbEcLljX65vnRYbs+stNdEdkZsqDNlnmi99NO4
 Zw/9ZS8Om6EeQ/nCO3uhH9Z0UCiQamBevx+UHUYEZjCUULanut2gG5yBOITRWzciAqOz
 7HYpj7Va41wVQNoFx3JvslHT6fzqQlOJ+ND/caU0f2a3kpYkl1F1D+47I7bbbNqSjkKu
 GYQocOWzedlGEtMknlZxR5BT1KtBklwH0DDr4UEscXJrZrvZ1ZZ/STZ5pexrfj9SI33m
 DfAA==
X-Forwarded-Encrypted: i=1;
 AKwUvByMLoYqS+BMeYV2b4nrUMy4rxqeMjvIKzpTx3B4qh9MAqB7DyuAMTbmvztIdsMBFHht9TeA9qUq4KWU@nongnu.org
X-Gm-Message-State: AFuF++mr4YKzhJUYhKPjyROoZ/yEt3Cb5Z7xGCGw7938/2FLv4amsSqz
 lSLfGV3nkTxjTu8AKEXplm9tM9jHnuGw86yG9WXRlXLLy4zrixa6H5d8DzkhUlJpij1gI437DhO
 pMvnyyoafrvbfUke6PgJd4kttCZF/E42HNtkxSaZxf8fGbxM7wGNgH5WAiw==
X-Gm-Gg: AYBFou2PchSMOkRgGYEHkg6Sch7202uc3Qt1Fjiu+QkbMj5rNTQ0GiU/MyOFuUatWqo
 bXCEAzEVZfF4lFT8/UwWbV0jVfDZpg3wjSp4ROf7o7EW6lTU5t2QiNU24RpZUd7deUbRKqOBtz/
 +G+T+JT0V4qjlEWRJrupcEc3VIeht+50Gnb6KL2GR7B6DjxM4PFZbEDIh7B5jR2dbIg+AxLUN1K
 FIE631xyYBSAF2a1FC+bKzRs3YqhqZqX7M9BWF2lAsck17LPgT/2md4TBxYK5V5tDKPLqAO5dFx
 toOdU6xk/PSi1XT1uin2xrAVaqSlLcDrgf9QJL+DRdMQ4apfBUz6ERCx6Ke8s9S+mvyLA2nPljr
 4ZzGCkjQSFIGJ7WCiU50Noe/SihguxUBQ1eh4
X-Received: by 2002:a05:6214:3018:b0:917:99d1:bda2 with SMTP id
 6a1803df08f44-919aa745d0emr19526506d6.8.1791427055598; 
 Wed, 07 Oct 2026 19:37:35 -0700 (PDT)
X-Received: by 2002:a05:6214:3018:b0:917:99d1:bda2 with SMTP id
 6a1803df08f44-919aa745d0emr19525936d6.8.1791427054210; 
 Wed, 07 Oct 2026 19:37:34 -0700 (PDT)
Received: from [192.168.10.208] ([185.243.168.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91997d66da0sm32830486d6.39.2026.10.07.19.37.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 19:37:33 -0700 (PDT)
Message-ID: <3913a329-c79e-4bff-a66a-ff6619e3539f@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 23:37:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/11] target/riscv: Implement SMMPT fence instructions
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org, rahul@summations.net,
 xiangyi.zeng@linux.alibaba.com, cxx194832@alibaba-inc.com,
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>
References: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
 <20260723200325.24969-6-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260723200325.24969-6-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AbMkjHXG c=1 sm=1 tr=0 ts=6ac701f0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=Adc43iEMMYzOb2FTIT2GVQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=O0VJlaFw4OW4KJ8IkpEA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: wEUr6UkFTedXqoGT8xLzsSAq9ptsK20O
X-Proofpoint-ORIG-GUID: wEUr6UkFTedXqoGT8xLzsSAq9ptsK20O
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAxMCBTYWx0ZWRfX6X79LkOuIdlT
 g0r9hJNZktRvtmZxxB7BDYtrOMbwOf/GPnIr0AIKnffeg5qhal8xF1pdy5PvnwKXpvEipN98UqS
 tG6y0zN/kUIYTdqtPCYvCw3VP2yf0wo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAxMCBTYWx0ZWRfXw+OjZp+omv6F
 UT4GAzANB2vt5jGYluUCEYaFupNauzoZvjKVB/5YEyv2NlbgWJT+IYmXB7g/8eb5csNb1YAmQOV
 6A8aSQnozX8XT813zWp1GiBtinm2I6auIL4VNOdeP1+nAzHhun6YDsQ6mZjpbQhZKNalAXhy7DZ
 dFHy0+FYmgIZoQQkJl43WzXKWKyDpv47TK/z/KApiB5sMnteRFTBQs2KWK6geOn88ahnn/ayK9h
 4tByP4cDX7Xf5E0FslQUS9bRa3GyGYOVJgAc61epzAQO3R0ORJvN9zi0e4DCGzC55RPuGoPzIsR
 ahIY6mpoc3w9y0RLhxODlTwB5ZkcpUU8IO2V7mgGssw0E9ovDYWDZukjbwvDYAtFQ8opCeC6cwU
 U/W8jQLYLHlRjYPjI7UGd7cQbFdOCNFktQs8JJmP7nGF5Dz0SHVdNU95/gY6CCCX4uXb1LSD1nc
 Ux9cV/XVvpfWo3bYFhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_01,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080010
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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



On 7/23/2026 5:03 PM, LIU Zhiwei wrote:
> This patch completes the SMMPT implementation by adding support for the
> new fence instructions: `mfence.pa` and `minval.pa`.
> 
> According to the specification, these instructions act as memory ordering
> fences for MPT updates. In QEMU's TCG model, this is conservatively
> implemented by flushing the entire TLB, which ensures that any subsequent
> memory accesses will re-evaluate permissions and see the effects of any prior
> MPT modifications.
> 
> The instructions are privileged and will cause an illegal instruction
> exception if executed outside of M-mode.
> 
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/insn32.decode                    |  2 ++
>   .../tcg/insn_trans/trans_privileged.c.inc     | 30 +++++++++++++++++++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 21272fdb50..f0917b7696 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -120,6 +120,8 @@ sret        0001000    00010 00000 000 00000 1110011
>   mret        0011000    00010 00000 000 00000 1110011
>   wfi         0001000    00101 00000 000 00000 1110011
>   sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
> +mfence_pa   0011001    ..... ..... 000 00000 1110011 @sfence_vma
> +minval_pa   0011011    ..... ..... 000 00000 1110011 @sfence_vma
>   
>   # *** NMI ***
>   mnret       0111000    00010 00000 000 00000 1110011
> diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> index a8eaccef67..67f2e56034 100644
> --- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> @@ -160,3 +160,33 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
>   #endif
>       return false;
>   }
> +
> +#define REQUIRE_SMSDID(ctx) do {          \
> +    if (!ctx->cfg_ptr->ext_smsdid) {      \
> +        return false;                     \
> +    }                                     \
> +} while (0)
> +
> +static bool do_mfence_pa(DisasContext *ctx)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    REQUIRE_SMSDID(ctx);
> +    if (ctx->priv != PRV_M) {
> +        return false;
> +    }
> +    decode_save_opc(ctx, 0);
> +    gen_helper_tlb_flush_all(tcg_env);
> +    return true;
> +#endif
> +    return false;
> +}
> +
> +static bool trans_mfence_pa(DisasContext *ctx, arg_mfence_pa *a)
> +{
> +    return do_mfence_pa(ctx);
> +}
> +
> +static bool trans_minval_pa(DisasContext *ctx, arg_minval_pa *a)
> +{
> +    return do_mfence_pa(ctx);
> +}


