Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1279D2502F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 07:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veqFl-0002Qa-Si; Sun, 11 Jan 2026 02:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veqFk-0002QD-KH
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 02:52:48 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veqFi-0003IU-93
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 02:52:48 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-34be2be4b7cso2791041a91.3
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 23:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768117964; x=1768722764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SEeSTgm7Tcfb79fz11fqjFg7zq5pHy0h092GyRg0F2A=;
 b=uORmUad4LD5a9mdYIBGlfav4h276OH0OWlI5enLP60adgqbpG5fLF6HBvCauKzzVep
 MBw5YVEa5W2dBVfOvRPGdAnpoPApy6nxaJmJMogiF89BWycySwWks07ZioosBJtoa0wH
 L5/iMvnh5EghcqmDxQZ/g/JJ1o2Q7ohjVYVmJvZUodib3UszS9r/MEGMI/XA61S06lyP
 J0BPaV4aNvnm2oCGnoBTuKXk1pYZoBDZ4RRRiucYis1osoOJ41qR0Wbj4i4jCTJCJLws
 rNx16V1m390NwTBPJW/umok9PNUqL6biwIAqn5L55u+U6LF6RgDDQAnCX/ktHvDNjYa4
 AC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768117964; x=1768722764;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SEeSTgm7Tcfb79fz11fqjFg7zq5pHy0h092GyRg0F2A=;
 b=NcWOHoRdehbEnPOTKBaXqMDeT6x9zLRM8RWFLvVLPbxh+3zksBKc6vY/FOpmCjIHD6
 T0icYAg90qwgQX76bY9SLq/KAO3jsXHMzDoZJbF3R+TJwm71i9CuovO1NIf6ni0DrMTF
 RKyionK02/khf+G31vzbt0HiCzxrL91Ke7Y9oL53mRYiGzZxNP9aMyVjFC30EtE1HATK
 6f4p2APPAL9E//7XmIut3XnVbEznsyySbWW8qOIOUBQ8B5J/zK0SHo7E4X02KtT5hkCl
 vCzmSXshXmqebYjjxawGdsIqAKGCXm3mODS6zj+VHupFot+VoqZM5R0qFrWn7GWxBdg3
 Ggqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAZwrAPushRt7OKm2PNf8sM22xE5Ywtcf1cI53xT+lfecI/o8AzVElA0Puft4o7HkgIaAwRsshoIf5@nongnu.org
X-Gm-Message-State: AOJu0Yz3x3/e6M1xkCtRxIdPMHEv8y1+N+SudBnPaEYZpaYD9h/5rszf
 /77MNZrtEGoaYPz3TycDugtpahcmh/tArw7MuHvHGzCDvbmDQ9yeAF34XSf8kAz40+A=
X-Gm-Gg: AY/fxX5xzU3IXjXPlxrOG5gTbKf1nn1Y3BXoI1mGbCDIsrsLmvy6VZ3CjT4e687JI7g
 S5fjziEPLvxhhFmQojONMjQGc1zCKe8OvlOvbwhgUAW2HjWf5Z57FpQv7t9up/kfxmYV69D1q53
 Wq2u64K1NJ5UX5MeI2S+JD1tt4TN+93rWsWwGgxFpQI6jMDK6gDAvWAGGmwIdzx3lJ9BUjR7cav
 YnuaJV2kpdMq3d5bDrYw3MKESybdsv6VNSSSGPXsSj2pz66D9Ej0SoQgmLZCP2bzH+hzb9UX+bG
 HDDhEqj7CkMERZrP8lBwoLryuBo8k5MOJNFr8Lj5cMJS5w8u8avSO+pf+feIPq/KDQeCgicfGYs
 HeAVegxEO/vqQVlO0oTMY2JH09VEC+c1J52bubtv69uFj3/8nhylA/ME+taD6Yh2MgeZYHVF7at
 5AejmQiwFMsBUwdTVQE3csSMXExA==
X-Google-Smtp-Source: AGHT+IHh5dOL340vnZQtxeK0XL1LuM+YwiaXz3rCAfh7BCPlgGW5KIbsnM5riPtddxu1f1FJp151qA==
X-Received: by 2002:a17:90b:1ccd:b0:34c:c866:81f2 with SMTP id
 98e67ed59e1d1-34f68b4dfe1mr13090464a91.4.1768117964432; 
 Sat, 10 Jan 2026 23:52:44 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81c96d762f8sm9195774b3a.64.2026.01.10.23.52.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 23:52:44 -0800 (PST)
Message-ID: <f9ad7045-9e66-4271-b3d9-006958824f55@linaro.org>
Date: Sun, 11 Jan 2026 18:52:35 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/12] target/m68k: introduce env->reset_pc
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108143423.1378674-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 1/9/26 01:34, Alex Bennée wrote:
> To transition CPUs to use the multi-phase resettable logic we need to
> stash some information for the reset handlers. Arm does this with
> arm_boot_info but for m68k all we really need is the PC we should
> reset to.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/m68k/cpu.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index d9db6a486a8..fda015c4b7b 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -155,6 +155,7 @@ typedef struct CPUArchState {
>   
>       /* Fields from here on are preserved across CPU reset. */
>       uint64_t features;
> +    uint32_t reset_pc;
>   } CPUM68KState;
>   
>   /*

I think this ought to merge with something else.
Just adding the field is clearly incomplete.

r~

