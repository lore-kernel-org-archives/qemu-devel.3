Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8CDE7FDD6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 11:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnExS-0008Hl-RW; Tue, 03 Feb 2026 06:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx8-00081v-MA
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:22 -0500
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx3-0005CU-Sp
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:18 -0500
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-b8876d1a39bso780093266b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 03:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770119532; x=1770724332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4p2xjSQh41Ag5LxVuPwppS8kSDsK6cwuipOCAHLv74=;
 b=xrAV/DZLQFYUJ4F2ROtfldJxJsKbB7I40BkDMDisQGwzAoZa9ugvkDXnUAT7m+DoJh
 RU0O0YG9Bbs0MFyTLcBaSdlbJq1u6U+oPoN/P2ny5w41RP81pYpMKnF1OktnS3KiamWg
 uPFtqiZbZv/neTvRUTcOBY/bNzpEi+Y4iioYw+7oanOiUxmtnvKKQKP+cKfLddddByrv
 pBT4SfLr0CD3C8M3EAR5jZPTPAxEPvONud2XT3tdmGSnj/ajRY5BGbweFw24qphIxtrA
 n4RxSXnWZ2LXu5uls6y3RU1c6BhX1/Z2yILhFrj0YLegyjIdFOo0Ikk3/hLQebdVky1y
 X4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770119532; x=1770724332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q4p2xjSQh41Ag5LxVuPwppS8kSDsK6cwuipOCAHLv74=;
 b=IpOj38F5XHssy9JhMrpKwmg4tsIAXZWkgrAdoeE+AvWYrQsbWqlt6kgenQd6flm+yq
 GSeuSSQ6XJ1qGgJdGqdlAsGu/SuzithnrG4N/ZfSgVxx0iqUS2xNPD9hRXazJuGVcu0y
 D/yxSsMHcGQpaxWhZRFgZi1T00mdtIcZA7nRrzWOvPZguAmNcW4fMCpV/cmIK4A+oXO4
 wpKe01LTSRU0eKGQh9krybl9upBew4ZnFUppqOpOyQ87Dih1uJAh90b1vzwpP1/taaAx
 vQDPw0jNz6wshN+ldGy82Ro3Pvyy4pdmmjuIFlYF28JM6cGT2+IWxPQYezgclEEmIIf0
 scSg==
X-Gm-Message-State: AOJu0YxgCkWBlbuDSMAzDzoORBzeza6w3LlZPkt6PUXU8uwSv9ngG7Xz
 fG13HMj0zuuZURgsMBsGUYx/pNTPrXhKLsbj+Ry/IQza676k2qmAbzXWE9LTMqRHTAk=
X-Gm-Gg: AZuq6aIf4c4VMPBjglj15RspKWFUMWhlNHsk+xXDBYrLg5/uVn1vvL1iZTy9rqLc5g/
 5Y0mR3wvknpfGw++n6oJk5swPm7Y29Fd3BBdFhQ2H+pt9JzHTu0YLvhltARoroXTMbT2dI4zfhU
 eP8PnZJleREtUOJ2/2RiEJLJszcY+ooPGCHLh731LDTCpSv2xW/rnAbH7WWyGrOVvFruo9JIxVB
 4XK+XOgHydXCG0YMWpJ1th+XxwDd+zbb6VbTA5cdCc7bHGZTA/ObmD4IXy+bgDcdSpjnXzGEYxE
 wraPbtvgC1DuaHCFBflePVONTJp6E2DNzzWrDL2oHdJUd4JENqpBfOyyAXvKK3D3dnxzN0XcPkv
 JOhhceaKlWUB873Aqf3T+PwnEKLtbTnHoEs6NbajMDWpfC6ltK+yDwYz29X6tRNoD8DNpfnKxsz
 va3FcIvqNcf88=
X-Received: by 2002:a17:907:7fa9:b0:b8e:7e21:132c with SMTP id
 a640c23a62f3a-b8e7e214381mr246135166b.59.1770119532214; 
 Tue, 03 Feb 2026 03:52:12 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-658b4691e78sm8931802a12.17.2026.02.03.03.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 03:52:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0AF91603E3;
 Tue, 03 Feb 2026 11:52:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 10/11] include/gdbstub: fix typo
Date: Tue,  3 Feb 2026 11:52:00 +0000
Message-ID: <20260203115201.2387721-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203115201.2387721-1-alex.bennee@linaro.org>
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x642.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/gdbstub/commands.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index bff3674872e..989a95c33f9 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -50,7 +50,7 @@ typedef union GdbCmdVariant {
  * '.' -> Skip 1 char unless reached "\0"
  * Any other value is treated as the delimiter value itself
  *
- * @allow_stop_reply: True iff the gdbstub can respond to this command with a
+ * @allow_stop_reply: True if the gdbstub can respond to this command with a
  * "stop reply" packet. The list of commands that accept such response is
  * defined at the GDB Remote Serial Protocol documentation. See:
  * https://sourceware.org/gdb/onlinedocs/gdb/Stop-Reply-Packets.html#Stop-Reply-Packets.
-- 
2.47.3


