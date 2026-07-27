Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133C8C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woLaa-00086m-Tw; Mon, 27 Jul 2026 09:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1woLaO-00083p-Lp
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:41:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1woLaM-0004N6-Ku
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:41:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RAMRca3594238
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 13:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vCgvsW3zteO
 hUG1qOBRs4a5Qp3bLSzSaMCSOTP4Jr5M=; b=NfdX1oizaoawpKhx2rwq2AOQtL4
 auO4i/g2J3sZ1m43m5lsLIeGyB4JzCgA/HihmQ03OCsFctxpYdbdNRKCJdin0JtX
 lEBuiLl2eJr3ZFr5wlkB59SNbNhUoBYkLfzKS1V/D55m/13VMjprMeLA+6W8XDRR
 HZuH/MBdLQG9N3eKfnjvRyk0iMq+33heQ23AhzKBpt9tk4CSsppIqJbqs5fPakM3
 dPjHDlWIh0DuW/jq4Koyiu9yEOrpOZ31MbjL8hUb5AUclEmlf8obntYsXOFI0wER
 aQ0wj8ACbb035AsPM7wZazX6w0DT9MNe9JJccJFRzWNHkge+hzPL0RzVwhA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4mq0y9k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 13:41:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc5faecf01so59186675ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785159695; x=1785764495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vCgvsW3zteOhUG1qOBRs4a5Qp3bLSzSaMCSOTP4Jr5M=;
 b=dJ2lS/Ul+zeM0EcvGw01mQb20+3OsZEowDm6CbXbmU0Es9ovpnr1PNIRbR9IuFK0bT
 HIDWcgKam6xHwrgtY0p2ff7SnwRmqz0/d1VAjExNNvu4vuzA4eGS0fxTtmN1QDjiANxv
 gcUQjHgJD+lFm0CHkPToRz/4JzZw5H/Prbnf6ZQ2UJeEXqWV1ZpZVDKvEWb/VjnqJXGu
 ejMjfiAe1ARjGML05PdQHTFbFJHEvtwfa9vYQbgVoQdh65Try82VETi0JOYNtd9rm7xp
 8p104e3/W5F9fJPsa4iw/zQ33aRckcBdkIInR8+zJE6mOfdR0jcYe9JqCOyE/tpt/dOz
 3j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785159695; x=1785764495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vCgvsW3zteOhUG1qOBRs4a5Qp3bLSzSaMCSOTP4Jr5M=;
 b=jQDDI1aP2ydc3Ds389v/UbeaKtvf7/nISl8CFBueNrgC2bAn0W/DxRaT5gZxtcm+k1
 lt6n2pkiQrFwm4gZshnuguGD2MfPqb9aiOh6neyArCEpxOjVRKFZLibiL9FeuHcwbxwj
 Ue+l3etPRxZusUCPev+1SBxOkEaX9aspv+ARRn7zcdIc9yREEdhCD5edjX14fuhQcR4R
 gtQmcEmvW10mSd0msAvcY4GTi7NDii92T5OIgp8bbvgSwzl+UXrGh9B7+oip6MgT7eN1
 bBT+Fv9D8orS4puXppspv3z5wLc0Y7Luy8gc6eZ4smrK4gPK+sITVlJ/ouL5DtH3KNkm
 GIKQ==
X-Gm-Message-State: AOJu0YxPAg7vpDnj8/2upZ+9j68I+uZP3eAQEUm0owb3lHTNCnXMWjSt
 MtvmHrwoJgdB0Xo6ehScxM7o0h39vfcIN9TFqTS7Os+gnKiOsewNCWHj7SQm2RvHwBhTE9Og3bM
 HpTqf+Vces5ZkjIEVlP0bICvU7McT+AAhziYpQuglS4jm8KxOzclnMyjInw==
X-Gm-Gg: AR+sD13kgOYeq83K5p4A8jydW35/H6TDLQqw/Yooc4ghOESNiSjbM7Krtbip+yXLWde
 8DvIx6yk2u+nCTI390O62MUl9ZiGMU9ade0x9UtIoMFT2sPKKMPgkK09+vPNCEd4dx85qb9tmEV
 ZlorlBndUCaYCUad0iCAH5yKcaQzVaajkY+qQ+ihTR4zcbyC6a19/Otw0kZIwhCbbL2qRrxelkJ
 z5WkkcSIeVw4SdrSYXVHydLyIyRvI+IiZmxQSSvYyGlOLkxApfx+mNVj/JPxrK5znrO807NtDmC
 TnIvjuykuVIbM5RWOkuHjTSGRqLYpRjPJBYDTS9SKB7QINXaeGMcv4bR8uFJ5Y1Nr17TxRY+GuL
 a0B/aQFPzvJEFRJmwIUOs8MtDzYj304pqXjGtj5zCaMWXNLfpqQT3EVcY0ebTMQI=
X-Received: by 2002:a17:90b:1c89:b0:38d:56aa:6f32 with SMTP id
 98e67ed59e1d1-38f605ca79amr714869a91.38.1785159695036; 
 Mon, 27 Jul 2026 06:41:35 -0700 (PDT)
X-Received: by 2002:a17:90b:1c89:b0:38d:56aa:6f32 with SMTP id
 98e67ed59e1d1-38f605ca79amr714836a91.38.1785159694285; 
 Mon, 27 Jul 2026 06:41:34 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc5a04b2sm30036965eec.28.2026.07.27.06.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 06:41:33 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com
Subject: Re: [PATCH 1/2] target/hexagon: accept valid packets rejected by check
Date: Mon, 27 Jul 2026 06:41:32 -0700
Message-Id: <20260727134132.2615852-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260724171845.78440-1-brian.cain@oss.qualcomm.com>
References: <20260724171845.78440-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzMSBTYWx0ZWRfX/1fuSjkDWpUP
 WkmMiw/8UCUBpU9j5DLioA2msgm9QVbnQUhEc8OXh0ep4LfuX84kwpScZo7dpvQLFGzbbLIsfzE
 Y/d+Z19zMCXW2Qwcj451hMF7jcfciKQ=
X-Proofpoint-ORIG-GUID: UrOnVJiUnNaCNJbyBPlDnM7cTl0MCMkg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzMSBTYWx0ZWRfXx+WpcArXVdS2
 uHi/+BXQ0ILuDiQaSlwIGzPwAmkxvokmA+EFKefeBWbqeEZueZAzNv1dTuEH/QscI6hpNz6T28d
 If3HvXRjx52iuOFz6j5iwYnCddGuOKdMDOaIPM7dTG+SsVGuo3ggrJ1/bWpboKRU5QsFti3B7zf
 XC/jxBs3gM0fCKjBspWMyIaV89s5QjH9Nic0e9hKaykqcSl087VBv98TankOcOJA4WZHOfLpkIf
 WjGpa+xLqcX/9kLTFJlM2aZlJ5llNmVMF2u5xz46GVQHNqgyIY4yxKcg58flwjiZfdXHTjCG1vj
 KYabNpDlWxh4en60Uj7ZQUZLKsEe7W7IdQMHi+O67UtLdt0XoXOb/FkF9PSFzzuD1aBGvM9U8a2
 rU+iSGdGfytUZqM/+7OCK7tPww7/pWG5sPtU4khtA2gV3MmPUpBAxkV8oA37xjr9JX1sqIo1NTG
 q6pIGLfz7frBQ/Vg6zw==
X-Proofpoint-GUID: UrOnVJiUnNaCNJbyBPlDnM7cTl0MCMkg
X-Authority-Analysis: v=2.4 cv=TemmcxQh c=1 sm=1 tr=0 ts=6a676010 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=GootsNMVz1RDxwtCn9EA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270131
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On Fri, 24 Jul 2026 10:18:44 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> has_valid_slot_assignment() rejected any packet with two instructions
> assigned to the same slot.  That is too strict.  When a memory
> instruction is encoded before a slot-flexible instruction in a packet,
> the descending slot assignment places the memory op in slot 1 and the
> other in slot 0, then the "mem insns to slot 0" fixup moves the memory
> op to slot 0 as well, leaving both in slot 0.  Such a packet is valid
> and executes correctly, but the uniqueness test flagged it as
> HEX_CAUSE_INVALID_PACKET, raising SIGILL in linux-user and a precise
> exception in system mode.
> 
> For example this packet, with the load encoded first, was wrongly
> rejected:
> 
>     { r6 = memw(r3+#-4)
>       r7 = #0x4ae6 }
> 
> Replace the uniqueness test with a slot-exhaustion check: walk the
> instructions in encoding order handing out slots in strictly decreasing
> order and fail only if an instruction has no valid slot at or below the
> running slot.  This accepts packets that legally share a slot while
> still rejecting genuinely unassignable packets, such as a memory
> instruction grouped with a duplex, or a load followed by an instruction
> that requires a high slot.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/decode.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)

Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

(BTW, apologies for the repeated replies in the second patch. I had a bug
 in my setting here)

