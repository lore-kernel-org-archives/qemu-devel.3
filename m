Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E32C83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbcY-0006g8-RI; Tue, 15 Jul 2025 05:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubbcU-0006e9-Gb
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:06:38 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubbcO-0005so-1I
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:06:35 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45629703011so1740535e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752570386; x=1753175186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0JmIIovkuZ2UkZH/Ms+o9LN+k8Vqh/ex9KD+yCD7TE=;
 b=r7t6mQlC4jQO147nX3iPwD0jH+S1vyWo6NW8vxwWO+yV4BbyHB2EhE1kdHaa8bMZae
 B0BBy5gNWSFjJSwEqjM+yGLtI0jYKWc+BhUMYTg6Awt+IuJGEgrvVZdkIJ36iwnazmLi
 sjq4u10zr5rWi8FS5m86R2vp4RVHFIsgvZfRAsRNz5wYUo9zqfkCalNSLa3Z6UBbT6rK
 uZax/x61nWQbEUQZhH6oEWD7ZCb4Z/k14OzptWugBij8Cbpp19RtESM3GEF2nBb19hWt
 qRBDf3LdEJFdE19VkDEOXser1mHQE243WQXLP9aX0KGtdmlLFlfECEu6vYrVjQ4Po0SB
 xg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752570386; x=1753175186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q0JmIIovkuZ2UkZH/Ms+o9LN+k8Vqh/ex9KD+yCD7TE=;
 b=uHYNKYBWNA0hTSPJP1JK+P0IvWzXHnqnfjQXxRKEbvrDcor85S/r+8gc60gW7v4Egq
 0T0VSyG7tfstQO9BXc+a/MpwqHJWoeedQnfQMnvWKSMTr9NUPFc7+vXpm6W8csMTz7+n
 sKbtJkV3o+sv0gywPzX9Y5DMongTTKEo1Yc8JJrb+7IDrWiNxylLmhkFEoqXOudG7YbP
 wjc7kHW0s08WQfcCH1FzbW9IPLGW+SAUpZ/cz3d1m3sjuAhYWqxBqGiesW/xVDm2PRFC
 55HJSbeZIkHWqSpUXNNjcLLtwGy3FBFaKKOfV8QvXlL4iPZ9AJSsaJmeDjniD+2Iul9/
 948A==
X-Gm-Message-State: AOJu0Yz8hOYq7nhiyhGC67yn185PLOy9K/lz5IIZsUfGdMK9pYKv68Po
 eLnAS1VHyW0wMeHDi5tTK6bQ0J4us//Hht7Dc4yLFwWfQotM/2SKPDE9TMVD7ZY7BYsLzQ15H0s
 ye54b
X-Gm-Gg: ASbGncvI4xAZsfM8m9/4Pw1GHs5pTBIXGebucj20ZDgz6fsI/WCZF0rAwNJ4JGo0Qv4
 TAS38zeUU/CgqWdxkp2F+QqpRiBRbLWmKmuhV+QAcIWkoTBRJnNU04++nOAylo7N3Rn24IJd2R5
 xBpo7Nqy3JdiCftHQtwYUNk4McACwJPvSlHhNFwIQbCT+DIgQDgi+m01iDthQ+3vnTTRXwAI5oP
 lBTD1Skp2ieveignk3MkkCJFbjPQJEHsU8CJNeTfjJT1ICJEAm9Yb7ynMuCdTSJpq/fujtzvl6F
 Lee+vFiBVXdd8OQVmkiOciy15TFPXlRF130v4vd48Z6I5dMq5tXTG3pQpdZL/+5WPRsFm81AV6o
 w0qWEBe1JstkcYbDChAcpSPr5IcjfYP4i8O4iNeD6sGVkeHYHiXTf3h1PSjkFxGX97o2XjMQu+N
 mlqA==
X-Google-Smtp-Source: AGHT+IEpfCkWGgKbmLtq/ObOlz/J/TJJQh0KUV7K0IW/mkE50VRhU/oNmuN1weWM0hDqHqnRaWsM8g==
X-Received: by 2002:a05:600c:46d5:b0:43c:fe90:1282 with SMTP id
 5b1f17b1804b1-4555f895b83mr116957685e9.7.1752570386548; 
 Tue, 15 Jul 2025 02:06:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560c50b7b4sm93998325e9.25.2025.07.15.02.06.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 02:06:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH-for-10.1 v7 0/2] hw/core/machine: Display CPU model name in
 'info cpus' command
Date: Tue, 15 Jul 2025 11:06:22 +0200
Message-ID: <20250715090624.52377-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Since v6 [*]:
- Expose QOM type name on QMP (instead of model name)

(R-b tags kept)

[*] https://lore.kernel.org/qemu-devel/20250703173248.44995-2-philmd@linaro.org/

Philippe Mathieu-Daudé (2):
  qapi/machine: Add @qom-type field to CpuInfoFast structure
  hw/core/machine: Display CPU model name in 'info cpus' command

 qapi/machine.json          | 3 +++
 hw/core/machine-hmp-cmds.c | 4 +++-
 hw/core/machine-qmp-cmds.c | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.49.0


