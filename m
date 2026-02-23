Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB54EC110E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZg9-0002aT-Rk; Mon, 23 Feb 2026 12:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZg7-0002Zr-Nm
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:25:04 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZg6-0004XR-57
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:25:03 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-649b1ca87ddso3984923d50.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:25:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771867501; cv=none;
 d=google.com; s=arc-20240605;
 b=TsRRv7Qmsf/raw93fG/I2hwTYKe6XlMUzZSCB+ihWCENpGwhoc2bL0DjHnJWPjjibd
 PS3b8u22uRhfHjMTQad36FXbNjYdjOswZnBfmj/H7/7XZwPw0NZXGoMTPwu5b1RsJ+YI
 CKsKdrWa/RxwNTsOzD/3kenxBH2DbGX+BmWPNyhcSWi/1jFgU1ou7dEmSO/lpI//zFqM
 XBIfQRzH0QaGve0ZC4CdXZN1savOfeaJ0IsMU99s07YlnOjeacqSASIsEbnmUDaSQGYQ
 ht7TjbTSeWf0BjTXUO+nh1ti5EHpvhnLlj8uoogviOY+iv22zeRhYuyzzf14bS8B7jEu
 ce7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=aF4nLYer1W1Plh9seuNY1nlMdTk4JdT0Dd9anPkXhLg=;
 fh=vhHRca6DjLNIDmBO0eNpW6l6b7rpPbRHjL/Jym+cKZo=;
 b=BWktpr5ga0wl0HmSG+fi1AGqlu+nWektPwCc7Fg58h59tYNTxiQbGxUSCFElVbY9g6
 U2PYH9Q646NsQlbs9vnORy6bZNmH5ov1/hRbA9y01vsKsb4+DpSGwYbvmjMQUcm2muDF
 vEVhg/MVRaXspAGbYx9WIjCFe3Q2BDICM/m63UdJxi70aSmF/4TmZnczEm6tgkJ1ITAH
 sdQvFT9zV+k0c09sLdgvHp29VBpDfj5SlvmifVLaZ3lBL54ebZNgmQ2aH92F9BEvgL/k
 05kqu1wd+PjO+JnNDFMik8dQ8O2KnfuNVFBlvLH0kByhMoYH69ZKhEbGh8XuHukSLcHX
 Helw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771867501; x=1772472301; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aF4nLYer1W1Plh9seuNY1nlMdTk4JdT0Dd9anPkXhLg=;
 b=mQlfavWTMAvLLTQ6t31Xrm4XrF1gSMSH+j76/Cvo7BmgqNuH6r93PaXXVeBhdk/wHm
 5FyBg/COUjpL3SwZnxj5XZPaH5V5E/Xho7xBJEXJNuvsu6P4hR3Z2jRWwYPMfImeCh81
 ME3m/Km05KjAsCWyZvcGoh9BQqV0okhyvXadFOuibuTbhijXXfo4xc3bp2E3N/9L99RQ
 /PNNjI6NTg2pM/sRhQ9G8g30iwjtKox7tahRmHh+4bTPdyCjUEzEtiUzYm+N6IV62OgS
 FJWKeBugRZ4AqlkEfKwhQ+RTfrmu2/k9/9zVox34Qm1sg9cO91i5pzdwb/HXsF7OF0sp
 6u8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771867501; x=1772472301;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aF4nLYer1W1Plh9seuNY1nlMdTk4JdT0Dd9anPkXhLg=;
 b=OSlrj5RnoYRbKlg/CktNlZgqi2TejGWUy2blIphfUZlL7Bj1ZFdYFhoKSn6Q3yOpiM
 7mStzEfOCGt9bjSg3Szzdrozf2E7c4/8m2M+a20DPxNaWkcbpaJIn+nvLFtbtvFFbTgl
 ee6o7Q9IojQe+nyWFOfWf/nLFPZ7FCv2BH9uETSX1Rimpa811tLSkrjI7sl1UUS9flg1
 TfO5IjNGWbXmLAACitaaQvVN2yMan5Tvr4qyeukxy4miRpAdSoqC7c2/GHO820qk1PkX
 QWqvVS7ET0JKrueKbu9pxEdHbf8/QglQY58pqHTjviJobXrd83kr8i8gYg4iKbqN+GkC
 yz4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtw7wznQvol0FQ9ODl2Cff4BnN2CrVcJL+qNinTHh9atWyk8WQRif3EMUoPzynHME7DPklDMWznX5h@nongnu.org
X-Gm-Message-State: AOJu0YziEBfhQrf08L4rdzeF58NTfO+5V9KSNFee+ZVvN60dk/PVcgap
 e8CRZKMzHhCoqoypC5cobS5sHds5DvxteZf8JCIXPWMrze4/QcVvrcQE0VT4PBZYVItyZC8kKbc
 xNA9HgvoObp+MaacBYjkS/QltELEJZLerluBAtCG0twyL0HrfoTpMpBM=
X-Gm-Gg: ATEYQzw6vTT12zSZIVDuo/Y9OoVoxW8xkKsaxCfK0oD+npCLgYjvQi/AT/2QFmZqdnF
 DhMMU2OOyzmA9kb6WPkaypK1p512Izvg3faOws26evlrHUnHDm0KUL6nZt8DsFBiWxnSr8J8JOE
 pzAiLBD3yrm94mwe53UJUTVTiA5+jTSrTo67gvnNkt+hr7+4CIJR3/JZywcMhZKFySFpMsbj8TS
 KZ+SDIzHWIlDwErJUjgUkt/LYZaoz5JjMZdqaun/3xhrxbuw8l1JQDPPLTuWcOKWXRnBCc2i75S
 X4lb7cDWKALseF1GoRF91ZeIb1FcAB0qcRNWY4a7bx+7aRh0BBsPImRrIl0lTUbtH8s=
X-Received: by 2002:a53:c589:0:b0:644:60d9:7514 with SMTP id
 956f58d0204a3-64c78f5ed96mr6173581d50.88.1771867500689; Mon, 23 Feb 2026
 09:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20260223170212.441276-1-peter.maydell@linaro.org>
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Feb 2026 17:24:49 +0000
X-Gm-Features: AaiRm51f0kcYPGySN4UXNcplzCOwp3QbERK55DXkVz-N5xuOxveUSTJWs1XpaTA
Message-ID: <CAFEAcA9ciDOcF-jNa84QKxGFO27qgzpOn1TVVC+M28T_Ybh2MQ@mail.gmail.com>
Subject: Re: [PATCH 00/65] arm: Implement an emulation of GICv5 interrupt
 controller
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Mon, 23 Feb 2026 at 17:02, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset implements initial support of emulation of Arm's new
> interrupt controller architecture, GICv5.

...forgot to mention, but if you prefer a git tree you can find one at
 https://gitlab.com/pm215/qemu/-/tree/gicv5-v1

-- PMM

