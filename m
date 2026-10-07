Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8C6CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEP0I-0006CA-7D; Wed, 07 Oct 2026 06:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEP02-00069c-2P
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:35:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOzy-0007pq-QP
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:35:48 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jipp151961
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 10:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8a44lFmsaqF99pzdmLjXZYXv/Q+Jj5C5KYp7ERYUtA4=; b=CSWTNBVuXVZHvi3x
 wjYVkVAsA5O1SdleciXuLZT/7KyvK8ccpoxH1BC6zXPH5Mw6ps39Im+MFGc37ZcV
 ck32ilcwZKki7jj03JBvNZknvATUspvMhgC5LjrgRnmsgv4gchecSbTnUAmbvyOU
 LnEn/5jvJdb4EPYW4v/h4IxMM5ZkbvwUQ+8tZJv5XkMN4A/QbNPREnhMFTjHUCjF
 YlV9M/Z+/cpr/e6+9o0j7bbt7yvdvMpKtFXU37XwoEvGJiGWu/0d1N6igN335jlW
 8jSAR61QjyH2zPmbUsI0KqJAjcRaybED+0IommMOCRFgOZ2iAX3mVIsnz+dc2BaP
 rL9pWQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c719p3j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 10:35:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb98809caso550424585a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 03:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791369344; x=1791974144; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8a44lFmsaqF99pzdmLjXZYXv/Q+Jj5C5KYp7ERYUtA4=;
 b=GU0H19irIYIxSpMy4Pcwibzh/MHvRHqIi5nvND8EDSpTT+vWT16MuevKcurxtaIZ4j
 SzJNnd+RfSYcd/Af1dRE/0ZExCmyIKEbY6sNGm9LfNNYojuijl1WGwUjaAq+mMSGwXNt
 +Tw9qeizXlsDFxb0XxTSas/2XA2DBVbhSmCPU/AdrkaN5mIG6ITgSbtpEC3YZCq7ywi2
 NbQ+sZfz/fEFAOGo1671VFWYC4WeMxULIN/WVDDRKNo/3/JsGsjavdygogp60rUFIeKw
 C0ugBDB7VVhkxPv9z7dgfSno0FCeBmDcCOu17haOonbmVbzttEod9dpbGUhEatREuLfQ
 GnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791369344; x=1791974144;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8a44lFmsaqF99pzdmLjXZYXv/Q+Jj5C5KYp7ERYUtA4=;
 b=gH8Ea+aYEJfwwLQUAjs4bvn1WEQ46oz5QMaooDBdcfQd/ogPZgmWRjCu+/Ke2qNChS
 pdA5uxOxUkQQacfEe73J5j+aYXsYUjgVGxHhkuPic8aVp8afSAfiKvEsJXdMLaaSuWCh
 dKI5JPjZMHSqW7TBaMQF/rTy5tuzefOtE9JCcuS8DNMfGlGNDV0awdrGB9ri4xbLfaIB
 PKI3AesrmNN3lq7A0FPnIaQyKOoames3wCWQ350RwtYXIwhWEZvMxzJ6OAqr3HjzgwsK
 Sey+kcbqq3GJYiYqWdpQkOwFbA0+qVBQuWVDZAOL/5nba0JGshlTUDrbi8XfpEXVJ1oS
 3Beg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjANVX2uRiGu/Q3xLld4yqwt090i3BAawOgPD9cg6xDJgf2QqBDjoN9KCydEzoS6pR9cqgA/6KzYlc@nongnu.org
X-Gm-Message-State: AFuF++nrIkpw7oz/HjuajRaG5ae9ism8GOIV+4hvYPzeTCjMdbpZTwJe
 UXOqRtr+EwxSeIg+zqfbK/2dMs50A3MbkWl7OsoRBbXQTiK+11CGT1ds8QPrb1r4z248jc/PxmE
 Xnii/NjUUc8fERUOQMzFPnY1bpT/n5sloIXnUKLbb9Q6eoy4i3oVRijl+ug==
X-Gm-Gg: AYBFou2iXG05dSJilAD/SKdA2quPEuqjbYOcqu0WlWYlbdTCMXYfokdIfePZXYwJSaA
 dmMSsSibTZiuOY7pT1OooUatgFmzURZle1aLPfAud5q2/Qcrq3F69U7f2/bJsXe0dPI/MZy3GG8
 BVd9yKzeCA/BFYKZs5e0I8knip8Jf1TuB1SIfx1BUQDBhbEYx5yV/0jVbWMhB4MKt7bkouiI++M
 Rx345oWnV35TEUN1HsJ8DI190+3jvu1BgGKMHEe9cXEcvb0TIHt3X/THRxhl89ne5CjImQIvI3T
 JLhAbZIZ7qKsNZ/I9Jb3p9VfoOgf9rkEfnkeRuKJThzfz+tKUreKYkpUXQ9ITO8BgAuso6h8Oow
 Ffc/UzB+JLPsPjfjzt91+2WGu8Zep6er7Rg==
X-Received: by 2002:a05:620a:838e:b0:93b:e6d3:3145 with SMTP id
 af79cd13be357-93e9b890fafmr341647785a.64.1791369344380; 
 Wed, 07 Oct 2026 03:35:44 -0700 (PDT)
X-Received: by 2002:a05:620a:838e:b0:93b:e6d3:3145 with SMTP id
 af79cd13be357-93e9b890fafmr341644185a.64.1791369343839; 
 Wed, 07 Oct 2026 03:35:43 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f5510desm53070525e9.7.2026.10.07.03.35.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 03:35:36 -0700 (PDT)
Message-ID: <ebb9178a-c2eb-40a2-b217-db93e76bdc49@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:35:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/18] target/riscv: Compile machine.c once
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, luoyonggang@gmail.com
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
 <20261007-rv-dedup-v2-16-8a2f0f296a7f@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261007-rv-dedup-v2-16-8a2f0f296a7f@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MiBTYWx0ZWRfX8A9RWa+FvL2e
 waYcCbUiZ6TLpdz6xpWmTzPoOksCAEPTrU2j8E7hZu1ESQrvJ5XvOGHXUkRMEg+vzsE94uC2IIS
 QJ6YgxGvRQ8j9taSJpwA4uvdMSIWUFY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MiBTYWx0ZWRfX9HCMMzT4Ny1M
 /G9tSnPTAT7MZ1x+EM0V039NJwrrR7+BkzAVfIpciwf1Ha1Zn1+AImbPYKlFwXunMEEo6HRyyw7
 9EIV+CEDIuwbUplPKyQfDfGqZ8s35YbndIjnHshZ+S6f3bBMGw8MiT/U4l5q1TPyV1f/7yKxfcF
 fjmKXBcKNAJB0cjP2UZbmvl7suNrFk1WLejmUm004apI5JyhTPXxPNH8ckvypVk/N0Hz435J1z4
 68sncDfLkoOypFRlKgujnu1DjJsetRKaqBUH6u7U10p23oyYP7fYtGz6r31Qlqhtz0eSW8YlP+L
 vN4AjQTiOPko8fzQbGfk1x4a6pXEZthRi6lzsNuAfrFj+BTmXKT6bgt+5B8PcPKZpChU3jA3dqZ
 OduEvqV0jAjIqBqOf3FwVN2FtB/KtHF36lr8JwKodB1wIQiedt62Xk007g5aTPPuHMw443h2ogX
 PG4fxVEaM7+PFqc/eiw==
X-Proofpoint-GUID: VuMPSPlAvQ4MTUytBS8n7FROM7iitpAN
X-Proofpoint-ORIG-GUID: VuMPSPlAvQ4MTUytBS8n7FROM7iitpAN
X-Authority-Analysis: v=2.4 cv=LvYHWXdc c=1 sm=1 tr=0 ts=6ac62081 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070042
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/10/26 10:43, Anton Johansson wrote:
> There's now also no change in migration stream between KVM/non-KVM
> configurations, KVM fields are filtered out via .is_needed().
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/machine.c   | 10 +---------
>   target/riscv/meson.build |  2 +-
>   2 files changed, 2 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

