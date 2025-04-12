Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B46C369AE
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Apr 2025 17:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3eOX-0000zX-D1; Sat, 12 Apr 2025 13:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u3eOU-0000tH-FZ
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 13:11:51 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u3eOT-0004Si-0E
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 13:11:50 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22403cbb47fso32025825ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Apr 2025 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744477907; x=1745082707; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9lif+I060r52wAK9pX8fs3xbCy/IJKgEJm1ZH7uGFlw=;
 b=ovpQ/Rtjc/7ZNT+zPhw3txi8z0eeaWcmBOVokc+/MCCp/jGGa156b12hF6rpFiwkzN
 toVTFbD/O+Vam6hwzTfBjb50RKg3ZU/0iztma9wDx/vy1obTQ/f5IAPjdwIiEFMNbeYI
 ygfjI0L9FebaYWHjHvO8LLUR2yGNnUNxqcoKtYIJs1HpV+tG8GMWHvxlsYwJ2NSv+YX+
 FnROBIzUUHwFTyydYyjfvVfAKJjRt+UkMXaOggt+s4EckIFAq+3jXWT/NgJvbyY9P1y6
 RWq1VKvd4cY3zeLVmNxyMvZsGbRR4hDXko6vWKScVbSh8I8sRUtTAhw/XitAQ2A+ozHa
 vucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744477907; x=1745082707;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9lif+I060r52wAK9pX8fs3xbCy/IJKgEJm1ZH7uGFlw=;
 b=APrQG08qWwS7UwVIySrKLHcDDdfIsvLylo46366EzpUKoMpR3Dl+Nj3q7TSY/K4YvO
 iAu8AT7dZkuAK3aUhLWafn1gNWdcRwNNCmvxXFJYHDUjCQfwQkEWuex1jZm1b29I+ATk
 S/zZqdycKBFH7hDHWx6fZ/C9qAbeb495WLW5d6vMVnDLnzrfw+gu0sUioa/WCxS0QGNG
 vv4I+Qc73ODeKY3l5Ua1oyX6pomOFkcojS/ASAmf7q1jrawc95EmbGz1IAZ5T2rjptbQ
 wtlMBFVtjglJ8w6d2F1mjhA7zCczqj7ntafmuotCojI2SRW5DlQQQY4P4NsNEXLRnbJ5
 Z9Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBZM9xpgUNZC/ERaMVLdIoloAtnWA5MkVC55IGRx1xWTJQ7dUPwxXfV24oCmnIQBKrQq2R4Lvf1s/J@nongnu.org
X-Gm-Message-State: AOJu0YymraIa9Z6PloNzL4mdJrfIro1/eO7q93Wt9Nl/IeEtTLxQNWdR
 n/orWWKRuxQSujbUk9Thqu6QrjNhXjQ3oD03GRRDiHYOQClqYyWEensOqELvpwa/5LhKy9DuPyI
 s
X-Gm-Gg: ASbGncuWsPIRZ1qJKn2EZD+N2jZU0TmXmwQAkgLTxBHD1lKaUrL9Xrxbhmw5FQ8TUbM
 FZhpRlYjpOT63TUVgyoKqbgxja/+Y4Pc4I+uwekHtOsOQCc9K9vnyRvqWU70CcJSO4IwXsgjjIs
 3vveqAEcDtmVRnyzxTbxr5/8VFEy6hAfIar8ErNzepitEwuN/mdv6z10BXmLyBPgChBzAs1AN0N
 dfmmfbTsqTesUk67mOK/BrlVai1EblvBDYND9Tnb/gT2ra8LvDlLuJoQUROQXRGahKqSKaPA8d6
 ahGspgVIMFiCE4v8TBK+6Wy+qOoatQ2RUO3bCaALRJGuaSAi9IpYXGFSPZ7CGsqR7UaiA6LXdKJ
 rc2MwDEg=
X-Google-Smtp-Source: AGHT+IHBTTgkola2/9LW8V8Tl9qWWLlq7TM2e5LKnkvDqd3X5SnMo1nfCfZ+v0nHEvP+WGgfAdfYvQ==
X-Received: by 2002:a17:902:eb8d:b0:223:5e54:c521 with SMTP id
 d9443c01a7336-22bea3f1542mr97886545ad.0.1744477907597; 
 Sat, 12 Apr 2025 10:11:47 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbcc6sm69325625ad.247.2025.04.12.10.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Apr 2025 10:11:46 -0700 (PDT)
Message-ID: <271cec07-4d99-49b8-9ebd-e1623cd59a95@linaro.org>
Date: Sat, 12 Apr 2025 10:11:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/arm: fix arm_cpu_get_phys_page_attrs_debug
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 alex.bennee@linaro.org, qemu-arm@nongnu.org,
 Yannis Bolliger <yannis.bolliger@protonmail.com>
References: <20250410210022.809905-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250410210022.809905-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/10/25 14:00, Pierrick Bouvier wrote:
> Pierrick Bouvier (4):
>    target/arm/ptw: extract arm_mmu_idx_to_security_space
>    target/arm/ptw: get current security_space for current mmu_idx
>    target/arm/ptw: extract arm_cpu_get_phys_page
>    target/arm/ptw: fix arm_cpu_get_phys_page_attrs_debug

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

