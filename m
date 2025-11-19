Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAD4CF3182
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 09:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLekV-0006Bp-2j; Wed, 19 Nov 2025 04:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLekR-0006BU-Ma
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 04:45:12 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLekO-0004V3-SZ
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 04:45:11 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso45167485e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 01:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763545507; x=1764150307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BlIr6YwxMlRV9sP0VE0roAh7cyum5XyPX8DYr31xbGw=;
 b=dey7fGcOEk7SfCKuQjWQ0Uz+iDE4feZwSlg3LTwir5XOtGjOUHRgHIqe4RqfUm+Dzm
 OIS7AHJsAIo3JIqDfrasQClhr56b9H4m2OOSPPmiUYYPa69wWLuF8qYMh452bIsaBy7b
 0MNAZXDTNhXTznYWsXjfXTO3diVjFfaF0VapAIgkb/pTw73FKVd02HnmiOyuNnXEGg1I
 W04M4qoKneZstiwCigy/JeJaI4/m0f/jJfMYymcgy9H5K8hsgcMcvtjaHFfW5n1XDpjR
 atII6tvkgPC65h3XNs22JJb894Upg6Q8WZLQ9HtVB2qJ+86+h1RiDb1XpC7uGyg7wwAa
 ttmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763545507; x=1764150307;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BlIr6YwxMlRV9sP0VE0roAh7cyum5XyPX8DYr31xbGw=;
 b=iil5eR1dcexFEvHwHbUmWXtvJ2CI985xjgjGS54TpcIVL4Zqpl/1swAGkDXVKHhPiX
 sUNTKrksymzEmpzHtGvjjBr4QaTNCzQ530dE0nf4jXQAUMiBuOmbTWXx/ng0Kxm4BuI6
 f079+Xpx8yoFRBEg8MZWyGCQ3hk06CaqyfKmLGWen33Uxej25+WTgcWlwJi+ZWvYCDsO
 dGl5+FsRFt+Fq5dfZNoRtPhnpEcgpyP7KkbB1tGQRKdUKQE1kpQHa1452QD5WVY/IKqV
 2W74Q/oyOxpSoSoPar7jeQK1HZ2Tet7ElVr0Jdr2STHqLktbd+omQwAhVU86CZGIYkKc
 v2Gg==
X-Gm-Message-State: AOJu0Yyr/o509e67ubabjstHMvlMulRjYd8uUkZUBA2XpdIexNPh+r1a
 mAk2Tp3JSSJYlpaYP5pOf15HtE7vCROwtTz7awOvoqSZGZmYWJ78UbxbcyQIJPECqDU=
X-Gm-Gg: ASbGncuhUyKddDlNCQq0/WZjDJOhTrLBxi7G9ZxfCtR3Q7O7DTGGr/acUegAn5XeV3f
 noIyGnAMNjDHetisMABEx+O2eYtfLQzSGKnHqREgRtYb7Qvq2T7yZZOd4L380h/z+nl3YYjzR8L
 hMiGHdHQG39mDlt+htBYScT3lc0GjyB/DqwNoCIQB/qJYOzADh4LWrCPHLiirA5jM+lDHqWHa8i
 javopscgpviSIk2sr19CJR8S3+LqnyVK0rZE+JVwx3jBpPUIauPogvBCtcCh6ajbJpfNHXuDB9A
 cp3QMKFVOVgCchTJbezXHueTv3bik0ws89tTQAtrOXoSWP88XELXDzuTbMMg8Jvu4fj+uAiFlPs
 wJv5HZwvRGc764qD23qbfOFLTTfVnrsYducglXgkMOMAWd1OgZZRnI76raLeGUfJ73XqkDczKfy
 Z6OCUZrfYNabn5vKwgo07+dTwyLibBSupN7IJxQmaUgIJZkUmFxFTrSJNVPQBXZgcni1Q=
X-Google-Smtp-Source: AGHT+IFrJgRckt5TzSKUhiUw5jFu7Cni4o2+B5oftiAkKLRyCFcKAH7ZNJ0PzJBFtvrTJO9upUzIlw==
X-Received: by 2002:a05:600c:3593:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-477b19d1156mr16883675e9.18.1763545506729; 
 Wed, 19 Nov 2025 01:45:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1?
 ([2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e982d6sm37187167f8f.21.2025.11.19.01.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 01:45:06 -0800 (PST)
Message-ID: <a4451602-70f7-4603-91af-693a0a4a72b5@linaro.org>
Date: Wed, 19 Nov 2025 10:44:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/19] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20251118170256.272087-1-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251118170256.272087-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

On 11/18/25 18:02, Kevin Wolf wrote:
> The following changes since commit 711a1ddf899bef577907a10db77475c8834da52f:
> 
>    Merge tag 'pull-10.2-maintainer-171125-2' ofhttps://gitlab.com/stsquad/qemu into staging (2025-11-18 09:18:23 +0100)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to 837c04e9fc798cddafe721e2abbbd0d932571793:
> 
>    win32-aio: Run CB in original context (2025-11-18 18:01:57 +0100)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - Multi-threading fixes in several block drivers


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


