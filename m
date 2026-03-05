Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3D5F47CD2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 20:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFgC-0006cq-Gp; Thu, 05 Mar 2026 15:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFg9-0006au-6I
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:17 -0500
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFg7-000680-JB
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:16 -0500
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-89a000f5adeso84695126d6.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 12:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772743934; x=1773348734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TmvG9qPfC+MFsV2E2Gt8Szd+mNMYzqsDos9C+QAET0U=;
 b=XHtO3NW2gLlHxxs0o2UPUmiJxD3/cRBkaEu0POOdRETsULlUNUaQysqb2EuafzDFlN
 H6c02eFbAlWfnVKocfKSo1FQLs9W1cir2qCVuR6AX0p2+HAaRWhDkbP5hmw1Q4BaDEAp
 ZfdtCzHBqMMb5TXVhDjm03YgN/xSo47ztovWRoQFzSV1m0F3ywo8whMu62WkET5XGplS
 F4cP3WiUDspYb1rGgz9j1Bpa8nlYfosl+s32V1wRfgxuSg8ArpFoVuEpAahUn9yvidqP
 RGHqZltMv0C8DSVQAYEN29vZ/JD6X0WStvWFJLTWrghQyOWzQDJrgq9f6y30alslJy/H
 uo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772743934; x=1773348734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TmvG9qPfC+MFsV2E2Gt8Szd+mNMYzqsDos9C+QAET0U=;
 b=p7/wikGkF5FqSK8rknxDrYpgTSnclpTTksDzX4uTEjGqn5j/h8qPA5K2mMNm/Qn58B
 L6BWtZjnhk5sJ221IJfGjnZGbqHe0vv6M/LECJa60AoYEavHrVk2tf2ASNcrrPdOW3sy
 ABg6slgwXiwCqBp7O7Ptf8ur5sONAL2b7JyEzWthX/cIEPCBLm1C+5yiJFrHA7Z5U5RR
 2ve6aHFRnlRDbvrI1wsVsyTVYX8kA90DWq+9KF8qxThe1nwbI57yHF4f1PQPKb5x8QuE
 A5TF/9Xyy+BqKi0k2dG0hdplRrNz/8/h5JtwdS+TtEIL2c/F71vEgB87IHVRsvq8k0EG
 wRUQ==
X-Gm-Message-State: AOJu0Yx6NbXoUqz+MXx6VkUWCGIO/caEz586AxHbkD5Wpo5OAvs01xtI
 WwmN84k8AJVDHFDuAt6eWH5sdLHIhk0/e8bdk8fUYddKPGQTcgqcse17HBWet57Xz/aCoztx/Y5
 itHMC
X-Gm-Gg: ATEYQzzV5npfRgJJ4fcFG1TIGq2sDv028c/ePlG6wiMbn7SVPhcU1GCIRZg0xhDxKK5
 voE+dCBnWWR8r/HsBatx+kyjGRXCWgOLQZjDvYGeceAQMyO5QTpRVueMI9N224oXY+qczck/oE1
 VYgagLkTLOQUqMO32oRa4M9hjmNH+1hSW8hpwUvjF5RlIkpqbpG9ssRFdumdB5UoZgeftEQcE6Q
 Jsl6R9sP19XXcBw60v66+Q1Ld2SN7ClKJsPBLpf06J/D2UrNNgjz46pzS1BdLF9iE6DwCBsT6gg
 AcqgLCiigLCQ3b+YEaGeoz8+/F64KeEtpBGWkTaRRHarKYJjJiHsJ6e//t8c3XNFebc3tldHJw4
 Q9+KYfj1rU/6Od8MdkuvA+fzRMeQS9B0ebm9sxzVigpUp/Qz7u+wq/zO8M4bU4fqoq04tzwWa2/
 CRkGxXiLKnfsfTfVtt0IhSHrXeyjEidlASOqyFQ5E7+bdyts4PA/3P4HBZZaGBS1Wj7ubu4veAK
 b+a
X-Received: by 2002:a05:6214:1bce:b0:89a:ff2:b8ce with SMTP id
 6a1803df08f44-89a19af3cd5mr110427206d6.41.1772743934287; 
 Thu, 05 Mar 2026 12:52:14 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a0e31b035sm65559396d6.17.2026.03.05.12.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 12:52:13 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 09/12] plugins: add missing callbacks to version history
Date: Thu,  5 Mar 2026 12:51:49 -0800
Message-ID: <20260305205152.2121854-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
References: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf32.google.com
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

From: Florian Hofhammer <florian.hofhammer@epfl.ch>

The discontinuity and system call filter callbacks were not reflected in
the versioning comments before. The callbacks have been introduced in
aac73d85d2d6f556dbcee6041a2898cb0ef9b0e6 and
5ed628d1d398b164053f5d5685541ea705275998, respectively.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/c4ecefb4-8769-403f-8420-8bce42e43e13@epfl.ch
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/plugins/qemu-plugin.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index fceb8194eb8..827e8e17877 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -77,6 +77,9 @@ typedef uint64_t qemu_plugin_id_t;
  * version 6:
  * - changed return value of qemu_plugin_{read,write}_register from int to bool
  * - added qemu_plugin_set_pc
+ * - added disconinuity callback API (for interrupts, exceptions, host calls)
+ * - added syscall filter callback API, which allows skipping syscalls and
+ *   setting custom syscall return values
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
-- 
2.47.3


