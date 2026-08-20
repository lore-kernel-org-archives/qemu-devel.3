Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CADC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx7i3-0002Fn-TQ; Thu, 20 Aug 2026 14:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7i2-0002FU-2Z
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:41:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7i0-0003bj-Ha
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:41:49 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIJLa84117958
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wXbHRLqjtWrsIyLcHCnkHFuESpX2Z8aVxrx+Utk1Jjg=; b=dIzv5kyXpURxprR7
 MKj10Ov+/AjR2C4F3o3oMQrd3UeWriKisE2xm3MUxCIa8x7ncDKZlH+3yxe+UpS9
 kUPYfRyqn408/L/dDr5QS74EE1skZl+xHCZSZUI8H0jRwwbvQ1kSUDTgCcxdbu8/
 4B19w8F7cJ9sumLz69MFlAYTlq1LkaFw8lzm//A0j7P+PTfD9Z8isMOWfDdnurzQ
 h8FwpZLxZAD9po11XJ/Vxw/coAhIuUI70cEIbXFYCHb4hL8FPgkmAzFERk5gWli1
 bWVsU8CXWamrBOPVEUCNoC5XfpXk+vJ6qHEefR+krGfWWYfbAFSd6UUd/5iH4Mf9
 7brPuQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xuk2fb5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:41:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cce14a21faso1122135ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787251306; x=1787856106; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wXbHRLqjtWrsIyLcHCnkHFuESpX2Z8aVxrx+Utk1Jjg=;
 b=ZXThKdX8O4wb0HmvvE29q6r3CZzFbSoXyasum5xQ3KEe96+AOtok9rCyuV315oesAZ
 k7bAAVrUnZbWVP4tP6hwHTQZI6q3g6E6Qr1sDY+DEgGhEbRyXjl93A1c257Y7M12TSCP
 JtskYgwODcBADJ+gRzBhXHUbzYSQeZLaiGZ0gBWE4giVZ07wvgaMr/cG4wR6lFggJmW3
 m5cZtPSgaInfcHj+oq4GXRu78b87K4AxQMkBEFK8Ufd44UK5ageFadLOOitgHRcIEw/h
 mWc4vKbX+9GSgq+iSWXSN/mm6iqUk50KM9sL+Ca2t+EAPLie3S2jrRqJtNkybAKw241h
 KS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787251306; x=1787856106;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wXbHRLqjtWrsIyLcHCnkHFuESpX2Z8aVxrx+Utk1Jjg=;
 b=coGoawK8XY2pNI6aPmyhydDyy18FlajRsGdTXLH0aUhqA42P6Z9SLboE+SJa8bfHBG
 UYC2BgopAbuiGOyuSWDvp9Crl6MSQwFJrvlFLZdzzojncR8Fon1EDAgvrA3mPI8Gosu3
 wFTqpfH4tXONVVTuRHjz6GhtsdahwSgZIXtjScTwK6AFphC21vonV3YB/uW6ewDEHtaI
 UT62B7zJgYjCfdP9xDcPcfNEMJdT0M7/n6ANrbKJzITGKx6oc5bGtCmO69p8MZgNkHcE
 B8/HxihbslBE5lXD+9+cn3oszbyQTwPNth+wa6DInNEfgf595Z06Jwin38OXuvI/3pB5
 i7Qw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVXBPWaJiJgH4gLN3smxJ806HgkeGp4OISHwx8jeIs7hNAqXO6mcxPOobiH4tN9JGrTqaHxmvZyhRA@nongnu.org
X-Gm-Message-State: AFuF++kxvgxntiRK1Wh2HlN6+lo2u9lB5HrJYAF6Z/acjzhG7cI9z7ph
 0+i0HTEoWE8J5ngHNTbdFutPWCbXiaf5ieAEcndiVSybYMxq6rKEkamunkq0zK9FvzeGyZ3bWwW
 97jg0S7LMaR13k1u0zcZB/iJcfGde1qSLStdjgxKBuwsPw80qFJsZxBxsDA==
X-Gm-Gg: AR+sD12OE+E5cr5hbrVMGGbJMIoVr5Si37CMW8p4E1MPWXuTOdS4F5TXc6/iINqEgo0
 J7J/tZqlwT2kkbu6LCFEOPUp5AsZ+w52yRfY9tPt6TE/QosN9L71AIzC0INyWKzVYoO3TUojVNH
 eyoIaOhcWjtcMd8DhknXqixQ4x/J+f3IsDsZVb1isJZBuOBTSRXnSuzNsQ6nTnYnqPcDUf8qhxl
 tbu3jgBCjXcRo5DDmNCgsAxu0oGnEOkaNfDPF5zq5Lhc98fm0K0T97ipwT27PWyNaJwkuMNaQ8S
 uWHl9mr9Fa8wc3jAr2Uia+gtckKmFZJdVVfVh0K1NiDiWgkZptUSWzwKyrnIrJEoDg++MxLDxuY
 Pni8lbwY/nnFy6Wdy46TaZpUrFGv8ellYaVTikWRW+WfBPJfPSsYnHMPs1XybOyazGfHY
X-Received: by 2002:a17:903:15c8:b0:2d3:c3b:c7cc with SMTP id
 d9443c01a7336-2d61a0308fdmr99996545ad.3.1787251306486; 
 Thu, 20 Aug 2026 11:41:46 -0700 (PDT)
X-Received: by 2002:a17:903:15c8:b0:2d3:c3b:c7cc with SMTP id
 d9443c01a7336-2d61a0308fdmr99995855ad.3.1787251305868; 
 Thu, 20 Aug 2026 11:41:45 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf10b584sm31737324eec.16.2026.08.20.11.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 11:41:45 -0700 (PDT)
Message-ID: <2f891703-e57e-4f3d-a552-13b44de9027a@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 11:41:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] hw/intc: clear pending bit on l2vic de-assertion
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Sid Manning <sidneym@quicinc.com>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260819013144.3264096-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rG-dbEkBRDXU1brLx2LmK2s2OmEHY_bl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MCBTYWx0ZWRfX+bBa2efLFIsa
 YEodcxkE0TviE30HhTUcpAiroTqQmaOkYR7HcBjrDQQHArEvzLcYInO/1bVOVYbt+cIW0MmjwPv
 fYSCYdfBzkRJZfurSlnfWNDp8A9YpgY=
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a874a6b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=kAVW4TL67sLhy5MMfsUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MCBTYWx0ZWRfXztMvmr7YctE9
 9dZV6UgWXFzqU54Zka2OBGCSY08ja9m0U0qDwjQBlb6lU/SD02TgB9HqARbIu+57QfkwfyavGA5
 0Gq4Dcje9kCQazMSz+j5hssgpoRoPMpIG4p+XkJt0dsDSXVzL3EocxVFuWmY1FGpBuhuc14A2yL
 Dke8c1xQtyqI/day/v4nKKmDGoawN/Z4dMsjH/Vnj+mEOqRn/uDYkad5/FXuv/oXTY5VfYpIa31
 2AvWKskxRt+8bh2IWGkB3eTuN8N/P0gqISwOMZcHYWfftSTL9FoXJbKsT6cwx8/E+WqXYUEp+Cv
 wGg9fNoarwqbks0ZLxyAo03uzUIIKe6qu0Txz2/81MYGthI83lMO1cqjqqyfXSEZqL5PEOSwKpp
 yI2VbjOQEu2euvgpMEjt5bs48YF4s/M1tt0gpGafCyVVhHCsFElNYzAyiGi/+CLMola2EwqmgYj
 uYZLZLERuh40DguG0PQ==
X-Proofpoint-ORIG-GUID: rG-dbEkBRDXU1brLx2LmK2s2OmEHY_bl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 8/18/2026 6:31 PM, Brian Cain wrote:
> From: Sid Manning <sidneym@quicinc.com>
> 
> l2vic_set_irq() clears a level-triggered source's pending bit on
> de-assertion, so a source that drops before it is latched into
> int_status is not spuriously re-delivered on the next ciad.
> Edge-triggered sources (int_type set) keep the pulse semantics they
> already have via SOFT_INT/set_irq(level=1).
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/intc/hex-l2vic.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

