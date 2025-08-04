Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9A0C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqey-0005ju-4x; Mon, 04 Aug 2025 04:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqec-0005Wm-D9
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:34:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqea-0000Od-Hu
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:34:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-458a84e2917so34040295e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754296483; x=1754901283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=st24j4UZAzvpJb8c8QYj2IQFFM0KpR65CkF9zcZR8hE=;
 b=u0d5BW6u4fQrWf5uXNyY8FLosA0egG+Oe02mbLPiEO0nIafiD7qVAts69jIkRgPnlD
 Pc3ZmAIm4S/pCIlMlokriR2I+pfkrGNnKPhE5ZG8wNhAWNLiOLUdU9pUPzBy7heBi3n4
 tGble9N8GnDlDadxHRmzUcu3dNEzF4nRvoGodxYFVVpHYhrf0XpLEXHFwMABfw+9lfbK
 ZNAtNumawUalz34SGWU74AByh5eKt6ug5s0fNMLM5aECovGB2McZw+xba6vysTQeEFI/
 dQE/lmA0VzQ2E7bNV4ddwZQ0r31+TxMan2JZxSMAH0r8+tOWuvTYazGiyExGKiCSaeJx
 sF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754296483; x=1754901283;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=st24j4UZAzvpJb8c8QYj2IQFFM0KpR65CkF9zcZR8hE=;
 b=YLAKGjms9XOTBaaEvpA4f08GyB5ypU+vBTy+EQwXeNmml6t4JAvcU+nElrhtnsG1t5
 ehJpjH8gGiF940Ul36013H+38zgIq1+y+XtkXSE5ZLKtEx6J/xLWrzW8o/Ldi9QQBqvF
 gO2J84nhD6nLeAhWcNksHKReEVsATSfx+V2h+tmfcrNoPMvBKJ2efqRKcMu6n9EF4w52
 QuAgjRgCUitTerg84/6nWHMJSDlA0fuESSYVInShR2VjYAcfXLP1V3oZTtjL8GjDdBtk
 1wGZ3jJ7hhBB+8n0TbutUPYknyW0mgx0cXaXBCU2HA3uOUbpIMy4QglwuYPZkjKycjqv
 5AoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU701doZFIkubF9WLApTI1Py4M/XOxfsUoP3mDTpwTYQjiJC40x9w0uG10Z8y2Y1i52f6u2eOBv47h3@nongnu.org
X-Gm-Message-State: AOJu0Yy//jRhD4BDbeBf4BH/0QsosDGY+QFHi+FUAlo6tWts1zI0Dsvb
 zNmj+pgdWRtdvpa01bzyl1peUry8GVfGelNpVb7WoLBMUReNvxT3NUCcYXr0cycHoJI=
X-Gm-Gg: ASbGnctYmCVtwlcg32T4RVLAguCSVWYOez2NygZqfqcUx1LItjvC89NBR+94nE0iJmC
 VbMJnKuG9LBndhVvRRkiJOkux7z1kJxC/g1f857D1i78+opdOBZLAIicUdKoykrYUNawXiDCz4E
 EsOj5/bDYFNHh4aUuX2p+iJZLlZBFcmWQpsT1kd1rWqKAle1lYcZ6QRU1ncR6cm2QUsfiqrW13f
 V1/hdB8VWYPQxXmXXdARq+J0p58YRY2/D5HMhpaN+CEJYw3EEs95gDy8ipCBGsQvMldP732lybg
 JqDpthbeUSLPuv7+U7NqRrtfPaGhDQIdF9P89KYF9++zlv2Kic4Ll8gKhJIlBZb32o7WWSPzRes
 KJvnpwzvxW8aQm1B1kSWSNp2wC7B3GcDSgmxkMGK+MHqBlopx3DMl7BP3Epzyti1X8bzB/fQ=
X-Google-Smtp-Source: AGHT+IGTbOjQt90f2TAmcihrwzJsFFesHUzaPmhxjHmSAb3haTsXs8cvcKzOSPoqLPHiYigADTqMxQ==
X-Received: by 2002:a05:600c:4749:b0:458:b068:777a with SMTP id
 5b1f17b1804b1-458b6b5460amr71994805e9.30.1754296482866; 
 Mon, 04 Aug 2025 01:34:42 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c489e81sm14798780f8f.68.2025.08.04.01.34.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 01:34:42 -0700 (PDT)
Message-ID: <ed7ce30a-1741-4674-ba16-54f5b86a7f1e@linaro.org>
Date: Mon, 4 Aug 2025 10:34:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/24] tests/functional: Move hppa tests into architecture
 specific folder
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-10-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801151251.751368-10-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 1/8/25 17:12, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The tests/functional folder has become quite crowded, thus move the
> avr tests into a target-specific subfolder.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                                  | 2 +-
>   tests/functional/hppa/meson.build                            | 5 +++++
>   .../{test_hppa_seabios.py => hppa/test_seabios.py}           | 0
>   tests/functional/meson.build                                 | 5 +----
>   4 files changed, 7 insertions(+), 5 deletions(-)
>   create mode 100644 tests/functional/hppa/meson.build
>   rename tests/functional/{test_hppa_seabios.py => hppa/test_seabios.py} (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


