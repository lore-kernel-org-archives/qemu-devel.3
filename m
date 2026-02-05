Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C920ECD997
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo6Ee-0007uk-By; Thu, 05 Feb 2026 15:45:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo6Ec-0007uc-R2
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:45:54 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo6Eb-00036s-DP
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:45:54 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so13223835e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 12:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770324351; x=1770929151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cV0ZQ4GE3Zhr92VTpVWmfpXw8v1EwQHVilw8p0xygmI=;
 b=hOw1OTlOHWJv58M8UDHESJwp2+eYvvZ9cLD8G2hApAOVqpLPcE6g1TuJNI7K9UMS4g
 2tticIX4H/hUsFi69k5UV9/IDsK4MWSVpTdufQIeOO//qxDo2CI74HhvsKsO4DVNGnaG
 EW7N2afK3tIxLgHGyhWHmCMZCm49y34bdPkRmby6qV7UoNSKp8oBq3oLuWXYSktWF5L4
 /X5cSpCNCoKRlV0rg2Vyr1YVMcmNdkxILMgGuTUt+et379UGAF2yfTO86otccBykBIFV
 4fbXnokpAnyHUvh+5rIM8wW4EE/BWZIx57q7I3DZSr2Ko4qd1LW9EcUUR2hPjvSSHDWu
 RDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770324351; x=1770929151;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cV0ZQ4GE3Zhr92VTpVWmfpXw8v1EwQHVilw8p0xygmI=;
 b=ExySZ7Dg7zNy+7cVnr5zmq9nDi1SN2ZCqATKCjl8FidWgRUZWWvVDBNYamJq03NTpK
 6EhEKM5pM7tELFF8y26NOUmn3bc4cRo/JXwq1bPEP5vsgKzPl1wo3KMABUV5UM7p/VyQ
 SpoAoTlnpnU5m0Ur4zamaV/15/NEUdedfzGEbaLXYCrVMiXPbPVbtsgvKCHL+2jbC5yp
 DoRY6trXYQiqHO4qexhOVIBSFFysx3UnQzfwGF5uK4PqpUCjOxwe3cFAOjYSxYnHvcd6
 mbOxbltK+Fz/bnOV27FDi36Nxepgule7sOnYwVt3/aQDf4IwuhlocT3MwIl1+XJsgvxu
 HjaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtpj0mcvuRzvkVZ1nlnJqNhX6Es9QsV17ONA3UfhMnlIDCQgbiH57TaX0orDCO3Pw7ozoXWTWDKl/l@nongnu.org
X-Gm-Message-State: AOJu0YzVWFEOFOMlR7sa1eSdyFNqX53pGTNycYgLKHlDuDpxOMcXGPpN
 k+gD5/nVJ9yDzv3GMJs9vn8F1L4H4LqWH02TFOpnONp4N7CSBYF3+jXCjEoTgUK4hzJbE174rzN
 Jq0hXWKk=
X-Gm-Gg: AZuq6aLqAazz/vTck+FXQcsHY8mi7yoq25+3RRmGUVbrdeXxNISQachP/H/NBVlhLeg
 OTkiRy9h03cv3fpMS2ZbCq87a5YZNB2PHjDb9SU3OzEyuxTbYXgKlsgd5dAJ54lHmsBoFVaAqSE
 zB3aux6uYtZu77Ran8bNXL78Oz9Bp7nuHDU6j8vW+UJ3aQ7HXXgGZt2C6V2Y65fjy2Ry424H3NH
 yILggFAnTBlVNVrTXiTx20Cd6lf7ijTUrg0g6wOq/c0YB0VtBnRBquLlg6zX4cgaUF/g98I6MsD
 HOpcBCLMOR97m7g1Z+IFHCMCCigUUhqe/2y18mMEJnhpem/cAmJRirx4TMxtJrEwvrHoWGhkSZN
 YUeb0EvXo/EjQI6EwdJlxSFkAYs8M/6vRd5WFLkzYNrjiV5UHNanm9reajEY/BOdp/I9UEz43xz
 BmWdSSUOoZPL6uboZMnvp6I5trEAzqvMcYkL8l/mmP4rEVBbeH5yEiwQ==
X-Received: by 2002:a05:600c:6214:b0:483:887:59b0 with SMTP id
 5b1f17b1804b1-4832022ff38mr10730505e9.35.1770324351226; 
 Thu, 05 Feb 2026 12:45:51 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d7a924sm121242895e9.10.2026.02.05.12.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 12:45:50 -0800 (PST)
Message-ID: <69bfb7cc-10e6-4ade-8302-5926c7fa1a06@linaro.org>
Date: Thu, 5 Feb 2026 21:45:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] target-info: Statically initialize target_arch
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260205030617.266625-1-richard.henderson@linaro.org>
 <20260205030617.266625-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260205030617.266625-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 5/2/26 04:06, Richard Henderson wrote:
> Use TARGET_ARCH and token pasting to initialize
> target_arch from SYS_EMU_TARGET_*.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target-info-stub.c | 2 +-
>   target-info.c      | 8 +-------
>   2 files changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

