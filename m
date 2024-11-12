Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E1AD597A8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 21:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAyPS-0003iL-Aa; Tue, 12 Nov 2024 16:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tAyPI-0003hG-Fz
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 16:26:43 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tAyPG-0004St-Ce
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 16:26:40 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d533b5412so4239171f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 13:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731446794; x=1732051594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jWErWBIj0F5t4NqhpwMkB48eX+pCqWPGB0s4Lu9mBc=;
 b=xyp+MNUbwf9qXis9L0SSnmz1qwbY3IOTJn4Py1GVgdHojmvjkn9WpPLoKRQC35UN4n
 jIMZi/J6lV952Xe1cLxp27C4Plpl3138jCQHDtjgIxx5FUGJFc2/Qyax4YNK34tInJa2
 O93ZC4L+/YlSKjlUSLYLUClb0Cdj4q7XJMuVzmfz8mXqAAQDaN04h5sc4L4SkYKZB7JT
 hj7E8pfUZbRc7lWutkQUCCTIzc17XP2X4ak2RkHLMeKOCfD0n5igFBUrFGAia83jykYP
 cze11qucYHQjaTFfT9+n7P/Kowo+qK111Dk9Tdqk7t5OZr4lLTopjH0cEbz/Y1X8/XvP
 IKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731446794; x=1732051594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3jWErWBIj0F5t4NqhpwMkB48eX+pCqWPGB0s4Lu9mBc=;
 b=vcEtaLydUXwM0iGWqZhElnRXRmTHmFrSPBiywnEAOQnVsjAjq+xG3iZtBQ0E9Wllea
 sV08nY2GavtgIAwYX+wjoHtvl6YJTXnAW4jNO+8mSsGFp/Lu2dNnXHXjDKQJbx8OxvgD
 9RpmLQjI1Oed2Dp+OSZAewX25T8A2E0FK97id2PcSW56P7ztRMiYE1/Uc+jy42kShLqz
 IJbQ07fTKLrEx2eSg759EbVrjbzn5/CMNuJYAXrVZLR+9xBsydKqaxbTnPfBXkcCw3Oe
 XbMul6Swq3ISFqM/0UhcK+4zVZU5thDSzsGRrFC1A/gJNExq35l/NH7XHi7M2Q2YC+GL
 hb0Q==
X-Gm-Message-State: AOJu0Yxc39YKXyJsHVzPjnHrGMs0tE4T/N1yXs5M4+D3t4qopLr9AlO5
 9Us1So+3AdwScN0ODR7IHn9Vzahnqz+Vu8nSSLV2O0vrXjnKLP1t9ulaqm1ESumvP8fIIT2B4g9
 1CY2XDA==
X-Google-Smtp-Source: AGHT+IF88Dc05xck2t5e1IeZ1v2sUC/6SjEkQ9/Oppl52bQJR5R298K4H+FiKjFJkgWtV6EXYm0MxA==
X-Received: by 2002:a5d:6c64:0:b0:37d:528d:b8ad with SMTP id
 ffacd0b85a97d-381f1865423mr16586941f8f.6.1731446794352; 
 Tue, 12 Nov 2024 13:26:34 -0800 (PST)
Received: from linaro.. ([193.32.126.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ec202sm16613515f8f.83.2024.11.12.13.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 13:26:34 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 1/3] plugins: add missing export for qemu_plugin_num_vcpus
Date: Tue, 12 Nov 2024 13:26:20 -0800
Message-Id: <20241112212622.3590693-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241112212622.3590693-1-pierrick.bouvier@linaro.org>
References: <20241112212622.3590693-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42b.google.com
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

Fixes: 4a448b148ca ("plugins: add qemu_plugin_num_vcpus function")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 622c9a02327..0fba36ae028 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -803,6 +803,7 @@ void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
                                     qemu_plugin_udata_cb_t cb, void *userdata);
 
 /* returns how many vcpus were started at this point */
+QEMU_PLUGIN_API
 int qemu_plugin_num_vcpus(void);
 
 /**
-- 
2.39.5


