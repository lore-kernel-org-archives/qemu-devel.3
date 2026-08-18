Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11373C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 22:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwSfh-0003B3-1Q; Tue, 18 Aug 2026 18:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwSfc-0003Av-5Z
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:52:36 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwSfZ-0003ua-W9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:52:35 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ceab75934dso3960035ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 15:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787093552; x=1787698352; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s3JSDrG/Z/LbVmHmR/nySqSYEMQ1uYn/UZKZi9TDNW8=;
 b=xmr5VfvC2Oy+aLtgwdYFBnBs+yk/kRAdlAxOmTDq8m8OnSWnKHanQvEojmw80XE0nF
 LgUMJnA3RiRjx8jluvVFQJQSctRT1Tx4jqZJKicKT2FmkN7rjhzBQH8Gaq3VkwkUbvUa
 vvAahxBxIXPBUDw2Uv92OShdfbieZLnSkHU9PTqzeGlsOIrBhnxE9ys6FAXEl6/g1brp
 ElzngeKdTobOUC+b6jsZ14ZljDcZHwFKsJcFyT+20+ge2Jal7lkHJru1p7zDlDSoELtt
 D6ksLNmmONMn0x9MCzHW1kBFpprHf+1C3hpqnG1rxc4DJqp8oht27kz7iVvE+rwJOT0s
 D2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787093552; x=1787698352;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s3JSDrG/Z/LbVmHmR/nySqSYEMQ1uYn/UZKZi9TDNW8=;
 b=iuiDmhp8bddulm6E6h+ug762Wfqxz6cnxUeKp2S67lniwW0nJQ+HvbUuKetc+iqhyB
 asqQBMv2G8PYAx8zP0WZPgazg25AWx8I5j4DJZFa6hVlYfSeF4wRh9i4lxsxaiN3BCfk
 POiW/OlwXhQPsNpl3C/mewFm7FgiiQ3GdBBNw1asCgkoEJFCBrGZERn1Pg3NS5bcTOoz
 rfKuvdWkhCuPQU5/PB+m8nLAsb/hcDXmETMfEl3nlO8c09ZMTgT7+P0wGe8nQtbIHBjd
 XwO5AsRa6jMYvP7Aziw9+L6tbKNs5BAow97w3LJ6ACcQxI9+ClkbScGeHoCi1YW7Tomi
 Sr3w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEcRtmI4ZhnBObIAi2Zj4cidyndaS8DEF0LZdwA1OENsNQGztmY2zy0wDrBqG+vTq/FhyGm7qdha/l@nongnu.org
X-Gm-Message-State: AOJu0Ywx+HKs9IN4y3MOB3LGL2FdxXQvmVy+DPSJSF3wxZBvX2RDoT6P
 QM5N1+oqADeklNzsUX5ywk4NCWgAasG2M3KHuZU8UyurCYPI4th77IntTngcxZcIBLY=
X-Gm-Gg: AR+sD118mSHSfAl9b9zcA5YsPoVYTVdQKE7UdMHOVigEiZxx6peRTm6uwBZ4gztV61p
 5Xo7ntV1F6fKHTNVwVh+cLw/viskLqjN1JsHLL24zNabc5e37CpVw+zx9DAA/GLRSnRsdgC3sT1
 cY71fsU2G9lt+DO+nlImYptqR0YxnIzFoeqTfR13yN5W4ccTLYFunvPcNN4HtpDaSaGszJNfPAF
 FsYZSVuG8pWvInsdIKkp+NmHAzAG7yAEJ+DJxk4cVz4o92xolbP6yWiHBv1kmkZxvBzEz06jRfe
 kMZjgjS4RD8aJFDDpfvAmEFRTBeykx1Har/U1kGBClf7w8sQHDowemYCGm7Ld8q4Y0JbAlqH7jB
 Ay2kUo4+VJzoW0Qv1RUS0Ozcv6OMvinTiQL17sZn1voZO2Umq3bGSS+00Vbyfopyb1o3r+c7++i
 6W4x7pEvlVeKUNuFu8HrCzV2HJ8+iIjuPEv44+p2+W9kfFPETOUFUgse1g22N67plSwTqh6BJz1
 FvAEzvY
X-Received: by 2002:a17:903:384c:b0:2ca:6c8:abd8 with SMTP id
 d9443c01a7336-2d5fd6d812cmr5077435ad.12.1787093552302; 
 Tue, 18 Aug 2026 15:52:32 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5c1eeb6f1sm18924685ad.76.2026.08.18.15.52.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 15:52:31 -0700 (PDT)
Message-ID: <d0245a09-6643-4c87-86b4-be0ab2579e8f@linaro.org>
Date: Tue, 18 Aug 2026 15:52:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] accel/tcg: cut per-block dispatch overhead
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@mailo.com, zhao1.liu@intel.com,
 laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com
References: <20260818174247.649526-1-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260818174247.649526-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 8/18/26 10:42, Matt Turner wrote:
>    4  RFC: tcg: probe the TB jump cache inline instead of calling a helper
> 
>       95.8% of those 8.4 billion helper_lookup_tb_ptr() calls hit the jump
>       cache. Emit the probe inline (hash, three guarded loads, goto_ptr)
>       and call the helper only on a miss.               -36.51%, -27.05% wall
> 
>    5  RFC: accel/tcg: allow cross-page goto_tb chaining in user-only builds
> 
>       translator_use_goto_tb() refuses to chain across a page. In user-only
>       builds the invalidation path already covers what that was protecting
>       against: every mmap/mprotect/munmap reaches page_set_flags(), which
>       invalidates and unlinks. Lift it there, keep it for system mode.
>                                                          -2.42%, -4.68% wall

Both of these will break breakpoints.

However: for user-only, gdb can only be attached at startup.  So we can recognize that no 
breakpoints are possible and make this optimization then.


r~

