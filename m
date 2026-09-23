Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DB7C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Srk-000595-30; Wed, 23 Sep 2026 15:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Sri-00058d-Hb
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:42:50 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Srh-00087n-35
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:42:50 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747eefae4so3966255ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790192568; x=1790797368; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6shCzq5mS0/pDekKiXLAXxbVVtRD1QqgUyc9RCFwlZQ=;
 b=yPHs6JGtx8qGWUac8nPmM+tDKjv+JzdqdHsrPGFD282ZyNfmO1la5nxjAeav8JwcJF
 nVpbTzzRYgk7+hoW7PmjIGRi6+VPKJThNl/upotmvI9mDF/2L1tLZfb7hlloSicz5yfr
 97lzAE1ldpU+IQM1Ahitqs8VfS4RVAbQID/+dF9WII7Ed7x7vCgUzTZQSIda7iyGLEBq
 iqDgPz+eXqqktVqb6wRVY1dN4suZjoS3TdSnYkU6kqINVoD96voD7H7jJLyMfuo918v4
 a9q/XcfSZKOFXX7Ghi4nqKRarE73HxI02lozZdTQRgs5kS2aVwlnHkyIv2/v5S5wByMj
 ovaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790192568; x=1790797368;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6shCzq5mS0/pDekKiXLAXxbVVtRD1QqgUyc9RCFwlZQ=;
 b=Bg2KzrVZU1J8Te3NtgWKeUu5MIg/fjQyDXNwbIuLvpULuuOZtVc0NJYmMwJbKs5xfm
 b7VXEXOsqyAAtgM3Oh+4S6T9Ie3V72Au3RQ8haltn4+I7FNJ2WH3cLudoqrj0RvRROr6
 YY1uqjChL09J1ftT5fd0c/pDCMkxFtwzzXNts7kRPKMRRZt3CUCFxVub82hh5mjzC716
 gtBHqVTls4VKNsZeU+dJz4OmKpyNLVdHihPaE86kUN3XYmcQqDHpkAFXT4E67UcER02x
 MJfBE4KZxYZE8jXYk7oQGVJA146rMlA9jttBCJs9//VOuojT4he60fgOhB7xakKvhooe
 zm8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZBBcOStMhNFmlb4OIvzq7/RfqT5Y8qO7qWOx3O/xAmBiYg8e4AgHO1HAD8CQT5u5idjeS4G3H9Tun@nongnu.org
X-Gm-Message-State: AFuF++nylPLwlZYyYMQ0D2hWU7Bcqq+UFMclOQS6XDrcIQm8eghunU5G
 5yU4zQznesSRPkn6bAajcxhsRoLx5KDS3H8uswv4yZDbBxkcSTNvCbRCHt9aeF/RSdg=
X-Gm-Gg: AYBFou2hs6R07WgasUPM8k0ce/Zzw0rPe+Ew+JmEw5csddLfn+qdR+fHW1zF18lOrm8
 Tu262b1ZdO9ew8AHVpkDwNn4w/jVu03bjaqDc7juGUMkq4ZUeZuUltUCrWWy+XHVGWaNi8Jx6dd
 uYUL3lHBkmI89DNWV+cDaFtjgg0X/b3zI7BT89v46Lmj+FuYFIl1AX26XJEeKJGPyE+RCcpW4rF
 XkPYRq9bCL2G52fm0ieONWK3Vsoajc3mroS2yBU2GSoxrMTWBfwLbBmm9eGwTnyVH9fRlHAZdty
 uGh/xwpG/+33b5ILAsZOhVQr0ZDRMBe0tzXqiLUxhDSOdxPSQ6BQgF+bQvrFQSrZDohQtwOLZ41
 WBFJXUJublFcYJ1ht2vDvbtfPGSlRF3ZDyUTYJboP9JPT3kXnonoIeCIo1kkFZiN9d72wF3BMGQ
 QGeuiUJ0nstG2oYOBrxgjwtDIYvK71G8ySi6UNH1XLoOXI15UMbDF1+H29tWajn5j7682BbHtuy
 JhsTZ+1thUMvmsXLJj46YAA3+meJAD3HFR+o693
X-Received: by 2002:a17:90b:2b48:b0:3a0:7c6c:9824 with SMTP id
 98e67ed59e1d1-3a098b337a7mr97800a91.33.1790192567546; 
 Wed, 23 Sep 2026 12:42:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0976c7435sm577849a91.11.2026.09.23.12.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 12:42:47 -0700 (PDT)
Message-ID: <17764d10-d257-490b-bfe4-d0e6cd34cfd7@linaro.org>
Date: Wed, 23 Sep 2026 12:42:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] target/i386/tcg: mark XSAVE* as not allowing REX2
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com, zhao1.liu@intel.com
References: <20260923173021.317809-1-pbonzini@redhat.com>
 <20260923173021.317809-8-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923173021.317809-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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

On 9/23/26 10:30, Paolo Bonzini wrote:
> Reviewed-by: Chang S. Bae<chang.seok.bae@intel.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     |  3 +++
>   target/i386/tcg/decode-new.c.inc | 21 ++++++++++-----------
>   2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
> index a3702b00614..b4b0567e7ca 100644
> --- a/target/i386/tcg/decode-new.h
> +++ b/target/i386/tcg/decode-new.h
> @@ -187,6 +187,9 @@ typedef enum X86InsnCheck {
>       /* Vendor-specific checks for Intel/AMD differences */
>       X86_CHECK_i64_amd = 2048,
>       X86_CHECK_o64_intel = 4096,
> +
> +    /* No REX2 prefix allowed */
> +    X86_CHECK_no_rex2 = 8192,
>   } X86InsnCheck;
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

But adding the flags as decimal constants should probably end.


r~

