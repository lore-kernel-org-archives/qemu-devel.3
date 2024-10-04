Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2A3CFA774
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 12:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swhVo-00027P-Ql; Fri, 04 Oct 2024 08:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swhVn-00026x-9e
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 08:34:23 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swhVl-0003e3-B9
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 08:34:22 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5389917ef34so2409516e87.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 05:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728045259; x=1728650059; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QVdNkeOgocUFPxGA7Vbk+ZDv0iq0DO8jFyf2J53lgRQ=;
 b=DItSUdsghL6BiIeNpKDIygY6DpDmtObNHd3C7FfzZYcFmnmpr2pfvNxzOqPmSefG32
 V/jxAwaTOAsFB+9Doav+TQVwrgeWq3jfIH9a3ILOoil7u1HZW2ySpY3nJ55bAiNnvQxO
 15TElWjhZxsyf8MhR7EN7dSReYRxMqEESASATKnPOkjCJGIWFiHcGfGuQtgwa2HAYfms
 P69aEbgaWAC6HuUBBDDSek8Wh0+cA6r7GkxGGgNOmycFqyBI3WNW0bZmnElec8UBAyOd
 E83P7/F8vd8OD06Jx/yn2S7i0WKes/0KUY1YIKC9hz0YoIrIur+SZa3cbRf01yvbm1tb
 kVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728045259; x=1728650059;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QVdNkeOgocUFPxGA7Vbk+ZDv0iq0DO8jFyf2J53lgRQ=;
 b=tSzMvDy7p3NtcyL+Ru5+3WYc3LWmpiUMTHV5m5B3g8eI5AT0BcgIQp4PN/ayfOq9zf
 tTbShH7ddXnMNC1QjLj9bhXcNnkG4oG8/Zims4AAasaxehp5Ra7afi5f4QF5gOh/c63F
 HqArX4rHdJ1omTxEJXjWXRm81mD/TDLFZlzq/U7Q4IXOlB+HzzFnw/CMc7ezHlkBuEwO
 ivT7j6epygVn8JUfy7V+Nsx9ut5SH12xxJulx/7nzTcfNNK7dShmusmE0HlV4cB2VldU
 k+VAUUDfeRCbKoUMiGk1HrdXvfc4gQc2MjWMPWCWpt3GOoaYFFaiJrgWfVNGt9iJoDPJ
 RfWA==
X-Gm-Message-State: AOJu0Yy+mnWxt9sRXXC+QpyGrstRo88jYBJ4xcLoegNi2ySAHYumjBrM
 8iSqhc2DZQUuYLt0RV7jYfXWeZMVetVEeLR4qr6LS11gZtpOTkJVjrsk6KoBfIL7yCOJy5tB9cn
 TfVCYKTztDcN5SSZQrH8Rn3Ed58X0WPdf5rLcSwjgvZWlqwqP
X-Google-Smtp-Source: AGHT+IEMgRD9PA+YNv+3ti2zGDnfJ8vABlqcajuotQTkob2Vv4ujAZfxaNa0/Llk0dqUT6P5GKjEffkw9n9kizMRjiI=
X-Received: by 2002:a05:6512:2254:b0:536:52ed:a23f with SMTP id
 2adb3069b0e04-539ab6d8ff3mr1634887e87.0.1728045258911; Fri, 04 Oct 2024
 05:34:18 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2024 13:34:07 +0100
Message-ID: <CAFEAcA-ppLVFejd_zQH80qWWTkf+pBo6R4zvCLWaTiGQMrcCOA@mail.gmail.com>
Subject: proposed schedule for 9.2 release
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

Here's my proposal for the freeze dates for 9.2:

2024-11-05 Soft feature freeze (all feature changes must be in
           a pullreq on list by this date)
2024-11-12 Hard feature freeze. Tag rc0
2024-11-19 Tag rc1
2024-11-26 Tag rc2
2024-12-03 Tag rc3
2024-12-10 Release; or tag rc4 if needed
2024-12-17 Release if we needed an rc4

Any objections/suggested tweaks? (I was about 50/50
between this and moving it a week earlier -- the
rc4-if-we-need-it date is getting uncomfortably close
to Christmas. On this schedule, expect me to be quite
strict about what goes into rc2/rc3 :-))

thanks
-- PMM

