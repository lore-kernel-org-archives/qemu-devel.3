Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D933FE5209
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 11:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGEkw-0008K7-B7; Fri, 24 Apr 2026 07:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wGEkr-0008IG-UP
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 07:31:30 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wGEkp-0004oH-Kt
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 07:31:28 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d64313c39so6032820f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 04:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777030285; x=1777635085; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VA9luHJYq3IUJn2ErMjx5YSPBzZn0p0skawnDbRPTY8=;
 b=Wc5i/+1X50C2pquEcvF5W7ldBkn4w0Skpdtb6B02m6leTkFl3ykTfq0De6pqO9nOaV
 dkOgPPff/wq/QAQOmNjGBrFVzY/st4fLwZU2dsWB8muKwVoRsbysKfipn5o+giOU4CgG
 L8O2JuLnhlthsiOyJbozSLQMH+jt/Gm69RnDMpam8cFoyswp5XhmCHBExQiMuEDQG8GF
 Fji0i9qqOBzsvNNx9wsO8G9AUJ7YiExsZsJl3cKZIQzVmRZEc8JH2Oy9ts/iSrkUKheK
 79ictefI8Hd84GeUKZXpaij0M2FPUQzrHZKWxICnxc9ZWJB+LUU3vHjVIpx0s5aKXGFU
 0Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777030285; x=1777635085;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VA9luHJYq3IUJn2ErMjx5YSPBzZn0p0skawnDbRPTY8=;
 b=VW+zrtRBo/UQ1oMNKrGXyVy4AuXM+H/mMpm1g6CydfP1XqyZhdLQHYDENNSUeh/7he
 igw9hemPOZkQ14d/+WxXAnLeh6ni7Qm6Adw6TMCvpm6PjIZ2TcT39DJUtwzr6ZwZpnsE
 14fgyjJ3G54DresJt+9Fzr9Teo6Tgu8WIS5Q0VELSvmlQyRwclrtI0nILvV5Tz/mWmPL
 uI5Rs6Ehx0VufGBFkT/qNSJpJJU5L/R7rZHdGlTLb8HFry0oD/JzKdAksHYv/syO9xrH
 ZCFBmDr21JwVEwJq/TRZsSVRbs/Dyc43O+n21yNrdvZ6X6PbcXeDyi3lAHep2A2/C3++
 vinQ==
X-Gm-Message-State: AOJu0YwmvfsIpZjrV092k0oIkHwrIkYKFTVRYQRSkwiY0jIt1TCUVC+f
 CDED2SA81gqvLyhYCQVR0t1HcbUfTwFbUcrOtcrKmGSq9qV7VYdKosNn
X-Gm-Gg: AeBDietFRFhq99xjPWV9p2XBzTKU0FVC2j1Ckne291Y7w2Ty+HTh7BNRMML/vCO7xGU
 BuPS5WtTP6H/b2gYN9CkBZ8CtBbGCT4VEBTwSxmCxYmO9cssO3ODIq827m/fRmWpZk7n/28nyGP
 4Szt7pZUqzMm2crPIhLq1h3o1tXIKnIMgVGXv2kNHq8odMNxWJDBSel20aRWAQKnjqaWSM1IoHP
 fQfZkL5/QhBgvpEKpa5eacOLJnJ+9vTaJOkCBbz4nOuO/NEcQZMoDxAF7RLStrTAHLyzvs8GrJl
 Av+JxcoG64x+GZo9JWHpVxSjPRgZM9VVsbCDjlOkAaadLPjr8Yh52FaOIlWMRj/jqTGdtr9pwOe
 RLQRV+ANcyCGaJIDdCdn/p0mUmyLAMKkNokS//SMIMBCkjcl8/YBsu/Drpqikv0AJ6pVCqygX87
 RvWZy9StTTqXjprJy9yvvUmGlx4teqeC5Sjs3/k6pHpq25D3kNkNZ8YpXZPIWqVz+h
X-Received: by 2002:a5d:5f96:0:b0:43d:7d24:b4ff with SMTP id
 ffacd0b85a97d-43fe3e0ae9dmr47172941f8f.40.1777030284540; 
 Fri, 24 Apr 2026 04:31:24 -0700 (PDT)
Received: from smtpclient.apple ([5.32.173.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d6casm56227569f8f.32.2026.04.24.04.31.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2026 04:31:24 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
From: Elisey Konstantinov <elisey.konstantinov@gmail.com>
In-Reply-To: <aes4kEdQ_x8eI-m6@redhat.com>
Date: Fri, 24 Apr 2026 14:31:18 +0300
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 philmd@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4FFF1823-815E-4956-9C80-9C62A98033B0@gmail.com>
References: <616E96C0-F0A5-4A9E-A63B-3BC1B5F18094@gmail.com>
 <aeswZxFn0zMj-3jb@redhat.com>
 <06C2CFB8-BA33-46D6-9F84-B1F81A2A319E@gmail.com>
 <aes4kEdQ_x8eI-m6@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=elisey.konstantinov@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I understand it=E2=80=99s a niche use case, however, =E2=80=9Cniche=E2=80=9D=
 doesn't mean =E2=80=9Cbroken=E2=80=9D
Currently, QEMU advertises support for PPC Mac OS X guests, but it =
doesn=E2=80=99t work on Linux
for certain versions
My patch fixes this breakage with a 3-line change, proven to work

If the root cause in UContext takes months to fix, will you leave the =
feature broken for all Linux users that long?
Can we apply this workaround to unblock users now, and continue the =
investigation in the issue tracker?

If not, what is the official status of PPC Mac OS X support in QEMU?

P. S.
	For example, SigAltStack is the only one way to use QEMU on =
macOS, and it works.. pretty good
	To be clear, only Linux and maybe BSD (which I can=E2=80=99t =
test, see details in the issue) works on UContext by the meantime...=

