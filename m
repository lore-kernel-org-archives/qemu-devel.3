Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7423C36017
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 22:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzNNL-0000YK-98; Mon, 31 Mar 2025 18:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzNNI-0000XM-WD
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:12:57 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzNNH-00075l-Bu
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:12:56 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso37953325e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 15:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743459173; x=1744063973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uGeanX4YC4zYH5MMtKamuSE7l3hBKePqC5xHGJjgb7g=;
 b=eJDdBho+IfQNMdC1No4hIy1fPKILtXB/CYlI5lamp+UX7qd2GY0eWaDjQmsTl4obh3
 597JynuG08gXdXg9hMfnu8YH6eBVfpjNvDzU+65BDnS4j9yWS84o2bEAyZPGyXI/vxVK
 ys/IzGSII1cELqCOPVwAeA2vD0NDH6CeO6LrM2CuQiZivVgkjL4YPiWKj4tHIwXxf+XC
 nitUufo5G/+uUOYRau9etsQ4PVAesfFoIZ65t76a5CSXjcdLQp9+q1UPh1SJlQ+L4N7f
 laLwDTY8z5iEHKVOcaXCVfoumURWPUZUqzvbY5e3kHt+poIlbiP0HxR1gac7VGvUhxgO
 4yCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743459173; x=1744063973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uGeanX4YC4zYH5MMtKamuSE7l3hBKePqC5xHGJjgb7g=;
 b=eBdiczPPaTG8+dr/X6Zgd+9OaYf9S8ruUH2AC5souoLEkDJTHYql2l62ierlbARLvV
 EmUmLZDZeO2PQh6JZsxJbRgpi0BVLzp/ItUtsqPyEYDec+q4EymFOSmwibik8Vw/H4ed
 MZFSIT2VXU429v/UgKOidsRGft63FFLybIE11AKo4mA5JFiThnAkeurryxUwVA0rMLkq
 ZNh7KrCjlYTNHNrdrOj3EFXoLyOOMTXNymnvR44SktBH1iSbD1c5pLTbZ47uqIOHmeTM
 MjyiqCm2nHhUNFtM1DeSCAt2f/pYgXkwik5FHdILO69Xd0qryPmE37Rvu5l0OuLVe2A4
 Ck8w==
X-Gm-Message-State: AOJu0YycgD5YfkLWp8YEkCdw1kLoQkMjNbC1hbtIoa7isqQi5HKV59il
 QnWAUb7q3jX5RLm5aW9E1RjE2UPyIDf0U51eE8fjx5yL1J5GAVd80PNfwBlgpsMjxxVJ3fnqGmw
 6
X-Gm-Gg: ASbGncupNwSvYMNL8EmtwztinXi9oTy/JOE+HZWTr3MUbPtrXDBzlgdFmDLgsVWDPUP
 TFnIKz+tQMhlyP6Ov/L7a5g5TqAcExtOutSYHvfk+/x2x6o1ruv+bOkzPxIbvgun5I4RNuSw3k9
 NnrKBRYy9PQz8hevwGFLyeiyCy7qCWXnMEG7Av351JRj5zYFrTMpvMxs89vE9MNowzOYDjTe3ss
 BdlYKzWEi1kBHjQdJ+grhxv/tvAMF8wHHR0pI7he7XcEJbGiIu65TzEfoTjzfiv8fIOLMfmAcqt
 pDrgO3BpY2cKzJMtA3rwiE0M8tTWgk0baamVY9gK+Na+LEvRydnfs54EkLlrjCcS7zqJAcJxiGB
 sVPbd6v2ez5HXpo2QJj4=
X-Google-Smtp-Source: AGHT+IEqp3dEjt2dLIBKi+b6WRrizbdDxAnl/GVUCkQN1MSA/iLfh2Nsm2iOuTWkIwhzGveUSTvHHg==
X-Received: by 2002:a05:600c:1914:b0:43d:4e9:27ff with SMTP id
 5b1f17b1804b1-43db6222510mr85971015e9.7.1743459173679; 
 Mon, 31 Mar 2025 15:12:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6627bfsm12205438f8f.25.2025.03.31.15.12.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 15:12:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 2/5] qtest/bios-tables-test: Whitelist
 aarch64/virt/APIC.its_off blob
Date: Tue,  1 Apr 2025 00:12:36 +0200
Message-ID: <20250331221239.87150-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331221239.87150-1-philmd@linaro.org>
References: <20250331221239.87150-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Prepare for ACPI table change in aarch64/virt/APIC.its_off.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf..bfc4d601243 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/APIC.its_off",
-- 
2.47.1


