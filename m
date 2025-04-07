Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C924EC36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 05:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1emv-0002CF-4j; Mon, 07 Apr 2025 01:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u1emi-0002AQ-5v
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 01:12:38 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u1emb-0008AV-Hl
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 01:12:35 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so2996095b3a.3
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 22:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744002747; x=1744607547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8h5dcOrcAbddHzeDnTj6if3eCBS5+25SAQ6FwH4xvYw=;
 b=VJZg5jABmcPrQYtUBk/Gf/XQTpfGljmY2dm+EuK3BXZxOoIfWL13WNM2e+fq1fdpJu
 mW3mp6cKkjNmYTuXJT3fY/WSMUss/qQ8+4bbXskbyJHe2STcd8Gn5RKXzQiv0axg4OFR
 h+iODtv5fGgFyOG9jNCScbhwJpaoP3DzBSI0hox+1cwr/N0HiTp5hU1FlWdzqukPSkHR
 0oNy0qhGTZNkoCH7qzrT2O8Pfpxiq/aTRNdi8eexo0esf+9jBTJJeJYW8gjQSzygJYkY
 jS3vKfnKJzTO4bemsX1Royrk4iW+G4zcs3kxzoGysn570vwtp8ae5zozOJ4zTV3uuwsa
 Nsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744002747; x=1744607547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8h5dcOrcAbddHzeDnTj6if3eCBS5+25SAQ6FwH4xvYw=;
 b=A7WH7QJbgTkw5coTGVpJuMmieDGWy48tk8OlFl007ZeaCBbgXN7/VAPKxxrgBh9CCS
 oan9oEMALNQULPVTh6TwALrdkdnbqde12dL+CACyyExUe1c3boVfU35pNd0lqpZsQT6T
 L5tVT6z4kvlijTif67ot0PObs8kActZ2xJR8tF5k6bF3/C3QIMFcnjD2YhMCKGkF+BON
 pWysT7U4ZbNLTx1pyCf/R3EVB3dD9Rinnuc9LMa8xwkFEkuT86stWTBmz/YZGGjoV8gy
 BPPL0kVo2DKWTtrTnNnySMiswxRea9MFcTmVRLeugViw4w5jolr2Z3voAYyBpmr4Yn5b
 A6aQ==
X-Gm-Message-State: AOJu0Yxl+JSw8m7xibOF7b6jKB4OUXvEU7jsMgtkvYZ+NLE6jrhkYgIt
 VqBdnZ/UvAsS5TUcKMTAN2skk0wI6Ql0fb2s33J6eFoSqQC579h8O0XrVA==
X-Gm-Gg: ASbGncv+66Oq+NovSDaS5LRAXWvIbv470fZ2tG/KbOwtiEhpZ2AK3+CUO7nTjhjJPqZ
 IQTbWM69ZdDAEMcw7gO52d4NFTPGGXmISOXz3l3jMywFkKCIDu1DWn7rwUxLYzWQXfuN4qajOuH
 Ttl1IxHUtH6l0Cl29pProFjcmimAzPJ0ecagAyY+pDZW+CuDKDY+rj++DLO6yB+4fiAjzsjASN7
 HGjKe7lKPKkk/o+IBmqdB6HGJ1Q+Z9pWbl7tOM6RsQ4y+QUPhqxOBvEF6kLJFhq8u5ddIMDhKpm
 QAlJblw0PgbTcLrsbjoHity1/q2a89nTSCKrJckNIMjKhwMSW9e6bVPRwbHTt2gu47r4liv8WU+
 qcA6ydMCZD40Cbo7Cp+jEup2cIXGpm3h6yMr70J94Krdgzps1aSs=
X-Google-Smtp-Source: AGHT+IE2WTij+q6TPl+/pbEJZQtMLxK69jnJEjyVCHeogWqjhvY2G2MLH3GWiuzhGbd9trQmu+cZsA==
X-Received: by 2002:a05:6a21:e95:b0:1f5:790c:947 with SMTP id
 adf61e73a8af0-20113c7158emr11357919637.19.1744002747223; 
 Sun, 06 Apr 2025 22:12:27 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af9bc41ae31sm6435665a12.72.2025.04.06.22.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 22:12:26 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/1] docs: deprecate RISC-V default machine option
Date: Mon,  7 Apr 2025 15:12:14 +1000
Message-ID: <20250407051214.95248-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407051214.95248-1-alistair.francis@wdc.com>
References: <20250407051214.95248-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Commit 5b4beba124 ("RISC-V Spike Machines") added the Spike machine and
made it default for qemu-system-riscv32/64. It was the first RISC-V
machine added in QEMU so setting it as default was sensible.

Today we have 7 riscv64 and 6 riscv32 machines and having 'spike' as
default machine is not intuitive. For example, [1] is a bug that was
opened with the 'virt' board in mind, but given that the user didn't
pass a '-machine' option, the user was using 'spike' without knowing.

Being explicit in the command line is desirable when we have a handful
of boards available, so deprecate the default machine setting from
RISC-V.

[1] https://gitlab.com/qemu-project/qemu/-/issues/2467

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250404122858.241598-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/about/deprecated.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 76291fdfd6..0f41a99c67 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -304,6 +304,23 @@ online to check that this board did not completely bitrot yet). It is
 recommended to use another MIPS machine for future MIPS code development
 instead.
 
+RISC-V default machine option (since 10.0)
+''''''''''''''''''''''''''''''''''''''''''
+
+RISC-V defines ``spike`` as the default machine if no machine option is
+given in the command line.  This happens because ``spike`` is the first
+RISC-V machine implemented in QEMU and setting it as default was
+convenient at that time.  Now we have 7 riscv64 and 6 riscv32 machines
+and having ``spike`` as a default is no longer justified.  This default
+will also promote situations where users think they're running ``virt``
+(the most used RISC-V machine type in 10.0) when in fact they're
+running ``spike``.
+
+Removing the default machine option forces users to always set the machine
+they want to use and avoids confusion.  Existing users of the ``spike``
+machine must ensure that they're setting the ``spike`` machine in the
+command line (``-M spike``).
+
 
 Backend options
 ---------------
-- 
2.48.1


