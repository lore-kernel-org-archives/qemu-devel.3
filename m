Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4B9CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 07:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0xAg-0003hI-EP; Tue, 23 Sep 2025 03:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0xAd-0003gR-H5
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0xAa-0008Ip-SY
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758611434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rpnSJ6NJ4RoYMK29SwlPSEa0ilMxmvA4JP131Z0CyNE=;
 b=iY0+y410qtc1T+VvYB5LaBxY5zGcRp1D1akAiXj5lOOSknupxOHuS5qpx9j+J732CkKBb0
 nAhOWwOkHJTDYl1BzY81tqW51x7DlrJx2rYq2Gi9/t67Hjiom+iiUbT7FJo1c0q8Okkdgq
 TwmkSpj3uV8nfQJ3/S0iVB2QwhiLuGc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-CDDauXN5NEmOdL_jwy27oA-1; Tue, 23 Sep 2025 03:10:32 -0400
X-MC-Unique: CDDauXN5NEmOdL_jwy27oA-1
X-Mimecast-MFC-AGG-ID: CDDauXN5NEmOdL_jwy27oA_1758611431
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-62fce1f3fa8so3250899a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 00:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758611430; x=1759216230;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rpnSJ6NJ4RoYMK29SwlPSEa0ilMxmvA4JP131Z0CyNE=;
 b=eVbbYvHBtGX+ILMfbFdHYHmznU3sDksWBx2O4CDNORbOf+FL9t/ldBkc4/jt8zLT/R
 EUnajCc4K3kkLUpV7FxUmBiFTt9uShakyqPEGawLyronPNHes3mZOIwNEZVndpqchrec
 XQddHzJBkNT4c0cpsi8I+0JoHqEDorXKUfZfc5uQtOxJFWm20fPntwYD98JqoqVYtGXL
 xAcLxBgoBKgaJE/8LU/nCNqkxNHoraiLM1m7PgbKnvy037wF7ZQiQHqH7AtCpg2PigGV
 +9C/dgvG9mEbc1zbNqnNhBYcKqaNxabzu9D7v+xas/LqxDmiAGZCMuF42oJipzTB6Kgl
 HfEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP9hMIaUXMmmlcQ97mY04iePAbisCMyMdOw3ncvylSMRJLkgCyTFnSA8JvpSv/O3wNLRGVJByMUWGE@nongnu.org
X-Gm-Message-State: AOJu0YyUq0NkCcqpMgFDMjRX4LZHUwv7mxy0xeB3dA1IxCauzSVmbFIh
 ZFF2ma3O1i9Sfh4W2pUHWFd85/um8FzTNxLdbUs1WgKrIq0d2GEhK/uxFW3uGrY5a71Ihn/fBQo
 fh775s4Nhr3zOPPpyeHSr0F/cMY5KdQ8l8Kv3nl/9xU2ej6gk+yvvL1QQqk3lU/K7
X-Gm-Gg: ASbGncs7Szk3sN6WENQNMAwrSqFYg6s/hVAAj8OLo3xDaAlrYmqwW/p1yrosxci1jVx
 zrX6W/DxgjH7uhOO87zTM9s5LQ8H2yzAH9QzNmx0p3GBW1uqMV/O4rs1gjfIu/qrVxBz2KoSz6h
 ZL4zAzEuZVryFwHoSlE4BKp0yNr7x0mYanAhQXJZw9RkijNBle183C98hhl/ig8d5nTLGoYNucb
 P26qu6dW8cF3r+zpkUJs9sPiMTsNid9DotQ60qI+PSqPyiJGJ39AXyn52IIPXpMp76U8gVlesXt
 SdYYyZJEbRe3MSrGJ/4d1Q1XYK9NBLaNH41R3HwgSUvengHWPQnKCkus8Y4qgnz+jE6v96qxCNC
 eXp1c3ISYlolBfkHuE2PLhddkE1n5hWNqmONeQIWgb7OPOg==
X-Received: by 2002:a05:6402:1d24:b0:634:5722:cc3f with SMTP id
 4fb4d7f45d1cf-6346779876dmr1131125a12.16.1758611430538; 
 Tue, 23 Sep 2025 00:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYOHc3MDHr+TEeYcICfcjGVqjEAvxLcPdHLHqRCHmS3kzA4yXc/Vb6To875f84F7VshkKC1A==
X-Received: by 2002:a05:6402:1d24:b0:634:5722:cc3f with SMTP id
 4fb4d7f45d1cf-6346779876dmr1131101a12.16.1758611430130; 
 Tue, 23 Sep 2025 00:10:30 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-62fa5f2b4d3sm10309499a12.42.2025.09.23.00.10.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 00:10:29 -0700 (PDT)
Message-ID: <67f2c84b-4bb3-437b-8184-e7dfb9947df9@redhat.com>
Date: Tue, 23 Sep 2025 09:10:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] accel/tcg: Introduce EXCP_TB_FLUSH
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-10-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250923023922.3102471-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/23/25 04:39, Richard Henderson wrote:
> We are going to disallow tb_flush from within the context
> of a running cpu.  Introduce a tcg-internal exception to
> return out of the cpu run loop and perform the flush there.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

One small difference is that different CPUs can fail tcg_tb_alloc() at 
the same time and flush multiple times.

I think the check on the generation count should remain.  Instead of 
introducing EXCP_TB_FLUSH, you can keep the guts of tb_flush() as

void tb_queue_flush(CPUState *cpu)
{
     unsigned tb_flush_count = qatomic_read(&tb_ctx.tb_flush_count);
     async_safe_run_on_cpu(cpu, do_tb_flush,
                           RUN_ON_CPU_HOST_INT(tb_flush_count));
}

With the unconditional async_safe_run_on_cpu() hidden behind a function, 
this patch goes away while the next one survives as

      if (unlikely(!tb)) {
-        /* flush must be done */
-        tb_flush(cpu);
          mmap_unlock();
-        /* Make the execution loop process the flush as soon as 
possible.  */
-        cpu->exception_index = EXCP_INTERRUPT;
+        tb_queue_flush(cpu);
          cpu_loop_exit(cpu);
      }

Paolo


