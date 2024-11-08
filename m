Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3CBD5C0E5
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Qgw-0004SF-FN; Fri, 08 Nov 2024 10:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9Qgm-0004RT-5G
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:14:21 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9Qgc-00016a-JU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:14:15 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c94a7239cfso1569355a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731078849; x=1731683649; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iz4zLuqnG0fh35dcQoPgRmjAN517l8b2XuGgwH2ZeXE=;
 b=ocp7Abv2IBltXrahyzmPm0nv1MGZbUnJmHebIjxYzNGLAlp7OasTWBpmMG3CtKw+OC
 cxfrAw3SKkSh64DmR/jMwtU9jD4KHx8SdzPVIsns02LXAqgz25ebjXhhPdiDw4xNBO1j
 cOn7hupUtr7/OJmkLQhJSoFObFh9+no6rnudOFArh3+G9cAnWO1AE1IvGnna6b1m/xFD
 3GvVzNmAyVxNd9IoZffuH8qnyFn4XHSGkr8K5EozV3m763+3wtBkA9bzVWovrJwf3AQg
 im43YPIoRx1qQbteZeutQbb7UicepzFThCZs243bmpHalmJhEADbGBVak2+iWy0rkTCX
 kRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731078849; x=1731683649;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iz4zLuqnG0fh35dcQoPgRmjAN517l8b2XuGgwH2ZeXE=;
 b=D8Y0majFDCdLVFCuiBPASM6w+tsqlHa6UIDKSLmwrsCRA/RVWyWgDPGu7pTc9arCf9
 244CATTDeuMg51XjCTof75LBPQjV71rMUZUOjOLW3uMnApG7man14axL6A2GAwN2Ioj+
 xQtkzpufPjLV3ZBw+/wW8BDABivi77MsG+V/cPW4Jbt+mYwGjTxbHH/H78AuBkhIJTT2
 6R3/60ZBQR/jlWHjaFsZjxCrCSnaJJQDSSnWFaVPF4Ej8WMzwGB0P5rRrzFV7MECKrDS
 tY2OzUzUCYNs8BrCBGFU/bHprR+Ly3E7X/MuIfOQffUptkhXi+A1bGc3KW6Jf9C4hEiD
 VBOA==
X-Gm-Message-State: AOJu0YxGbyOD6CHCTSVb6QE3Q3nkdtdqaqhj2KrOqgevYHsdr5ShDJhi
 rre/rZoZ/HBjbtGPBaORUyltLK2kOIa5wM4QWqEV/mQxCq78sgdsyoahY/vd0mot9F0K/3UdUDZ
 V/v0ZufRq1fspncnXie7z/oJ5CbzUYecWqje3julRuUlt6ZnY
X-Google-Smtp-Source: AGHT+IGZj/4nz2L8j740u7N//4DZstGApmKU3aIOlKkBxkJt9+eRXPjPP5mewHtEM6MrTIZWjk1d7r8GasS2GEnt0Ws=
X-Received: by 2002:a50:8d02:0:b0:5cf:8bc:9f68 with SMTP id
 4fb4d7f45d1cf-5cf0a43f0d4mr2553302a12.23.1731078848728; Fri, 08 Nov 2024
 07:14:08 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2024 15:13:58 +0000
Message-ID: <CAFEAcA-ZQuyGTtG-vhRTEwpz0L4cpimNxkKix45Yw6gVHXozRQ@mail.gmail.com>
Subject: qemu-rust@nongnu.org mailing list created
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

One of the things suggested at the KVM Forum Rust BoF was creating
a qemu-rust mailing list. This is going to be one of our usual
qemu-foo lists along the lines of what we have already for
qemu-block, qemu-arm, etc, and the standard policy applies: emails
to qemu-rust should also cc qemu-devel so people subscribed to
qemu-devel only can see traffic. The separate list will hopefully
assist people who want to follow Rust-related discussion and patches
in identifying those emails.

You can subscribe here if you like:
 https://lists.nongnu.org/mailman/listinfo/qemu-rust

The list should be set up with basically the same config as qemu-devel;
in particular it accepts posts from non-members (though there might be
a slight delay on first posting from a non-member).

Please cc qemu-rust on future Rust related discussions and any
patches that touch or add Rust code.

thanks
-- PMM

