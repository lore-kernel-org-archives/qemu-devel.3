Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885D1CA5FDD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 07:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCuYd-0005gW-OK; Sat, 03 Oct 2026 03:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCuYH-0005U4-23
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 03:53:04 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCuYF-0001AY-CR
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 03:53:00 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-4a01ff8c098so3103665e9.3
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2026 00:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791013978; x=1791618778; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8YKttbV9S3OnxJHVnQGylK4tbgpT8OHl3mUoR6KDgd0=;
 b=kmmuffx5/PM5gZ7hbnCRzkWM7/QQEw5zJQcmVOsrvh3Q6sy9XOOjdYzzu/ewMqE/Qb
 cPIEIGcVtBSVkm51Vt0aGlxoS4JUb3qs1rSYX2b3s8492gT5QECym75VBB4wFuDph7uk
 AVISIdgKfIsVJwPAtQQ8b86oKvEMpx+bz+4j/9wcw5Z9em+81yoB4ZM/WEz/n/i+Poi+
 R/8DFExEjCc6j79j3s+jL/62CiW6T40ORFNDJvwRda6YHNCzxy9eSpIyccChrvnMLXct
 g2zByMVCOMQmgdK1UJmU9SnTkyLVd9iHY1a1OYcVRxf76rB9OqTvaM3TDmCIYXBGkyea
 H+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791013978; x=1791618778;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8YKttbV9S3OnxJHVnQGylK4tbgpT8OHl3mUoR6KDgd0=;
 b=BboIN+66EtcdbmabFWVFQtVKqUSV/6BfvkgoPmU5N3Li4xA6v4YS6TakYrwwCsSf2N
 epmV/Ddud+AxBzcL+KzhyUxnXuqRvTaSxtWseS/TUocJyXDDE4ihgYqcbLSZVmn6bAJD
 /287ybO2qSg+LY7pit69nOcHxsg8F7NMYAm7HxWn0R300JSB2wNT+K0DQyZ6paGC/tb7
 QJ4ZClNw4DXAnQ5WKxhv1d7DhyV2J6lPza5fAG/5NpTxyU/EgjHvDYbJy436TCDAjJWD
 2+p3STlY5KbNoMSZfbI2RgU7f5wLWhlEYVNIwHiMhoFvXI1AdK0s8oNVZecCLNftDX1A
 SEIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvnEqTDPqEcvaPzoi8whuo0Ze/H/0+RIRE5QKCnCSbsF6KB+7EyeNxoCJbm+OvZkgRc6nwwJpKfwd7@nongnu.org
X-Gm-Message-State: AFuF++lcTo4QLIeqOJVETA/POMxZ35gLg7lRgyUkCcjCblxnRcFuezVj
 Vn5yjtCzfSGr5x9WuPpvnTqL+WnJgUE3R+L7fKndUf9NkIYKlCRq+R8eZoVKNb916fM=
X-Gm-Gg: AYBFou2t9t/VDiLezSBsUJkA/k25Z7uXGOLrZTbSmCfRCgnAAWzpIHDqamG7aMDAzrP
 b0RtSAjsaLmT+LnZ/i7XzEQW+/G9YWhpQEUDX3Y3OESOvDuSKFcOU+09Z5Qdy8dyG3GtSR2VnzU
 nEGiDgeiZu0FakLwhsebgZ9/y+DLW9/ALMfcqgVtI9e0sGr99kJK9K8iPVAEd7r8Xr/mJmZ6fks
 ZAxjuoBjEePOoEQ2QwCq7jRLZiQ2A5eoTvMNE/PBNojmnCEUnt1w88OqWAUKOLJFA70ejRKm0u+
 O6G5T89cTcE+DXnjJgV2oddUjGXAQZ1oxqivAwwNGdMTAUTJ8VP0ORUffhM2yN2yekJGR4SNjQw
 Y9fIrMHRw54GGCfiUVVok3BLwLDniSrJIFrRjMx4VVF0UQV7cFd9m3p3JWJW002ztoqZfRd78jb
 DbSDkuaAe/XOsICTKvssB6Yv3xMxBkHUtaX3017sTBVad3kZjB60qPD3dgtuikUSuZM6rF/oVwk
 DzLVZ3ZyO9mTx4bTQYxHTkSLY67QxrJ5/kWPkEeTw==
X-Received: by 2002:a05:600c:8b6c:b0:49f:ec98:f030 with SMTP id
 5b1f17b1804b1-4a0276b3e15mr86835365e9.33.1791013977700; 
 Sat, 03 Oct 2026 00:52:57 -0700 (PDT)
Received: from [10.9.5.233] (vpn-konference.ms.mff.cuni.cz. [195.113.20.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0a6e894a4sm126257725e9.5.2026.10.03.00.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2026 00:52:57 -0700 (PDT)
Message-ID: <bab7c601-28f3-4693-83c0-67eea5431df0@linaro.org>
Date: Sat, 3 Oct 2026 09:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 00/27] smartcard fixes
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm2-x10.google.com
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

On 10/1/26 15:29, Marc-André Lureau wrote:
> The following changes since commit f7ada39edacaa5c26b30e98b94017b0b2ccbcf94:
> 
>    Merge tag 's390x-20260930' ofhttps://gitlab.com/efarman/qemu into staging (2026-09-30 16:44:59 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git tags/smartcard-fixes-pr-v1
> 
> for you to fetch changes up to 32556054616c89bfdf45573af0be381b271885ff:
> 
>    hw/usb/ccid-card-emulated: free libcacard context (2026-10-01 17:29:31 +0400)
> 
> ----------------------------------------------------------------
> smartcard fixes
> 
> - CVE-2026-18609: guest-triggered assert via short interrupt transfer
> - CVE-2026-18204: OOB read from the pending bulk-in ring buffer
> - CVE-2026-18410: assert crash when pending answers ring overflows
> - various bug fixes, spec compliance and refactoring

Applied, thanks.

r~

