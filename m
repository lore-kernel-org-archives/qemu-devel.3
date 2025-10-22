Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A44CCD1BC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 15:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBaSL-0000fD-3w; Wed, 22 Oct 2025 11:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaSH-0000Vn-Gf
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:08:50 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaSE-0001Bj-Nd
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:08:49 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so3755377f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 08:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761145724; x=1761750524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PpX/2+MBiez8U9HpiPaqbx+2JJKLT0Lt776CCM/DT2I=;
 b=DIeNOkXgzZFk5hc+WDYZY0cEuSlIh7lGTnkEtv9fX9rs7PqBd1jnMy1fo0X6nADd6g
 KqM2K+L97hva37c4qurt7UI5wivTMYiLAWv3PJ4M+Oer56s7NrXov1jNGjhMg6Rj0vy9
 Q+NrpEOU4Mu95Hk/Hw94DGYea57udrVOXNb/USD99AmGVdHAA1PIkpl9K0YOz9suhQEj
 QojEk2IbZq1WEGYxv80glfMOcSK2WjcArmFjqNR0gcPql4+PI8ltJqIWuyNqDfEmzJyl
 IzrOylJiaOqlNIIEwfpj1qJtSib1rN1b2OpLyIJgfNHLdUocfsNuK6gY2jejR/rHDoIB
 NLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761145725; x=1761750525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PpX/2+MBiez8U9HpiPaqbx+2JJKLT0Lt776CCM/DT2I=;
 b=kaqaimEh5k1JAFG2dfP1EdHZ/CcCie9/lEM1G2R13AlbmUIvB9ZZtTViLyneDSBL0T
 13ksT1Afxg1U6J2gmjqXfmLIpWGjnDftjvkvcwe3b0ULH4jfoOFJMccjsVszpxsQ/KyP
 HloKZ5i0TOtgTTI9ZTm6sOJwsMnwGfhvXQqoYMdEF1daO7M2alh7Jp0v2aQtfmjw+QGM
 rFqw449k+f5gb3ef4otVsh1wBMF+zHstORlEDd11RzcKVeE3XUfob16RnU9cebtY8isk
 DOc7Mb2dY0nOKx5BuaHt7bxnPF6mP+PrVef5XhlGVVDGpbGhrXu1VrLyX6ytxBYtizOS
 RntA==
X-Gm-Message-State: AOJu0YzAAkRJ/WYaJm0vfhAF5cHD9tat8ZS0r+rsp3eMsGQta2jKeD4M
 vAVpio9myTl0VDCnExHzZVTsKclal61uQKDmHGCPAw4Ul2YRxmJ5I1jrlZ72u6Xawe/tJZLyUna
 NzGtqSNM=
X-Gm-Gg: ASbGncsMoHIppFq8vHZyoFtXaZ6uqF0ZD8qtypgB55sXtezNmAG56FE6GqLJXxNPfZl
 Y+7EEQMUMg8AVj50cWlcF6QK18YRpcingJyl87DS4Rw5ziiAH1QR8ZwyzrXxQNv4r4zGBgve+2W
 mNRt7nNlArsJEYf2jD4FWm/MVVg+3eXOWoUt4/OdUCX9zjGTtfCUIsv3W8K71OvxqaPeyoivMlo
 AMwa8cd37PzNVNQ/BLEJZIc3gvJH8KM83kpM4Aag1sSt5NTar/Vg1pdVXo++CiWUUqZa+I3JMjy
 gWDAa54j+hB7lSxhM1oTGvqhxn2IoDuqMjmERE14MXaH0rWO0igLogyGnhMS1ejgD281Orcyf+N
 OqZ1a23OQlJIQ+ojuMFLdk1+6PRgu3SeN3OqY7mohaYonX3xtXdyVBxwd9q8/2MWyMxBKiPuHE/
 ppIZZMdbDeueKSdK98ih2MId9rKccMT5bYgRbEddPr7g2tUlav4rb6iEGpvoVt
X-Google-Smtp-Source: AGHT+IERgFqAfACqqNWlwvqCRXuzQNwXeYbCrLzMrra9u5d91nJQWz0Cv+yx0XAfp/zE7IFWxXHjiQ==
X-Received: by 2002:a5d:5f56:0:b0:3ed:f690:a390 with SMTP id
 ffacd0b85a97d-42704defec8mr14135482f8f.40.1761145724545; 
 Wed, 22 Oct 2025 08:08:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3ae9sm25319399f8f.13.2025.10.22.08.08.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 08:08:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 5/9] chardev/char-pty: Do not ignore chr_write() failures
Date: Wed, 22 Oct 2025 17:07:39 +0200
Message-ID: <20251022150743.78183-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022150743.78183-1-philmd@linaro.org>
References: <20251022150743.78183-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Cc: qemu-stable@nongnu.org
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
If ignoring this is deliberate, this must be described in a comment
to avoid any confusion.
---
 chardev/char-pty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index b066f014126..652b0bd9e73 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -125,7 +125,7 @@ static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
     rc = RETRY_ON_EINTR(g_poll(&pfd, 1, 0));
     g_assert(rc >= 0);
     if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
-        io_channel_send(s->ioc, buf, len);
+        return io_channel_send(s->ioc, buf, len);
     }
 
     return len;
-- 
2.51.0


