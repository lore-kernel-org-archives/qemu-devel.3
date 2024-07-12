Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6945DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 11:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSE32-00008n-97; Fri, 12 Jul 2024 07:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sSE2z-0008Uq-SF
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:02:41 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sSE2w-0003ah-6U
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:02:40 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2eeb1ba040aso23297561fa.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720782156; x=1721386956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dc1eTWi5iZyva3MfQYId5KFBzpR8Jnw4CwD+XxknsHI=;
 b=igiPwKgHm56hZOm/Flx3nfEonZhq9fA5MXEE3xQdG7OGLhbFVAQF+sejwGFionmptF
 MD4KnYyyitr0XF0xb+JKs51KOT7q8kywNJBe2Q1HCP1yGn1pK1j9MCBRtdfDwGZtYBvK
 o6u3GYZjP0QOJ4hCRZ+6zqgWi0vfMWTU/u6gFCPkiDP01Z6jhKnp8Ot61B1k4Iwl3Lgd
 kLCjV1qahIbAw/TZKFhMSpzVSlyTME/DRT3DeKuYdGdwkMtoZ0aGUg6pcxCPgrqydUUA
 1I//g3I/xx80vbrtjunsWyF034cwii4xR9LlmjRHiGAxoQKymTzLFrTpQXbwcvIczw1L
 2lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720782156; x=1721386956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dc1eTWi5iZyva3MfQYId5KFBzpR8Jnw4CwD+XxknsHI=;
 b=tGXUqE2Ncz91z4Iz7wB4yf6OC9yZpv1ZL7qhP+6FGlSKdt3uWzMC1KTvSbuwt6VfHG
 tUASpa5UI4nwtk7oii5Od5Gq88yT1YTKAR73hL8RklniKAWiGZyix2flqPk81+8X0J7S
 wvIGLNfkgaoLnreA/aY0Hm3WcQsY3tNyfuuD92SPDzUPyRMIvgWm9o81dBmPNg5fQAor
 wR/ixvFE8OplEQ1SfFXO3IqcVkqZHb4nRqeXndmtun+45S/+IkRJvAW8a9VXSiAjCakp
 v+FdB0wLdt1fD0K+9OIA4ZXJW5IVSz1YqCWg+St5I7tfHkiqg1wJ4qXGLe7PfUpZTfzy
 l6kA==
X-Gm-Message-State: AOJu0YylMXb3d1L9ilCnCW+Sou1U7JbP2X1FkW/9Ok3hxsv4iQ0F4MB5
 /+cFwCHiqtWxHNfT1reCM3K/dChsl0aKzyb3QJhLRyhwIEk7nrthEa3AANN8
X-Google-Smtp-Source: AGHT+IHkWR3puHuo2XOZ/nDlGjWAHbnO9jGh1wexmZx11eY1lI0DYagRvxEN2CVXAlXL/la0QDxqUA==
X-Received: by 2002:a2e:6a05:0:b0:2ec:2d75:509c with SMTP id
 38308e7fff4ca-2eeb31977c3mr71565311fa.46.1720782155218; 
 Fri, 12 Jul 2024 04:02:35 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2eeb3489029sm10741871fa.104.2024.07.12.04.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 04:02:34 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, edgar.iglesias@amd.com,
 Stefano Stabellini <stefano.stabellini@amd.com>
Subject: [PULL v1 1/3] MAINTAINERS: add Edgar as Xen maintainer
Date: Fri, 12 Jul 2024 13:02:28 +0200
Message-ID: <20240712110230.4098056-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712110230.4098056-1-edgar.iglesias@gmail.com>
References: <20240712110230.4098056-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Stefano Stabellini <sstabellini@kernel.org>

Add Edgar as Xen subsystem maintainer in QEMU. Edgar has been a QEMU
maintainer for years, and has already made key changes to one of the
most difficult areas of the Xen subsystem (the mapcache).

Edgar volunteered helping us maintain the Xen subsystem in QEMU and we
are very happy to welcome him to the team. His knowledge and expertise
with QEMU internals will be of great help.

Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Acked-by: Anthony PERARD <anthony@xenproject.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6725913c8b..63e11095a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -536,6 +536,7 @@ X86 Xen CPUs
 M: Stefano Stabellini <sstabellini@kernel.org>
 M: Anthony PERARD <anthony@xenproject.org>
 M: Paul Durrant <paul@xen.org>
+M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 L: xen-devel@lists.xenproject.org
 S: Supported
 F: */xen*
-- 
2.43.0


