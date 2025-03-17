Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CB8C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuCjx-0008VS-GU; Mon, 17 Mar 2025 11:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCjw-0008Uf-0T
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:50:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCjs-0008GW-6r
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:50:54 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso24967445e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742226650; x=1742831450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l0kvYVh3QIIhVSteww7rz6e6dOUJeoxVvK2zu9yWA2A=;
 b=mnv4kohNSqAUpsu9pvMJwaASgZSk+GaSt0Gx0yzEP0mqNaUMzMTT5yHDs9ZoEkU7Bm
 urzJV8yOYY/xERvvYZDbpXejxGtOtoAb2I6OupE0EF9bCy5D7JrELQMb5MbgpvPs8M9e
 j+qXwlbigQmjt+40foOWTKc1IEeuZ/3aOR+abq7MgIKb+WhVIXjCV4MQmtgLl0SZ8r7z
 dKaaemYlx3FtJ8Esk0Q+6HY8MI/qBr4w3ixZf0Z5xVPTqCldgslpeyoiliTqLCfATojw
 4kDU6xqPVnMurhCjZQJth2Vbztw4NQ5tAfepjw/UetRtYhnP7m3baDwRgBc7Pg6MGHCi
 Gl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742226650; x=1742831450;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l0kvYVh3QIIhVSteww7rz6e6dOUJeoxVvK2zu9yWA2A=;
 b=uDcJdgbym9ybQ6QsXhZlj64iTUDz9tyzfgZQSSPe7O3E0sBZtGsUTSJVjFH3XXdez8
 X5kYa1KgoX8Ys42p05VX6V2vJBOTW0hPfnNUXc8I1dEtwhDIsy3H0vrf3a4BnnysRm9C
 z8y31ybytNBZ5JJkkxjexcxIVPv2A1GDGiWdCtDANMm2Jl5Xdv5Eahg9qXanXmUhUmRx
 xUJMZDsvCBAQrdKLCK7W6QxN6PAYM/X+5K7fXEd4sJ/GEsKeMDelmRzU5ou/X+OfNaY4
 msaKSbl/+nJ2dFb8SN5Mu2OVBPDCY8++GyDtQnsrCzsc8WHcg3P986r4nXExcroORJM0
 megQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlDDz1GK6PGiD5c4GXD1S45a03RaAApsTxbxURzSEWvYGds9fpQdgg0Ocy6ogc8A0zsjQjN9cHkDYg@nongnu.org
X-Gm-Message-State: AOJu0YwD+bf+gbADSsqtACsJfutHaggreYTE5aXq1OiBMk/4MhdzjJfs
 iQzBBCrgQn/1mLphFhfkxafeOzJNFF5V+XucMffuUI5FMCFVPps83SnJwuok+5Vy08uzTmvjAm7
 J
X-Gm-Gg: ASbGncsqzPx6C4NBoqVRIFe2Hv6YdRwUP0hSK5Uz9QB9W+HC4A4zHC+ylZm31C+XFyb
 7W2TafL1p7WdVy7/CwUFowAY+M647pZ3nEwv6eQPdqQvwtLC9FB7i+y9nx9DaBiesIXbjk9mu1I
 yz9xmwk3S1/NH6I0e7cUwMNvj52Q4NzEHQT7Fa439Yry03rjsb5LVe1GeVE73P1ugrqmG+MNgjg
 MErUFYCpvFo9bVMnxMmuvjCFB1BXLU70k7/9At3Y+dFYNzXGIq29AnTAJ1ceky4CrXCmsRI3DX6
 LJiXGvXEcX/JyI3RZN1KdSRwlEFomxT7lp0t8Fy4MzZ7smTVyGEUA3kWC2LTBC33dJM2G115MM+
 Q42LcNlNPWFCb5LIP1xBT
X-Google-Smtp-Source: AGHT+IHEeSmQycdcPRPilEPN46M2KLx0DgnGBUIOfvhqo+t3Qgdzg2qlN331n14zj9svwQlA5J6N9Q==
X-Received: by 2002:a5d:5e0d:0:b0:390:ebae:6c18 with SMTP id
 ffacd0b85a97d-3971d237919mr9793052f8f.12.1742226650139; 
 Mon, 17 Mar 2025 08:50:50 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm15132825f8f.86.2025.03.17.08.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 08:50:49 -0700 (PDT)
Message-ID: <ad7cdcaf-46d6-460f-8593-a9b74c600784@linaro.org>
Date: Mon, 17 Mar 2025 16:50:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] exec/ram_addr: call xen_hvm_modified_memory only
 if xen is enabled
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
 <20250314173139.2122904-12-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250314173139.2122904-12-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 14/3/25 18:31, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/ram_addr.h | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index f5d574261a3..92e8708af76 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -339,7 +339,9 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
>           }
>       }
>   
> -    xen_hvm_modified_memory(start, length);
> +    if (xen_enabled()) {
> +        xen_hvm_modified_memory(start, length);

Please remove the stub altogether.

> +    }
>   }

