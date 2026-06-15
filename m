Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6DECD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZDA0-0003Tc-JF; Mon, 15 Jun 2026 15:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD9x-0003JJ-RA
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:39:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD9v-0002Y2-VJ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:39:49 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ1URN1367680
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R6SI9H9HbEceqrx3xLVbm+ClAwj1CRaAZxdF7TjCrng=; b=kJi94uwAUvLoxm0w
 VWy7zyi6NoLXcMgbT6XdKaXyR67vQWZeVngRXD9aipHDY1qiYg/phswPJhU/w/ae
 3p4ulZK7MLdwS3jHUm5tS4KeZaduDaTay6cqOd1XFxs0oowjoJHzh1s9rLhHiSSN
 WhrEEh9g164hcxWK48afO2Me4UooFCorTpCi8RwI1NYqx5zL5tgL4zD/26DAPYK2
 yx/c9TplBOrHw6RoB1V1+jwjGx8BCLKe7AOxu8dVYFZhJ5YTe72GNPrWvaK274Ur
 +0CAfjxkPD4mHj/N8wNDAw2woPBeGLlzorWtlaHR0tbQ2tLs0DSBxzsgCiuEUHuI
 CRO8Ww==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etegutp08-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:39:46 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139553dd8acso3762043c88.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552386; x=1782157186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R6SI9H9HbEceqrx3xLVbm+ClAwj1CRaAZxdF7TjCrng=;
 b=QmJfm7WrYAySuXj8DHSbVz1xU1CoAQR81sdJao/WRZJXXenRo2w5h51edjmUuywtGr
 2e4rsVQyhobSbKy5blrwo2xgu2QClhlYDotMJZiYR3ohqZ6gtgWPyIgah57mHWDv3f39
 8Bxkx/3yFk5EwEuXZa+q7bnVnZyj0AP7bScOOnaGeNXjzwg5ZCWnXbyTrqibU4kkyFS8
 RtMwyWIeUxAnre2w8cfImIcTmTvMumdfBJXP/OpKE4o5tAAAqvGiSkv2FcaaVZi3gmio
 TMyFs+xf9pl0fS8fjinR/2ODqL6b9QKq0wrP3yO3gidUdMPFSDhgHzGzUebD8GD7WGeq
 MxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552386; x=1782157186;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R6SI9H9HbEceqrx3xLVbm+ClAwj1CRaAZxdF7TjCrng=;
 b=YMeyCJMPQuzNSa2SHAK1Vnk6pPDdPgMiVXsjvhtf0onp8WFyYZMmOy5WFiICk1tcl7
 qqgUfAK1Me/Kt/G6pVyU+ErYbmYoTFmY5mLg4O5TxEAe8NUA7CJzgb66sApIRdH0Lq8X
 Bv95D2vnV7CEL41dOjvbDjjTBOjUw0sBfIwUlMPvnTTPgFOFgHqQsYVSA+OLvtGefKoh
 aJCwoEw5fwU8rK/jeb3ZAAN8BK5mE1ESgwW/coLmgcuu+9ZlU2zV+rJr/+FGU/D5SgWq
 s5Mxr6bBZngq4FTGQkzuU1mVF5al1CK9teKqOzlVlXGrQNRARO6B05BPhEqUb6zHTcyX
 P8SQ==
X-Gm-Message-State: AOJu0YwY87tdIEQ+6XEB1qlyx/tVLkZf565EwAT8uBW2p0ynw8cuGYdM
 cHys4ECxsaVllt2nXwi5xtuc4l9n/8OK/W3WoMudxop7DxgDabaOPz0RJsM0MjGpFogx8mLeNHM
 AkHcOpnMiydEgWAFWMx/AqXOB9U26OesOPLkVITuPFwUX0DT9sCy4m3+D693JkCZvjjEn
X-Gm-Gg: Acq92OH0N1nB/EqrKV7WmiR4zzRjMCV2AVFhybn6Oblw+3Hz2u/Ye9jCgVBcytt8O09
 f987t0KTKczM4+IBijxpmTOCLDOMQ52RpEj/0e574UATDwdb9Nd2Dn52epXG6BX+SxtnKV2EtP/
 ME/LCGSDlRxsXje9lt63DxUhdI49JIk6R9iDwxI5N5l+u09pI1szSh+tDvcC/X4Eq2IJxTQa7AY
 0vN8seGyyqB+cuql8XhbaDNN7oTL/0cgJQe9eFFoeRUUu3t3yE9XMKadnlRQQw0O06QC9Af6X0S
 ePim3qLD5eSvDqyBz/wVpxIvLiBWOqKWmXiuJ9oKOk8ZOPIRAGhcrtEbx/2eiTs8epn3Exyhh9s
 kmRTGmJsfE8DrnesNS6z16efO7/XoqvqpSitHduuWo/hWTgOWGp67hw9PVbN0Lf54viVcmhU4mz
 cIOwnG7BM5tqq59g==
X-Received: by 2002:a05:7301:608a:b0:30a:e52f:9bcf with SMTP id
 5a478bee46e88-30ba5989838mr406182eec.10.1781552385632; 
 Mon, 15 Jun 2026 12:39:45 -0700 (PDT)
X-Received: by 2002:a05:7301:608a:b0:30a:e52f:9bcf with SMTP id
 5a478bee46e88-30ba5989838mr406162eec.10.1781552385057; 
 Mon, 15 Jun 2026 12:39:45 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d0357sm14878678eec.11.2026.06.15.12.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 12:39:44 -0700 (PDT)
Message-ID: <ac98094a-5cfe-47b2-a90c-334927d2fedd@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:39:43 -0700
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwOCBTYWx0ZWRfXygLt0BxL108V
 5csJqyQcF0FmwijH+ek6uKVCT3lHGbHIUqDqvAgB2oh4wKmdU3hcJRDK8+D8clDeI5E/RECDrd7
 ++ak8UcU/koq+1RTSSghaOJrh/3r9zUhGZ86awCajuHeYcSV4Ck1moaNB9zNxJn0eh7faEEp83B
 bsOR85Y5LfDpkJBlTSn9jzdv2JgWnjCW/6yN9lQN0xFTMy6tNeTzEc6RdBwmu7pHpdf/n3WMRVK
 bk7gNAQ5FPPymzfgDUgyuBn/0oqu89pfD52myXBRK20UVR6xazT8x9onSndZIr/uTivpS047wQr
 0cz7CsA1hwVKS6RuXNficN1xJXtDKjjc9op5EZ2q0zVYU6FcIgSwFdR3KcE3l7btTL72QXFBpJ3
 qUVdAxvkO8TWLNR0wgIFNcjPrueX9S6bf41mtVY2SRcWjinACh5CSO1VfJkCSDRbK/i9IthuXQb
 u5pEiHGfe6oxdj1iS9g==
X-Proofpoint-ORIG-GUID: 4pQHj1j3PkM6ywaa3WOfOwSdZR96sn27
X-Authority-Analysis: v=2.4 cv=HMvz0Itv c=1 sm=1 tr=0 ts=6a305502 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=1nqhs7xc5XLLtRwDZDwA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwOCBTYWx0ZWRfX0bzPpSB6cUV8
 PK4OwChuFnpHvZ0bBtE/CAgc7u/teFV4zfRGEdCBpexIHt331umZXLVqyu+ExiY9mcUbc+f5Q8d
 wafqxFAHBJ67EUyLRg7ggh9SC40aZV8=
X-Proofpoint-GUID: 4pQHj1j3PkM6ywaa3WOfOwSdZR96sn27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150208
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

Patches missing reviews are: 23, 24, 26.

Regards,
Pierrick

