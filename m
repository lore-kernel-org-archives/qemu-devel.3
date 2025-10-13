Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55757CCD18F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8O43-0005pr-Rw; Mon, 13 Oct 2025 15:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O3o-0005ec-Bf
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O3k-0001pX-9I
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:18 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so54615765e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760383094; x=1760987894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TiskSlcpHbVz6etHzZa5UXIOcmLt3xPCpjHSlXUbr6c=;
 b=YbfnCE022UyiZi5OD/osa4oPQC1CNRG5gigGpjwtIIxKbQOUZNMs5s5QCuK6H5C/bs
 TiMay4Rb9AueF0Fti4kF0RDN91562gJhDxfYPm/FuOjI9zhIZxxsp/SDs9MGAzIQHFnj
 ZdISbZv1hf36LtqGv5KmfuckmDFKzzDNBTKyfjtZz2Vi/uRx3HQVsSOHy9W2IeIlUC9I
 tTS7B6I6/GNTASB4G7cRAhFKyQAE+Qso/chojt+MROfxfxfZmw4fZ3goymQ8u4TVY73U
 cwOeDbd+w7IV1QUvSiyKEZzSGsS7joCHpDMcbcC5TLD6JH3EEpLwPa+4K7wkuTZdhHJc
 2QNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760383094; x=1760987894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TiskSlcpHbVz6etHzZa5UXIOcmLt3xPCpjHSlXUbr6c=;
 b=gqgJ9xXLpwB1L++c6crfpXo+WL2EOSSlsuN8TKqJAp1SzWmJlaymBkuacvansmpd6M
 WHMz/yflPodIkBZUZPAeX52jbbbD/bglOhAQjFjrb7xYKZ5yNwohshcDWzDGBBRJbNWB
 vY/i6aVG4ma0YsZbQmBT6DY86J6YKeAMLY/v8Dgp415Izh7QaEbLOI+nQWtqyuF22VFP
 lq9Ojj8/y927ZHLI0YKowwRmKNZyfD2ZjQw6bQXSy0nMXeQfO6FdUO/nmnZv53WoZEWs
 5Aj5aMdcgxDQeP8jDoNklHUaekPE6jgWyZlpY4/C95Tu2CBv01A0EC8BiaE/Oj3Ixk1r
 zH+w==
X-Gm-Message-State: AOJu0YzfKUzIow57vna84Vt/cvz6LIfkmf5y+ta30nsrEef8TukCsjP9
 8QXObgAu62Bf8l0IOPpr4vQRR4otacyDdZyFcJbcz4mriQb+ztNkyP0ZPOeuPeXd3THCjueGkOo
 KV4A/3gM3/g==
X-Gm-Gg: ASbGncvHPERsvx+jcyRhSzJQvkPCinV3ef82pAsn3XCo3ISYlEHLmUS29tQADOdE9md
 QLWnu0IbChyIc8t7nDnMNGIsQMVBXFjWn2/FJOqEBAun9CU7X1YI/ZAkWqbzcv/ZICvcqngS9uK
 gSAaVGeL2ZI8zlo3uxuE5CslsRDLuvHqi7f8zX0waokT/5XDIQsBNE9A/0z/8Meyp4/lmPwozsE
 rr+S4zJqwjsNfYYZJaJD2pgmeLeaecJNlF/KMb7HPkIE0VFNCkrInjFWXqjctaS7xorAfVyRp/s
 GH/t8p3gAI0P0ujyCQCuTekFSbV1hsRvOdQSawJwgCoQU1DS+MMrP/3ht351OepMRQUCpOCKx5r
 8jiNXsFhE8zMBFrgAOflB2UAZaHKFZnD4SETUABXyCmSuMuWn2kv31bkAbi45FKtcAZUvkwGmHr
 ibfITXi9R3mab5CxeN87Gdy36IEpDWGw==
X-Google-Smtp-Source: AGHT+IFDodQo9M24T2nSpwjl7e0HKNo2PXvheRtdse0f/NQ7gs8mrsx+GkEOPtpeUVpl06o6PBOrJA==
X-Received: by 2002:a05:600c:1383:b0:46e:330a:1762 with SMTP id
 5b1f17b1804b1-46fa9af1697mr156506475e9.22.1760383094157; 
 Mon, 13 Oct 2025 12:18:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce589a21sm20209395f8f.23.2025.10.13.12.18.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Oct 2025 12:18:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] hw/display/xenfb: Replace unreachable code by
 g_assert_not_reached()
Date: Mon, 13 Oct 2025 21:17:56 +0200
Message-ID: <20251013191807.84550-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013191807.84550-1-philmd@linaro.org>
References: <20251013191807.84550-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Markus Armbruster <armbru@redhat.com>

xenfb_mouse_event() has a switch statement whose controlling
expression move->axis is an enum InputAxis.  The enum values are
INPUT_AXIS_X and INPUT_AXIS_Y, encoded as 0 and 1.  The switch has a
case for both axes.  In addition, it has an unreachable default label.
This convinces Coverity that move->axis can be greater than 1.  It
duly reports a buffer overrun when it is used to subscript an array
with two elements.

Replace the unreachable code by g_assert_not_reached().

Resolves: Coverity CID 1613906
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250729111226.3627499-1-armbru@redhat.com>
[PMD: s/abort/g_assert_not_reached/]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/xenfb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 22822fecea3..164fd0b2485 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -283,8 +283,7 @@ static void xenfb_mouse_event(DeviceState *dev, QemuConsole *src,
                 scale = surface_height(surface) - 1;
                 break;
             default:
-                scale = 0x8000;
-                break;
+                g_assert_not_reached();
             }
             xenfb->axis[move->axis] = move->value * scale / 0x7fff;
         }
-- 
2.51.0


