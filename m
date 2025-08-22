Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92ECDCA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 14:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upT5l-0002mc-KW; Fri, 22 Aug 2025 10:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upT5i-0002lX-KF
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:50:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upT5b-0003Tp-1V
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:50:04 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45a1b0cbbbaso18077555e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 07:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755874194; x=1756478994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VVaNZ3qwSE3EO0jJ+/VzAx8KiCpbx0+AhUXp2fCptXo=;
 b=R6dGy+2ublvHQ+KApLK41Z6MrrnnDRvWuSMSbjiBgKntVam81ndlkxe/rgHoUtjgTs
 WJV+Gj7nffn5eyYit+yxYtwn2ITsebrLEtf2C9IR6K0TSImHr8/pQmX2n3m9nnKN/iC0
 +IWWQXT09t9uc/LPOzGjfdpBXAwmxZz/mUN2eOC0Eh/SpGbvyiGs0iT98NCy0TLhhLSz
 zXaPGkhtGRGFUEhrdgkbtWcjLyqY9q22Hg8hJhaASHOFP4fFlb1/KXtRZ5SEjbijTx1/
 ht3120GuRI2flO1b9RVmbe5DJyOHI4law3GBtH9x/3doD5729fuzjRG40vJoIol97SfD
 Jl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755874194; x=1756478994;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VVaNZ3qwSE3EO0jJ+/VzAx8KiCpbx0+AhUXp2fCptXo=;
 b=e27P7GM5TuMOlnQKkh96xKIwQ120Ik2HMw43918I3b1v2MiFRcthFuGlfW+M2cnSy3
 exPMustvOHUm8mn0ZTcmo4cddmsrOnUCxPnx+K1oRUaEeFqp9o4qCi6nxPwRiMtrVBOf
 P1ObALWZGgMa8RP1JjfylzfafAO1eW0v6KeuuaCV/MIpe7sQxz+6CDNZL+lsecSLgum+
 qgz0EV2C90trfW8AKPUBSW8YgEyyilo4NjVtRnTrcj+71+qHNMx1tMfJJc6S5r36AeIW
 NYeJ//kvymbc0bcG6z1tKRersliNB9yMwFmsNbZLTk6C/c4h2rXRNaxd18VNudAO/Zlw
 X50A==
X-Gm-Message-State: AOJu0Yyj46Ywmbn1Nmhv0qG7rUNmTsrrh/ObwIx3h/R/wvFtksmRtdc3
 3MsIL66D65TfPiVqtihW7UfcuEkThMXAs/DbdngbzNFOmOsvyzXr9OC1EV0GhbX2HKE=
X-Gm-Gg: ASbGncudePDvF20uC2FSUoy88Mv5dtrX0wJfkf81kPUj2DkhbTAjqiPGAtIBH/DZkNZ
 d/bTEZBZSav2WZejp/wh4ic3c62c1HPFDZNJMngWqMe6NwN4kP86HbwpUpK6R3GaSX5NBNrVr8T
 J/xqBokfRGeWhtvGnnLAn44OuiA3oNFe/45KBvYXsog7VIyWmKegLW+F1Kx46lTMh4sYJFzRSmX
 16FtEE9/w4L9AWjLZHul+9YiPU9x+onagea05+1xG4ZoivryndQN0WFYIbjbMedtStHdYG8lino
 ImPxbDlzrQwq85zxXGmaG6wzVk16PPO+X+T4Ow6AToKYAJENKUThAQxFZLH9skO5ewmPWVPkqln
 tLoXrBTYVF6QjPHkOvuqd/J+ViVgE7mL/BE69LVY5qpYHMZIz/RUydSjRfRuSyVprDQ2VE/M=
X-Google-Smtp-Source: AGHT+IGJt+7ahKlymQW4t+VOVV/lx2tWR9YEV5TMEQf6ssNPrjO71PBgyqxWw63NI+76uwZxI0oITw==
X-Received: by 2002:a05:600c:4715:b0:458:aed1:f82c with SMTP id
 5b1f17b1804b1-45b517d3b30mr25330625e9.22.1755874194069; 
 Fri, 22 Aug 2025 07:49:54 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c0777896absm15640033f8f.50.2025.08.22.07.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 07:49:53 -0700 (PDT)
Message-ID: <592c3338-77f7-4393-aef3-7670e6ec90fc@linaro.org>
Date: Fri, 22 Aug 2025 16:49:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] docker: Remove 32-bit MIPS toolchain from
 debian-all-test image
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aleksandar Rikalo <arikalo@gmail.com>,
 Riku Voipio <riku.voipio@iki.fi>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250820142108.46639-1-philmd@linaro.org>
 <20250820142108.46639-2-philmd@linaro.org> <87ect3k3c4.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87ect3k3c4.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 22/8/25 13:23, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> In commit d3322023bfe ("configure: unify again the case arms in
>> probe_target_compiler") we lost coverage of 32-bit MIPS with the
>> debian-all-test image. No need to keep installing the toolchain.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/docker/dockerfiles/debian-all-test-cross.docker | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
>> index 420a4e33e60..bc74d65a634 100644
>> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
>> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
>> @@ -40,14 +40,10 @@ ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
>>           libc6-dev-arm64-cross \
>>           gcc-arm-linux-gnueabihf \
>>           libc6-dev-armhf-cross \
>> -        gcc-mips-linux-gnu \
>> -        libc6-dev-mips-cross \
>>           gcc-mips64-linux-gnuabi64 \
>>           libc6-dev-mips64-cross \
>>           gcc-mips64el-linux-gnuabi64 \
>>           libc6-dev-mips64el-cross \
>> -        gcc-mipsel-linux-gnu \
>> -        libc6-dev-mipsel-cross \
>>           gcc-powerpc64le-linux-gnu \
>>           libc6-dev-ppc64el-cross \
>>           gcc-riscv64-linux-gnu \
> 
> You also need to remove the references in configure:
> 
>        hppa|m68k|mips|riscv64|sparc64)
>          container_image=debian-all-test-cross
>          ;;

OK.

>        mips64)
>          container_image=debian-all-test-cross
>          container_cross_prefix=mips64-linux-gnuabi64-
>          ;;

We aren't removing mips64 yet. We will but since the reason is
different, it will be in another series.

