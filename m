Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7E5CD98EC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 00:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZdoy-0005nW-I5; Tue, 16 Jun 2026 20:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZdov-0005nM-Od
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 20:07:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZdos-0001a2-8m
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 20:07:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GNvGIO1141725
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 00:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MpfquTJRysTP51rQ0NBRCrcSNdM+ebORTVlth+6AFj0=; b=oQUJIpkwdrJeDbYy
 xKlesEaV5rKlYPDAZrbpLxGWvQE0XB6GBEhCmXX3j7GqDpTtrVe/kNI909pqPzJ5
 F76zy34Le+jaiuDGjYH28x4McWXhxqappa8KE7Q+glzzaFuSNz6D2AEn13gsthO6
 JqmbKxmxeJi8UWuI82ndTbTL+Pr92jqM2+pg5mYanm3c1Tbfg/tU0BMxXuVGONhy
 EeYxAbqgTSmboo20ZB2OlI4o4/OW+zVdwS0WxxGDFnaSQMqDfktEuhIouJ8H2dtE
 r206KCx/Uf1CCC9gv3Xq/sxWMqfIx53wdb6R3ufEEjJaaIsyXQ/rnh8Iqiw8NN2u
 XtcSyw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef28g7s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 00:07:48 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bc7296c59so945825eec.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 17:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781654867; x=1782259667; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MpfquTJRysTP51rQ0NBRCrcSNdM+ebORTVlth+6AFj0=;
 b=dUb+1tyfrZ6w0XdaRuEQ2Zi0epbHbY3YRk0ovHnFiXC1tfsnE0VFxVmLRzyv83EU55
 NvQ+0feWh9EgfkMumNJs905lT2WgeSj+/iX5ZoP8378N+X7rzxXM+ufe91oXCJkYLnPN
 ZlJQuVG5O5ELdu6gb3iD2BL7IzxEiNEzbAlVWTYE+tsaqP2tyRhGGsp2MP11Kv6H0CgF
 L36MHRr10gqSAg2Wo6oRDQKEFggvZPbGHGDuA04x9OnlZSp9s6q3fcUWCw7lordeulIY
 U9s4q8x8jw2UnDSvJH8hQo218B2SFDAsPhj4lbMSphpZ1I55C+pKQcoWRtnEHV2LChR5
 lz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781654867; x=1782259667;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MpfquTJRysTP51rQ0NBRCrcSNdM+ebORTVlth+6AFj0=;
 b=sVYZeJC3A0JdIvJ+7BrB5AHyWIn0LpSXzayp70vUWvkab+bMnZLnoMKhUBW0sU2tl/
 6ylq404C8Q9yq5iXSqrg1qST2AgZjWaAzlrj+Evb0cUEkw0OKzv/kiT5Ykkd4kQ4Rm59
 TUqeXX4fhB6ILdPs3LGAuGjmHJNct8hPkSKB8G0jDz8zJ6zZ7UAVBo7M+mAQJl+ew73z
 d3kgusEj+z4xS+7t4qXslkb2N0N3rdGh552GqZZDV9eEVo6Jk8UmvoM9twanHjM0soT/
 RuyRYlhPFjel8OffUGn91PkaVi8eRMJ8uJ97DGKuOyIbwgu79AzI3y75K1MJV/NceazG
 lWTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ865Kd4i4ckrio0HbPoDHEPW72VbZ+NOv0H/+Y0YCW/uesrwDG+ckzUboCu+dtjKeb9rHxME39AhXdu@nongnu.org
X-Gm-Message-State: AOJu0YznW1rPJMWbm4KYpntvfajKfCyYjazrVATrvd5786obXm4rKxqY
 r+Zs4uwczGg5pio64uvceXCEI4vxUjOBpHhypOra8rB4RbI/tAUnKRq+lyHxxsjoVMKGdyjowVk
 aurjqRfa30ExhoCjD5xaHWtOZM7XoTDfyN8AK6/MGZ6yySsIsel9RsOs9ng==
X-Gm-Gg: AfdE7cnHw9zBUw8uRwg0qxGnUWTrmagdJxNC0zqnLskpgnAeEltW2NhbkxJLr6jJP4I
 39pnaLrOXckop4JV0hU7HTskPwUea7EDccMs0fAkUqONm//vtP1CnZqC4h0Cs68jmnCA2UBy5Sl
 5MNLEkck6oZrXXO7vug9z6RpenPSxMqMh4c+9R/ga77IZ16GhjKriBrw2k1r0Ckyscr+hqA0Xn0
 eTn/tGxvAy960s11SUx+f0rZS0e/zfWNGlG5cZlZLoKRZ8N8iiOk3BxGanJrpck5OBAyDgVjVBF
 VdHOgUCvzldXoAKfdvXx1NEhaJ/mBo9JA9iKmkoi99115ixlG0gFrJOnF5vLUmCQtIy/IEYLmEW
 iEQHdfHQEnlSZenFGMO6+wJ5p8yvnKLA9q+WV6btJr6Rthl0CfJQEugl2kPXW/HJ39OrXVmrPBE
 NSbbJpjDLZpSKXAQ==
X-Received: by 2002:a05:7300:6902:b0:2f3:5266:fdfc with SMTP id
 5a478bee46e88-30bca0aa2dcmr996733eec.33.1781654867094; 
 Tue, 16 Jun 2026 17:07:47 -0700 (PDT)
X-Received: by 2002:a05:7300:6902:b0:2f3:5266:fdfc with SMTP id
 5a478bee46e88-30bca0aa2dcmr996713eec.33.1781654866429; 
 Tue, 16 Jun 2026 17:07:46 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb9a2e7sm20490917eec.30.2026.06.16.17.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 17:07:45 -0700 (PDT)
Message-ID: <3df19982-be33-4175-aa78-61a6af1b5640@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 17:07:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] plugins/execlog: fix segfault/race-cond on per-vCPU
 structures
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Harry van Haaren | OPENCHIP <harry.vanhaaren@openchip.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "erdnaxe@crans.org" <erdnaxe@crans.org>
References: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
 <ab967bbb-7961-4450-bdb9-06b9db905d2d@oss.qualcomm.com>
 <d06786e4-d4b2-8acb-18f7-9273f59e1746@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d06786e4-d4b2-8acb-18f7-9273f59e1746@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F8hnsKhN c=1 sm=1 tr=0 ts=6a31e554 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=OZcmDFxvAAAA:8 a=KeO1wXt4oVXvLJVn-gQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=liPxxeoTYnb3ClP5OJlV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDI0MyBTYWx0ZWRfXx3GbhaUkfplY
 NPqs1e8zBo+zNI4mIcOV4gqzwcWmJmMgkeaVrrggUKyQrqx+fHBgy52pIjOF/Aq++cPuVyjD6Dc
 I7jDMFGxPY7N/oqnlZEocLEf8LEmHoM=
X-Proofpoint-GUID: lFKYHdr-p3V0RSz2HiebAqfRGsGjVNmH
X-Proofpoint-ORIG-GUID: lFKYHdr-p3V0RSz2HiebAqfRGsGjVNmH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDI0MyBTYWx0ZWRfX/+1BHa2pYG27
 94dmAV0CgxuZGhcGh/KTDiRfzp1oIr/xhH51B0MdKL36f3U/2qycLwcg6I/WZdgkYl0u9V2qjDF
 d3CO27M4dzj1cP+Eue0I+XNPW5ySqaSCxvgh579btFO9ZjEBtsPwum6SS9WORNUvwPePXDsSFyg
 z/gWqauaJvqpx3sAym7gSs4+zFcVDRE155cB/iAJ+o2H1DJX3fIZMXlAWiTBKR05Hjo6bVhZnKj
 zGhR8IJA8pUo+efsVNCoVo+sB02NFVcRRnGdlWx+RyDPPVmBoMI80ZZ5SUzzHfWb2YPqIIq19u8
 2ZPqxjjJE6cicZnk4OPdn+WLnDm9HosSzus82hDIVDTxmmbitBsoXjDUAr9PD1lJzRa2Acn7MfQ
 M5Su7Z6hOfF58O+Frg/gHb1wsT8jI0tI4tLeqYROx00/6D88pYKrNDmPxOmNfPis4BE0FVXG/u3
 y4WdYZYqvQhrjV8wbmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606160243
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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

On 6/16/2026 4:56 PM, BALATON Zoltan wrote:
> On Tue, 16 Jun 2026, Pierrick Bouvier wrote:
>> On 6/16/2026 9:12 AM, Harry van Haaren | OPENCHIP wrote:
>>> From: Harry van Haaren <harry.vanhaaren@openchip.com>
>>>
>>
>> No needed for this From: tag since you are already the sender and have a
>> signed-off-by.
> 
> But the message From: field has "| OPENCHIP" in the name which I think
> is intended to be removed by this tag so it's OK to have it. If it was
> the same as the From: field of the message it would not be needed indeed.
>

Good catch Zoltan!
I didn't even notice the '| OPENCHIP' in the name to be honest.

> Regards,
> BALATON Zoltan


