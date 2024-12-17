Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6890E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgHc-0004Ig-UN; Tue, 17 Dec 2024 17:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHb-0004I8-3U
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:15 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHY-00018S-RN
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:14 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-728eccf836bso5151592b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475390; x=1735080190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JC4GxJz38t3F03j+PKDd/gQkOP6CLd7q7r5tKLCpngM=;
 b=UhDz7pdQQce6uzxkrFdiVcXc8U9NjBAWc/1GiBH7tbH+h1C+xP/Ys3KhPif3k7BxKg
 ahMOCkMfgC0J0BA8ujOYvTjWpXGoXzuJ9yttF/Fh/xvUPs2Ub0gD0kASo57pKyTVhoNw
 tgupT4BrVGA0ANQtNwAg+Mmq39wvVsy/lBrummea2HacybLNcpFBZPdfS5bRhUQaGQJW
 zTnvThjv6Thj3iZJldZaaRXHq5owtiRQYE67faXCe9AinDnwyHBkRvvdTizXnNPesN6K
 jQBZbOvwVAoCwE5XEBrW5fkWPyTjIyb7Pq1tBaern2vCS8L+MS6quhUUfL/WC6lO7yDS
 rY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475390; x=1735080190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JC4GxJz38t3F03j+PKDd/gQkOP6CLd7q7r5tKLCpngM=;
 b=SbX913sFfKmR+v5uJdgYHQqQjKg1mmzaD0XozobUXI0ypTC0Z7XXfZchmuiU9CMrhv
 QMLuorvA2t9Iooyz81vrjC9v5E5qba6d60F1X89JWj6qidlJ9iPP0rmfYWuSNRDJLbxb
 viTjDY6r3sdHzW/tQes5ci8vm4S/polylOP+DT/NUeVE0CREI0So0SWwBtdE4NrGSdDJ
 pYCyQ1f8Pxlo8urjJSvl1JSx+m6BzTtg9vBhqdZl0rTU50wqIhnXrs5ncdhXnfFq1jf0
 BpjkUP2jzadv78u1WHyWiDy5uEtt6I258JEsJoFCstMQUS8C3bSkYpaV4wrNlBtBwb3b
 kmgw==
X-Gm-Message-State: AOJu0YzhI3ZFGCllyOzxWSkLtHa5AJtDlXpB194X8qmirrEB2X7d6rrU
 xu9aUZlD7F/hf3xKAXuC0Ger1FpGRFGfl4OxdAxxIicJBiK8AS7HUpiJYaRxc/iZt2O0vs2q5i9
 YiOI=
X-Gm-Gg: ASbGncveuL58r0aAO+klyLXhQrDx49ljPuKZbPO4EiMkORt8SLq8W5JKo0lDcDMFxRg
 0m/O9Yo+AXK0mXfrtOWZslo4/3nsbhKTucwaAR8VoSFzJR5yzoM8hOCLkZV8rPjDFQXubG8sqiD
 2JMFkQs9eY9t3hOArTjnnmCfz70P/sQPiSJDt0ALB0TyJO3Z+tP9RE/GrdfqT2SP0TgRGXSP9e9
 UwB8jDKB3QW+CpSc321a17psvMSosW0Mr1KK7kyQRklmaHozMlKcGCD
X-Google-Smtp-Source: AGHT+IHJpV31k8QAKjDi4oz5R5Jgde/bPz6tlQJ8cmo4qIzIyp/PhswW8uLHfkodELdcpIG/pUln7Q==
X-Received: by 2002:a05:6a00:1941:b0:725:b347:c3cc with SMTP id
 d2e1a72fcca58-72a8d2f0b7amr989542b3a.23.1734475390623; 
 Tue, 17 Dec 2024 14:43:10 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ac53f3sm7463214b3a.27.2024.12.17.14.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:43:10 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 00/11] Fix 32-bit build for plugins
Date: Tue, 17 Dec 2024 14:42:55 -0800
Message-Id: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

Since 9.2.0 release, we are building contrib plugins using the QEMU build system
(before, it was external makefiles). When building for 32-bit host platform,
some warnings are triggered and build fail.

Thus, at the time, the decision was to not fix those plugins, and
disable by default plugins for 32-bit host platforms (see cf2a78cb).

This series fix plugins to have the same behaviour on 32-bit and 64-bit
platform, and reenable plugins for 32-bit platforms.

There are two portability issues:
- we use hash tables, and use data as key directly. As key has a pointer size,
  it limits its size for 32-bit platform.
  The fix is to use pointer as a key, and point to allocated 64-bit data. The
  change is pretty straightforward for concerned plugins, and does not imply a
  memory overhead, as hash table entry is already heap allocated usually.
- we use plugins callback data to pass a pc. This does not work on 32-bit
  platform, as we are limited to a pointer size.
  To avoid doing memory allocations, we simply we simply use
  inline operations and a scoreboard to achieve the same result.

Tested (for every plugin modified) on i686 and x86_64.
The behaviour before and after this series was checked as well, and there is no
difference, apart from bug fixing (some pc were clipped at 32-bit values, even
on the 64-bit platform).

v2:
- do not modify qemu_plugin_insn_haddr signature
- fix cache plugin to use a correct hash/equal function

v3:
- add missing Reviewed-by tags

Pierrick Bouvier (11):
  tests/tcg/plugins/insn: remove unused callback parameter
  contrib/plugins/howvec: ensure we don't regress if this plugin is
    extended
  tests/tcg/plugins/syscall: fix 32-bit build
  tests/tcg/plugins/mem: fix 32-bit build
  contrib/plugins/stoptrigger: fix 32-bit build
  contrib/plugins/cache: fix 32-bit build
  contrib/plugins/hotblocks: fix 32-bit build
  contrib/plugins/cflow: fix 32-bit build
  contrib/plugins/hwprofile: fix 32-bit build
  contrib/plugins/hotpages: fix 32-bit build
  configure: reenable plugins by default for 32-bit hosts

 configure                     | 21 +--------------
 contrib/plugins/cache.c       | 18 +++++--------
 contrib/plugins/cflow.c       | 17 ++++++++-----
 contrib/plugins/hotblocks.c   | 29 +++++++++++++++++----
 contrib/plugins/hotpages.c    |  6 ++---
 contrib/plugins/howvec.c      |  7 ++---
 contrib/plugins/hwprofile.c   | 27 ++++++++++++--------
 contrib/plugins/stoptrigger.c | 48 ++++++++++++++++++++---------------
 tests/tcg/plugins/insn.c      |  4 +--
 tests/tcg/plugins/mem.c       |  6 ++---
 tests/tcg/plugins/syscall.c   |  6 ++---
 11 files changed, 99 insertions(+), 90 deletions(-)

-- 
2.39.5


