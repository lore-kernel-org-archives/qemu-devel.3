Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF54C54FAA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIxU-0004JS-5r; Wed, 28 Aug 2024 09:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjIxS-0004H4-Sb
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:43:34 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjIxR-0002Kd-8f
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:43:34 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a86859e2fc0so840300466b.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724852611; x=1725457411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExlkdrUtqEM387e5iz5EaHb4pSvHH/3TmSRHTIVr1OA=;
 b=UKVgkspKrSQVXTokaAHxwVUUniC4EQSL9/yYagzZIB/kE1nke2MSCTSiEa2O/a8NmP
 kTi7L3voIedNNj5Xhil1W5OqydgAg2qO9G7yirdAS+cypbxPbEm0WgDH3vDko4NO3Gel
 EnDgj/3tU8KAB8vNUU4oTksGUSotEE6omAzLCArkVM/Tt4AH1ndU7Xqn2ddJel2eWdBv
 P0AdupRb9wCD+Hk0hMxNX01E+BV0T3YNFIR0isDcTcW36Pd50ieVufhkj9xLUkAC0Wt6
 7VcYmoD+LBLYuwI7rnPhpNqaPSDonj/B5pYSlcN5mOuBlVSwVhJTopoZrZJsuXobOY2C
 5Sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724852611; x=1725457411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ExlkdrUtqEM387e5iz5EaHb4pSvHH/3TmSRHTIVr1OA=;
 b=ffbkk5qkTA2crG6SJTOhUuRBpQo4f5YrZequkj4bTy0v3kXxtVgUbqkRIWU0yYdRFC
 ISHC+YmdojADEYxb+4k1M+t89Xg+Wiohf4E9hVLtOx7/v31UjBTfNBOvTp+CQCZV/4+9
 5Wh85WInLyFJwQI0VX7D+7ZAbhgnBEDFwyBZNRrs9f2TZYuQ7FM/EaeGwcIcAIhrVWxa
 dC05M7kMBVjwTIyaApIz35ElS1afZHT+R+DeR0odvwEGeUFGeey6uRQCu3YUxbN5QDEp
 Gts/rZTuWcJwmRucLlL0Q3a4bQC0PS1n88nRRa5LThODlJeqckM53EODiDe/TfAKN2oT
 OyrA==
X-Gm-Message-State: AOJu0YwRZE8k+NU67cYSwzTr4lAOMjJUCPmg/I0U7so5mkmllLHQ9rhf
 SgtKUtKqHkE4lOyAeoItEOZVJlmvRPPFKhM272EFchAefifiZxutGu2FHw==
X-Google-Smtp-Source: AGHT+IG5QKGb2A4nf2DMokKwMOF5ql0N8b75+qDSQ/os7/zk9J+PuVQ4q0aIT6o4l0cTNE9Aa8luog==
X-Received: by 2002:a17:907:7e93:b0:a80:f81c:fd75 with SMTP id
 a640c23a62f3a-a870a5d443amr175009866b.0.1724852610989; 
 Wed, 28 Aug 2024 06:43:30 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a88a48d4a39sm32606766b.12.2024.08.28.06.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:43:30 -0700 (PDT)
From: "=?UTF-8?q?Corvin=20K=C3=B6hne?=" <corvin.koehne@gmail.com>
X-Google-Original-From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: qemu-devel@nongnu.org,
	c.koehne@beckhoff.com
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 1/7] vfio/igd: return an invalid generation for unknown
 devices
Date: Wed, 28 Aug 2024 15:43:22 +0200
Message-ID: <20240828134328.94528-2-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828134328.94528-1-c.koehne@beckhoff.com>
References: <20240828134328.94528-1-c.koehne@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Intel changes it's specification quite often e.g. the location and size
of the BDSM register has change for gen 11 devices and later. This
causes our emulation to fail on those devices. So, it's impossible for
us to use a suitable default value for unknown devices. Instead of
returning a random generation value and hoping that everthing works
fine, we should verify that different devices are working and add them
to our list of known devices.

Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index d320d032a7..650a323dda 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -90,7 +90,11 @@ static int igd_gen(VFIOPCIDevice *vdev)
         return 8;
     }
 
-    return 8; /* Assume newer is compatible */
+    /*
+     * Unfortunately, Intel changes it's specification quite often. This makes
+     * it impossible to use a suitable default value for unknown devices.
+     */
+    return -1;
 }
 
 typedef struct VFIOIGDQuirk {
-- 
2.46.0


