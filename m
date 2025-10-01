Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18154CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v43zR-0000yR-3l; Wed, 01 Oct 2025 17:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v43zJ-0000we-T3
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:03:50 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v43z7-0004BG-Ib
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:03:48 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-26e68904f0eso2938765ad.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759352604; x=1759957404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZbWysB4BLwKnNSFlp6k22DnxpWHP5NTJ3CmDeF4a/mw=;
 b=qYO1aFaGYrKVxXchCVPURTFfYPqosgPjKixvfaXyhjAjeUSq5Ve+Z58klb94nsXa/3
 ehRjZe5LGtgxHjeLogl5G9NhY3BYcm9IqJ4T5m8DNSN6D+C3cLYv7Aqr/1qpT6MyTsD7
 D4CkC1B/PNi1DnfQvh1K+bhp2XpsZpVmjhGVnremFwj03NeP0gMmsi7cqUt9u8UvgIqR
 VOOIUC7z8coMkyEO1kq/TTEXVVfx47cNfB/MRtz8+VIfuwjEeup/h+WFtl7ejhDV8vZs
 soWV+bxhXo8uYlvg262FluQ3bKOyOJQWHBaJOhtm28SwLY4a/0cMWmFeKfxhZxdUqcwp
 CS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759352604; x=1759957404;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZbWysB4BLwKnNSFlp6k22DnxpWHP5NTJ3CmDeF4a/mw=;
 b=nQWbkFQunCfDne6XNk6aaMyD7CoZUho6+GleOKR1oCkpdJTAhH7N0eRttfT4mvIzHB
 DuBLPu/UdF0EmRnuiz5wBrP8X2zXeNE2G+OQF4wCviKFBOEA7agA0Q/spH1VGbw/K9zi
 zReLmtI/Tkx4d87ByU10pj13BmWMug4PDx+t/F4MtLKnad67xapE55UyFpbZMFtS3v/Z
 dhh0VP4jo/bg4e+SE5KD62gS3E5ZK8rdLvcLr5X5tdVcRDUVrx+6aYDkY/1ad0fgzDnq
 frgCJyBQTNyinSP+kHxdGwEPW9DLYwUTZnh1ySnCnUQoMRWMnbis+1YCDJu7wcts2sM3
 H6XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/0SldN7GrUZe19nw+Q/xU1ouTBZift6WnFTNqwOuHwaVfo3baQOakTlYGhAy1UyNXZ7T/TrR8WiSN@nongnu.org
X-Gm-Message-State: AOJu0YxVQcpzl8wKonV0rNYLqGvoZUHgv9uK0eD75xwb6mj3E+/lN+sm
 99n7O9lo38IgZtNYZKID05zagr8QSLT7adyOuHYBE52DCMzNwHDiR81ILIYxdjhx/10=
X-Gm-Gg: ASbGncsKVB7D75AHRFUlNku3dbcert+pzAt8h/pDn7GoalcYqP0DbSEXHt09OBCDRHM
 xhyqFb1otsdyaRvPBKyFaxfUZJyCqdXZdFgU1tDyNU+GByYgELsgzjhSMZecHy6Vt8ivqs4zZVl
 7kIstDDc4542zVuoa++uONb7nngPkR+1m89Dz9fJxF/WQUZAT7AaItquZA7rGotpgESiPA34udJ
 kQzS17AevpA56t9Q/64/CZ8Lt9NYBX5Ei8vRzlnQ9mPZ2JTYmOV1Gr1BDbDOo8gbSvm4dY4gDAh
 9v7vg6I2ZJPBjSMN4kW4hr1mohjEH9oW2s9EqJD+zKRVSMUm9Hwp+zNi36sUSkoWZr8EelYTPwu
 mNY2FeJf/h6zhb/Q7q4tH3l3TGthrTKGXyowdA1Qty7ViS+qcQ5muf1IdmAdy
X-Google-Smtp-Source: AGHT+IEze18lci6QhXSI0pyjivHhs8/ki5NdOSJauXh39b6o1CSyAoKunE55CzTsis1nowYaOBnG0w==
X-Received: by 2002:a17:902:ce0b:b0:28e:80bc:46b4 with SMTP id
 d9443c01a7336-28e80bc4968mr52046075ad.55.1759352603665; 
 Wed, 01 Oct 2025 14:03:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d111a37sm5280805ad.8.2025.10.01.14.03.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 14:03:23 -0700 (PDT)
Message-ID: <51dc4cd9-a12c-4302-ac47-93aaf09a6406@linaro.org>
Date: Wed, 1 Oct 2025 14:03:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] system/ramblock: Move ram_block_is_pmem()
 declaration
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20251001164456.3230-1-philmd@linaro.org>
 <20251001164456.3230-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001164456.3230-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 09:44, Philippe Mathieu-Daudé wrote:
> Move ramblock_is_pmem() along with the RAM Block API
> exposed by the "system/ramblock.h" header. Rename as
> ram_block_is_pmem() to keep API prefix consistency.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   include/system/ram_addr.h | 2 --
>   include/system/ramblock.h | 5 +++++
>   migration/ram.c           | 3 ++-
>   system/physmem.c          | 5 +++--
>   4 files changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

