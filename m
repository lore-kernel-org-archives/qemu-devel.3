Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A30D3EE74
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 15:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viwYF-0001eD-MJ; Thu, 22 Jan 2026 10:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viwYE-0001dM-Dc
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 10:24:50 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viwYC-0007cK-TR
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 10:24:50 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4801c731d0aso9221105e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 07:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769095487; x=1769700287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d9NZQMaKjw/9PZ8DPzJVFbLPhmGM1hoSma/eUU87F38=;
 b=HwjV+o5D6nivz3F6xdEPQw3AZU8pl1RQTMDga3jqXUx6/x4XBVn7B7O2y4+1tek6BB
 GGlnAAx44uC9QuuhJ7buSzCBBICQ9J/GAFCo5cJn1o6CQVwN2QCdbqLIFsGudrIIor1A
 tenKBTcSOHZiHCcAyktwf5Q2OB/KWxQjR6eFpc/300jhXDAArbTaGLlR1uryC8CicjY0
 kCRb+OzIzhd2IzoTENoCMTRU6szizHCv7+MbvD4s30AVYvyX7ESNzr/qCsd7rPx2+tE6
 TRHH4jR/EWV1PRbKDybF8+ncNjgik9mtPDlwbtAomkRKlQF1Z7hIKCrlxx+4NAKk04h8
 zUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769095487; x=1769700287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d9NZQMaKjw/9PZ8DPzJVFbLPhmGM1hoSma/eUU87F38=;
 b=UTs2bCy4yg3evDsEnL9kEwXHN+TMQ/OT5ZfxbERCFCc6X67ZxHT59UyMNDCGAJ+mF9
 fngETvIz012FVeMyrB6mO6eDk7uafwqe4yx1Iabd9txJhw12Z79PjbnYzGfPc6hYas8M
 A0NfBYsuQbbZbQ2ueyBRP5vtdKQyu9k2WX/knnsInoE55HSM6aEp4EezbgeRn0uACxbt
 RS9+qXmCb1ywnRlY1GTwnyF+JOTVJRj5X5LoA6HYlyLoG7leYjDbR+n8oECsYH+namRI
 1ZSX721A1s5KCf0nP4jaYBL9LxCAJm6XyHpsulV/QrQSUCBVW27ql0+gEaO3HmaWa9pE
 Oktg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUDUFRuEZ6gSW0hmohw37hrjGOrOR+WGVsQhVD7szkeej10hTodt1b58b9dbi+nfL5I8et5sq2UyoT@nongnu.org
X-Gm-Message-State: AOJu0Ywg4XNJyvREnZVDNvJ7YCcKmWxxh2i+Ajw0P05HkQeH70V9EPlA
 ybGFJEcWrDimzWXYvq7rfqg3Us6hPjJ6IUSSe+a4WXVr6PvwnG2BlBAHb2v2wznA31ICN56gF4m
 LPuLnrBU=
X-Gm-Gg: AZuq6aIUH5b6Kxh4/TuPCm6pIy9WwYFLyxR8PjGgRBca95LvgKwK66QFV2/Zq6dyUeu
 Gi8cppVNkpv7nQczPJ7CeGUVRWrmIlq0xT5jaN0WEf32aynMGYQncmWjjHhXw460zHRbyW7LhjX
 K5oAuxq9mJnXmy+0tRIBH0JlNsv+EGkUag1HZ8CS+zhDOIoeGlTZUe40P52r5tnSsiprK6+hORW
 gdYMmXYiYAxIMKoL40g/9clH0MTC0rPA7CH1J+mNkE78hgZzkjZ9lHE54NKmuRs/5/5TZ2ulVre
 n42B6sqfdny8w44e3Ls94WkTSSYF9tbeDgUvqo3Ev69SK4SWfddXYuZBt1RpX8nKHgTdlbIMFVI
 /4uLQdO1XdOz+Uq81CSLBVbOj+feUTJIp/3BRW0VO5jTczUC1vcyoorvP5mSTMU84zD9GIrnlKa
 UOdpZ/RnFY1tQNQR4BIJd7Qgj3MvPMwbkDkcPacem2prCHJGpvZm2akQ==
X-Received: by 2002:a05:600c:19cd:b0:479:3a89:121d with SMTP id
 5b1f17b1804b1-4801e359031mr315662795e9.36.1769095486935; 
 Thu, 22 Jan 2026 07:24:46 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042c1011esm56382575e9.6.2026.01.22.07.24.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 07:24:46 -0800 (PST)
Message-ID: <a1fdb977-b43a-40a4-9371-6b36ed7bc848@linaro.org>
Date: Thu, 22 Jan 2026 16:24:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hw/arm/virt: Clean up MSI controller selection
 logic
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260120180339.1416328-1-peter.maydell@linaro.org>
 <20260120180339.1416328-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260120180339.1416328-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 20/1/26 19:03, Peter Maydell wrote:
> The virt board might have multiple different ways to handle MSI
> interrupts: via an ITS, via the GICv2M device, or not at all.  The
> logic to select which of these we use is confusing because it is
> controlled by a mix of versioned-board compatibility flags, board
> option flags, and open-coded logic inside the create_gic() and
> create_its() functions.
> 
> Currently we set VirtMachineState::msi_controller as the very last
> part of this, inside create_its() or create_gicv2m().  This field is
> then used only in the hotplug pre-plug callback function.
> 
> As a first step in making this clearer to understand, move the logic
> into a single finalize_msi_controller() function, which sets
> VirtMachineState::msi_controller.  The actual machine creation code
> can then look only at that field.  (This is a parallel to what we do
> with the GIC, where finalize_gic_version() sets the
> VirtMachineState::gic_version field.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/virt.c | 38 +++++++++++++++++++++++++++-----------
>   1 file changed, 27 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

