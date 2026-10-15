Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED59CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJNB-0007db-GG; Thu, 15 Oct 2026 07:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJN2-0007bO-Mt
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:11:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJMz-0002iY-SB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:11:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so17512165e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 04:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792062692; x=1792667492; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=d9QUqoAU+zt9lhQIUhf6BXEXYx2xY8OABVWyGpock4o=;
 b=rM1Nr0oSQgZUBkgoACtND4lOu+DA2kkwBW/wbLmWOz13N7C+PLbnoNuv9i5T7klVar
 V07mYcPeK4xq9ZkdaA1QCNmUm6bdDtU0Rjy1vZDDmpmpyrXYGogSuf0pRyifJ2ld4ayn
 QA8VMjXnHH9a/WCe1nzcgolwBHiuAJOmTZZGRNIAdbmEXxgZL9wFbYSfBnWMzK7w0ddY
 bjXqi8H3jLMuridBbSEFLcGiyniLDe/msJf+4RPPx/z+3fKiO+hE2FgJsI5ICwLFExub
 tPx3k2HJSv+9euaeUkw9lZiz1QOHct2J/8u6tIZhSwBmirf7JL1LfmGRTrzFEtX2mM4s
 n1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792062692; x=1792667492;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d9QUqoAU+zt9lhQIUhf6BXEXYx2xY8OABVWyGpock4o=;
 b=or6Ase+2gYb7m9UQcclTmMaSfAY8lbu5EGlZI1jgzH6arE960owXNi1ytAIVJgEKvy
 QKZHmrovoxk4oDkrmwrkivGTg0+OD/YVpfvEZbFqQmdo3ys5XYv9FDvu/dZB9cKiBfPx
 QiFKfbahTw2wH7fFL51yBXlh0NMacZAnNLx3CuYPenOJkpgIcm8Lhy8tlzuAIGlhQK2T
 BvkKU8iGjEGCQa37rHc5UIbZ4q36A/4I7R6fANjotfv/tKPIQmTsQ6RPNz+vbVO/FYPr
 IskcLtiCDNm/xzF3DoBYHtwWRBak7iqbQZZK5w+4HoQ36DX7+5H+2TmNHrlZmNqgdLgc
 /SVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBty5Glzo/4XoYIGe6rEh5YrcgzV1iQ3Dp0p11v1vTv1P1TcFJhH5AWOx8Eh1AtVPkWXtF99jkSgV/@nongnu.org
X-Gm-Message-State: AFq9FYJ15WGGN5X66u4R7xOYJ7Oke6f6/MczIGzRFsxE/L/G+PCvaM79
 qHYKYKDpyedIGCwbUFDbVog5pmvGttBmHCt7/yjkLKMzoawLdz9feWJeGx1k6qjKWDU=
X-Gm-Gg: AYBFou2hzhgaUZyiGjDMQw0hmkY4x3RMCtsXi/mkPwhb76S2hK50xLQimqbYYv5IRm5
 DQqjyOAiss8Zgr6ba71qfm4UJrw0zBNczPUkbSO78KjW7gzIYxmAQzTK7LHL4F0K7K4xjhksvTJ
 6rWhE2DGS2OApQcwXEDXL40zEOfPbh5cwKxWpCNsM1UAHJzz2zR+AGIm02Jye1QE+JNoT2s9+RL
 CA8h5feKL0f5VWJeugZCMrbtZ5X7d14Sj0cpJ+yxaBrVvqlbw1L1zRm1/Q7dEd+WSUk6b76QRcv
 JTIK741IjUGgKzmlArr3fww1BI4UqVVQN7Up3RNohFIlylJ6b/OuIN+BKusiFaK4R/lor/D6tgn
 53/3DlqCE31JCbGNiMoPAGJBa3hqt4D5rR8OT4NTEUd4pZ/qELXVGSDLHqBzgMKDky+vdjyB3tg
 tHxqFe0mJpK3fqPXL55OSHoJXyYiFXfwrjnxHOFnal73VtwAd9lU6XF7wWaq36x7uJpcakCtKgZ
 SI1QcVPgIJE70X9/oD2Qf0/OC5U4IgYyVdffhAQt7U9wsed2xWlI3ai8Ivqv/Ih/k01+/inxyl6
 qqFuFobJWtwhUqImgmJwcqsvDmmy/38FkHvXUlxgd1Y=
X-Received: by 2002:a05:600c:1546:b0:4a1:c0a8:6b15 with SMTP id
 5b1f17b1804b1-4a1c0a877c2mr36897565e9.8.1792062690580; 
 Thu, 15 Oct 2026 04:11:30 -0700 (PDT)
Received: from ?IPV6:2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860?
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd69b2a3sm1808965e9.4.2026.10.15.04.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 04:11:30 -0700 (PDT)
Message-ID: <249f4616-0345-4b6f-9566-9c1e5be60f8b@linaro.org>
Date: Thu, 15 Oct 2026 13:11:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
References: <20261014194950.1393771-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261014194950.1393771-1-stefanha@redhat.com>
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

On 10/14/26 21:49, Stefan Hajnoczi wrote:
> The following changes since commit 8ee6c77176cfee03be0ec7665b6652b2f31f1531:
> 
>    Merge tag 'pull-ufs-20261012' ofhttps://gitlab.com/jeuk20.kim/qemu into staging (2026-10-13 22:01:07 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/block-pull-request
> 
> for you to fetch changes up to f659157103de6f335d83d3770e383a52818399cb:
> 
>    dmg: avoid out-of-bounds memory load in dmg_read_mish_block() (2026-10-14 10:41:11 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> Contains a bug fix for the dmg block driver.

Applied, thanks.

r~

