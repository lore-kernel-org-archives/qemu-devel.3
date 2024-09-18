Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511ECCDD546
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 15:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqwvy-0005Me-Eu; Wed, 18 Sep 2024 11:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1sqwvw-0005Jf-CC
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 11:49:36 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1sqwvt-0007fr-Hu
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 11:49:36 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7686F3F756
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726674571;
 bh=F+xAcdwvemJXFq2JmBI2yNArggYzfuI0I0zCGmRTnl8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=k1Vh2K9TQfYfBs5+LRj/7CcrOdYnnCIXY+kK9T44dw+UgWuE1Um3oxL+khRkXcD/r
 /GnAfQYkc6IKpOuDYl1CnuYgbHCAw4zyGxP9Vik4cTFju4kNxzTjiEpt0kmYPKT2ai
 lccjzpfGOY7R5Xx7/qIhKcJ1RNRpJiLirK2GWorYD0BnSwPfjRV8DxA3GJq7dPrWIn
 gFRgHA7r/WFirRvHS6xI8t7uOjMg6K0GPoNPb/nbzRUC1lrEzohw812zzgfQmgAtlx
 D3rjGveA0xJL7EKOyrLg+QVgGJUJbjxSNYJYRwG9l5hDy4VwX7LlARXGM/z4T8sBcY
 Gx9PwZExJqONw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb33e6299so44195135e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 08:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726674569; x=1727279369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F+xAcdwvemJXFq2JmBI2yNArggYzfuI0I0zCGmRTnl8=;
 b=kj8ES83KAxNpNyYo05NEMGIpgFEidPIWfQ+jWHV0y+NVGg0raY68MZF6d4XUYPr6bb
 pwsOcIIcNR3qgtD+qD2gX/NdFq3VbVNOah/w3igEGEf28jZlyImnjaTA+Md3F6Evk+kb
 7t3kERr9dcTf0q1pjKVscbFQ2xI1PO/17AgF11uqt9kg8514NsmYeFZqVy902AMR4R4T
 WHwLYuNCYqt1jWqpMmgUmhI4rqusSGf0N2c7w1iI+LmYgvWx4VdufkYxAGslcA3Tx5qj
 HOzG+slwFfLV7Jc5h7VGljdYauw4j9YFnNxJjrkk64WcN88iDOoB8zfXTVlgVOiB8w6q
 cSig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjpj3x85C5F8yncDfoF+tyBGUSxFmservWbhDNUJfslM0sEydzjyTROtowSFXkFSGunzSI5Zo06Iw/@nongnu.org
X-Gm-Message-State: AOJu0Yw96QXwjKmxe/Ln7RTathaXwOU0w39QxIqHjjIwxei0jQ7raZzg
 XqnO722AcXFiDizwLagJm97P4mzl5fUD4MbQOBh93vToczqbdPglPYV36aGETht0/dDiUZctAyn
 dA8LYXVZZKX773niJNJY0pe1AdQOTurf5H14DRGVsilzHLw5czbWpqulOVExYa14jkiRZ
X-Received: by 2002:a05:600c:4e93:b0:42c:ba83:3f01 with SMTP id
 5b1f17b1804b1-42cdb540288mr156767875e9.8.1726674568850; 
 Wed, 18 Sep 2024 08:49:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExAlrcNId5RFaxWnWQbjyD7bs3F/Z1jJ/Y8qRGrKFZW3zH9kusnRT07hhPZ09WpG/efGfuSA==
X-Received: by 2002:a05:600c:4e93:b0:42c:ba83:3f01 with SMTP id
 5b1f17b1804b1-42cdb540288mr156767565e9.8.1726674568334; 
 Wed, 18 Sep 2024 08:49:28 -0700 (PDT)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e72e4a46sm12643718f8f.14.2024.09.18.08.49.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 08:49:27 -0700 (PDT)
Message-ID: <620daf0d-caf8-4fe5-901e-2abadb751392@canonical.com>
Date: Wed, 18 Sep 2024 17:49:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: enable floating point unit
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
 <20240917-f45624310204491aede04703@orel>
 <15c359a4-b3c1-4cb0-be2e-d5ca5537bc5b@canonical.com>
 <20240917-b13c51d41030029c70aab785@orel>
 <8b24728f-8b6e-4c79-91f6-7cbb79494550@canonical.com>
 <20240918-039d1e3bebf2231bd452a5ad@orel>
 <CAFEAcA-Yg9=5naRVVCwma0Ug0vFZfikqc6_YiRQTrfBpoz9Bjw@mail.gmail.com>
 <bab7a5ce-74b6-49ae-b610-9a0f624addc0@canonical.com>
 <CAFEAcA-L7sQfK6MNt1ZbZqUMk+TJor=uD3Jj-Pc6Vy9j9JHhYQ@mail.gmail.com>
 <f1e41b95-c499-4e06-91cb-006dcd9d29e6@canonical.com>
 <20240918-4e2df3f0cabdb8002d7315d9@orel>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240918-4e2df3f0cabdb8002d7315d9@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 18.09.24 15:56, Andrew Jones wrote:
> Thanks Heinrich, I had also forgotten that distinction. So the last
> question is whether or not we want to reset mstatus.FS to 1 instead of 3,
> as is done in this patch.
> 
> Thanks,
> drew


If the FD flag set to 3 (Dirty) indicates that "the corresponding state 
has potentially been modified since the last context save". Upon context 
switches the value of the floating point registers has to be saved.

The value 1 (Initial) implies that saving the registers on a context 
change is not needed.

3 (Dirty) is the safest choice. This is why OpenSBI is also using it.

For reference:

3.1.6.6. Extension Context Status in mstatus Register
The RISC-V Instruction Set Manual: Volume II - Privileged Architecture
Version 2024-04-11

Best regards

Heinrich

