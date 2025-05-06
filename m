Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C172BC3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHrv-0004GZ-Ge; Tue, 06 May 2025 08:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrZ-0003YO-FJ
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:34 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrT-0003t7-8K
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:33 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ace333d5f7bso1060092366b.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536245; x=1747141045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ujckOaXBqgzpxCAXY4NOb0Hx2Mey25Y6RSr4J9VJVFc=;
 b=VRfnFiQdqtU1lGpJuxcuEQNKGdhMTl3jo821lfJtwmi9L8gB8TuEcFgfETD13Im2vi
 xL+bQFctl1CA2RwSH/70VFIvDT+VlpEyuzr0/oGySMiPgWvZpHeA/xmTCw9k/pXDu91C
 6rOHylfCGiWpoWl3t+Pb1wHuFmn4sXmxp0tgL8kyfvK7pucwYqJ7Dt8bz1eVUmsB78L0
 ORmBIdn9HbqC8OJYIdZ0q9yw9q5odzQII+OAxU/9flpP9dVAae8Kw4xTLfetA7e4Gw/e
 hxvEVil+xEhkmTSfSQvNuEMoKzmRMmjCR6jR/X6DjX+N06dPeRBpOJGGznzbgSKjTHTo
 MX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536245; x=1747141045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ujckOaXBqgzpxCAXY4NOb0Hx2Mey25Y6RSr4J9VJVFc=;
 b=qu6cexOozTYLxO26BHTdYTVlbd9bcMBzruLpbfAQtzbeZYbNlAbmj2de2FRvokoq0X
 EvCbryhPjQFs3epOWrlt1FKp2xchXI0QshBoqEq9UnmHqtoRVcqrIR49gCwa4U1/e1Ec
 2EbI4zeG5HEg5v8BhQOCaFmwOTitlKpJQfuyQsD/cF6Psf1vcwfov+FgfMNABl7dGa/D
 wRo4P/RxEuI2q+UwTvO+6gIHXfJ0iGI3N01Tly1rdld9GNK3SmvLSbTBqC0euMtKe7Al
 nU57EfAj4BGRnBeD3BoxXzIP0QnI9M/nF+i5CTObzFV5GsjC8uA4xQejC5RFGHOv3Kyz
 uaKw==
X-Gm-Message-State: AOJu0YzJfAWW8qR3pI6Nfsd2fDkw+oPPLwBfjvE0IoljEDtWwp71n7EZ
 YU/Ya0HvxVVBsFi1bzYkdSLrklJfXUyamFGpESeGwJsPCBKTZMB1qPpPOXQo6jE=
X-Gm-Gg: ASbGncuM1zX8yNxD+saJQelpe5hD+5/02zWTnMRRmDgQSS2IM5kMpUpijt61pQRLFnh
 Q7te8u6bcqnI4Yh7Ro/6IKLiFt6qgLfdfQ6yUoVrFLR8qtYOIIKLxufa9niTtIqUOcouXqgszCX
 H+wxUikSXRFFxSgx6y+MAo9o5FwHMXiSH9WgjpaNDI0R9rZHuZHUWOsKwgybiON+Bjuy/M411zj
 Sx2zp5np28+P/ySQwYQETk/B5gXa8kxT56fupwN8MhWN7US5rDJI3VUFjCu5DMPLBHg72pP3ouh
 UVlMOST9oKYIGSMvMpkedkxYT5OX0AIezcqQTDVlMWw=
X-Google-Smtp-Source: AGHT+IEhBjNlDkfiloy2vamGkUaQjzKVajCDK/Lmm5/BpdL9KiZ0UFnjnkfgd4eQZP8XEkscrMw9hA==
X-Received: by 2002:a17:906:d542:b0:ace:d7af:15e1 with SMTP id
 a640c23a62f3a-ad1a49afd2dmr1026164966b.28.1746536245263; 
 Tue, 06 May 2025 05:57:25 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891e980bsm692494666b.76.2025.05.06.05.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 05:57:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 727145FAE0;
 Tue,  6 May 2025 13:57:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 14/14] docs: Use uniquelabel in qemu-block-drivers.rst.inc
Date: Tue,  6 May 2025 13:57:15 +0100
Message-Id: <20250506125715.232872-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506125715.232872-1-alex.bennee@linaro.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Use the uniquelabel directive for the 'nbd' label in
qemu-block-drivers.rst.inc.  This avoids a complaint from some Sphinx
versions about it being a duplicate label, and means that we can
reliably ensure that the link in codebase.rst goes to the document
file that we intend (i.e.  the section of the HTML manual on disk
images, not the HTML copy of the qemu-block-drivers manpage).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20250429163212.618953-3-peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/codebase.rst                | 2 +-
 docs/system/qemu-block-drivers.rst.inc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
index 40273e7d31..f3f133e9ad 100644
--- a/docs/devel/codebase.rst
+++ b/docs/devel/codebase.rst
@@ -116,7 +116,7 @@ yet, so sometimes the source code is all you have.
 * `monitor <https://gitlab.com/qemu-project/qemu/-/tree/master/monitor>`_:
   `Monitor <QEMU monitor>` implementation (HMP & QMP).
 * `nbd <https://gitlab.com/qemu-project/qemu/-/tree/master/nbd>`_:
-  QEMU `NBD (Network Block Device) <nbd>` server.
+  QEMU `NBD (Network Block Device) <system/images-nbd>` server.
 * `net <https://gitlab.com/qemu-project/qemu/-/tree/master/net>`_:
   Network (host) support.
 * `pc-bios <https://gitlab.com/qemu-project/qemu/-/tree/master/pc-bios>`_:
diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index cfe1acb78a..1a405e4782 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -500,7 +500,7 @@ What you should *never* do:
 - expect it to work when loadvm'ing
 - write to the FAT directory on the host system while accessing it with the guest system
 
-.. _nbd:
+.. uniquelabel:: nbd
 
 NBD access
 ~~~~~~~~~~
-- 
2.39.5


