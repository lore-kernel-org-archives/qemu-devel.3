Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F78C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 17:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXONL-00037S-IB; Mon, 13 Jan 2025 12:37:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOMn-0002L2-6j
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:36:48 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOMl-00072Q-GV
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:36:44 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so32067885e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 09:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736789800; x=1737394600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HyhgHy5lutIfTsw5uCOmzhS68O1wU1WLlga8mlFXRVY=;
 b=PFZHJVVsckWNauKHEOMtPaEGpbye3zVcihsoBDeQhFDswHYftoAGDa2mTh1IVKvwec
 tkVSCBb/cCMzMNQbefhzSd9CT87Q6468AAw51QmLZ0Y2hqlwTjpf9FoTq+ZwpbrNJ5fh
 ioBBailgqIRKmXQcDNXC1m43o1ss0m3xcu+0snlO6ymK0/LsYl1tFHLl8eBGH3fgHsF1
 JkFsaZr/Dw1iZRD0c3z3I+sAUqrcFbdqUAhr/YnbHE1/zyRy7kiTA9i/WkiDFWfRA/lb
 NjX1TLsgnlIqet413kUD2qJ3ZxIANR+c8jG9fzQhfKYPFNjsja6w8B4qTMU2eHp4e85k
 yDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736789800; x=1737394600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HyhgHy5lutIfTsw5uCOmzhS68O1wU1WLlga8mlFXRVY=;
 b=Gm5TmGe9Uy2i+UqnklRBVEcdNE5WzCm3ac5jHhWPUNZGls4MkKOECXO4b39hCZf+qk
 73/SKT0THsCjpdPlmGKGp4hQgXo2SXvetL5CifploR7m9bf8Nkwt7l4vdp+kLd9FlKH+
 Hz4mj6KDrCb5ndCb0iMcqT7RA71jFIlOdjr1QgQgxz9fQZ8EtMSpT/0aNEqeNKrpeCNT
 OhcfUJlZbvdButPNHalMUo7AYRwVOIAPRvCwbg+zJivBBQUsCJNOQXvvqZuQnPY9CzCx
 79nLpSHqp+vbZGDMGgyiX3Z+/HiepBqQNdKt9k7O09PRoZit+mR1TkMcJ3goNdbVol1K
 5LYA==
X-Gm-Message-State: AOJu0YyfE97v3jdnavwsVucSICKTmmFqdCwAkBoqGNPkZPqYaw260du6
 fmnUX/J3YgPKkWGfkNeBe3qvoxA5ox3yRLneRFKf8zpbtDhw4PsQNcDAqg1WiVAFl2pY23VCQuv
 ilcg=
X-Gm-Gg: ASbGncvvmBQ9gj963z2NpkvycwvwlWpzf6VZwyocuej+9mqSMDqJ+fCcNvkw6TWxgpw
 HLARDyhC49Hlw3oqdrJLbd0LouyNgHVFtILDrjkyAqYw4VENMn6iCbUCsc0irwPNbQv0/biUu8a
 dzL+oWzrNJaqeyz505Oe6ezFlwZdNEqNG7e6/OjcZo1eKKPE0rIXnP9VcAKLsyN2WWo8jMWyJ9I
 u/let2MJdI68GMm0XAeHKS8XVznY3dn2kAz9Cl1Y+uztNZ1X+81lx/cPw4turAvVl9J8lHa9cSH
 gmbGbrvkJsnTzsxeIKWKBnJPnE1sAak=
X-Google-Smtp-Source: AGHT+IEoY3bsXDrrD3aeN/d6i958cc60AwLxNezTQJHLt7RiCOJL5StT1QpPrYrNd3YuVCkizywDyg==
X-Received: by 2002:a05:600c:314f:b0:435:9ed3:5688 with SMTP id
 5b1f17b1804b1-436e26a1f79mr218206415e9.18.1736789799982; 
 Mon, 13 Jan 2025 09:36:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da6336sm185094455e9.8.2025.01.13.09.36.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 09:36:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Signed-off-by=3A=20Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [PULL v2 55/55] Add a b4 configuration file
Date: Mon, 13 Jan 2025 18:36:04 +0100
Message-ID: <20250113173604.46931-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113173604.46931-1-philmd@linaro.org>
References: <20250113173604.46931-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

b4 [1] is a convenient tool to manage patch series with mailing list
working flow.

Add a project default config file to match QEMU's mailing list conventions
as well as adopting differences on scripting.

Examples of b4:

    ```
    $ b4 prep --check
    Checking patches using:
      scripts/checkpatch.pl -q --terse --no-summary --mailback -

    ---
    Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
    ---
    Changes in v2:
    - Add lore masks (philmd) from:
      https://lore.kernel.org/qemu-devel/20241224135054.10243-1-philmd@linaro.org/
    - Link to v1: https://lore.kernel.org/r/20241222-b4-config-v1-1-b3667beb30a4@flygoat.com
    ---
    ● cc5a4c890fed: Add a b4 configuration file
      ● checkpatch.pl: 27: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
    ---
    Success: 0, Warning: 1, Error: 0
    ```

    ```
    $ b4 prep -c
    Will collect To: addresses using echo
    Will collect Cc: addresses using get_maintainer.pl
    Collecting To/Cc addresses
        + To: qemu-devel@nongnu.org
    ---
    You can trim/expand this list with: b4 prep --edit-cover
    Invoking git-filter-repo to update the cover letter.
    New history written in 0.02 seconds...
    Completely finished after 0.06 seconds
    ```

[1]: https://b4.docs.kernel.org/

Co-developed-by: Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <20250102-b4-config-v2-1-cc7299e399bb@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .b4-config | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 .b4-config

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 00000000000..4b9b2fe290f
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,14 @@
+#
+# Common b4 settings that can be used to send patches to QEMU upstream.
+# https://b4.docs.kernel.org/
+#
+
+[b4]
+    send-series-to = qemu-devel@nongnu.org
+    send-auto-to-cmd = echo
+    send-auto-cc-cmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback
+    am-perpatch-check-cmd = scripts/checkpatch.pl -q --terse --no-summary --mailback -
+    prep-perpatch-check-cmd = scripts/checkpatch.pl -q --terse --no-summary --mailback -
+    searchmask = https://lore.kernel.org/qemu-devel/?x=m&t=1&q=%s
+    linkmask = https://lore.kernel.org/qemu-devel/%s
+    linktrailermask = Message-ID: <%s>
-- 
2.47.1


