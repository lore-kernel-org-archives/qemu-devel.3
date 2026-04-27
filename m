Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208BAFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHHBi-0007wO-6N; Mon, 27 Apr 2026 04:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wHHBR-0007sX-UD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:19:18 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wHHBP-00073u-Bx
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:19:12 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso103401665e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777277949; x=1777882749; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bz5o5GjKyVM+0WXB8yNy+1xTOMdyEPr4cgc2VhCqTI4=;
 b=YnrJOOF1jE5hdTgm8BZxXzz8PlEhf1SVnJHsyEig91bXoH67lCSKARE7YrvQ80gz7N
 qrXUgC2BQCKin015dQQzsmOIpNxBOD30qXW0GvaftjtlJ1i5GSXO0nUGLgONYaCc38Ft
 VGQdxPM1BKC9XpMqmZ3g/GYP4Cw1b2EvFSfg9FwiFTcEkvIxDkI8mUzB4BU6N4RdR3+D
 AA983RiCUry5e/u6brVlfH9II7GSGrFMib4s0y42BPai9UTDzUFHyV0dXZ6+xF+lmPNV
 qKQJ2q2W+WwFQAn40cN8iKmR4J8XmCvtgA3n6U+YZZxH3dktYLBC174nBJR1vzLb6j6R
 jiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277949; x=1777882749;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bz5o5GjKyVM+0WXB8yNy+1xTOMdyEPr4cgc2VhCqTI4=;
 b=Ief5pjVgeBdwPpIhsE5TMiwGHMm9hgqYrjOdwpmJyAWPvVQBruMmtkcK5165FxUGvr
 RFncHj3dK3yGjmfgIEXf6XK6QVtfEhFXEhhd5XJq5GK2sWsWjtoJv7tw0TulQ9uGHruZ
 jMi8MNzpvwwaPOIweu3pE56oV3F0bky6CJ7jdv3eSzSnKpMsM+m5dNp5p5dKi8xdvYLY
 FvCOhPmk31lxEuqAOAeksqN5tS0/qezqdvHzlsS5QYa/xAh+Qf/IOmp1Zo3wnjs3yQqf
 0ufZJjw37KOZ3EH8kG+UHzO4wczE1ie2NkSKmtvxfGGOneBo2naC3Il/Ae9tVQD8WZKT
 KwAQ==
X-Gm-Message-State: AOJu0YyU/6ZPv/ZOi4//Zksbmt8FB/7cb8ieUlHGqNZXjzcxfTuLjyhZ
 n5eEVEM3Mu02C/wt2I8SVo2lEGWRULQG/jc6IOvt37/m6BdopGetLE1+GNyaBByg
X-Gm-Gg: AeBDieuj5K3egtkjHfIOZGTv+v+beQd39O3yNAIJt1g7bCfOQrMD4eG+cdhM0mtz6We
 HIIqOfIGpAtRS6iXQMJ8GP6cLyuO4zPYkO9VYlt12v+eFG5bFuVlNeE2eT4N+jqLQ/jViaXWjzz
 Rmu3mXzkof4xXGMmrSVyzGjPyNxE6mxZfPPD7rVKZ4j8s+0SMVVTGvAizYvMWZ/VD9bRbYpM2sN
 TVtirRLC51TKk4zOM0S5a4ewmyAtmlTr4UQzW1qtDPqpYBdUVvoY204rlkMAwziv+AqXgezUqNV
 ZAnCHT5dWUP8nxHAUZvxtkosZojnvkC5uqGBYrBZ9rvVbw3RRupDU1ducWeictLTurRkMNjS8Xy
 hfhiYE18XT7pAxdzeyfRTquGdk/W8qZWWTfH0pY5VeZR3wrIt5KOk7f4h2ztUmpg2oxRMPJq2Yj
 iJ9b1Yy6hXHgEfWegMA35Ampg3VSh5WCLeB8kQd40tYgZqdxl5QZO9F7KMWIIJK0nSWg==
X-Received: by 2002:a05:600c:3f10:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-488fb753c9amr566314045e9.10.1777277948716; 
 Mon, 27 Apr 2026 01:19:08 -0700 (PDT)
Received: from smtpclient.apple ([5.32.173.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffad20f2sm392179705e9.0.2026.04.27.01.19.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Apr 2026 01:19:08 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
From: Elisey Konstantinov <elisey.konstantinov@gmail.com>
In-Reply-To: <73E79A4E-C0AA-499C-84ED-81FC5C1A8972@gmail.com>
Date: Mon, 27 Apr 2026 11:18:57 +0300
Cc: mark.cave-ayland@ilande.co.uk, berrange@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, peter.maydell@linaro.org, philmd@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC5DE7C2-924E-4690-B12E-4E33BB118BE5@gmail.com>
References: <73E79A4E-C0AA-499C-84ED-81FC5C1A8972@gmail.com>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=elisey.konstantinov@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Update:
Maybe it=E2=80=99s system libraries like GLibC?
But then why does the build from source work, whereas the APT build =
doesn=E2=80=99t, on the very same machine?
Mind you, I=E2=80=99m not very good at compiling, so.. but it seems to =
me that perhaps the source version of QEMU is somehow linked against =
more up-to-date libraries than the Debian Auto-Build version=

