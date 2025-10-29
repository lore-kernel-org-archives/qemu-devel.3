Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AA4CCF9F1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8SR-0004an-Tq; Wed, 29 Oct 2025 11:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8SN-0004Y5-JX
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:27 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S2-0002ub-JT
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:27 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-63e0cec110eso12904269a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753062; x=1762357862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+sccIOnlRollRBUEGlbrGT/jg0uNfttKz/lur3Ex3hg=;
 b=MIr/claFZu/AxLwx393RY4PKkC/38qJbTkPfxgpA/vjK+cIPNvrja/V5H7B49Ivfgv
 9jw1BNK+//sR4E5pDZ9IP+mTHOmFMxNSN9et2ElqGW062fF5/7Y3SG0bfJo3ZMB1yVLi
 ca5+NKm/S1rB7YVRm0PF+bhnVbySGeZJn22S94euHDiVam+eSPgVEqrXfa1fViWTllce
 owDp2xkkeXNCRG9Q16mVkyhl3YJ/wF6eEdbnqbQGXR3Bl3YmqU92/ecXQ6t45PEk2Arz
 0fj90LbOF3UtqgCpj7naZHQ38ngR0r3jBzev3G0x1/3BsJp4NMSTsMMRTVoAZuADJzFr
 yl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753062; x=1762357862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+sccIOnlRollRBUEGlbrGT/jg0uNfttKz/lur3Ex3hg=;
 b=KLRTtI0oy1uBRjqKvhwUpaLToepxkmcL9kdR8VVF6haHxJTOHlCUyBvEXLxQQi8qHP
 1GzsGeKc0zMuXVf8DFwiLjTeRp8dYc0yo30UdjnTzUkIW3ENbqGTnlzCplYKUoZzT8v/
 +BJFhcXScuGukStS2nVcVsBT+JMfEfbhzSY+ctQAEUbRDCWVZlu/qS+grrT4v+DFZlZo
 7md+v7HSF+p1I/12bFQnf1NqZQWbSukeJIOTc+MpE4vkkYG19C9ric+QyDMFDXiO7TJt
 5LLLY/6l56N3ECN/snFA3HBpVLc8YQdDqvorNpLI8iHzcmgFiOgmIDhSf9eCvJk8d9+Q
 jCjA==
X-Gm-Message-State: AOJu0YzDFOV66owNZTyjIpUOi6P+wK/mleGoSsxaLKMQvuYNVLh7plZf
 tG0NnbJKLJMbsiuQ8km9+ZXKWiQF/8hwGFkjv+ZeZsZKGl4aM8NY+LjpfPDfcai+chY=
X-Gm-Gg: ASbGncszFuzMigO+MC7f6epZ0ZFLcSO7jdtdR1BQXwGDoY9oQXze/0pLv1hbn2nDR+q
 oJmzAZ1ySRWdJG0q794TBRAASOUuLRN3ktVqN71r17XBQmjLZ5g6uS8X4JDzaM/xn/KGi8NKtlw
 1IlCkX2E3pQBHiUFcYIqRykxpYICLw6Ow1GshiaP4uMVMAnbu3JmYeP1KyQx0WyFf2sM7yX/x9C
 iW3O++sdL5Cc7LjAGdMw1OJYjxI1TyURD1glcg7nYyUXC8m1v1xSd8nx3VM+MnA1Kq/PYHn3qKO
 KPkXlZHMLRB7A62E2ebvmCXjvvOMGSag0cDDnStEPdGgcO7Txcsw5hutSDEjHJLurjkcp0H2IIZ
 XkhEy29j7tvysyT5ixAlHMIizx2DHK1r5YWb9WVSlHOBed7qMn7lQN5JBd/xCaB8juO9hHrWr+S
 s0
X-Google-Smtp-Source: AGHT+IE+shmBgrMHRl7Pd04VR/EgZUFVQFpPy0OcMwEDJ/bqP+izozEZ06Nk2AfE/rhzFXaGbcVyUg==
X-Received: by 2002:a05:6402:2794:b0:639:d9e7:8051 with SMTP id
 4fb4d7f45d1cf-640441a9aa0mr2560321a12.10.1761753061956; 
 Wed, 29 Oct 2025 08:51:01 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7efd0bc5sm12269706a12.32.2025.10.29.08.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 374B161528;
 Wed, 29 Oct 2025 15:50:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sean Anderson <sean.anderson@linux.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/35] gdbstub: Fix %s formatting
Date: Wed, 29 Oct 2025 15:50:43 +0000
Message-ID: <20251029155045.257802-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

From: Sean Anderson <sean.anderson@linux.dev>

The format string for %s has two format characters. This causes it to
emit strings like "466f5bd8/6x" instead of "466f5bd8/6". GDB detects
this and returns EIO, causing all open File I/O calls to fail.

Fixes: 0820a075af ("gdbstub: Adjust gdb_do_syscall to only use uint32_t and uint64_t")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251027110344.2289945-35-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub/syscalls.c b/gdbstub/syscalls.c
index e855df21aba..d8bb90cc1c7 100644
--- a/gdbstub/syscalls.c
+++ b/gdbstub/syscalls.c
@@ -127,7 +127,7 @@ void gdb_do_syscall(gdb_syscall_complete_cb cb, const char *fmt, ...)
             case 's':
                 i64 = va_arg(va, uint64_t);
                 i32 = va_arg(va, uint32_t);
-                p += snprintf(p, p_end - p, "%" PRIx64 "/%x" PRIx32, i64, i32);
+                p += snprintf(p, p_end - p, "%" PRIx64 "/%" PRIx32, i64, i32);
                 break;
             default:
             bad_format:
-- 
2.47.3


