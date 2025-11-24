Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EC0CFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTHq-00060D-NW; Mon, 24 Nov 2025 04:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNTGW-0004nX-2l
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:53:53 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNTGT-0001pw-RA
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:53:47 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso18961315e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763978023; x=1764582823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIXv6XnAvdl2C+DvX/l80MOD6jY2xhAW4OuUBxjlIME=;
 b=R1iQXIMvuYkUAY8VXlFXgAXYDa+m/t/8ujdgXVkRuef0wRRaAZnIfT38kQ978B83ZT
 D4lsZehkBqgSQ3ThmxfS7e9+IQ+I1cpLCqYJO3huVpBY8nq1rBkJXCSPMXVBnWvc8OK+
 z9WXzpxWQU3JLH9HE8XwGNBnCRRjWLTeIaWTKnKsC/Hg4z0TWl0fSnwHZJG6NVqwYCEu
 1MWX/uU+kX1BOQ4iVJyB+SPIE1i7ifrwFuM5rgZp4cjoX3WlELSe7TsXPqSGnyvbQGAQ
 Kgii/BV1jKm89Yb8uqsBCPEvjgS7GucQKgE7Pkp9oDXGekfIFOj4aP6UFyc1j8KrttxD
 49kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763978023; x=1764582823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wIXv6XnAvdl2C+DvX/l80MOD6jY2xhAW4OuUBxjlIME=;
 b=jsn1po0y2Snw+r8x9ON8qnvGu1CTlpeT9/QccA61Neq24tSmhrs3zQiWEcOiqvlCpx
 lc+XTNarKLvkK8uX1/haxUcfUWfrWRP5raFBUayHDNCNOxrmT1a+kszlDFmV8ITXQbyY
 ZSt/5dib1NXPRz89tjdd33FWLTp25YfluHW+bY6VzmaXQqZ1pEKcjRVC7JwCFFzxs5nP
 AN0ifAvglikU8QRQi0hTF97aZPuIJ+TMNfJR+8O/P1fX3PKN//Mz4z4naMQjjcs/LiYz
 6zE/IoDBBp07Md+x4Hs1qwercJRUui5W6TXTVmC1HlzkOxonuhmmCs2YlClMxj9csJoa
 9Bbg==
X-Gm-Message-State: AOJu0YwUNcUi6VM70bUGA+kMngQ+rOmgW29RN+PWGU31pKisw4YXJ6kp
 uMuw2rGIm92jW4HWj1Y7YfDqNh7Y+0k3dTd2VTPL2Bgud1NBOnnroOwangDnXy+4ajBognD3YpM
 ZH4WW
X-Gm-Gg: ASbGncs0BLBjaVYk5rEBSN/jhlxbmvGZDR65lBVCF5r1XDD0gf7lqcbi53SxCfe/Sha
 G1dtOQbp9r0uhiplCbZiSTsnTLT0GFuOz7OPl7c3H1RoVZInnhkln1eIPvCwCVnKEQKv14srdfN
 /epr+EbfD8WpbvFrr06A+sbNM9vR/LVb9ojVrLkJ3PQv5mng4XDOkC7WQaBmkbYlnxN2MtlUZSq
 1/xuFw026aJ83mK4K/0V41F+iRKEUMr2iFLEzBmfTb+ER+ueiSTFwpEBP01L16RpxRs1SUdYq7A
 lnzxk50XmMi9qpvO2uXixhkKXW4LJ94K6Z8e0HLYwdlSjwpgRr/rjP6UsWzvS0tepO6kjGS5NDX
 MUWILoOTo+8JFZp429omWvWDLljaSOoHQyjYANCtC9tlWEJV+YYridESp77URFt9Blq9Ce0N5Bk
 7c9ow80je1Hec=
X-Google-Smtp-Source: AGHT+IHZk9nz5Ef+j36cZdFT6jAWXO8Bn6DdyTCbQTUBvhKIUqCPooB54/S1eowrpMrnTeiB1Wu1mA==
X-Received: by 2002:a05:600c:c492:b0:477:8985:4039 with SMTP id
 5b1f17b1804b1-477c1143024mr104389005e9.17.1763978022835; 
 Mon, 24 Nov 2025 01:53:42 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf36d1fasm180885495e9.7.2025.11.24.01.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 01:53:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2927560221;
 Mon, 24 Nov 2025 09:53:38 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Sean Wei <me@sean.taipei>, William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PULL 6/6] contrib/gitdm: add more individual contributors
Date: Mon, 24 Nov 2025 09:53:37 +0000
Message-ID: <20251124095337.537277-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251124095337.537277-1-alex.bennee@linaro.org>
References: <20251124095337.537277-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

I only add names explicitly acked as individual contributors.

Acked-by: Sean Wei <me@sean.taipei>
Acked-by: William Kosasih <kosasihwilliam4@gmail.com>
Message-ID: <20251119113953.1432303-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index d7116f5444f..4f4645a84cb 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -42,3 +42,6 @@ shentey@gmail.com
 bmeng@tinylab.org
 strahinja.p.jankovic@gmail.com
 Jason@zx2c4.com
+amarjargal16@gmail.com
+me@sean.taipei
+kosasihwilliam4@gmail.com
-- 
2.47.3


