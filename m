Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A23CA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDX3-0006qQ-Eo; Mon, 28 Sep 2026 11:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBDWy-0006pV-LE
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:44:40 -0400
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBDWx-000507-Bl
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:44:40 -0400
Received: by mail-yx2-x0e.google.com with SMTP id
 956f58d0204a3-67375a844dfso2862292d50.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 08:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790610278; cv=none;
 d=google.com; s=arc-20260327;
 b=AyaZbNqqhNtjlvaKhfaH3j2fZUmez7CO1NVfZgTtxoCKe/vRZZ3v03Qw6eDKEgnyVs
 v8GQPcriX8E5aTi1SeKgj6PdwvVfdJIylR3M8TxBTCNrX7rO+Xcl/uEownPbzmgtjLKZ
 gVG3IcCOvDj3GX3X1sWYwFrLnSleaKPy4DrPYHBto32rSReWqY5r//AykGSbCifQ9YQ8
 wfrvWQHHXVRwcQPXicu5+EwmYbVIzK3v5XnseuuUSxbcZE9mt4QvS880IjXmLdQ6/psN
 cplhcjBHD5S89g5Vdvnfq1RXm+TiW30iuYqEonZGjWZiEzlllwIIqlPX+REzvgEkP5sd
 gmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AiQtjNiunrcG/8J5YHHMQrio8j+Oayk+13IHAt1q+Uk=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=qkVITiSqor8ASb0AWUgKqeTQxv3rI5PqXjIWy/MYppof8xMkX3wLGGnVr0dbP2GpXv
 umowLsy3CriWhU2GTQhYf/D9SCL9kYbG4ly2l7UlfCmBRE2snlxLjSjZ3RLNT1piwWxC
 /E7w/wvrJtNk4HsYtGspbPbeYV7e/92ic7pZvIC80Cye0sHEQuR54EBF5wHz12n4HY3H
 gJBycEwnvt42/6nU7FssLzZ5Vh1bMbkpuC0pJCF1QycBMQHF9fazC4Kf9TqwW7Ya5fjP
 eICxaCylrQyUDJsnjx05LjdH/uS/66VDG/MNTLnjhOuhMwOQCjJqCzWiWhNsjAiHwf1p
 eW0g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790610278; x=1791215078; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AiQtjNiunrcG/8J5YHHMQrio8j+Oayk+13IHAt1q+Uk=;
 b=qtXeJdDuYtaA3QJQ1X9bn21wUTVl75y5+iPHJm0z1O6m92YSP5DFK/qfk4ElGqLZRN
 cWJulo+7+IGaU/WeDaEW8/ZtdshpbnrwnmEXef93aOIgzMSPozUjQAvDvqzfDTSK4C+w
 p9c+GBUi44GesuQ87OjsjRp5e3f6bksu1qEO4ipXA+BF17VaZgkTZgcbrcGRB7GXoRi0
 6XMqTZ8sxhm+fCevijoNbC7wy4usMfrYfJNEzUom4YSFtMSo/zw72uQMwMvNkSwGQYZo
 NwxkQx/fEydfRCbO9cXScJiycCXKtpG6eb0l0PBrqHvGxXa5bJ0gufhN7GmTO6/osqX8
 r6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790610278; x=1791215078;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AiQtjNiunrcG/8J5YHHMQrio8j+Oayk+13IHAt1q+Uk=;
 b=1q25ZOql5DgmKdpNLsX6nL/0IZLNYhSP06W29GyWat5Ylm9EwsPq3wrMrTH8TJUlw5
 vYrYv8jTfTAx2I22iHItozWAqzwizO83nRzKzUHwzghZtSmWAegUN02MoURJA72+dTK+
 WCUVe6QR2b2U2d+nJ868wcgq5mS+yaoAYLGRFh0KZtCv9E6ooOh/MqaXimnNec+blJvM
 Qoc7/7buVP3qdA0B18xT8b4Q8w5aennfbYnSzpJNBcHdXPxkOxjgj06jASRzxWJ1ncZj
 Zy87qQAnQYxMS4zRmmCsCAKVq8o7KIrO3Gln1X+elYub3baGKtmRnyzNQs0Y/oLx2HWt
 XZ/w==
X-Gm-Message-State: AFq9FYISRKnPS1TlpZIHnPC6qF/tCElqdI3sFgS56vX07ugR3tqYBt7b
 TY/oc8EWiRindQHJCqjcWuUsp60LA6NXWHUd9urhpeZQMOb8MOtWnvSFiGZQJFLt9HB9ASX0CkP
 LpgbBNEbPoY8rq2sLDA3Jy1WEZlWKWKKsvC8tG2LMUw==
X-Gm-Gg: AYBFou0sY8LbauEhrIpfkHG5sbJX/mp7OeTOIzVUfqNPOe/TjzsqTYraaZaMzFF4Lkb
 12ZDLINtjcqHWreNEvjq4IYDNXjrlpYcRF2d4Z2wNVIADmeb5dzIkfF/gNNGxIOh1dr2Pzg7jnM
 5b1fxpuWJZB7NP6CwYeikkrzyOKlShZTZluol1Z//0ZAosOgm9MrhdJsdobONUIht72IBvR66Td
 +B5hwpdpxtjSRmTO4XIuDb5Z5z7Gn/KZrUSt83PZPugeSll3W1Dk9uxELaLrpVQX4C+8PPa8XZ0
 z0mU2k1aTzXth84ItuSByrbFPqnepRUKdUUrNU91Z19I+ODrzBejk8MPloJucwDTuFiim5fFKTi
 3d0LYc31AAuf097Z1si7YRWcZN0WYiN2iZaGjn8w=
X-Received: by 2002:a05:690e:120e:b0:675:4713:1f9b with SMTP id
 956f58d0204a3-67547132576mr1622260d50.39.1790610277942; Mon, 28 Sep 2026
 08:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260925215004.456336-1-richard.henderson@linaro.org>
In-Reply-To: <20260925215004.456336-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 16:44:25 +0100
X-Gm-Features: AclHuK_pJRuo3cwfBVjfj_yKldj4o8JhmMgdYFWUybLz2cfhYKZ6xj4igMKumGw
Message-ID: <CAFEAcA-uu-v-xnNH+vihOvccwobHbLpo+frhjm1_ZNKv4hCiZQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] target/arm: Implement FEAT_UINJ
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0e.google.com
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

On Fri, 25 Sept 2026 at 22:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v2:
>   - Reorganize rebuild_hflags_common*.
>     Trying to force a tail call for these was perhaps just confusing.
>     Inverting the order means that we can handle initialization once
>     in a common way, and the lifetime of some of the parameters is
>     shortened.
>   - Introduce rebuild_hflags_common_aprofile.
>     This gives us a common place for the new UINJ test in hflags.
>   - Introduce check_il_uinj.
>     This gives us a common place for the new UINJ test in translation.
>


Applied to target-arm.next, thanks.

-- PMM

