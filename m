Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25D2CD343F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwVn-0006xW-BF; Thu, 21 May 2026 02:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwVl-0006xK-Ji
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:04:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwVk-0006bG-70
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:04:01 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso45812515e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 23:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779343438; x=1779948238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s2EiLcOpgYHYSNYrc1InP2OXkjOAqULQEqJ/DRkoHPw=;
 b=dKD5QRPzHfeLvKjERSPOU4EI0/L6sooQfoG2WZW6LSA5ZLBWfO439IAaPPkpRPhXSd
 Mw7EpcklRz3PYnAnaK77ok5HyO6FFrGhOpMYdEQfTADJjesfRlA5U83jyE7oung6umbi
 jLQUkeLBGAcu+Ac/06fgtID8yrM7nfI1CAqwGz0jtsYW90xzY6cFledHLKatMPldNtqX
 aop8nGvLOwHxx3sEVKQM/CcGc8E8dsr8/whb4Jw9FAtz22WD+CIw5OAtOuU5zxm0yFqC
 IInbLMTEsbEwe1nnNiaEEDDaRNOw0+7paBRlEVF63df8v2L8rBKW49bchDGbs/Gxhqco
 pc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779343438; x=1779948238;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s2EiLcOpgYHYSNYrc1InP2OXkjOAqULQEqJ/DRkoHPw=;
 b=fVap85bTvvwypGoUIDth1Z4vhIRYe9ckCU3UcVAPVKTasqtY4C2wNALoufT5S2K/A9
 aPO7WBhi/9Xd1P9I+GMYN1EP6S5DKnYJZ5Aen76dMY+jSx7Humb2I/xtqzYl++SbeXv7
 63JFejXObeJmP7ytUwGA+V4gVIn+Fy+XSZCwHU/aXzKWXYMVUDP3PlR5DEH+RIDtXWiS
 iEE3NognhFcEDArbDLp+P/Ewgp41+o0yN9lEE8D39qN/xUc/PSiNUoQBk1Do8n6lkMmV
 ddsaTL4xEUOOj+VtUyGIv5wbcaFJGa75ylnlgYcWv76N5pQQ95t68FeVvO0cSH3F4e8m
 7SyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1nvh++BVoIQ2sbSTkwV9g+xl9PppNl8TCzl4NU6SevZ060/5igE+i2QLbA4ZEbkAY2kczq9V6u7nT@nongnu.org
X-Gm-Message-State: AOJu0YzpHoEBtueLDoI0varBdyJVeZuxTnBvktWx4TCC/jgB1/zXFjD5
 NWklOX7VGJXOWJUKlbmc6wrOILXEaWbJ6uY7+8/TcYlMPyzpIXTbt73ApVd0GqyawzY=
X-Gm-Gg: Acq92OFwZx/vUA17oxRoH36N3LexZxM+ccgvUGsZW9t3xtwJLMd8bueDLQWCYVPbuG2
 4Tpl71Tu8fcviQGU91YAcjwGMXhbe4NkstMsD0QDzVwkzvSMcEZQ1tr7n89FLkhJnAsrmhx9McK
 v28BWbYai8LeaQ2E0MYi0l3PYjTDCcmOuS3l2ByZBdBBf7tpCEb3EDk6SnDv04o3VZ4laQ+Lmc5
 xgcd/2kt1B2+BKNYBSeRV7mDS14jxWS7k5aRZm6FTB75eR2NR/r5pbHJvrifXUtIZ5vUi+GznUH
 JC11TUVpMz6U6QplgDwjJB2sM2plsVIx8GGvpT3sOTrdN9NdJq2adzHye0VDzfvhFRq4HlSHlNN
 Rf/XnKYgHAiA8lHikG8EMVb4HfKYJQnDYXCDTksBwabI2VrCAQqZZRWUDpmjdl1/gOyJBxCIcsD
 I1EgLcZO9LklZ+gyr/L3V37m0QrM23NrOfHIgldNqVAUeafKLBzrwuiJpnUQ3B3xavdw==
X-Received: by 2002:a05:600c:e40b:b0:48f:f199:4c02 with SMTP id
 5b1f17b1804b1-4903605a63emr15640505e9.9.1779343438388; 
 Wed, 20 May 2026 23:03:58 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903cadc125sm380285e9.10.2026.05.20.23.03.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 23:03:57 -0700 (PDT)
Message-ID: <c55478ae-c47e-4c15-a44e-a75b9d5d87e1@linaro.org>
Date: Thu, 21 May 2026 08:03:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/40] tests/qtest/cdrom-test: replace HMP "info block"
 with QMP query-block
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
 <20260521-qemu-no-hmp-v1-27-d104f809e145@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521-qemu-no-hmp-v1-27-d104f809e145@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 20/5/26 23:49, Marc-André Lureau wrote:
> The test_cdrom_param() function uses qtest_hmp() to run "info block",
> which depends on the human-monitor-command QMP endpoint. Replace it
> with the QMP query-block command so the test works when HMP is
> disabled (-Dhmp=disabled).
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/qtest/cdrom-test.c | 29 ++++++++++++++++++++++++-----
>   1 file changed, 24 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

