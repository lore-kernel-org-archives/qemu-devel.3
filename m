Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C11C9830C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 00:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhdah-0003zs-QS; Sun, 18 Jan 2026 19:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdab-0003uu-E2
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:57:53 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdaa-0000Fp-0a
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:57:53 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-81f42a49437so1838826b3a.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 16:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768784270; x=1769389070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O4s3YLTHb/kxqUnJNzYFRXRo2duLyt5oLaWP5uC6Odk=;
 b=BKoGJ7Yt+OYLblskWjeYj/pFC5palqb4Ooy2THKquvDQVVy4vL3SBWrLoAp1hBvSdi
 sHMdrFrx1UAnc4YyE0v3sZzh1N7wsVY32lQ+7xg9JzhgOjuJq13FlmfS4hwNloXpo0Bw
 2juIUwUxGCEjsnKVe4USohev4qTDxQAXpornPGGmai4ZvZdPIFi7uM2iDcE2MXFB3iH+
 59laeW8rOW6MZ8KEMihvyfvkNDHqpxjh9r9/O3mxTw5O6MpiBp8Pdbvic8csBtrtP03w
 KcmAl3SVfmFgYzTclBtBFbv6ZqcFjveDk/nMH39neNssNbHeB8f4SbVdWiWULDggjMBf
 Bqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768784270; x=1769389070;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O4s3YLTHb/kxqUnJNzYFRXRo2duLyt5oLaWP5uC6Odk=;
 b=ZiT81uRAlHl/yX5n/lNE/O+TnrKojr+qwisUXcxjf0mPOKXdnB+cyH0W1F4NHRcrhB
 uTu8fZDhm276ztzgrP0TkDQHBoVFDvfHXD6UIGHhTXoa5SNeuAsZmDlKrqCp73pvRvZL
 Qe2X6EMJpXIyfrtHkiAatOY0Ba11teg91kTiWRXwW25os2gUGouDIfISOTj+966kzW/y
 YtpQFcEKTN1mm/Xk7xVYNi5nxzBMIONT13IVHOF34vlQf7XjLeGYu7xLJbPJCs+X0FXB
 OyhwGA74XbWxhuyn75OwRshbUWMGjLMS2Nc7MYE33mhtmZc5oDsy+8TAW+F1KVOfRM5/
 g8Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe/krExRBdS0w4KnY38MNF6PxQYpYLZaWRY1uYrCkWNS+TBTVk8sAjxQGHykGVkmncydmsH4M1G3qk@nongnu.org
X-Gm-Message-State: AOJu0Yz/CdV6g7d9t4r3P8GsNKYcvAL6Dxf2/+nIXZtC4Tye+WCAEG1N
 xUWXClQjpRA5mYKD0MpvMQ83cb0wdjldRClSaqYL+GR+Q5pG0AcDbXdDZF1XmXaIQ94=
X-Gm-Gg: AY/fxX5a2dmsAQng6vRqHAd1dvnYLE6F4pDiSAGBKCEBOEP+y7/jHDHjwgWcoxAcG1+
 SaEWUUn+xEogZAX3ifYAbna9AaOs25wNTduifeAa42p5pfxJeQ2Pgm96WJoCjxNIo2Qi8eF6BOp
 LYpwt1K1u1FsecNho3j3/xhBxZUa+bJkALkqbHKnYgNjKSI5fYaNA2cwBXCNsaRbaDDkWEDNHw3
 YasjueFN09H/es0UXF8ekF+3/nFIeEI7gr48k3JOquDqff8aLWEshFS8Zv+gHxqi8ZjNm47zSIi
 KzoLvSWbXb6CpbnqLoE8kNv0TCmCLHHZCPvV2bgfiEpK7N4vCOLud1EYQF020wxr/wK4pebuNNc
 1HcDxkX8/7REs7hx46hKsqhx9g66U54xQYPfSINJdgoz+BxR+mOPmLcs0GraA5XxQjwZt5ZNfOF
 C+WAKxg1aXMe7FJxzacnKHDR58TjIvc9DdA6MfxLid
X-Received: by 2002:a05:6a21:a4c9:b0:36c:2cf5:9b06 with SMTP id
 adf61e73a8af0-38dfe7fb23bmr9697195637.79.1768784270257; 
 Sun, 18 Jan 2026 16:57:50 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf354b3bsm754208a12.24.2026.01.18.16.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 16:57:49 -0800 (PST)
Message-ID: <bb8abc92-0f2c-4916-a4d0-b112b5aefccc@linaro.org>
Date: Mon, 19 Jan 2026 11:57:45 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/i386/tcg: merge decode_modrm and
 decode_modrm_address split
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260115113306.126905-1-pbonzini@redhat.com>
 <20260115113306.126905-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260115113306.126905-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/15/26 22:33, Paolo Bonzini wrote:
> Unlike the older code in translate.c, mod=11b*is* filtered out earlier
> by decode_modrm, and it would have returned bogus code.  Since the register
> case is so simple, just inline decode_modrm_address into its caller instead
> of removing the "if".
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 64 ++++++++++++--------------------
>   1 file changed, 24 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

