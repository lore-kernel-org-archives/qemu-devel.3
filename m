Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBB0CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1Uj-0003kS-9N; Mon, 17 Nov 2025 10:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UI-0003bt-CK
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:49:57 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UG-0007wD-Qo
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:49:54 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so20472855e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394590; x=1763999390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ivdwNrOGS01xWkggL1OfrnPbkmNAF0idzh6eMRuOvBg=;
 b=s+SoRn/L7VOnqpmX2kjvfV1N00WML1vbRpWynumtbfhFBQ3C6W0+1ECs2ySviSMMZt
 CALJHv0+/iDav9AEFPVuqIxJunh9patpjnqJclt6K8n/jdv03c2xJwBTY4plGOJUyu8G
 ElJRJaXHUQRN06A4JVGv5uJ0N/OEG1/lPeUJbbS/xH0FF2NhOp+IhJJeUacbbPBP0iwt
 +tsUcCW6w2Cj+Nlfb88yPIOuPiEQlM9cr8LAfBMH+gGsotS1AaiNgevTtR91hEAIMxae
 ObmoOTO0toT8b1Ezs4S4cgVsecDflzNUMIUqeHCHIqMdocvywla2wGOOtcUMww28PYFt
 gC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394590; x=1763999390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ivdwNrOGS01xWkggL1OfrnPbkmNAF0idzh6eMRuOvBg=;
 b=LibkgsTyG3kiT6nfmzEeslI46IMnZsCxy+SCICw8vh3LN8/a/5aOINFJYyaYafy5zH
 ZZ5169z9hfnWHpw2GTMhvvOdjEv+3ZGRMmWc82lmyjQGTxkLQnpXdnzhtiObAuOtoFME
 4pmN2fUllJUJrKfoMJpLDjBjGQ+EfRxtp9IENBgUbTx0KCUBKh0DsK+aGw3jKT6iJBJN
 j3JZdv+Apx2nAq/abgM/vO3Kce3mfIRGZgFZQtzcirjqUZYq7Lk+cVXZWujTE5U8o7H7
 FFFwXaUAslOGiSsU/n4u2e0Zl+f63zNSuzAEfK0K4lUwr7an8ZTHWiKxZL0p4+yay7uH
 4FKA==
X-Gm-Message-State: AOJu0Yz8BuwhRH/L8106QmeOkq59w/5QALtgT5A2d6vESZzd40LMsBkQ
 EZSoRuBYuI0OY9oAAv+1331gcQa1Ypha2ydIcQCKt1uX9D13CcRAtEssqFNG1lqT3u0=
X-Gm-Gg: ASbGnct/7i+v1XOtonAjey/LVngdy+1s2GnPGx3kuFvGPOXp5SrVQD4PyGnjqb+KBtD
 vZVeFPn1LsaFObdNDOblUG3xZtlOO4+3wB+sh4mA7PYyeIw8zsgIp4u0h2mEIimYviD1t686jEL
 viX5wFMQL/XZUaIpwncIOn7eoAKgzCdJ7lHcXnMGtlxaeDFFIeZr2ZCdlK5VlVzRdaDbm5WrBED
 VhCbNG/VzvK8297xBq2mCD2a7UR4aRxYTFv+WMezenp3zUZtwFSGk5AqLoPGL7JqYuGlzZyCr7p
 9N4figcXaWh7egfTguLcctFRymWxM0eumKX2aLXCSFp+zYt/uUa3TCXy24KNjQpX5U91KKvHkH9
 Xu3VReb12C67ENyYIRCNhPDA1a7CYTm6cpNuLC7V7BEfKauMfLhha1ll5ol0cmGsUesWX05vib+
 XaRUpwqA8dPnE=
X-Google-Smtp-Source: AGHT+IGlT+3nigKgKyheDwELVDYDaTqiUCg1RRWm61IvIJmuSV6LLK9yRLRY5gXVtoDkybYSr+UMSg==
X-Received: by 2002:a05:600c:4513:b0:477:2f7c:314f with SMTP id
 5b1f17b1804b1-4778fe5c820mr137637465e9.10.1763394589964; 
 Mon, 17 Nov 2025 07:49:49 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e6a1sm304404475e9.11.2025.11.17.07.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:49:48 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4685D5F860;
 Mon, 17 Nov 2025 15:49:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 01/18] tests/docker: drop --link from COPYs in emsdk docker
Date: Mon, 17 Nov 2025 15:49:30 +0000
Message-ID: <20251117154948.4122164-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117154948.4122164-1-alex.bennee@linaro.org>
References: <20251117154948.4122164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Message-ID: <20251117115523.3993105-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


