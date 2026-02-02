Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CA8D172CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 05:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmmEW-0003Rd-V9; Mon, 02 Feb 2026 00:12:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmmDP-0003BQ-Cs
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:11:13 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmmDN-0006NW-SG
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:11:11 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c61342a69b9so1570725a12.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 21:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770009068; x=1770613868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d+0Rv7tG+w4QiEGqp4/Hu25Olkl/IXBJsR+MFr1/W+8=;
 b=G7Zybq994kXS0OOwRww5A3SsOykSQDfqNJ6aQ5HFEvPvYyHKSVVu7Wp5qwzKKNrG6P
 fYrg0HzblhUxYkoxBZmQfQQWUsOwyZkjPoew2zjxn13Mczise9uQPKuU4P0wPjVla6aK
 vYuqVDT3Fej03OxYg0laQ4uOrXMlwrP3BID4PMAyO0iiRag3EdAFUDQZgJkxbKgmd1y2
 wBckYv8z6/+XICWd//ATH06cEbJLCAAZKFCfBhNpOjuhkpLmYhm2A0y8ofdYakv6OCYs
 6lPfSwYxLnR5Tjff6hFph/ZMA/Huv+eSyU7bN5lyba0eKEZjDoE6TePS9I6VdznHTY+Q
 uiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770009068; x=1770613868;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d+0Rv7tG+w4QiEGqp4/Hu25Olkl/IXBJsR+MFr1/W+8=;
 b=LUCGg0ESv5e3FNJzed7qq7D0a5fg0dBRMXxwkn9uWsX/E+qTAIlXgsoHZcpbojr3ov
 nrSY2QUq++xQ6XAe9jqXTIWypyIWYDHMTWAbeobvVuBUrpuPVlniCxRuOdXmHOQUDr7g
 RH0/Dye+NhUTzbdnv2fQ/7bNXDd4nC9SapYoqxxTc8igPa0Okk3/xCKE2R/WIynRG/wJ
 Djcx4ma0cYOpMfi7KvNTaKBaSFPF/on//xtaYx6xTEeXmo1D5+bmHbD4gd07ZS1RbcTZ
 OOiqsjgzGEAQTLz9RHzzLQmIpovlKeuWHXDnZ9J9hfVYxPsTMLkUdyI7BhKQ7ErpaqHw
 fATQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnodM1+Pw3oBlRKhD3T6T3X6ozQlxWqfeyVlXd/5/uvj9yOQfikgQdEhVObgI1x7bGQJt8gA22s5pJ@nongnu.org
X-Gm-Message-State: AOJu0YzX+e6F3UwXBUEO8i45pDAhVhmNken+vLYKmgB6SXth0/9dLV5y
 od7mWMs18mFpqBwQDzcopby66qtw1sDekv2tK3z/AjbW1KKX363DmKnLa2yEgvVJS6E=
X-Gm-Gg: AZuq6aJb4GQLfmyQhqc1AKJLuAeNLvfdm35wT7+ZI/wOG4OSCf1qhGvM0nN2jMTm3YN
 E4KSqRC1HUbICpjud/+b8lEyiS/5d2vArRdy8gWaUIFmT9BoMfpY3R1eEuT22pXYuY84klkiGOk
 9tH8EEqC55tcU0u19fDFUyftbBfpcXZcQWk9C7DnH7f+AgoskVXaxFxLS+Zg4LccinXjBp9pfI1
 MiS3SET5TZBcliqHjaJHP9/jp6olIRP1MI6MYDpcPj3HN74wXlbooL7YjZKBus5vHrVQ3XA9cAZ
 pe/NgtAiAQALfqTIowyd9Fm3HMp4x09frc8jEhDOxtJ4y9GrdYONHXAYcbNvdrmmCkoZtqpXF2L
 LVII6qJ/H33nSXwfOu7soXnqY2ineLpZnoaZq6ZBe4rzDQdN5JqprZ3XWTp+MxAyjxoOWpud0GQ
 hw2Ozcnwdx+4MHEtzxaIcgWS7KxpHXOvzBXqoi/fPwkv7gomrWj682MGvdzQDm4JF2dPMlNnEDY
 fjOMlCpBAkeNe04vfg2l75wXUN5KnxjUbtRuwNyqA==
X-Received: by 2002:a17:90b:2dc7:b0:340:2a3a:71b7 with SMTP id
 98e67ed59e1d1-3543b30027cmr10157379a91.12.1770009068297; 
 Sun, 01 Feb 2026 21:11:08 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:e524:51ca:ff85:53b9?
 (bg30dj08q4s9ql12qb2z.ip6.superloop.au.
 [2401:d002:dc0f:2100:e524:51ca:ff85:53b9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3540f2f0283sm17238508a91.5.2026.02.01.21.11.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 21:11:07 -0800 (PST)
Message-ID: <a7c2a110-f1c6-482a-b3a0-ba17b0cf191f@linaro.org>
Date: Mon, 2 Feb 2026 15:11:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] testing fixes (docker, sbsa-ref)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260130151504.550929-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260130151504.550929-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 1/31/26 01:15, Alex Bennée wrote:
> The following changes since commit 65fb9de4888f9bf32bc4f60c880da3dff04c4fd9:
> 
>    Merge tag 'pr-build_fix-20260128' ofhttps://gitlab.com/pbo-linaro/qemu into staging (2026-01-29 13:29:33 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-11.0-testing-fixes-300126-1
> 
> for you to fetch changes up to d9ca273f8f31acb22d3f5aca5f063b94fb962e19:
> 
>    tests/functional: migrate sbsa_ref test images (2026-01-30 13:52:59 +0000)
> 
> ----------------------------------------------------------------
> testing updates (sbsa-ref, docker)
> 
>    - restore weekly container job
>    - move assets for sbsa-ref tests

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

