Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B858ECA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 07:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyjd-0003ew-0j; Mon, 01 Sep 2025 03:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usyjb-0003eB-3i
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:13:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usyjY-0000px-QE
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:13:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45b8b7ac427so3757615e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 00:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756710820; x=1757315620; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FXgc0OUU86gs6S5lrwZ3Cvh9hVW7i/4WSG9GNIaOFf8=;
 b=jQo/qxfHfgp86geaBaqV0NwzGV9InBB5n9zdHUn/LaKTdKEIRTNiHX0q/+h6LpBRy5
 0rxSLvM8ASKhT/du+cye0NJZ+cqKuN7FjZZZX0vkoaJzOri/2c3mdJkF11y4Sp47a1Hc
 oH635LgPO8demQtC/pxJUJkX55t63/lZn21JCbNb19SdfhgNPx5hDhQdiUtFYeBcn2Bb
 jdNOu7CB7H7F2eNIujpRFSQI/eVAJROmKfmas1Ivv9zT3iCGxBox8Jy4yNHP2lkZ+EFd
 7EXtPllCwzS77SKamqtPm2YbkLHsYNYqif+tVZst9srH4bXTZSApDLG8rHLHoEP7bwS2
 fLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756710820; x=1757315620;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FXgc0OUU86gs6S5lrwZ3Cvh9hVW7i/4WSG9GNIaOFf8=;
 b=XQ5fnSdMVCf+oaK+9FsvQ/gv2OxLCuUIKVuCure1xR07vlqoaTkBAhe73cJ280e+KY
 zoIzDdLNwMRx3IfDfMuErDBhVcWeTlENevJGHJrl/LJ/ITEpeMxzb/AQM5V2YvTeT0qx
 rbPrWXgyC6CvWZ7p3Xq+9BCMlByhSlCJUv9GX+PMhfMq0LAygHIbiRbi4OQ1RSTsTo9F
 TedfLA5p9NtIXYGosCXhF35/YJvYtyXoTgpSJGA5lqaRdORx38ibKrwNnbiNUbJhd7Xd
 5GkUfBUVnYdvXtNCCjNk69u+Jpz9t59f519JTfpnf8Y9fmsEqmXuzrrRMKv3W7AblYT9
 7CRg==
X-Gm-Message-State: AOJu0Yw9t6dv8t/VDnf4k4rmYETWZ478whvFVThgxF/x9AwZ8duBEG1l
 vhUYi4EEwOSw1oKXi8BWFl6v/kgQ1izrAbSucyyHkVZWUa1L+oluU5dWMniPV/lRWPuKNAXjnKH
 9ZFIS
X-Gm-Gg: ASbGncv59D9Zmc0mp0ian9AZZN+VBKumWxc43A6HMvt00bjh1zDxkicMLmWnQ0FlDAJ
 V4KQnQpqGyMTo6x50Ncau4fWvEjJFngWZr+KnTtyzsMVydeKNVyDqak2er+uVKnC1px0ikoij53
 Cewu94CNg1zJJ1VRymLSmwyGDkoP/h9rJL9bBio/f1z+hIolLIdQFlzkIr3WBzydYHIdJnXsWO6
 R7EbicYoNPBdg9rr4M+mshzA3CuuoD4VUhs1Xd4fY19m2aRgTkxjPjYtjvfcSpJiF+0X9SbhCRu
 988QILr2xzBaRclWyWJlm6mHkF/WTF0ph420YnW6hOipYnr8pryOhok9ApcEIMe4ABXkgbgLQB6
 yUjOrJ1Tr9qYK+IaHwa7+gx5LOCho2gOBxO7eqASWFy7MxPVKqEZ8k7BvIFIVlKesLsWRMf/Xsq
 oH
X-Google-Smtp-Source: AGHT+IHcS0pDEzBHr4n+QLIkVae7K5otINeLlW5agIVICA+SwkuBDNvvc8KEUEUZTGJ1xtN9x1iwhg==
X-Received: by 2002:a05:600c:4513:b0:45b:7eb4:cee4 with SMTP id
 5b1f17b1804b1-45b8557b769mr49188205e9.32.1756710820150; 
 Mon, 01 Sep 2025 00:13:40 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e898b99sm142822975e9.19.2025.09.01.00.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 00:13:39 -0700 (PDT)
Message-ID: <03fdb83f-ebbc-4fe3-800b-40e145fab5f5@linaro.org>
Date: Mon, 1 Sep 2025 09:13:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/mips: Remove mipssim machine and mipsnet device
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250828143800.49842-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250828143800.49842-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 28/8/25 16:37, Philippe Mathieu-Daudé wrote:
> mipssim machine (single user of  mipsnet device) is
> deprecated since v10.0; remove for 10.2.
> 
> Philippe Mathieu-Daudé (2):
>    hw/mips: Remove mipssim machine
>    hw/net: Remove mipsnet device model

Series queued.

