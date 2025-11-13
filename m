Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B3CCD5BBB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJUWI-0007eU-Re; Thu, 13 Nov 2025 05:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWE-0007TV-T6
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:34 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWA-0007HH-5W
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:34 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-64165cd689eso2931415a12.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 02:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763029529; x=1763634329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gZdfn5DTRUnuvKpFRrCy4/zIYR7A5KWzbxEDTPGlz+4=;
 b=zwJWF/RmVRViEl7IBt0gpE4mgTCbDOo5nLWjj5vwlQrA9JZ12LMk0sCHSEnJKee8Ae
 M9vZSba1hQdVgHUAdANLigI2gs/vhl9SbdpY5lXAN0y6pjFPHrVWkEpLEiAdb60vZ5io
 zy3cig+yCPx4nRzLKKWmmfvEoaZANm+D7icGDRECbaoG4T9llAfq2Ah0wY3Fm1VCxs0C
 zUkzK//5bd1aMDfXra8EOvS+BwRmVXAOBGBWoF9D2iI5lja2uNV9/1JyBa1f8KIXtp8x
 dMvKodehAkeDpQFtKc1WGgNAHSVgvkEM/Fn62tNPYxz8pZHB7c88KqACMWjMjSGTLFsx
 TZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763029529; x=1763634329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gZdfn5DTRUnuvKpFRrCy4/zIYR7A5KWzbxEDTPGlz+4=;
 b=PlvrcJinJ+dpJ+aaERyzIGxf5Ome8Cgd7U27a6Qd2DOxtk34gcCTqY7belnv07mLKj
 cZl83/2DVZxQNN3TOGWmAhPIOedzWEFgdGoqM+fG8iIUTgvLaG3XVUEGEBw41uSl8Kua
 EwzuOfu0mNCMLRSJt5nE4r/skOdMvNyijHVsRB+OC1wfCE2oZ6iUkNtP4DpT6iX7Ipol
 N6qKSifzzTFDC7IRlzk2ghKxtmRNe9pW/KsQK3hx58dAdPIPftY0X6WOlY+nQShC8R8d
 r/v2kpUZobizqh4pryJAkcW5+GkyD3sEuDjfkwG+hglyi0LFNEffZfY82n5VzygtopIA
 EVEw==
X-Gm-Message-State: AOJu0Yxi6LUUr12xJyCPjH+jROj0xNQia/T55jQ9RYWcVRU/9l8mec1Z
 8MLlUlVoYYwxEgIr+t4QKIWO1dTeJynxLUqR36WTryK0KDtJsjy4E4skeV4Ieup+irw=
X-Gm-Gg: ASbGncu56PvPqYrZOpEk0e1wtD1EJ4829uSYKilntQFUGE66uz+OlLNLh+jIC3ogutO
 6scHKo/uZrEY+wVhnLCGkm0YksCTK8nvGs8nVEgYN3k498JVIXPOCYr5ME4HqfossdumXTXTKYe
 05ia1IgzCkS0pzcZMum4LzpFEUsQ9Dndm0tE6I9S1XVwcIVr6IU2TPXhmnetwCmLJvNx3Gq+/Fa
 Y+tHo4UW/gyB9gNvd2ieEMwvCiKFMUcgsF5mY+c1SO8Slz4gM8aFIrnJb573yrQQjcKI5rWfctH
 myY+Rf++Pl4s3MMNM0bzV9q2VbaEdX+MaRYbf1CxAzmmylQBqj7iGu7UZvzawkC7H9pRIGx9aVb
 pqdPZuLHTWM0OeZt54X+ayKLbNUc/M+4attayyymAMJoZ3YARSzWb1yXToexNV/el/Bt4WGBLes
 D/
X-Google-Smtp-Source: AGHT+IGv2cm7ocr5fzcGcxPLzJmrIGvdICG5Ubl1uOdDwPm5NY7NZZIVnCcz+xF1LI0qUZZ84+tcUg==
X-Received: by 2002:a17:907:3d0e:b0:b72:dcda:fe5a with SMTP id
 a640c23a62f3a-b73480bdcbemr275276966b.5.1763029528656; 
 Thu, 13 Nov 2025 02:25:28 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fa80bf5sm136504466b.3.2025.11.13.02.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 02:25:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C72B55F846;
 Thu, 13 Nov 2025 10:25:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>,
 David Woodhouse <dwmw2@infradead.org>, Ed Maste <emaste@freebsd.org>
Subject: [PATCH v2 01/18] tests/docker: drop --link from COPYs in emsdk docker
Date: Thu, 13 Nov 2025 10:25:07 +0000
Message-ID: <20251113102525.1255370-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113102525.1255370-1-alex.bennee@linaro.org>
References: <20251113102525.1255370-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

As we need to build images in both docker and podman lets not have any
incompatibilities. I don't think it makes any major difference.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tests/docker/dockerfiles/emsdk-wasm32-cross.docker | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker b/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
index 6b1642a207c..1f08eb0b855 100644
--- a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
+++ b/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
@@ -115,8 +115,8 @@ RUN mkdir -p /glib
 RUN curl -Lks https://download.gnome.org/sources/glib/${GLIB_MINOR_VERSION}/glib-$GLIB_VERSION.tar.xz | \
     tar xJC /glib --strip-components=1
 
-COPY --link --from=zlib-dev /builddeps/ /builddeps/
-COPY --link --from=libffi-dev /builddeps/ /builddeps/
+COPY --from=zlib-dev /builddeps/ /builddeps/
+COPY --from=libffi-dev /builddeps/ /builddeps/
 
 WORKDIR /glib
 RUN <<EOF
@@ -141,5 +141,5 @@ RUN sed -i -E "/#define HAVE_PTHREAD_GETNAME_NP 1/d" ./_build/config.h
 RUN meson install -C _build
 
 FROM build-base
-COPY --link --from=glib-dev /builddeps/ /builddeps/
-COPY --link --from=pixman-dev /builddeps/ /builddeps/
+COPY --from=glib-dev /builddeps/ /builddeps/
+COPY --from=pixman-dev /builddeps/ /builddeps/
-- 
2.47.3


