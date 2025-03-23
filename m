Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0A3C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 21:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twSzr-0001Gl-Ix; Sun, 23 Mar 2025 17:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1twSzp-0001GY-PA
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:36:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1twSzo-0007mX-5R
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:36:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so28025865e9.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 14:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742765798; x=1743370598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GfMWTr3aY5IGA6JAL485a8Bddzr/9nKfXZXjVwMFZAA=;
 b=UXNlcU0IS0PoeAwPydjmjD2P2H5N20Us/+j4SlYquiUcvs8SFUOyb/f+KVbuR5jcJ5
 OheHfvC1Vl1Wyaou8A1NcDFpRaAVjHInlTKnNfpzNYyLvmMNDr2dF7r5yWMAobfeDA0m
 30cFrXmSPvVAh81onh1ZOW/OEl3N81fpf1MlGHL2wAtZVoDwp2z9qta/m2X0De5fi7Jb
 3OrHAxSz6SlQS/0nzz2jZvFdqwbkqvBoMXkKHcH7lB/uXqwSuF6wXZfYVbhIvtmZKJcn
 yuzgG7TLtRHBJFMa//VPiyecDSUehoFnX6bBJ1tLiElwb88eDq6ccvzeEtEAgRpvY03+
 xm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742765798; x=1743370598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GfMWTr3aY5IGA6JAL485a8Bddzr/9nKfXZXjVwMFZAA=;
 b=CvVyRiKiMJkz1gDCskt2hTaOGGtCJafBSNd572o9bnmWTIld4mGPimzrOyyrTMuzkM
 LE8APlJr2rp3Lu/kg+cucHFbCfvZy8ELGpU8gmvAmLsAAWcGV6lBl2M5XMjktP2gWUdq
 pYRQtGdvuN63NVN0ddHzxscB7P+Jke8HwMnEep3hP0gpGfBc2yYs5HMbhbwBU2xpp8CC
 hdser6fmlpvmBLBow5av3z9pobALNsfxgEfQLe6aWNWRjUghHzUZn9LvAPQcKx59HOBs
 lBny5WbFDmEv9dYo3WPPNJz7BtBY0EZg+UQvhK8ZpZNvO1/jjrduXFjXgrrvp+ForWBI
 5MKg==
X-Gm-Message-State: AOJu0YwvEieRoer4VeiLsDZrNGR4FBh9EwC31cs7yi2p4FzJTu/kKRZh
 GVNlROZx5srBLWfLYF37xnccUitYJRcYBgijOwGGR83aKkrUEJkS/lHH1Q==
X-Gm-Gg: ASbGncs9lso1L7f9uNRc0NSdRA9I9X12tsUZsEKjh9lqc0fD1Bn0BXsrO5uSSBpUFPM
 js64yhUUw1TtBX/N4c7AFU4hdsEskA8wfO4IuCwmYHItPA0ezZkEPmWApGtA5XfQi27Qh05KFK7
 9NTCvW1iBJmPaWLJ+3lI4r3vmiH6w160AwCDnxCAuBKCwsbld3/D+jZTDW+s6PBaElhmGOFyJ8E
 ENbrJQbzdUJnjgLzNbi8q6KfJu4ck4T2WA+6eyDl1aW+xkQ4oENiD0UjaHw7FxDhUXd2JGnxsQz
 Hfc3MJORnt2Orxzd0wF22nvuAO+dGP7lWQC4N5Af6u7rCN2MfiYnxlfnN8XaBw4JRVe/gSLxS8V
 WcnjjH7Gx6nQ4WETZFXN+6/fQWCOsgRx8lc9faYoNOHf6uKTtnEX+gOyiiDqAcpfYsQ==
X-Google-Smtp-Source: AGHT+IGotrDXIa5xPIiIhW7V6AS4PD6Etc5B2t/J9crqpWwdVKAoWRs4jXxqcqrZoCHQnG77Wc/09w==
X-Received: by 2002:a5d:47ca:0:b0:391:9b2:f496 with SMTP id
 ffacd0b85a97d-399795756bemr11616331f8f.16.1742765797852; 
 Sun, 23 Mar 2025 14:36:37 -0700 (PDT)
Received: from localhost.localdomain
 (ptr-4gzr90iu0qscra4za0c.18120a2.ip6.access.telenet.be.
 [2a02:1810:950a:eb00:6ef0:5527:345f:b96c])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d43f55721sm150123075e9.20.2025.03.23.14.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 14:36:37 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: qemu-devel@nongnu.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH] smbios: Fix buffer overrun when using path= option
Date: Sun, 23 Mar 2025 22:35:54 +0100
Message-ID: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=daan.j.demeyer@gmail.com; helo=mail-wm1-x331.google.com
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

We have to make sure the array of bytes read from the path= file
is null-terminated, otherwise we run into a buffer overrun later on.

Fixes: bb99f4772f54017490e3356ecbb3df25c5d4537f ("hw/smbios: support loading OEM strings values from a file")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2879

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 hw/smbios/smbios.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 02a09eb9cd..ad4cd6721e 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1285,6 +1285,9 @@ static int save_opt_one(void *opaque,
             g_byte_array_append(data, (guint8 *)buf, ret);
         }
 
+        buf[0] = '\0';
+        g_byte_array_append(data, (guint8 *)buf, 1);
+
         qemu_close(fd);
 
         *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);
-- 
2.49.0


