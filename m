Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADB8E7717F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ56-000773-7P; Sun, 08 Dec 2024 17:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ54-00076k-Rz
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:50 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ52-0006C6-LT
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:50 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5f1ed6ee4d6so1860412eaf.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698127; x=1734302927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dry87Jh5nw9awikYWLGeiW+IAYg+Rmtsj19DEsR1oJ0=;
 b=Jx//+Y5S/cLpGUM2TaXuqnjt+pO9MGBfu4W7OXS2XxsTK8SadKVyTgKog3MjsLU2XS
 Y7c4WpvkVUBaqHetsN6W8WjoYNu0NKPhEp6AJ9g3Yd5MZtdWMhBvJHs+wH4t8UYJCJl5
 /QoZRwxit1eEfQhY6QcFL9DaoOn0cVm+doQioNlRHCfHoSdj+2Rc6qsrRXRshBCW1fuN
 xO5uyeFD0m85R7h4JhCFgayKoDLKVJkpbyYQpIceaclQV/tST2umrHBI4zUuVWWKF7I0
 dEh/RlLWm0svfBsfWr+5MTIFrlhDJbGD52LOI5Z/W3n2nuofNt9Mv+Jk4UrjQ/J73xVU
 /vOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698127; x=1734302927;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dry87Jh5nw9awikYWLGeiW+IAYg+Rmtsj19DEsR1oJ0=;
 b=T2f2dhFkwa3490S3GsnhwrvhDmgIooK/or+rz1Zek0OSuONUb7GU+kSw4bt0TeH4v5
 7Uw7r+xdQsoRt+b0ibkynEDtzeAbEd6DXVchT/l3mRlIaOwcJ30AMgM4oWQI/aIOt3lJ
 KlFBy+liVEE2WwKPNWY7XY8+CzFzDrIgJqf84AIoRdqdoIPXOKZX/YmqKFWY5vSxGTT4
 13A6FZrf3C7akNv+JUUwn50bP/GZ5V9QnmImq7fq1mJrE8zF+NbjavAg+ucL9pGtbetB
 TGDK6GCqs9Q3yn87ESwWq5Iq+79YWubVEdsRspfusgC7Up3tDztOYNCSKjkniDRo3bMh
 Js6w==
X-Gm-Message-State: AOJu0YzZv5g/AmoAn1+PCgikoA2xRW/kp3Qho6x4ltNJZW+CXL7Ee2mC
 zkLsdhA3EsMRpZPI/hVKBU3ylP/Zsh5uabL5USDFxL8PNHqOkHa3hKhiP4wu4c4warlBo4PjXFK
 1zoiEfw==
X-Gm-Gg: ASbGncuO1QZ/JTs/l0UCR51zs9xwbx3HIZdzrOtQ5/NHROOPLJiEgk975fwCvYcOuD2
 1Sgqi54IrnlOGuhMIkB4gOd2gU3HqFX9owkY+rFkIrevvtcDnD8Gd7PADxrB24sRzzsYWOFbtoe
 iQ97c9BjptsIdUYQ2kyT1cYoyz2lL6zXExCIENGq9guqSB0hI63Iohvbxl9iL9NcP6BHSREhMe6
 fbNth4OZLhFN3647GMy73HDYAmSMN4b531BZy5ZoOhyjcMZhrc+lcyrZs5REHY4Bbd0tiYUkbA+
 IFzdhQLiGZ7FJFJPr1OPY3Gh3U+EQMpc0sO/
X-Google-Smtp-Source: AGHT+IGMIHxN1RJ6XU3bzNGRSzUHu5kyqrRdr4VD9+oCx5x7KF7DhJlXyOFsb86Lpfso2tV4pnXxLw==
X-Received: by 2002:a05:6820:16a9:b0:5f2:5dfd:ecba with SMTP id
 006d021491bc7-5f286e777dbmr7123170eaf.1.1733698126869; 
 Sun, 08 Dec 2024 14:48:46 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:48:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [RFC PATCH 00/17] softfloat, hexagon: Cleanup fmaf
Date: Sun,  8 Dec 2024 16:48:27 -0600
Message-ID: <20241208224844.570491-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

While looking at some float_status usage, I got distracted by some
odd looking hexagon code.  With some minor additions to softfloat,
we can handle all of the special cases.

I have a feeling that dfmpyhh can also be simplified, but I don't
quite grok the accumulator in this case.  It appears to be integral
value, added into the middle of the floating-point partial product?


r~


Richard Henderson (17):
  softfloat: Add float{16,32,64}_muladd_scalbn
  target/arm: Use float*_muladd_scalbn
  target/sparc: Use float*_muladd_scalbn
  softfloat: Remove float_muladd_halve_result
  softfloat: Add float_round_nearest_even_max
  softfloat: Add float_muladd_suppress_add_product_zero
  target/hexagon: Use float32_mul in helper_sfmpy
  target/hexagon: Use float32_muladd for helper_sffma
  target/hexagon: Use float32_muladd for helper_sffms
  target/hexagon: Use float32_muladd_scalbn for helper_sffma_sc
  target/hexagon: Use float32_muladd for helper_sffm[as]_lib
  target/hexagon: Remove internal_fmafx
  target/hexagon: Expand GEN_XF_ROUND
  target/hexagon: Remove Float
  target/hexagon: Remove Double
  target/hexagon: Use mulu64 for int128_mul_6464
  target/hexagon: Simplify internal_mpyhh setup

 include/fpu/softfloat-types.h |   2 +
 include/fpu/softfloat.h       |  14 +-
 target/hexagon/fma_emu.h      |   3 -
 target/sparc/helper.h         |   4 +-
 fpu/softfloat.c               |  64 ++---
 target/arm/tcg/helper-a64.c   |   6 +-
 target/hexagon/fma_emu.c      | 494 +++++++++-------------------------
 target/hexagon/op_helper.c    | 125 +++------
 target/sparc/fop_helper.c     |   8 +-
 target/sparc/translate.c      |  80 +++---
 fpu/softfloat-parts.c.inc     |  16 +-
 11 files changed, 277 insertions(+), 539 deletions(-)

-- 
2.43.0


