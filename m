Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B47EE57C2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vah0C-0007J4-HY; Tue, 30 Dec 2025 16:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vah0A-0007Ak-Ep
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:11:34 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vah08-0002tj-Qj
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:11:34 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso64181005e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767129091; x=1767733891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H4lmZbkpIbKlo+Cbmsb70+Gpr14aO3pvkdUUaISmtEc=;
 b=Hu4Jo4lYgfyOpMmkotlf3NOeZC41/AGek9U4y0n556bwUXEW6t5Sa1+G18Iv6AuDLh
 0R8gQTOm3NcU8+V8ZHpfyQn6hQdPdEfgvVyLyyUp7PXmWUsFkjIwvrOjuTedoC29Qvx/
 6FHGdDU3EEP9DUxy5KCMm+uC4xsh604ZtPs2gZUc7eiqmYw7VuirsqAOKmhpkJrKspQ6
 fE5ZXICoBMK11Vkhg8JSRehkIjCihL5kwZsyJtnzAkslSzCr7umaH6gHgk65G8aIEzn3
 POdVx4aFTdkd+Y04p6OtWUrntBHJW8vTPQQ9hf4XU4NGrEL9eha/pqcyaisRTN3oKRUb
 dOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767129091; x=1767733891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H4lmZbkpIbKlo+Cbmsb70+Gpr14aO3pvkdUUaISmtEc=;
 b=D5WMLICO+ZTPoQbriivrMIKg6uLWJKws+DW+e74NVNWNQ55cjbqsqq+kmsYlcEJ34B
 p8ox22m1HCWf0d4hwOQKDUcTSvCKgzsPPeW8xURBMyTMbxgfrqxTIIWcjGVzpj2wgKpT
 0ptP3lT6Ribbt2JWE450Mk5sBOLhh4vZIjwEM2X7wq2vJR/hrkw30D3Rr6DnDRd/kvqg
 lnpOKPhE/Fj9DgxrrMuXBJgobm0QzGEr2bQ/7thj3Ol+qUfq95SnSOnjyfE9Qjq9zw3X
 CeYgCrbSxLRekbsDYyu8KvP3EQUms/D3vtunw49n2gsR0TcJ1dqNcXzhAQT/xQ7ZW+3z
 w5WQ==
X-Gm-Message-State: AOJu0YzlKbvCij+IeZBBreQ5cThNapm65J5xO/AIOBGP7ogSX4dn8kOH
 WuMfUM41jURbPnfTaTtygHYI4QNiRvyG/GOtWUYstEoh62Bb2Trn4pnNjefclbtIxgDiRtcI9hf
 dcm7G0oE=
X-Gm-Gg: AY/fxX5Zt4VE+acJUly2z2U8qRHAthQMGAKXiLHW4l1q8wvHH42vgDS6aTiQ0bLdGX0
 Nv6KmxUkm02CQrIvHlFI/j3Z7mYUknZPeLgIhcoZTDOA3NbYLXNQvpVtca+msH82iId1nLMCv39
 3TJfgYT8ZHoWaUZqpiIg7IW7KN+j+n/XgQ7sFFRcb22ebpN7YP+6M/7xrIgrR6J6gVLKMh2qrZs
 rgOh4KYLv6HmYL+FawssOvG5ZpqOwbjBTXQ95DPqMkmjoSzXrJ22uY/0xCSGYdko6EsFrEmxXhV
 VR83IPIaohU/dp50Co+Dh6HoPxWcyjojz+JT+RCgBvkz3OXSM7r1hJ3f2CMAAuHJ8OQlLZh6ikC
 I+oVbxGIZs1QSyplohKV+zdO+a97NNPojQADBEnid9bY4hgwUFW4jOPmQ4UMbKxni3BnOHlag1b
 B74Efwxf96lGnvKFFMCR0iL7RKKfI0V5CeE4q1lknFS4ir7dcoZS10+A7amb6i
X-Google-Smtp-Source: AGHT+IGI1+kt8tkkyfZ373Hv3dpdD98aEP7ptvaUpzxoq7ROk9LtEntYWqi/ouzJNJYnPoEKDNQZyg==
X-Received: by 2002:a05:600c:470a:b0:479:3a86:dc1f with SMTP id
 5b1f17b1804b1-47d1958e43emr322603395e9.37.1767129090876; 
 Tue, 30 Dec 2025 13:11:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272e46fsm647306255e9.4.2025.12.30.13.11.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:11:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/34] meson: Optimize summary_info about directories
Date: Tue, 30 Dec 2025 22:07:54 +0100
Message-ID: <20251230210757.13803-33-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Bin Guo <guobin@linux.alibaba.com>

Clear summary_info first, otherwise there will be redundant output
about build environment.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251219230456.37178-1-guobin@linux.alibaba.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 8111e62bf12..db87358d62d 100644
--- a/meson.build
+++ b/meson.build
@@ -4650,6 +4650,7 @@ summary_info += {'Download dependencies': get_option('wrap_mode') != 'nodownload
 summary(summary_info, bool_yn: true, section: 'Build environment')
 
 # Directories
+summary_info = {}
 summary_info += {'Install prefix':    get_option('prefix')}
 summary_info += {'BIOS directory':    qemu_datadir}
 pathsep = host_os == 'windows' ? ';' : ':'
-- 
2.52.0


