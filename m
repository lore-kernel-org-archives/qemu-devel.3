Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF71BCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utNtX-0000zA-Ow; Tue, 02 Sep 2025 06:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utNtU-0000yE-LR
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:05:40 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utNtR-0005Uc-VS
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:05:39 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45b7722ea37so18380015e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756807534; x=1757412334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wgG1TLtqGBeWhctyBCBmqSrMcDiTygHV1aSWWvhvhgk=;
 b=WY21kIWhwWnOylYMna5CLREspAFujB34l5XGNPIAAv8rrtSMgRN5QxzCzCS0J+wzMc
 lHHOazhYvnzzkgTVaqDOup7OQTNyPpX4bntydIpO5o8w6nV1/hjksBcH8J4suL9BLR/0
 ukUvPT2VmnqamS0RYVZmiiG5IN5ojGqKw+vmQaTE6eU1qEejqBxpzqZfgQUY9yZpgrqo
 YgoBZ0dzmhdvyt4TCYu8iQq/YAT+Uhg/us8tjFp5pAjvQc8cqsLExGJMyZUR9hdLqYHM
 Xm3J9u6qpqJnv3JVwR7xgElFe4oRNQxDrH/07t6UQDD1JwObZ/e05aqbz/23savyw6DZ
 Jr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756807534; x=1757412334;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wgG1TLtqGBeWhctyBCBmqSrMcDiTygHV1aSWWvhvhgk=;
 b=ZZOrnMS36BQ0v7+s1WuiXrJsFN7bcXoRsF8uACriferhP36Cxd8+78KRBktlM2OI6P
 Kkb1Lbza1J8wJaT7kCMX/M4tZPbf2Uh5D4i8//Z4k1xf3vVwdLZQ4PZ2PyRmZWYFWgy1
 NqjbLS6JDeM+a0t5LaCU2iRj9ejhVfGc+gVDIK4j5TS06/HgPk6fwqZlQcnDUhLcfUL/
 +kNs0T0YHNnCHuNQCVj2DYvdIWSo/X3075GRcDGD7hyl73xfNuc/bH34WLMNY/t9+Yju
 XQW8f2DHDiGam9XsAU4LH4WGiOkf6kb93Ctr5LvyM6WwoTRAsZZhEmzcPUh/DQ6HMFLF
 mQbw==
X-Gm-Message-State: AOJu0Ywnn3ojD0ilX2wzfzAkaaAKsVHz+AE3bUSJMTKmzOeyM1os8s+i
 terL3boWgC+iekuUcroKPMbShBVuy7dVEHwetn8y1Kf4uwwpZGqd1yf7FEAvCYbQUuLHKl6YhY+
 IAC7PN5E=
X-Gm-Gg: ASbGncunwjlScneEmNn6rxTks2R5qXtXGDlHGZW+sJ6qV3kuRmPdFeXEM1jyAoEumbd
 HCTEPH03EfVGeKuCh6Wq5vF6gDEhUW/WrektXBZG9JAkyQuidydLm3E8bgfS+Kxr5r4J5JH9w9Q
 h0JA0+Bxv8EQR4ZihQW5RnMYjym/6tRFK8wX4ZL58uqu43sfIpttNIeKGs4RhBCEm87Mlz3yKPr
 UAbEqAGnPNRA9dIjb4u5v0nUM4J6dNvoFUnlfMZVXISTMEcJueIlHN9wyYQGlQL5q2gH+iq6L6C
 /QmjQ436fxivAfAFg/KXWaz/bge55+GDDXUvClt3ModhAZ1gl/t0L9vFz+/LO1UhaLTUY0Q/LeO
 /m3phjz2c37ukP/9lvy+AjjOBbS/d2d+fsG4MS2iV/tHaWOYc9AmpL1HyL67e70I7pooKKNWMwO
 AEI/tHnQ==
X-Google-Smtp-Source: AGHT+IF9EokZgn3AjGVJRrHSUMg8CVEBD1TqXFs75nTmb13ucjKcrTp+PlFGBtdjjE8ZlXYOn/E+UA==
X-Received: by 2002:a05:600c:4f4a:b0:45b:8a0e:cdbf with SMTP id
 5b1f17b1804b1-45b8a0ece70mr70475885e9.1.1756807534520; 
 Tue, 02 Sep 2025 03:05:34 -0700 (PDT)
Received: from [10.20.0.233] (151-0-205-164.ip282.fastwebnet.it.
 [151.0.205.164]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c93sm275798865e9.14.2025.09.02.03.05.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:05:34 -0700 (PDT)
Message-ID: <a246bc5d-1c99-4546-83da-eef4f94a4965@linaro.org>
Date: Tue, 2 Sep 2025 12:05:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/14] loongarch queue
To: qemu-devel@nongnu.org
References: <20250829025507.2315073-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829025507.2315073-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

On 8/29/25 12:54, Bibo Mao wrote:
> The following changes since commit ca18b336e12c8433177a3cd639c5bf757952adaa:
> 
>    Merge tag 'pull-lu-20250828' ofhttps://gitlab.com/rth7680/qemu into staging (2025-08-28 09:24:36 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20250829
> 
> for you to fetch changes up to cc78259deb21940521a227619eb00a4b8e3e36c2:
> 
>    target/loongarch: Use correct address when flush tlb (2025-08-29 10:05:02 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20250829 queue


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

