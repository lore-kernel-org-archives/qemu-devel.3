Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B909F9B608
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUeL-0006yU-IH; Wed, 22 Apr 2026 06:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUeD-0006xy-TU
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:17:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUe8-0002MZ-8D
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:17:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so19902685e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776853046; x=1777457846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rop61lo3CsCy/AA+flQ6RjC7mnHYxt45F3om3vFlXxk=;
 b=dgQmp58Fs0NsPN5cCZ9jCVqKhIuJ/Y4bg01PcHOneJGIk5Es5VqpTlbybpn2U/rseo
 qeTfx/HLt4yCGHietOInV4eJhNwZLSUj8W3Kehe+YCpjGvxuP8CdqQSHzOk0i2RJTVuu
 vuJ+B7mnOXeNhirJTebe5QRMsgam6Qpj+x6Bz2tnVwn3v8UiJ6eCm0qgpHjQPSv2KfNU
 W+bVbTG3pkV2pfp5682qTCifYIjA+mTbOl2r5/qFacGCAyLVIR8ld875r+M7npndkxqY
 R9nJ7SXZqe9qgUHVzxg8TmtMX38vLrq7MxfDnJ2CVdl5aoCcTMw4Su8FLMoxoZ9Aipw1
 lY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853046; x=1777457846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rop61lo3CsCy/AA+flQ6RjC7mnHYxt45F3om3vFlXxk=;
 b=OrZrEwecbUnXXVKlNA4WMV7PixbBEcqAFnliKl7524wZqeAC50fb7cF5499RRsHHdA
 BS3QfNQ/xYpEZ/tx33JsvbkNleMIRB8SyvEhUJosY4j685TO9KbIjP9mr0VYk0NnqrO1
 1nbGQB+UnS1u/EcZ4TaDOXVkdRbWktBytXQs2/ROkkTUCUpnbHMRbnb2cYbKoqmccf7u
 kgGcbF+LLKcqssz9I/23XjBEIjQ4MVoHKoaxyV0XGOKyqrTErLK16UPT4zgJoX9FPQRk
 U0s4ozjn0f8uM+/sLN2pvDjFOIWnS5MtQyItU9IsArtP0ctit+HgTIHsMInlSgjPg1YP
 cSlA==
X-Gm-Message-State: AOJu0YwOi1KcvVikRcOvaDASLTEdNRwJmSZSvJeNsBgRjdiSRVtMGxKy
 FvHjPyTAR3+/O5shOdyU47bxaTxPrrgG1XEh+iGjQWkjYhx//UdT4GMrf6G+77dMfPg=
X-Gm-Gg: AeBDietbmlbuRr3O3ThgudkmizktdnXJLLIksabKzyq8AlfJ8TsNRJS31WvBZ696dKp
 QBv36LJZSisExrMnkFs5IE3WcByTz67VAUSyKp6ciDHn3XGQ5zQk9kPBvTHf09nCzwXoucPo4Bi
 t9JF6IDjw+2VohGQ6dipBRiHSusIWw3mTgD2hV0ghc5yqQjlH6F3JlTqBI+S3eqtrTJSXEQFn4G
 aHAX1q0sqoC9XUsWSMuLlt+vhAW/QR95bpXs7HD0GtFt8NZVZaC0kNAtvhJgUwZtUuNdcrle0oU
 VtaXYgokNwxtldaC7P3NSvZanvHEbeSFmyE/D2qyLdsPHg/7Pf2frFkJWej2Xo2K4CP09H1Bi8J
 laW5pegfA7LPm6xnPb0OJSK/beHF4U4INxC85FWlQqDKcUMOkwzTIVTrYgUzhiQpLQoOJPR0IF9
 c881ZQDOjpeuTYh53W3lOSXp34Qt5WK8s2Cg==
X-Received: by 2002:a05:600c:570f:b0:488:a502:8955 with SMTP id
 5b1f17b1804b1-488fb882f13mr231449795e9.4.1776853045759; 
 Wed, 22 Apr 2026 03:17:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e46898sm46560662f8f.27.2026.04.22.03.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:17:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 08B4E612AD;
 Wed, 22 Apr 2026 11:10:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 20/31] target/arm: use syndrome helpers in
 merge_syn_data_abort
Date: Wed, 22 Apr 2026 11:10:31 +0100
Message-ID: <20260422101043.1234229-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

One more step to removing the old defines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 565954269f9..c74d8e785a6 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -56,7 +56,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
          */
         assert(!fi->stage2);
         syn = syn_data_abort_vncr(fi->ea, is_write, fsc);
-    } else if (!(template_syn & ARM_EL_ISV) || target_el != 2
+    } else if (!FIELD_EX32(template_syn, DABORT_ISS, ISV) || target_el != 2
         || fi->s1ptw || !fi->stage2) {
         syn = syn_data_abort_no_iss(same_el, 0,
                                     fi->ea, 0, fi->s1ptw, is_write, fsc);
-- 
2.47.3


