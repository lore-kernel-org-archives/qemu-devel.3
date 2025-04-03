Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9124C3601B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 11:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Iuf-0001JB-NX; Thu, 03 Apr 2025 07:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u0Iuc-0001IE-JO
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 07:39:10 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u0IuZ-000260-NG
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 07:39:10 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e5cded3e2eso1321817a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 04:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743680333; x=1744285133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EjUK7SfxGm9/wdvScIHCfnIKV3g2WCyTpcT7AjajSE4=;
 b=kaclcygCOhyBoGI7+4W30IUlnfQ7ACOnYjKJz1mBp8SnAK8gPP7TsF9TtLug6/s4sg
 MLIMQsGbyL5rtrUs/LUY+uieHiPEepFaiE6xdvvwyFqziJUFAbFiRnnw1hTSkipY8hDj
 LJgx6jAkLFCRVmRBksQM9q5d24ICyhwdjM4Sb6CCfDNoHMIZEBTo6SiwVMcWbwn6hAw7
 SlO06t9b4BlFoGUi184Pc/xs15yP4MecCEach6fZXMYgLD9BfQD1vlt9u4T91yzsVBm3
 aE1ixNwav3RvKioefw+EkGwA+TepaRgps75sFWW1lPufRCR2nUigAiypsTLYYWmVktf8
 l4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743680333; x=1744285133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EjUK7SfxGm9/wdvScIHCfnIKV3g2WCyTpcT7AjajSE4=;
 b=AgOfFXJxhOtr4qdxiuiLupzyvFvU8DrbK/nL15Q0gK5bdV7C2Gxm+DMvdxNQ1/Dq4F
 yKJ0ZWcITPHM+NbkY2pIlcwzK6oQuSqTQ9OSDU8VgPx7PMHyW1/j1VH2fJjdQIh3YaMJ
 GryvdGz/LHJc4cme2BlCHHxZuRcb5XtudUgMF6CLuJZ9CAu1plLEZRWzG+Yk/gaSd7dx
 SfFhAV+CKX3134ZxwB5pwwUGmsb4Kktl1e2NnjTqq9K14JoGCTkne8JC1c9frnTuCETs
 LZDhPtX+cj/UADr9tZ5RlhdxQirUaMWwMhozyvTb6rMWz+1eg8w9h/Ty3eWIc1y4STqK
 fC7w==
X-Gm-Message-State: AOJu0YxltEwYs6MkSyGl/cg6OeK9tWMAI56XAaIQ1J2bpcMUdw9HXdB9
 7PRUVqo3Lzx9Sj9OdlZzb/cELHA8erJkPAyy4oO2Uzzy32SWFSWbstfCDgNcBzo=
X-Gm-Gg: ASbGncttGUZGSZqezmR2ZGwvcf5ZqHrM7+wJxRleciR3hJBn0bldB3dCU5ZqT5pH2z0
 P74qeQN3nn4QN5i2lvbkvMWEkEKkH5ze97Vfzwl8FgQLOO0fjGUXt/To+lAtwvjlkGR2qHp2Ssn
 CyI48x1nB1ul6o4Xlpq8PufAl6euiEFqUBvB1RJHF2ukoUnPSpVJoSL3EkJrtYffF5h9NMsmTmH
 AGywvXAnuROsf4XwEV0Pp033YuQVNKdoAEGc/EDmsjNMyyvWdtEy+cMB3k94IguWXtpFJ5i5bhP
 U8Yxt2sCCtcqSZXaCGHESAqPumT+YAq+n+a/UGQNYOrnwiY=
X-Google-Smtp-Source: AGHT+IHErtHpXy6hVDXSaDi5s174POJA3MEHIUcuR4bqODfpfTuzch0lThlTI5IEORSS7E2DsrXHJg==
X-Received: by 2002:a17:906:c109:b0:ac2:d6d1:fe65 with SMTP id
 a640c23a62f3a-ac7a1a45387mr503887266b.41.1743680332870; 
 Thu, 03 Apr 2025 04:38:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe5c92fsm80558266b.17.2025.04.03.04.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 04:38:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6AF125F8A4;
 Thu,  3 Apr 2025 12:38:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Alwalid Salama <asalama@qti.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 0/2] add explicit virtual time callback for plugins
Date: Thu,  3 Apr 2025 12:38:49 +0100
Message-Id: <20250403113851.4182190-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

When we added qemu_plugin_update_ns() to advance time we missed the
fact that users of virtual clock don't get updated. Rather than
implement the logic inside QEMU to keep track of the magic number lets
just delegate it to the plugin instead.

Compile tested only.

Alex.

Alex Bennée (2):
  accel/tcg: add get_virtual_clock for TCG
  plugins: add qemu_plugin_register_time_cb support

 include/qemu/plugin-event.h |  1 +
 include/qemu/plugin.h       |  9 +++++++++
 include/qemu/qemu-plugin.h  | 18 ++++++++++++++++++
 accel/tcg/tcg-accel-ops.c   | 11 +++++++++++
 plugins/api-system.c        |  8 ++++++++
 plugins/core.c              | 22 ++++++++++++++++++++++
 6 files changed, 69 insertions(+)

-- 
2.39.5


