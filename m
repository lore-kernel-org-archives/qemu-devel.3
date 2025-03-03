Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00949C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3iD-0003ab-3n; Mon, 03 Mar 2025 06:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3iB-0003Zl-Ij
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:11:51 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3iA-00050Q-3U
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:11:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43bc638686eso2701585e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 03:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741000308; x=1741605108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TXePp6d66/7K7zoMgGcEq1LiVC+8JxroBjUksCe1hiA=;
 b=cP94Z2RHOq7d4N+wUjTC/ygnIezx8WzMca8hKNviXXtsuEblhL5Hb1BRMC+Be7jMAS
 qLQZHH1umSBtlw0VFOhNa5B/Hw5RTZHB9u8NGE7nDTt3xxqLrYEv07GLgmLnAusoiXv+
 LoJyds9PFL025LY1Ad3wbesd3ewjabkJ37Ykf1u8kiEuknA5DBTOgEC+GHERRpi5Hj4O
 KyWIfvanFp1PnxbLw2WEIB3UhBGVBdG+fZxZk8+Gd3bd7+Rzkiqlfds4dmEdh4zB7EFo
 l0SIoVQairvSKFd6vtUXxIGML3eIHawU9Ti0nUaToYe3JzttyHxUUDGTM13+D+5BlNJp
 KDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741000308; x=1741605108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TXePp6d66/7K7zoMgGcEq1LiVC+8JxroBjUksCe1hiA=;
 b=cqpVg5MKAi1/RBlkK4W1oTCWSvh8ANoamLLuTdmHF08XxJATXMZ46eL794SDaNfOD7
 /ScKtZ+chsaiZQmhJMH6Cg1eYclYkPbl34lvvoQ5Z9K1ATBf3bBlB7vXDiVaN2flfMx5
 NQhXjDDnbsf5NLt9LXOrKud3Na2NpZEIJJIm1uahyfi/xIQs7+aSz8zHvAo/Pxwc4gwA
 Imt6IfUv0YQAtjeTW8wJaDUTC6oQvwYAWlniaZCdWKyrdsSieftYC1TZOOu8b9ZmHWx7
 mpzdBdyCcR5Dc9l3ySFen8MGYziRkID7O1QE/3A/McmwDlaHgmVmnEIR5tkDr3tLI2of
 xhDw==
X-Gm-Message-State: AOJu0YwtiQLyOJLJ+KED317L6/WKavGRW5XQFZkR+zuv92fXhZxD54MQ
 YxINMD+1mNDR+7ecsXXuJ1hHipIqKvkqF+1bX1++VvC8n4LJVleHU4oeyCYy6E9ALRCFIn32Nfv
 mkGcWpQ==
X-Gm-Gg: ASbGnctZPHfx64GFiCa+Wi3/vEXen3SG34f960zJLPpCLQBV6x1JDfyxPnreSnWo1y2
 iG9I3T//LUmwhykpB3j39I5RwoXGyJXxZ6ZK+Wgkhc/OAabp7ikZjJ1E/okWXlvBh2mGFUeMefo
 mJYcRVh8YRJyH/C8XZKqbvMCbTIuOZLxKnXuHmibcaZwn2nVBOKADe9RS66mkOWiNb/VUObDej8
 uLD6oLxOzM0UGw6z183rMAk1JG1p3ZF44JtK/KhIGoLTB4T18S9aqGKcviPmId99scz+OQbfr1c
 KdRsPIasWovj02SRHX7hwgu6jrVF0rff28MheJTHbCyATZW2ZMcuJox04i0+IyBVxP336Y+V6TF
 nzRf4WhUrHGbF
X-Google-Smtp-Source: AGHT+IGm6SS0Tx3aVo8Pdxgek5Qs1D2aBRLNyFmmaDPbcCk+FIV0Ui7BeXW1FUaE9y+wPzMb01+N2A==
X-Received: by 2002:a05:600c:548b:b0:439:9737:675b with SMTP id
 5b1f17b1804b1-43ba6256610mr102706775e9.7.1741000308067; 
 Mon, 03 Mar 2025 03:11:48 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bbf2ed24asm42494365e9.23.2025.03.03.03.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 03:11:47 -0800 (PST)
Message-ID: <6fca1ca3-5746-4ca4-b8f3-c96cfe93a9e9@linaro.org>
Date: Mon, 3 Mar 2025 12:11:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] xen: Build fixes and dust removal
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>, Thomas Huth
 <thuth@redhat.com>, Jan Beulich <jbeulich@suse.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250218162618.46167-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250218162618.46167-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 18/2/25 17:26, Philippe Mathieu-Daudé wrote:

>    accel/Kconfig: Link XenPVH with GPEX PCIe bridge
>    hw/arm: Do not expose the virt machine on Xen-only binary
>    hw/arm/xen-pvh: Do not allow specifying any CPU type
>    hw/xen/xen-pvh: Reduce included headers
>    hw/xen/xen-hvm: Reduce included headers
>    hw/xen/xen-bus: Reduce included headers
>    hw/xen/xen-legacy-backend: Remove unused 'net/net.h' header
>    meson: Remove support for Xen on 32-bit ARM hosts

Queuing 1-2, 4-7 as I understand #8 needs rewording, thanks.

