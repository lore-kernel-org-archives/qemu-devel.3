Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FB5CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9GI-0006lW-LT; Wed, 29 Apr 2026 14:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wI9GH-0006kh-4S
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:03:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wI9GE-0007PC-FN
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:03:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TFRXbx3752372
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FMcrg/uNFK03dLcTbKEzOU0qTWdfdX6tDE3HYmOJLa4=; b=mGSOBsBFPEAMtQ1D
 Pr/LQ4Flnz/iIKz92yResGMlqQIbc1gTfIAfoDxM6AGMPM5Skq4cPdYlN5bRlaiA
 GtcEehbwjs5TePOOcayk1V/aVSIEdBm6mkuZ0LvVX+omRdIKxrIGg6kvv2gfWBPf
 sMAjI2zkp2xRIGLv10E9f6zOVrpvBoBocy6TsICqO6uayWe3/FAVZ294dKYP1eeY
 6Fz0frsaAs+Lq0f80ersMuO6YOM4a8f4ERL4du+U81m8GGo/C+sD5FUWyv9pz3ys
 1DnsfbXGw3oledjl1YpZUSUeTrB9wkokYKcc19uIGNWS1I+xJ5CkmAfEAS98u3H+
 VOCGjA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duch1jvs5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:03:42 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12c726f4055so23840c88.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 11:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777485821; x=1778090621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FMcrg/uNFK03dLcTbKEzOU0qTWdfdX6tDE3HYmOJLa4=;
 b=bEGr1TPo4UU3s2QlatJohRM496aIENXwDcL6jiA5GvJ31vRtjPpw5U5zpPyyT/8sDq
 9akj6E5AMYRxZH3hzAWawxglAVIgXiVynXBgeocwxy/fOWQTM+mIz2coCpnCD5pFEVcZ
 Yp4O7BJoedU0GYTAtF6AyLngCunKjnhKktJ3SDyJasOed15AWw7mPrC6G3CFcoy7k9Ju
 FIA/mzIzTsgDeT8M1WbjZXSWQxe6J4fxPaqyS2f8zZgOe0xuX/vBrzjZVb0usR3yKmCu
 qhW4MOCovHPEYUSZIZMZ8RiFUpvyVEUPnq0J3LIHFI2tI+CQ41oG1Rp5bEx4f62cabrC
 cAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777485821; x=1778090621;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FMcrg/uNFK03dLcTbKEzOU0qTWdfdX6tDE3HYmOJLa4=;
 b=J5cb7J98Nq8YRXkG0yekLu44Fgtiz/gbslcFlLsohw3oFeItp5XNJb4MB5462I3/lR
 xexdoHxxFTeRtHCi0IvlVUwIOitmsHzSRVkLqqEbQ2q3I7gdHLvKJHxxQHr0eZsbtx4G
 BiYTAChnGChEEX6e9PyQkDhjbLgJMzO1fhmepzMrhNQZIKqrAAKtIJozH+ufgmCQYj5M
 /9FMojRs5VarDT05krmtvXXlcMJLhwHYVKOvcKiTHSetYWMB3BHaNyaibmlNjiM92hwN
 T8Zw5rHAzBe5ISaO8lrsNFVScwik61+XzFBy4ESKKA3G0CD4ovZpflqwBX/e90hBVNKc
 NbXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cBAtcnUc4oUCRkLKYFhSJSYAeqTS6deE0OKs1MyuMKuWnz4eoXB8Xb4WLAgvEDAFigdRWSwhL8w0J@nongnu.org
X-Gm-Message-State: AOJu0YxQxKJzWjjd+PzcfCvL8c6PbK+arY5G6YO1JSov7rrOkVEi2eIx
 Rug4o7bca9DVBD89ziTd71DoQnt1cA27HVBV6etXn/9GJmxisYCcd4oHjHfSIIohCFddI0S4nWy
 vOS+MIrV6Oulm3oWUP+f3RctM3nt2MNpJpxLg5cL11RDtRrlcvIw5GkCkYQ==
X-Gm-Gg: AeBDievfc3G/tZqpJOt6H4m2yx+2qeWuEiHiDunR+LWDInGY3h2PdqDfBzscC67S42Q
 iEdAbYOiQEKeuDuYH8sy7rGEGxqtfpm3CFJqzz8XGJC9TQcb/GFqxLGjVmWcNFu7+ieYDq31rXb
 CVoxXBhYDmaiT6UmI1T5zx1yWyv31NxklWNGu5TW+Q2oPo51qTKOu6zmfO4a1mH7b4TSoEaX5Eb
 Fu7xMLC1xcFSYq7PDZ31kFEp6ILkgxXWMc+7tXgtVxb3+j8/eaTWYPldBh/xFTPNFVn24MQuZr9
 zACb6U3aR38bnu5kKatc4HO69uj26CrkrKQk46KfUd8M55M+4VAMExGB+x5Cu1vgbHDTht8V5nb
 A/yShdFkP5sysv+Mdv3bJ+V/u+p73hia3z3pFVI4byE6hVVKSbBD8Cw8P5D80Y0N9mfBbpbv78G
 ly4cpCTh2P0gy5zRXlm1qQOWe6
X-Received: by 2002:a05:7022:42:b0:12d:de3f:f3ea with SMTP id
 a92af1059eb24-12de2a601edmr2352627c88.42.1777485821142; 
 Wed, 29 Apr 2026 11:03:41 -0700 (PDT)
X-Received: by 2002:a05:7022:42:b0:12d:de3f:f3ea with SMTP id
 a92af1059eb24-12de2a601edmr2352606c88.42.1777485820328; 
 Wed, 29 Apr 2026 11:03:40 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c0d8f90sm3263081eec.30.2026.04.29.11.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 11:03:39 -0700 (PDT)
Message-ID: <5aed20fb-9df4-4f87-83f2-2309a8d6ad8f@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 11:03:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Rust builds don't use link_args
To: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <24ba9372-a691-4a63-a6da-e8340343faaf@oss.qualcomm.com>
 <389edd46-c25d-473c-8603-1a5d411d0d63@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <389edd46-c25d-473c-8603-1a5d411d0d63@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=arGCzyZV c=1 sm=1 tr=0 ts=69f247fe cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=ukH1R-b_AAAA:8 a=7PweTpuV95bmKq5wTOEA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=zUGFzhdS3I8ccRoxxLmr:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE4MiBTYWx0ZWRfXxASd0tt/YGdF
 uOqeZ2zvprO6x6pw467jZOrFUvmw/nUqn5Rgukqdt2ewbgq1SJvkgFIjOHMXLeszfT1p04zh3ls
 T8cTacQyJWBIAShtp9dGLcRt4tFAmKdclGL4HTKIUQY4SMHUkrORY36UO06qg4ilZ5xaMo6a+2J
 2F8DV/QjRB4F6bYaCl5fMNIKVOv2JRVmgAgaMgJkB0+AR8tEKzpU5ed+3WRB0XW1tbjZqGtde9o
 ZLogL1eNILkHz2saFSKhYnDH+AN7zAYPJFMHIiWFMmCAwv28M53L7H+hkELgolgHYvb59WI1Dbz
 2pE+W7OwBCp7dviJdsA4zeRSE+cgknov95GkaUOCBLwwqV5rKxMsSX7MxdSLkRR+wdVtYdhUsYs
 +JROMxoqTgJjM5lLgteb6pebfiiTEbdLD0cN0VYS7ztuW54LMVDWqrixe4ETLh6Szxcrcf9nSQW
 gPmMwRVippR6cESMYAA==
X-Proofpoint-GUID: xEtYYUm8-od912bD676G0tKHECV2h5-2
X-Proofpoint-ORIG-GUID: xEtYYUm8-od912bD676G0tKHECV2h5-2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290182
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On 4/29/2026 1:32 AM, Paolo Bonzini wrote:
> On 4/29/26 01:16, Pierrick Bouvier wrote:
>> I noticed that plugins are not working when building with with
>> --enable-rust.
>>
>> We explicitly export qemu_plugin_* symbols from QEMU binary using:
>> plugins/meson.build:24 [1]
>> ```
>> emulator_link_args += '-Xlinker', '--dynamic-list=' +
>> qemu_plugin_symbols.full_path()
>> ```
>>
>> Tracing a rust enabled build, it seems that rustc is responsible for
>> doing the final link, by calling the compiler (cc here).
>> However, I didn't see those flags being passed.
>>
>> Any idea how to make rustc apply these flags correctly?
> 
> I would start by testing Meson 1.11. From https://mesonbuild.com/
> Release-notes-for-1-11-0.html:
> 
> ---
> ## Change to handling of linker arguments for Rust
> 
> Since the Rust compiler integrates the compiler and linker phase,
> previous Meson versions did not obey link_args,
> add_project_link_arguments or add_global_link_arguments.
> 
> Starting in this version, add_project_link_arguments(),
> add_global_link_arguments(), and the link_args keyword argument are
> supported for Rust. They wrap the arguments with -Clink-arg= when
> invoking rustc, and are only included when creating binary or shared
> library crates.
> 
> Likewise, methods such as has_link_argument() now wrap the arguments
> being tested with -Clink-arg=.
> ----
> 
> Paolo
> 

This works with meson 1.11.0, I'll send a patch to update version after
running a full CI.

Regards,
Pierrick


