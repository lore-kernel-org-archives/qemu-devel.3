Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B55CC982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 00:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ivP-0002lh-Dt; Fri, 18 Sep 2026 20:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7ivO-0002lL-0d
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 20:27:26 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7ivM-0004Rd-DE
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 20:27:25 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2dd1dcdcf95so9513735ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 17:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789777643; x=1790382443; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZwkDzfwfDyOyap/Nn2gCxM12OZdSiCpaZIk79NGKmBs=;
 b=qvrGLPb2UowFrzK3+XZs5fKWWQkG2sId5iS/r0Qdf6FZVtm1PeLFBCQM87WDkjUYPC
 Vx35y6dw5PRK03DNTL63qxO8y6PuitcF9GvUhLd5DsDHP6kq9s/VjWGxPyEhn9JHuahy
 DPPDRjTyWhTxpRZmZyaPol1NdpASXJjv48bMy8vBX3ZqnIH5EhP8hYjjEI5smwMsQ4aE
 YdqUr0bnr4Hw0btifLpiu+FvpGi5OG3aWSkYFktqmWfCeN8cKf8/VjiviOKrsGVEuOD4
 +DOqfR52a7CywYFupC3R3y0xC49KYyH9/2sxq1F4QjONFWmpqQ48w46kFCcxn3vWOEyk
 BLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789777643; x=1790382443;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZwkDzfwfDyOyap/Nn2gCxM12OZdSiCpaZIk79NGKmBs=;
 b=cZpOXKKnywO4Yo1NvdSb+s1Kxtmt+wyrIi+8734R4pPiNLMXZuxTHGVhQg1YyyUETJ
 30iqyTs+sbA+NnwJ9vOu/gflWmMIUMR7ppJ78viD7KrPtzd7QqZDtvplwWfVJExoa2bX
 XvMxSPzIrHavCg0Hx/t85njlb92clpQ6D2hgOe3iF2IYq71um0u4n6qLbKpRAgzuQMlS
 XE+2IunU3MiKcYSmDSXMdYl6zdswoYcTkpeGPXTkyhTrg4IZMfExpauFLYuFqIHMYl41
 YejTYBuhfEmTZRQeYsYL0v+pAwL8x3SA/F3Z8jpO5AoAePhPyhKe3Ow8V8kTOFUeHRDW
 ZMCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCrc4WVWgTwnE3YNwk2terY22awoVhyHqyYCS8Ef72H4cd71yNOYEeVtR8S8o+RhsR4wIlHVLE9Q8+@nongnu.org
X-Gm-Message-State: AFuF++mTFfP1OHNNsMWt4nShj8qRENZ7mrVqwovbBJSDGEO/O5OKH+j+
 WvQ8FCb5U9r0ae0yIE3eRHkk5jl9a4LpqGwxQIavDw9hSWqKhMVZ7JGRJste69zKPV8=
X-Gm-Gg: AYBFou0oPtH8lX97gZ1JJbReBjstrBI4WQJZ/GXOfQUV/ljUIFqyYVSJNnTNPm+STXx
 aVkX1RR4MGkz3dGuSKXBJNShzvLg9cS5E1xEMd1YaP4EvoR/D3QqcD4/p9sfrpxc3GjrTpzfUcY
 /ImfYhUMkyW3pWrMjNFZwrqNzRYoKw6zl+gkX8hh3IxmGtIfZrHwUvV+YtYL4A3bWv/7IXNKE/l
 kNiJTUS1cuDOEv2Fe5AKmp456SG7DnsIeH+hKVVDNrLDWrnXiPzfwYn/HbI3N4VsA1aWo1vuowa
 gBE7DeqWF6TMW1vbCxpikZOYRmwfJ0lqdMx7x4NU73Yr5VyAL8eibFc94e/EczGmFgVucRiH4GU
 FMDQrCckscmGb3TMa8RhbHNm7+v1nSPFw8NUqZmJ83s/rdq7VKKv7xqRK7syYia2Ew2eCJDmCX9
 OQw/p0S91/NwsA0rY5VZPrett7f1vpKHur4SSNnpT6yJWDncEDGT3k6JpBowr95GA3s+0qmCGeQ
 gi77RPA6dTuaAHZKb0oVnzEbwUVnKyYYKE8LbCS8bLp8a/nazDZ4KimAm7U4w==
X-Received: by 2002:a17:902:f68b:b0:2d0:401c:2edc with SMTP id
 d9443c01a7336-2dd9c6b9174mr119752665ad.1.1789777642705; 
 Fri, 18 Sep 2026 17:27:22 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:fc68:7352:7265:5984?
 ([2603:800c:7900:ed00:fc68:7352:7265:5984])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331ad266sm1818775eec.23.2026.09.18.17.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 17:27:22 -0700 (PDT)
Message-ID: <331e0d9d-5b28-4914-b558-777150e31316@linaro.org>
Date: Fri, 18 Sep 2026 14:27:19 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] Superio hppa patches
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Helge Deller <deller@gmx.de>, "Denis V. Lunev" <den@openvz.org>,
 Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>
References: <20260918163829.2917-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260918163829.2917-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 9/18/26 06:38, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit 209b2afaface001c7d4d981e38f186afe7b24a50:
> 
>    Merge tag 'pull-parallels-2026-09-11' ofhttps://gitlab.com/dlunev/qemu into staging (2026-09-10 22:02:18 -1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/superio-hppa-pull-request
> 
> for you to fetch changes up to a8b79b2d9c50165df1d974de078f951bc4628662:
> 
>    hw/hppa: Add NS 87560 SuperIO chip to HP C3700 machine (2026-09-16 20:28:42 +0200)
> 
> ----------------------------------------------------------------
> NS 87560 SuperIO chip
> 
> This series adds the emulation of a "NS 87560 SuperIO chip".
> The SuperIO chip includes a floppy controller, two serial ports, one parallel
> port, an IDE controller and one OHCI USB port.
> 
> This National Semiconductor SuperIO chip was commonly used in many HP PA-RISC
> B- and C-class workstations, as in the HP C3700 machine which is being
> emulated by QEMU already. The last patch wires up this SuperIO driver to the
> existing C3700 machine emulation.
> 
> This driver was developed during the last few months by Abizer Lokhandwala
> <abizerlokhandwalastd10@gmail.com> and mentored and reviewed by me.

Applied, thanks.

r~

