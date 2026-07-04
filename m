Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9905C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 19:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg6BU-00068D-Ki; Sat, 04 Jul 2026 15:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg6BR-00067g-Bd
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 15:37:50 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg6BL-0005s9-R0
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 15:37:49 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-847aa193d98so1312744b3a.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 12:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783193859; x=1783798659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=35+V7xLyAyaGRfj8x3oOD0QHzC6TW1oRFvkPiwvyv/U=;
 b=Vqo9hsEzhY1wkMOcv5CE/+blUINqAOoqz91m0DkmkFm6adEvFvAgiTW+Vo1qvnvm0s
 0noK3ZVEFW4P1qM7SRQw/EG/bZeOEaADT3XYOQrlIGMhupb3wigI+dYUxJM3b81WMTfC
 7Yn57J50qqU7ii9eNHsXyFRsYylkeuJGh9OGtGDoHwxdeFzkhpchLD/rfu+AsdnJLt+p
 gafg8CKE3Dq0NfueqYKBGTsxTjdAWbxz7WzhVdodsiqYpygsOYl87Tpg0ZunpktzM+f4
 SgJ5zOWsSU7MVrF3kbLDIj9oMh7uL/ztCooxsuzTDjn6LU5T3E7BARquURS7sGI8Smr+
 upeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783193859; x=1783798659;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=35+V7xLyAyaGRfj8x3oOD0QHzC6TW1oRFvkPiwvyv/U=;
 b=FJOiy5PX91/ioJ2nqATR3xsZYShe6YV4Dzn7B1QCornwGAvFqmdk9qDCQ+wC7wUv5b
 jMkes7is8n8lN+vwAn3RMN3488JVEJWbsi5gpGMMzyRX5km6/o7Tqaeyz5uxoFDwxdiu
 S5q2k5P5pCtmMTxyOLRj8cZcMaSfndVHT2+GtgzjnOHTg06jzqUrcPUFsxk9gDwqZcwO
 +vpg8t4Lkm4KgI1v+1NKJ7tC7okMMp9lN2Quc7zcom6imuwgQtzhzYfbbOmm2kR5N8V2
 iBFwELamQgHghAlut0x78+EIIMYObOpWhN3BdewLh6eWC4TsYTmpEilipG2KEikZkWB3
 tZ3w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKDyXBgKRB3PvQhV476ZD76vggJz59KR9/asG8R3L3wRq+wvPUW8Unz+Kj50djDin5xJoVt8va50qE@nongnu.org
X-Gm-Message-State: AOJu0YxNOaVF/9SBHhukxBXdQsxuw0YA5OqGXGu7+dbccdkVv1+7iv6e
 pzhUSCajR76lDFNQed/ddVjAknAg/WMnwl+VRrNScKFUA/VDvPTfspOYAu7aOsjNmJc=
X-Gm-Gg: AfdE7cmt1rzxz2HOVNCTTvUPqZhWupYPAE6/J/ZBqECXE7cznRFaTu+KBROHVnn6/Bk
 88tdhpWsYO5aUMZ7Yn2i+Z0bhbRkoNS1m79FFI6uhxFL5zTBmz2K+76gOXy4m9zGZdcVIZXGNGd
 8ynNiWF2AKu39gRibNE21sVoCSC5F20ftRPInyOvwjFoAbh4ZzNcX1e7LicCJ1r/rEb0LE9VfuU
 esZVTEuPvfl0uRxXq+myIahEDvtzHcs7353yjR/HpXj3KbEgugPpWTarAjA6S6+z9xR+JmrXuc8
 2lJeZ7IPJD+vZc3BY1OeHrTS20kTKYmev/nflQSQZiSdoco0BzMNsBn8V4+TTsE6CHkFFmXRQWw
 +1SosUmk4T8vMxrmZTTg7tagV1ApstGzYYQSLwe/cruXpnWXccBVHbRacF7mgj1IX3ncJXiiEXD
 xW+ikdKNFQugU17liUaBKUGv8mT1s4cmjec5F5gK8vklwUbVvfc6yKIWs=
X-Received: by 2002:a05:6a00:3cc6:b0:847:1d73:f753 with SMTP id
 d2e1a72fcca58-847f6f4be80mr3969705b3a.45.1783193858858; 
 Sat, 04 Jul 2026 12:37:38 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6bb2753sm1534319b3a.23.2026.07.04.12.37.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2026 12:37:37 -0700 (PDT)
Message-ID: <28307c7e-1627-4c3d-939b-daee7a7f3331@linaro.org>
Date: Sat, 4 Jul 2026 12:37:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/33] gdbstub: Move supported_sstep_flags in
 AccelGdbConfig structure
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-s390x@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 alex.bennee@linaro.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
 <20260703163757.55500-14-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260703163757.55500-14-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 7/3/26 09:37, Philippe Mathieu-Daudé wrote:
> supported_sstep_flags are per-accelerators. Move them
> to a new AccelGdbConfig structure, still in GDBState.
> 
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   gdbstub/internals.h  |  3 ++-
>   include/qemu/accel.h |  9 +++++++++
>   gdbstub/gdbstub.c    | 10 +++++-----
>   3 files changed, 16 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> -    if (new_sstep_flags  & ~gdbserver_state.supported_sstep_flags) {
> +    if (new_sstep_flags  & ~gdbserver_state.accel_config.sstep_flags) {

Remove the double space while you're there?


r~

