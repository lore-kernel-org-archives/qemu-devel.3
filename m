Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B5DC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgma-0006l4-2F; Mon, 24 Jun 2024 06:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgmX-0006kU-OT
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:41 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgmW-0007eJ-3p
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:41 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57d280e2d5dso3868654a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719224318; x=1719829118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YP0Mfaa8TidAoBaCJkmfwZz45gYzsO0OgSu5WsDjDig=;
 b=MiREaZaFoc2AVznp0DA9m82WvUVOW33SuQoV3qXafPTenH6aoCwyiYwZcAJh8QLYBs
 n1gZpNheTI0vZLWRrYiyEOGHHIPCgAkKMl+j5Gd3F1bmJAdt3YbeU1h3o1KpHJ4uKBi1
 m9qUQAqQ5Im3YUpL4AdLS9ogLJISGA45VxQmEQ5FPMD/1ARiC3h9HFGircJdiUo/FP61
 fA6m9ncR0XOtff9n32wx93NGb3xuqypIu32NVfHaVnohSQFSuC4541Ri+9573o6cEM3D
 JrSZWOVVMCjbWMzv23jFlBJl3RPYWJiacPnupdenyU7pRWKdlh2qy47wp4UULoHcgDq7
 biHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224318; x=1719829118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YP0Mfaa8TidAoBaCJkmfwZz45gYzsO0OgSu5WsDjDig=;
 b=SsWOR3Pxf8SnhFM2T2SFPqDFhZ22HkcoHqAcDsrTwcnE+P2Py2pISgdUnHGxRT0SyL
 U1ok3rJJg4YCxL1b51yCwf+afeXSiNn+4sptMzrtgOByX5dcC6LPAgzhTR4MTM9Adxff
 IvWZZbg5Pruz2tsUayuhz4z27FQUSmnzBIW4xozsyO6Q7WLzl7Hcqv+ItsJtB5awanBj
 yyuAoo9lo60Ky/4b/KlWGhfBWd3d6XbXu/F/MU7oP804QaO6216VREKAYjMiAyuah94G
 rRXbCKaqgIeQ2wEwd3yIhgB6Pe27Fa+bzBgPXk4a3ZFHAU5U9o4h3eNOaFhoUcPthqxj
 xUhQ==
X-Gm-Message-State: AOJu0YxBCj983BdOC/lwqgJc0llBud9//FIoKYL3vbsf9ioFAqYgeZYq
 9sgNrxCl63uVi1m0KPhkcrwIl4usDFFj+EbZMXcNSe5jnrU5f/PiQLhkBqQzeQU=
X-Google-Smtp-Source: AGHT+IF4essl0D3NCh21YCVBk4QmnMUZNsoHttfpzdI8If1i1Ku3Wd/clzMBdtd3brt/2etryP4u4w==
X-Received: by 2002:a50:ab01:0:b0:57d:5388:bdd3 with SMTP id
 4fb4d7f45d1cf-57d5388bdedmr1803171a12.10.1719224317986; 
 Mon, 24 Jun 2024 03:18:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3042fd17sm4556554a12.47.2024.06.24.03.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:18:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5FF055F956;
 Mon, 24 Jun 2024 11:18:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/12] include/exec: add missing include guard comment
Date: Mon, 24 Jun 2024 11:18:25 +0100
Message-Id: <20240624101836.193761-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624101836.193761-1-alex.bennee@linaro.org>
References: <20240624101836.193761-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240620152220.2192768-2-alex.bennee@linaro.org>

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index eb14b91139..008a92198a 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -144,4 +144,4 @@ void gdb_set_stop_cpu(CPUState *cpu);
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
 extern const GDBFeature gdb_static_features[];
 
-#endif
+#endif /* GDBSTUB_H */
-- 
2.39.2


