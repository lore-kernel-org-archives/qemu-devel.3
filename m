Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11278C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT8VS-0001Y9-Rx; Sat, 21 Jun 2025 20:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8VQ-0001VS-NH
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:24:20 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8VP-0003dq-2u
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:24:20 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so3140489b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750551858; x=1751156658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fUMTEZ1BwxUOR28q7J/eZfsZGNbFfiRvVaDy6HjLs4E=;
 b=XVvjSMptzDI4pNZIZ7Af+yJtnt5dzbsTZCRGNLxsWiHubFwRBz68VDlcLez+NrdisM
 ork12ZjCrQxgP9WlGYlhaEGmXZgKyJH1jb/nstWLgvqLddSL/pDUtGt7/FSpiJKQBTfh
 6mtZH01uWGvB25ISvFQOi8bAoMtl6u8G6DZKPoC4GI5pmfR1RsoXMJm0DbHAycVAIdDa
 0wcB2opTeT2j7W9qnNjq2SRRIwH1fCyR422ATm3Mdw5wQGJb92lomSn5bghBtH0i6SqS
 KWUxhMrEUiheBdqFmUBktbCC++iCZqv7noEbykCOsBFVtNXs6Rw0wtuHcIaiv/ioVsUf
 EuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750551858; x=1751156658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fUMTEZ1BwxUOR28q7J/eZfsZGNbFfiRvVaDy6HjLs4E=;
 b=uxuNJoZE+/Ig/jkhNDKk5lA3qDj6LaHiNpB5iWaK5AGmEo3Mu7kR2A92UMWf26RSFL
 yqfXa+2A4xAGxtqFJ54YE80PaqYs7t+JkrvB98Pd5tsNm7l5NEWV47sGZEhtHTemWygr
 hP7m74NHC4+PzG+VaYpPqI5THrXA2Nl9tyNAvG6WE9u/90VhLOrOm1e5hQ04uJd6rMz6
 qTNQWQvVZ82uah5yDhVa+syxRgZ/Tp8xhd4LM180rYIdtqktVCV2Y2KFsP08iCTu3+MK
 zExPd7cDv0xnKlvN9Nb8gR0a8x1wYajAONGuwkyf6pkYTt+Vf8jFyGgtAtQv94Am+54b
 G0Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+Ao9tkOsx0SdyIznAt7APzumhDHrWOIF5xECRvo+E8IixgUiNApn3iV4dC13+71iBIcMjRvRZLnDd@nongnu.org
X-Gm-Message-State: AOJu0YwAnnu7gDBugCdQ2bb97RfRdGWMIyn9+U/a68EF/+KQBkl+pm81
 zl76CzyH8n5aFjHKnBghc91qESa0tWWLHmCz657jota4t90PDEYCU63kXnmduh7SK1hpx9nYkjE
 nkzEq6CI=
X-Gm-Gg: ASbGncuGYFaMtV5K+98e1H4OkFBWUENcQLDFq/DofQH66bzGlXg8L1ZqG6GbrQJfyc2
 M+TzJnLoTsV/1H2TMWz14GbSJfDqoZYFnt9XCAXmujPh6ib/n8epl4EyEAkn2PoI2k9xnsKsuVR
 qZOLJEUeVb6IQEMcd7+RdDoCTR6KZQ5y2RbW37A/YHaALZnzGtSAce9Mtu4uAehyX+IIZ4tquKO
 ZwarIC6Krs/zmQIH8mCJjKcHvXMc3sk6eGlCKdz4mX4/jFVFkxE/+hqAgK8YKT1u2WNutsbZetG
 20JLSlrAtD0Zwxau003i0ZIH1ADFEuxU2NxNTiIMseyVaA9BfC+i6m9G6lITuXF/AZdCBY8Xqex
 G9OTGmpw6ajQ6o/NRYXMB3XSrQR2wTu2BNNyYWkU=
X-Google-Smtp-Source: AGHT+IEoMNIGK+lYwHIqKJNg2ijMI3y1RYRgOxz4zgn5nhu/vEBX9/VYH2RgGZaBS/ulwbS1KwM4kA==
X-Received: by 2002:a05:6a20:3d83:b0:1f5:9024:324f with SMTP id
 adf61e73a8af0-22026ecb493mr15393319637.31.1750551857758; 
 Sat, 21 Jun 2025 17:24:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f11a20c8sm4642605a12.27.2025.06.21.17.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 17:24:17 -0700 (PDT)
Message-ID: <371afd83-91fe-45fa-a119-b6b3414422ab@linaro.org>
Date: Sat, 21 Jun 2025 17:24:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/26] accel/hvf: Add hvf_arch_cpu_realize() stubs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-17-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620130709.31073-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 6/20/25 06:06, Philippe Mathieu-Daudé wrote:
> Implement HVFAccelOpsClass::cpu_target_realize() hook as
> empty stubs. Target implementations will come separately.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/hvf.h      | 3 +++
>   accel/hvf/hvf-accel-ops.c | 2 ++
>   target/arm/hvf/hvf.c      | 5 +++++
>   target/i386/hvf/hvf.c     | 5 +++++
>   4 files changed, 15 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

