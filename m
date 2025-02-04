Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0877EC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLpx-0007IJ-Tx; Tue, 04 Feb 2025 11:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLpR-00072p-4Q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:31:16 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLpP-0003Za-C9
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:31:12 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e5addc7b249so3670062276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 08:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738686670; x=1739291470; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6jO3SEdCWmHUg9X6atoMMcR4mM2oH2x4+LOOL6tTUMs=;
 b=j6n7h7jttXLKHv/xKjLA0ybIxBcFCG0ZkWQ7F++MDZfCFuulEluhJ9T81gc9zp2QZK
 cNWhS+MwKPpji3YV4MBUy08xsIjlVz09uMylqiHm/jAmIxcBcs7FFkK0K585jk6RkQuK
 s6cWQMNLGEulLbLyU3V7SgNxhvkjqCCw8GbHkih8Bk7eNUo4va4qVq8oE0ySH5T5T5H5
 9Kf3udnzQ9pJ02KUui6k4Ir7GtmhIEkBqlVxbt27jq8WOzveqewwhwTafmyIpQSSqDSj
 1j0BHjLP2ZKwuwsnmat21CPokNU1G1FoRUX4ct8hmfsVt+uylz8+6S+3Nr23gfFU9S2x
 3G2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738686670; x=1739291470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6jO3SEdCWmHUg9X6atoMMcR4mM2oH2x4+LOOL6tTUMs=;
 b=etNEk621Pas4mTCPzbOCkyugqzSulzjRjbNEypfZYlhvjxODLcOzpW2RlbJClk0P8E
 eLlTN2UMoIvqWFIDkKYbnz/8F+8aIvM4Azmtkd2zSVbSvTIbdS7ktUizEc7svM1ngRZT
 QmU36ZUpTqBkjXViIyNu1CwDfcZbZN/rUjl0vm/wfIGbXIiXHM/TIKiorX6JodJF2Ydq
 VlfwYvo0EGF9tid+sAu4Qpd/cMfV5UA8cXqglLYY8VORM10qd16zmycta7BdDjQq+zYO
 G+rPVGZOmAKhVfjariJXCPt8k3/qUJSiPi0iJPuVWeL10i7jwXrdGmBE004TY2rFT0Fs
 RJGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYkDpOLvB3pG6hQwuL7PG7HLZ4BL0dmDp/N0e8DHhnTef3XEKxAQVOALFaZvTJdnGohFU3m5I2P197@nongnu.org
X-Gm-Message-State: AOJu0Yy1mVKdXB5Z81Mp/by+ox38kDL59zRH1PuzjryK2VxJp7BHiZ+J
 FF14DtWOB3bizQCSnArIekT09LrkRjtuuzxPnw0DRrTQtKn+rI3bGG55cOnztBvJTC2hg/u1rO4
 sKyUuEJeded2rVrKeY9TjNQybaytM4qQiViLWtQ==
X-Gm-Gg: ASbGnctYvwkHV6PtItwMME439FCAUM8V+1ZHaGFLiEY6pfPC6vzN5vIdYF/fyQERY2S
 Ib0Ok+8HJ0Ke2S/nEA9TUA/FleX8QxfDT0wAsjxOMaKAOZaGruR905wAz3m9Iky7EUMGAh+XnaQ
 ==
X-Google-Smtp-Source: AGHT+IEejt4Lt9SFkLT31I4V/o0vH1oAr/66vr8MNNSMH/Nao7QDYMfZugDJxewl+OOWb38eOVxKgClB5A1VhDRlkEk=
X-Received: by 2002:a05:6902:2191:b0:e5b:fed:7b48 with SMTP id
 3f1490d57ef6-e5b0fed8ab7mr4921685276.43.1738686669706; Tue, 04 Feb 2025
 08:31:09 -0800 (PST)
MIME-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
 <20241226082800.2887689-3-wuhaotsh@google.com>
In-Reply-To: <20241226082800.2887689-3-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 16:30:58 +0000
X-Gm-Features: AWEUYZkBFhZoIe4sUSyWlrra3qpe3BiyyGLPZGwbmdeUE__VgRy-TWUa5xks4wY
Message-ID: <CAFEAcA_N0wiJRjLUsJzsXFBvBpnsqTK_-YPb5CK5sqE=2MZ3ew@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] roms: Update vbootrom to 1287b6e
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, hskinnemoen@google.com, 
 venture@google.com, pbonzini@redhat.com, jasowang@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Thu, 26 Dec 2024 at 08:28, Hao Wu <wuhaotsh@google.com> wrote:
>
> This newer vbootrom supports NPCM8xx. Similar to the NPCM7XX one
> it supports loading the UBoot from the SPI device and not more.
>
> We updated the npcm7xx bootrom to be compiled from this version.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

