Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A77ECA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjzax-0007re-TJ; Fri, 30 Aug 2024 07:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sjzav-0007qF-ST
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:15:09 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sjzat-00071N-Rp
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:15:09 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-374b686d62dso162203f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 04:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725016505; x=1725621305;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yUlFBuHssOtjZZroBCckVNrjcV2/EFHTtnV2x/X0zHA=;
 b=gvS7HlXIfVf7sbeS5vyQ8pNpXo9Ra5wcUMFB8kDG8EB6krXLiZAS4BgYl475Hl8MpG
 caHQsuOBXVVXvQ1FDdtMC2GhrI17iJ1Kmtasqbl9ef/bgYmj5JmagREa34lGXyrOkJfZ
 18j9Za6rSkmqqMffnT6sJumjlsD5AtFlX77JBmWgxRk1imvm0YSemfCf89E7lLblSaN+
 I+CjzylQqc6zgqsdPs95FtxR0h0hoXKLhzdfeBIWOCLX4BiOTidefSW9DapKao1uDebo
 +FykGMh7L7a84tfoyxBJXKnv2QN3qze9cg6Dc+2VMe82e93qi1/GApgTMVbWYdU6vEB+
 Gk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725016505; x=1725621305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yUlFBuHssOtjZZroBCckVNrjcV2/EFHTtnV2x/X0zHA=;
 b=qyPjmjQRXJqJh89/UJlz+K6jGRfrdCryOVM3XJRslzUo6MJSMxBsV9eaikxJ2dTl6y
 Z1TdBuibkwt515KuJRbEijswp/COiAqo86t84Yae3F9OgOMdVYX8xTh0tTfXnZpYqqbh
 86CzoJ/ji16BUw5oBiQxlqthgrKIMM0YBDZtaTwjm7ePgVCKsc38d5ngaUOfqCcvesYV
 igos/km346irCvY5liNfGgfaeDnOcgXdR8xqrK6+h+EUWlV6JP1t4faIhWFK/eX68Li2
 qr6BT7nuVFYwbB87riOTIW0cmRYN99sDErz2PMToLW7KADZDyGHO3RRAyODDxdICmTpn
 o2vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDs+YqCzMJghuixDbFonF3Vkvn61M/lM+aNHpBthkWVMAQ3leGFjx+COx7ySHPGHXfyqW0OIMOJuRR@nongnu.org
X-Gm-Message-State: AOJu0YzhxIAPQXhx0AVcqZevu1ZX3lm4g4tHyp7nFo+tGeaC140Vo1Yo
 SNlW2T3cFAIHkQ5OdeAzTOuR8c1b6ukzHMrfBjIyoP28C7mKcSlTEre+4QtS6CM=
X-Google-Smtp-Source: AGHT+IGyVgynwV+5+Y2wcn7XC1UU6b8AsZ9Y+7lLOwLJL7XUMSWfvF1IUlZIVoQTs6/u+QphpldMJQ==
X-Received: by 2002:a05:6000:108d:b0:371:876a:a98a with SMTP id
 ffacd0b85a97d-3749b5577e2mr3825342f8f.14.1725016504348; 
 Fri, 30 Aug 2024 04:15:04 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee4a590sm3713859f8f.9.2024.08.30.04.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 04:15:03 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/2] oslib: fix OSes support for qemu_close_all_open_fd()
Date: Fri, 30 Aug 2024 13:14:48 +0200
Message-ID: <20240830111451.3799490-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Some OSes (MacOS, FreeBSD) were not correctly handled by the original
close_fd() code. Handle them by fixing the path for self process open
file descriptors location as well as sysconf(_SC_OPEN_MAX) potentially
returning -1 on MacOS.

---

Clément Léger (2):
  qemu/osdep: fix current process fds path for other OSes
  qemu/osdep: handle sysconf(_SC_OPEN_MAX) return value == -1

 util/oslib-posix.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

-- 
2.45.2


