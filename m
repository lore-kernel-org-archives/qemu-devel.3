Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEF1C98310
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9T6U-0000FC-1F; Wed, 23 Sep 2026 15:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9T6Q-0000Ey-BT
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:58:03 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9T6O-0001KT-S6
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:58:02 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4c08393dfso942191a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790193478; x=1790798278; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AbFu2F1cuKRTvVldvcuaJ8hCnmjTiQs0Zqf93ICFLXA=;
 b=w48yAstV5DPp1ZuxfnMbfwEGCW0pZdbEMdMjrA3qrUA3KvOvTLJcyWAmfsMSJAYAd9
 CFC9Ralqbo1Hpf4L53W1YZG9da2iQQOahe9RDaDFcnOk9FEU4AUVtTbUtiBbBcJ0wA9A
 kJYtNf+X6RJcUW9QpQtI2FDqPj8mHb+8SF7yT3sOcFoka0+fIOfwwRAlvdbt3adn1rNI
 WI+wVg50UqsGW/PcBXfGqugBeG259yVhiGBJcVRFaOxzToFoMLzVPIzP6HjWeu2yakiw
 WdkMfoHgC+TGVuwXo864LPqtdkJ6yGL97Syc60llGCpbI9jGkIRSIcXF4ZrFnIxuxjuF
 GYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790193478; x=1790798278;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AbFu2F1cuKRTvVldvcuaJ8hCnmjTiQs0Zqf93ICFLXA=;
 b=OV+uSBph/FAx5GUCkYhx248Lmd7fUSPFPnDjWCUiOnTHBgoZXs+JQ/bm2wByasP1gl
 VM/h4u3XSfZYmyBWOoU1otbEQgORjP8HJcmxexPtbJaKtnoZGHtnqxaRyAC6j2oVRKJZ
 ECa5q+hvjVAjKTYAHFiETyLIBsq4NCaHZWwVgKeHgUXcpOilxvyrG6EIbhh3UB9g3HeG
 3ozIBkBLSoGs3i4y85zXYtaZBgIxtN+rdqsqJXjy1RryF+9xPFLrjqe48GCeeKgedxLX
 AdHPcVsPtuQtreczcE9nnevn9CQ1ClW2dQvbEwvTaoGxRxRt0aWJFyZyfmxxFfweJsN8
 xG2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQ7OFG0X6WL6mSNL72OMYNV8FgnSUtc+qwzqryG44b3xZzaya2HaizIHCX4HwqOoabhRChBYz3dfsG@nongnu.org
X-Gm-Message-State: AFuF++njjAbzPGceD2Ln1lJYMg0NtSWRVXCoNFOChK80NbaMxCE7BvVs
 IKxsBGLmZxccdjw/zUph1doVYryLrK9q8pcHq0iVCbEujPTtFlr8pQK3GPY0QfbawkU=
X-Gm-Gg: AYBFou3990p5LBhtFMjwFT+qYJJhNjxy1HBg3O2LvNkPKgfVop6VAgzybx7X9AnchcX
 75Fozkmk8o+DPRqMtBWzKnWoRFyruRUoQY9qZ3ri/gwxkvzYx5qhqeM3KivLKl1AKN2epGciOcH
 fwQoUTdojvur0nNxu1cFH0WofuZn12VwWq3buDiikuiDnntiomKy17HMiuiQQg9iBbgBgyMpAER
 cPDLtmt1+9RKXNsQQhqFUNaPilClAZxLHLBgi5HH3dxaiF0lghhnrJNtRGOcerYV3YdkirJI9x0
 bQEVQOsyl9CEOsGVZ8Tr/RyYDUwW/JBQyh9ZTVoQkowAzVTHpSVGxky2PUUswJUlIrr25ra2TLM
 +jm4vcRU5WfQ5LYDfZFQUTKdt+Dwjb/VFwBDISzhAybIm7ayNp28o1i9xuPFsffAiRbJ1Gmfjlm
 kkx8I75ETJTJmG8Jn9f3oyJ6hf4Gwm93uVcUQrPZ6zkB1rt+RriMNy+26yZDRCgic2Bjb7lfFg+
 5RQyGA4RKEAcoRA19dBJC76D8XBa1sVtwrfBDKFsyBqUtctteA=
X-Received: by 2002:a17:90b:390e:b0:3a0:2ffd:1a51 with SMTP id
 98e67ed59e1d1-3a0985663c0mr186640a91.10.1790193478342; 
 Wed, 23 Sep 2026 12:57:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a08f120ee7sm1078801a91.1.2026.09.23.12.57.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 12:57:57 -0700 (PDT)
Message-ID: <9141c0ba-d2d8-420a-98be-e8fc168a6c03@linaro.org>
Date: Wed, 23 Sep 2026 12:57:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] target/i386/tcg: decode REX2 prefix
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com, zhao1.liu@intel.com
References: <20260923173021.317809-1-pbonzini@redhat.com>
 <20260923173021.317809-10-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923173021.317809-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

On 9/23/26 10:30, Paolo Bonzini wrote:
> The REX2 prefix has two main complications: it does not apply
> to vector registers, and it disables or mutates some opcodes
> (thus needing separate decoding functions instead of decode_root
> and decode_0F).  Otherwise, all it does is extend s->rex_r,
> s->rex_w and s->rex_b to two bits.
> 
> Since REX2 provides the ability to access r16...r31, extend
> cpu_regs[] to CPU_NB_EREGS elements.
> 
> Reviewed-by: Chang S. Bae<chang.seok.bae@intel.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c      |  22 +++++-
>   target/i386/tcg/decode-new.c.inc | 114 +++++++++++++++++++++++++++++--
>   2 files changed, 126 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

