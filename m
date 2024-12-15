Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52325E7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwK-0001HA-Gm; Sun, 15 Dec 2024 14:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwF-0001GE-06
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:59 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwD-000118-Dn
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:58 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-29fbba47ca4so1352913fac.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289555; x=1734894355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=llJ8necg6Hk67Yi1QiP/nuY6/jPOVfZRsl8P8QhMvXY=;
 b=o6w87x72CphAIoKJoSs1ttGTE0Y+7sUeKHr3Phr1fz/6isTTVyYqtF1sE7PbCZZkSy
 O4JTfhIc0JOF68wXS2QYqPgTf5kRHMTWlytVHWC/q89jnoz71g0qvi4MrUaIz0VkFj2+
 fqdqiO255+dkVjp2i+ZFUAG8aTaT2W9gul/QVHUcHnxZbfq/LuXIDjR08/YZOPDjl1IJ
 WN35CNLzPdPAB0qaEHXwPDibENBiEq2N8E2xUzA24Cy4N/k6/W9FYEYC9gUET/cEU1po
 uRkztH0gc3zPV+25qYoPIlUAf4D3FoNSt+SSQGyucnH4PFCgPohP0UnHPMN5B9uQcco+
 Z2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289555; x=1734894355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=llJ8necg6Hk67Yi1QiP/nuY6/jPOVfZRsl8P8QhMvXY=;
 b=aVVDEG8Hp6JJaGoeA/fuWfBTOhNKiMgmEsacuW0Q7HnoqO4TALb5Yj57yv79tm6UF1
 oGFMQ9P9fHMfSV6U3WLEZRWBZ9Um+XT/RiE3LycMO3oMFESlSgKPt/3eXlYcyFpMUDl4
 kAx+4IaqPYXM/piA114xJuXbJCXYPaLztXN50ljIu62nhADzCxqIxb9GDzGKgdDBIDNp
 AywMwjvbH7Sfa5U1uYB12uN+IzGZoikhcdATMfdMU+N65dl4b6+96TbdBHrLNsx1GJB8
 uQpp+R0gdWUe2XT/2SllYYAZl+n19lWUze1YzPwDEpqC35UzzE0PTuwhiu7cLMFHV4A2
 LFVA==
X-Gm-Message-State: AOJu0YxPQdg4tCLSfPmXwdeQXadsJOMm3kS542Ph6pkml0zOj72gC6u6
 /UG5uCsJs480Pp4mOskPnAVnYzAW8E9u3tM8HC7uGr4fKjFo7+8HN/JD7HaGS0ZALGwn6T+iUg8
 Kttd7PPNr
X-Gm-Gg: ASbGncs/I3mihu9jQpSdWwWtVf4+xmKnr+sZk9PQHRqLuvlnltl8nXGJ0fVpc5CkpzB
 zn+YBif76ZPxq055yh3voDyisekZurb5MmsD6Nq/Od/ffXtM0uOU9913CqnVtEbHRaYepad2qMA
 +dzIRVIlETYlYG6h3ImPlMI9FpRiIWx5US2Tp1+Yuyawk09O9UcF+KJ0qcZnYwoeiMJtSBZ9h63
 ZOxRFkNxmh9YgUCCUsWHOtb7C5xhMbrUVWgjsT4f4MNwRcMjpxMEacGeZfgMzBtBaaaKFN6Qxbv
 6Sm8aqkyc5sOyCZS6v88WPZxEI8itOuSwlI+gyhqiP8=
X-Google-Smtp-Source: AGHT+IFTM8+CK5Byz1cfrhHjTwBHAvf7u1BvqMGrYYQOnHmxZ2AV8R1UFSpBl9VhpXsX16zKcbIZAg==
X-Received: by 2002:a05:6870:e8d:b0:29e:5bb8:fb35 with SMTP id
 586e51a60fabf-2a3ac8c0fedmr5454400fac.37.1734289555469; 
 Sun, 15 Dec 2024 11:05:55 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:05:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PULL 11/67] hw/9pfs: Constify all Property
Date: Sun, 15 Dec 2024 13:04:37 -0600
Message-ID: <20241215190533.3222854-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/9pfs/virtio-9p-device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index efa41cfd73..b764e4cd3d 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -243,7 +243,7 @@ static const VMStateDescription vmstate_virtio_9p = {
     },
 };
 
-static Property virtio_9p_properties[] = {
+static const Property virtio_9p_properties[] = {
     DEFINE_PROP_STRING("mount_tag", V9fsVirtioState, state.fsconf.tag),
     DEFINE_PROP_STRING("fsdev", V9fsVirtioState, state.fsconf.fsdev_id),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.43.0


