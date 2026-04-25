Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035D7FF8862
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 09:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGZhx-0002vX-4y; Sat, 25 Apr 2026 05:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wGZhv-0002vC-65
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 05:53:51 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wGZht-0002Ay-J9
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 05:53:50 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso60424515e9.2
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 02:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777110827; x=1777715627; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9z17fTDH+T/FKwuycHj6+pFzs8DH9StMCPv2WiQ2rUU=;
 b=ldjzCyF6896NshLAHsONhIO7xXgutMQv3PTG8N5loiFfSAGkgcRDE3uyr8ZlDA3YJ8
 3PlpYMmX9PLNkTAtWLEVIteXvQJ6dA/5bl/+EV9NzxByBX6DUYWdqV11fp1qWsExfwzA
 Svlgkq/Z7acr/oaEUyBRGjYwbpfGTwcYN+rBxeiEn6Sz5yK1lKa0GP2B78+Lc9M5aYYZ
 6anpVY/AySg84nlznwZp35HjZ7a7CpEd66JB53D7r8ILIj+lXoXRGDfTnZVRCYuQRwnS
 ynBrRNJRr723z/rigkks61L1ELxf+yqSXdeViBjz1gbg8/Yk1VssR43Cd89XzxBmL9tW
 Hnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777110827; x=1777715627;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9z17fTDH+T/FKwuycHj6+pFzs8DH9StMCPv2WiQ2rUU=;
 b=MZeN7Z2McVHMcmVWNfqFFMiYgax1RBeKzfXwDJRz47mad7oNEKGh/xfgqY7YQsBZ54
 YuG6SnXhvOXyl/ExsSNCG64HgMJM1gKcKzDzjVNsWeVv4FVn5HVXZD5f88dDpJAYLdDD
 WygeGiLMcgmIPawE+nSSLZDA1HoFBxNvJ32Qt9uf23NQ0qH3Z0CsEpjzddek06b0814c
 C234LyssFy3MFL2pRUaOPE1cLdhqzmKbXaYCLuyNKc8R5a0seITjFTLrsIXSYlTSSEiY
 lOp1X3MyGC9nbO9vZzGUTWLcUUW1od7+ijELPg39z/JeEyNbqc7I61tqpUwORdC0590D
 OiIg==
X-Gm-Message-State: AOJu0YwrpXX56a0UYeHt3oOi0WYba8/P/P/XaCpsyONmqf2YtOyCLm4G
 cA3SetV+BxcRjXD9TTOh+qPnWV2AwgxdODYlUrluPDzdjDy9o+aBSn8t
X-Gm-Gg: AeBDieveZeIA3hcGcEt2JKexuqulcQE6F1CmcT4MO04j1ZTNWBxy3plMouVeo9liq7W
 cjurB49BgbFwtUJY8IU0twxF/KWHAD57xq04SZm+acVs15AE98AWWcejtNygGhYwOHTC5oh27Z/
 tIS9B+lYtT1euSrApjHQ+StOiYih43nV06PNYb1eMU/pSgarcsMTZZXJ0HRHXV5gcDJ7kSUPc91
 OS/RzeOJqvwtW5iRADbC6lG9WA1iOxwbcZ8yPJ3GofWhFhvd4CL70Yc6/ztwM4uTV2fUbGZuuSx
 N+aM1TS24kD9lAGQ9yYELT1j37QEITGSWNs5d9qz4uxS2wbvH0AdEXocVMflJcC04tnGfzHkMCf
 T00kkJTygnlFNsSHJfLR0Lr6yKWBtEkCZCIhyrXSQN9DwNQJXHQtC6IMHBYEsBKnhavS2P+VetV
 0fWzGitW3pSe1MSRgxMvdQBWr20wwUBS4DZORmH2Y=
X-Received: by 2002:a05:600c:3006:b0:487:1108:48b8 with SMTP id
 5b1f17b1804b1-488fb739f86mr279424235e9.2.1777110827311; 
 Sat, 25 Apr 2026 02:53:47 -0700 (PDT)
Received: from [192.168.0.10] ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc0d51sm67574574f8f.10.2026.04.25.02.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 02:53:46 -0700 (PDT)
From: =?utf-8?q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Subject: [PATCH v2 0/2] Fix and re-enable GTK clipboard
Date: Sat, 25 Apr 2026 11:53:39 +0200
Message-Id: <20260425-gtk-clipboard-v2-0-b098f3cf69cc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACOP7GkC/3XMSw6CMBSF4a2QO7amrYiWkfswDPq4hRuBkpYQD
 enercwd/ic53w4JI2GCttoh4kaJwlxCniqwg557ZORKg+Sy4bW8sn59MTvSYoKOjnnnlXJGXLT
 lUD5LRE/vw3t2pQdKa4ifg9/Eb/0nbYJx1hinFN74HUX96CdN49mGCbqc8xf+5Sz5qgAAAA==
X-Change-ID: 20260425-gtk-clipboard-fdf99db13ac0
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jindrich Makovicka <makovick@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=makovick@gmail.com; helo=mail-wm1-x333.google.com
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

The following patches change blocking clipboard retrieval function
calls in gtk-clipboard.c to non-blocking variants using callbacks to
avoid UI lockup. It is a follow-up to the patch proposed in the GitLab
issue

https://gitlab.com/qemu-project/qemu/-/work_items/1150

This version adds a similar change to gd_clipboard_request that also
uses the blocking clipboard API.

The second patch removes the gtk-clipboard flag, keeping the GTK
clipboard always enabled.

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
---
Changes in v2:
- Removed forgotten gtk-clipboard comment in meson_options.txt
- Link to v1: https://lore.kernel.org/qemu-devel/20260425-gtk-clipboard-v1-0-6bd99e708e14@gmail.com

---
Jindřich Makovička (2):
      ui/gtk: Use non-blocking clipboard retrieval
      ui/gtk: Keep GTK clipboard enabled

 meson.build        |  4 ----
 meson_options.txt  |  7 -------
 ui/gtk-clipboard.c | 47 ++++++++++++++++++++++++++++++++++-------------
 ui/gtk.c           |  2 --
 ui/meson.build     |  4 +---
 5 files changed, 35 insertions(+), 29 deletions(-)
---
base-commit: 4bde339ecb41b16e90810233ba5ee2fa87bd443f
change-id: 20260425-gtk-clipboard-fdf99db13ac0

Best regards,
-- 
Jindrich Makovicka


