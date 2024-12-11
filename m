Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC13E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPT0-0002K2-NS; Wed, 11 Dec 2024 11:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSq-0001bz-5E
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:28 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSo-0007vJ-Gq
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:27 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43618283dedso16754255e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934085; x=1734538885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gSbZ33dYhUCvriB7gJIYOSjh0uJ7qwYxR0y7su+tpkc=;
 b=KRE/1KwIeFrD58JIyaLgz64RScARneDJwpxkS/FS6ViUjeELV/trhloF/8vDyzA1ci
 i3LEzNpUUHiXRPmYaNTkb2wwyOyJWi23R0SZFsxyIG86apvEVlOFcrl6fNMA9Z+IUmpT
 gnG5nJzIYJJB4b7TyUjwFTrYPX4LUgNKenjgoizJq3yW46yL7FwY6U86KXC94i0OE83h
 c/q1NPx4eDUUWXMV/jQPn4XqVdP+XM2XxHBKxgKebaUuA4RlCoSbWKG0kLJ1ObyWW8jP
 4NfalotmV8UYdqxlflzXaxTCuUSPTSGBmv7Wbpcv4KzyONGjQM+AvyDAQt7f8U3MuZWy
 pCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934085; x=1734538885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gSbZ33dYhUCvriB7gJIYOSjh0uJ7qwYxR0y7su+tpkc=;
 b=s05U8bICx92m4aRPcv+z0ppH+MyzHn3Qe0dLi8T6xlyRYSKSa5SVbsJ8xQ7Ufgtumx
 m8MypPVA1xdAfrP1yU+7C6D26NwBVFOT9QK20q8FUFfxgRyaDLCkHJV/8EKc/tVhBWgv
 dtA0srs3SLNEq0yyYXJfSc0vHIECq0LkETlRbmh6cAKQVc0ATIGZBY3eLQ98RtF6wX48
 DXpAqMBzEnEAezyAWiwLfKen3hMYRwdRv7FCm+BUxosU4vf0ouka3i5jOM7pz79xkF8P
 9OSqebMDy+d2dBiuLlZTCQoRBR1HH5ILGx7OkRWZQJoQb0NTk9SjYmh7Cwf0TAAyIjft
 8UxQ==
X-Gm-Message-State: AOJu0Yx7QaNRg75iDceTGZu57arMf7RsOf3JREUuVCB2b+kB3Fq2gsYI
 WLqcbfIbZNwNhe0ZtrUxmDPuctq2UQO1QHBoS46PHUVVl5ncWmI4ZUV46wd1v9+4HHArlwzIWfx
 F
X-Gm-Gg: ASbGncuDfdMTiDxKi7t8WCLlGSOPVFN63RMvdlCmE40yH5NandBY2Ze2dqcilCla61I
 s+osy8iiAZMosT9fRl/FZz3PXyQbEE2zZA1zknrkrvUhy0rOos3l/dpK8V9hizFjrc0zlFDs3rO
 +RFf9xz1uasSRGxB8/NguTtULnlwpTvqkrOWGj8vmVkWA9Fchqtab7vfe0Fx9xiHNlH4work5r7
 I4bYHb0hd6qrH6hJqj9nIL+BTymF74L9zqPvX3FN3k6HMPylyd17n1BieFA
X-Google-Smtp-Source: AGHT+IFFUD4MdrOm47MBTREZv0Zu8sIiii5xNVD/e17gQHbodrAbO1lH2rK0zKCh3+rQDQnVfzSVRQ==
X-Received: by 2002:a05:600c:4f48:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-4362286dca8mr3464295e9.30.1733934085039; 
 Wed, 11 Dec 2024 08:21:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 71/72] MAINTAINERS: update email address for Leif Lindholm
Date: Wed, 11 Dec 2024 16:20:03 +0000
Message-Id: <20241211162004.2795499-72-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Leif Lindholm <quic_llindhol@quicinc.com>

I'm migrating to Qualcomm's new open source email infrastructure, so
update my email address, and update the mailmap to match.

Signed-off-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241205114047.1125842-1-leif.lindholm@oss.qualcomm.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 2 +-
 .mailmap    | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aaf0505a214..9ae6a78ae9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -915,7 +915,7 @@ F: include/hw/ssi/imx_spi.h
 SBSA-REF
 M: Radoslaw Biernacki <rad@semihalf.com>
 M: Peter Maydell <peter.maydell@linaro.org>
-R: Leif Lindholm <quic_llindhol@quicinc.com>
+R: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
 R: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
diff --git a/.mailmap b/.mailmap
index 727ce204b2d..5f6df414e1f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -87,8 +87,9 @@ Huacai Chen <chenhuacai@kernel.org> <chenhc@lemote.com>
 Huacai Chen <chenhuacai@kernel.org> <chenhuacai@loongson.cn>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Juan Quintela <quintela@trasno.org> <quintela@redhat.com>
-Leif Lindholm <quic_llindhol@quicinc.com> <leif.lindholm@linaro.org>
-Leif Lindholm <quic_llindhol@quicinc.com> <leif@nuviainc.com>
+Leif Lindholm <leif.lindholm@oss.qualcomm.com> <quic_llindhol@quicinc.com>
+Leif Lindholm <leif.lindholm@oss.qualcomm.com> <leif.lindholm@linaro.org>
+Leif Lindholm <leif.lindholm@oss.qualcomm.com> <leif@nuviainc.com>
 Luc Michel <luc@lmichel.fr> <luc.michel@git.antfield.fr>
 Luc Michel <luc@lmichel.fr> <luc.michel@greensocs.com>
 Luc Michel <luc@lmichel.fr> <lmichel@kalray.eu>
-- 
2.34.1


