Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CC1CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 19:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc76j-0003Js-Pq; Tue, 23 Jun 2026 15:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc76h-0003Jg-Bs
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 15:48:27 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc76e-0000Yt-Iu
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 15:48:26 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2c7d329fe93so1365905ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782244103; x=1782848903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n8BDBOpR4hjirlK13bJV9eULKnWw1Ao6kCC8qJQlV5Y=;
 b=WpVeZ9AouZqH6RUMLHOLBP2Rfo4k0bECO1auqLNM3rtX6rTDtbOag+8B9ont4Xmhsw
 9DSfxmNakEaaCP9OaaZIkAKCOqysneOF+SuIbQiH8Xp9sQK963xWbpoNqRTWF3G0d+ZF
 1RxT7wiSl4p9OChADZQWfJrd9vt2A3SVOx7WA8h13pTZ9EYfvSQXjUZNUYaxDvRSbvJW
 5iAZN/zNwjVyWL3Un3KwYG7D2OzQ+HBDSqvKZ6+O9x8PyL2Gxc77q6fKFLpShOcHYqA5
 pLrrFupXsBZhxPSI8/QZlOfEOn2aTAyNZv4ZK5b+3RSk/ojGSYDYr2nqhVyB6z9k7bd5
 GMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782244103; x=1782848903;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n8BDBOpR4hjirlK13bJV9eULKnWw1Ao6kCC8qJQlV5Y=;
 b=TeFHYPBOVoKZfRINX9ZiTbIgUTpU9q6mycOI0feMlhrThEHTCc7DvrBNwYW3C/GZC0
 EJp/HSFJkdY21LALnUNvH6wenslPnfPn+Yp3m79exDZIQ5Z27Y7HbSfreSXCFYJ1Lkl5
 NyB/wdsVN9NgtcOhqeNDYeR7eC9NgvpD+0GeubDa4wm5Oc76X+TtlKAAtbmGTm5rTrIA
 ByfKom2YSKLbm45YpoxbcHRfp/xdbG5AvkWsKel/n+3yWohxoRZuS0fHzRBDwxiUyFYD
 gCo2H6TiP4AhVwqsOcpJAJ1l5lxlIqzXs8jNGn77vAxWy/PdFZvNuPyc2wiDDSi+xu7y
 j75A==
X-Gm-Message-State: AOJu0YzrcaumBmO5ByrKFy4WiMzYuXwJCw/FpKO6ftrDuMdsgjIoT1dl
 JRop8lDNeM5gMrpbecgznLWBHa5spAR9cn3YVfR3oG1eleEoMc4nQArQs5GWI9gDXe8=
X-Gm-Gg: AfdE7ckPhXk79usv+WP+G6xgWeqBtXeG5fd2EG5pDrZ22DtHFvoJdI4WmVpJ9fSQbam
 lupmoJ3d4Abh8/qfygrjf+/FwHsYGtR3T9oQthtUdajLQrtJTBifSTRSdh8o3kO65/Opg4XeyFC
 HKDSjSc1bHdO62zFdYNFZH61gy+9/Czs/fAymtSpCDnYYIrvmk5dj2Vu8Y4Ct0BqWVhD22FebdF
 jHGlAy2OhyqmoLBD34BuOVx/lWVMTV5/2OOtkXE6zkN07QwrfqlxFlqQIRzkgccUXtPwXn622JE
 u7/v2OK3Sz/mz6f9Nnq8u1QB29BcU33BY97zkF11SvW3bQ+PX8nDAgTwLGtJ/LArfwl9+5Y4vw0
 5Ugje0Ex2iDbZ2B/pLeV1jThi0nOgndTfhgVryfiEzjqvx0khrJlFiKs06AEuRUz2Wf1tSvL7pj
 agZwyOu00ma6ebd2Q5Km4E4fNg0zUaCItYcGguKaEtuughaPB9mPKTgTMIOt832P++iRU7
X-Received: by 2002:a17:902:ecc9:b0:2bf:305a:310b with SMTP id
 d9443c01a7336-2c7e13bd5dbmr3217045ad.1.1782244102529; 
 Tue, 23 Jun 2026 12:48:22 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7439f85f1sm118851945ad.42.2026.06.23.12.48.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 12:48:22 -0700 (PDT)
Message-ID: <c9c087f9-63db-4510-8694-a4588b02ab47@linaro.org>
Date: Tue, 23 Jun 2026 12:48:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/75] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
 <CAJSP0QVk6wsOnPAspC4YfXRp90saKibQfD4Mk-44-RQo0k=z3w@mail.gmail.com>
 <841ee482-4d6b-4f07-bcf3-011478c13fb7@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <841ee482-4d6b-4f07-bcf3-011478c13fb7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 6/23/26 10:57, Brian Cain wrote:
> 
> On 6/23/2026 12:22 PM, Stefan Hajnoczi wrote:
>> On Mon, Jun 22, 2026 at 6:33 PM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>>> The following changes since commit b83371668192a705b878e909c5ae9c1233cbd5fb:
>>>
>>>    Merge tag 'pbouvier/pr/plugins-20260618' of https://gitlab.com/p-b-o/qemu into 
>>> staging (2026-06-19 15:00:01 -0400)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://github.com/qualcomm/qemu tags/pull-hex-20260622
>>>
>>> for you to fetch changes up to 4f876e63daaa40bea293c2eeced2ac6418b3d13a:
>>>
>>>    target/hexagon/idef-parser: open input file in binary mode (2026-06-22 14:30:23 -0700)
>>>
>>> ----------------------------------------------------------------
>>> hex queue - sysemu
>>>
>>> v2 PR: Fix for wasm build error in `target/hexagon/meson.build`:
>>>
>>>      ../target/hexagon/meson.build:285:47: ERROR: Program 'emscripten' not
>>>      found or not executable
>> Hi Brian,
>> There is a wasm build failure:
>>
>> Run-time dependency libffi found: YES 3.5.2
>> Program scripts/decodetree.py found: YES
>> (/builds/qemu-project/qemu/build/pyvenv/bin/python3
>> /builds/qemu-project/qemu/scripts/decodetree.py)
>> Program ../scripts/feature_to_c.py found: YES
>> (/builds/qemu-project/qemu/build/pyvenv/bin/python3
>> /builds/qemu-project/qemu/gdbstub/../scripts/feature_to_c.py)
>> Program flex found: NO
>> ../target/hexagon/meson.build:294:8: ERROR: Program 'flex' not found
>> or not executable
> 
> hmm - I think this should be coming from the host and not the target.

Need an update to emsdk-wasm64-cross.docker


r~

