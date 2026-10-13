Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2820CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGeNB-0005UQ-GK; Tue, 13 Oct 2026 11:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xGeN9-0005Sa-0s
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:24:59 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xGeN6-0001vc-SO
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:24:58 -0400
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D7B853F5D4
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791905095;
 bh=rjcKL+WWgC07k0ZxQPNEZPioIh+IFao5JDwEYUSjP5M=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
 In-Reply-To:To:Cc;
 b=P1FPFSiILrrdKHNSJyi3lUxyiT3Z8iLcbe2PMRgzQRTnt993Kx9lvjuvUz20vZDMS
 QzPEvBhjjiMlHAvmP2+NCBMBYAl3y9fTmxpS+6aaIQGSsO691Hy2bGjWaa6XuAmPw3
 LGlXhX7FLywI8JvEpTck0s0zwecsTupyuLgvmfE0tzg6AGccKC0rlMH6KxpmAbdyBq
 DgPxUoMHgU1AqlZ8nehdJwaXDeC1s4AydKUQpl/M/BtnCAkekMaDjXdsljrOAgWS+Q
 WnGRn03xzxi4CJdBUhSN63N0hMjyukXGHx+E2QmeT2NnQgYuJvsQH830hE3oyNF5u/
 3r4V/uaxlxyg1JNMMHypUsXngQYFpvKTrPBmWaPDOMgp495Yd4T81NEm7oYFsfHlpj
 nQbwk9Uu+SPpM7U5fYhJi7AEc8R4hlUvRV5b41eotHeUuhJqQVIweUGN9lnYCyIBaH
 IbFo6KWnMq8ZVfbPx0EGIBX8CKK8KlnNWAgDAkkAsg8LswAFCB2XhCLkLv1bfDVqkv
 SIuavRX2snVH/zVcHpGzLL8ouwn8z/kA7OXvZMProZQlnTt4/QT1ipSV5wqfdYLfQ6
 x72m223T1M0R8bQb7kbfXSrKrLlG2SEnCPX0TQXw9zvAUNFh/NXIddWhE1VX1j1A5N
 JgQZDV+Q3ylbeR1uD9rUzcWA=
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8b0a28d6acdso245797b3.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791905095; x=1792509895;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rjcKL+WWgC07k0ZxQPNEZPioIh+IFao5JDwEYUSjP5M=;
 b=Ghf93jJ/1EgkkV3A3U6zBsHWRbXd0a0bw18iEPjhjeIr+Fjs3KMl1mY0N03lw3IEgr
 0+dgLXzCAlbQwkIUIGYweJHSAzYxaA4BO6N56GQ0YZsv6qOuNirql8bhB2XzozZxYzUt
 KUophOWmUsFumvkGZF42yjkHyGHrB5P0B4ZLnThx/b3Z6weMirRa8AF37B8FrAHjodcx
 5JPRwnXqLXa5EOFIiHFcbllPdSeNeh7BcYBKmPQ3fXMp+FGUoaVtfswemRk4+UXlyjGr
 EY/ZFa63hOJ95N7yIFfD4N8nzjmlefViU/A+EYtgQoZrSqbnizv9GRGIMVxu3k8B3ZjB
 4mFQ==
X-Gm-Message-State: AFq9FYKBmq+21xIvH/qT5qxUzWLD00DN0/TcZA2b4bk87hRWkB9XTTeJ
 bKeUgn7I0bOf7teuFqck9IwEOK0xHAfgj6/U5WYR0RdymDKFYxIt775hyLybsINPoeBbeqSnG5T
 0Vqy2l2bHsvcvuVhIyub6SBIoCfjGFzRcdiw9J+hrwT5+PK4Ua/MdzpuvDntz17P0OiJVo+3OEf
 09e7C7rEyApA==
X-Gm-Gg: AYBFou0c/DoEZQbWDvfFbpjI/TQAeB4atxx52+RG+kWT1VDJroT+VYaOUmudSGqPXg+
 OXA+dUuLYB2ScPLb7AjzvKHo1wKhSThNdCFba/Hg+uuCJBl5dbsBQLvDC2EZe8XVBVd1DWnfFob
 A01Lsq16HqqfyJDgOhVpKo1INx9eqBytXojgbQxH9CAZdS7er/hoZ3ZY6HpT02FG2PWu4pFuymz
 /+Jza/Mai1vehe2jSdSl2IoJbJmwy3fd2nsCL/MTlSYvsDw+wvYHbSIEzQWLQ0VrmOon9JFWzhA
 2paxiTTOgOMIjQ9XtvbL92E1R7PwdK7n1VCCljBShJzdtY5ixbRLzzdr/mqlWciCnD2bO2zMlQN
 zkMw/maiuwHXrCaXOiKyVul5ZObuu0Enfb1vMRlQ12coy6g==
X-Received: by 2002:a05:690c:6d82:b0:8b0:8c43:72d6 with SMTP id
 00721157ae682-8b08c4375fbmr43305377b3.13.1791905094623; 
 Tue, 13 Oct 2026 08:24:54 -0700 (PDT)
X-Received: by 2002:a05:690c:6d82:b0:8b0:8c43:72d6 with SMTP id
 00721157ae682-8b08c4375fbmr43305227b3.13.1791905094163; 
 Tue, 13 Oct 2026 08:24:54 -0700 (PDT)
Received: from [127.0.1.1] ([97.87.60.46]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b07ee8603fsm47203617b3.4.2026.10.13.08.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:24:53 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Tue, 13 Oct 2026 10:21:58 -0500
Subject: [PATCH v2 1/2] util/coroutine: trim sysctl's max_map_count newline
 before parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-set-default-pool-size-v2-1-f4fd6f2a3303@canonical.com>
References: <20261013-set-default-pool-size-v2-0-f4fd6f2a3303@canonical.com>
In-Reply-To: <20261013-set-default-pool-size-v2-0-f4fd6f2a3303@canonical.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hector Cao <hector.cao@canonical.com>, 
 Wesley Hershberger <wesley.hershberger@canonical.com>, 
 alex.ramirez@canonical.com, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=jxt5gtVdNSGI7nu008sOCCv976EKACNaD50FtGvaaDQ=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBqzk1Cuig33SdU1WMxyySQtgf2l7X99I9L0xEsM
 PXetQH5SR6JAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCas5NQgAKCRD5KICs4jod
 uaU9C/9rJoXAnYU5crnzh1Tog5g01/imQhftbVqTqUiY2hBDXKPb9wduVzcWXSCAEIe6V+d8leu
 0JZYLiCPgWQyydsnxjJM0sc/YLWQS0HMl27Uvvnt4mce3uOx3PatVh3JX/wjK0gVi6r/erIQQEy
 qMrd1VbeR7FG+rl288RIfFYWHFWUK6xDV+TUBFE8C5PVobAdMvStbSI03sJCIl03O9M1WNU4yQc
 wggq8p4ru7SSzpx+yHeTOA4oRSoJXiKRLOREcvKdMPG0I4PfQNUPQr/39VlL6J+kzer4wlNOJu+
 YBfTDupidgTHBN1iGNRKvgqCaX871Jx4UnQAnnT6ZE97+VyBvgsKRAnqofoYXgSSWj7XqmR8xnh
 gqmDDXPbK18SqFSs0MTPfWPI03CdaH/muHnF5tDfZKKOZX6q+JPirdlvb6Xlm6OHTb+u2EXU3TJ
 03DYuEgMT13kos2Hk0urHQAFU2exCMGUcdwfB0gv6v5GC7d9f9RJ67e76dvMo7AStO/ns=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hector Cao <hector.cao@canonical.com>

Strip trailing whitespace from max_map_count before passing it to
qemu_strtoi(), allowing the strict full-string parse to succeed.
Otherwise, qemu_strtoi() fails to parse the string and returns -22,
making the global cache pool cap size set to UINT_MAX.

Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
Signed-off-by: Hector Cao <hector.cao@canonical.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/qemu-coroutine.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index d17135f585a..5af61995437 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -374,8 +374,12 @@ static unsigned int get_global_pool_hard_max_size(void)
      * VMAs.
      */
     if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
-                            NULL) &&
-        qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
+                            NULL)) {
+        /* contents has trailing newline, remove it before conversion */
+        g_strchomp(contents);
+        if (qemu_strtoi(contents, NULL, 10, &max_map_count) != 0) {
+            return UINT_MAX;
+        }
         /*
          * This is an upper bound that avoids exceeding max_map_count. Leave a
          * fixed amount for non-coroutine users like library dependencies,

-- 
2.53.0


