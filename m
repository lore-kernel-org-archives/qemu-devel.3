Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C60CCFA07
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 22:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGPTV-0005Ay-9o; Tue, 04 Nov 2025 17:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vGPTQ-0005AM-8p
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 17:25:57 -0500
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vGPTO-0002hO-R4
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 17:25:56 -0500
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-9483ece8d4aso143920839f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 14:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762295150; x=1762899950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ad+01ZEwhsE8gjLnxNHNZX5rtgi6IEtaEAFRT9B9mCc=;
 b=g58v+VRibWy07iWYPaQxthzD/RUQHVg2m5SacB2mQOywhJIod/Fmiza3A2Bzxfdznn
 tB9q0/04N8oe2LDQB8xl/nazHjje54A107YCd/Y6EVA+Thw2ah5PiTencDrFoepme5MH
 J2c8uqwRdPi1J+kNSF2asftpmn0ARtrQjejhormS1fwOBmCUbvcRe8PP8OtHp+vZHMpv
 2ilWOqIzg2o1xuT1Cmk5qQlfupQEWPOJmWF5AAw/QUfKtkE7HDz++QF/MXPQAjRDko9w
 cYN5cBWMy1gbH7vAgotjzQCNBWnJAUUjSPNEgVv3DhoEAp7eM1EtPQ6qEAKwJQYzKFkc
 qBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762295150; x=1762899950;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ad+01ZEwhsE8gjLnxNHNZX5rtgi6IEtaEAFRT9B9mCc=;
 b=KlXjvkixNoKwZLCjWzToKT3yq6WSCeVPhWuJM9LtHYK7blXGeqGzpnLVrN8n3JvK2i
 Mhp1rLdSistSE3n0YczouydJS8LpTY/0hmOarXSVTx1oYx8itGj0Y75iISUfEhpP2rr7
 N/UeSAf3fGBRpF5FjQU1QSFmcDiDvMJqI61sgTAdmflMPJeBc4ubHXxaIM53u9fBTGgj
 YvgcODik/Sl4yKJNrTsiXugs8PHHuiV8O1tbWLf7cfJ9jlrJGB7dfvK4NNIbwLuwmiD+
 jdSaQNqUG5BtC00L+LJyzSJG+GTAoGUxgxoH6vR9E4gtfui4MhzDOpiop/8Q7J28fNC7
 AsTw==
X-Gm-Message-State: AOJu0Yxp7fBmYJjqfDuUmMO4qquIZtmbA01WgSWoApXk6nV66uH5HNZI
 B7RZqxWpFJDnCXM+qCA8QRXQB8Z2K+tUnCsHJ4nIsKZ3OLa490upRY86ZdYj4ntBO5Q=
X-Gm-Gg: ASbGncuJn6+jkzMcoMUNkZowWL1R1K8/R96kh3xdy6cJqJwKBF5dJUSImN/jY+gvQdd
 Ap4m2Got4sOvLtbtJLZt1vnm5nexStEP9mUbrDhMuDsb1FlCND4S9DKfWK3uwsaMMln7AoBQSeA
 yATU4kjt15mh/qKhSsowRFUY4AiIZMJBEtpxC1/58i0XaG3eu5Be+vyrRFx72rQP/HOF2JKzG8A
 8Q+2rmyY3EAIrjPgcJPRre2T/qt8ixf4MlhJGGuSInf2Ay9shYFcYOASZ3U4jMlZ9yJc0UfBzWq
 cz+f0NtHpb/ia8NS5bvDNfe04Oqvxr07oqzavFGR74YVCxGbxeVQanh5YHXv0Ep6siNTWGHjOs8
 7vXJHzU+0GyMZipa5BadX1P3IkHnk39eFuqiX+IFNseQtV7pYU7/RNxEGymjkYcDHn6Z4j/pFcK
 DmVWdZjc66XV2gVPn9ieLpxZNUFHDDmZ4a/o9chfK3rEVJl6daxSZmTtoah+aWERsYkh0rD2Tyi
 YC0
X-Google-Smtp-Source: AGHT+IHRb9WrtmmVMG7qHVJHymZADbhsAMCH9reJWpr1+F6q+kOJ4NeKmZX9194e8b5eAHRMdwEMTg==
X-Received: by 2002:a05:6e02:1c08:b0:433:2dbd:e93c with SMTP id
 e9e14a558f8ab-433407a6f3emr14604735ab.4.1762295150273; 
 Tue, 04 Nov 2025 14:25:50 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5b7224a84c3sm1755789173.0.2025.11.04.14.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 14:25:49 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v2 0/3] Hexagon (target/hexagon) Improve USR handling
Date: Tue,  4 Nov 2025 15:25:45 -0700
Message-ID: <20251104222548.108264-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd2f.google.com
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

Currently, any instruction that writes USR disables short-circuiting a
packet.  When the write is implicit, we can allow the short-circuit.

Changes in v2:
- Properly handle implicit USR writes when packet commit is necessary
- Added test case

Taylor Simpson (3):
  Hexagon (target/hexagon) Add pkt_need_commit argument to arch_fpop_end
  Hexagon (target/hexagon) Implicit writes to USR don't force packet
    commit
  Hexagon (tests/tcg/hexagon) Add test for USR changes in packet

 target/hexagon/arch.h              |   2 +-
 target/hexagon/gen_tcg.h           | 114 ++++++------
 target/hexagon/helper.h            | 114 ++++++------
 target/hexagon/translate.h         |   1 +
 target/hexagon/arch.c              |   3 +-
 target/hexagon/op_helper.c         | 287 +++++++++++++++++------------
 target/hexagon/translate.c         |  35 ++--
 tests/tcg/hexagon/usr.c            |  26 +++
 target/hexagon/gen_helper_funcs.py |   8 +-
 target/hexagon/gen_tcg_funcs.py    |   4 +
 10 files changed, 343 insertions(+), 251 deletions(-)

-- 
2.43.0


