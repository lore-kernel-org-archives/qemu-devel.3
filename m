Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98187C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 18:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scU2z-00028x-GU; Fri, 09 Aug 2024 14:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2x-000216-Hc
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:09:03 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2v-0007E6-VQ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:09:03 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0481so30874251fa.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723226940; x=1723831740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bV8ikeaAUAZQosDzE0s/Lkzb0lfb7R8ZRGC15xmyP3s=;
 b=NE6YcxpG8tdtCKlblXo/m1YgdzVv30kKs9PNzojYf2OT3ubH/42Bzk/NUEqjlo8dFF
 SuLeC4jIyJIQ1Ng2gWth6mPZbrfvcrT3bXO4gBwnNo1P5AWIkCCVN0ygoIpbWtl+Sn+T
 vTREyz+a33IX3beHIGKFjj5BIevIMYliGsJ86PZjcfz2Sf8++rJtd0GjXjiFhjk9WvHq
 8KGCBlG/++pStfjmEQLH0Ug2cJugDPNnEHe+FV/dTihzpImogDJzne+9QI+N5KKrBDsT
 zhosazDznbC8eXCctdYgMtd0GiK959Z2UFSwDld19Axa7DcpNOcl/nhYOGCUGCGRWI3x
 w9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723226940; x=1723831740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bV8ikeaAUAZQosDzE0s/Lkzb0lfb7R8ZRGC15xmyP3s=;
 b=qXjYsN/qxkW7X0hQuvuPinr7GzVfIll9pidbQzjtz99aZb1Aubxlggpa6Iq8WvHPfz
 6y23+pXYKp+MQLTYmlSG1CHbuWUHPklBrKsPqxrLCsaSQkf0Ek6100YWcPz1/oQZPfln
 Xs7H4r9tB8BwFFlpBkMEYlMiCanpbncr7QJIdHAYnVlM4XzEiaUr8ZzTqyjwq3ZsvjCn
 5sAEWevjRphDUuNJUgpgfjXJPnPnhkAV2UAOGDy22ZRp028h/rgngo+mvTwAGrS5GvV7
 uL2OrdNmaxPCToEymdPBJ2bCkOE5lnfIBevRkX5p9397VjOP8E4yoFn5JJ+DbXtjtUIm
 WZeg==
X-Gm-Message-State: AOJu0YxzJAICRQXWcnisnWMtr5OtVxVCZ0iWAzJIKpe+GqY1wbPrziSi
 sf0GPHcVIsfhyqdSSapwEW41dxhmaIWloTrNeY01u3dSACBwZ8J+cPRpgsdue4OEOLJs9AeNVmS
 /
X-Google-Smtp-Source: AGHT+IFRLiBj6Zml026NmTbtvJ1BIH4KJliOlLIDGxzxIlmluvlXCSfzpt4eUiEBPM6RzhMVZKKqAQ==
X-Received: by 2002:a2e:f12:0:b0:2ef:2f53:c300 with SMTP id
 38308e7fff4ca-2f1a6c778efmr15952001fa.28.1723226940028; 
 Fri, 09 Aug 2024 11:09:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c937b6esm132262f8f.32.2024.08.09.11.08.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 11:08:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/11] docs: Typo fix in live disk backup
Date: Fri,  9 Aug 2024 19:08:32 +0100
Message-Id: <20240809180835.1243269-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809180835.1243269-1-peter.maydell@linaro.org>
References: <20240809180835.1243269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

From: Eric Blake <eblake@redhat.com>

Add in the missing space in the section header.

Fixes: 1084159b31 ("qapi: deprecate drive-backup", v6.2.0)
Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/interop/live-block-operations.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/interop/live-block-operations.rst b/docs/interop/live-block-operations.rst
index 691429c7afe..6b549ede7c9 100644
--- a/docs/interop/live-block-operations.rst
+++ b/docs/interop/live-block-operations.rst
@@ -931,8 +931,8 @@ Shutdown the guest, by issuing the ``quit`` QMP command::
     }
 
 
-Live disk backup --- ``blockdev-backup`` and the deprecated``drive-backup``
----------------------------------------------------------------------------
+Live disk backup --- ``blockdev-backup`` and the deprecated ``drive-backup``
+----------------------------------------------------------------------------
 
 The ``blockdev-backup`` (and the deprecated ``drive-backup``) allows
 you to create a point-in-time snapshot.
-- 
2.34.1


