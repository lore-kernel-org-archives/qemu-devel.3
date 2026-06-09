Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B0ECD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrt1-0004XM-4D; Tue, 09 Jun 2026 04:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWrsy-0004X7-La
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:32:37 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWrsw-000056-SE
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:32:36 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66043ecf6b3so5228872d50.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 01:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780993953; cv=none;
 d=google.com; s=arc-20240605;
 b=gYyZ46t83H346Cgwib8GDVSC4ILEvCvDDmjEW7o1iDFlx2h2TA31x1LAl9xbzrGXdy
 wLjFvo5oi7XeV6PnBLoPLlHdQSWlhJ2WQKy/191VHqGACLq3BrkfmKx36ROJxCh/PRCv
 F1G9VazFCfYShVrvcRuN8s4WGoPMFHfj5jxBZ57PU7US1D8PCH2KmI3eCJ4dST9CRyfe
 Q0lVu3FXFZvCP/UlWKV9lDax/Ge9zzH/pwsWEIhFJiDeFtUBDNDFFpTbW2epoSuvYErL
 1jpCh6GTeFH03wEXr0wKq7svPcRXqxCZuEg2grvkOVe+HXQvP1hp7ucUueOK7ND9cCQH
 kkcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eGmRvggmkX3RijdNDruXNxMrOnDsMq6YRfx8A8FWgXw=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=cwCivS1wx8eveXCGyYGsppc02EUVQMxRax4x5AmVi7iMhllg/P3WF2n5w3UeLkjhqD
 6uBiAhv9MEQQ4L0BZggc3/RKB0sjCw0UMeJtN2s/o0KoSSKb6ou0BZKqqVP7b1Ts5BRL
 oF7Wzdk+Hjf0CT2B7RzuybWagQ/zx9PycSl+K9Llajm06nUTNovnJ/Qa0JfnJRUi9wLk
 44c0VxfG3w1MO40GzeI/UnWxURv65knVQFsmN3i3KyBJxlPMBtnY+NaCnzSVQicHFOy/
 qdh0B3wvUYs623pMYbGu3tqDKShDgXEyF2ovOHT/aar5vv7hovnmSoIymNTFXvoDB/w4
 gB3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780993953; x=1781598753; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eGmRvggmkX3RijdNDruXNxMrOnDsMq6YRfx8A8FWgXw=;
 b=Vw1aLJJy+ZIDuBokzvCk5TM0dSvF/9HqewOWnAq4XFSkCwHKLqjLMRO687RSIASbhg
 XAGH66skFgnQBeIeVR/sxiQn8oaUmKK37gEepHp5t9rS+0OjPHMvKagr+f4MqegnL3k5
 3jRQZ2FlbSvRNYgW90SI3XQH2EPL0rlv8g5TwZRGGEzVz1qSwl73iWzsfHlv8Ncuccc2
 8aCcqOai+TkDkDMx3wyLT2kuvdJHvviEOX53tpjbEf0jySN58QW2EevWvluUe5iHxM5D
 9Q0tdRk56W6sDdGWX6ZG5NDRE3z4JcI8l8wf9BT5xk2nsln/GrKSxqbccI9vL48VA4Sp
 9HHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780993953; x=1781598753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eGmRvggmkX3RijdNDruXNxMrOnDsMq6YRfx8A8FWgXw=;
 b=TX3SMrtCBh9y1/j2+rFBP2Umysbuf6LLJXUUWB30FF5frTBRzU4FtqTaiSZkkBO8Lh
 KjM/yqF9TaQ8fqqmUh3lapN0V7rlKqsCpDed3LOccVr/TuUhOresGNrDWXa0Hd44FH8S
 bqWMQjEHHZHH89haECFl6XYggv6TMitiXoGgDIF0nvYBX5TuxSuvvihHtEjqwYMqm/zc
 84kzOH0sjdrd2y/8QKefiRwKKyf6UDTFlgye7NTgxSBDWUcxbvjLUKUXXv4VYHxR05VJ
 e7m1M4GREclvRtMpyLPvfdcUexOKgp1ETjv4PK5VRs3z49pSSSKmuGTltcKyC8yCiZCw
 23PQ==
X-Gm-Message-State: AOJu0YwO2hBvuhVCaWhxRiF9yioz5R07aGgUPkz/yUx9y0w7syiW4CbJ
 ZoqWTv43wxXVTIZfXorJA/u8z/2Q3aj6vdZ5TI1JzgPCivlR188keJbDknnzSjLST2wKGSII4rE
 87d86ExYtZbWN99GzEvct4OHNy4XFCLMveKW5+cKXBg==
X-Gm-Gg: Acq92OHNXe1HypQjjIj4dXje43NO2trQ2MG3kit7/4SzikIf6PXbSZIhzh25ulvcDGx
 g3rvrxqmagn9S6spggPKADmjgjxscSYt/aL49W9HkrFxwjk5pxjeCVLMTLWESgkcXwx8DxWU+sK
 MI+iC0K53Ynw89Fpbdbd+B+BiIfaV+EN8lcLHzOf9+83Lf9OyDx02uRRsFfe0dxQkyeiTuaSdwD
 fpfWW0CXNj1u1OIgCPHPXpj3nNqS+JxoHBJ7jVt0IJ6IG8fW0be9hMPHdMABkXo3DO1sBLO7N25
 W4jNoDGYHO1JCbxbR2TG1VimIHAi9uYJLru/pww8w9LjoX2X3CBwstVlSpKbGVzX/tpzC/BlFC8
 SgQ==
X-Received: by 2002:a05:690e:11c8:b0:65e:4bcb:2a7d with SMTP id
 956f58d0204a3-66106fb5392mr16301999d50.57.1780993953558; Tue, 09 Jun 2026
 01:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260608190155.637067-1-richard.henderson@linaro.org>
In-Reply-To: <20260608190155.637067-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 09:32:21 +0100
X-Gm-Features: AVVi8Ccu7Na9ACb8YapEialsQnqeubNO_FsIcKDbsSjiEtlE1vrTnnSL87I9nx4
Message-ID: <CAFEAcA9wR8h_yipin6WqoyPgKa3GwXE8E2NfT17+LLbZbKrzNQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fpu: Handle all rounding modes in
 softfloat-parts.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Mon, 8 Jun 2026 at 20:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Fix up some unusual rounding modes.
>
> r~
>
> Richard Henderson (2):
>   fpu: Handle all rounding modes in partsN_uncanon_normal
>   fpu: Handle all rounding modes in partsN_round_to_int_normal
>
>  fpu/softfloat-parts.c.inc | 5 +++++
>  1 file changed, 5 insertions(+)

roundAndPackFloatx80() is the other function that doesn't
implement all the rounding modes. But I guess we can assume
that 80-bit floats are not going to ever need them. (It will
assert if called with anything other than nearest_even,
ties_away, to_zero, round_up or round_down, so we'll easily
spot the cause if we ever need the functionality.)

thanks
-- PMM

