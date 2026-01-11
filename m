Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD23D25028
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 00:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vejDS-0007Zk-7y; Sat, 10 Jan 2026 19:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vejDQ-0007ZV-Rm
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:21:56 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vejDP-0001dW-Ee
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:21:56 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81345800791so2742929b3a.0
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 16:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768090914; x=1768695714; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=57l8tGMaB3pkQ1sC2hPf6dwFowH+YnO6lCNK5hhSQaY=;
 b=uzq6yO02K1AxAphIyi4Ou/1rUgkeVW8nnWkkEKJivRdRIBdT01x+BTsL42B9/v/Sxa
 RV2adJWlcKsRnoGSdqaGJXuL8CfT90c5EMrGarK/gZgwb3eNpstvSlYMolVUqcFvYTn4
 piT3GcLKaZ9etWqMHj22FiLmgOdx5QRKZRJkoEacDWHFEjoLcdvANFtVwZNRFO8VWNiA
 RnQ0H2p30QQnYNQWiONHUKouPL8lwhJ3mG/Du5jHXg7Wy7GVttmasBbDGpfWz813LtWE
 0Ky0Sk1/q8Jba6gCDAKuM20BR/VdgwCEIzijrwnfwdc48HA+qvVZWrImzdXMxeVeN42W
 TpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768090914; x=1768695714;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=57l8tGMaB3pkQ1sC2hPf6dwFowH+YnO6lCNK5hhSQaY=;
 b=ahVHk/sz60zk4T3nyjsN+zzvH+RMJRmLR6id3i7FJJHXdM8qbhYev5a/Ui0bNJNvEF
 qH9yciCUTf9qfK+DePKD7pYx+t4M0TPOl21m+nWdsYbJ+Phv77/Bnc0503WtWufhtFsh
 KBLedLxZcbAvrdmYyPvOMcuz68U3/rJZuz4VCCIVqVCQugLMs5VTj++GQjDFoF0RdIS0
 whkkQTCCkHQLIyhWXbUmaChDe0XglhcTCgWh+s0B1SPYbjJa2Ma8FgJAU3y/DO46fzxD
 GSa0upk/rEWzwypKhBPAfjFpjTOXgByh1rbqebQ5mPcRu7+iNwgGWbCqoIPZnI+0ZEZn
 KeuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMSwX6CXKcAfMC7d+3NeE8HmuTGTjGmKq7ECU+a6f5PtZWmpgyodLB2a2g4cBDRLHkmFby+xfRBv0L@nongnu.org
X-Gm-Message-State: AOJu0YxlxDAaO/etGV9XTYMpv3I22+tk/oyESOGob4UUypfRQIXvi96M
 vjUZBanFZboRyKHISeW1Wvl3+gRRHBtAMCSAPQFOXkMyX4UE/s/W1MeJSV4HVV7abP4=
X-Gm-Gg: AY/fxX5UeFgaly2ur9A4wWc7Tjrj10zlGDVeMUjzWswUjVWhpWQ98o3AmvExxnAJArd
 1MsV3KBV93BLzPwMtGk5T4LRdAdO3GKturR9u03/AGY+i+3oDuOQRTxAevknvAWuQJd0FkfC7Ed
 VgeA2pMgsOup3TZPGQXlYZJ+wqLfw365fnRS9oqf7OvHWjWF3m9onQjEKvZTrZzU6tHfqSyoq8+
 Fv8fX7WXi6Q5LdC2djzKfjBBzxUTHiHoAj3QPH7ukx3Zjb7N+rPPvy/lnkkVkAlUIcPPhdbITUR
 xuP09iL5i3gkgECG0f4sDgIA6bEa34ICgpGLFlwIoENbEu9sH6S5mwOfjBrmI42Ihzl//JIZ6lA
 pPY/ilsrvsjGbsSdm+adJDShh7l1VCCzWi2ebb81QVPNv5XDqsSfzmVDykJYEL89PlNucrM6wkM
 K014iIsfB7vf//iSIVU7OTX9uZhg==
X-Google-Smtp-Source: AGHT+IFXOrdZNPvFAD8aiQOEcE1TH3Qvp4aEtst9laQ/iqSzgz+HVh1FftTB1eQqtsARNp0xetoiRA==
X-Received: by 2002:a05:6a20:9184:b0:34f:2f38:cad9 with SMTP id
 adf61e73a8af0-3898f976c60mr13343548637.53.1768090913640; 
 Sat, 10 Jan 2026 16:21:53 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc8d2952dsm1034919a12.17.2026.01.10.16.21.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 16:21:53 -0800 (PST)
Message-ID: <7822a02f-d233-4014-bc64-688c88aff846@linaro.org>
Date: Sun, 11 Jan 2026 11:21:47 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: disable libatomic with GCC >= 16
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260108141407.2151817-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108141407.2151817-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 1/9/26 01:14, Daniel P. Berrangé wrote:
> Historically it was required to ask for libatomic explicitly with
> -latomic, but with GCC >= 16 apps will get linked to libatomic
> whether they ask for it or not.
> 
> This invalidates QEMU's check for atomic op support for int128
> which explicitly does NOT want to use the libatomic impl. As a
> result with GCC >= 16, QEMU is now getting linked to libatomic
> and is activating CONFIG_ATOMIC128. This in turn exposes a bug
> in GCC's libatomic.a static buld which is incompatible with the
> use of -static-pie leading to build failures like:
> 
>      /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/16/libatomic.a(cas_16_.o): relocation R_X86_64_32 against hidden symbol `libat_compare_exchange_16_i1' can not be used when making a PIE object
>      /usr/bin/ld: failed to set dynamic section sizes: bad value
> collect2: error: ld returned 1 exit status
> 
> The newly introduced -fno-link-libatomic flag can be used to
> disable the new automatic linking of libatomic. Setting this in
> qemu_isa_flags early on ensures that the check for CONFIG_ATOMIC128
> still works correctly.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

And queued.


r~

