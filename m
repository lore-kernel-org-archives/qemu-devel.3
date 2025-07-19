Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EF2C83F34
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Jul 2025 04:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucyog-0003Cm-VS; Sat, 19 Jul 2025 00:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ucylj-00086r-RG
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 00:01:53 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ucyli-0007gZ-2o
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 00:01:51 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-23694cec0feso26060055ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 21:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752897709; x=1753502509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tnNfbDJoI2DUXMlBlzWoW0B7THEIBo+0lwWKlcYSUq8=;
 b=fb/XMvX3G1XSTaMTY5ON7zVx4GmFH4imeybJ6dLoNJwzPVwAB8Arx7z05qXaIfrqE4
 1dXZ2y+UOgzL10cgFILHlLQf7faCqmlAM4FEYSSKnVrCo35tQniLD4xnGuYD4NT+1/+5
 wlCLECVoyeSSQBNSbIwE1EhHpw/rYXAwXSuQk7kzRp7ORA+4QgRnyL1t4X5bjzemHANu
 sFTapjWNIj9PdLtYrZA+ckEVN27Jk2dtnni/jiScX17ABgNc8PlYTwISvfiaxsOR5EWi
 Ps9AkiMcbGWSM/vFDDWxOBANhmq/jfOIruZUHMmDp1F+m4a/Kv/YfKUp1Oafs2oCdcQ0
 9nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752897709; x=1753502509;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tnNfbDJoI2DUXMlBlzWoW0B7THEIBo+0lwWKlcYSUq8=;
 b=aBDv8pyROhRgKDhSVyVCiWlVyw1XwZMpHRWRRW91oY6G1Gmv8DW/zh9NXXRz5T4lQG
 ABC4XnKc0VG7bxZ91GxYcdOdPx15SpJoZomg0O3W7tOoY/UnoZn5/11A+1wRPaYEd2zH
 dg8c98RjnDrjdUaCYY+qXmgE8z52Clu0q5dB0oTecV7xLuAUHr5aaWNVlOc+4ii3c26s
 5QG5qdIA23a30JF6xS7uAHngVubERYrVeHsQXpRmxsKZwzZTjDmFZRPxNRFWj/+pJhKY
 DPR80XoRy/ECl5xEO+72jBR5YNjnEcHfZc7eI1fcPF/NVMEpc+x1kD6k+gyQ/mobA7Sc
 UOQQ==
X-Gm-Message-State: AOJu0YzOTwokSiUnC4KAq1/lpbjVJ9u//VQVxHewar5LXNovlTjNp7ad
 +ioGIG7LcEKszH5FqiB0M4Rlty4W+FDZHa3Uy5ojJ+lLFEltMsHUy7n2JPDSBfF/yWJm4I+z9qM
 HFMKgKn4=
X-Gm-Gg: ASbGncs1rsTOrI0O2NZHDo3mo/imrFEhRwf5ZGyAcYXjBaoGyeLhUzVAneeV3FZ1PnX
 jZB18jAkrESCi9ABe+kRa6HF0O/zLd3czT4WQL7XscV0XTajAmNBPZD6onauFxkRAWeI5s4tplC
 stMCeAwAbPV3yeVz/KLBfRI60W7nvlPvGkKflAT2FgDWI4dqrVa3T6DY3YslT7KKTIn5PQsA4IQ
 ylW43/xgXdwBF1jSus1fKNU+rs+qvI358fnkHANE/fj1d++8ppu2UYgfzTbp0NQPBIlxigs86Jx
 LmDlZVfax42sQLbme7o7BdtMxlczHD6PrvLKey9/jzlqHDGaLbg7212vx9LSuMGYr18WPdMdsBw
 CK3b/qXaSaUYFNc3Q2AErL8b/s6vb7/Vbh7Ma9divCIonIQ==
X-Google-Smtp-Source: AGHT+IGpx2yP8heDo3rmIux2Glbsb7g+AxqENEMefDd+fWjLMWwpNK9NKQU0j6eoXwqtnmdGzVjQYg==
X-Received: by 2002:a17:903:2b0f:b0:236:8df7:b30a with SMTP id
 d9443c01a7336-23e24ec70c4mr199924975ad.1.1752897708752; 
 Fri, 18 Jul 2025 21:01:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6cfdbdsm21155675ad.150.2025.07.18.21.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 21:01:48 -0700 (PDT)
Message-ID: <8b49b4a0-feba-4e75-a78b-dcc3aa33091a@linaro.org>
Date: Fri, 18 Jul 2025 21:01:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] aarch64: update test images with new trusted firmware
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, jean-philippe@linaro.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, gustavo.romero@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org
References: <20250715212335.2215509-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250715212335.2215509-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 7/15/25 2:23 PM, Pierrick Bouvier wrote:
> The FEAT_MEC series [1] introduces FEAT_TCR2 and FEAT_SCTLR2.
> TF-A needs to be aware of that change to allow accesses to those registers, and
> thus must be patched [2] to enable this for QEMU platforms.
> 
> Concerned test images need to be updated to allow them to boot.
> 
> [1] https://lore.kernel.org/qemu-devel/20250714155836.1514748-1-richard.henderson@linaro.org/
> [2] https://git.codelinaro.org/linaro/dcap/tf-a/trusted-firmware-a/-/commit/c8836cec14213bf92dae79d353bc345254a0a31e
> 
> Note: [2] will be upstreamed in TF-A once associated series on QEMU side is
> merged.
> 
> Pierrick Bouvier (2):
>    tests/functional/test_aarch64_device_passthrough: update image
>    tests/functional/test_aarch64_rme: update image
> 
>   tests/functional/test_aarch64_device_passthrough.py | 9 +++++----
>   tests/functional/test_aarch64_rme_sbsaref.py        | 9 +++++----
>   tests/functional/test_aarch64_rme_virt.py           | 9 +++++----
>   3 files changed, 15 insertions(+), 12 deletions(-)
> 

Superseded this with v2:
https://lore.kernel.org/qemu-devel/20250719035838.2284029-1-pierrick.bouvier@linaro.org/T/#t

Regards,
Pierrick

