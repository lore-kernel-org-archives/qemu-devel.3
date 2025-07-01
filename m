Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB25C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 16:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWdww-0004iG-Q9; Tue, 01 Jul 2025 12:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWdwn-0004hj-FQ
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 12:35:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWdwh-0008QU-Kq
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 12:35:04 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so27331305e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 09:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751387695; x=1751992495; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d2K10LNjVF7YPHB2xQYULfdat2hC8OE4Tb7cNChuI7E=;
 b=qaTPTw+52sN1dWeK+L0KQ+uA/VDWez+traZ45vKFh0GAuO26Czgoo7L9W+qgMhuWR6
 mu7llYKbaw03QxJkyI8m4ricngGw6ZmYB1IVfTHLaAJuE+owuny697NeRZELJGDXtVLy
 EsjQ2t8DZKSHMgvjRHn1Maik7x3zK+hQ1IokxLGINXx7/yJYEREefxM3opp0vtNzxZ6P
 6n0HpoQRw3oyush+NorYt3Z/obCxTgeP01cyTDUxd5xJKqxv3wmxzpeZPfXwDanxETz3
 m7DsW7zzQM+mCX6t2TVkIizN4volHroIgUSsOrCvsCbBiVy/zpOcHrshEmlXn2K6ZQf3
 xp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751387695; x=1751992495;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d2K10LNjVF7YPHB2xQYULfdat2hC8OE4Tb7cNChuI7E=;
 b=g+F0ovaolySemg7D28mcvbpDMiZpJZ3Dm8aeni5X+WxCRk0q6fnMtcLSUmQgLztlwZ
 nRNhk+RLQ717+hczMXiyu9tWSbDQZ0KCgBJvlglcgA6mgARYYs6bcoVYJhgW46sGt3lp
 WH5fcTd+qNyO+TN95JSIbFCr/nSauHKHAOx9ZhT8FQjUi4vLoFquU9npyWlitcFabjT3
 f9rkZ0UsdzWKVXWKhOXKRYsbFMbF6AfYqOfZHGahmQc8tuPbCScSnbYPJbTyTk1xqvJp
 DbiD/JbYv237vrkwNPirgBRBuxuf290YcncXvyaWBPWB/FKizNP6Z8K+KO4LT19li/JG
 ED6Q==
X-Gm-Message-State: AOJu0YyDdi12mKcdoDZGTK+1wGfJ4aklITDwwYUmju8ZjMDHLGeCDeKB
 ShdjSUxPmJH+2Q0FHBb2SZQGDxL4LxiI5ADWgmKnVc5l2QsV4B/s13uYyutr3ZnLF6c=
X-Gm-Gg: ASbGncsV1N+8Ji88d8fyTpzAOpEhKNTNUWnasDBchendYIVpWmRUui4BFZehWzm9EZC
 8soU/vEpfURq6XIdgAoJRZyr/jMzY1qrBNXotxajY0GJCgTnif5UTcyMiWk4uyA6IuDUHpKotsS
 AebmBF/WqnO4h0k21TxwPvLA7ZSsQ0s8yKrl4quA/LUSPsMDc9lZQ+UZ4QuqPxPUakdVJOp6uQh
 za9wPzY80qnIShOIJFmeyRjKCONRIJvgo0vF8s9xXaCGJo9WHVNbzJPyoUy+DP3SOBCjWD4GM6n
 zSNXcLuDJK0xUgu6zxQTNfTdVq/rtfFf45NTTGl84e2lSBwhLAu9WonjjtEcWMsTMuqE/FQC+0j
 A+du/6leQrJixcIRZEk46ooNJZiJhUg==
X-Google-Smtp-Source: AGHT+IELwnWyYcu4hvfdvvbC7DYEvVdua5rlUoWfFzyQB8GHFmkYY6GB86F+9a8HBtGke/AvoPoUtg==
X-Received: by 2002:a05:600c:1913:b0:453:8ab5:17f3 with SMTP id
 5b1f17b1804b1-4538ee837e3mr172158175e9.22.1751387695285; 
 Tue, 01 Jul 2025 09:34:55 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538234b30dsm200624615e9.12.2025.07.01.09.34.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 09:34:54 -0700 (PDT)
Message-ID: <30fb9500-b38d-4143-a4d8-d72d30a18292@linaro.org>
Date: Tue, 1 Jul 2025 18:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/26] tests/functional: Add hvf_available() helper
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Bernhard Beschow <shentey@gmail.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-26-philmd@linaro.org>
 <CAFEAcA9MLMJBFk+PQCJT8Bd+6R+vaho9_vXmDCjPU5cp6B7LfQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9MLMJBFk+PQCJT8Bd+6R+vaho9_vXmDCjPU5cp6B7LfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 1/7/25 17:50, Peter Maydell wrote:
> On Mon, 23 Jun 2025 at 13:20, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   python/qemu/utils/__init__.py          | 2 +-
>>   python/qemu/utils/accel.py             | 8 ++++++++
>>   tests/functional/qemu_test/testcase.py | 6 ++++--
>>   3 files changed, 13 insertions(+), 3 deletions(-)
> 
> This seems to trigger errors in the check-python-minreqs job:
> https://gitlab.com/pm215/qemu/-/jobs/10529051338
> 
> Log file "stdout" content for test "01-tests/flake8.sh" (FAIL):
> qemu/utils/__init__.py:26:1: F401 '.accel.hvf_available' imported but unused
> qemu/utils/accel.py:86:1: E302 expected 2 blank lines, found 1
> Log file "stderr" content for test "01-tests/flake8.sh" (FAIL):
> Log file "stdout" content for test "04-tests/isort.sh" (FAIL):
> ERROR: /builds/pm215/qemu/python/qemu/utils/__init__.py Imports are
> incorrectly sorted and/or formatted.
> 
> I'll see if I can fix this up locally. (The missing blank line
> is easy; I think probably hvf_available needs to be in the
> __all__ = () list in __init__.py like kvm_available and
> tcg_available. Not sure about the incorrectly-sorted warning.)

I neglected to rebuild the Python package, sorry...

Don't worry dropping this patch and the following.

