Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DF9CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8kqd-00052A-SC; Tue, 14 Oct 2025 15:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8kqY-00051t-1D
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:38:10 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8kqS-0001Mt-7m
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:38:08 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so4513778f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760470671; x=1761075471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Yv8sy8ZwmlYp3n//nG1dXyK7OuUV/z2iC5zjVIskf8=;
 b=oDkE9cZ2Q3c2+C0G3GvDvrHxqdeZx50csqNsU9KRU+6BQQUp6iSodV0TqzZXIIQ4Ty
 hOVRdhPeU/uIKG+fCx7B+MghU6gF9Pp/Lz1G1jmnsdYWPIMKVpQMX5+LJduVZP9ObCYy
 WrYObufKz2KUN56GvYWxCzjM5paiPKZ9wIO0J/VAeAQkB/dMcqFQmk+8kinJnn0aie25
 lATtYXPYe255GDtTGNct0zb+qcp0cUFtecAiOF6U7+3nsJ5oCb2xEYCeV3GEeqCE9sjE
 DkrugxTyYJFk6pkF6cp1Z41uvJavgUBgxNbLxTwkSPtq9H4+peYaIZnUfEqFWaj89+I8
 9vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760470671; x=1761075471;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Yv8sy8ZwmlYp3n//nG1dXyK7OuUV/z2iC5zjVIskf8=;
 b=PHSv+zuYWjSYn8fPsT3J8LbRb6/clMd3IRfhVRpI57Z/wKwqJ0ryD+wlXBYePc3aR0
 cH5wB480ZmGjwkOvnPlCjI+M5GyvG2KsUSrLBLWqQtOW7Ab2w8j1Nbpz/0wOq7GGmnj+
 8ZRIZ/7d/mTbGz1RBFiYbFl7kipeuj35wJud1lamWvW3eY2i6Mx/PU/cEfxhzMNXGzL2
 8KNAjGewjmU4C/eztKZnuzaTNSq/AB3Z80sLHcOCpXZETAtuwNQUamkqws1yxirKh/o3
 4UdTOFgi+RfbIkbg2G01Hp0u5kveEklJp/76pWWpewmVbej7+ZGeYIO91dTseHyaradT
 ZU6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhBKNq3QaL2IH5HIyUx0d+7AZAm1Y4z+ndzGWTfY5tOHaYMuRnmZDTfzJMjyqdOFZcPZTl3gXUoSSb@nongnu.org
X-Gm-Message-State: AOJu0YwZjybNb8R2XiGrPXQiFDt7Gf5G+FSaMI7p7O8FT6dfqpG+mI2z
 e9+BZ9O+487jrUfRXKaTARXUXcP/lwxWprSjvG35w2jMfwVA6A7qPHw4oQ0o6ZXLuEjUS0WNVJU
 IillbAskjCtN8
X-Gm-Gg: ASbGncv4H7tXwYn7P1DvssSRYO6mv9EglltVopinn9BiVCCIbtdoMRdL57bZNG+YwDD
 1ZlvI0Ht9aGEWy29GAeenJ/oWQ4vQK+Nvrm3cN3WhKOKCTV4c2efcdWZvFTAwSnZh0+pdbEL7FK
 xLCopWEHrgkrBASD9Af+Eg+POllB/baFAnoFJkUpAcbF6fTdYwnOymAMuFgCRBFMYgsEC30KA4p
 U9arf5Vtb68od20y8LgikCEYGnK+z4dyc0GYdE5RLS0QZDzdH5hH/qba4IjdVTNTo4o+BDvnWg2
 1KzWzJETj5to9Hb8KD5FyttKpEhgpA3m3iWBny2x27vbQtFXYdPaWOQpfhpptXk84ASgtvkhQnm
 uSaFf0/r9gekTrtFjPvW1cUF8f320IsJ+kRvYXkV7sGMmbycu6Tv9L3lvbmSD3cOuoj2hzRSs+t
 83kxyidjjHUex5
X-Google-Smtp-Source: AGHT+IGhXI5WfkCSyX70zZYJwupTRSI9LKGrsv9gEG5Thjn53BGKVCVQIJedacH0fe76ocUEIm8ORw==
X-Received: by 2002:a05:6000:2dc9:b0:3ed:a43d:e8c4 with SMTP id
 ffacd0b85a97d-42666ab332amr14221007f8f.6.1760470670855; 
 Tue, 14 Oct 2025 12:37:50 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5d0011sm25373657f8f.31.2025.10.14.12.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 12:37:50 -0700 (PDT)
Message-ID: <ae6208b3-f339-41c4-977b-177b973db425@linaro.org>
Date: Tue, 14 Oct 2025 21:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/3] accel/tcg: Add clear_flags argument to page_set_flags
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251014172341.243858-1-richard.henderson@linaro.org>
 <20251014172341.243858-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251014172341.243858-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

On 14/10/25 19:23, Richard Henderson wrote:
> Expand the interface of page_set_flags to separate the
> set of flags to be set and the set of flags to be cleared.
> 
> This allows us to replace PAGE_RESET with the PAGE_VALID
> bit within clear_flags.
> 
> Replace PAGE_TARGET_STICKY with TARGET_PAGE_NOTSTICKY;
> aarch64-linux-user is the only user.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   bsd-user/bsd-mem.h             |   7 +-
>   include/exec/page-protection.h |  13 ++--
>   include/user/page-protection.h |   9 ++-
>   target/arm/cpu.h               |   1 -
>   accel/tcg/user-exec.c          | 114 +++++++++------------------------
>   bsd-user/mmap.c                |   6 +-
>   linux-user/arm/elfload.c       |   2 +-
>   linux-user/hppa/elfload.c      |   2 +-
>   linux-user/mmap.c              |  32 +++++----
>   linux-user/x86_64/elfload.c    |   2 +-
>   10 files changed, 71 insertions(+), 117 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

https://lore.kernel.org/qemu-devel/1bf93222-c3be-4a11-9a5b-71029595d74b@linaro.org/

