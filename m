Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFF7CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 14:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSbkn-0004vs-OV; Thu, 28 May 2026 10:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSbkg-0004i8-Jj
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:30:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSbkd-000132-TC
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:30:26 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vmFR1697973
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 14:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JjKngCH+tN/DN3kMGAPIRvmTGn60U/+B3RchTraZprM=; b=HqpgP86jObG52SDP
 Pqvc2jq4wRlYdh/MX1/IGI5+TzKosi/09c0PB2c+aDFeplnNI5vQ8cvVooriVb9+
 hPFOA3KF/lUXhuJex/Zriqf6R1t1PL6MoPehOm1ZTiLS8TP4Ojoy690I+ulO71aZ
 CXWmMaMTpctFE4BY8qvjO+V+rJaWCi/cBWeYFmTh7e2FBBvlGMcX6C2FDH9/bymd
 E4ciRVQbgAKf/yD11lsxCh5NRIR1qj/usEuKsP9kshRLPgV2TkRV1qOKOEKjn5XR
 6fPlJACkyKgKEXgPYDIqJaohZ1N+U5/LNKa+HWfo8ett7FOM/8lSzgbVNEInBP3D
 q902sQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yak3yb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 14:30:22 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304dd917645so376097eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779978621; x=1780583421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JjKngCH+tN/DN3kMGAPIRvmTGn60U/+B3RchTraZprM=;
 b=RhGiAix9k3UwSuV04poXf/12GPf58M4hK/uczzXLq8TJGqWJgboMAKPkUeuv/iXoat
 oL6VFu0Dg1f7nw/mgiH1Odl/VgwQ5BehM+Od+Rs/N38bRY+BtrCycAz50RER8nIuOfqb
 u1abibVZCku6x6a7Z4VcvA5j4iCPGce+hVi4G177VCLwai2rFMmrtTNVVmDDTXWjnv+M
 +v2BiV0QDW1Ub1RpXW9vGsprzTMPZLIGrFG2cBVPdlLhrMyCPMTt0dVAxUGWc139yfp0
 AjHpktaRY+m2u+QzKjPIsf7X1u+VLtaEG2u/vsrouXCyGECy2wZE8L8f2ovzOw2LISmU
 ncXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779978621; x=1780583421;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JjKngCH+tN/DN3kMGAPIRvmTGn60U/+B3RchTraZprM=;
 b=bZedlvGEQwoCnw4mcdzYDNk4tBPC7wUzkNBh5eIfo6si1ErhGwPM/rb6eH74kYESC8
 lshR8lhU8/iJExZALbEjIPV9lPdkmX2DavrUcaH88YWGqf5JgnMdHREVYph5A2B0N/Az
 RYRiVSlcXwW+b5AISGrMtDEaAAy40ezadiT8DKvXtC4c0a47Z27btEaR/AeYpylkp0UR
 sDUaUKVKvc2JYnOsyGJBcd9fDuvlsGeTl9KAnLhaKxLGzQWo6CewVLmJ5sruX46WDhSO
 AkgY8rjbCmCYNSbK3x4d3+pUQF+dh1nT5Nwv5xTXXoiZwRECNjFbp65XiHBPwBsVxKxP
 rb1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZHGa95mxaMwt8DGCtcuTe/RSxy2uO0UocGsMPpJAPlU4HvlN3HRpHnoCibZvKwDJhotYHvYEc8OH0@nongnu.org
X-Gm-Message-State: AOJu0Yx3PzBBYSoZMXVAxqH+EYyjkTclYeN43Gphbthgvj8l0n+R7wOA
 mWAPn1VZXok/l9na5suTh3Dg97hmB0eOb7uDBzzIFDbgHL/qdM+XJEZ2E92CxChjyjyx2nm3Zop
 VcEMNfC9w+gW9BxMNIQC5qaZL5SA+F4iqN0ylEMONSbaZG8vc7Zr60+azVQ==
X-Gm-Gg: Acq92OGizBAOx9Jn6LIXWCaHfjADGHLtnVIX+YnXEFBVX32Hg+c5GWrVyI+litqJQud
 MSxBFUdD6695B8ey2IWB5Bl3uAYU27PRLT9lM90A4Z+jFTK9wtYFG1Tmb26qVMK4nIUxkM+vqDc
 hxeHPSiiIzePulQgz67l3dYmLOaYZmpRnR/g7uQY1bz1pbweUZTA1fYxp8g4X27vEOB87ZfeSMP
 44jHZ9ms27z4nZjDMH1CN1fVs3UaypBLLdB9cUPyFW8iB4m9yWFEPzl4pbkAtXQ3FG00G9/IcFu
 M1+YRSXtL124xVc37EBTTRmAVsrdgoxnm4LPbN0S/W6iQijyNl//RFwGyaCQoygbz/dIBz5tA3T
 k4Bpx99TrCI/gA0XoZMXGukZ7EDBBQIyv49V7oh4w2fVdMuhg2MKJaRcqKmYh3G6wN9fMuxU1sJ
 Il8PntVOdn0V/Sx2XDFDbP84kp
X-Received: by 2002:a05:7300:cd91:b0:2ed:e12:3769 with SMTP id
 5a478bee46e88-30449228424mr11544248eec.31.1779978618615; 
 Thu, 28 May 2026 07:30:18 -0700 (PDT)
X-Received: by 2002:a05:7300:cd91:b0:2ed:e12:3769 with SMTP id
 5a478bee46e88-30449228424mr11544154eec.31.1779978617834; 
 Thu, 28 May 2026 07:30:17 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045245d6aesm14720790eec.26.2026.05.28.07.30.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 07:30:17 -0700 (PDT)
Message-ID: <afaf1562-cd2b-4da4-b7e4-f4e699b750a1@oss.qualcomm.com>
Date: Thu, 28 May 2026 07:30:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] target/microblaze: rename helper unaligned_access
 to microblaze_unaligned_access
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Rolnik <mrolnik@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowang@redhat.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Xu <peterx@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Fabiano Rosas <farosas@suse.de>
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
 <20260528051642.115721-10-pierrick.bouvier@oss.qualcomm.com>
 <41e70c92-99d0-49d5-b233-a7f80f863f8d@linaro.org>
 <33274371-2cab-4132-a4ef-0497c7ffec3e@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <33274371-2cab-4132-a4ef-0497c7ffec3e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cq1EvbmU9XEa4LzLcRdsGMHwCsr2PRKM
X-Proofpoint-GUID: cq1EvbmU9XEa4LzLcRdsGMHwCsr2PRKM
X-Authority-Analysis: v=2.4 cv=E/r9Y6dl c=1 sm=1 tr=0 ts=6a18517e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=sUTfoMr8b-0mKdkWX2sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE0NiBTYWx0ZWRfX8WUuDagLX/1/
 afWlhG+ynITsUqf4HwUcZKv+g8iMGgW1unRtDzfHI3K1sChbR13Q+IDffVSdfMwT1f0JZ+tBSlY
 PwY9jWUsw/2xjn2Sh6x71cgeZ7mcgrqJJip7VxZxx0eR+sW+pN50OBxhpIO8E2NWlSyy3CA2uFl
 4C4Psy/xTz3tWrO0cGWGC2EgS3W1BfUwJMeqt12Hz8z6LlD7r2GnImQj8HI/X8D+py+gCXGZBXO
 vj6ZdVnh3u8NIMElAjXQw3FT3RT/Qry4P0dRflOiWRZi1rEHMC+amsFyvoKX0bqTKBHCDl9zXS0
 GXq0mktLQhoZA9gAERcTbvmRZC8UNkKWU4KVR0gnpYwIGUDx3mXsTGXpG92lRxEok8/kFwM/aaz
 iPdpHPomzmxtHKzgK58lxChnak59vk0cA3f9G4SEKtOAxcLws5PmVCjxicAKzzwfypwR2/95LHw
 flfCeTgU9m2GRxIEEbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280146
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/28/2026 12:27 AM, Philippe Mathieu-Daudé wrote:
> On 28/5/26 09:24, Philippe Mathieu-Daudé wrote:
>> On 28/5/26 07:16, Pierrick Bouvier wrote:
>>> Solves conflict with aarch64 unaligned_access.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>   target/microblaze/helper.c    | 2 +-
>>>   target/microblaze/helper.h    | 2 +-
>>>   target/microblaze/translate.c | 2 +-
>>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> Duplicate of this patch which you already reviewed:
>> https://lore.kernel.org/qemu-devel/20260224193028.2370-4-
>> philmd@linaro.org/
>

I remember you did something around that, but it didn't cross my mind to
go see if you had such patches in your single-binary branch.
Problem with checking someone else branch is that there is no guarantee
on branch status (build, checkpatch, tests).
 > The point of this comment is to avoid duplicated work (I thought
> you had these patches in your branches). Should I maintain some
> single-binary-next branch in my repository with these unmerged
> patches?

Continuous integration is the answer: we need to integrate things
upstream as soon as they are ready.
The best way to have this solved is to pull those commits once they are
ready and reviewed, even if your PR has only 1 commit.

Luckily, this one is not a huge duplicated work.

Regards,
Pierrick

