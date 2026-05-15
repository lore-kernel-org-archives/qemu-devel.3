Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC61CD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzy4-0003WS-6v; Fri, 15 May 2026 17:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxq-0002ym-QI
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:01 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxp-0003AV-Ef
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:58 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7de431da8fbso321506a34.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880056; x=1779484856;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yEnwcLeGpg8+Aatds6AxT6Eb+Y85spWjquA4JTnuWfQ=;
 b=U/H/Lgs+0o4Gf9cKuGeNco8OAELVVIlL6dRlYBZUvhbHarhg9GUgh8htoDJ6Vf2JkS
 yMocwKhc4KVF8c/NxMbK48DTCJ7LASsJmDNPq6FuLEYnTMfFExwjU5oIuUarvfxosSdb
 EAdFzAHzSthnuJ2KvTu+IxHI3hU82ng+qo5hPXCyxKQVWgaYp3THTKgIxCO+A2S0U675
 TkTLn9NsihrrN5rrmiS0u9CEfCKCBnwfGfZ6UE+1JBIWtSZz4c1+6fg52Oii2fWM4/hP
 QQCy5Aihb4nDg4RzgDaaODtV4CtwVh5Ezvg+9QeuUubrIc1ry+2TME3E6NB9UHHKOr3N
 HjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880056; x=1779484856;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yEnwcLeGpg8+Aatds6AxT6Eb+Y85spWjquA4JTnuWfQ=;
 b=JS7vL3xGG9Q9h+1GqLNPS1aMKPU0PAsZWHGZzelut9teysM1eWdHwyogLy3hsBNSKp
 M0pmE6npBxLMtW9XfLfuPFNSdKobKQo022QVbAqGTdvB5Vs2+B+m/+VznA+Dt+ksEL9x
 h1zHuEzRFWBxiB2egW8UM3JFc5jWDFZCtOO4ukUFQHPPgbNYc54+/iNbKMpaq3uTdQL2
 QWaBoimhF2f1zfGYnBJtxvRkdi2rle8FltHvP6zQrqgblSeqyJ0h6VTW3iTPkRazM5OX
 xyLfcvkSzdcCH2xa3dUJBDhp5ObJceRXMK+Gw2wGDWl++N86SEXZEUHkktYoHQNPu6dJ
 8tHg==
X-Gm-Message-State: AOJu0Ywbvsirmie8QM+H1XS5SXljQ+oMJcfRLQPUPbnxqm3VMgLYIP6P
 vLH9jLn7FV0tPBGgsuoc/QdK9JXHtDfPOXb5cqiIiEoJbgYCmZfy8NiUgHDSXl3KcxA/oAfUT5m
 dMo2l4gg=
X-Gm-Gg: Acq92OGhFcFPj2zdW0LhJDkvFKHmKOMmpxbyK/LO8yAk+6qpfpuXGgpYWO55orMhGU1
 6YRCLdpEc7hySAhzfRZWNYVdEHLRCDGocyZxMm1khCYbyJ0XhBXwnbUNkK87LGKXyGTm01vg7ah
 wX4TihhpJcDrYWxurkYcqTrUWtNB/Aj/18zUHddmzIUaV8iu4X0EprnewMtEakdOe1TsqIU+BR4
 dKFH7wxURgkbXWYetvk66VqYDKiDTPhimmH4NdyYt4/ok61IKlq1rgenti+5S7mp8RkAPcjZ4XN
 AafMiAl4DA2X+bADOTa6//ah8cCFYz20A/mbtX93g6d4kj6QrS5LNgAshIqPwsOxHqInF45qSfB
 9Agl0E5wQY0hySYiQlHhKtYbdKZ0p9LWRzn10DiJf2lGg1uuoOvWdj/ks5Z6lZyV4l3sJwEFKVs
 Ilmh2jBKpg8w==
X-Received: by 2002:a05:6830:81d7:b0:7dd:e032:3ce5 with SMTP id
 46e09a7af769-7e4f2bce60amr3752255a34.17.1778880055978; 
 Fri, 15 May 2026 14:20:55 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:55 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:51 -0600
Subject: [PATCH 52/66] bsd-user: Return -TARGET_EINVAL rather than EINVAL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-52-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=ZAOx7TZKzDpoWv9sI4ywL/Z4sDbvUZIM2czCevWXdMU=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43nZjWQhM5Zq+ViU269WZMKY50NbaN7oC1TS
 tyUWJCku2mJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5wAKCRBsHNEofbAR
 AAxpD/9avKwc12mD7pmLumVBjEuxlSgsBYXqFnYP6gOC3zPqoyqv0JQJC23BJ4q60g3jH70+hZ1
 BhaPzdbLCIg3VC+N47fEF1VzzIk3tCVtHvV0/bE7ITPtCP0SOb8BVeRhO+JbhbpTwAhwdZDveyo
 5yMcEceO/PlIOj7RaGJegmDAaXdCdWGyYrwW6qU3ot9NIGePq5nKXwCQVYvaRXTZTMo7UuyX91/
 lgFa8M/HBjaywN77PaHKVZuIspV+XtlnCdDW0WWavA8+GHo9YJfWV3SsTiD2KDbtG+ndJ07bfYn
 n8k8ot54rqsZ6vSFVqi94ybQVYdLbY25iecYvYxWWAnprzIj7V79iRT/Nzelq2Mb9PkKq7U81vh
 OjCgOGJLy8/P0o9WIS5nYtGCgiq95rpwrO6rWI2+sLeAy/6pPvY9ERTSkpuP1S4JFfaM5FAUBy1
 XjXRNqoHa2Tw2JDpsYC78xGH6f4tMBskIR6zZ6AbrR8hE8vcrBGptY0uXD14RCW22FTxc0PyAFj
 yB4Tyh5//z1PGdr5nRVuX/k/34Hy5jp/7ikPBUL8sh/MA40gW7LWKsSwVkTLMODSXkCzPrwGjs5
 I6jiNbpkfXRqM3ORSdkG1+RXQ1+M0PbNwqLPwDm5gdMcWGXWnCYmMavdeIGBrY39MZW6pPxJOdL
 Gp2hAcZhUSEyHJQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x336.google.com
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

The convention here is to return negative target errnos.
Plus fix minor whitespace diffs.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index f1a49ae423..c8f88efc6f 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -1589,19 +1589,18 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         break;
 #endif
     case TARGET_FREEBSD_NR_kenv:
-    ret = do_freebsd_kenv(arg1, arg2, arg3, arg4);
-    break;
+        ret = do_freebsd_kenv(arg1, arg2, arg3, arg4);
+        break;
 
     /* XXX */
     case TARGET_FREEBSD_NR_cap_rights_limit:
     case TARGET_FREEBSD_NR_cap_ioctls_limit:
     case TARGET_FREEBSD_NR_cap_fcntls_limit:
-    ret = EINVAL;
-    break;
+        ret = -TARGET_EINVAL;
+        break;
     case TARGET_FREEBSD_NR_cap_enter:
-    ret = 0;
-    break;
-
+        ret = 0;
+        break;
 
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);

-- 
2.52.0


