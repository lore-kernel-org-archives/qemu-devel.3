Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4B1C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 15:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujg5B-00083A-3M; Wed, 06 Aug 2025 11:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1ujfiD-0005J9-OQ
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:05:57 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1ujfi9-0005RF-1g
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:05:51 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-24041a39005so38069715ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754492746; x=1755097546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q6hQ+HwdhAde9tfN/Dbjh1icVhd2jU2DSAqxfWw/Mo4=;
 b=iw7u7KgnzucsXeKuBFEvjYU1S4D4jXx3HB7RcvqzksDS0oclDPmCo7wVtWYNMpxD6M
 rEgC2lV1Jg2UAd545bXymF+1WhzcEZB8cpgaoRqAR7i0je8G7v91go5O2Su45sroCUwg
 rvZJGMIwM7wOoge9wHzCcdjJQdQna0xELPEsvLUs0hJnsvyvaa6rG8mgtak6Y2v/783V
 gfXhygk7ZuaWRz5V4rMzxlw/MGeG4PNeA7zxKaqbzvCyTtr4MBXRIoVFwKWEUwhWqazW
 c+Er5zV8izHJ7x8njxQd8g2wiynvjUyKP28ZPil6ZlQ+obLDtiFMrvttwT7Wv2wWYbEQ
 lLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492746; x=1755097546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q6hQ+HwdhAde9tfN/Dbjh1icVhd2jU2DSAqxfWw/Mo4=;
 b=CPLSyknK6/BgwXALqCkBSLSadEftBKkwYo92NCDo5y/JKVoW0Qw2dy/6UdIO5tX8Yx
 RbpcaszAHyYfaV/fQgY2rITZxl8NWNkVs8LM9X4Axnk0SUTLZMzlSQXykQuF4ndY/27a
 DM3uvFDDdSKEhpOH6VdgJhiQx+s7xH8bTVhue1yZkpNVpIfAtFD7+y9abLi5FwUe38uq
 KHt7cphcABjkTjZcnnG40l+cUdWRheTl564b46cwKzsjzbfsKcWRj4/oWSDGCPiSat2U
 YZBcmHansxfcuEWfRReQWEKLoDKaJQes0V6T4+m4SSx082ApsrLbJp05JSVWgqTjB5Mb
 I9Pg==
X-Gm-Message-State: AOJu0YwuI4RgkDkZw3b/cLcXiJUImQnP936xKmIbiOXH8qQ1TG8BYATi
 4GG/gHqM3NPuxIaeRyal/Ly/2e/Iy+gyeN1zlR+IEjsSAJyLfYUAViL/Oy/SGvMBDnc=
X-Gm-Gg: ASbGncuAAVYi5rrVioTB6d2aPAWczIIGEbrOTADHUYSmCUyZTiUablNgwr+BCNyq2vV
 paPlnIVnEK8464g0JUoD7MGLGVvPPKHmMyK3ik3325DXkGCaWmX8zhSTMZmHuH+tOY5F3z6pdyN
 BX0aWrtmcQgyG42Sf1j6e5eaGI9JQotZ9w9R3Qq5Lq6AQD5pG15rICBuzHV2fVOVNoulwb7zjIE
 EEVFgKZc9jb6+YfmXZLUvXlFEqGiwLFdUzh0Uxf2AWN4iCQpJ57K30eRYh1b7hl8L1B0B1Tabvo
 Gh8sxMN+10PWw3gK/mOgoPatdiLJCeH2ATiEe58R0ClNoM3nbhu5dKe4wpvya75CG+LGvOdrik0
 8okIY51WY61kJd+H1xM/WBvSF
X-Google-Smtp-Source: AGHT+IGU2WjPlY+/X+DrilZMlLYKQ17cZyj7sMwaB0ExsYoaqozm2WBDEt5lGgSQf43lUCeyXFQGlg==
X-Received: by 2002:a17:903:94c:b0:240:2953:4b6b with SMTP id
 d9443c01a7336-242a0ae458emr49849615ad.2.1754492745579; 
 Wed, 06 Aug 2025 08:05:45 -0700 (PDT)
Received: from ubuntu.. ([106.215.156.228]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d21dsm160107365ad.139.2025.08.06.08.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 08:05:44 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com,
	tanishdesai37@gmail.com
Cc: Mads Ynddal <mads@ynddal.dk>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 0/2] tracetool: remove no_check_foo() and if(true){..}
 blocks
Date: Wed,  6 Aug 2025 15:05:37 +0000
Message-Id: <20250806150539.2871-1-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patch series eliminates unnecessary
if (true) { no_check_foo(...) } blocks and
integrates the no_check_foo(...) logic directly
into trace_foo(...). This results in cleaner,
more maintainable code generation.

A new backend attribute, TRACE_EVENT_GET_STATE,
is introduced. When enabled, it automatically
generates conditional block :
if (trace_event_get_state(...)) { ... }. The
generate() function emits code within this
conditional structure for that backend.

Previously, without TRACE_EVENT_GET_STATE,
each backend was required to manually implement
out("if (trace_event_get_state(...)) {") in its
generate() function, leading to code duplication.

Tanish Desai (2):
  tracetool: add CHECK_TRACE_EVENT_GET_STATE
  tracetool/format: remove redundent trace-event checks

 scripts/tracetool/__init__.py         |  1 -
 scripts/tracetool/backend/__init__.py | 26 ++++++++++++++++-------
 scripts/tracetool/backend/ftrace.py   | 12 +++++------
 scripts/tracetool/backend/log.py      | 10 ++++-----
 scripts/tracetool/backend/simple.py   |  9 ++------
 scripts/tracetool/backend/syslog.py   |  8 ++-----
 scripts/tracetool/format/h.py         | 30 ++++++++++-----------------
 7 files changed, 43 insertions(+), 53 deletions(-)

-- 
2.34.1


