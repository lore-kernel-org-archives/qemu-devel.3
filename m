Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA848C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Kah-0006oQ-HY; Tue, 22 Apr 2025 16:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7Kaf-0006nu-N6
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:51:37 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7Kae-0006q4-2I
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:51:37 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22401f4d35aso62957025ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 13:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745355094; x=1745959894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CHZw91TE/aryGvNoQqdwN4EocOVRs5Q4cBhAJohcibA=;
 b=iigxpIa/w9dbjDQDToxbBRZS/ptDVUKl0JNYueZFm4LiX66CaMGHf6/pEKwhvF+5oF
 3MB9h+ahVXL0TyRZj3EcdE+ylhb7g8ro8+hCz3J6nZ/4HYBawWaI03zmRSRGBaQQxvJb
 wJAS8QPt33Bem6/Jn8dAyk4/+uQP+m2ria+BFLVohyNJMZ88DEYmfdj+RkUprNkz0ftA
 EIdtkqv+G33s9UHnluOaYd8Xw40lpliIsVKIQ2aYccvpYiW/AhjmwCehS1mPlBILX7yZ
 QylTsAV6Qi52vLEYdXIc9UpdwCUQiLoGcq7NjgZziUK5q5v+s0guQtIN0hjwTiH+Rkmf
 EH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745355094; x=1745959894;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CHZw91TE/aryGvNoQqdwN4EocOVRs5Q4cBhAJohcibA=;
 b=JWXjReLTe26Ef/lCSIXtX+dJzD3s5c32m7Mk8HY73/HaNWwUn3Rs/AqtCJnQ33WtDe
 g87hrmKgKXq4+M5ZSDV0mPKLfqWULdP0Ev3vXub8kTsC1z7Tzx2laGOM6ifwjD6ooYPX
 koFLDFInbwNZdT5k+H6LqOeVlE1nBERtnEMYuUj+u9kydcppcpkKxzlrwGLUZVKctylF
 9ZJIN0po5yTO9qzp+pfVdN7R0/A1bTXp7JCClPH1ziRGGXqA7a55GegBUEnMPQ4VUow0
 QpfeSDOcM39Qr9RZVfNMvpIQuAsAXeTVPY6BJuf4aJ9jTDcmRGegvl1ddYeUMe3Vf5JX
 lJKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5bbBCxid+otg8rj0pfmx8OtvytMlxyw8Lo44AUBS9cCWbIS6Hc3b4HVFaERUqWacU/cqz7XsKk3az@nongnu.org
X-Gm-Message-State: AOJu0Yz8+ktjfn6HeyM5BShfuy3uQv/ekCBtM43r5qWWPQTYFRjetdAT
 CPLjZ5t9B02ETPQTLY53JBLB4Br+NyG5MgoZf3XmJpFJEI7TR0zEe2HMic6s8pcpI85l1ZBLO7x
 w
X-Gm-Gg: ASbGncubfC0zA3/DYlnRaI84z7AgNYziRuXi6JMhACPBDSodRzGO/5lzYVbGew+PwYp
 WR3Zh3eeAjERL8nFAjdXw1IcDVJMhxz6g6X6wZXPgQo+SbSNhGsmRhVIaJP8xuvuMZCGkFG16ie
 +vYaxgKePXbizkuVeXz6HURzLfTih6tO2GRYhOFl/UYXTiXA9CxvzvaI8DOi9pIt2kuTdv2/kCn
 epAlV4hLWGBD26DO6Y9zS//EUGa48yHqizlIg/W2IKnTmu1Ttl8dk5U4S2JKtbN98QjWE2eS/NC
 R0t0N+r0LcRc5LT1kVGIGKN97GYZ/9HGCpCkAY7MuOhNXKtwBq81Kas0u3HJHlJQ
X-Google-Smtp-Source: AGHT+IGTB6bmudDLU0w9x+Ef9lp3JI0LOYKX4LQaSKe+qw9QZGQIO5X+NlG0wzwVEwHNpioyCEVg2A==
X-Received: by 2002:a17:902:ce84:b0:220:c63b:d93c with SMTP id
 d9443c01a7336-22c53620dcdmr244895135ad.44.1745355094189; 
 Tue, 22 Apr 2025 13:51:34 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed0f7asm89947765ad.169.2025.04.22.13.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 13:51:33 -0700 (PDT)
Message-ID: <13d93fb6-93f1-4739-a17d-a0d80b197efe@linaro.org>
Date: Tue, 22 Apr 2025 13:51:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 064/147] accel/tcg: Pass CPUTLBEntryFull to
 tlb_reset_dirty_range_locked
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-65-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422192819.302784-65-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/22/25 12:26, Richard Henderson wrote:
> While we're renaming things, don't modify addr; save it for
> reuse in the qatomic_set.  Compute the host address into a
> new local variable.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


