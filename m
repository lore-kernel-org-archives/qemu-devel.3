Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FC0CD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 19:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZw9h-0004uN-JZ; Wed, 17 Jun 2026 15:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZw9L-0004sC-IK
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:42:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZw9J-00085Z-9x
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:42:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HJbMD33515325
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 19:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zj2C7TruRjSbnd93rscAcsG+D5yIEDVhHrbNL0s6SrE=; b=Y1zm+APWCWdf5gl/
 gy4lOPhygDPhuXS03oHafWUcmjiribaKrDabXS7IAuG6hMW7PtQlxzAd2LvormkR
 tks+qiXqBU5Z67nErrFeuKPt4ve8lqQI/90gWclZ6pGyPKbtW0cnWNZVscUmIO4l
 jUNsdPVvPMg0TwEE6UFti5IhCcnQ3FOLkOqtpL1UnlqZDsXjqaCRlytgDmoekEdx
 R+BDm+WWLAOryhi7PDIlQinElzb+2genDXQEmPb05xwzFKdZlr8PC6lQlAlmCO1i
 6GtLpXthmXIAWzMUf9ll29qwiGZmoDDwxtlfIYjX+VYn5FpEQqy3btxCC98fRUoJ
 eClBCQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1wc00ep-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 19:42:07 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304ed777a96so105841eec.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781725326; x=1782330126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zj2C7TruRjSbnd93rscAcsG+D5yIEDVhHrbNL0s6SrE=;
 b=Nn8mLeT11j41CuRFK4WoYL53L8k0nBpCNy9RQOE1f7UgI/suwl913r4rK3hTdMNC/G
 rYkLXTUUdpo5Qr6D5MpixdMwCidD1dH0syKIbb9egjJyntlA5SWhEQgFM3FNOlee+ldQ
 FhKmWao1X8tBsXhClZ6dKzeF6EYiGmeIPrudmgCIboGLxL8Z+8qUmPdUWM1mHhD/zYwS
 pRmroI7+Dx2Tz4AT/093+IFumrTd0sEfjdfTzHahqxVCQM9yL56++GrB+MKNXfgwfeER
 8mCMIeseUh9UVWPNTD6yiTPhAQIjOiJiUcpYr95uXCLOyoPht/1V/gdZ24hg6Di3C/kV
 bkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781725326; x=1782330126;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zj2C7TruRjSbnd93rscAcsG+D5yIEDVhHrbNL0s6SrE=;
 b=e3gCBggAVOpsO9YRL7GtvWV8z/Uu7fxj0YABRxBP2QgTFZ1aJgiIje3jxQ4wcW8ysc
 mGcsvunuz5LdZrXNgfr7xC2rPxlVeMo7RhHZeBV2Z7di+G6csCyj87W4JcXyhY0Ld4CN
 ihj0AyWpiiPRGrSRzs1+yEd9W5vFwvktBiM31SLszyG42hgrjy3aVipM7fNeM183fesc
 LDTayhIrzuwN1rCUPIGITCO9rQ3Yyd7NWicoC4o1zbePpaKSXaJzayWFT3qhUkFIFV/f
 S9nGFqHvn2OAv08q17HN54bM1j4C5pZdudKPxvXhbNm6qrx4V/Da8LzcWpf2k1RNQ8b9
 43vw==
X-Gm-Message-State: AOJu0YxUuie06eMH6eSgUy5gktVQp6tPUMMIEs3j2g74qfB7ZC6hzthO
 8cW6oBl05UPslj1VHzA7lyyLELIJFknpebzCesGti6dQZldKtUDO/duV1XrXlrchjDGdCY1qfZX
 lNTXznStwmEdZfhyfwAOsx4AQXUhbvGIZh4zAzy0MdO9g2LeRf6vQj3sqcbroABBBFA==
X-Gm-Gg: AfdE7cnIXKQCn+RNg1Ifs2v8b7Beelm9XJqFkM4Hykz0IH5XhGy+41dYEq3khgBNGzv
 BBIN65vwQ60nP3vehu8ryeWXeXgvHkWa/bfKtm3lejXcxkj2eyAL1+Kocz798LaFiUKvq0BIvOg
 kdEaS++QOmPLJ30jp/Mw7cStEnlYpwQBdO9wpubvLDkkhoWwlyppsxXH9c/sT+Y9nG4l3LpVEJV
 U4uNB1VlFeatzM+s9pWCEmkTtMS6/zAC5zCkXqi1yEHH8UbltHHsqiuqHywgSy2DW4ilOsiT9cR
 QP51kFqshwSofcSMoNED83Y2a7ypqVtUK7muUliU4Jtwp2KqgEV35HuLo8CYh1yjM27hDODidsS
 S3iwy7dZmHzSj1tZ1FOJA7+ktpf/DDphAdVKgj1Yp/Lsjql2TM2XQVObzSdnbppiNQ5CLrvhHJ8
 cA+U0=
X-Received: by 2002:a05:7300:d20f:b0:2ef:1d11:18b0 with SMTP id
 5a478bee46e88-30bede5f031mr354320eec.17.1781725326240; 
 Wed, 17 Jun 2026 12:42:06 -0700 (PDT)
X-Received: by 2002:a05:7300:d20f:b0:2ef:1d11:18b0 with SMTP id
 5a478bee46e88-30bede5f031mr354304eec.17.1781725325729; 
 Wed, 17 Jun 2026 12:42:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30bd8ab412fsm3137578eec.31.2026.06.17.12.42.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 12:42:05 -0700 (PDT)
Message-ID: <22b0cffa-9fbd-40bc-b7f5-77cec3f3cccc@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 12:42:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/26] plugins: refactor API to maintain state through
 callbacks chain
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMt1jVla c=1 sm=1 tr=0 ts=6a32f88f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=1nqhs7xc5XLLtRwDZDwA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: Bl7IHU3sZBPksfNxEK1ow__CpR_TmOZa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE4OSBTYWx0ZWRfXxhdhtX39lMfJ
 GAatCzSxHChobGBDclO/FA2eWn8TfcmrdWXfYYmr6nduQRhABKDKsLvKAu1yIONJUuIOsZ/+Q8I
 g6h40UNEu7fVK9rhkiiDPZaj5Jhoe0E=
X-Proofpoint-ORIG-GUID: Bl7IHU3sZBPksfNxEK1ow__CpR_TmOZa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE4OSBTYWx0ZWRfX1iY2dtGrak+D
 DLqexmFW0zAkenODllMy99kHxrErqzxgUpOUjRoGJKqTNVLpGKEIoq1fnGGUmbrJ9J/RqgFJ1Sj
 9VXMkKAZHisz4n6AmilnhOFB94BiPXqB2Xsj8+Polkc3ZS9+5qbyl96w0Pd6CLDAhOUvWGlZSrJ
 7CS0Q6k39LuSAFXbrL0anr9RnXIE4vvMssPWoRjZDQVAFSR9UPOKb1TwN1WuSpBhHqJKB3Xngic
 TnihDkM+crXLDG9wJJmTPAhaRaxZkpNnliPbszXYId3B0J2RGXpRuZnY2K4DyffW7keqxEN1DCF
 YkjNlqHSdXCAgIM/8Nf6Fxc9zRjkvE/WJgSEau20Y4mPEUCyie8vs1h4y8f0cQ3G54O8XHC6yYv
 dnv8a7e6E4LIJw3vq5NhPyIF5KFd+jTmx7SPIv+d6H2WzehQy3rqwYHerYoBXHbuJ4YBUNvkqf9
 CT70spqwQlcAkBH6M8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170189
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

On 6/15/2026 12:34 PM, Pierrick Bouvier wrote:
> A coworker recently wrote a C++ plugin, and noticed interesting limitations of
> current API. Basically, the biggest issue is that the only way to maintain state
> in a plugin is by using global variables. The root cause is that some
> callback types can't transfer user data.
> 
> Also, he asked why some callbacks have a qemu_plugin_id_t, and some other don't.
> This excellent question exposed that we don't need this most of the time. And if
> needed, we can rely on user data instead.
> 
> For functional programmers here, it allows to have something similar to
> continuation-passing style, with all callbacks carrying data to next one.
> 
> This series modifies our callback types to make sure they all have a userdata,
> and none have a qemu_plugin_id. Existing C plugins don't need to change, and
> global variables can still exist.
> 
> After all those changes, we can finally implement a C++ plugin without any
> static variable (well, out of qemu_plugin_version), using an object and
> lambdas. This act as a demonstration of how we could write future plugins, and
> also, how we are finally on the edge to offer a proper native interface
> in Rust using closures.
> 
> v2
> --
> - fix wrong space line removal in patch 7
> - add patch to have consistent documentation for userdata parameter
> - style patch for C++: better commit description and add comments
>   about which constructions trigger a false positive
> 
> Pierrick Bouvier (26):
>   plugins: bump version
>   plugins: add userdata for qemu_plugin_{uninstall, reset}
>   plugins: add userdata to qemu_plugin_register_flush_cb
>   plugins: remove type qemu_plugin_simple_cb_t
>   plugins: remove qemu_plugin_id_t from qemu_plugin_udata_cb_t
>   plugins: remove qemu_plugin_id_t from qemu_plugin_vcpu_simple_cb_t
>   plugins: add userdata to qemu_plugin_register_vcpu_init_cb
>   plugins: add userdata to qemu_plugin_register_vcpu_exit_cb
>   plugins: add userdata to qemu_plugin_register_vcpu_idle_cb
>   plugins: add userdata to qemu_plugin_register_vcpu_resume_cb
>   plugins: add userdata to qemu_plugin_vcpu_for_each
>   plugins: remove type qemu_plugin_vcpu_simple_cb_t
>   plugins: add userdata to qemu_plugin_register_vcpu_discon_cb
>   plugins: remove qemu_plugin_id from qemu_plugin_vcpu_discon_cb_t
>   plugins: remove qemu_plugin_id from qemu_plugin_vcpu_tb_trans_cb_t
>   plugins: add userdata to qemu_plugin_vcpu_tb_trans_cb_t
>   plugins: remove qemu_plugin_id from qemu_plugin_vcpu_syscall_cb_t
>   plugins: add userdata to qemu_plugin_register_vcpu_syscall_cb
>   plugins: remove qemu_plugin_id from
>     qemu_plugin_vcpu_syscall_filter_cb_t
>   plugins: add userdata to qemu_plugin_register_vcpu_syscall_filter_cb
>   plugins: remove qemu_plugin_id from qemu_plugin_vcpu_syscall_ret_cb_t
>   plugins: add userdata to qemu_plugin_register_vcpu_syscall_ret_cb
>   plugins: use consistent parameter documentation for userdata
>   scripts/checkpatch: ignore spaces required around some operators in
>     C++
>   scripts/checkpatch: remove check on forbidden space before '[' in C++
>   plugins/cpp: register callbacks using captureless lambda
> 
>  contrib/plugins/bbv.c         |  10 +--
>  contrib/plugins/cache.c       |   6 +-
>  contrib/plugins/cflow.c       |   6 +-
>  contrib/plugins/cpp.cpp       |  90 ++++++++++++++++++++++-
>  contrib/plugins/drcov.c       |   6 +-
>  contrib/plugins/execlog.c     |  10 +--
>  contrib/plugins/hotblocks.c   |   6 +-
>  contrib/plugins/hotpages.c    |   6 +-
>  contrib/plugins/howvec.c      |   6 +-
>  contrib/plugins/hwprofile.c   |   6 +-
>  contrib/plugins/ips.c         |  14 ++--
>  contrib/plugins/lockstep.c    |  18 ++---
>  contrib/plugins/stoptrigger.c |   6 +-
>  contrib/plugins/traps.c       |   9 +--
>  contrib/plugins/uftrace.c     |  10 +--
>  include/plugins/qemu-plugin.h | 132 ++++++++++++++++++----------------
>  include/qemu/plugin.h         |   2 -
>  plugins/api.c                 |  40 ++++++-----
>  plugins/core.c                |  93 ++++++++++--------------
>  plugins/loader.c              |  13 ++--
>  plugins/plugin.h              |   5 +-
>  scripts/checkpatch.pl         |  28 +++++++-
>  tests/tcg/plugins/bb.c        |  10 +--
>  tests/tcg/plugins/discons.c   |  10 +--
>  tests/tcg/plugins/empty.c     |   4 +-
>  tests/tcg/plugins/inline.c    |   6 +-
>  tests/tcg/plugins/insn.c      |  10 +--
>  tests/tcg/plugins/mem.c       |   6 +-
>  tests/tcg/plugins/patch.c     |   4 +-
>  tests/tcg/plugins/registers.c |   4 +-
>  tests/tcg/plugins/reset.c     |  17 ++---
>  tests/tcg/plugins/setpc.c     |  10 +--
>  tests/tcg/plugins/syscall.c   |  22 +++---
>  33 files changed, 371 insertions(+), 254 deletions(-)
> 

This was merged into master (255745b9ad40df216c0c2334dc0ef4d81f00bc3e).

Regards,
Pierrick

