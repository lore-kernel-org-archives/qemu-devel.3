Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5963C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 10:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8GXd-0007Xf-0m; Fri, 25 Apr 2025 06:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GXX-0007Qn-6n
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:44:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GXR-0000bH-Kn
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:44:14 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso11750975e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745577847; x=1746182647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DYXI/G6vMB5iCXd7bJohZL/skzcjQJnaG/JuT575+nk=;
 b=cjKZPD5acKNViogWDXJyYMLEJAA+yQw5JFESKPhNtVx8I/AjenPzusol5CVVkgbByF
 +49MYo4gVSUNEYt0EjV1qfGmcyqfcgXNyR9Cc1m+wKff3TojW5WJDFvVokOfSjw0yTGo
 6of8PN3S0nbdiA4tcpNoX9YlTe+1m4ub+7yG66Jh9wJhBVsQiZqWojhp2JzMc0hFCz5h
 F6qDc7jsyuSPc3LIWYqBhr/fJBdpN5wOhse0UhKqYdSNDhotC+qAGrHwJ9lbg43ddcz1
 HdJYtuth0L2ZmCAdiz6KzeZdwBYTolyfPbgDbeP55Hrx5HP/l2/+QSZ1JfcwTv3Tp0eA
 g0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745577847; x=1746182647;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DYXI/G6vMB5iCXd7bJohZL/skzcjQJnaG/JuT575+nk=;
 b=oM+2CDF2FG8JrLtVDTO+akuF4LhOAZ6vO1tTovKxB27sU9OmgpUqheKLp91KohzP/7
 zl9sVeu38y03NwwkWujW2nF2pv8hH1qUkYQJv4aEm3WNPox6HpPDGy4iWILh6jEDKrQ2
 Iu3qvhkMi2ixwIfS0yIyvwGkQXGiu1CM17JMZIpng7GPx4km14B5gWfFzwrETQt1i0pQ
 3j6s1b7sy8GZwQ9FvWJVMUxmmOtneNKVYrWakn1nvmDGNP+BQL6fLXYSQatEPxHA9YXA
 AZ78zBUdSkbSLhiJBJvoxVyhNVmQzHzx2WrSwg0DGUSWL2lfQ6JDMSiFvfPiSonW/bzS
 +JOQ==
X-Gm-Message-State: AOJu0Yzu2tghV6LmsPGWyd8tIAX7FGnja305FDR3nxgE/AT3JCTFkRM0
 +0q3IOP8R73e3yB3MwUk3W3efPxrR3vof18QDHpFBLhUP16JjqtGb4rlX0zgCOFbTPbvKf7jst6
 q
X-Gm-Gg: ASbGncsZF1e3dQp+fpgph3gRZnNXio5/VFyN0TB2mw9NV7bxUhe4BMhE84LKML+bg8y
 n5fQYfNbVOm5LEh8gzbaSd7XAN3UGV9IYOwP9Cbo4Jd1Roq3IbG4vrc0uvBa225sAXK4cLXemMr
 1/4AEOajO7Xok04UPbtqkz8psnnCl3y2tymH7vOVua0DJ1cSW5+mYYLWEwXmuw0Syr7XIJPe9ya
 e8BdA+/rMvOBCW+OBuKwOQYn7QxztA8YQf+5IK4LLeyfy9uSdMeX0zIl5sZiduwQFEO2iIKlSAW
 8vMZzijLd6/0yaR8l/AyAZP/llyfLnoPCOFIqQVvyfhHHXIPSm9PmUOSlmmtXq6Zl/Hb8QvMBVF
 mcHTk5XYW9aP6gGpk4sA=
X-Google-Smtp-Source: AGHT+IGz6D2a/n/wRF8Cc90wGcRXmO9FccPFIGVapv7IRWL/O0vblFl9pg95AVNRXnp40KNg872nQg==
X-Received: by 2002:a05:600c:46c5:b0:43d:ac5:11ed with SMTP id
 5b1f17b1804b1-440a66abe30mr12556715e9.24.1745577847492; 
 Fri, 25 Apr 2025 03:44:07 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a5303c68sm20354985e9.12.2025.04.25.03.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:44:06 -0700 (PDT)
Message-ID: <804ee0d1-9a51-4fde-b094-cb06833a258b@linaro.org>
Date: Fri, 25 Apr 2025 12:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exec: Rename target_words_bigendian() ->
 target_big_endian()
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20250417210025.68322-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250417210025.68322-1-philmd@linaro.org>
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

On 17/4/25 23:00, Philippe Mathieu-Daudé wrote:
> In commit 98ed8ecfc9d ("exec: introduce target_words_bigendian()
> helper") target_words_bigendian() was matching the definition it
> was depending on (TARGET_WORDS_BIGENDIAN). Later in commit
> ee3eb3a7ce7 ("Replace TARGET_WORDS_BIGENDIAN") the definition was
> renamed as TARGET_BIG_ENDIAN but we didn't update the helper.
> Do it now mechanically using:
> 
>    $ sed -i -e s/target_words_bigendian/target_big_endian/g \
>          $(git grep -wl target_words_bigendian)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/tswap.h     | 12 ++++++------
>   system/memory-internal.h |  2 +-
>   cpu-target.c             |  4 ++--
>   hw/core/cpu-system.c     |  2 +-
>   hw/display/vga.c         |  2 +-
>   hw/virtio/virtio.c       |  2 +-
>   system/memory.c          |  4 ++--
>   system/qtest.c           |  2 +-
>   8 files changed, 15 insertions(+), 15 deletions(-)

Patch queued, thanks.

