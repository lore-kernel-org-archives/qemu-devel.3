Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC58CF43689
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgA4-0005R0-99; Fri, 17 Apr 2026 06:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDgA3-0005Qc-2r
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:10:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDgA0-0008V3-BZ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:10:54 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so4376655e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776420650; x=1777025450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ic2kaI0uKrtg/VOh1crcQp2SMlWMf8Rp/cFBLVjLTmU=;
 b=OVvkML/5c51QuTLebYd/BGeLAIq6tm9UatywPf2/coajwPSxtHr+/RJuJOh+YvN04g
 4qAyUv2PEQ66R7aOJh2VieRtdBBJW0ojI/DWH4dVrwe29pwwJ53UV+H2fTcpUsYGe9uW
 difUa1MdJuwZmfVYiy3mW1pdTqUNvq4+TNpn1hIPCnYC45bwTebS0cYIpZ8Nv7eu9btq
 oPf+0hJ/5/44Ee2Tu3dmfMcfWUivwXwSnjjPHXHXAQisj2UADqVVdXLcemQmRdKW7oaw
 81CfFxVFOaKcsBqsHPnLi35xY3VGHaHcteliLaVwnEG0CHzGmBGMwuV6tQtET7mK7Vb2
 Bd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776420650; x=1777025450;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ic2kaI0uKrtg/VOh1crcQp2SMlWMf8Rp/cFBLVjLTmU=;
 b=OKrWNKW27FOrD0G5/hhOG7DCUEvDQtel6wB50d057sz/jjluiX1l0UDdbb3WnId54g
 3Geba2adtOxiNjLYOhgwvOBBV6W2EwUlx+CGYcdOH2F+Kh+047h6myrie8Ezv72yuGBF
 sj13fid/CNUSSQm5ROt8+3j51OlJC4a+zoTmuwU+83l4Vrz4jfYzFHiKOJXy6vsRu40G
 Rb4XQsdZXUx05vGpJqvFEQ1fGYrmLpWDOdkIFkKFZyxxckDdVYpmRzYOK63F58rm/q04
 R93pzFKM1IPdRRrR9iaz3UscDTmvBDnHkUi6lf9GGrlvIEnIJORVoeRbHO5V1PRTJKzw
 dBvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8M8IqL3FLVyESKM0ZNGzDJFXUNT/4UTGySj6BoPGXclW/jA15dzMSqDPTDvQKYIGCOtrwoAtgD6XHI@nongnu.org
X-Gm-Message-State: AOJu0Yz8BB9XDobBGsZBQwzJMhdVxXc3J4MEKb4x3LsScMvxaPGAr+Cv
 XqyARZ+92lThZM3Bbw/J4phzggryRfRYqes7hy4IGdjsqst9y5QS/Sr7x00McHuI2kg=
X-Gm-Gg: AeBDiet5Jf8rLdQFNcwrDwJDc3T2T+RBdr73xjTwLAlp7UHdwPn2QFJncRYXXMst7NQ
 MYSIXSbjM4WRi5Y2Wy02wNJurTJRgu6+D+yPqH+49wfN5PWmiux8yHM5wu8oKgvGH0WOYfqac6i
 K6Jh2tV0YXZ0xDycMX3v3D0X9xX6ObWLxHLmY2tgtMu8zz6URl21HNDNcULop5ag5nWI92u9lxP
 IkbuhgHfXZP7uo4tdPUZDvvFCe978upyqL+wS5DxnZhAMhlgyvzMTiobvIPk6m0Q2SCEhj6tm0z
 e6Ut/oxwqe9/XvcfZP5NIXYAoeSnvRpAkGdNk20o8IQiuOJ5YuIKneKvY9b5tB8Gv2XMskR1z/O
 VhBRwTK3jqL1rxcKmmlv3UGiujcyRAgTVfX5O6KK3qHz8tySSHwvYaC6aBcoQicbp4VPFo6phAu
 3PLF0SWHOBqltze5Ejlg5HXT/LzSyjWbhQakw6UWOY58SCfXI/2FAXPzpVb2aefEafpGLHLf8hR
 Axu
X-Received: by 2002:a05:600c:190b:b0:488:ab5b:d711 with SMTP id
 5b1f17b1804b1-488fb77e3bfmr29158955e9.23.1776420650339; 
 Fri, 17 Apr 2026 03:10:50 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb74c789sm13060165e9.5.2026.04.17.03.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 03:10:48 -0700 (PDT)
Message-ID: <18f7f436-c146-4353-9ae6-7b124ee45b76@linaro.org>
Date: Fri, 17 Apr 2026 12:10:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] target/riscv: Add test for RISC-V BE
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260417100302.162260-1-djordje.todorovic@htecgroup.com>
 <20260417100302.162260-7-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260417100302.162260-7-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 17/4/26 12:03, Djordje Todorovic wrote:
> Add functional test for RISC-V big-endian.
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/riscv64/meson.build       |  1 +
>   tests/functional/riscv64/test_bigendian.py | 57 ++++++++++++++++++++++
>   2 files changed, 58 insertions(+)
>   create mode 100644 tests/functional/riscv64/test_bigendian.py

I'd name that test "test_endianness.py", anyway:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

