Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150C0CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEYD8-00012k-LZ; Wed, 07 Oct 2026 16:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEYD6-00012E-0C
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:25:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEYD3-0003Kx-At
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:25:55 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697JOLjU038970
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 20:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +N1Cy01PH8bYn+xyS8dTvSdYJxHXVkq5SLvQYOZs6DY=; b=okeoFDenELBL03J/
 oe3wiOEJXzKd6TEdGe59n1j5ycNrzYdsW11Mnq0oe/2nK5vJfjhjllWFCvYwy299
 cDrRI+oCUBDeDgMkGjrC89muxhHqOJcYw0edB/nh23K4tpOpzP4k4bQb2Yc2+sRD
 8/Rn9RlhK6okP4Igj6yrRZMqmkDj2IAh7ppbM8RZY2/5zZZjTSs7uaUXMb1dIO1M
 jbIF83RKYZdYtL6+MXV5uVbpZfBFTGFUvijykhHEyPM7pr+JAghyMg5MX7AvD/SE
 V5ChdKgK+WCKI2W7s39wn1pzSMAvedEiV2mnwxjp6sPm/FDQj2Vah2tLNtmniZv7
 QYk6TA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c1s40w6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 20:25:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34ef0362d95so8290705eec.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 13:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791404750; x=1792009550; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+N1Cy01PH8bYn+xyS8dTvSdYJxHXVkq5SLvQYOZs6DY=;
 b=Mlcg0hgS2MzjfR7x18m6KL6Ti6/kyKLgJd35Nm56Z+NL0uOE9In6idvJSIRLudqfUP
 ErMywKK9IYNm3u9B9+zQLlUEYUfQzQEEUxJf3UTi1LgN8r1YxZfWvonIwv1/MbNNHtON
 y7rWb1VlxXv3hyV5w7iKcG6DItElSH9ScmpnP8sVIH/0QQlrixvtC86g5E6NJh/YbTL1
 MmZsgcpzGTNV2O6LveTMxVQ2RxSklUp0RtQLO4iYy9Ae46wK7X7jlYIFCpmKrwXqEWeQ
 AXkoUh+/gaK30OnqEzpqJAy48xYzbX3NFuLeiE2nLtcT2Due84p5dLr7Gv33WRGnYbW1
 3mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791404750; x=1792009550;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+N1Cy01PH8bYn+xyS8dTvSdYJxHXVkq5SLvQYOZs6DY=;
 b=dEhVk91HNeSh71WU2pYofmDnc2aTWeIRESsF9p5l1Y5Unvm3zW+a1SEsBXZNkGIbLK
 jPQYgu91T5kStlIFz6pXQLaiW1Pmom0a+vyFEnxiOvvqK+Wmr8HBPyuRzYp3gvM2Lhj4
 F9Om4YvHAuUQlhFX9MbCKXZ6/a+LqfXKkUg6X2TbZIg4+J4ZilhQOH/RV/7IsRBs2UdD
 pvhsWSxbXxVypwND0wIwnn80siJ6lxFWgB/rqOgFnDLL7pkSZqZDQtHHJCrxMTz3LRxa
 aA3N3dD1q68T0OtdbJ1FY3VBBO8RwGxXMwxo6DJaeR0pMrI1OG/eTYFgeLxr5aSPoKP0
 nIMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgiGyf5kGNQQ5VTg97iaWIC7IUSNzssoPuAa6RrC8jryQT8IsK8wncH9Iv98jIRlxxw1Hhn+PLyMIW@nongnu.org
X-Gm-Message-State: AFuF++kUOyONGbxzuysT+5jxZGQBZV/ru1q+Bo3hCd2D4LWVZceQQHzC
 Yvzma1bz6EJwmUE2/Ll0zSIiidY/ZoZkhMPnuE12q/XolsKL/F6k7SgqSc68ITGGMQaRjZUUZHa
 1swf0IhEtSoW54V1HaUShvprSyIPzfsTtDNw/uAFuS4qQuCNmZY8Jn3PYoQ==
X-Gm-Gg: AYBFou3bGwTmTWplyG1kQ4s6aOKKfkW2qhoi5gmudVcUl3nwPc82tF5w5UxOyN77Wx2
 cEAW4fyER2OWUYeOhGexTbUaUhianEZe/H0LYJXVkjumUQnJJ1TobgwerQgi8OnwiRA56M+FfJA
 kcG3Kfuu/o3ZEf7TOXETBRA2W++y+GGe4+9nEFrwVTSbwO4CdM+tUXF7/vrP4PpEkgUsFQBS3Oz
 MFrvNWI+izWo6YnPqehBsiDgkOPbtumiiyWL0pc1LtmKQOy1GxqZpl/L2X+BxG2VlU9uK+ANqwu
 9O6fSGzA5jeObyqCzs/Gjw7UOGoZxiTbqjoE5ZqY0RFZH9EJNgow1sfycOihHy2yeEvjKYv5eQv
 57lfbhHau7wC85shmN1EM6l8hnTgiP25VpY/P4E8HtA7GiNVK7Uhs2fFAUqul5Pev3Ydbog==
X-Received: by 2002:a05:7022:43a5:b0:14c:c947:6afb with SMTP id
 a92af1059eb24-1620374e1bfmr5197625c88.15.1791404749990; 
 Wed, 07 Oct 2026 13:25:49 -0700 (PDT)
X-Received: by 2002:a05:7022:43a5:b0:14c:c947:6afb with SMTP id
 a92af1059eb24-1620374e1bfmr5197572c88.15.1791404749381; 
 Wed, 07 Oct 2026 13:25:49 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-163020ba64bsm13718365c88.23.2026.10.07.13.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 13:25:48 -0700 (PDT)
Message-ID: <2390b3d7-6918-41e3-8532-c19de4cdd1ff@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 13:25:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] qom: pass TargetInfo to the is_available callback
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007115253.328-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: odEKZnStyYPZyzjX45GkyMsbu09NK-03
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA4MSBTYWx0ZWRfX/+FlPUi+0ftV
 DDBQSY/obr0cCezF8T+gxX1uMqJdS3S80Sx/ywoKsA4vWO2onaeOjGDSg5A0OpNypAtZlw5qHD8
 CJUBcJXaJRqrS5t9TJ5iacq+iI5Tp0ugb5okUgvMkLDVK0njTO8eNOTxe6rTvbIsd+fPgQUc8mQ
 xmoLrqcsFNnnaqeUtYpbB1MBoLkvMuxn+MKvPMYO7XxO44nMTFn3B04zbrlkP5R/ZXCImUasw/p
 8kdnChjhsfIO2oYqM8rceUw+9rwvLcClbbbRGgc5zKgdERsN3RcHQ8u/fp4EqGWmy2Jd6trDGjq
 LYFPm9Ab2PWMuqNtk8U2/VtNu8gSm50iJye8AcreSIg4mSOnQ6o+jYMFRzd9jYwJ4PwL2EK520i
 h9T0dQq6w6uvimM1L0FFD/3sq5gq1+LkfmnKaRXCk4+Vs7XS0S1bl2TtBgJI3UsywVtl9d+6yEn
 n2wjiWw0gFUWeTIBXqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA4MSBTYWx0ZWRfX3BxuSStnoyTH
 obQXluu54HfHZK7EJxobM74kJoK9P6qTC94+NhPvB1xnd2XCGa+7PhZ5O8LHvU4k49hKCetkiX0
 1sfyj6dToT/TZ6TzhyXPRb4xVOuuJ9Y=
X-Proofpoint-GUID: odEKZnStyYPZyzjX45GkyMsbu09NK-03
X-Authority-Analysis: v=2.4 cv=NatzRGD4 c=1 sm=1 tr=0 ts=6ac6aace cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=W3QROBFJkTBO-5vcJEQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070081
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

On 10/7/2026 4:47 AM, Yonggang Luo wrote:
> This allows a combined binary to register machine types from all its targets.
> Consequently, QMP `query-machines` can return machine entries from every
> target, even when `none` is selected. For example, a client can query the
> combined machine list with:
> 
> ```json
> { "execute": "query-machines" }
> ```
> 
> The returned list includes the registered machine classes from all linked
> targets. This is separate from selecting a machine: with `-target none`,
> `-M virt` reports the targets that provide `virt` instead of choosing one
> arbitrarily:
> 
> ```text
> qemu-system -target none -M virt
> unsupported machine type: "virt" for target "none"
> Available for targets:
>   aarch64
>   arm
> ```
>

From the long conversation on a previous thread, I thought we reached
the conclusion that if we didn't expose any ambiguous name, then -target
option is unnecessary, or maybe I got lost on track of this thread.

https://lore.kernel.org/qemu-devel/ar_coT44h5-zJPVV@redhat.com/

I'm not sure which semantic we want to have with -target none. If there
is no ambiguous name registered, we just don't need it at all. It's a
win-win IMHO.

> It moves target_info() to a shared location so object.c can call it when
> checking machine availability. The series also replaces QOM-based target-info
> registration with a constructor list and passes TargetInfo to the
> is_available callback.
> 
> Target metadata and architecture checks are generated from the configured
> targets, there is too much arch to write biiolperate code. doing this for easier
> Add TargetInfo* to is_available
> 
> The target-info API and implementation are shared, rather than compiled
> separately for every target.
> 
> This series removes the per-target source files "configs/targets/*.c".
> Their target-specific parameters are collected in a generated
> target-info-def.c for each softmmu target. This lays the groundwork for
> QEMU system builds in which target-info-def.c is the only target-specific
> source file compiled for each target. Using the same filename lets
> meson.build handle these definitions uniformly.
> 
> The series adds unit-test coverage for target info and multi-target builds.
> 
> Pierrick Bouvier (2):
>   configs/targets: remove target info definitions
>   target-info: rename target-info-stub.c in target-info-def.c
> 
> Yonggang Luo (6):
>   target-info: rename target-info-impl.h to target-info-def.h
>   target-info: replace QOM registration with a constructor list
>   tests/unit: add target-info coverage for multi-target builds
>   meson: load all target .mak files into target_mak_all
>   target-info: Replace handwritten architecture checks with generated
>     code
>   qom: pass TargetInfo to is_available for later use
> 
>  MAINTAINERS                             |   2 +-
>  configs/targets/aarch64-softmmu.c       |  25 ------
>  configs/targets/arm-softmmu.c           |  25 ------
>  configs/targets/meson.build             |   6 --
>  configs/targets/riscv32-softmmu.c       |  24 -----
>  configs/targets/riscv64-softmmu.c       |  24 -----
>  hw/arm/aspeed_ast27x0-fc.c              |   2 +-
>  hw/arm/aspeed_ast27x0_evb.c             |   4 +-
>  hw/arm/raspi.c                          |   4 +-
>  hw/arm/raspi4b.c                        |   2 +-
>  hw/arm/virt.c                           |   4 +-
>  hw/m68k/virt.c                          |   4 +-
>  hw/or1k/virt.c                          |   2 +-
>  include/hw/core/cpu.h                   |   2 +-
>  include/qemu/module.h                   |   1 -
>  include/qemu/target-info-def.h          |  88 ++++++++++++++++++
>  include/qemu/target-info-impl.h         |  42 ---------
>  include/qemu/target-info-init.h         |  53 -----------
>  include/qemu/target-info-qom.h          |  31 -------
>  include/qemu/target-info.h              |  87 ++++--------------
>  include/qom/object.h                    |  12 ++-
>  meson.build                             |  52 ++++++++---
>  page-vary-common.c                      |   2 +-
>  page-vary-system.c                      |   2 +-
>  qom/object.c                            |   3 +-
>  scripts/gen-target-info.py              |  99 ++++++++++++++++++++
>  system/vl.c                             |   4 -
>  target-info-stub.c => target-info-def.c |   3 +-
>  target-info-qom.c                       |  60 -------------
>  target-info.c                           | 115 ++++++++++++------------
>  tests/qtest/fuzz/fuzz.c                 |   3 -
>  tests/unit/meson.build                  |   4 +
>  tests/unit/test-multi-target.c          |  12 +--
>  tests/unit/test-target-info.c           |  38 ++++++++
>  34 files changed, 379 insertions(+), 462 deletions(-)
>  delete mode 100644 configs/targets/aarch64-softmmu.c
>  delete mode 100644 configs/targets/arm-softmmu.c
>  delete mode 100644 configs/targets/meson.build
>  delete mode 100644 configs/targets/riscv32-softmmu.c
>  delete mode 100644 configs/targets/riscv64-softmmu.c
>  create mode 100644 include/qemu/target-info-def.h
>  delete mode 100644 include/qemu/target-info-impl.h
>  delete mode 100644 include/qemu/target-info-init.h
>  delete mode 100644 include/qemu/target-info-qom.h
>  create mode 100644 scripts/gen-target-info.py
>  rename target-info-stub.c => target-info-def.c (94%)
>  delete mode 100644 target-info-qom.c
>  create mode 100644 tests/unit/test-target-info.c
> 


