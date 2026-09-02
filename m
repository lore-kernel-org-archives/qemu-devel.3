Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D437C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1jhl-0002Ut-1J; Wed, 02 Sep 2026 08:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1jhe-0002U3-PO
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:04:31 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1jhc-0007hI-A5
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:04:30 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-482e2fdf6ebso1060940f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788350667; x=1788955467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XKiJrXTCr2mrBLghn7+HTm/dHfTHsGUaEoYFuaHFuSI=;
 b=op7/RxtbncD/9BvIpmh9G3eGiX9b5Kiudr4XV9Dq5nYBAyr/0nASa0Q3uxDalX3UbB
 DAthjGh5ZYqm3DNNAcIMJP77vAj/PZVQD4eIhDRcdyaANlSj6Gbjkb08X3/LQHEM8CSE
 7TUcwzpkuq6I5BFfZSUeF/l74CnkbB6rSix3TZwcAA5ugBUPIZYL94vcvXJ0YJv1D2Ur
 RqQygVvd3tQRzNO8y4XQQnyyh9108RrDgyT4q3j8qcym4yTlgYoSV1eEh4exakIGLj3B
 aWXOgT2ITrIcOuXp1Q48dOgPXKrkGEZ9kqmQQMdZwgW/zErrFDLseRiqb7UaMqBhbGQl
 Qewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788350667; x=1788955467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XKiJrXTCr2mrBLghn7+HTm/dHfTHsGUaEoYFuaHFuSI=;
 b=VcPAGiqfuyIU/87/KlpBbWHdmYNyjjMwON63mvn+QGdntQuRpavLLUvN61Wu6gNaUV
 68IlYZUZmmTgMSpSe5Z32K9/fEGnrPArM2ZIlmDnZDhVzDZ+TbGlhsDR1rDTuHQNs62m
 lBol9Ok1dg/Oy7fa640vBc46/DKGuAL4PR5Q4EZfO6INDkALZt2OdimAWVbOuddvuBQt
 jCfmyXCx+Rdqtyr/TjMIPT1NKSGbYu6mCRHQ/l9o8gxqRAuEBk4ewEQZCcJwug9eHbyW
 5gVxL9/EnpWPhq35FuEcU7TRSMjZxqHuwnuz6mp+PeRp6c0/UXQpoT7gc/lWT59XbK1y
 odxQ==
X-Gm-Message-State: AFuF++nGIaFPJIoHOk0LtWeG0otXe7fv4w3sPuOHyrhJUq50e6ylEBuM
 2h2J21xxnVicvpSzwjQMEZaLK813yjRXKghI8di/Hv2GxyTkbl5q8flx65lcUy7ZQCo=
X-Gm-Gg: AYBFou2idA7wDMAH4E94RPrjgGk1uwMf/5J4yoO4ct8zY1OttrraTqiGOEXg4wzmdMV
 yNqiMaF2KahWexU+uIIXZZjT3/1pzzCHgJd60ALB4Oz4BfsyfTiIlG/IfPhtoMZAi6Elw9vS2Ub
 4kcMTNpiLF94Q6ByrfeZjyliBxci7W5y83LW3vvhP49LbY3FTYAWg5bszqn35VeTAl0+BrwZIIo
 rlQumXByuZlYfUqhPN/tCvDcwqIgm3Q3gjFwSGDGy3aBYTYqd3DLGkV2vv9vO5atpwLamz9dvqv
 HSfBJH/aDfM8IGjQiVyh7O2va7AjYT6xXaMXbU/ABJAe1D32S1wmveklrIL32Vx9c1HC2Bb+99J
 956k1MCtZZzmXfOzm9QZlzVSFIaFQ+yBAOCMRBrB0hrvtqM5HOZcF4fOAtQf9yi3rmdtA5FXY14
 LgUTnh37r14uml5an1YENjFI85ZxM30oeVUl7IYUQUrySYL/wQKlfzxu2y0tccZXRSxBTPHur3X
 kVVgMbFY/lfdCE8a0MLB7RRaeItXKuv6WsTRPqYtDW/Wwm8Ar5bo8AWDLbSBoa5Nif2wJHThKtq
 3zVef4CuM9+dwtuoGVKgx2VGAwAkYbM=
X-Received: by 2002:a5d:5f92:0:b0:47f:8f8f:db74 with SMTP id
 ffacd0b85a97d-48488f06da6mr7809888f8f.12.1788350665367; 
 Wed, 02 Sep 2026 05:04:25 -0700 (PDT)
Received: from simon-macbookpro.tugraz.local (tug-swl-225-161.tugraz.at.
 [129.27.225.161]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492cdc37sm6504420f8f.34.2026.09.02.05.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 05:04:24 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH 0/2] target/i386: Fix FPU tag word for FSTP/FXCH
Date: Wed,  2 Sep 2026 14:04:17 +0200
Message-ID: <20260902120419.212855-1-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Following up on a similar tag word bug in FXTRACT
(https://patchew.org/QEMU/20260901085839.138094-1-scherer.simon89@gmail.com/)
two more instructions sharing the same bug of not updating
the tag word turned up:

Patch 1 fixes FSTP ST(i)
Patch 2 fixes FXCH ST(i)

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4400

Simon Scherer (2):
  target/i386: Update FPU tag word for FSTP
  target/i386: Update FPU tag word for FXCH

 target/i386/tcg/fpu_helper.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.53.0


