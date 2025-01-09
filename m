Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E709E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 10:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqFv-00027d-F7; Thu, 09 Jan 2025 05:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqFt-00027R-N1
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:59:13 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqFs-0000Rv-19
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:59:13 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361f796586so8234725e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 02:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736420348; x=1737025148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EtxRF3y05zfQTKnBAw9/bJz/KlcfWNgncPZ8Zc2e3/E=;
 b=dkut1EnCt1avtKtBNOLhU6NTPJaZkexz6ZJauZ1VPo+E+LlrOM5E9JogghlO4Yccmj
 QT23iwn0aN384u+wkR5PIqj9k0IqDs67WlkQ/R7lO7Gqtq10fW+ID9OkFbUyeOrlYMZN
 1H0QVv6IS+NvpQZccuGekz9TSnWySiIViSCTUfvKqVAOkA1T3e4gr+PgGGD6rVS0T+RV
 ZW6CuFDuwJM9owq6g0AnaaONR00OvDfJobEQSQwkXbU4m/TAktlMFkSDQteHKJC5O3Tx
 30YlH4fcgCqjiOzf2V67MuynJF+2/hMfxzZuA1cecvdeoRB/d0f3enozaVQzd7BNkZXc
 le0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736420348; x=1737025148;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EtxRF3y05zfQTKnBAw9/bJz/KlcfWNgncPZ8Zc2e3/E=;
 b=wil+B0AViEfAZtVdxB38Z7RGS6SgtIE7guNtFwovd/+q/nsJA07yllb88WZsvzMqwE
 pxb1K98vqrUHv36LKO7uMYHaPQ9VcKzbKHXBJIuxkFCwJjOTkRKC/N64OjWeuuGL9L7b
 3oqRmCQAQeHRKq7/wT0Wxm9z552aQaMPTbiaYiuw50G7mjNH3B6n1ELuMOF8doj+v4Dg
 j149BChQYxudyIs6v/fkVIfi3N+LszdpkinAx3Kw9tSxxS1vDn4WZSwIvnSpKc5iEaZ5
 rXmBLgzof/LU2iXbyJQGesTVnVBtU5V8dRmz1pryKbZNE6iKg8H+KLd/xUufioCspkDd
 tUJw==
X-Gm-Message-State: AOJu0Yza8D/uqe7VDd+Pqq5aMPVTiSd8BOZQn9OzBpWfAu/dhQ8QtbZH
 fB8T9rAOlzcP2oIHk19l01a0JaYjBiQ1BMwLF/exxpvWJj5NkuR07C2O1iQLhpzy+RNYKSX7+C4
 OVHI=
X-Gm-Gg: ASbGncuv04j8ZckbqyEBG2YP0cVcGoCsLuGe1wWEB19AYaxfBaS5PQ1JhYj9p21MJ2u
 rcnWttSfcXtvZ2JQLCRyZxdmopVleClovVDeJ7DcPJEiRsI4nOMDKVgqwL2VEdvaAkw33XeFnTz
 BUorJ5sn3izyXj8NdRKi9bFZ+853T1WeBIAT0nvcekIH8BqZdQ+vKOLREU1HP9vdoBycfwOPjN/
 WoOzfIRIoy/j5PrnPJtG4OttcmVJrfF/8iWaWPZq8SIepG6whR6u69FN9PhPp+1EW3v9BYWSeIR
 FtJvQJOT6/o2JE2psKyvyzYU
X-Google-Smtp-Source: AGHT+IEVKTrAaNOiibkH5j+EH+uFkJ9kd2O5eHEOxIow6PM8620Gvdsj+N7/jRyF11GiVggiPKmhXw==
X-Received: by 2002:a05:6000:470d:b0:382:4ab4:b3e5 with SMTP id
 ffacd0b85a97d-38a87087028mr6327643f8f.0.1736420348454; 
 Thu, 09 Jan 2025 02:59:08 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38332asm1475124f8f.23.2025.01.09.02.59.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 02:59:07 -0800 (PST)
Message-ID: <0006c412-11a6-41c4-ab80-5ef18350797c@linaro.org>
Date: Thu, 9 Jan 2025 11:59:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] linux-user: Call tcg_flush_jmp_cache() before
 re-using threads
To: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250102182521.65428-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102182521.65428-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Ilya,

ping? :)

On 2/1/25 19:25, Philippe Mathieu-Daudé wrote:
> Fix a bug reported by Ilya in:
> https://lore.kernel.org/qemu-devel/uuuk6a2vo24yrrqrchjxaeko3utqshrdu6txcnqziokpg7dkom@4l4kd3dqh6jc/
> 
> Commit bb6cf6f0168 ("accel/tcg: Factor tcg_cpu_reset_hold()
> out") wanted to restrict tlb_flush() to system emulation,
> but inadvertently also restricted tcg_flush_jmp_cache(),
> which was before called on user emulation via:
> 
>    Realize -> Reset -> cpu_common_reset_hold()
> 
> Since threads (vCPUs) use a common CPUJumpCache, when many
> threads are created / joined, they eventually end re-using
> a CPUJumpCache entry, which was cleared when the first vCPU
> was allocated (via Realize) but then stayed dirty.
> 
> Have cpu_exec_reset_hold() call the common tcg_exec_reset()
> helper on user emulation, eventually calling tcg_flush_jmp_cache().
> 
> Philippe Mathieu-Daudé (3):
>    linux-user: Only include 'exec/tb-flush.h' header when necessary
>    accel/tcg: Factor out common tcg_exec_reset() helper
>    accel/tcg: Implement cpu_exec_reset_hold() on user emulation
> 
>   accel/tcg/internal-common.h | 1 +
>   linux-user/user-internals.h | 1 -
>   accel/tcg/cpu-exec-common.c | 6 ++++++
>   accel/tcg/tcg-accel-ops.c   | 4 ++--
>   accel/tcg/user-exec-stub.c  | 4 ----
>   accel/tcg/user-exec.c       | 5 +++++
>   linux-user/mmap.c           | 1 +
>   linux-user/syscall.c        | 1 +
>   8 files changed, 16 insertions(+), 7 deletions(-)
> 


