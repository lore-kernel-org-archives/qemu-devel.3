Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E079C28B24
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd5O-0002Sg-1Y; Fri, 07 Mar 2025 14:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd5L-0002Pw-04
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:10:15 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd5J-0005sr-3W
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:10:14 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2234e4b079cso41957965ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374611; x=1741979411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wT8pzATX7z0g510B/bcUtetzdKIxpUlAXqTAPEA9Pmo=;
 b=X50c26POZV1APLSQc2CDyEmq3pOvZ2vwxfpIriFW6WsbOvrxeQQsGa04nyAFcYlDyW
 fgL3Eun0Io4kMnnTuDEPMMLBoOaFs8eiFGvQmr9T5hun9EzztwjC8FvRbSE9gzD2FKGm
 SxX66XHrPVPA0oLgOgPzpG/puiztAtTaigMMNFYV034pWNLD7tXk4PF1SQFDWzhEwWeF
 FwKI5JCqloimwecBizytKJ0FdTRdFtRbhItadoz2ZQumKKq4XkVK902R2mdi2e5aq4Zv
 Jx4XdYMPJg+EP3v6BR5eO3uz9rV40JtC/qtE18jEkwMrhfWbkLJS1ODmouq+Kx2PcRk/
 mCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374611; x=1741979411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wT8pzATX7z0g510B/bcUtetzdKIxpUlAXqTAPEA9Pmo=;
 b=mKUAZ6UIabDpEBOZ5B6n+xWIHmtZSm1tfwvzBfYGyJ/hhGg3QCdXqt5wQSVaX73FTV
 mduLCmK5RnHcqnTmCLUGDCOpTu2MSdKxe9bAJC6CBhoB0xMxFWEJ6TAUddTgbKudoqAE
 6vw+xOjGmHjtuLowk439rzLtPTMpNrzc+22vH0CvrTJO5WOZUMxGYdMPLpTXfM4oDsEk
 9AZUOl55epBx0oPH5As0J3kZRXFCx6hmQb5PYBWl542BNkeH2ZgUU8hHzk9K92o+2cvP
 UD9/MA5g3npq+iUcBv+f7J0wuQlF5nccN5prrFAENh2lmJtS+B3QWKq/3rhsfUsl0Tgg
 TNdw==
X-Gm-Message-State: AOJu0YxAm1XBWWoqwaBNMbcn28SwFkmDIpW7MbMsNSRgku7qHr4ohseG
 NmsytGHdOnM3qZVmzfpRKQq+D3j5cNe0uMc91hhfC/RJmkKlmbbP6Y6FJNTHYHXVqCU27ddtbHq
 N
X-Gm-Gg: ASbGncv6YhHcX2vhV+iSHYTAmZSFKSCMJOdqHG79YA7G0HB9T+AvHp/kLD33Z4UQ2eM
 EbY0bzwoAiazfKtadg4HSv9x93cH4xjTjy+Wgam8wXHn3ZJcMIrdPrB0o6bq4sbnzdxV2Pbsshb
 pmgtj2L2LQAkKz0kAp8jXwnZZ7KZ5LkDnw+xIW5Vw9by1KrnoX8MJiiqtCPWwzpEBYl9rv3oaPs
 UhXoz7d6EikasxUENkppwJzf63AtUCB5tX7mNp8JTnhmeTlJfjWFBato+5O7gAmAvsAl/jVsUuN
 uJKYib7IV4EVNn6N510j65fUguTCcLg3r/8X9Vna6jD3
X-Google-Smtp-Source: AGHT+IEH7EsRMyLZCmYOauj7JToSFEANXbFzPetpi9H1zUtYRPDo3QJkFW/8iGfm/aLPKoNLrKiADw==
X-Received: by 2002:a05:6a21:b93:b0:1f5:5807:13c7 with SMTP id
 adf61e73a8af0-1f5580717dbmr263818637.17.1741374611193; 
 Fri, 07 Mar 2025 11:10:11 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b2da32c6sm1449895b3a.149.2025.03.07.11.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:10:10 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
Subject: [PATCH v2 1/7] hw/hyperv/hv-balloon-stub: common compilation unit
Date: Fri,  7 Mar 2025 11:09:57 -0800
Message-Id: <20250307191003.248950-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
References: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index d3d2668c71a..f4aa0a5ada9 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -2,4 +2,5 @@ specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 specific_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
-specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'), if_false: files('hv-balloon-stub.c'))
+specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
+system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
-- 
2.39.5


