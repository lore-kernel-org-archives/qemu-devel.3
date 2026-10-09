Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910BDCA9EBB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFIgJ-0007zh-FR; Fri, 09 Oct 2026 18:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFIgH-0007zV-N1
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:03:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFIgF-0006jU-Sv
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:03:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhtNT2021602
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hz9oipybgvRBP1RBSYHU1bjEnexd3M1/jlkjXSvE2pk=; b=Vqfzc5lJ24SdGyG2
 +eZHtaxEcpCdmptFwYDZYFiX5RFjv2t1fBJuzh1HPpo9mSowi8COJRzcua9IxDFp
 xNY7mBTAinW52pwFwV8QiOEau4V6DiEBSc2lm04miIdkA+oCu53zpWee5Giqd7dP
 ZOJYKAsfuh1rX25lPz65vmwX3cnGzKaRgDkLYt+LapZSK+M73driYVzvKRvOzI7h
 76KoLdeiSgYz0j3J6koC4b1wa66tA86AFqUU3cb3a7kI+lF1htBVHEo8SKCcTeNT
 UNFxzN5Xuh/ezO6SvTi4Z80BEeKbs4xdo3L+z/ndz27hhD01pUq0u8dfVqjYlWrP
 h7L57g==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t70vmk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:03:05 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1663fb7e005so236225c88.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791583385; x=1792188185; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hz9oipybgvRBP1RBSYHU1bjEnexd3M1/jlkjXSvE2pk=;
 b=f/bJUTHBH5Uk6KSsd8BXK6oRUje6ZI8gyYhJL49N0SuR7k+IYaiqsxzoeYqjaJcdyN
 d6OJjO8zl75+WoRO3sgbRMToX2tqCe+No97wTxpb6jT93TjDOOHtCfRpDSyal8BauiJ8
 5FO+hmyon+PkxgfxCLHE966k5YtHUlNiG/MAAQnl9R2BCLwzn437ss43BTARsCvKy01o
 xkK6GYJFAkz4rTCUDWiO1KuhkcT/IQY5iWmYbLjuQ7fzpJu1gaLEfRFo+2kedpJlvBVY
 sxF0k7R1jK/rgjWZI9/62c7CxG79bZrtoEVqzzvkAx3T4DEUc0EBo4SX2Tp0RKT30lRl
 AHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791583385; x=1792188185;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hz9oipybgvRBP1RBSYHU1bjEnexd3M1/jlkjXSvE2pk=;
 b=pESqQznHwNgIMB/D/JHg1UBumTXRogD7NkU7wAgeoD8/sYUb8O1LK2JTa5TcfyXj8z
 qPFCvdCoxpR1Z7El4fYflXNckBurReL01/yq32oMFFY+AC+tYG775HiALqt0l6Y/3M1Y
 rLqy62nNVrTU0HkQEYZ+MGUBKBqOCbAZd1mBeB2hJfT4uyX0vgW31jGcecHyY6gLgm4p
 tEQgXJjl2GAncUiJ+E+6TBtsBkgydyt+2SQnZenWyZbEBcxeoIPrNp66oifdXumWK9bk
 qAHcO2eMx+D3FjWHJihL1hzFcHm0ToMSYJYlBJFAOOXVXPLcfK+sClHBAxlMqrfjLIzX
 wQ6Q==
X-Gm-Message-State: AFq9FYIOXsbrwPf1FeWlgnIBvQiqxjYqfiCjz8r6/hp1Bahqjr8FR78i
 a0LjoqGd94dD/d8AEHHjkCneCxC1kuXBMMBW5gyUdlDzGpfRsh3+jM63Byb74dKgc5f6ftxSNzw
 UVfY018AfiLYCgVFyY+8owmMj9mcul5jUK3lvunxE3rwZizOFIDtdY27TEBpuX+nW9w==
X-Gm-Gg: AYBFou2p9V9Dyu02Ii1gXhSXrJhCGMrikgFZw3NXQEMjJBoHdmXkOU7rnSF0BEAnBCF
 7TQYd7DZaYSyO3SW2GyfduzOCVNVDGvLXtN7obrwEVK5miEc6iUFN+BR2LZW7oFlZtCKS3VzlUU
 //f5CRHoYt9B+NaEuH8ea/NNwDL3qekXIawBlwmXWTSpr/n+RzbEctyoTObWh2CMPKSGZnWouhN
 F7KoNqqqG1h1oLEgLcR4o40mCU51RizKntc+E/eMpStn0JdIRTkp8/jbJjKbs3m9qYt1DHJDzZW
 Mpf3IPVb4/AsErj5Yc2exM1dAPB8Hi3DUpmPaCg/F6Nly+Ejp7mQYBVp3ir2cs9QWeU6qw412fx
 hBAMxdhKMT5oQUf2FbA3hh80zola9LDvx9qK97cQU8TMEVzX5zvFeXY60xAxl8s5Jo8iA3Q==
X-Received: by 2002:a05:7022:28d:20b0:15b:afce:62c2 with SMTP id
 a92af1059eb24-16a6384d04dmr3659518c88.41.1791583385210; 
 Fri, 09 Oct 2026 15:03:05 -0700 (PDT)
X-Received: by 2002:a05:7022:28d:20b0:15b:afce:62c2 with SMTP id
 a92af1059eb24-16a6384d04dmr3659492c88.41.1791583384603; 
 Fri, 09 Oct 2026 15:03:04 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a2d2db98sm7822439c88.10.2026.10.09.15.03.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 15:03:03 -0700 (PDT)
Message-ID: <f73a446b-2550-4e29-8292-2c567079f5c7@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 15:03:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] target-info: expose full target variant
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20261007184612.24073-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007184612.24073-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA4NyBTYWx0ZWRfX5onE9TQ2gwwd
 ETTO1q5gGPaZoonxBHfSpG8UICuWylKsva5BRPzwJO+7+LeIFGX+JBDX5EYtA9P8dMj92qwb1P/
 LlnUKSawT7JFwxDjjNmOzewNkV5r6tI8fdolqyFBzow2hJNNuZkEPYOypZMod1XbUo2Bjxx8EoP
 JqMs7X1r21NapBlEgRyo99mqvkzfFej7HLade0Ee1Qm++qS3E+kr3T5ZItTCmlIdQl/x9L2KjWK
 iEXVnLPSHzXYeGj63cEswdVk1qyg9H8PR1p0Uy6P/C12qlhHyqyFFR6EJENgaatfn0HzNEMyJFe
 D1uOrWJw/L3JfcezwuD1v7j9u5BVBK6FL517/DwMDLCzqMtmCIFaZUAB8nHFo4Kk+G4Ek3DjQrg
 P+vs2B41S8PNqLlAhjp0gunTFMpoSrU/KEOoyqC1jwqYb9NtVGHPZHCWGTiY+75vk3uFk+H6X8r
 8Slov5vebifzs2nWXlg==
X-Authority-Analysis: v=2.4 cv=Zt94uN7G c=1 sm=1 tr=0 ts=6ac9649a cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=0Af0PUoDWarKJPvs41IA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA4NyBTYWx0ZWRfX448uUeH7IRqq
 PI5Cl4VDIQCFmwygLyJaa7a/hdUMRRh8VjwGCkSkTy/xPy01/ypAd8nNytTWdkoFZM8cpK8b/pv
 Zc5pMhSKp75teo+igwh/qt08yM7qeuE=
X-Proofpoint-GUID: GoD7zGNJUJVz-4wKyYVTT7GadWgBz_oF
X-Proofpoint-ORIG-GUID: GoD7zGNJUJVz-4wKyYVTT7GadWgBz_oF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090087
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

On 10/7/2026 11:46 AM, Pierrick Bouvier wrote:
> Recently, a regression was introduced that restricted list of targets returned
> by target-info by ignoring endianness variants. As a result, qmp query_target
> output changed compared to previous releases.
> 
> Fix that by exporting the full variant, and use that to define arch in
> target_info, thus giving us back a 1:1 mapping with SYS_EMU_TARGET enum.
> 
> v2
> --
> 
> - Add Suggested-by for Yonggang on two first patches
> - Add test patch from Yonggang
> 
> Pierrick Bouvier (2):
>   meson.build: export TARGET_ARCH_VARIANT in target config
>   target-info: use TARGET_ARCH_VARIANT
> 
> Yonggang Luo (1):
>   tests/qtest: check query-target architecture
> 
>  meson.build            | 11 +++++++++--
>  target-info-stub.c     |  2 +-
>  tests/qtest/qmp-test.c | 13 +++++++++++++
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 

This was merged into master (14c00f0e5d4ed837050a7fa1a41e4c1e9ba84cb9).

Regards,
Pierrick

