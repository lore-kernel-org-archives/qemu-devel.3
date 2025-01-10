Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B168E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEuD-0004uD-WB; Fri, 10 Jan 2025 08:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtt-0004gY-M0
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:09 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtr-0004kj-Cu
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:08 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3862a921123so1337316f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515086; x=1737119886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/3Hjxcplq4p9qNo4qN9TNveaAV9bGLco5miclcArLM=;
 b=NAqX9mC74ISFdcsR1+ycmOE765zG9GIxJ2f+22TMlWLkRywzZmg054OqWOcFogAsT6
 IXy6DPPxvxr7CW6lPIMT25/y5iU1mvs/Y01WImkiOUpuJsMl82JdALh7rj8vxEGeumF7
 EY2ljmJU4+y+BkE2DSGvpMwp0DaBAdaJLDhhWa0JrTKy0io+htOhOMKomGI8NE8HPYad
 3gKnHKx+demGFgbNEKUusVWDb/1N8BKZraTHf2GpipUOApnneBbTPY0ttzD0sVSVDSDM
 8wEhWtVAfg48+fp+KN1Mok+fmKYrKPk9U0oWaoRr1CUOKwbYzakD9w+P9Gh4KQIGlVIv
 geRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515086; x=1737119886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/3Hjxcplq4p9qNo4qN9TNveaAV9bGLco5miclcArLM=;
 b=fIJoLJlzKR62SP1RoO0BWFmttLbQPRpUNzkezEzJrZ3f/4irbcOfs41uqm/tnOZwBD
 tNl9Yf4R+6tsJS4Yo2ytyBtP81HRgeBhDGH+3QKGlOXtLMni0nKLx37dbWXqSJ6zp1eV
 WwoCtzPLomvzgcWKPKpyzZPrjasZIzsnGd45eZ1z52hvDGxfJLfE9LTjEJeut62TRTL2
 CNT+l5O6iOZXI1JRoxFgKeQxA4z91NUm1AhCIkpS9nqzy9442YeD3B8vGl926oOMkmM6
 F14VoAl7Wky+PDJuAmGTGgDFPQJ6cGODc3wL9/Cd/qGgA0wngBlKfUHRHe15p4KKZBEH
 d90w==
X-Gm-Message-State: AOJu0Yxak2icBEnlitMTIofzlkK0Wfd8MqJIqmaypv/tlzcwgn/XIrFz
 fqI0BkSah1hHrNHcRwzHONgsr0JL0g7GpclcW4uqvHOFJ+6loWz1BhQ+pZoWaicBYsO78LlanOi
 F1KA=
X-Gm-Gg: ASbGncsW92yKWCI8vv8nf/YcLuotW/LfK4HLXPOvaakzdR11C7RXstUmsKD80IHi9u6
 g2fdJeth5BSwB26HAfGaetAtjZeGAmQWR7xHse23nk/gqBytaLNiMasA/gtKyQ9AxA/rscuw3UL
 FZitFkUKiuq1tui0S57b9s1bARW6vd8BMeJOgj3IAce7C2ezwkCSXla081mhUQVMgX28uXc0n8n
 lAy7uRQrlYQJvigb/h/HIQeHoknLUjkT99v6IxmvE3kZ+a8RfoEsGk=
X-Google-Smtp-Source: AGHT+IEBnj/yaRI8MaJFN0mano8sclac7W8V9mlYJ6qUK1L4aXvgneNbVpU+TOS7CDBsKNTLKVw1Rw==
X-Received: by 2002:a5d:5886:0:b0:386:4312:53ec with SMTP id
 ffacd0b85a97d-38a873049c2mr9684888f8f.17.1736515085582; 
 Fri, 10 Jan 2025 05:18:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d2dfsm4468203f8f.7.2025.01.10.05.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:18:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8186D61834;
 Fri, 10 Jan 2025 13:17:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 27/32] tests/vm: fix build_path based path
Date: Fri, 10 Jan 2025 13:17:49 +0000
Message-Id: <20250110131754.2769814-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

We no longer need to go into the per-arch build directories to find
the build directories binary. Lets call it directly.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-28-alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 4a1af04b9a..6f3f2e76df 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -520,8 +520,7 @@ def get_qemu_path(arch, build_path=None):
     if "QEMU" in os.environ:
         qemu_path = os.environ["QEMU"]
     elif build_path:
-        qemu_path = os.path.join(build_path, arch + "-softmmu")
-        qemu_path = os.path.join(qemu_path, "qemu-system-" + arch)
+        qemu_path = os.path.join(build_path, "qemu-system-" + arch)
     else:
         # Default is to use system path for qemu.
         qemu_path = "qemu-system-" + arch
-- 
2.39.5


