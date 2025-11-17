Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5874FCE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1VB-0003wE-HQ; Mon, 17 Nov 2025 10:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UO-0003cs-CD
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:07 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UJ-0007xI-4J
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:49:58 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso37080155e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394594; x=1763999394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9tbBOFZcbf6qkUrLJv6zj0rwn2I5w4p3d7SQXfrnjg=;
 b=MxWLtWPn9Gzk/Tf0sWcq3Px5I0VocV0h9BFSEyTRKOjEU9yhlPk9tImdnzpgETXq5k
 eu6sqGSMJ1Wz9JrM43mRvF/fvl5sAcGjgIKxjRzw9ikC+SEmCFYU4/C0i52gvZ/ajRuA
 uhdFn+rxvs00YbEdTFet01sZl6oUkHSBt5xj3udpM43Mm23R9Rr4A0MhbVeW2Rnu6sfR
 ZdvNR9EgxT1mJaLBPs9Kms3Aa9WXBkGLnPVdpvgb+l1kbhZTPFvpmayTXYGVaQ+ECLB4
 V5MwbTF7iy1a0erOhvzVMthkaysROWWaifOyRbKKoadNldRp+03juEpq54z8baF4EWes
 bVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394594; x=1763999394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s9tbBOFZcbf6qkUrLJv6zj0rwn2I5w4p3d7SQXfrnjg=;
 b=VO9pyS4dMwhHBra1rvp5fbcYWQcD+3BBV6JfgYPNJYTCh25D3z8ec/g3VA01C2Ef6K
 Cx7lLx75jFsUyjZ60v5j+JP9VXAvewMjtxHPeL1kMWulr0E6iOUps6j1meakwkscdcB+
 SED5AdMlZi+GE+GXXBENUAEjmE7vAO0NHpMeKH9qyVDEBossPtENE6DoDoIs+j0p4xk0
 zEl0LI9SYbNRljYefwWQ9zlgcy/tPolZmOIOjugfmrPgpvk6NAZ2Uq2DKXrUGUygTQ9y
 rp9xmE5g9VR4SVnBbnX7GGE+vap0OXeK21F4eZxTDcowf4DRgfFnN0WDtCKukYLb3Cxa
 oseA==
X-Gm-Message-State: AOJu0YwDjMVxmJnH4R88TBjgRysLTcT8nZ7+9dtoWZ4zQCcXSQxT6H8d
 I0jblqBx3k3o1rjxZcUgfeCGak9MguhxoZm4VJFZ/2d/1ejaS+pAREK8QZFO+ip6DAE=
X-Gm-Gg: ASbGncuddN5ysRJTzPc/fQiizvseEEgjgtxDv2WCqF9P09iPP28hn367XnCOYSHp9Du
 QfUcA7kGgCpS46x3QhhMN6ThhQcEDiGrODKFt+sZcsT/JW9g3yaQFGTVFzsBQFfkM45apoO5S4W
 fWVO8vVWQUpaMy2sQ08+p9RSsnchlkktQEmLTtjer7gEVFyNNop0Usuo9B+DrWI7BGPSMfVbpEe
 V4Q28ul+SVlajByWF2eSwvY+/U9GDk6sHXPvwP1bsxAigSqz4rnhkWMxb1Uw0dki3eAZyRREbBc
 5MlbD+wLEh1RNgLzHmqlgyQ70eIRIKqsVmQ4Sw4ZBXIXnaY92LmQTYKWfwrZ0/8rjnpUQPJ1ozQ
 RUiSqMKRmbjH7j68YJFZ4LjJCJ1zz8PsOz/3MeIF5TweTuJVYEq0VvWT7bwGhaZKLpW8N8RkwR6
 qB
X-Google-Smtp-Source: AGHT+IH56pC0++WJaAhmBEkUxvXnIw/V4Ujf612mRCXrhTm52OLY59R4Vc7dJChCf8v05uTpY3kHcw==
X-Received: by 2002:a05:600c:4991:b0:477:9d31:9f76 with SMTP id
 5b1f17b1804b1-4779d31a01amr46241835e9.12.1763394593509; 
 Mon, 17 Nov 2025 07:49:53 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779973ddcfsm136501565e9.15.2025.11.17.07.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:49:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF96F5F915;
 Mon, 17 Nov 2025 15:49:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 05/18] docs/about/emulation: update assets for uftrace plugin
 documentation
Date: Mon, 17 Nov 2025 15:49:34 +0000
Message-ID: <20251117154948.4122164-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117154948.4122164-1-alex.bennee@linaro.org>
References: <20251117154948.4122164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Linaro is discontinuing its fileserver service by end of the year.
Migrate assets to GitHub.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20251117115523.3993105-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 92c219119e8..4a7d1f41780 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -886,24 +886,24 @@ As an example, we can trace qemu itself running git::
     $ uftrace dump --chrome | gzip > ~/qemu_aarch64_git_help.json.gz
 
 For convenience, you can download this trace `qemu_aarch64_git_help.json.gz
-<https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz>`_.
+<https://github.com/pbo-linaro/qemu-assets/raw/refs/heads/master/qemu-uftrace/qemu_aarch64_git_help.json.gz>`_.
 Download it and open this trace on https://ui.perfetto.dev/. You can zoom in/out
 using :kbd:`W`, :kbd:`A`, :kbd:`S`, :kbd:`D` keys.
 Some sequences taken from this trace:
 
 - Loading program and its interpreter
 
-.. image:: https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
+.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/loader_exec.png?raw=true
    :height: 200px
 
 - open syscall
 
-.. image:: https://fileserver.linaro.org/s/rsXPTeZZPza4PcE/preview
+.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/open_syscall.png?raw=true
    :height: 200px
 
 - TB creation
 
-.. image:: https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview
+.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/tb_translation.png?raw=true
    :height: 200px
 
 It's usually better to use ``uftrace record`` directly. However, tracing
@@ -916,7 +916,7 @@ Example system trace
 
 A full trace example (chrome trace, from instructions below) generated from a
 system boot can be found `here
-<https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.json.gz>`_.
+<https://github.com/pbo-linaro/qemu-assets/raw/refs/heads/master/qemu-uftrace/aarch64_boot.json.gz>`_.
 Download it and open this trace on https://ui.perfetto.dev/. You can see code
 executed for all privilege levels, and zoom in/out using
 :kbd:`W`, :kbd:`A`, :kbd:`S`, :kbd:`D` keys. You can find below some sequences
@@ -924,27 +924,27 @@ taken from this trace:
 
 - Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
 
-.. image:: https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
+.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/bl3_to_bl1.png?raw=true
    :height: 200px
 
 - U-boot initialization (until code relocation, after which we can't track it)
 
-.. image:: https://fileserver.linaro.org/s/LKTgsXNZFi5GFNC/preview
+.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/uboot.png?raw=true
    :height: 200px
 
 - Stat and open syscalls in kernel
 
-.. image:: https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
+.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/stat.png?raw=true
    :height: 200px
 
 - Timer interrupt
 
-.. image:: https://fileserver.linaro.org/s/TM5yobYzJtP7P3C/preview
+.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/timer_interrupt.png?raw=true
    :height: 200px
 
 - Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
 
-.. image:: https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview
+.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/poweroff.png?raw=true
    :height: 200px
 
 Build and run system example
-- 
2.47.3


