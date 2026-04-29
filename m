Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FB8FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDs7-0008FQ-4R; Wed, 29 Apr 2026 18:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDs6-0008Es-43
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:59:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDs4-0007h2-Id
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:59:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbLR71809066
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7/zzbMxOk1yxq7dP9hjtMFr3UxGUCq5hGmHFx4pTG4Y=; b=GyKNp31cqZJeBoGV
 2lcHb/NsNMhzC6zkpr7PmMHc6YcodFhpzbCmhnWSqg18RydsE7f9CMcLEjvsIJ+O
 WtMIM31Yd6vt9txRgIv/3HSPXSwG0ZxFUTKdDCciZZ3ijeSHDraVKBcG3tl/9l3i
 9Y7P25GHYX5sCjkpjbR5ptP9ghmOlNUkcSiZsvFQ8LVNpQZbVprjkRQMw+kefBly
 ZATiJFQXY+rje6vZrfUH6Xwof0HPOBh8KTeWUWjZEE23tocha8gfEF3VfpX0dhiJ
 QMQsTOQehJlXU6N3VP8DNAiVnlp47+ko+zWR5MFnPUjeYIgKXrYDi8YqPIHanjZI
 ehll/g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duj6ta6uk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:59:07 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c726f4019so368609c88.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503546; x=1778108346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7/zzbMxOk1yxq7dP9hjtMFr3UxGUCq5hGmHFx4pTG4Y=;
 b=EMKNGk6/ErWK49j5PQ51RYEK/jcXKfLu95yokAP+zFZDkvP+/SkSjld3RFwk/XTpdV
 huL26eVlKIfzIp+d01lmP0ZlRKfOVxYEOTJZEtvruqcRYYS+gSonVmdkYuFLQeI+W0Hb
 o4gFNAgSvhOxGmcZZmviup2s8DgP+dixcg4cRYaD+Rz162Bx1FGNIOIDl+Dzj6q/vN5o
 FohtNLJhPEmvuTiflyVPjdVw+p9rEgPWLsb+BspcgPRSr94Lq7V7YibsBNVzXLolG9yf
 6eNr5bR5RH7QocqDOC4A723FrEknJ7V1fA6eo68PltQypol35aetBG4KK5eqLnsXHsHC
 X++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503546; x=1778108346;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7/zzbMxOk1yxq7dP9hjtMFr3UxGUCq5hGmHFx4pTG4Y=;
 b=oimuTxRp/R8H020Bmtf6myjNeP3B4N+uh+VJteuWiXJE9VXq3ty3vbeVUEFuUrQUZG
 LWHCyDekuBNixGOEpX7W/O+34tqcev1tgcvZHUD2SmiXDJzHOrscskmo4xOVhg/HfB7z
 J1gRBZZTUgDSFbNOE2Ohpn7JxJ2Fs3X3Kw+0t8VXvFWAL65bRWBvuptgpGNq/oSa4A5u
 wOMzw78JhmfHkp389x6c+izfOPeIIDkIzVkZFWGHVR2qtvwjOG17e6Z13PdXJe6xS9gn
 vyLtbliwRS5t6sqQDmT5/WI3dtknLxyp0COuRM6kHPL4f69j6TPklc7nC4nv1nNjaUdy
 8K+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9EV0Q+jCLM1xMNE+WAd3FA92PTX6WJp+YM0d8aKCeVQLnwerMOR0pjNSRk7sbL5LlLwf88M0pIg242@nongnu.org
X-Gm-Message-State: AOJu0YxJbrv65jSRbh9gI+TkEEpVS5LL5ELa1pwJmArHLpM0bGh6rXFP
 wfJZ8mtInN1/iib/chS0fFRoM0CNDu8V6ldXRkkPCskiX+TZePUw88XJLUx9Ev6y9tYKmNFNsyU
 W+l+Sw9insmdDv2pTPSUYLkUmTnU5v0TWdXcoOvRYHdBD0VQ1bxOkCmWZ27PxvWmq667t
X-Gm-Gg: AeBDievUPzxlcE36k2TlpwR2dALv1rMvXWbgKMQ1MvrzDRTBoahjFgTp4wqbY4P1XLH
 7EF8r8S85ogGQpbKJad05Ja6Ude4xp5GYfU7rvVwJabZnri/BrZ1xLY+c+TRb7gohJxeXaWKYPa
 r11p34/Efy4Pm/zUr6wEr28Deoo505ooYGYIKDEM7vLUGJn/YtdB4COXUJ5IoeeCDVT0LXyBxZW
 AoA1hlsFN6Wz7YF7m4X0zPvfl4gMM+w2RuhBmtDzO21WL/elStEkyvjSBwQVHjQGL6bkUsrboWA
 iIpin+jPIlUsqCnrNf1q+6KrBOu7ox29yBy+D58kcaUH2HphQEARx2/k080jazI8qaeNEFEXEgI
 KuC1bz+gD/XCUI9b2riHZOIDiLHxD50KrQD1st/ZYewK77Q476oLfcg2A/Ur8NME5c04Q2AqhF8
 lxBfpXcgHmCj7dFviQR8GsgWpG
X-Received: by 2002:a05:7022:6707:b0:12d:b552:e22f with SMTP id
 a92af1059eb24-12dea9c7ab1mr281822c88.0.1777503546284; 
 Wed, 29 Apr 2026 15:59:06 -0700 (PDT)
X-Received: by 2002:a05:7022:6707:b0:12d:b552:e22f with SMTP id
 a92af1059eb24-12dea9c7ab1mr281809c88.0.1777503545707; 
 Wed, 29 Apr 2026 15:59:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de320ed98sm4754395c88.3.2026.04.29.15.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 15:59:05 -0700 (PDT)
Message-ID: <e616496e-b4cf-49b4-89a4-11914c5f955e@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:59:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/17] bsd-user: Add FreeBSD IPv6 ioctl definitions
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-6-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-6-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ONUKP9ugH9YuzfHYvoCdhP_R2QiY9AWe
X-Authority-Analysis: v=2.4 cv=KcHidwYD c=1 sm=1 tr=0 ts=69f28d3b cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=igV55USxk0bV0TlUbZYA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-ORIG-GUID: ONUKP9ugH9YuzfHYvoCdhP_R2QiY9AWe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMSBTYWx0ZWRfX8M6ykXDLw2bD
 zMHsDwgBU6tIjxSOKGt6o6ChOzeKr9pG5QzXvZ8IgsCufBV41rb1AahYGdASDnLz4FhnnsVH0Zp
 yuvw7DJiOcn6gbkHPItuoQTiBqdVMHJmpHcsLmYhaD4uyafx42cxnjC6vZ8wNOjh4uiUMbRdjtO
 oErMxN9WPNI9g6Dp2J21Lgaejg87ve87IAbEvBtTCDyXHEdezhGn+qwTR7k082knmLeKK2cDuQ6
 jV6ByNx8JM2s+7ACzWnHfhtj241OCtrnsiHkn6uMa6Yc2iKd8z0SoFH+FWzlUhaIpsRhCDGTpG3
 lvTjV0Ut97eVKEjN5fugKMvySu5gDlA9Yr2162QLp1UallWnvqgfpUaIMTf9AWATqjurq3q0OV9
 e6QATAkJbrwM39VsZ6O8clxwzK3UMN+PaS75wtlUhkAOFXKEsgUBTQ3iIPLJf3JXRbIvdbaoIHM
 zVInjwf/KfESrinrtTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290231
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 4/29/2026 7:45 AM, Warner Losh wrote:
> From: "Stacey D. Son" <sson@freebsd.org>
> 
> Add os-ioctl-in6_var.h with IPv6 network interface ioctl definitions
> including SIOCAIFADDR_IN6, SIOCDIFADDR_IN6, and related IPv6
> configuration ioctls with target_in6_* structure definitions.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/freebsd/os-ioctl-in6_var.h | 217 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 217 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

