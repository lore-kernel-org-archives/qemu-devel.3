Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB89C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKae-00055e-Cn; Fri, 29 Mar 2024 18:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKac-000555-Hl
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:20:46 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKab-0001oz-41
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:20:46 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6eaf1005fcaso340711b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711750844; x=1712355644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLgHs0lHF4uZkMVrK5zDEoSHxG5H5AOQOiZmQyJc1i4=;
 b=L3rbRcnRU37YopaavvC0LPVDLo74+HkRRKxSgjIyIzxLkJETfQJeqDukH+Xu+cTf2F
 p5HtKh3bCO7qRyMkJMHzbUmMdD8gBYMGfB6UkU4OWYgdKnuzCty4Fd7IsB6PQOVB8aYt
 CgDNQ2aOg1jfl0CsQUkhBA+Uh4nmOL2vN2Z4JGO75V8cc8WGfC3Baaw/eyDfJ0YxksgE
 +Fskm1H6/tqSj6mamxDqDZ6LuvxNgreNbNMyhmW9wGVMWfFvgGGZwp5Hd6vpcB8ctI8V
 qqY4aMN511OPDw2wjJKMdPvw74dV4ztuW0cWm6bXtsAlYCodR6GwCiIyHdOZWStCJQN+
 0a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711750844; x=1712355644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLgHs0lHF4uZkMVrK5zDEoSHxG5H5AOQOiZmQyJc1i4=;
 b=f8zDPMg8WVYdh1waAvDRZU5fF8Bq09hyIjFGXmrNui5JcTQ0FyEJrnx9eI/OaJhc4N
 Z0lEOYIOPURUDa8IdMrra9TfHIzwh7Lxon9vrI1kJ0BaZ/COkFfhR4G3kHRb+u3OPBZz
 nyeBAelAXtelyRd4h7rY9PHegsiqtMEMPjw2tzPuWSJFQblS95uomChB6zYFTB2qaAEo
 ePIqPmcyXIX/o6EzHnYCnIoIcTmaGv/gHZSzwxcS7hFfM751BW2VEiOTcUZcgzGh7TAv
 6/ra5uPJLn2fsUOa0Y9DmK/O9J7gAJ/aQ3GSZCdaghpdwxu+P+wvVE6wGL+z1eMrUMCb
 tQlA==
X-Gm-Message-State: AOJu0YwNZJgQ5A14VLE3fGP+ytzyfnJe5oxB/7qC+xnE2snIn0UAksnd
 mNXKxmwuG9zzRIE+Q0FPFJJ6p36zmVmI3sPgUasR9oWeoy4LECdicbsTyU15uCA1ydPlWu9K/0k
 f
X-Google-Smtp-Source: AGHT+IHN59+by1kIong4yHUfgIuSfRFMHf1n2EmLUVLGCxvDf6ks61L3QSP90pJnYZnvhPb35MNbSw==
X-Received: by 2002:a05:6a20:ae86:b0:1a3:dc19:e5a0 with SMTP id
 do6-20020a056a20ae8600b001a3dc19e5a0mr2851946pzb.41.1711750843638; 
 Fri, 29 Mar 2024 15:20:43 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 lc24-20020a056a004f5800b006eaacc63435sm3579811pfb.173.2024.03.29.15.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:20:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 2/7] linux-user: Fix shmat() strace
Date: Fri, 29 Mar 2024 12:20:32 -1000
Message-Id: <20240329222037.1735350-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329222037.1735350-1-richard.henderson@linaro.org>
References: <20240329222037.1735350-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

The indices of arguments passed to print_shmat() are all off-by-1,
because arg1 is the ipc() command. Fix them.

New output for linux-shmat-maps test:

    3501769 shmat(4784214,0x0000000000800000,SHM_RND) = 0

Fixes: 9f7c97324c27 ("linux-user: Add strace for shmat")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240325192436.561154-3-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 51a5bdd95f..b4d1098170 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -701,7 +701,7 @@ print_ipc(CPUArchState *cpu_env, const struct syscallname *name,
         break;
     case IPCOP_shmat:
         print_shmat(cpu_env, &(const struct syscallname){ .name = "shmat" },
-                    arg1, arg4, arg2, 0, 0, 0);
+                    arg2, arg5, arg3, 0, 0, 0);
         break;
     default:
         qemu_log(("%s("
-- 
2.34.1


