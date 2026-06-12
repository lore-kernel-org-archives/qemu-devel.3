Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8A7CD98D8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 13:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY2Mp-00007V-2b; Fri, 12 Jun 2026 09:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wY2Mm-000077-BQ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 09:56:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wY2Mk-000422-Nd
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 09:56:11 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CCijFF3747567
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 13:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1LwOIeBo/UdbC9s8dFZVqB8hO2nskVmhHNvKYJSl1Cs=; b=VZudbHK6mAnCwive
 SLTP1tyBojW00BJQuHaFqHdtEfzA9agHOxEsIOsr3lYHuAFn4NudCbJ/WXjMU5at
 gcgzCUtuxptLnbhsSx+tgxH+rcHAhwXSdJnidsvTSl1wS81wf232hgjjmjekpuk7
 w24cA1nVYYAqSGtjEX1vY8DSR5UEh1cZ/hJ6jkhxlS7vGAD3P8QG9C8Jo5huZ/2T
 USws5o/rB2IXwaZdQj2kWhIbhGe7mviGIX/suE4wYtxbr3l+9kVKDjWqnlEur2In
 O5elvw9fRx0qCtWYSLk5QpCJdo+tIS9+RBaqA3I/WpyJFtbuLzXrqWA8gori2Yd/
 2E11XQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er76ej2hf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 13:56:08 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6c33d75153dso371452137.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781272568; x=1781877368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1LwOIeBo/UdbC9s8dFZVqB8hO2nskVmhHNvKYJSl1Cs=;
 b=HyiuNuhJ7B3RJBDJ77YEHBlLDiqN9swPFYNQeuQhLQAgIOFUkpchH0/GczkdOe1IFe
 1FWYQ2FQsVn4JNrD3VR4DJN1jnevNqtxmNHK4aerP12EC+GOKX6qoNulG3qTsIMnNrzj
 og9HTTny+X0koOLeNSqjRvvcQ6Ebz97STy/TxoEkVz75izKlfQKVL/jc/YIWGI5MnFw+
 r9Px1isDDpUM2s7I/q1pVjVL3Mxy81pPEVp9f80lPBLF3IZYFg28ZNza9UA9gR3xPxsO
 wMswPfosP9d3ymzcwGzn0dGbfqobOJxc0Kp1XAQEvcN2sneFBC02apDP2RPjbNgI+aJ4
 i0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781272568; x=1781877368;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1LwOIeBo/UdbC9s8dFZVqB8hO2nskVmhHNvKYJSl1Cs=;
 b=EN9TRrZQ+VGAZlHj3ZrdQjEvgMKcM6hc5yNC6lEeFeksQhjkK/uZ0AUji/aJJ97iCb
 UW4yR57SA8Y/L5pKRXGWeNzeuA9xy97qhDZSuZcnCnRC8362+1v7wOZ4B9O+xAJugLH+
 qG3TiFS4h8oBL4XYYgMr6UEwAwxtnfKP75gCAv2oV0CaWGylITGDYENBMVCMPM+VTLxb
 lA2tDJw4ZcE+EI++61DJzshRXk/IECl1xrS+QxwfV/NdxyB3vDGRDDy7SrjzfAXtlTkW
 KfMrugDqDB1TEHlPP5zZ2W49Z2PISluSCRr8VA26+hKJfptFmZAg+rGwaNV0bVBRZisB
 2Cgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ84KKcehE5VJSFK4jYDb41lFu8P6/fe0GOFFMdywZeBR3wBwk+knecPnlQo+MglMLggJqLcYIxbq4xA@nongnu.org
X-Gm-Message-State: AOJu0Yzaif/lUXYI7xBzMcza2fsIeTH2qFZtI3RAGGcOYft2NWtAu+XN
 7ATkWB8DmPkSRfRnmisKWFT0vlg0bNmIjCoAOlFTama0gfEhSHIloi3kXEo1UDty08M99X8EKfJ
 3v+nruE3GrHFWBqkdXloZ+etH3+UrEApULoE7bp6Agct4I95MraLuu7eS+w==
X-Gm-Gg: Acq92OFEaV+9BZr/UTDoBDiN1nPmWcKr4sQ3PyD1Cl1PZkf4biVfkX5bUrCrNCItTW+
 TmpgJAnCEbQcsuabWSxZRaSnLv5Jix1Mou6mGEquTBywnRVCALLMu73iI+wMeFaQGZTGEgoQgg+
 JqFuyT1y/tIH1+QgZ/GLUlzjpfnXFPArpR+LUGF9Oz73DuSSdhQHo3yTRJJiIeVlAkN+PJBzQO3
 +cEuQRaJD4l3xJRXvLO/+FUfjn2eQu7P8/cPmVHd4Tkr3Gsw+JatuoKbHE/+OYxtg6Oq/TLpruv
 zQU0S1I1NH42k49yqOOg+2EMHzSS1MpFQTOfMQWtv+7nun4dUFsM052jsc/38Xyip0Pkx5U/e6B
 OdwJqt5JQxsHK+szCcBmcobFrseckrgJp/mkVoFtB6KDJcOeD2HgUTfwbF11z79woSrLdCUj2
X-Received: by 2002:a05:6102:8085:b0:6f0:6293:747d with SMTP id
 ada2fe7eead31-71e88c388b9mr1376421137.14.1781272568286; 
 Fri, 12 Jun 2026 06:56:08 -0700 (PDT)
X-Received: by 2002:a05:6102:8085:b0:6f0:6293:747d with SMTP id
 ada2fe7eead31-71e88c388b9mr1376410137.14.1781272567859; 
 Fri, 12 Jun 2026 06:56:07 -0700 (PDT)
Received: from [192.168.69.232] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26392esm6352203f8f.3.2026.06.12.06.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 06:56:05 -0700 (PDT)
Message-ID: <71f8a1d2-e123-4815-a4da-dbb249b8cfba@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/core/machine: Add new compat for vfio-pci ats
 property
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260612014322.2918836-1-nathanc@nvidia.com>
 <20260612014322.2918836-4-nathanc@nvidia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260612014322.2918836-4-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=O94Jeh9W c=1 sm=1 tr=0 ts=6a2c0ff8 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=Ikd4Dj_1AAAA:8 a=tF5Azrqvr-rrHehjHX8A:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: AO-CkqolR4J-WqIFZ_FRCTVwK_bNjKir
X-Proofpoint-GUID: AO-CkqolR4J-WqIFZ_FRCTVwK_bNjKir
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyNyBTYWx0ZWRfX/SasH5ZspMgJ
 jCOOhoB9iGJ8oji/C3vyMUKDo+LpAW4aSqWl5lkVKeKPTOxRTVGcwGEO46KarN5ccTFsFLwiDXo
 ADu3lxd0vvXY/Sla4DdIJ/fcDfsVh5nf4uUQPjuahwhhy0kCeTNkGrVLodvS8yh0pjgYa6HyXEo
 sbcj66iR09C9xKXNkpcp6KHtBSPPmedIkaL+ahxVR/duDD0rbFxtvPEPz40+8kAgDwLfdtlNjcB
 WSHIFpG8vcf+xpFIuxBhhWdyRnhuoKCWJi7cxGMaOBnkNtviirGUQ/rKkYKhF6DHvdS0lckLmXV
 S6FZZYOXilgq4cvyW3eGu7F05ia1iVapHNlPGB/i1B2QFgdx6Dux5D9Kly2luzf6ADziXTlUK24
 aci2dJtx6C0O0vCV0De4DMYZBq+smGq5dwLv6V8G6tbwBrmcezSDUK3qZ/KlyIm5sSoQgvrbJe0
 W1a2fmeg1sCMBUAFDhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyNyBTYWx0ZWRfX1QIC+Bcz49NY
 i4UGdVIUwrWY6j55qIBA2WrAbuzaZzUJQAIdoahUzFv0vXiFQs5bBtMDbxrOtKafAex1Yp1xiEb
 YhhQ7jhhYs/ASYK7WkUafpjCPTO+5i4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120127
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi Nathan,

On 12/6/26 03:43, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
> 
> Introduce a new compat for the changed default for vfio-pci device ATS
> property, from "on" to "auto".
> 
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>   hw/core/machine.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 4d8b15d99e..c0cdf7c9da 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] = {
>       { "chardev-vc", "encoding", "cp437" },
>       { "tpm-crb", "cap-chunk", "off" },
>       { "tpm-crb", "x-allow-chunk-migration", "off" },
> +    { "vfio-pci", "ats", "on" },
>   };
>   const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);

Shouldn't this be squashed with previous patch to keep bisectability?

