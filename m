Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438B0EC1432
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNtc-0006ax-De; Tue, 03 Mar 2026 06:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNtW-0006VH-KK
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:26:32 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNtU-0006ST-Pk
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:26:30 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64ad8435f46so5149009d50.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:26:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772537188; cv=none;
 d=google.com; s=arc-20240605;
 b=Kc+KLjQZ05Hk4nwjB+PJGbH62Gy9GP3lPcp6J/M0UdLeUgYD5/9S3glPhVI7NiRRAu
 ybqkEQojyJRHomDXtShrWLWdNjv3Sw/m4zPm0hsDTk8tPOd8ynQDeEUUncUFTrthOjt9
 GrqnkjLDd7eBRPsMGBxNZIbAq/80yNdQ0RcyLupk6MVCTSw03QEkH6PUqHbSZIui8hOL
 QIOwNxfdYgAgkkt4qmg7WM7z4OgCqUHC7fIXAukaA3sj5l68rSCYyTA4QPDe+5/SE4la
 UwArO8jWKQ28XgAUnX5sGN+M3re1vNtcSQXO0dm+Q2g3u0hzzT0FhdxUvpdZYMFKrHmG
 VXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A8Z6WB7nAHorDaDqaWbnYplt3Wv86qfzGUQ5z4nwdrA=;
 fh=e8lPG31nRq0pa29+ILZPVpv23pShvDc8zQNyomzI6HQ=;
 b=SdlMyjUMUb3IN5IFdFOueAIHAoxNr+37QrdUeO14qqnTnZBrhvDGWZY1/1Xlmz5NDL
 6Nm+uqlJHisLsTlGgBNsekSDZ7sbwJRNcPW9ZkjCKaqToSlZMvDxVvcYhe3rmX3iTYNu
 SBF7yAiEX2lvUKKy5VX9d9XzQddK5Nt7lh7/tyqwRcBE65I8lQT6Q/WlRg2PKEdfWlUk
 owcQZ07EYfxI74sOIkO6+GYMdA6/K6zy8JxCR7AZG6OTBWN3mVsYOfd3Xta6QtV93/FB
 c8z43l6aKdv4OhTaGEsRPH2PTGLiYf8KI9+y1kNhWQin9YORprRGD6a6sczdmL+gaXKU
 /Kyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772537188; x=1773141988; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A8Z6WB7nAHorDaDqaWbnYplt3Wv86qfzGUQ5z4nwdrA=;
 b=LbBrhFxYq08qq7IFB9tPXPssStJKjbxRpY4ihq2sQGG+8qBY/yPFBubVpvxwpgp3mI
 pod2r3voZl4BJx+n3dUS/zw3w0USKrHDyncLxNrwIMc1cgPe92rTS3j4wcvNhkq2NP6m
 H14OpmYQicd28YKjxz7n8m88gNjLS5HvXaGKPKxTBHTJpr5mjNLRzXL4O9pigNaEaJMP
 kEHvqrCc13009J8VkXa+ntRUTx+nl3cJciqtSBNOQw2HE4cAyC82CFOgAgov7yiJRLu4
 ehsUilVbb/5pygLYFuxNgLOrGV7zdOmobPkRrbJ/e2WVkri7Ml5MIuxAyafNVY7sPP7a
 zygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772537188; x=1773141988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A8Z6WB7nAHorDaDqaWbnYplt3Wv86qfzGUQ5z4nwdrA=;
 b=giVBxhqyQkThH81IRJ4nMdbq0tec8B9YRYOLWBVE+6by+hWj6iSa/MdEsLFImVp8g2
 wia4EK7cbfrymD/JIBQzlqLuJP1OYf4Sed+gSGgYBY6o1FgbrIJKmD5nMev+bqwnxIKb
 vF7rQC4vicdVWe3HUAmc1ZcpUQWUVon16sQ469hXBSBBMTYBSSfTCR39Fwp8TtreOz0/
 dSbOEGKI83Wxe0xwNOHZuAb3dzE33PNB+QTnhe3OSgamvt04cmfY8TOhqaW1tysD/tkV
 e4hvp7QW6T6b2isTJqYJEWuCGaLP5tmVRaCUc1XmvwI6/YenO0qLJ44lbkFnD6KjSgNK
 TlBQ==
X-Gm-Message-State: AOJu0YwBhrMYxjW3j3XSQsQ8vJG+bDQdPBgaRSoCSfSe5o8a/f7H1uae
 GcAkvqB9u6pk9Xx9zkJ++RNnaYWl1ZzL/tnK38hQE07Bw3c5DyiyhYPUm23O1GMfumRDN87jxwC
 /BzkFaSK/r1i4l7u6R2MN/VCt5ZiyhBW/5/MeeXArhw==
X-Gm-Gg: ATEYQzzywXsf6UkYaibv6/KfAqdJKnLaHRjMv0UhNbGdeFeDUQktTPDNYhO2VCaxZuE
 tUw80YFzNoHhn78wmGSt15CCSjrXhXoS41hf1NgRUIVk2IZGbGBh2Mge5r3Yi58A+ReI6uWPB8V
 lSZRUiQwDSa55+4sD+XrzXbSMirKyOK74Va7HCp1e4D7BjJ1Sopv8Swd9saP3iEx+Ne2snueB53
 u+h3s3pJHikdLYHMVlFSxnzZuct0tc1thw+UHV4HWHrqJKixhZ0Jztos6OyOiQqgjitIkWPdOmL
 iRM22ENo+FjRsJS30hcz2kyw/cVe1WUOcfbJloPWk3By1pjGnvTXzsLX0a8cJA1udE7BV6YxNE1
 NxQ==
X-Received: by 2002:a05:690e:200a:b0:64c:9a66:9a15 with SMTP id
 956f58d0204a3-64cc1f48e32mr9005665d50.0.1772537187643; Tue, 03 Mar 2026
 03:26:27 -0800 (PST)
MIME-Version: 1.0
References: <20260302220254.1166849-1-shentey@gmail.com>
 <20260302220254.1166849-5-shentey@gmail.com>
In-Reply-To: <20260302220254.1166849-5-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:26:16 +0000
X-Gm-Features: AaiRm53ag7NYA0odo1z328R2rygl5caJ5bc-pave17NaE3VxBF2clreQwFRtOag
Message-ID: <CAFEAcA9a+HSvZsX0MbqMbEEcJrVEXpg-Exu7FLxJgMWgotzjHA@mail.gmail.com>
Subject: Re: [PATCH 04/12] hw/char/serial: Reuse fifo8_num_used()
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Mon, 2 Mar 2026 at 22:03, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Avoids accessing private fields of struct Fifo8. Now, TYPE_SERIAL only
> accesses struct Fifo8 through its methods.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/char/serial.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

