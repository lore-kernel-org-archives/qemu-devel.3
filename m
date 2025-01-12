Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798FCE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 18:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX2HJ-0005SV-Of; Sun, 12 Jan 2025 13:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX2HH-0005Rr-If
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 13:01:35 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX2HF-00037P-Ne
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 13:01:35 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso1877261f8f.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 10:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736704887; x=1737309687; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZJ47eQrSvoFEHaxjjWYBy1IbAgBze63V7XOjdJCsQk8=;
 b=AjQ3nJHTqDK7l5OsE1wzr1neIJlf5dcdKQNq+ZodPhLIFL14E30ys0qD5qQf7GG/eo
 ObtNnfzwJHm7mErOJLwhHgQd3aMNuI8DWBnAIim5ILZ2okjV8BZWwqdODQQQUiXQa7XG
 soB0OcA372+eYDgSu0y7uT9+ECVy994JO8rc8wiHZ5esyJhl96hq/lNi8HW96EB2upiO
 EiOS+bPfNZ+IE7uIcA1mI5dgR/J/fyQXVQ8oNA4+x/FHA0tY7yrTCBAiTqk8yIaCF3kB
 aN6rfOIQx9ahRQW18kkA6MSzkaQUuv3Yib6stB18CNXtLb3bK6O3IyZRjx7S/zIxRyi/
 7wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736704887; x=1737309687;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJ47eQrSvoFEHaxjjWYBy1IbAgBze63V7XOjdJCsQk8=;
 b=qTBo7ZsK9q9iV8QgFfqrhAsYb2h/GFmSJdQgbcimfyvNsoN7YKWAaXF0MqNLxBLF59
 0LjBuWR2rJfpj+5rz7lfWILbdZS2T40CmnpuwIpqgAdvT1+i2agMmV70x92X4cTB2AT+
 5rPfcDHJ4samQZldLsMeKyTxV19BJ++xlWthRQ1nIPRCzUmz3ZfLI/HmZiH9JlziDB9n
 urgvtuhqaBy/pzMvZdTh+SyI8U8G/PtT/jWL/lmowKFMT600M7m38ntAB8vKMCCCjRTA
 PEd/iJKggjheIB+ddLVjBN9Ol++geiwCxZDeZoduQ70khKrBXap8gHH9oaB32XYjj+yS
 WTVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyXjzObavCMz3sIMmxpndhg4+6SDKZ8HWwQv4t8vWsTrFZ1hEbUSvS8AfwNTqECPJ9Lz6uthllAo2A@nongnu.org
X-Gm-Message-State: AOJu0YzuQkvO5KPWhDRMt1TeXmJwrog/98T4qdHbWdYJ+ByhV5hb0sk8
 q1WNfoL43TMSLsSnlZsxsrq7EOitQZfqKH5mtLSAv+JaP7Fr75yTEH54XssmTorjbAcNAe/LQuR
 qdNY=
X-Gm-Gg: ASbGncvwqSpOynlY7RdlsR+MeoKA1+HlwdPcv4dMOHeAagE8Z2buB/zSTAv1wgP0pjp
 6A9itmFKsyEwOB3k94cqJRp51cWFAvzewKJcoouM+F0P6VBlkvurydrirZH/jW3FK/d12x6ODJS
 yn07ELMzQi0/XDYVr76SeghTWxaW9A6zU6PNCilj9P3gSDFTIRnFqRJqkonELJpmCE0KKhnq6pi
 wCghfNwniVsTjADOB1//cBOTiwuLm78NPDzCZcraH9CYBEb2g9tq8YNzqdI7eymYSvep51aAQu8
 qVmqrRSzDO+xaOPemqP1KlvX
X-Google-Smtp-Source: AGHT+IHeodSrOx4xZCaI+z+8mMuQGc+naH7WvkXAcm+qCngDczLwBsHX9Tl25okT07vXjmER1Ph69w==
X-Received: by 2002:a5d:64af:0:b0:38a:8e2e:9fcc with SMTP id
 ffacd0b85a97d-38a8e2ea11cmr13315220f8f.45.1736704887428; 
 Sun, 12 Jan 2025 10:01:27 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c697sm10348274f8f.52.2025.01.12.10.01.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 10:01:26 -0800 (PST)
Message-ID: <b7d08568-153c-4a35-9395-214cd8d0a228@linaro.org>
Date: Sun, 12 Jan 2025 19:01:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Add a b4 configuration file
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20250102-b4-config-v2-1-cc7299e399bb@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102-b4-config-v2-1-cc7299e399bb@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 2/1/25 23:53, Jiaxun Yang wrote:
> b4 [1] is a convenient tool to manage patch series with mailing list
> working flow.
> 
> Add a project default config file to match QEMU's mailing list conventions
> as well as adopting differences on scripting.
> 
> Examples of b4:
> 
> ```
> $ b4 prep --check
> Checking patches using:
>    scripts/checkpatch.pl -q --terse --no-summary --mailback -
> 
> ---
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Changes in v2:
> - Add lore masks (philmd) from:
>    https://lore.kernel.org/qemu-devel/20241224135054.10243-1-philmd@linaro.org/
> - Link to v1: https://lore.kernel.org/r/20241222-b4-config-v1-1-b3667beb30a4@flygoat.com
> ---
> ● cc5a4c890fed: Add a b4 configuration file
>    ● checkpatch.pl: 27: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> ---
> Success: 0, Warning: 1, Error: 0
> ```
> 
> ```
> $ b4 prep -c
> Will collect To: addresses using echo
> Will collect Cc: addresses using get_maintainer.pl
> Collecting To/Cc addresses
>      + To: qemu-devel@nongnu.org
> ---
> You can trim/expand this list with: b4 prep --edit-cover
> Invoking git-filter-repo to update the cover letter.
> New history written in 0.02 seconds...
> Completely finished after 0.06 seconds
> ```
> 
> [1]: https://b4.docs.kernel.org/
> 
> Co-developed-by: Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   .b4-config | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

Squashing in order to avoid checkpatch.pl error:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index ec898a3cbc6..0c71eb3f925 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4310,3 +4310,9 @@ Machine development tool
  M: Maksim Davydov <davydov-max@yandex-team.ru>
  S: Supported
  F: scripts/compare-machine-types.py
+
+b4 tool configuration
+M: Jiaxun Yang <jiaxun.yang@flygoat.com>
+M: Philippe Mathieu-Daudé <philmd@linaro.org>
+S: Odd Fixes
+F: .b4-config
---

and queued, thanks!

