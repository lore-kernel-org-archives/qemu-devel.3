Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35D2CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRac-0004CW-Rn; Wed, 24 Jun 2026 13:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcRaR-0003yg-Cl
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:40:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcRaP-0004tG-5h
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:40:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso13356355e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782322827; x=1782927627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J88CqxmCzdV6fdyF6jAEmjfKI9GFOxO0HLu6uoYy2LU=;
 b=iaspK99Knribu04dVkUvc9RXRAKG5bphGvS7/B87jlWb5zdgW3nage23RjoHiNdEzU
 Scsxs1RFbmi7wRASAcrT8COHo4Jfu64f8VMkS3vINuEYBUk9ROCPUYP9dsJObNypGIY0
 K4FY6oHz4rum4jbQ9q9IuRwYw1edUFYW13Qlic+/qp88Uj9eGNtR2Xts797E/ONhoitC
 BjCxn08qlSobdr0ZnGkJNgEg1bKLTfMU3OXH6FvDD4MBJCJa0F5xwn4xLSJ23h3yYr+F
 zWobZChknYmDws8bJGXF4y7g/C9nu2osa175bBBXdFMTmo5hquxaowg1wdbSuy33klpu
 i7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782322827; x=1782927627;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J88CqxmCzdV6fdyF6jAEmjfKI9GFOxO0HLu6uoYy2LU=;
 b=IZMkVaEqT1lTTRvT8sqGMf39Fd8IURLnll6ga5ZRKxee7+orULD3pmXUydC3ycln0I
 yKwBZ1XzGRPvRvkhYYuFb7nNRnmTqQF01x0dkO4bX2+MJ/rfPjt/qLJSqywGL+ij2wRl
 zkO+Jvu8FUdW4myDy93fzkmmdz1UR1TvdsC75w1nJCx/9jIljuix/xeXcyloXRF2pClB
 9IsAqh9fkhIRqtzWjQKvmRFPF0EFJX++JzEyCuZjO9GPUp6qUFI3idyNSx70Z8gDGzN7
 K5iBqWIZS9w2w7lIRiHolTsYP3mYLSixFJTlF4F6uwuX1MRkg/1Tsz9K07nOURaX/Nnf
 H3aw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vFOfp4Two7D2g9EZEqbdNxWSFC6Z4yOl/51mWg9yOCh4BWgVhF586GIEGE0+b3D/FO8hmaJNzUyQG@nongnu.org
X-Gm-Message-State: AOJu0YxJxgMZLee5iR8aaUhQaGsD/4ck98FDLOzIDVwY8kPECUyHtcFq
 HWfFEn0Za0rXlwhhhfvKinHQBC9eBnSIiKhPdpeAbnOo3HkkT9t+lVv1aES5iYiDxhw=
X-Gm-Gg: AfdE7clGD6owBkGluHZtDRLsGPv8OiuOCS/LHREW3V8s2GCDcVcY5mipzSgnrp6A725
 sUqL32fwjNWLVkIm4BJb81dO9q5FbWAXRrYFQHEkhYN/F4sKz94xhLR/op07iV7UNbijVktLd1F
 5aKIOxvCCZzOMpNcxMSpl541VmRzO9FGrqdCQwop2SxG1lC/MFwhlL6XxpxUJQR8wcpkUHCuvzv
 XOSRAaXe9P9yO6cv1XPAU1yZk5etIU8cGhWkkkbNnxBGTezi7ZP4/YhOFmMZkWbjA7Zan/Hn3S1
 r6AQr4M9BiJ5y+79+gMDcRpD35GiZhQL6Qqmb7Bw0K/wlLiX8i+Ughegvt5LbwDxVtquR6uJCm8
 0BMGe0Uo1wuf69BTdT2MT96X+hAzatDsYTRyIQ7h8xXLW+7UDMdEhxzuOlo0FKoFzoCaPq/xsJ4
 jwppBIBhcx9d7J
X-Received: by 2002:a05:600c:c4a2:b0:492:59fe:4a15 with SMTP id
 5b1f17b1804b1-49260873710mr58590515e9.24.1782322827412; 
 Wed, 24 Jun 2026 10:40:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926404ee91sm8156405e9.14.2026.06.24.10.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:40:25 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E1AD5F807;
 Wed, 24 Jun 2026 18:40:24 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,  qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 stefanha@gmail.com,  Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: Re: [PATCH] tests/docker: add flex and bison to emsdk-wasm64-cross
In-Reply-To: <dd48e432-ab04-42e7-a88f-231d1c9d55fa@oss.qualcomm.com>
 ("Philippe =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 24 Jun 2026
 08:34:19 +0200")
References: <20260624054832.610697-1-brian.cain@oss.qualcomm.com>
 <dd48e432-ab04-42e7-a88f-231d1c9d55fa@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 24 Jun 2026 18:40:24 +0100
Message-ID: <87wlvnj0qf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> On 24/6/26 07:48, Brian Cain wrote:
>> The hexagon idef-parser requires flex and bison as host build
>> tools.  Add them to the emsdk-wasm64-cross container image so that
>> wasm64 builds including hexagon-softmmu can find them.
>> Link:
>> https://lore.kernel.org/qemu-devel/CAJSP0QVk6wsOnPAspC4YfXRp90saKibQfD4M=
k-44-RQo0k=3Dz3w@mail.gmail.com/
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 2 ++
>>   1 file changed, 2 insertions(+)
>> diff --git a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
>> b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
>> index 8a924816f92..5debbc77d08 100644
>> --- a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
>> +++ b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
>> @@ -19,7 +19,9 @@ ENV CXXFLAGS=3D"$CFLAGS"
>>   ENV LDFLAGS=3D"-sWASM_BIGINT -sASYNCIFY=3D1 -L$TARGET/lib"
>>   RUN apt-get update && apt-get install -y \
>>       autoconf \
>> +    bison \
>>       build-essential \
>> +    flex \
>>       libglib2.0-dev \
>>       libtool \
>>       pkgconf \
>
> Maybe emsdk-wasm64 should have been added to lci-tool first.
> (not your responsibility).

I don't think that will be easy on account of emsdk having to build a
bunch of libraries to support building QEMU. If a distro provides a
better cross environment for wasm64 then we could try.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

