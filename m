Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9604FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKD9K-0001Lz-OW; Tue, 05 May 2026 06:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKD9A-0001KW-8J
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:37:00 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKD95-0007wr-7N
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:36:59 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso44875935e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 03:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777977413; x=1778582213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFhuzS792h9v8bPHJJvfZPyb+8Yblrmc05ngEGzq5yg=;
 b=mipAcsL/2bEkSdx4M35IsctZbQE1BuhYc76rhVA7OC4Fvdkzf+sIhku0pwgiYvJlU8
 NIuBk1L7iLli/VflSsVZY4sFR1+cQDbzgAVP0MMpWbEoCker69WuTMy+RLlBNI2hacgV
 sqb6aoa4F8WE/gD3BzlAw4lBPvnbcmK2oqFry0sCbtj63zpPCPZEHK3tdm51VG14zi9/
 CPq6yd1ERqLgzOPPi0xx8S02TFQOru7GrKH1P1SZGJr7+ltRKEYj8K36mdNFYd4sXmV9
 4OVw1zn1Ce12Kk1KfPzWysw56TCXomYHdwTG/7SGfxsaTuWHjvMxSVr24qhEGzcLxoTC
 3+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777977413; x=1778582213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MFhuzS792h9v8bPHJJvfZPyb+8Yblrmc05ngEGzq5yg=;
 b=m/S9MzDLqpYKl+mD5fsknsgHj8ansHUixVKXXqZj51uR5dNv+NrUWgncvp/ZcIhFU0
 qJbztH5S6lPN0DBaCZCIEYX+Unv2wiX/c+U31KcBceIsTz5IF10EHwiWOisBbs9Fa1Jm
 9lGaDCwJDi6KytlGqw+GxlzZwy3RZcp/rietRlJPRKzJO3q97U7oXe6/L5vhZskaIob4
 E22bJhQQwz4JovVxTKvQui3lrVWF0vis9l71j9/NGWNRisEk/zLvbjZebbm/Bg0OPvS3
 aqx/va+22KVcralwrTI6otdD8JPc4BDjmCC7QyitKm9BZ8yStXgK1lI5OaF3q2EWvRmA
 RNjg==
X-Gm-Message-State: AOJu0YxvmEp5/2eL66AJ4AnO4fkIKTDafEtv5EdcM9xqPQ1gyzM1DrmN
 +VK0jqcpUwhL040OOAUCFChhDUSArfYVaTJF/rxT4ldEm3ZO0UrpO2na3Ye5rR03Jsg=
X-Gm-Gg: AeBDieusXz2NC1LLbF/Gt89Js+ERusE5alJ9AD0OqJjQ0gipXzfL6a4jE3RzJJbvt2l
 B00gG+U4MIs6syJDaHbVdcN88h5wh42Zs9egOLsblDv3ziyfNvzbEKDa4zszdc2Kw/rjLRwFFiv
 MZzBiusDFLbOmIE47/KQQJAaIepCLPB1fiqfEEsKbrLkWbciGN4+cqPGGjde9f44/+9ppRxzid1
 rBAmKaAg97WpgGfWcP4mscRlj8qOhXC/SgJjP0JbRGMj7uIZxSJ6Qe8GFg+DJ9ePMxJaKoLpe1y
 HFt7G278avDlJilmmRftIIDu7bEy5BXZk8AIZ0mGZUlB+GpBPpRjls5KwKFKkL54gGdqq5GFjpw
 uY3/aJhc1EW4nCGFQV1HHVSO3g9oGRrymDpVPOx89NK5AVdCe6hkDdJ2Y2Pm0AnUyMp2Sqv6DA+
 9wcRCRHVWgKhGM3QloL0PTY0K6fs1XviJB39jGB3ZgOAuD
X-Received: by 2002:a05:6000:26c4:b0:43c:f247:4792 with SMTP id
 ffacd0b85a97d-44bb32fd802mr23280032f8f.12.1777977412976; 
 Tue, 05 May 2026 03:36:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-450524833e1sm3631705f8f.2.2026.05.05.03.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 03:36:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B76955F913;
 Tue, 05 May 2026 11:36:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] configure: report unsigned qemu binaries for check-tcg
Date: Tue,  5 May 2026 11:36:45 +0100
Message-ID: <20260505103649.68361-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505103649.68361-1-alex.bennee@linaro.org>
References: <20260505103649.68361-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

On MacOS the initial binaries are created with the unsigned suffix.
The user is expected to sign them before they can access the
hypervisor APIs. However for TCG testing we can run the unsigned
binaries so lets make sure the make variable is correctly set so we
can run the TCG tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index eea90306728..c0090b60d1a 100755
--- a/configure
+++ b/configure
@@ -1800,7 +1800,11 @@ for target in $target_list; do
       ;;
     *-softmmu)
       test -f "$source_path/tests/tcg/$arch/Makefile.softmmu-target" || continue
-      qemu="qemu-system-$arch"
+      if test "$host_os" == "darwin"; then
+          qemu="qemu-system-$arch-unsigned"
+      else
+          qemu="qemu-system-$arch"
+      fi
       ;;
     *-linux-user|*-bsd-user)
       qemu="qemu-$arch"
-- 
2.47.3


