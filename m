Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE7AC7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 14:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uScs7-0000IB-T6; Fri, 20 Jun 2025 10:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uScrz-0000Ec-DS
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:37:32 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uScrx-0001id-9v
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:37:30 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-313eeb77b1fso1516540a91.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 07:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750430246; x=1751035046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wY8/KfHUSez1SUT21ItrNo27iE7/jUobK+nyqt0bQU4=;
 b=i6wb+BYDzefcIUtmD/PpCho3xAf6mdyIz9kN6lAjz00cuYx7tjcIdNQa7XnTSnwyru
 H3/T7Rje7NOJWWKNZTGYZ277ZKXZNs2Fb6uro6mrTAXyF53qo/4hwwG4uowOOFaR7EAt
 fMTNV6AYoMn8vlTOWjnhAQexFplCMOQdvPi0lVs6DqTIczXjX6fmIS3B5uJScTT76w4A
 /ICKJomoFGsx2W/Jg2Wtak3Q0zVNsCVHXkJJJwlfeM0QpK9fUFYFYj6YtYHuMce85puT
 EfOh4Ut26flqV9uAc11f+h+zpsXN5i4u9Z9hrRBL5ZG2tWzQqAwuonxgF37Gk84PIiEz
 fC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750430246; x=1751035046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wY8/KfHUSez1SUT21ItrNo27iE7/jUobK+nyqt0bQU4=;
 b=tjvEQJ8WxQwxtAzLaAQfdtcFuv+C1DvYCef5oqWY9GWwG5o5uiJLLMzGlCjQxGzsbG
 k617jhFw2HWeujc/FaFVoQuKdUN3sd2fdIBB4Zsvygb5nFY3e0LEK9BQXN/Uy7g8W3+U
 FmpD4yF/8Gz19nrXrq34yON+iJE3kcFf9o6m1TXTT0EJoO4pv6LKjtSmo26xq9JSWjE/
 93FnhaDUwHaawWRW2RmlogPVTql/j4tC+Qq0pn3yfIfg4SB1Nh85yApj4ddRJUp5iiub
 LRFJQs0tbOc/Yc20CAxQLsudBNIy4wuLZJihGRgaZffcxjc6khXTbdt5ocpgCqgwWwJY
 0C6Q==
X-Gm-Message-State: AOJu0Yy8MDU+D8CytwLsANBT9m3GXDECTIe89CLf0l60dMCvjJqoz0Fa
 r8Zu00fFGladpgPw6Tp46Sckya8AD6oRqNyIxLL2GKkDfk9daB0zwEnI1mDJ9SMF8+Svmg==
X-Gm-Gg: ASbGncv+rjQX38/ceiAJH/0DAOSDKItJWNHKjJ5TZFIPjPQLb8Ock2axYpZVFI9mDc0
 ob+SWi5g+TEDKZnIjsXal07F8xYWvYq49akjh84KBxZeH/751XZ5Z3mW7sF+X11ib7M4s8p9Clp
 0hdYzZkS9S5f+xE411muDrAvGVRRuAi0fSkPmBthK8OJLvCjVI0TWQwegA23U/XQ0mMaH5RPuP3
 nHx1bDXGnkQxDgY6PAKSNiqEgnE5cJtrjT6VmTIzcnGI7rRV03wBh/apHUygJCtdhwYhlrG6Cp7
 /Su44aU9aDRJ/cu7X2g07eKpxrDSTUgZyzbFAoq4G9pOsArVVoBBCanXAT9x3f9POCXM2id+
X-Google-Smtp-Source: AGHT+IG3tw33lDYiU7raasEXvXBK8U9ll7NtvYd/cJHiRtH61Qtj1s2crg8MRGJjrru0MnhMni1aDA==
X-Received: by 2002:a17:90b:5546:b0:311:c1ec:7cfb with SMTP id
 98e67ed59e1d1-3159d8c7d18mr4991949a91.21.1750430245382; 
 Fri, 20 Jun 2025 07:37:25 -0700 (PDT)
Received: from ubuntu.. ([27.61.32.140]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3158a2f0cf5sm4368820a91.26.2025.06.20.07.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 07:37:24 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH v2 0/3] tracetool: cleanup "if(true)" check from trace_foo()
Date: Fri, 20 Jun 2025 14:37:17 +0000
Message-Id: <20250620143720.3143-1-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This series of patch aims to removes the leftover if (true) condition
from trace_foo, a remnant from the TCG tracing feature removal.

It replaces it with a proper trace_event_get_state(...)
check where necessary (for log/simple/syslog and ftrace backend).

Additionally, this change centralizes the generation of
trace_event_get_state(...) calls into format/h.py,
eliminating redundant code across individual backends.

This cleanup results in more consistent and less
repetitive backend code.

Tanish Desai (3):
  tracetool: removed the unused vcpu property
  tracetool: introduce generate_unconditional
  tracetool: remove redundant event_get_state checks

 scripts/tracetool/__init__.py         |  6 +++---
 scripts/tracetool/backend/__init__.py |  3 +++
 scripts/tracetool/backend/dtrace.py   |  3 ++-
 scripts/tracetool/backend/ftrace.py   |  3 ---
 scripts/tracetool/backend/log.py      |  9 +--------
 scripts/tracetool/backend/simple.py   | 11 +----------
 scripts/tracetool/backend/syslog.py   | 11 +----------
 scripts/tracetool/backend/ust.py      |  2 +-
 scripts/tracetool/format/h.py         | 13 +++++++++----
 9 files changed, 21 insertions(+), 40 deletions(-)

-- 
2.34.1


