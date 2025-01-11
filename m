Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13614E7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 08:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWWXH-0002rO-7f; Sat, 11 Jan 2025 03:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWWXF-0002ql-8q
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 03:07:57 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWWXD-0005eq-AB
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 03:07:57 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2166f1e589cso57568395ad.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jan 2025 00:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736582873; x=1737187673;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v8cNyBdobIkz0QyaNuyQLNKJ7RJ2RaALxJcA2fyRj8Y=;
 b=lwv6ceS6lsQb3Xa6JIY4ORZ0Zfatct3755FbnDk8OCJ2EERIzE02UMiAiBUyqtlzk1
 C+hIDFIzwTr+J50tGtjKWd6acRyvqMpzpln+NdvXD3WE0lKLbE+JSwf0s36ZGdA1TUxN
 hFZmj8fx/eQC/Vt11wAyC4yKev4xKXvr5piupaEtMTqKV0Q6IW8iVa84PGwj9r38j6aR
 bzeDAEMzg14m7qGAEVHdO8csO8eZTedA8glGILFnEyWv3xsQnLM9uP6ytxpD+/J7mjM2
 F8KdbiIfIEgTlXO3owPK0bR4PJIPl4370XyLXOcFXu87B5bZwIE7nk1Mc5gVyqsAfT7N
 SSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736582873; x=1737187673;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v8cNyBdobIkz0QyaNuyQLNKJ7RJ2RaALxJcA2fyRj8Y=;
 b=GnWqOxldP28gko1Dg9480ZxqPxmgF+5Xf1/dBb1whMzJLmzzK7oS/CP4TzXK1Yjy3i
 SNlMe/EHj0dwBpVliVND6k66GkEa/rE2vAhsLHnFccTt8Lksf+69x+ynWaLwEZSuQZ/u
 JtJsZJMEHuAZmzaNA0WBLXoTrOOo5GaLLZv582pGEtjXf1P7AflGiITTz2UdbVeReCCa
 2z6zzkVbWYARhIpaGclzp6ffyl//q8tYdWgzUMAkq5pgYj3Uec2DuNdY23FEcflOxxxA
 KLhC5Inj838yZm46Em+dphfd6AzkRgOJprliAzWeZ0MimY5z61REOoRd/UzBNx08Hcp0
 5wlg==
X-Gm-Message-State: AOJu0Yw6DjQkkhQK63qGjfkLtlxYRWLRVNhHupxoGgyLyDWn2Wee9LNm
 I9sjeQC0PIwfh9qojRtiUu+P3EXIGTGtXj8c0NNJHGpiY5MJrdX4dajHx+K+rpk=
X-Gm-Gg: ASbGncs9aVJ65/54L811cDKasnvtqt27btCL252323w2YtUuyc2x/q7U/Q2ZI0NjV7s
 U8yBM8xiR7VCHMF2lTLS9HeUOyeWUWHDtmYiOMU7eDg6kmhlY+wLSTqLXECiz8Bx0198D7y8fYb
 mf50hZ/GyV/9icvRbM5lvXCP2ouo38uQwwmjI6/Nu20fuvMsVh7GdhRNG4FvyEY7B1QhaXBNrO/
 7mMDHuRrkm12fj8QT4+n/6TsI2qAk5ARO2iajfvs0FAQYU6zOe1AM8/WEI=
X-Google-Smtp-Source: AGHT+IGd0plujXc1VHDoGQQ0bwk1fnJC8kJ0fHvIuEDg9za+r98Q+6wONuIjIspyRa28X3pIupsmQQ==
X-Received: by 2002:aa7:820b:0:b0:72d:2444:da2d with SMTP id
 d2e1a72fcca58-72d2444dacemr13233902b3a.9.1736582873530; 
 Sat, 11 Jan 2025 00:07:53 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72d40569fddsm2571701b3a.39.2025.01.11.00.07.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jan 2025 00:07:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 11 Jan 2025 17:07:48 +0900
Subject: [PATCH v2] checkpatch: Check .m, .build, .hx, .json and .plist
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-checkpatch-v2-1-db77a522ab6a@daynix.com>
X-B4-Tracking: v=1; b=H4sIANMmgmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDQ0ND3eSM1OTsgsSS5AxdI7PURMsUC7Nkc7NEJaCGgqLUtMwKsGHRsbW
 1AD6ecZ1cAAAA
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Check more text files: Objective-C, Meson, "hx", JSON, and property
list.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 06d07e6c225c..94ac5230b48f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -12,7 +12,7 @@ use Term::ANSIColor qw(:constants);
 my $P = $0;
 $P =~ s@.*/@@g;
 
-our $SrcFile    = qr{\.(?:(h|c)(\.inc)?|cpp|s|S|pl|py|sh)$};
+our $SrcFile = qr{\.(?:(h|c|m)(\.inc)?|cpp|s|S|pl|py|sh|build|hx|json|plist)$};
 
 my $V = '0.31';
 

---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20250111-checkpatch-26ea9d86c76a

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


