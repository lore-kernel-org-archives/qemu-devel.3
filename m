Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F3AC43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 23:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgsJz-000294-Qy; Mon, 06 Jul 2026 19:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1wgsJy-00022f-3K
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 19:01:50 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1wgsJw-0007MG-HE
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 19:01:49 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5aeb6bdeaeaso945e87.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 16:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783378906; cv=none;
 d=google.com; s=arc-20260327;
 b=R3lLPf8wDRb2DRqfAda8ELlxQUlGzk8lzOQyH5C8CcdR1hgAeXbg/0wWM1DfjpJDp3
 FmP5sxrGh2H5OzQ8VZg8k6w/NlO0ygBHRcCKVYhPRErlfsgEeihx5VVufqvwez8aQwc+
 TRBCq7AOkiBZ1D3K43JjjlnXA3oTtOwB45ZRA3eM5WynaXSU9OP4wHHXUhwb/OcR4IsU
 lqQ03D6mWWtMF60/aotW4EHGMi5C1HP5TfgAVgrihAgEMVQR2MpfRmMQHFCfynO0PI0e
 Z/CFYztdeaXsfyn+qILLlmXjJ8fAE87+YposmdVbLB+pCkvhT2Y5C2ebJyRIM75Rk6Hg
 QV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wO2iLMvkV2w5S4S4Uow4ZdR28T9K7ZwbCl7ZUO9/KrQ=;
 fh=K+AtKPRmD6+W8CXi8KdDn+poxqtlLd792CCB9Qwruvc=;
 b=pRtT2YEcB3Rz2TYJ+z4Qr4I82fUwqy/lxHghyY6Si2fzbkRS8eaYQ+rX5HY1o+tygz
 O24FXCq76Mwfy+UbFAG5MdDEF2JPds1+LUVvQfqCPXAtGp2kflRiM9OpnH64ZfgTb4eP
 pyZaZiB7gsI4K10mss8pZYDeA1YMTAto786wcr+keJvovvOnPoaZHN2cojm3vPkFftgS
 vT/McbsylfSpbVZfH+Fo40g0Oz7pU8Rhz96oui2bkVd6P5vpoGTRt7oOnwOL0Iw8F4nx
 Jhpa2h2FlF+nrV3rPbyIlotCt8uRe6At54Vwrd+KM8xj+UA5nIGkzVeecNkoIH1gkxjq
 1tDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783378906; x=1783983706; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wO2iLMvkV2w5S4S4Uow4ZdR28T9K7ZwbCl7ZUO9/KrQ=;
 b=jNGoT93UBE/anvNB7w5tpgyPVUxyqlb0GcfKhckAgei5zpP6usEw2mtfJ7gSsSwKtO
 NkoiAk3YYag/6Qz1oVKnSQCIqyh5Ko0nF5SAvcgO8660xzpoAEcjJMZhNQzdLF8MIkbR
 cSfDm7q6CBRwxrBlU+y96zqun0BhRJHEsGDh977N7fke5sCI+4NIFjOfIWBOt6Jk/uWM
 3WTQqqL7W0vNgzwaDwdqxZw5YYrHDm118XUzIjhIG1L6enLKjeBQEhlFcav2JBSmYMTI
 2OYFuqpSoLZ6ybbhbUvfDF8yNN1boF/C9veZmWJGCVIZohxHp4jMn2UsrY7+L7o4KctE
 A5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783378906; x=1783983706;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wO2iLMvkV2w5S4S4Uow4ZdR28T9K7ZwbCl7ZUO9/KrQ=;
 b=mBM77zaOFhyx+FQLxmmG4dsPrZnRs/Z++g+MLnFjEOzxIW4p9vAhDO1UZixI3Y8ro0
 LiUOkc5+ceOGkPK4S+Kq5u4v4qSfEZkQnoun5bminr0YuGGJlseYC34ANzo5WSJoJlsj
 UjD8cOl0+wHyvg5M8Z219Sui7sdYRD5OxP0bIq/QP+eKF3pwY30E/Ox0zoif5SpO34X+
 Ho+e3pLE0p1JV5CPSfk04TvPiUv05I78z2DerdaWQ2hWQ7cgiKTvtUdXCJPgVKymtIPW
 sUt+/M2kRxVeSK+bvf77wn/lTzcWAPdwueeBIvMiYRLIGEBBhc9ul9ACu/4V96yqitZB
 kIBg==
X-Forwarded-Encrypted: i=1;
 AHgh+RriSiXMfxrj9R5skKEDHKlVei2w7MsLMQtRa0C8jHM2dzOumHJyb6K8OyCr+k0xRv2YmpCgLetbDTJy@nongnu.org
X-Gm-Message-State: AOJu0YzzU4PPy6zd3YL0fuL4Um2r6ge4P2X8EP8SecQOiEe+KIudaWW9
 VdPcuSo9NEGerDHvamvT/wITwz3a/jlQy/G/a4iLxMwV0L43R19Ermmb8ieHRf7ilakUdx44Jw7
 sWdYL7bvh6zz7AaOjP2IqF2GIjtrUqCaCjKtzaLJJ
X-Gm-Gg: AfdE7cml95hscNXqHFqRZepbkWrMQiWwEFjcUmbNvJsk3s8BCHKfjPG3bAdSgbv5wg7
 SKA2iUWBb1A3T5oWcGfnS0YIL3zH65J6XlBxR7MCT2sLEXLimwS5hJPjD25xVVdb8k0UWckDPea
 0RL3vVucJVtEEZh/0yxG9RwYa/X37dH89jaSxZBJDXOC6zirirA/Z6v1I1dgPQAPm46S0Fmcier
 nrHTKhuXpy+D0u72ALlthgwlJA2Vlx1ViZodgHzHDNRFXGGKhpKY6Vejt6rprxcxxmeFYGqe0e2
 6AxFClwj3ZHEFyQIJZteKQPpxcJ3kdmTi0A8Mg==
X-Received: by 2002:a05:6512:234b:b0:5ae:b59b:c65e with SMTP id
 2adb3069b0e04-5b00ace6efemr21718e87.4.1783378905391; Mon, 06 Jul 2026
 16:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260614222131.5795-1-imaginos32@gmail.com>
 <CAFEAcA-GGP6aALn4Az5By31q1R3d75Mm+p_YXN0y=tO3GxDYrg@mail.gmail.com>
 <CAFEAcA8zLzVLzTq-EJQ9+OpxytMdPuFkUbOF7xjmY0JrhPhYhA@mail.gmail.com>
In-Reply-To: <CAFEAcA8zLzVLzTq-EJQ9+OpxytMdPuFkUbOF7xjmY0JrhPhYhA@mail.gmail.com>
From: Titus Rwantare <titusr@google.com>
Date: Mon, 6 Jul 2026 16:01:08 -0700
X-Gm-Features: AVVi8CdLqN8eY1LBzlLVKuOnYS6NtHDIMx0rBUqE6HslYAOblXlH1N4b8QB4PCE
Message-ID: <CAMvPwGpaYiE0uwY6oVJjxdoVwGf8Mxr40o_m+PAhdZqqcShf1g@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c: pmbus: NUL-terminate strings received via block
 write
To: Peter Maydell <peter.maydell@linaro.org>
Cc: imaginos <imaginos32@gmail.com>, qemu-devel@nongnu.org, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=titusr@google.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

The adm1266 has a strange access pattern for the MFR_* registers, I'm
creating a series with the patch that fixes it, but a quick summary:
the data written to the register is the length of the data to be read
back, the actual string contents are read only.

I'm sending the patches that update SMBus and the adm1266 up.

-Titus

