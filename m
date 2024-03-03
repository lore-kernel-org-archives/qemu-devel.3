Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CA2C5475B
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 10:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgjRQ-0002Jo-B0; Sun, 03 Mar 2024 05:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgjRO-0002Ja-6Z
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 05:51:34 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgjRL-0001zF-TF
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 05:51:33 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6da9c834646so3222889b3a.3
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 02:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709463090; x=1710067890;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T3tYaNcvH121evad5hrC2hPT8ahKSlk1yp9xd2sfeno=;
 b=PtWPUXyVZ8KicNSydMn60VlxGpilarQH19MPnAGdovuw8LND1B0CP1K5RG6xkIUQZx
 NV7GdMsG/x5XzkNkZG12sx3s8mO+rKW0zW1MI2Hddn1xfYDizXCugFU19Wfa1uDz5iF2
 ZQiwFpPqgM5uoj+vv2PzWfDWhzmocKbyHnJAfYGxSf92ML5hfibctTNF1WoHo++r38zL
 /cl+OOq+P8+uhMCi/LLujkBVfsjURlrSmwFUkNMds9wJpm+WGFLh1V6AOlqPyLqPAN17
 /py+369lO4oNi2UFOS8DCLsIWMmAbrVZ4iXqoiMkGfN8sGkq6ZYgl8XUkmAsGKPtTolZ
 k9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709463090; x=1710067890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3tYaNcvH121evad5hrC2hPT8ahKSlk1yp9xd2sfeno=;
 b=qgehhb8Krstx8PShmiDfIusmtuKaSk4TKQDnzzvPyPtr3MXzs/wG4PSD0M+rZgFxpD
 wLIHTFe5YCzJbQTVjaNq3xJjHRmLiS3BMDa51DTBZ1OkS/uwK+yg96FSt24i4YRN7VsB
 SJ1Hcd1rhGZIlQ+kCBhXqplv71NtIdZiZE+qTvc6GMULlVS24sO1Ap3GLaUIoZGH0scz
 nG+/VcfB9wSQsIzGExqwmiz3V53TvVUg5RpEUDyBylrqew0BVUVrPH+IboMDeJ/45nKC
 FlqPWGyD1pXKC9tt6an67TM+PVgkzjlbnMBPF6jglYCRlQhP2GQcgGhsJM1aE2puREGg
 48kg==
X-Gm-Message-State: AOJu0YxekKXehFtSXCe09DybOVQAv1j6l0cO0jbUeHvOzypyiNIJTs2G
 ldd4fAk9J8BYc1UDnHgii/Vna+Zfewem9xTKr/trtN+oNgwo6r5uE66eMHa5m8xV9JhMmBN+vzM
 K
X-Google-Smtp-Source: AGHT+IFHl97K5u4+NKXu6IsXY15KLt9NxE5yymLidOc2F1+X8vi9Ik4YpOiVMpWk7MOi1xzqAo5ZCA==
X-Received: by 2002:a05:6a20:3c8d:b0:19e:67b0:9ac6 with SMTP id
 b13-20020a056a203c8d00b0019e67b09ac6mr8665647pzj.1.1709463090636; 
 Sun, 03 Mar 2024 02:51:30 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 sl6-20020a17090b2e0600b0029aaabcb82asm8084315pjb.10.2024.03.03.02.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Mar 2024 02:51:30 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 03 Mar 2024 19:50:41 +0900
Subject: [PATCH 7/7] MAINTAINERS: Add Akihiko Odaki as a elf2dmp reviewer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-elf2dmp-v1-7-bea6649fe3e6@daynix.com>
References: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
In-Reply-To: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65dfdc9677e4..d25403f3709b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3583,6 +3583,7 @@ F: util/iova-tree.c
 
 elf2dmp
 M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
+R: Akihiko Odaki <akihiko.odaki@daynix.com>
 S: Maintained
 F: contrib/elf2dmp/
 

-- 
2.44.0


