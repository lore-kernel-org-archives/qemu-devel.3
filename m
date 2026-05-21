Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D77CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1LD-0000tk-Pf; Thu, 21 May 2026 07:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ1L5-0000tV-QZ
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:13:20 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ1L3-0003H8-Go
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:13:19 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so84746465e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 04:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779361995; x=1779966795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzUL4+j/hUs7gdHs8noVX7LzKE0nxzReYCZAT/zEFsU=;
 b=jxpo3Rw138xaaKBZ67Bk1pZtlGyEBkCVw+WoHuXdxESiM/UF1PlW1jXj01gp99bqP1
 WGdYMVt6X+GxPyZ0oCFCofPsD0+qt++DA/dMUo7FNApxdsh/w6tK93rsB1hOBfdQfq9H
 0raAa/9zi9YP+DEZfSTkUkqyruum358O1ARLtW8+NsEO684DriHPVzqqG1GDtLuS7bBm
 txZ/uL7VA/moqOo67saeorZn7xRfQi1lj4R9VBch5u6hlPaRDxwKPb1KTZNSo9DQSm0u
 cmS3KbtHp+1JtxiYQFfLe1wpkwN99HYuyd+w5fRvDDYybq0Uc9v1fJ8ABx9kyYE1EZOe
 ZH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779361995; x=1779966795;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MzUL4+j/hUs7gdHs8noVX7LzKE0nxzReYCZAT/zEFsU=;
 b=TiYvUC0nV/zmeAJMMJCmDR3EiHctq0J+vBCHrBe/axjQG5KnDp/lSdHiNOANwjE19R
 F4URiLl08t7PzQfPzfeBtHuzj4sy8wiVhD2wtMdt+ghIUl6mW5Xo6uKxr8cx98zGZrO8
 TXqNtO7KRV/f4sxo4OHAj/JqNN4FOY6KIO9eqwlxYGT5dpMZ6lvd00HFGDgyssibkNa0
 Y8N6LhCQOIm8Y4sMEi6BxRb1OiM+8N1BRDcp9ZXsA2+WzKwFiSI/N+xWlJuLADi9IVDv
 +gnrgA4odr6vsjKN2ZwG23FtJsvAsEXnaKkJ9glE6sUsLMAIsZS7nVq7OcE865Ag9v3D
 dTcQ==
X-Gm-Message-State: AOJu0YwIdu0MNS9AEKKGir2sl/EPINvVlEyYY9Ok1pSKY8rygj34tEay
 QYovIuox/ystLr8+DE7ICgVrpfUQZFEod0ZmyWfOYwX3vSUfCQG36laBRKDHuTXbbJY=
X-Gm-Gg: Acq92OFbZ73j75NU/Qs8O03cIJIstSD6xJzt0mk0eiIjHGjXv3vBZuffLNxGd3Sd54V
 UVJ45kHPUQ2EzgmaUe5nXk8GVdaoQ1HDKyhbkZoHUJ9NDQqIZyTuf8RzH1vBCjKbMvjcPR8sapC
 sF6rKKlGulqqfPtbDZRNXfYHkH5frg0q38yVy+R/H4IhTBhhIsKNukk7QkIe/1I4MeLqVHb3zzt
 DUJXh7angt+gi3Sbo4Fn3lIaUkVLAwyj0h83BbiCqOeJ5cc7E5rDzcZ/PkE0bIaMF3bMiJSN4di
 cz4kHxfwxMoQB6ZYopZSjlPmGxSo8F54NarBv5SbXxljNqVFRmy+EcSCBp9+edvwmIDpVVCiuem
 1M4+JX8LQ0KTecvHWtH26XeviItPXbCTu0g1YUKAZNnwLvAKdMquwCZwUjzdFLUASYmwUaUhoCy
 B4TUQiDiV6/v8/msEr3ThVvQjw2jyBrS4T3A==
X-Received: by 2002:a05:600c:828c:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-4903606b5b2mr36430785e9.19.1779361995207; 
 Thu, 21 May 2026 04:13:15 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7da426sm2045348f8f.9.2026.05.21.04.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 04:13:14 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BC8705F886;
 Thu, 21 May 2026 12:13:13 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,
 pierrick.bouvier@oss.qualcomm.com,  Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH 25/39] MAINTAINERS: Fix F: in "virtio-snd" and "virtio-gpu"
In-Reply-To: <20260521080511.999266-26-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 21 May 2026 10:04:57 +0200")
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-26-armbru@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 21 May 2026 12:13:13 +0100
Message-ID: <87a4ttow1i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Markus Armbruster <armbru@redhat.com> writes:

> We neglected to update MAINTAINERS when we moved
> docs/system/devices/virtio-snd.rst and
> docs/system/devices/virtio-gpu.rst to docs/system/devices/virtio/.
> Update it now.
>
> Fixes: 487ce6ce99 (docs/system: split VirtIO devices from the rest, 2025-=
10-16)
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

