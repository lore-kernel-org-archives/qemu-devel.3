Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C961C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDQq-00075U-1H; Thu, 05 Jun 2025 12:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQm-00072B-DU
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:04 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQj-0007xJ-Af
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:04 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-60766191202so115048a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140819; x=1749745619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eS23RxNURpTKdKnQyf0A+flfVwkpy5WMSUSCIe4V0wA=;
 b=XFJLHwYTJAKwmUuyk98jaHEI8BtGduUuNr4hg+mKVtrj+iVEEKTk7pcybWMvJVRFaa
 ID53jyBwRcXq6iuKe4IkqaorZmpXW2gKxhB6OtQuuNXijR7p3eo0e/H89YIFw/dTuq7D
 y5dqA0LnrNvhP9nInc9BtBz4WVMvYk93Oe/AgChNN7jzVjnGzIidaARXLnS8EdM82eKp
 tbldyJkCjteOdNg0I9wr1dPD2y+zySt/s8A/bhZAYJ6ybc38daOcthZLYaGy8AWZk8nd
 FiYoVx5JI38CGZQehOhIRYkAJ0Sh59kYdgxnzMR360Gh1kNCN321Dmnf4Hhz+x+wwCaP
 E+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140819; x=1749745619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eS23RxNURpTKdKnQyf0A+flfVwkpy5WMSUSCIe4V0wA=;
 b=jyKTjuBlYWSGEsFN/QW0Y+Y5IrOB0fK/6dOg+giWxMfjd59l6TvdKeS/XyjoLyuTTC
 YPtvLfFgUsny9/48+B1b6fVhhIXww25gYuQgYTHLaEblTybV59U4OE1nVlk86gbLukkI
 7JyX65ITAZ3czQwy0ybB3b5/h1BhsCb3HqZsgj+e5z2U9jPTlQGQmnP43pah50zXVHZF
 xI/0mkTYVcXsHjofNZ7n4G7zLepzyk+PJXg4DY1tOz9AHUxP0WHsNgqhae4gmpYyIYFO
 AzvGaJvpFPlQqpSYaiEjP5M0umZClbe/Hp77hRcUJxYaHDN2i0qT1Tfi54KT7PK2+caB
 32fA==
X-Gm-Message-State: AOJu0Yy2Q0EblfUz55wFyi5bvj1sRxZNyhgIeyu9rLOaeA5VyWFSqm/U
 Wqz4RvkFfel/AFo168IQlIfQXYXeScuhuFPoSfKSdcyO5iHyVS5JlX/UT4/t/MPRjYI=
X-Gm-Gg: ASbGncuDdQYhjPsg/OfpQmwShZSLiJRpOTdc+5UjzDqAki2f6M+eI6tZ/z6UdnGivoZ
 x+5E41FIlvnrUFdUj3Lc77f5MUzzDz1p7i/oR7mXAr3h+rv4KY2ztq/O9+nSJqmQcxX6P9iRL7K
 Hwifwx451SbGMUqffiMFHqY95kOTYJA6qYVY2rkME/ImnuCfS6ia6C5K9HTn5QITPrj/zOGPcc4
 0xhgEhz0tD4aQuTwaTtzVi/VTE5bjBm876+4RP2j5UNbiICS1C2zlg2njcBhdozQji1Ptf4lJ9s
 vgnThaPtYd5Vj/o9FVlUHNd9e8wau0k/m/zTYc0Q/KykxZcMfm3i
X-Google-Smtp-Source: AGHT+IGtAGUs3kILSxvdRvjqSpQvjQj/MhupKlXEcGPiNXEe3sbuJKDnoCH2rEs3a0q9A/LsGG4bEA==
X-Received: by 2002:a05:6402:51cf:b0:5f6:fab2:9128 with SMTP id
 4fb4d7f45d1cf-606ea15f54fmr7812527a12.19.1749140819476; 
 Thu, 05 Jun 2025 09:26:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c2b301sm10779340a12.15.2025.06.05.09.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:26:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 69AB85F82C;
 Thu, 05 Jun 2025 17:26:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PULL 11/17] ui/gtk-gl-area: Remove extra draw call in refresh
Date: Thu,  5 Jun 2025 17:26:44 +0100
Message-ID: <20250605162651.2614401-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Dongwon Kim <dongwon.kim@intel.com>

This partially reverts commit 77bf310084dad38b3a2badf01766c659056f1cf2
which causes some guest display corruption when gtk-gl-area
is used for GTK rendering (e.g. Wayland Compositor) possibly due to
simulataneous accesses on the guest frame buffer by host compositor
and the guest.

Fixes: 77bf310084 ("ui/gtk: Draw guest frame at refresh cycle")
Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Message-Id: <20250214170813.2234754-1-dongwon.kim@intel.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-12-alex.bennee@linaro.org>

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 8151cc413c..429ba914e0 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -168,7 +168,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     if (vc->gfx.guest_fb.dmabuf &&
         qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        gd_gl_area_draw(vc);
         return;
     }
 
-- 
2.47.2


