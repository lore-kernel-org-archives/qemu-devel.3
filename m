Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1ECC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmf4-0004eV-R9; Wed, 21 May 2025 12:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmf0-0004dw-AP
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:51:19 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmex-0007Kh-3N
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:51:17 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-601ad859ec0so8302647a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747846270; x=1748451070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZF6S8L3UqVuJFuyJwFnFTJvE8XTZ2YC1W6E4Xyum+w=;
 b=rghLNE/jIBABQ+SY4At6vaINrD0R3VB4M1IelF6SPusHGf0Ck2Vkyi/Ssg/x8Q6cYO
 ZOUsHwjWOpcRf95hXUXyrqRwFRlwq0NjYy9WFZN7H6tF60xrrlzZkpeAmmtgSmN/ru+/
 oH7A9eqCGnNm8F9sKRFLuciUpP9UxoaJOqnUdDG3YwO3/yfzMTCfOCTjAMLKNv74tQXN
 vr2/s2DWhgc91NDBrxM7Eqjlps7+hojxmPQEQtbisLh2lQB6jIa4BjJdyOfO04+KxbS7
 ePK97eEWEozkCofjpbpUffLJWgiwf+pVIfV87812x43KRSbQoG2bXNwqZgCC48fh3Tz0
 eR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747846270; x=1748451070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZF6S8L3UqVuJFuyJwFnFTJvE8XTZ2YC1W6E4Xyum+w=;
 b=BitB3dWfkugxn/lgSaLhV2g7DutvTKBLF99XRfnKB1pVP12CUEMvZV3K6qNURDqWgE
 683ySPlt0u51EkF9JcGqtusBXqTsIO/VXHTBKNZ5PC6JgftB/IYYee3PnO9+5Fbx2Gyz
 KD2tFOrs/II9aZwbVKnHWhOoogsXjUGJxbbiai+CvJos0emBlIzwQ+R95f030Ntl437d
 ZdNP+epj2Ia4x7yiTXNHrk9Z/h5rlw9jE0eAYlQl9xJIarC4Fw6IYQaZHJJ1UzhhuCLD
 jmTcnHMaANVb0jEdsUViffiA2r74E8X9qvssulKwWA+2JONUVMwa0jpaBqZMgvkQ5tyw
 X63g==
X-Gm-Message-State: AOJu0Ywgewldo/gIS6iGKKIDyKMwh8VrMgiS0gjNEw39MMl0WXzDj0I5
 0RkAlAOj4CSUTOV2sDhugPqaPbz1vM8qWETWUM92uSjM0MvpYxKR57Q6Bcn3dbo05pY=
X-Gm-Gg: ASbGncs+kEpnlexGSWCB4Kimxi3GVktxZH6XowMfFJR066t9e/qIjADJ+E0MnlqNfBi
 9nhNfyikmmGHvIgusi4yqB5iKIxTcyzIGLIpZZe3+Occ2F47EAsQWA9Faqa8wsbODV/p9gZGqxx
 hsMjwO0YoBU5fgeq2zonXN3hSB6DDknHqUqHGkf3Qe8c+R7fv+ngi/16vtyiHuOFWepAOrdHw4u
 sWo+lSGWoz1xaOW8XHOESBvteTNfx3UcSfXDVU97jZIQDX4nkofIacLo2Qh/B5ro7tijg+N0gaB
 8mvUnCVebYfekKRsl4BEvf7FLO7OfDXSnKXdx/tfCB3absX0f0tG
X-Google-Smtp-Source: AGHT+IG1+hjxUhIvkliA4pVWDklxvicUXwLGmeJurC2UgiNdj05KGBbwKLlYvWcLcrjxb/jtophQ5g==
X-Received: by 2002:a17:907:3d10:b0:ad5:21cd:b75e with SMTP id
 a640c23a62f3a-ad52d5d3608mr1965724666b.46.1747846270392; 
 Wed, 21 May 2025 09:51:10 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d04e990sm923827966b.35.2025.05.21.09.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:51:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 820225FAFB;
 Wed, 21 May 2025 17:42:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 17/20] include/gdbstub: fix include guard in commands.h
Date: Wed, 21 May 2025 17:42:47 +0100
Message-Id: <20250521164250.135776-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/gdbstub/commands.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index 40f0514fe9..bff3674872 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -1,5 +1,5 @@
 #ifndef GDBSTUB_COMMANDS_H
-#define GDBSTUB
+#define GDBSTUB_COMMANDS_H
 
 typedef void (*GdbCmdHandler)(GArray *params, void *user_ctx);
 
-- 
2.39.5


