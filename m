Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635E4C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJuhy-0006IK-G8; Tue, 27 May 2025 09:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJuhw-0006I8-DU
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:51:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJuhp-0004e5-61
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:51:08 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4c9024117so2624292f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 06:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748353857; x=1748958657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3enJIulEOHYtn5FoMbOuaJnvWWYD7uAfH77h+E/s1Ks=;
 b=B0ZIjSs/qlU7bvkJ2dGCnJALhGDmaF5BRj3cpbTxuJMu8vdO4OiKs/fK3sn6CRMeE6
 EOeTXWAIyZEgDJMTBUJywGa12zLP72Xnx3MpbpMllrd1XkMW9Re4zGhKLcYA8Fvowd6l
 AhmmLv1ctU8YnwZI0e9UpE20zoebvYtwuUP4qcMvm9klpULp6F0rd7AvixmhWeBuvII0
 0Tvp/W8hDE8xzfLr65ngF0UNRI54b8UEF8hVVK4YDNSEq9IFTkjnHd9BGdIF1y92iyu5
 29jQWxKiXaTLaYPJNdVpPOBK5AkcHrVfJ86l27uhX+rLQ91+5fQOxMg9Zh2iKQjvpD0Y
 KnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748353857; x=1748958657;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3enJIulEOHYtn5FoMbOuaJnvWWYD7uAfH77h+E/s1Ks=;
 b=IsNZ0RUz4HLEf3ct58ZtSMTWKpEbZP1v1qMd7GAJIGcaw0loOyULemym0vlhPhimRL
 o1pS8lO3wpybUroQ5jgVTTEgU02I/IciWUjlXW/v6fgaQkHjBcEJ1gyHbe6hDN9wWO6E
 l/UU+A0vg9rGx3q/yq3EBhN2/Kp02aJW9CFYsj5VzgJ/hIa8LmSREjXqET0vTU2IaLCI
 p1EiHbcfoNeCbi0FMD9899kueOdza9LX3advJnwterk/a7WcjTUNYtmwK4eBII1GmbHq
 uoxAbwbo31GQ8L3gOSp9LBlk4yBQzL8GyXsICru828BDLVf6ph/waVDV65/Hzn9SWy/f
 j57A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuQwMoJLzFHHPE0FLmBE2G3KT1wCem4x5y1xWUiMVQBSNuQFzURgDU4hw9T/CrN4A34O2JCmmyMRBe@nongnu.org
X-Gm-Message-State: AOJu0YxxKH//hTS5KASbwghQWx+6sZdbNKJp6BHywE2mzKucYDenc3wr
 zoJUldK/nXs/dKmNw6lx30yF1BPm2Ct7Jr/fBVYwIznES3FXzuAlxx7NF+2sIqp0ESE=
X-Gm-Gg: ASbGnctqf3veH5+NNVCBdXqZWBS4DOSLaS84d9/Mv1nYtMSsiM5Sg6DfIHOoLOg3+C3
 QU2onbuI8/L0v7fUOGJ4cu5AyWcIBwpMFWWfIFCCi8rkyhSXSkwf6pxbnP6iAlvJCSbveGpZU09
 m/IQTm0yDQg4MRg7rWxzvPpqMZ577DD20WBMdQjIlygeyukgco9t0KNmZkyPedvo/uWV0jRtcYs
 HKTpU5M7FMLSs4dB45t5a5Ipq3TY32TzBWRkadkJTZ3nlETDCt7Cr81/14s4L+H8NVQSIU1hyTt
 p2M9ppGbwOlkVK/P0Ve0HXnHW1zlBBqy2E36rNFfKFqogZ81ZX9J9D+y4XU3LuR0W4ji3oTFghN
 5dgfv1Fly573WChDd+9GNerle
X-Google-Smtp-Source: AGHT+IEMAzz6MInflkM9+JttYMGCGeL42jT3TrFkHtSo/hJWmUlLuZSERpZqRezkkFlN5OtUmfnr9Q==
X-Received: by 2002:a5d:5612:0:b0:3a4:db4a:3004 with SMTP id
 ffacd0b85a97d-3a4e5e9e2a8mr580482f8f.22.1748353856681; 
 Tue, 27 May 2025 06:50:56 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d0d708b4sm9276340f8f.50.2025.05.27.06.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 06:50:56 -0700 (PDT)
Message-ID: <deebb72c-c39a-4e4d-880a-4b85773d7ae1@linaro.org>
Date: Tue, 27 May 2025 15:50:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] docs: Deprecate the qemu-system-microblazeel binary
To: Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250515132019.569365-1-thuth@redhat.com>
 <20250515132019.569365-5-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250515132019.569365-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 15/5/25 15:20, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The (former big-endian only) binary qemu-system-microblaze can
> handle both endiannesses nowadays, so we don't need the separate
> qemu-system-microblazeel binary for little endian anymore. Let's
> deprecate it to avoid unnecessary compilation and test time in
> the future.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/about/deprecated.rst | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


