Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB00C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 17:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucSn3-0005Di-BQ; Thu, 17 Jul 2025 13:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucQFY-00088P-7z
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:10:24 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucQFU-0002Un-Oj
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:10:18 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7e346ab52e9so132497185a.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752765015; x=1753369815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TlePFyyfNeXB5WjScFgdArr5bFP+TraGrH7O1kdRFrc=;
 b=R8FKGJ22PbvzwkROtTlbivgW+i7iZ1I+wMCudsqFPUdtWV+gfB07bZVkpvL3Vy8EST
 ORTXfX3K3JK0hHtqfs24oHEbBsvghnL9se8VVOjugYKJNYRhd+mfytItEudmAsCKcpUB
 9EbHEvEM/B6W81jMTEv9TZryncOgi6/l3q3CBqTFYyYFqdwPkOww0f7ODeCK2cFmK8BW
 oq6Heoy1nyCiurZigrXl3Jux29pWqH4lTMQ4u8gAwi3PlT92AmZgPtqZDPzSRqaApAPp
 y5Mqm3AthfSIX/rd2Z86dEu3rgmwSVdwWRCMkNwRl7019SRhfIB9Nv2oA6xGAGoeOXPV
 WyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752765015; x=1753369815;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TlePFyyfNeXB5WjScFgdArr5bFP+TraGrH7O1kdRFrc=;
 b=oICHX6v8vADn5wleDZdnoX6UBDGz5hvJmRcNhINTip9KT2J6WFnIDOR3TvLHTsk8lO
 uOpelts0vIrX/TRT9UZvDOvNrBefhPue/hKVVIqGtPrlkXs/f+wt9O5uD4e6wZi4g0rR
 y+iWyEAKD2qB0kQ5STFpWTzy1KvgqLm+VID5n5/ZmhQLLiXGQO7pmNhWmT3J9J0u15gY
 3kWYKoh9tM1lZNP1X5O9r5Vq3ujcZajiAhE7zd3Y2nKM8j6BCoBl+ZB5bMjF+y07pq0z
 5VxhQzdRvUqyc1j6kslAOksVbfK0iizVR0vJBqQADZwYywRjo5xK+yce/5OH3je5zGcz
 Q/4w==
X-Gm-Message-State: AOJu0YybmHerwkHrZ7uwJAaf+ItKdm5HYl7Elk9v3iMcPeg7AlQTkWZq
 K5FI6ftW6j85xKG4ULq8IR3hgaKtiddZk1PdFUEUpdne/7GnzW+FPU8WYlF6tYQ42Br9nrYU39e
 p5lP+hrI=
X-Gm-Gg: ASbGnctdsPk3Dm2IRYY/Y/Kl5domd2zNmrh2AlUSylHbYcxAf6S9IJ7fxuHCw8hGtRY
 ziVd/FFnn/JjnhZmsZFoEFoB+AlNrT8gFrz53NR4c9KprxOpjsrB1jDmN8ldyt7JD6dGs2Qy4qN
 68+BtN8iFdC2k68127xutQG0cy9zDcXDhGi7KLaYA9kiC/0iE0QOpO6c5MoUGPEMBAZXIOQG/8E
 IBOfTZdkUBncw+VPpjqCbjkT23Q7rF7YuSwyqbzz0prgrQnCOROT+3YCwqzutqQIvAA/241h/e+
 5/2Azge/VS960v6tZa7IfSCiXCEQe5/TXSWOor2RXOdwhbAFGBdR6neB8kqEWBiY8QSwuridzRt
 PWOvZmojNaafnEClBze7F7t4kemq58T9n0Dm1MVoJn6PAdlSOmJGH7N81tAhLcOyOUcyw1rhSfd
 JASD6lj28an9dhayzimQ==
X-Google-Smtp-Source: AGHT+IFZvuNS5RrY81HAIMvHRPboedY7lVBYc9vFLrIDZzgx8zQbaY38gzBGVI32+ulfZIMK2fCHTg==
X-Received: by 2002:a05:620a:890e:b0:7e3:3a5f:8db2 with SMTP id
 af79cd13be357-7e3435646b3mr981988185a.17.1752765014449; 
 Thu, 17 Jul 2025 08:10:14 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ecd:84f3:7dbf:d90a:4227:7191?
 ([2607:fb91:1ecd:84f3:7dbf:d90a:4227:7191])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e107f9a620sm632787685a.35.2025.07.17.08.10.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 08:10:13 -0700 (PDT)
Message-ID: <352357f1-f7dd-4484-82a5-9beca6d6f798@linaro.org>
Date: Thu, 17 Jul 2025 08:10:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Fix building of sparc/sparc32plus test cases
To: qemu-devel@nongnu.org
References: <20250716105414.2330204-1-alex.bennee@linaro.org>
 <89d04983-956e-4fa0-b607-951522b2a731@ilande.co.uk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <89d04983-956e-4fa0-b607-951522b2a731@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x736.google.com
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

On 7/17/25 05:32, Mark Cave-Ayland wrote:
> I think the basic Debian toolchain for 32-bit SPARC is working because it is currently 
> used to build OpenBIOS, so I don't think we're quite at deprecation point yet.

Bear in mind that a cross-compiler for firmware may not have all of the runtime libraries 
required for building userland binaries.


r~

