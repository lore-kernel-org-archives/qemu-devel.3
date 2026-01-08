Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED363CF6AB9
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 10:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdn4k-0000iX-Ci; Thu, 08 Jan 2026 05:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdn4i-0000iN-6G
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:17:04 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdn4g-00086o-61
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:17:03 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c05d66dbab2so1980808a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 02:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767867420; x=1768472220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZY6cxEFb8aCu7UwhZfhcweF6EdOVwnXfLNqzbz/utVs=;
 b=TFzGmZFOBCSuQfPQVMSRnKO3cEmsi/MHzzZFAI8nuVbo8g2OZnYlVkgMniMPO9yyny
 a7Fn277R0OleN7nsGzSe1en8BUdMbUsAjq7xlrdpLQxv6WCKODjR6noSoN77g+PrRVI2
 4vyzGKQa5O631DWH7JQ3+TbaryVICFm6nTSfBek7KqlinXghb7/HspWcphjW1JkLFxrK
 d+nwZzEuW7m/0/GIyqad3M7tgzhIEbZlYC6DW6gwuxJC6TpVmXrE0blqPToyELB4NBqA
 sA3go+QAgoy3aR0kx9A6UDQLV051hERHDWbMSfnxJP8cOhMbxokkAq4gQk0ugM5ymvUX
 MDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767867420; x=1768472220;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZY6cxEFb8aCu7UwhZfhcweF6EdOVwnXfLNqzbz/utVs=;
 b=wpnFsvC+AVJvoKiTNigMihMzS0Rzk+Kho3iLw0kMUjER067J61/rfdoKsE7bC2BjiA
 lpNMW862rWsvRWguRDyVyaLxZuOZbzC85o30tH2oucANuqYXyQSlgYW91aARTC8NWXFR
 /5DytLhZnbLJM0MjK3Ox9apVY32j3C6VQa3ckOETi11I2AfQzzXEodGDcxTgMtUwP2x1
 0UzwUIRmp3XQwbhkGJmaEd8AtXa8xBA/E+jI4Ebir4ewTN9tGGCAycJz0YRzZFSKKFEX
 bGSZFkj+vVJhmu1N9IbJri8rmyXtDSjU8Ibkd2Rvb/c+vjv+ONqSRNEzXlmrScsWFm2q
 xx4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxQuc8Mnm1bjeW/31yMpk+KlxMZdebjosERpDYTNzgUd0sQSpZ1M78K4eQsblBPXrymU6iV0KXpBTM@nongnu.org
X-Gm-Message-State: AOJu0YwMeHMs2kbXe1I4r8ZLpNTRHsPJGVAM6FFQ0nAFV+g3PB54f5PR
 WxKpEm5LM38jWu27sbEmwdRu1c66Ov3v7LRZ8ZSlLeJbOEyeikhbKfBex9jyb+Lgr40=
X-Gm-Gg: AY/fxX46r8Tl8IEnDuzm+DS/qyy8Vm9pd2Qa2jYyPqpxiA8CDxXqXk0Uo2OnUVfhQjn
 HqwcAinL18M0AEePpjwB5+UI5dQp11O7k4JelpFtcWpxBftuAZ6JNN7iZx+LS+wKg+N/XahbDLJ
 Xbu5BCJfOYs5npdUT9kX43G+DZp5MD4eQIH0G0Qj009KLNTjb2uQI61JpME+HO6hu1UOyJ6dZfu
 CiArrTzFfJHuCTzzg2q7SVctLj8sy0emMzJH+b1FU4shbqnyEAf4d1/1HWuHtD0S3Uf78eMEMxF
 y1Rw06+Wx/Ob2kYAzDXoz594h7CBCfVxeBZpGvr8KsScyMVUNsRgBr8l/dDonm6rt8KstcbHXMf
 kuk1MuZHXCPdT1boAEYG04a86aEXji+VJYdz6DyJWow6Rk/1I6OQMiT465NDfVhI47Mq/C1Ud8j
 +1SbcgH9hJbSXJKNatlOmqj5s57Bt4PA==
X-Google-Smtp-Source: AGHT+IEYKK8SRStMpwMN1l59vgog5Tz5qg7Vsk0YC2GNmNXj8QQPgL/6WNg/TwBySeR0K5SMtkcwuQ==
X-Received: by 2002:a05:6a20:6a29:b0:35d:8881:e6bb with SMTP id
 adf61e73a8af0-3898f905ceemr5685166637.22.1767867420156; 
 Thu, 08 Jan 2026 02:17:00 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf28faa9sm7582078a12.2.2026.01.08.02.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 02:16:59 -0800 (PST)
Message-ID: <463d2b16-55ca-4009-ad25-c5037e1f5942@linaro.org>
Date: Thu, 8 Jan 2026 21:16:55 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] Monitor patches for 2026-01-07
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20260107161256.1321694-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107161256.1321694-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 1/8/26 03:12, Markus Armbruster wrote:
> The following changes since commit 0fc482b73d8e085d1375b4e17b0647fd2e6fe8f0:
> 
>    Merge tag 'pull-aspeed-20260105' ofhttps://github.com/legoater/qemu into staging (2026-01-06 06:52:47 +1100)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-monitor-2026-01-07
> 
> for you to fetch changes up to e714f1a3d4d1e66b9a3ff4be1ff999c32bbef29e:
> 
>    monitor/qmp: cleanup SocketChardev listener sources early to avoid fd handling race (2026-01-07 17:05:25 +0100)
> 
> ----------------------------------------------------------------
> Monitor patches for 2026-01-07


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

