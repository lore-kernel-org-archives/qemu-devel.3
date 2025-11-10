Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3775CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 16:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIVCf-0001lw-Ho; Mon, 10 Nov 2025 11:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIVCV-0001KQ-Oe
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:57:07 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIVCU-0004ET-8D
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:57:07 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4775638d819so18715135e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 08:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762793824; x=1763398624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KOedLBU1IkQ8y0Y0T5uo86LDaAoJHzJo9/UetxwvTAM=;
 b=SSHmkd4oUzJ1VJt+pvmFdkotnnSzW/ijvnGwqBISGFxUOgg6n3RuucNCRCOuD7+eaf
 3Lk2MaAZ3gNFWuvC9Zopk3hO07ypiVhyXsunNDOLf2OEUnt4eaY7Y5cG3hmTXS6zLOq7
 GJhHN8ZmZxXURHGCnZ5TqKtkSHkJZTTZbwzI9u2rSI6QhAgm8TqM1BTwb2Mq5tXvmpP6
 El4b+oKbzalloILbPF6Or6NxZXx0QKpV5T33/pDoyveIx9I6ElbQos3ECSdYVMfdZ/NF
 ZMDH/ewacITNplTGKespvEHfKQ/MY4gJntDG9vVGjr2U8NmP+MzOh/5FMK44YSwT8ah5
 PZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762793824; x=1763398624;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KOedLBU1IkQ8y0Y0T5uo86LDaAoJHzJo9/UetxwvTAM=;
 b=SF/9iaKHn8pHOzEGNzHS2HHhgbTMd2LlaYPyuKoZWYBtireVSlo2U6XjGQfLApR0+L
 U5bXqB2JS6t6esYCWmkxjRd6SIsfSlJfJpVX4TcdS0e3YHwWoxC+hKUVcsbEupjoGjvO
 H7Hw15qFrisT9FrfPSjjEkdImHD9rgu3fjsTnJ46RxzsHa/p0/a9VkvPNfUQvE8FqOHj
 s+IPBCuvrUwgxV1CkdpHADFf8RdWgVwrvpPH++hRHB+1KDj1HH0hPWnPc06JsHlM/P3E
 QJdBMy2pbcXGLdwwyAntg8nnDSlOOsTEhcr5Wf3D2WyEyz7YGwsFkjQz2V3u1ns52vd5
 oRdg==
X-Gm-Message-State: AOJu0YzP1qBRuVTZleXLbxJtpbUKQRdekn8ua9yWBEklrbrip4iWQpw0
 p/C5D60E3hmrVk2A2ddgAm1GZqHGRk1g/ANQu5aOfkPjJXlK1vZYh3BvWalcBkSD8Gg6IPPi60q
 aiL594yw=
X-Gm-Gg: ASbGncuPTjbKoKS6+kNgLLT9dXnNiLBJupG6LKP4IWJFirA6LFI/NOrsfJEbIkavH9S
 vXnipT2CVjSOU4foOMR0VtSEDQ1Oa0Ltq/qY+ECe4qCzU7PH/DatcXzvO5b03niRp4/HUWqtiqJ
 z/xg2moDyZljG+WKTmNTSgqocNJvaZNPscht4pNGQEKzy0x5VEj+1l+nLZnu8pc6WajA663uuCf
 wBS5Azy2WdvuQjThWP6RQfAep29c3Hfotz0Xc5K5fjXXBbbx4PxyC0DTnB7LOA51r8O59tDaqbx
 JIXNJQaRh/V/JyzpHs/aATP59veP6KcmiQavIsdGAVa/HAJAGUvbAbGt2+i+q6v0eE8j/kN2OdA
 6I8dPv7amiznIgOtOb+0oB/LxbOOqVVWYX+KwHjsmeOpJ2nM/Rn8b6JC+M5OPRsw5pe+z+E5PpY
 hNqNq94NRoYRZVFqh87VwcrKDyHYI1
X-Google-Smtp-Source: AGHT+IFUb8yM6nVqtGpzFQhrnQiGAIsjMk0yS2mG3aKgnWuHIpyya30alSHvCAvYoV5fTbP6EFIDuQ==
X-Received: by 2002:a05:600c:4747:b0:477:7cac:50a6 with SMTP id
 5b1f17b1804b1-4777cac52ecmr41345275e9.33.1762793824540; 
 Mon, 10 Nov 2025 08:57:04 -0800 (PST)
Received: from [192.168.50.95] ([206.204.154.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47763e15481sm111844305e9.3.2025.11.10.08.57.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 08:57:04 -0800 (PST)
Message-ID: <26c8f656-8c65-42f0-9c69-f030ab774108@linaro.org>
Date: Mon, 10 Nov 2025 17:57:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/14] virtio,pci,pc: fixes for 10.2
To: qemu-devel@nongnu.org
References: <cover.1762698873.git.mst@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <cover.1762698873.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

On 11/9/25 15:35, Michael S. Tsirkin wrote:
> The following changes since commit 917ac07f9aef579b9538a81d45f45850aba42906:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2025-11-05 16:07:18 +0100)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 97f24a0496be9e0a7216fea1fa0d54c1db9066e2:
> 
>    vhost-user.rst: clarify when FDs can be sent (2025-11-09 08:25:53 -0500)
> 
> ----------------------------------------------------------------
> virtio,pci,pc: fixes for 10.2
> 
> small fixes all over the place.
> UDP tunnel and TSEG tweaks are kind of borderline,
> but I feel not making the change now will just add
> to compatibility headaches down the road.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

