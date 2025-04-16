Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79432C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4yzV-0005kY-5T; Wed, 16 Apr 2025 05:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4yzF-0005fC-QO
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:23:18 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4yzC-00010l-91
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:23:16 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39ee5ac4321so307475f8f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744795392; x=1745400192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XoImJa+fjliBajtT+2WRyNvLKOrfk0bxtRwFuQd95Yg=;
 b=YTwgQhtnlQnVK3BGIcEti8+brCKDt0+piSZxk3ueMpitGUA6f2pjSaUO+Zo/ZOSXPJ
 Fe3/mm0XF5Mjvz6GtUxlXfIfgGShWKWFEokS9r2drn16q4+h0ahpE7O9HvQJnYdd4IrB
 5NOSgTngjnDa6lyoYQidw2c4nT2MgU+Eb/bHN4bxKRHJLtoAy2MGiOG84I5/iH5/dinJ
 cZ5KfNxc7lkHQiEMeczjHaOTL4kXVkg842lhOh+/Wm+4O7pMUx8syChtMKjiuBUaSyAB
 wJtlU81FIZmrShNLu4Sbysvkzen8nbf0RYUJaTuWIxvdAdPnRTGrgl01ktJvIDWcqx6J
 1cbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744795392; x=1745400192;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XoImJa+fjliBajtT+2WRyNvLKOrfk0bxtRwFuQd95Yg=;
 b=nStSgpfgKSAUEtQSY9d8FPIn4yg6I7EcbT6mmH5CfyMfAVU63fYO03J9MY8WsR+l3D
 fKJKPOVUMC8tKYhpz42kVCnivXmcdMeXFuLkW0SXr9xzCwUyUQaC5frvaTsDJRsYD5Pl
 etQhUkkli+CbyFSUZGH32Z0qXDV2WGJtFR2oQi5yxTVjIl+97T7ZAlx9QyS/qF/MaVTT
 PAsDpsf+Nuk87FRYszZE9LYp4IkK0ik63CAC2fFak83yEC2oxtouBWgJvA7/yBl9oDiy
 NvMfAODKnF7sr4Hd0t4Iqvd/QgXxfnSzIsjnBKNCeC21yo+6avnW5CaROgneG38YWxHc
 eUPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8mblzCUjhjc+s9JNUPFbf0Qiy4CSq5wg1BcBA5cJRDyX3vTgP40b72gMEbJgip8Hv7G6ZG8mRJ+Yt@nongnu.org
X-Gm-Message-State: AOJu0Yxo7IacIebE9CB01NZ6qJRnjZfrQKJqIwoLRdH4PpToDaRFsIoB
 dz5xkLNq3CHhogczJeZ1/d2gsRA7nrVnepnfZGePz9WrZ/Z6FVHRlsoXSMU9VPc=
X-Gm-Gg: ASbGnctsm1MChcvpD52V85jxFL482bkk9E547F2e0d1lhKFjL9WDKQSttgCGsPAdHsf
 0vjeCfZJyypjj27P+WRb5ZfD7Dj3Nipwh97rq2BJ+UvIB+A2Km+LIDW9vi/o24CUa0UdNzeNYv7
 rBzyQRyImPh4O2kOCtD/kmOltGAC9wtx/sdS9f7IfPV891zmQfPBoZxULonT3VTSysKgfTJRuOu
 EFCVl8tQR/PQejsK5F2IcOTCcTIYHKBdpYncLA/1YBmccAhBRiWZdzGlLE5cyvslXgG89EkviD1
 UlFuIGj2O4u+A4/lEejw4P6yh1I60trD5WkDbAnb1eZd8mcL19WVU3/f9+apd+ie1wBtoI4+ExP
 HcQIWHhmi7ZgXlQ==
X-Google-Smtp-Source: AGHT+IGa7RGQyM2l9Tq/ih49pAHM7+HApoQxnN2Cd45RmYTPDotEOrhSfrtvQ6JTX++TzJDKj63q1g==
X-Received: by 2002:a05:6000:2584:b0:39e:cbd2:986b with SMTP id
 ffacd0b85a97d-39ee5b10eddmr912645f8f.7.1744795392174; 
 Wed, 16 Apr 2025 02:23:12 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96407esm16736471f8f.17.2025.04.16.02.23.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 02:23:11 -0700 (PDT)
Message-ID: <91dc0def-2e17-40c0-a66a-c5992f10eb3e@linaro.org>
Date: Wed, 16 Apr 2025 11:23:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/19] gitlab: Enable CI for wasm build
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <16055d17cadcb5f4c23203218cb8fc3fa81d1754.1744787186.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <16055d17cadcb5f4c23203218cb8fc3fa81d1754.1744787186.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/4/25 10:14, Kohei Tokunaga wrote:
> Add GitLab CI job that builds QEMU using emscripten. The build runs in the
> added Dockerfile that contains dependencies (glib, libffi, pixman, zlib)
> compiled by emscripten.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   .gitlab-ci.d/buildtest-template.yml           |  27 ++++
>   .gitlab-ci.d/buildtest.yml                    |   9 ++
>   .gitlab-ci.d/container-cross.yml              |   5 +
>   .../dockerfiles/emsdk-wasm32-cross.docker     | 145 ++++++++++++++++++
>   4 files changed, 186 insertions(+)
>   create mode 100644 tests/docker/dockerfiles/emsdk-wasm32-cross.docker

Probably nitpicking, I'd add the Dockerfile first, then the GitLab job
in another patch.

