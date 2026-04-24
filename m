Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF6CFED3FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGM5X-0002WD-Hi; Fri, 24 Apr 2026 15:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGM5V-0002Vo-OR
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:21:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGM5T-0007zo-W1
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:21:17 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OGuaeN1243958
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H5mnuiuYH5u/5JNOik2RpJhHXCyCum299t/X29xMziI=; b=g1lEgiK+Zq5Dz6KW
 OztpvX85MFyln/oOCn+V8r3/2tRzm3YxvnGoBGS8oM8HAPsHEt5cd7WwT3Mz9wlc
 XNFiNV3Zcb0/AIXwizjyllGsSYyVYaUEF+hDnf5gMr5gHYWkuUYZnNvs0TblL2mi
 lMg2Enj1fM/lt3LJ1cB2oyEs/HOozHcimnrrh/yvp+44/IOY9IIDNDzljhwzNkKJ
 T/4wLS7khgI+lHrarAb7//uIku/AY/JMLZaee5fKFjd9+IAuN35vAx66ew37BoAl
 gY91JOIxOn03PJQIHEOOk2hZ/YK7W3ywBioP7d/T8Bb4aHo+MgvNCvfOY2sot3kR
 xDQW9w==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr48n2uwt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:21:13 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12db218e265so10130501c88.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777058473; x=1777663273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H5mnuiuYH5u/5JNOik2RpJhHXCyCum299t/X29xMziI=;
 b=OE9E1+LYG4BU2dgvmN9e63UCF+zPs1SQQPZ/B1/VGlIn2WhykoPD056jyAx6cmvKB/
 vwne32+MktwymgE1GCPw+18ZkBbZyumP3Ww8f/ctHTi2KIa2THnLH44IQd66EuhaZQJe
 zouCS9HR8pKxub2TmT6ZBkxGAF2rjFzdfdVhTJveTLZoQCgOQpM94huiKqQeBhBVe4Sp
 H32ncaxTtZdO6hQf9/q9ScpJtb9mGxkCeFRG4te/zn/LMt7pbj74FrIlDn1k8xdj5aem
 anVd39WYnD//yRUwvGOasoXELLogs5n/E5SkF7HPHnr+IMPGpipP14BMY92gYFmiOqKf
 cTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058473; x=1777663273;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H5mnuiuYH5u/5JNOik2RpJhHXCyCum299t/X29xMziI=;
 b=iZnzkiLLSIhqzdA2ydS+zF9mNI9k8+a1+7pBYNmEvaG8zJ5S7xTf3G6Q5vM/IKSMNv
 X6+XDr3vUjX2l85UVylNNEo07IllAlgZf6JI9iaqtVKmnVx+P3dNKWEMFWXloiDK502h
 xtA3EAJ+pUMQ6vdhRMgABtYMmlN3Or6OzQSvBhFgukPGtnsjwtCXhVyQZV7c1uAPk2yG
 I3OUvjAaetjWGzUjV5fEt6PESBBIKzkMNJO7INmN+6HdaXfZBU97j2L1h1Rn4m7HmDlU
 xa6RCcKxDt50jxPP52c8lRff3drREW+uYu8jCTeCNwTK4zkvW96qw2EuDUr6Es/IovVi
 qbcQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XM+vdm6vdwA0BXz2M4PnA5YmFVPGZA8Z2GlikDSuUgwklUrflbHQecsG7c5Aj+i/1ll15x9iP11Bq@nongnu.org
X-Gm-Message-State: AOJu0YwHik9QaUf4fa5F2GjBaOeHulbfy0MaAdnrixfy8N3jmK5d0hvM
 Oi7HffMw6LkU1ApD5YV/+PG4stzg+djzQi7Wfh+Q4kg1bQj6r7foiKw9kGUbVhm53/4X9AEzEgE
 K92VS2ii/uncAyZc3bd9UsbLgXjKLWmELVePS3W4yTt4PkTARrPj9q7i8Qw==
X-Gm-Gg: AeBDietdiqzXr0ozyPklUECEh9vechLZ51HDsWKF7sRcAEaT7Agsh+xrMyZD2Gs2spX
 6WZIyG8DraoGDZiHwhpOLcrDtuMbtMX/ocsbvm+lNFONWqWLRbgpGZqkLLraSH3j/wJccxR18jk
 g8yz10fcJCdsTeY3aldqxNI6FVGqytbDBVsCTdi5kt+RV62wWUgXCd8YyY0DovXNGudbDL/+3YE
 TN4jEh8zSV2xleN0Xz4Foima4wUTXHlqpG88+ZPAd8wZglDz+opuDEBl8UmrGgjVFC+bRJXD/Ad
 EVmullMB/7AVu4hCvX2NwWGYSOTUjZ2jVr15FS2TzywtLW8V4qSjzQWR/Gh5UBVDj5SIKe20X9S
 He/MY2Takynhdq/cdhhZPTpngbsQOpVEMCtO+xcIsZL+Zjouwi+Y0EVhjciW0N5cZVoQeCh/c55
 K1cgIIaeOzvjKDpD9YC+XCLZkz
X-Received: by 2002:a05:7022:fa0:b0:12a:72af:83d1 with SMTP id
 a92af1059eb24-12c73f6f6famr19453821c88.11.1777058472662; 
 Fri, 24 Apr 2026 12:21:12 -0700 (PDT)
X-Received: by 2002:a05:7022:fa0:b0:12a:72af:83d1 with SMTP id
 a92af1059eb24-12c73f6f6famr19453792c88.11.1777058472033; 
 Fri, 24 Apr 2026 12:21:12 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c74a20eb5sm42404724c88.14.2026.04.24.12.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 12:21:11 -0700 (PDT)
Message-ID: <8ded2755-3d4c-4451-9d48-642943298618@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 12:21:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] contrib/plugins/uftrace_symbols.py: fix symbols
 reading
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
References: <20260423213838.780814-1-pierrick.bouvier@oss.qualcomm.com>
 <20260423213838.780814-2-pierrick.bouvier@oss.qualcomm.com>
 <tdzmry.259an10v60tlz@linaro.org>
 <2bcd35a4-0963-43df-8d5f-e19d1af16452@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2bcd35a4-0963-43df-8d5f-e19d1af16452@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PRLrUIBIE_41GNWIR1tBizYaTXJSQVco
X-Authority-Analysis: v=2.4 cv=VOjtWdPX c=1 sm=1 tr=0 ts=69ebc2a9 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=EMHajkgkn9fH6kUee50A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: PRLrUIBIE_41GNWIR1tBizYaTXJSQVco
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE4NyBTYWx0ZWRfX717DdHiJk2Ap
 ZFE2Y19puP9noHLtN9YR0aViGQrTGl6wqzNFa4XJuVYiSMX2KOzC+HOoPg2226MxhOf4df+ncrR
 Y/qtT1bJxxJQx/AFIsW7mhXGAuEHZedgw0e7ZZ/EyX00zupMBflr01mOWCuR41uwMCVwwzM4JVy
 rMzD2QcsC8yYICaTsfNUZWPSzs/Npi1laHLZPyQFoPRRpbqvxBb5IfFWPCv7ard2sOfEscZyAog
 dkAVoqYKWk6iGg1B33z0WuJNg7HX6IaGULINMR8Y1v9QAuFhoKJMMg8e3hZeW1l05Zkq39XVSl9
 uQHca7oUXzxpVZnbKIuVEa3h1/ce6lJ830Nr0p0ZQddjSA3WiYhjgNG4oqGvuUyKjAUAN1ToxQw
 bI7igZmXgEdwVLNa0M8mwoBllafw3VAQtHfsvWmV1mfRnVcx9ygyHJ2hyRNJAuCgcwzlCmU4Fto
 xDkvZ9it1iwUjaBJERg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240187
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

On 4/24/2026 12:18 PM, Pierrick Bouvier wrote:
> On 4/24/2026 12:41 AM, Manos Pitsidianakis wrote:
>> On Fri, 24 Apr 2026 00:38, Pierrick Bouvier 
>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>> When running this on hexagon binary, we observe some undefined symbols
>>> without any address or size.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>> contrib/plugins/uftrace_symbols.py | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/ 
>>> uftrace_symbols.py
>>> index 02d1221228c..895fa1a6b7a 100755
>>> --- a/contrib/plugins/uftrace_symbols.py
>>> +++ b/contrib/plugins/uftrace_symbols.py
>>> @@ -36,8 +36,8 @@ def get_symbols(elf_file):
>>>     out = out.strip().split('\n')
>>>     for line in out:
>>>         info = line.split(' ')
>>> -        if len(info) == 3:
>>> -            # missing size information
>>> +        if len(info) < 4:
>>> +            # missing size/address information
>>
>> On a second thought, shouldn't this be != 4? Otherwise the unpacking 
>> will fail with ValueError: too many values to unpack (expected 4)
>>
> 
> I don't expect nm to add new columns, but you're right, it's probably 
> safer! I'll change that.

It seems like python has unpack operator (*_) to deal with that also, 
but I like the idea to force format to be the one we expect strictly.

>   >>             continue
>>>         addr, size, type, name = info
>>>         # add only symbols from .text section
>>> -- 
>>> 2.47.3
>>>
>>>
> 
> Regards,
> Pierrick


