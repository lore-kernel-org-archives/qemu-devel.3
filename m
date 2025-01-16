Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD3CC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSUm-0005JY-7c; Thu, 16 Jan 2025 11:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTl-0003ch-Ka
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:23 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTf-0004TM-Ja
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:21 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso948733f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043934; x=1737648734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjBkm+9kt7SVmlp5MaEOwiSxlmy3tkhLPU0UETkvsQU=;
 b=gQEk2jjZxk75AFSJg7Nyub06ZToDirlUK/TZ4abkZmRGAdfdFjnoJvTbvarcFJUbM5
 gb4vIx1oHVTEk9OBaQdtl7NPIeOWgsIhSnGfJv70vn1ls0/nXX2joKY8zlJ/GVx9eRLk
 JmV9dmCIrc8HCQdAa03doT/vFdw8t1+2q60BYNlHLJ8XO2+idO8bXAHMrdz50ZiYZ3Vg
 D4WUTgrXHAyyl1YFtiL1o21Xj1Wt5jW3/FnGH19PrNrnl4KquoWe3eI75kyA6aVU/wAS
 MTsO1hb8gXlrKP6V5jDJBUcDv5/NughjuqibzDUwdU2iqufLkyBexYzkOumoo8hBpfUL
 atlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043934; x=1737648734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjBkm+9kt7SVmlp5MaEOwiSxlmy3tkhLPU0UETkvsQU=;
 b=t/OBkJ46fahKLqhg3i/GsqmWo5CJg8At1mZkyr0rbPxWADMPPNQt1q49UVt6Y4gR7u
 VaneRsGZgocgG5V9u+MtGsMYQ/cY72lVP4zpDqpF6IfUNRQ+hOrYvbRnFgt7tavcXA7W
 pNL9MTjKt+TIywsnPM3rrcoKWjQICEyqyNOSB9WNvDWkLPdvRRmDvYuIJyuxiHRVo+5k
 mDaH4qs5E+aZdnuh47iH7MwRawqr603Ti7AFVRarC+oWjIEYI6N0SH37sF29Gp/PRKFK
 naJi3RrKPuTFCxW91q3P0kgh9EJ7HoOJOpEwxhH+JNDcgKpY7z1oomiQ8MmNbZSMmvZK
 CHkQ==
X-Gm-Message-State: AOJu0YyGJxw+MbvKTmqvmz4d6nDD+m/gfxBxfgtNxQdrO1+RmVlf7Nt4
 j7BjyvZQO6+NMIrW2qitXtPgbY3XPdbElYGQq/aIUyZ0T7iw+OSDrAX/7HetqvQ=
X-Gm-Gg: ASbGncvD+PLBEoHt5ApumePwlyBzyRA4kbFQa/5D7XhXLGh9Zd0ZMgEzMIIGLBNswxV
 QMPm5wLiLkK5SjmkLWS7M9inRU3f7Ts2jLQ4HNMEP1gxaGQTn5OJZWbYSLwxu3smJzhS/SXKslD
 gM1j/+Yty2jXKPP3nE0x50vmWJ8yJRjcWZjoPOJr2fdhkNZPfys1Qp1zyfpRERrDoWDpRNDP493
 60L5+DIzzmxvUsGd4Onx7GRNFhGL7re/Q4bPbSQSFOEWZ6i14mnBSA=
X-Google-Smtp-Source: AGHT+IEY1itrrtpnM3YXXWP56AWDubbkrjiA9fJ3byomi0QjtO2edNf+vafGfyTadhnZwXH8brCneg==
X-Received: by 2002:a5d:648a:0:b0:386:3e87:2cd6 with SMTP id
 ffacd0b85a97d-38a8730fb57mr32640790f8f.38.1737043933741; 
 Thu, 16 Jan 2025 08:12:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890409758sm3931075e9.2.2025.01.16.08.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:12:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1EF3A608D9;
 Thu, 16 Jan 2025 16:03:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 27/37] editorconfig: update for perl scripts
Date: Thu, 16 Jan 2025 16:02:56 +0000
Message-Id: <20250116160306.1709518-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We have two types of perl scripts in the tree. The ones from the
kernel are mostly tab based where as scripts we have written ourselves
use 4 space indentation.

Attempt to codify that in our .editorconfig

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 .editorconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/.editorconfig b/.editorconfig
index 7303759ed7..a04cb9054c 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -47,3 +47,16 @@ emacs_mode = glsl
 [*.json]
 indent_style = space
 emacs_mode = python
+
+# by default follow QEMU's style
+[*.pl]
+indent_style = space
+indent_size = 4
+emacs_mode = perl
+
+# but user kernel "style" for imported scripts
+[scripts/{kernel-doc,get_maintainer.pl,checkpatch.pl}]
+indent_style = tab
+indent_size = 8
+emacs_mode = perl
+
-- 
2.39.5


