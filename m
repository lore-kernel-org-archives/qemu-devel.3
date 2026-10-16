Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A9FCC6B2D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHazY-00089v-Jx; Fri, 16 Oct 2026 02:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHaz4-0007qu-D9
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 02:00:07 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHayz-0003Pc-Ip
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 02:00:00 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso52093f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 22:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792130391; x=1792735191; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/xx0u/qg4uIciq5cNOSvHtJS+zKUEkXvgSlaTPyhS3c=;
 b=oDDCFE23tetmSapAsUsNBNHV4Yxqz1+ajz4CBdDFzpQddC2whByAk08NhXsULttEUR
 YMucpIU5q1glNIzFt9umizbUGK/LhQV3I+hjaCwlKQhvcOuiR61Q2N9gmyigNECURVIl
 85/Vg7dDuK1d+z9dRtbs6gVgc4PSe3J/OHcdYZD25+CXfAqOuXd0XDVFrWQfSVqIrjUp
 umFrvZjpFd1fye30i16cTGiWIWd79LxtBy5/xR+ZbVXc2LDOXzgGdb036Yg1+3uFqfYC
 9YEeJSGvYqWPK7MgezHs5pmAEO17WLJYSHyMaiOoEVMJa/g5vNzzlNWkR9uGxaR5bBcA
 +LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792130391; x=1792735191;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/xx0u/qg4uIciq5cNOSvHtJS+zKUEkXvgSlaTPyhS3c=;
 b=WnHTmP+SVPKiIvFIzbBT52O4C/xOZlZRP6WJ+qdkMKBibo/ukFIZnZKDOhUDvLOhF5
 yIvSRbYmjSzW/Qkw+vGda2caaaXA9tHg81QQ4KE6wfLOaGHO3SO93Je0uQChOpTBCiZw
 zy2BIsyK4gR51T6dhMk6tZeJiNBu4vNVpE0X4FYnC3lub+KdFvq3QmNhiMrmhXTPqn07
 SQwnGZEq6/iyuPMKyfPnHPIqzlxmA+3Ax3hLjOmE2xKenEQNWCHoGs6KHI+7+Fp/OBNV
 Y251g3eHkXWSFcfPKQ0NDbBrdfNt9A1ksR22LTYmy38KbN/lH3hXcvmCIagb+sfEpNFn
 o1pg==
X-Forwarded-Encrypted: i=1;
 AKwUvByO8VKt6jOZGysaIy9kw9J/sq4Pz/t0GUMIypYIVtGlMjbl68+elvcdvLIQulJsn0W4e9eOU5NJwzT8@nongnu.org
X-Gm-Message-State: AFq9FYJB/BzKoodDwexNwkYqc6rIk/LcHyPiUunuDU1sfhXxG0GC2V6O
 D8CZwifJGGAbMUcA0yAjZqCYL4dtvitWJQt8RYMolwTpL48IWnt9J08ObwnzrIIEMck=
X-Gm-Gg: AYBFou05kOBGNJ9iugi7ErzjZRRO2ZsRlUF9/tnhhv/6Bk4ikDQBzfwa0nPIh688i1y
 m75XDaLEl9n7TxEFDevEqlrkeL96Bp38/oAeEAXaz3nmHlXpoXmCIQcWALDTwVHhaiSdHUiaz9C
 iIkDtoCFgula9VMeKoF+CSU6IOtdBRwosaDG88gpICohU0DfFsLWv+H4zd+dx4GeVhcJ7VfzPK1
 Oj/POEE73YlcS5eU3dMdQAKOp+YRkTfQ6bDXehUpGkbAvk/RbS0Hsws8WaOUI/xQx1Kpt6GjgfB
 3FwDt6eLLTp7tKq86iFLkD6Wk99sCz9vFZTWh5eEVKZenlhe7XFEeeT+X4riTIJGyuTEXedkwpU
 1YZSZ9jVg7T5Nks0uWYIaJ8T7uBZ79CYexpnWeeSuqFtPqGdiBOfrDTbdRauVLbOJKEcSx0Hu8b
 kOPB6l6ra0Kd5gvVIVpmkOBUmPScVyLq/ustqjZMVafQtTGPcN9JQqWy57fZ9vf6FdTccZmcEV9
 QKhFC8Qkr4GuK2kv37glBrPNo9RUfscTp0hjEusNOky/SURvqAslLULyQ==
X-Received: by 2002:a05:6000:4313:b0:48c:77e3:6c8e with SMTP id
 ffacd0b85a97d-48dbacf4700mr43675549f8f.49.1792130390502; 
 Thu, 15 Oct 2026 22:59:50 -0700 (PDT)
Received: from [10.233.235.227] (p54a4c6f0.dip0.t-ipconnect.de.
 [84.164.198.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4f8bd9sm2763851f8f.35.2026.10.15.22.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 22:59:50 -0700 (PDT)
Message-ID: <10309943-c1ea-4201-987b-d43dc43aef38@linaro.org>
Date: Fri, 16 Oct 2026 07:59:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 01/16] tcg/optimize: Do not derive s_mask from rotated
 s_mask
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Dominic P <gcc@gcc.dp11.uk>, qemu-stable@nongnu.org
References: <20261015105212.356392-1-richard.henderson@linaro.org>
 <20261015105212.356392-2-richard.henderson@linaro.org>
 <d264e29e-a687-4a45-9e2d-5bd9e6f013d5@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <d264e29e-a687-4a45-9e2d-5bd9e6f013d5@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

On 10/16/26 06:53, Michael Tokarev wrote:
> Please take a (quick?) look at the two commits at
> https://gitlab.com/mjt0k/qemu/-/ 
> commits/71ceb9311bf43afa6da0f46677755d29e4646fb5
> which are this commit d228536a5142cd and the test, - whenever everything
> looks correct for 10.0.x
Looks good.

r~

