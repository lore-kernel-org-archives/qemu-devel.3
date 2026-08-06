Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBA5C56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws1W8-0005kU-1o; Thu, 06 Aug 2026 13:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1Vz-0005js-AD
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:04:20 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1Vx-0005dy-Be
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:04:18 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8453427d3f4so2906024b3a.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786035856; x=1786640656; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YxKgEb1bXCsHClo/nYVNmSBaE33fM8z21HS5kcCHiu8=;
 b=G+x7lAgFmJu4UUgJg/3RtUYuXR3KPH07kBvwbzYDOwk7Ud8I7PoHVJ0d6BJa601z48
 gcbDne1HiogY6JCtmuumEEL7YhEgp22GWE848R0Xyk3jeGxCw/qYzHadKCBIm/kODNjN
 Kq1V4twyJKSA8ULKzD1Fehl53Dlf8cVvx4/0QzSOLIAfXp+3Y51NTX6qqjzFCVThUFZe
 tlOi6vV+4TRO/wcoXnd7VOCk28NyUHMlqz/fz9Fs2Aj8e+CT2zxYEzrrg+6sSfb353ZW
 QG/vtZ1TrQfhYVxjBbuU6sNhx+/B94PETBGKsqer/ab9hZ1ZmVrpdQ58XytKOG68OBoJ
 wLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786035856; x=1786640656;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YxKgEb1bXCsHClo/nYVNmSBaE33fM8z21HS5kcCHiu8=;
 b=GRP8kNQo75MuW7OwifYNyYI4DDi6qKxLigVx4/Ei2Gy9lrT+jlgncqSPhOY68DlHpV
 WofY1c7B30fUYDHfjWHrg5ymKrxKi7KbLKEqJ45BVyKfEJcAOy/tfL6Sb+PRauwJjXHI
 d4cjpgbf3UlK+l6687jhJJ8dtwKszxZqVnzGup47emz2YWrhvkLrAuhQALKa6CPAnDE9
 Hc+qndTJTeV5cNnOObRJ4IEGeTy5cPMZMHZepDscAOR10pNhUxbBNpcw/xQOlMVYVCLQ
 jpSOevpPTgJuuFQ8dV+iI8TgBBK8Tn+XG/ChFr2l1SBLW4GLg+C9U4ZaRa1+HLxQqEiM
 Nkyw==
X-Gm-Message-State: AOJu0YwxT2cvhXE9YwPBWcF7yMSDxm9JizDIJjOyLgrsDW8r+UFA3ZYM
 +oHxpSttKiVWk3hXmLZA7JlZUES7FTw5H6Dd+nX1bZYjA+QfaQhH/3BR+Z4fAkOXfG0K+2xBeiD
 4oC0x
X-Gm-Gg: AR+sD115fcNo9d8xVXoWtTrdnlxIXjAb+exKTpwUSxZv8QHlQ8lMhtZINbdnUdZnIfN
 TtBSz+SJYD06TYo/QMGaXREAvIgVHNI3fQEx7YODr2jZzv58afDdbFDpsSsrh6GFW98o/Y1Zcxi
 x7ID8fvpK6KCzPY17+iAiY81eVq67Fn+4La5VJmT9OLXkYvbrSmk4Fxlfa3VErcCVmnY2QosKy/
 AZeBWR0+d/6vN9nf7jOpQUVPzfxi9LyBmxmI921kW1eKeiu44kZ1UOpXqqp0m1Rl4faHEx8VIA+
 bY6WBnO3euunbb07ZlFEdDalQjgDBEWa5+OI/lZev8Q4OrTkpRNaCdcV26YOlD414+lr4zWd/Rk
 rwuT/aHOIU73b2GpP73d4Ezd6c/ppCpbz+LjUGC8GMelGdCji9XDxCM3E417BmCKmikwu7UC9DW
 Bh2s8cKrh+ErV46AWveTOv0lHHCb3mfZvsliwH970I/YocEsp7Zx8ZXHsozwo76roZMUL7hb9xT
 xDebdVSlLIzwSPSHN/GEAqCahp4
X-Received: by 2002:a05:6a00:929e:b0:84e:26b8:5a12 with SMTP id
 d2e1a72fcca58-84f2e0057c3mr17871483b3a.20.1786035855474; 
 Thu, 06 Aug 2026 10:04:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f456b785dsm1753004b3a.36.2026.08.06.10.04.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 10:04:14 -0700 (PDT)
Message-ID: <2a8f28b5-302d-48a4-a22f-3ada0f3ef879@linaro.org>
Date: Thu, 6 Aug 2026 10:04:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] target/arm: Separate cpu types max-v8 and max-v9
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260806163939.328201-1-richard.henderson@linaro.org>
 <20260806163939.328201-8-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260806163939.328201-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 8/6/26 09:39, Richard Henderson wrote:
> -    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* FEAT_CSSC, FEAT_CMPBR */
> +    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* v8.7: FEAT_CSSC */

This field should be 1 for CSSC without CMPBR.
I got this right the first time, but lost in a rebase/reorg.

> +    /* v9.0 prohibits FEAT_DoubleLock. */
> +    FIELD_DP64_IDREG(isar, ID_AA64DFR0, DOUBLELOCK, -1);
> +    isar->dbgdevid = FIELD_DP32(isar->dbgdevid, DBGDEVID, DOUBLELOCK, 0);

I missed adjusting ID_AA64PFR0.RAS.


r~

