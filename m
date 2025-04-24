Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7DAC369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 18:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u81Od-0003cV-V6; Thu, 24 Apr 2025 14:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u81Ob-0003bA-MP
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 14:34:01 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u81Oa-0007mJ-1V
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 14:34:01 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so15410425ad.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745519638; x=1746124438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IhBZqYIRQ2byJdn1RM8IMtiTT7hHnb++hz5MqumQew4=;
 b=LZ8jlvAyd2+RIuztZhs55DZTs9uaJewSTKleN7PHUaMF/xZqdo32wEI7mYOIAFgl8D
 zg/+URQVBxeN6LkG8Gx+Ly/L0bvZKduiDDibH/3KnZZoWYsfhPywUvhc+/Af223qi23S
 +YJGwIZIQWDPS3sM+I1Wbqriw+0gZUyUHBUTbqkvVkqwzksBVw+0MpnwyprARQMrYqBw
 fhFeMQWTPEGVyFW+0V6K9J4Qh8+BCvCn12rDeUzCo+VANeh7s6XRnatFSA8Xb1vcDb9c
 DLIG2hNOs/anWbooz8dlbQBQm25XaPlQMym7x4e6bDlPYNqzNuOr511wSFGsexWz89nu
 so5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745519638; x=1746124438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IhBZqYIRQ2byJdn1RM8IMtiTT7hHnb++hz5MqumQew4=;
 b=NHh2pAtdRtSGAqhesy3tlAz6Qw5MOYf6WQO0REDB6RU6IxVitFXb8aF4jpV5gIeBaw
 LDk4tu7ndfgR8vUm4mhfywrTmDJPYJi3sdNWeTATprrwEEAPdpsqCYZdPeC+yQoCAEAM
 OVbTSXBjEGWbweZvTWCDBabJDL+aQO/n0UkZDzMlIneAYCeJ/SXo5k3UV1BHoDKcun4E
 Ns2VuD4r5RnLATyLagtey1ONo5MntNa6JyI0xqBjKO8ENViVZSav46IqdsZ4mu4pgzVO
 KzHHd3RWTsFoy1mKPcCFJcBKqRImxqVgh6h5fo2g7odZ4omFDLkH6/DOzc0S9yp/Ok7V
 MmKQ==
X-Gm-Message-State: AOJu0YyaKaamxpTvl3MF3gjtke6YYoLvuzyu/ik1hXXdv4071+QcRN08
 l3T/WvcdO8Oaz0Ns8kmH8d0hlZukMXX/7Os+5P/5lZIFfA+BBn1RJ66byEjv9Ar/XW4SkTOLz9B
 2zQk=
X-Gm-Gg: ASbGnctGWVJT51iBmrH3//dwXmRQlC37YHnqiXEgCqjc5tY3Wx/gf4tnYPMd4Lvu06T
 6SE+yxG4KJCJGagOyD4nICm0i0XYpOZpB0Ri6aN5HfcPL2vAHbjehR19PmBDVVOF4h+W0G43vJ7
 cKKtne2FkdqdJ9kS5IgLWWjxvdcjo1715umrI1qAPWYY2VjREqWm0YzjrEXNbe3xg4Cbd33hI5f
 L3qzwfrt2JJ67Oad/0D/r6x6QWyRwzF7BlFFHHO2327L+FhrJ9UpRso3coaVr2Lo136ieFvrPd4
 tLjmalK5Cox+lksmxJIJLVIUgRxA4NizwNvNHKbe
X-Google-Smtp-Source: AGHT+IEQRMkbAPUj+dnOzKh+WLxC/Zzw1YzmWUBJFd3eDaVjqJnOCV/Bsu8vdW6DYcxQwXePKZfyoQ==
X-Received: by 2002:a17:903:98f:b0:224:10a2:cae1 with SMTP id
 d9443c01a7336-22dbd466012mr6900765ad.37.1745519638633; 
 Thu, 24 Apr 2025 11:33:58 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa80fbaasm1544157a12.49.2025.04.24.11.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 11:33:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 3/3] qapi: make all generated files common
Date: Thu, 24 Apr 2025 11:33:50 -0700
Message-Id: <20250424183350.1798746-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/meson.build b/qapi/meson.build
index ba9380d3f03..58ca8caee12 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -144,7 +144,7 @@ foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
   if output.endswith('.trace-events')
     qapi_trace_events += qapi_files[i]
   endif
-  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: qapi_files[i])
+  system_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: qapi_files[i])
   i = i + 1
 endforeach
 
-- 
2.39.5


