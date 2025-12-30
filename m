Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5430EE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vah0I-0007Nm-4M; Tue, 30 Dec 2025 16:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vah0G-0007Mw-Me
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:11:40 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vah0F-0002v7-6W
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:11:40 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42e2ba54a6fso4460689f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767129097; x=1767733897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L6ML9swyx3/50z1k31zOpaJrNweHVDBzQiceI3AV+jg=;
 b=ADyubTHfRfHlUnbFXAdFrOLyq8Eu2o0IE03Xj4fx5Ni09g7EsJ5BJmG5rFakl/eGuZ
 3K+VEsNxNVljNiA8LK41Kk7j0mP01v671VNwOlfKmMsDrrld0B93koPWvjjh6vBxFToX
 C3G/itaeV/4cyNe7SZ7nYxuGDaZr1jUaPrYvxz8RkoDZVEgIP6KCAiy08vmwrtL3VgQq
 /I54XVQLgwF0Q1pJJttMlolt0OnzmY+jSTxdicPsIU59nsGQYbgR62ZSQ+D15oUj5/wr
 LUZKXOtwlRzFFaDSZRq51JKVjtHCpVb1/L6NjlK/93BO/CIemYjS1GaaE+u/lSFRsmCs
 rB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767129097; x=1767733897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L6ML9swyx3/50z1k31zOpaJrNweHVDBzQiceI3AV+jg=;
 b=tfzij/w9oks9gp4OhCoBPywBZeS2JenTfXXcVTPB03uv/g4OqpWNBAnpIyQVu0qTkT
 7SBHNfrBsKyLn3bHANHUF7GfX1aLGqWsp8TZk96YLQbr2ssREhGhgNILBgzQZryop82j
 4C7mnKT+E/+Yhsk+e0H6n/E0xoxad2BEgTt+7FI0TOjcqAe+0TQb4I1xn5zczazGtsmv
 1r7JOHUMMV0hPiUN7iUPPvZzby3DRDSQ6Fhb0Qmy2TNe5hHC+IhA/iqYk0KCpj+ShpQx
 P/qLolNhpfq6RZCB6TiZedwLlr/QwnfJl8Huf5dQ/pGJ32MpE79wwfikL5Ix8OikIb/l
 9Biw==
X-Gm-Message-State: AOJu0YxnENUzghc3W1QbG0sNYHkyORaYOuOt+HWAM1SpZKx6k5WM4iqu
 bOv/kMT+1PsSbeVGnk9IFAAEYNhVAEptaoBA9HjueUtPXzVXdPeZE337upzZDUDzPmlW9MMvSgN
 cpkvfFQ0=
X-Gm-Gg: AY/fxX6tsPzEVnQMTTXmt60ThcJBcwJ9fCJ5aSuvIk6LQ3ufPacndB2UVHEoo4KtBOT
 8uBJwQCvF59ao2OJdsK750HEUL0aBngGF+HqrvxJZUgzafjmDUYpQz7gPLQ4jn8ynv2CwIEuvZa
 L+kr8zri8BaAfLEzsGJq3nktqNJd4OzWOpY2/OfVaQFtbDWoqapbHSU85X09SJO/AaUDE44Lf8Z
 sldjM9CJyBAHg6aN513aMF1uER5vZAA3nyXlIkwRlbbkUebR0GyD59OklCcHjAFzlbS6fzDrVGr
 xSFTG14AIZjD0XsomSBzaKwMzNkVghxmBLPpuCLhv3NYG9zUJuI1L1DmOHJW64Qg5Y/G6R66dLk
 DYQFqp8JIGsEt8YEHzeS2A9XFMIR92mf2oV+S6ZlaactmEbKIuwq71leQecA1PeIYo4wccjXvmP
 7SAFxADum8b7M9PT/WLRdCzAfxzWhj5EqtQhHKqGCnf2MwaUXHvdXO4jPAjgET+TiYPVUOPaM=
X-Google-Smtp-Source: AGHT+IG/a7SnuP7wprj7M5p94oVcAcENC8Kw/RvUxRG7Rh4yWDKYWbBkpVc1NdXqbasatAeq2LJhLQ==
X-Received: by 2002:a05:6000:24c4:b0:430:fc3a:fbce with SMTP id
 ffacd0b85a97d-4324e4c9d45mr50225063f8f.15.1767129097256; 
 Tue, 30 Dec 2025 13:11:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2beasm69062242f8f.33.2025.12.30.13.11.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:11:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/34] MAINTAINERS: remove old email for Bandan Das
Date: Tue, 30 Dec 2025 22:07:55 +0100
Message-ID: <20251230210757.13803-34-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Bandan recently left Red Hat and emails to his old address now result in
bounce messages. I contacted Bandan and he asked me to remove his old
address on his behalf.

Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251226083207.506850-1-stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cbae7c26f83..1b4fd48935d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3543,7 +3543,6 @@ X: tests/qtest/migration-*
 Device Fuzzing
 M: Alexander Bulekov <alxndr@bu.edu>
 R: Paolo Bonzini <pbonzini@redhat.com>
-R: Bandan Das <bsd@redhat.com>
 R: Stefan Hajnoczi <stefanha@redhat.com>
 R: Fabiano Rosas <farosas@suse.de>
 R: Darren Kenny <darren.kenny@oracle.com> 
-- 
2.52.0


