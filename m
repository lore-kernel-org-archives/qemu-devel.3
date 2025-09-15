Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C98CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 22:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyHJG-0003jJ-R0; Mon, 15 Sep 2025 18:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uyHI2-0002sa-SE
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 18:03:15 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uyHHH-0008Sc-Th
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 18:02:49 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b54c707374fso1202257a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 15:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757973733; x=1758578533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a231uzq+R7iz2yMZho6ndeoyunTHc0d8m1kbta7iezs=;
 b=EhQFID2el13SXEqpvUVTKSxjouG62/rrKdBnbu7y22febZE+La5/H6ZcEglO8S7eO8
 CkaL4KQmsqdbprFVMGtKTTEYvWBqq4QVPABlayOTjim/OryzN2wPWGhG70h037F5nIzj
 XguD0qs0JkrPv3Wxe/jOL2qoK6v7V7Aeq4YLqpTFYfi6ewsb395HbgbDZXxSEZxgown8
 YPQ5n1ppWs0WzDdIXx15pshI5PR/wEUQ99nvc5IWBVB6BNnh92LLn7dBNC3LJn8R9W+N
 ICJQaDydcb+JHoaFfnkYGQSKKhDlyVQad3ASW8i1+Ejh5JShNBJEZU4xRwGWUXI36hXx
 rw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757973733; x=1758578533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a231uzq+R7iz2yMZho6ndeoyunTHc0d8m1kbta7iezs=;
 b=MXx8u8CZG48bmTo4Lea3T1Y0PU1FRLVCl5KfpjkVrHBLOPqVfc2X4O/ecy8CLdRkjt
 UL770P5yaIDRpwXSDvgsnOpm/ROMiDK7kdFDVNzcGbsijPeep0EZ/y2laR0pZsutAqDO
 2MG6GFnO4V+HLs1cop4NrmtbiMU3n0Lk9YsWvmd5KZTrK5sfXC30eFe+Zj+vMjLxeBic
 NGLzfFSeV4D6TbYBgwX8pCk/TouiirGbgpvcXlIBGi7qbzR1Q2FM8nP2Ke8+k+dJj419
 QulDmaOTolZKv7jiV2VfTWWo/z6NbW2Jqc3rV7BR+PnFTc3RXjx0gno06y/TEjMyZVmH
 8+qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw0XHqL+1YPnT+pDBHH6neEQ2TOUBwVvyo6Qv2TumUHnObpC1dhicAVXJq1qwsH74T/otobpgpuYO9@nongnu.org
X-Gm-Message-State: AOJu0YzbmEcKunvoMgvKvExlOXtd1J+h3VS0QEq0YqLl8IsvnaORxG4a
 r0SYgrg7qXsSzgaACw4ipc75Stk7Mdh1myvXveYHuE5jREt8eqf3rKUdBgkxzRJaOcU=
X-Gm-Gg: ASbGncttuDgNsgxRA2DKi18CvnVWeHxO3MFT4xyEsuaCh3aVHbSbZVpqv0genpK85TN
 Kiw1zvo2QeqME2XBpfqFWG4uj++Y4FKM+LM9az7KFgNYZy7OXEM9aP/tQ1FvF9YLaQsZHkxlh/9
 uCQ1DkEjHWu6ECU5ch8o4Uh6yRI7oRAuOyCpE9qAoBal3hLBOpYpmvI/E+Diaicj02dyT4xU0Wr
 YiWGfQaaU7PjayvszMyhc9QCpSmCCEcfdWMUSGq5fOkRdq30dsJMmcSxfQWF0eyvSP1fLCm58H6
 5l6NWbitGYcsnRbQykOB57HOnlgHRckV3g3gnoslHwEcPezGUb53+Ggt9ap/O/rEQFzYoSZ4M1U
 /hLgrzSPZQLxMbOsSGkMwlFjl5/AVcQi5OhKDUqmFfKW+5x92cXJ7IOFC9LJtiZTbpYq1vNscOQ
 vDuFc=
X-Google-Smtp-Source: AGHT+IG4fVNccz/oJCzx8yG5hwVhr6XpBF+kSk/ZnQrXiKnUcd59JVe27RBzo6/l1B4ddSP4iYF65w==
X-Received: by 2002:a17:903:2350:b0:25f:d90:ed30 with SMTP id
 d9443c01a7336-25f0dbecd59mr163021395ad.57.1757973733339; 
 Mon, 15 Sep 2025 15:02:13 -0700 (PDT)
Received: from [192.168.0.102] (200-162-224-93.static-corp.ajato.com.br.
 [200.162.224.93]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25f4935db09sm94265785ad.61.2025.09.15.15.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 15:02:12 -0700 (PDT)
Message-ID: <750ceecb-7c6e-4cf3-95db-c33bc4c5eed1@linaro.org>
Date: Mon, 15 Sep 2025 19:02:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] tests/functional: Adapt reverse_debugging to run
 w/o Avocado (yet another try)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250915124207.42053-1-thuth@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250915124207.42053-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Thomas,

On 9/15/25 09:42, Thomas Huth wrote:
> Here's yet another attempt to remove the avocado dependency from the
> reverse debugging tests: I basically took Gustavo's patches to rework
> tests/functional/reverse_debugging.py, but instead of calling that
> through tests/guest-debug/run-test.py and adding the cumbersome code
> to support additional test execution logic, I kept our normal way of
> running tests via pycotap. Instead, the essential logic for running
> gdb is copied from tests/guest-debug/run-test.py into the new function
> reverse_debug() that then runs gdb directly with using
> tests/functional/reverse_debugging.py as the script.


Thanks a lot for this series. It's neat that we don't need to touch
meson.build, TAP works, and no additional module is used.

Thumbs up from my side :)

I just have some minor comments about it, inline in the patches.


> Marked as an RFC since this still needs some love... The aarch64 test
> seems to work already (after applying the fix for the reverse debug there
> first: https://patchew.org/QEMU/20250603125459.17688-1-1844144@gmail.com/ ),
> but the ppc64 and x86 tests are currently still completely broken.
> Also we currently log into two different folders this way, into
> tests/functional/aarch64/test_reverse_debug.ReverseDebugging_AArch64.test_aarch64_virt
> for the normal outer test, and into
> tests/functional/aarch64/reverse_debugging.ReverseDebugging.test_reverse_debugging
> for the script that is run in gdb ... it's likely ok for the aarch64
> test, but the ppc64 test contains two subtests, so we need to come up
> with a better solution here for the final implementation.

Although I don't know how to fix this last bit, I think besides the
log files nothing really changes for any arch in comparison with the
current version with Avocado in the tree.


Cheers,
Gustavo

> Gustavo Romero (2):
>    tests/functional: Provide GDB to the functional tests
>    tests/functional: Adapt reverse_debugging to run w/o Avocado
> 
>   configure                                     |   2 +
>   meson.build                                   |   4 +
>   meson_options.txt                             |   2 +
>   scripts/meson-buildoptions.sh                 |   2 +
>   .../functional/aarch64/test_reverse_debug.py  |  16 +-
>   tests/functional/meson.build                  |   7 +
>   tests/functional/ppc64/test_reverse_debug.py  |  18 +-
>   tests/functional/reverse_debugging.py         | 235 +++++++++++-------
>   tests/functional/x86_64/test_reverse_debug.py |  20 +-
>   9 files changed, 188 insertions(+), 118 deletions(-)
> 

