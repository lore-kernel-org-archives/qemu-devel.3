Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CD2D47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 10:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggyL-0005ur-6y; Fri, 16 Jan 2026 05:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vggy8-0005nz-21
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:22:16 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vggy6-0004wk-H9
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:22:15 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so1460356f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 02:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768558932; x=1769163732; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+6O0WSPTEuOR1xkX62l6JtkQOE+pTi6GZ7PRXWNoFgE=;
 b=hXLr2r0p/iw0lhiRxigCz4wkSMMVvIw2sPeK0GUT89kdxhzyEvWeqAorLEsamBZyh+
 AOb5ZzVuB1kKT0JrUC05FsvtqR5tCDGCwEtJvXL7aJjSgiu8ac1TOmpyTXIy37kTGkn4
 Ghd8BKYwd6XKMZ0nMt/BW5p9dwR4IJFi1W2xlbMz2iusz12nNR7VJFa+VBF6MX1dj+I5
 jd52dj2b/UJuzON4hMpkfSmPeRkF5e8ZakkSSXkKhm/UIdFlZ5TsXu/Z0HPe1zsfT0Z9
 m4xa0AORj4+O/8LEzd5yw7aCPNSEVboB5aMk8CuwUaarZST2GOLxwkO+2/U+R7e2xIIp
 8RPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768558932; x=1769163732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+6O0WSPTEuOR1xkX62l6JtkQOE+pTi6GZ7PRXWNoFgE=;
 b=pPl9NBLfNjmZ0Q4IOWYx1O501YEkEqPVDbVb3dieF/bU05E+B7q1SlIvr/3PDsl2ci
 42m1cFmi2d1dE59xU4heNlBafYCuLg/UDf0PtT4f8rMX9w9ay0OBwMt+kkDVpO8AD6rn
 F1Pg+5yggV4H8k9YSchPax4Ljcv4zaVVt27REfDP7jINMroiiH72btY7Oz9CNlTCAZnx
 PbZVFBRGQ9AGAFPMyQV8Ck2XF1pOaNZ7216imJtckF3xopeQhAzoPMRTHHRVjhMCFTC2
 ZUvuoNDW9LKmRMpyyEO6bCpw3VtA6yhCN05mB+nQj8T4DVXpxqutTMya6bc68o+Ba01+
 nf8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNqlvuZtEWR1nqPkZsq8t4IrhkNR2CgHvn2T8aE42aHXTe5tyuu6BtyuZtYoQePupANT2SoYt4fKm+@nongnu.org
X-Gm-Message-State: AOJu0YwnAdgNhM7hE6QqsIJvPU3QMnYyBlazRGUNvslSi16duj5TWZOe
 FwIHABcar6WBEeCxUFXhuciB5QcfMS2uR2xd477drzn1Rby0hZKnyz4nwNac99gheTk=
X-Gm-Gg: AY/fxX7RakK75VSXpA8B/RDrwXMXKVcGKVO0X/DlUDA8Dy5sZ7FHnqM0PpkLejsjGY7
 rRVwDPK1v2rUs0OWtkB21y+3NaCRI2WJd+JUR/QWkdtR739U2txFkERuH3gkc5H1D0zDlNHiFrk
 oJdJZUsbd/1X2Dmk4/QldHo05EXDvfRjHP2zX27l1TOndCAwcXv03T3vCgARCXsvXwoNH18MnCt
 B23iC2twH20r+S7rauNSmuWEBjlsy9hEXBHWEzIkySfAFBROApkYuh3a6Bxn6kvkPjOpvXxxgL2
 x/kISdojS75RLMdv7EPXVWSzxCK99gS4GqxjCmjcHlW8S8gXBU6nYBFv1X+KneGTFmw1T4bGAEB
 g5SLscwevsNKgwOtBF5umP/8eIFvHhZ0st1pDKy6a0srplB/1UffOlqVQ7oUmHeMEw5Vn6rh20m
 dgovuSuyO4Sf2EmG7zpcqFjUKPKz00F3WaeN/BedQTcIhEyvisq1l/2Q==
X-Received: by 2002:a5d:64e5:0:b0:432:7068:17d with SMTP id
 ffacd0b85a97d-435699810cfmr3093742f8f.20.1768558932573; 
 Fri, 16 Jan 2026 02:22:12 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cefdsm4325182f8f.24.2026.01.16.02.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 02:22:11 -0800 (PST)
Message-ID: <2a9ad6ec-d41b-4f34-b070-e4a10ebd6cc2@linaro.org>
Date: Fri, 16 Jan 2026 11:22:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/riscv64: Silence warnings from Pylint in
 the boston test
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
References: <20260116095615.269199-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116095615.269199-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 16/1/26 10:56, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Pylint complains:
> 
>   tests/functional/riscv64/test_boston.py:1:0: C0114:
>    Missing module docstring (missing-module-docstring)
>   tests/functional/riscv64/test_boston.py:95:8: C0415:
>    Import outside toplevel (subprocess.run, subprocess.PIPE) (import-outside-toplevel)
>   tests/functional/riscv64/test_boston.py:112:17: W1510:
>    'subprocess.run' used without explicitly defining the value for 'check'. (subprocess-run-check)
>   tests/functional/riscv64/test_boston.py:95:8: W0611:
>    Unused PIPE imported from subprocess (unused-import)
> 
> Rework the code a little bit to make the linter happy.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/riscv64/test_boston.py | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

