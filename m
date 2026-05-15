Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540F6CD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxl-0002rb-0c; Fri, 15 May 2026 17:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxh-0002jL-4e
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:49 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxf-00036m-FJ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:48 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-47cbd445021so260577b6e.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880046; x=1779484846;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=huwi1I/ka0iZHPtPiOh93wv71GhTIIWhwbkGbSgPwjc=;
 b=GO401yidFkK7NlvhCA9pq3A7xh36J3rQbbjJf0WlKcWS5/mGcf3KibQBKrGAhdxiuU
 KipwlBJV5hn5ZWlkL2Y+y05flVjk55IEU93BS9SUxWMfCOSPR9i+AGyp8M2hjgL3j06z
 E7OKEAVxr1yDLTRKzC0KsXrKKQwmE8syp+7FRrgoKZMYeQzyySvsN9I1jgppkd/COVV+
 HSel1erGbLPL890xy9JjOw13dilPvAXHN82mDXgxEqKner+vYgwyt4XZn3hL2gZTwBYv
 gtAKI4YxmYLT6WtUlDbfYX7pgYY2p4q9WUlIJplSX6XDMeOaBNuxl6maOdhC0RIIyO52
 D98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880046; x=1779484846;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=huwi1I/ka0iZHPtPiOh93wv71GhTIIWhwbkGbSgPwjc=;
 b=BnPPI4pCh6G12TzH1adwy+SZhAM2kCfgJqHe5SRkLTkoakC0RGxC7hV2ViKbWgRDUA
 R5l3ikIb2Go4C+PPd62ErO1LdoP+TXfaJ6ju0ig9+zDbW3uTdQipDPuNuHq7WMB0R1rg
 JTSHdLO5+8/D3jTdXAqa0yeaPavHILEbLJAEd3UG8bI4Fmc59OGruWkcR8hZG6cmiIDW
 dfcUMYOilpnXC+kovJ8yaFiytddBT0to23PpmbYma6GMKZybh1QslcKtte78ghQxYw5d
 LgCdmMV6I0urOv0yEiBbzAGU8Bo1V6e3WrBQAdJkZt2OL1Saqd7ef/QgT7oVscS4wAZ5
 h4Og==
X-Gm-Message-State: AOJu0Yyty+zKyL9wkav6saLKXtBb3lBTeqCqDEii3ROvc+Y/4m0Ih9yE
 FQQ8fMXpXzarBdU6WQEnWKMIexTVPLtXKVghi/ScSThfWI2QE95w4kXMlaz+bkqVbUdjBNy7ros
 irBIloK4=
X-Gm-Gg: Acq92OGRQcmPlQ6ErbBjQvhy6E+wGb8dpvxMwwSiEaihUYE5vymgFGCGSrFZAjeVkMB
 kBMNLwPpP8j3qFyVdtw29Mm93OOHYtV0y8AtrsCH/XWdlS3UGJrwU9I6AveBwNORfQT5gMEAmp3
 /i39XVRlRrLAXE2o7NTvG3CkHNJQv3wu9AXaSqyvaIcPRvEly2RpDoMqXqz7E6IZKCf8w5Gp9L9
 DzMbq79RsurlNq5/05CRoh4vE5+AZmhTouma/B/GE0MH+lPE20iSecWwEy8tz19t0ljwFZT2auy
 Rb2fQLpIso+OykdJEt3D9skrvj1VzcHBHhH6R+T1JQ/4hm+MeNYKlownkl90sa5yPECNXZAgfGZ
 N2NHPGBdjXgiQydVczxuVU37eOHS6/NkMYqWj1koUj0ZAqdGRpC9f/F1Jf0WPEuDJ8WfTF4sUDf
 gNj8p5i8wLnw==
X-Received: by 2002:a05:6808:5383:b0:45e:ecd9:652e with SMTP id
 5614622812f47-482e55ae4c4mr4064717b6e.5.1778880045895; 
 Fri, 15 May 2026 14:20:45 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:45 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:41 -0600
Subject: [PATCH 42/66] bsd-user: Fix freebsd_lock_umutex to re-read m_owner
 not m_count
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-42-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=806; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=26DLjvIfcurHguoTpL1VROKTnCLKVIS1WBZAmmR48fc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43m1XvIT0hxgB1wf1DJ9LJRfYps1SuLKNERW
 SLQfCS1fCuJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5gAKCRBsHNEofbAR
 AEvHD/9Y8gvKVe+4wFS/zvVMXiX6hUuf8MMVn630NpMCj9lcqnSFs2qkd2nVwsp/ozHRXOxGLGe
 OkdzQlHwt8UL05weQvZAPA+h4qYMpcWmsVzRkBIooC8m+hTb2Qaw129s1EFaL8Rg28U0RAanNz9
 CK9M+SvJnKL8tsR7C+KGqRaKvAq+tohdjaw+vnz8454IiF73YOV1CvvXGQJ3wc4I2P0ksV25gc3
 z1jHYSFhuu7SyZgiaBRYhw1KmqGkLMSQ9dLNX5lRKR7QE21oU+XbcxX1pPs6wRAHVWNW/ZrgCU5
 +zHSL074J0PvsvgSedErcw3JU5Mk76gCjsL+cEwdYW34kRGfEVTxp0xMZGcXMKl22vYQSjRRdh4
 P5xkNPgNpMct/DMnwnO16o1Pj40716iyppT+3hxxzdholDbaJXugvZVqAw3BnOBMrTBZxurNABD
 0N2FENVrjaFJahtYznRtE5ASWxZcS5zeRaopyI1yCo5BrkUHPexWtgX33HLH1WrZdljynl2A7Mw
 S4rA62kT6224gIGG6cl+OrdhCvilaJ2WOZcVVHQbR3rYk4q+TZkUA4wOVE8C/3zquN4pWWAwV7R
 f4/4aBqiTCuciqVDI/LG6iELc0Bc2dOpdul6Mj/EcBA1B7o840yfY3rUADBYI62fOd1FMbUHSwp
 vjtcF1Lv57rK6Cg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::234;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When tcmpset_32 fails to set the contested bit on m_owner, the retry
loop re-read the value from m_count instead of m_owner, causing the
loop to operate on the wrong field.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-thread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
index 9e6055a040..b91e0d32b0 100644
--- a/bsd-user/freebsd/os-thread.c
+++ b/bsd-user/freebsd/os-thread.c
@@ -978,7 +978,7 @@ abi_long freebsd_lock_umutex(abi_ulong target_addr, uint32_t id,
 
                 break;
             } else {
-                __get_user(owner, &target_umutex->m_count);
+                __get_user(owner, &target_umutex->m_owner);
             }
         }
 

-- 
2.52.0


