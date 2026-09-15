Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED9CC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6T6z-0005Do-Fw; Tue, 15 Sep 2026 09:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6T6y-0005CO-3t
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:22:12 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6T6v-0001LS-R0
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:22:11 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4ab1b9f7so1430234d50.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 06:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789478528; cv=none;
 d=google.com; s=arc-20260327;
 b=i1l9zdPB1BfbhbELOmTy0a1LA2JxJ9BkFLp6TUbbxLi8odKZTKxJ1waA3N37I2gPOB
 9gps0HEp2umQ0Fi+Zz6aqJUjgbpOA657iBdHRlmT1MZ6cWWih5TZhYJABJ58Lm0eQRf9
 bfM67893LlPrOMqfnPXjvAoQfqSFGoHnp9lW6whVFNHRrDvJbP0loomhDdUs997YT9Ei
 ggG79S2FJ/drMQQ0NYFHOrlCg9glLqo5Mj7NcgJYBSRBtojuJC2jClgvYLpu0i8zwDs/
 duFBOLNXe6ro6LXjOCxwGSa4OCD7Y9aAhKoYiWlXaGsWfcfrpIojZfz1i2fnBeB40dyJ
 L+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W12o7TEZn86APiTZttCpqXbjGDKtL4qdG0FaAqyRrQo=;
 fh=fVPfpHMeJX2gxPKYTBQCzQO60hB2p26ro2vRuUEPsJ4=;
 b=nslbLOoFulrToh8hPoCVK7kjyu1hD18W1ZqriKZrlmqtTlMmLZOa/MpQ1XdQpGEj+s
 P6/XF67xxCO9Z9a5zjbQGYJK9l07J/rea1+W6AEXQAkjcvLuiOUSVTwqRa26238LIXAQ
 PhWnTp0s37a4JH5hV9Lur84o/ifrGFq9lBm5PmtxgkI+2x8FszYdyuHuQ7gYSf23P3HT
 Kh3RU+3UGjumsGYEyTGtKrJIOULxAItIFSYOxJbDZspJJQJ8NOAe9x2zkRteeZ/nNBVN
 JkfhrgnjJS2KwrxNCayjS10KA5EBnVGizAkb0a8lN44ypF4B1WL8VdGdlDa+cJVqejyE
 9Wgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789478528; x=1790083328; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=W12o7TEZn86APiTZttCpqXbjGDKtL4qdG0FaAqyRrQo=;
 b=jYlBr1NzmxP5Oozz8LbYeeS5RoMe9EltCo8ZQ+Voi55EEbR4tRjfvpntlh9Lkjv0PA
 AIkGPFKmEok5kZh0kruzUATtgXusTAGvC7GtdMMUJX79h1VJE/LT54SZ9zxgT8HGpU5S
 ilZRzoDOCm9LkCq07RejFPfQxYOJadJrbaGGLKpmJe6OMkXKk7V6BwbM0Hk9hpzvT25T
 G28j8yCf8wGgWIQYAh2dtwSsm46QFnsZQyle09MurBZ6M3+gO+JKnDg4uhfzbblhQdEf
 Oi1EQ0dN7HttIDenO9toNhphkz+yi/PsYmzq0UCFktpb2inaedlGSok4oLg4dRPLCccL
 cEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789478528; x=1790083328;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=W12o7TEZn86APiTZttCpqXbjGDKtL4qdG0FaAqyRrQo=;
 b=1gmT6BJBFzoVXvEptv54JcXEfIrc2xMdWYUXCvTA0elrfsnAMLbmgiCj0yOhphy1y0
 inIH2gjEoIOxY1PrazVFpjvm5iZhks1m6ms+liRejB89ZqKBcMAdf3UX40GSSnS4UDA0
 nwcgDYH1BTK50W8WfrEx1hdPJyBQf2O9QWJ+WiKfvBUHQwWwS74Yk0RTFA7mFps7pHNR
 uK3YQydNduDx8K0tpCtJATkB9aXbuX+isX8IRiaueJBUxIJR7lBO1MdTJbENtBW0dZB1
 5msYAf1axJE2JObg9fra1Pp16ba4lKIOkIfgn4f6MugbRsrdNMqTK0M+xVN7Y2kSv5ei
 pX4g==
X-Gm-Message-State: AFuF++lr6XyBny3yobvO7SgZDlFM7cHKf50ZUrpJ2dDHquHoyWklUfXD
 AXAG2kfdkdSG8VzfTYOBygCyEKAW9Bx4tRUuSNkyBhkwiMFHBM9aeiRDIpjLHRjyEb+LVniQQG7
 6N94LlFU37XjzXjT2dX4tTeJr5d42ksy9Au5vXecqrg==
X-Gm-Gg: AYBFou3aQYyt8di14HZdqP2l11zVBUGgmoLXVvysG7aP18c0a+8aJjAT/Jk7fJnZ3Sp
 KMKLTtXqLLAUsRh1Zfv8mHQtKn/ldkkR9QuleJUbvxwq+p2MiAr04luTZndFMS5mql12LVFUqu9
 k2kipnKItr5tlN51uEoKKSqUWPW7xWIk4HJZ4AdzktZb022TFERZvVTNjHimxgytZJoM1npuVsi
 3VDyUNmDaJDcKCDdMFK1mMYkAU+yr5RaHD0Km/zvlE3oz7+ViOuKAxoJIfZhPfP9rOuJsAin1Vn
 k/yvvGNc1vj5wu2rC7ftR0J36ZEtm/SOPSpYEEW500DkctxrQCXqkO0zzhnVKtmdFa9UgpFCokE
 JDNhWZcB+OICsg6Bk1S8dqWQLlxQw/KvzTzW9SoM=
X-Received: by 2002:a05:690e:d5c:b0:671:4d0f:13e5 with SMTP id
 956f58d0204a3-67154f6d8ccmr649579d50.8.1789478528125; Tue, 15 Sep 2026
 06:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
 <20260914192323.29250-5-gilles.grimaud@univ-lille.fr>
In-Reply-To: <20260914192323.29250-5-gilles.grimaud@univ-lille.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Sep 2026 14:21:56 +0100
X-Gm-Features: AcwNN1WG7p3_2CD_dXN25H1VAa6L_pCIaO12Kn2yP77PfsN8gTbyDlFAGlG3UD4
Message-ID: <CAFEAcA80Nwh0wULFVqO4CeTzNj0QQP0SHJ-j2CvQB8j7YM2+pQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/6] target/arm: MPU_RASR: mask TEX bits for Armv6-M
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon, 14 Sept 2026 at 20:27, Gilles Grimaud
<gilles.grimaud@univ-lille.fr> wrote:
>
> Keep the existing mask (0x173f) for CPUs with ARM_FEATURE_V7, and use a
> mask that excludes TEX (0x1707) for Armv6-M. PMSAv8 is handled by the
> earlier branch and is unaffected by this change.
>
> After writing MPU_RASR on an Armv6-M CPU a subsequent read returns zero
> for the TEX bits; Armv7-M behaviour remains unchanged.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

