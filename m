Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A237DCC6B24
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGt2K-00048n-GG; Wed, 14 Oct 2026 03:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGt2H-00048W-PE
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 03:04:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGt2F-0002N6-GB
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 03:04:25 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so32010865e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791961461; x=1792566261; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+EuWBj/8ZG7W4ukkHsOyOYlj8zVAWCnrngmXJ4uXQCA=;
 b=XlM5YTp+hENVmmII/f6Io50yuLFllnEGX5wudKi5zV5xJqqxzXNfro6jSXLaanovfT
 FYanDYD2I2dN+BtDb7Ejz++LvMc044eubVz1mr5zK9XXs5G4C09lHhNfglK5BcECG/Nr
 6+89HyfFbk6+1N4vmTiaCio3p9CNejvgEA7rNRfXdz6AlqDzUo2mereMrIxrZXzVaufX
 OyrTLqL2HHsV1JpdqDJ0rjVol5pe2kpNtWXkqX7kTwAmZwtZTGENSnbChrGzPjTAAgN1
 XUseHdOc8efgfyH28OgmZxRGgREs64OcoeRsV+GYVMZeivgaMX3JcKs9EGdkujiB7njc
 kV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791961461; x=1792566261;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+EuWBj/8ZG7W4ukkHsOyOYlj8zVAWCnrngmXJ4uXQCA=;
 b=y/zbjhvZmJPHw1INMGzPWeyRz3ztVfZCUtt8J2GsV4OS3BKkRZuPViUbYTO/VLi5Tj
 miOAIb8NuTsbxGy/eXQVmeF/BbXWYI+MPe+DnLL7ed9k7N6LyHnlPJa8EOaAc78aPJHg
 dJKYOfF0PSCMzkAXnkZEiaKleXLj4kpPfsDScfNXcxsaI4787dLZdLGl4c4gmSAJUOGg
 gb/x7wt0iOssk1gJOfHVhdzk21dB+T0nPt4PFM5RcYu/I6M278I8JGzMixkTz/rymk8j
 Z1lnV/JVPu2WEwF3510cs0PI+xTVVic3mj3tecChEm+GZVwIQkY58IE+HXB8D1bA7hCG
 kPPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0qFVrBePHR2z6ymrVa4YQgTPF8RJ4MgwVxsSZ8q/39I1u+866PneP5WXmFfT1OnHsstv4JFiHCPC3@nongnu.org
X-Gm-Message-State: AFq9FYK8SB7uPpfwcOmK0cUkvQBAKQ5tshXdt1e0SlEtS9mtfryvLV/z
 /NIJqWgzrG+RYCcUdx5oopMhv/mKSuvgtRr6q2c7Homal7BtLQnbqGaJRqPjPh2xNLA=
X-Gm-Gg: AYBFou3fAh1nuPFd07Ke7Ep1fb72zccz67Tq9YDBSKya3rhAiuffu+NXnx/gMDwG5t0
 SkJPFq5l3xoOuSO4Sg2jCJTUhYJ8BHGSM23VUkWQkmLho/50pA/ne6XC5Wxmf8l4Hgks621GaO8
 AvGJ7F1QPIEcYCyOiQ9DFKqYstN2xxv3mqGzarKG/utGb9KplLubvWwsiljHLogqVfZ4CAL1fIb
 cvxiLn0YTi0zL6AplPP3dFtXc8ypxoHCHyTULTE9RCheVusGN0kbps1ghlN105gISDpP/fkyq9I
 eYBNiFqSXkfy4SOsdp1DOfevubrBa9a1iyh5ou0HWXGFcqsfXQQEhP4U3NaMGFPchQVPeMTXQNO
 6ZO+qEe2JEkUatnBcAAzY9OUiR1aDz26uCD881uHeMfN+5TsItRdQV9UwGYncH9JAHEJRVyg5wz
 ftzeY+bti3Eg3EP1YHy6BXTrG5cNuZ2SZZIskW56qkfRz311+OADuIdlCtjQYazfcX9yUqEWq5l
 RYlY8q8bDihHKhbA20UYoyGQ9BYANLrxP8STPF4f8LBRINVbSX6dzgbQZ/jD44wxA==
X-Received: by 2002:a05:600c:4e01:b0:49f:ce78:3567 with SMTP id
 5b1f17b1804b1-4a18e4afc3amr283607065e9.24.1791961461243; 
 Wed, 14 Oct 2026 00:04:21 -0700 (PDT)
Received: from [10.86.151.227] (ip-109-091-152-129.um37.pools.vodafone-ip.de.
 [109.91.152.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b2ec47fcsm35401775e9.1.2026.10.14.00.04.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 00:04:18 -0700 (PDT)
Message-ID: <9cde369c-ae43-46c0-a1ad-1ec8bde06a66@linaro.org>
Date: Wed, 14 Oct 2026 09:04:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] Multi target update 20261009
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261009222459.32364-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261009222459.32364-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

On 10/10/26 00:24, Pierrick Bouvier wrote:
> The following changes since commit 615ece3c406b262996e569f29ea6eed0d81c4d8d:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2026-10-09 15:49:53 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/multi_target-20261009
> 
> for you to fetch changes up to 602f2e66e80f95af4c5f4ea7393fa5f858d9e1aa:
> 
>    target-info: rename target-info-impl.h to target-info-def.h (2026-10-09 22:23:33 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH 0/3] qom: pass TargetInfo to the is_available callback (Yonggang Luo<luoyonggang@gmail.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261007115253.328-1- 
> luoyonggang@gmail.com

Applied, thanks.

r~

