Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DA6CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 12:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umtWZ-00013s-OF; Fri, 15 Aug 2025 08:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umtWU-00013Y-1E
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 08:27:06 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umtWS-0007X4-6X
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 08:27:05 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76e2e613e90so1488748b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755260822; x=1755865622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkrjW09kols9H4CfSULpmG4eFAOBOauSMA2uXFjtwNI=;
 b=h4y+o1KMlNtu6eeqKNxeOs+GTex38z1UVFwD5Y49LVDMYg9YKWEyDED9Yn9TtTPSPm
 A+gIu+ETYH2zYhbORx331QZzEciHnRc21zR1K8LvfEvLrlhjw0k1Vs5L0SxDPcMmnBaN
 JB253j43HcEOGttLykyN9gL/K9oUrJBpKPz1NKvYIOqcC9GOBDr5LBVDmcdnRQJidcae
 5PCkB4A3IjVmEfTq7876LVHHbiioyJLnNqwT2rruiMIOLCSDntdreTYcvlnUrsMhz5jD
 8raGNpop0SXzcWsa2Z3J9K0upjG9zUU0ERt+w059IPExvcC1/v1fKuEmQedrIlOoik3j
 eevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755260822; x=1755865622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkrjW09kols9H4CfSULpmG4eFAOBOauSMA2uXFjtwNI=;
 b=JxVpwjPi9+32PSUl9s931nSIo5gUbeJxegA/82c/EZiFUnaM6ct9Ja6kUDbMQd2yUA
 pXO1qkicer7cZNzOr5t9Lq2+bhzj4IOD87E8oiziUKuVFfT7HSyR4tBxxVQG3SWGtyEZ
 bjDZXCF5Eh4Gdx//OFjHx90zYr20V9clrumvxPoUPT84cNcAjDJV8VXfDYhrP6bx87A8
 2gi7tHqRnJhxMDkDH2NgQLMuBw+IaZ7mxB3o61A7F2eQxGaugHaziBpunKyRF3YFUk+s
 az/6P+kTJrh1PYYSMg++LCCOJIjPVBiaxcvEQWPkp88/zoPdxeJLU7CZ19lLY2HL3vaI
 AGww==
X-Gm-Message-State: AOJu0Yw5NOyT0amDnXgzJgLxlSyFnTTqXmAG636liDIFH05oUyYirVeI
 FRbnDRZnxQ6wGuERzr3GuBqAT7CzOsVkjBk0Oa595ZFivktH7HsEJshEcTuljy/PRGllPAxrrYi
 +fAG++hU=
X-Gm-Gg: ASbGncssZdrHEM5FYf1UIEcnE73sf6wvmPqQSPlDc2jpOuQeVXqqV30khKra1Nb+e4j
 vOenFc9P9ipjlS8BscGLKy/Fz6B+KzRKFIB59T2JdjduN/vRfn25+N6/Vjecwh0rtN35PW54m8J
 Mw0aoyETl0YCwlCyi1STLdDQKTOooQbnZBBGaOmrbH+4owUg/4JiZzjUeihexhGz1HAfNuGFVva
 iCcO5T9Mr7Aq8xZdnWleOodYT11qigBuau66mqajDGfwFdhPYYqTQufiEYqed49D0GJmlCwG0zt
 S0CaCl/cdUrUSP/O6i8gg7aJS5WlDFtdTOH8qq0yAy7+QP9akNbc8cEZ4HQ9fIPqkdCwbk5PMDq
 wj0vdY4yzu2fJcL13O2H0puFPgHKk/uUp++Anhe9XMcYv18w=
X-Google-Smtp-Source: AGHT+IEpEPSZcvvxeqUlhvtOkGlaDp2xlyN0zTcO+aR38Nj6tWc2Ot5uDBqhhrjpBo+vv+/uFnbvoQ==
X-Received: by 2002:a05:6a00:4288:b0:76b:d7e7:f1de with SMTP id
 d2e1a72fcca58-76e4481c097mr2127214b3a.17.1755260822589; 
 Fri, 15 Aug 2025 05:27:02 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e45292c86sm1053475b3a.48.2025.08.15.05.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 05:27:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 1/7] qemu/atomic: Finish renaming atomic128-cas.h headers
Date: Fri, 15 Aug 2025 22:26:47 +1000
Message-ID: <20250815122653.701782-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815122653.701782-1-richard.henderson@linaro.org>
References: <20250815122653.701782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

The aarch64 header was not renamed with the others, meaning it
was skipped in favor of the generic version.

Cc: qemu-stable@nongnu.org
Fixes: 15606965400b ("qemu/atomic: Rename atomic128-cas.h headers using .h.inc suffix")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .../include/aarch64/host/{atomic128-cas.h => atomic128-cas.h.inc} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename host/include/aarch64/host/{atomic128-cas.h => atomic128-cas.h.inc} (100%)

diff --git a/host/include/aarch64/host/atomic128-cas.h b/host/include/aarch64/host/atomic128-cas.h.inc
similarity index 100%
rename from host/include/aarch64/host/atomic128-cas.h
rename to host/include/aarch64/host/atomic128-cas.h.inc
-- 
2.43.0


