Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E67AC44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJMo-0002mj-RT; Mon, 13 Jul 2026 12:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjJLw-000250-2O
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:17:56 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjJLt-000055-QQ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:17:55 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f36a122fdso12989f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783959472; x=1784564272; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QYQ6I8YjnDUt1gVcOj8gOZ1mMNMmK3qD7Twk5bpgblY=;
 b=VdFWJYMTp6+fLSZQmBZlMVZgYr6H702Wf9qZ1zg8SEbiLuaukQ261sCWsLAJS2N+DQ
 zufWqdFO1tmYQQuCdupZDKvm1SQRsJqYd3aWroANI9zSBCmvCTpUYqFZmYhK7rwxxume
 3zRbTKUEMtm687LwSO2m14IucsG4qadDTyAetNILHmM808HjeosUJ9MIf461yxXiEJLH
 u3zsQWh1shSqtToM0mSagXnwSK0JPzpoRmA1+pLoJbdquzMSmHdj9n7hSIKklOcA5h6/
 6CO8suzXt2425F+ez3ku7YBbdlSylEo9WUlLpZZaOZYEp/rn2CnU6CXet0oySYr6v9rB
 Af+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783959472; x=1784564272;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QYQ6I8YjnDUt1gVcOj8gOZ1mMNMmK3qD7Twk5bpgblY=;
 b=sKOnfBoVhqdA31nowcG1tTJfmQXL3QM/IGCf7eWEcs7xm9V+XxZHeBiynOhBa+svDI
 xnpZVh5UdIj2FD+QwQgwQogSVfbrbSFbIk26T6tHDjbLT8lR/PqxAhHi+5h18tv3iCed
 PQ0QD/6yzuxWNBlbLilCr4j910b2jUaFGYv0B8mprXYhI2FQRfh2z4JPAtb9jMwBEv38
 iCcFvxCtExbrW2hSB/72SOifSwYeD8/sGCFXZSD4JkZ5oWVNZCgRptYBHklNEJRB6ej2
 OaI2xJCP/i8GPFrKZ2bE3vbcWyiHSJ2iDToycrbFXhF8SOsvmkKiWI4R5NcEOZ0bZIIH
 k2xg==
X-Gm-Message-State: AOJu0Yx0xUnncmb7cuM4ihlbYe7hapryvHr/8KmBeJ+3K0kj0+twwH/6
 OmLyd/6N5gKhKParbekzi2jJZb5L0wk1NKxeaT0oL62qPtF5aVWLY+4ywfp3qeLoeZE=
X-Gm-Gg: AfdE7clV0R9Hc5q+Pks8Zh2J257qjkJW3KqotpDPqlIZouGWxZsa/mbaFAnogMKz/ok
 y/kNEv5XOSvkpwV+u+B5heX8u7s60Oy8jAjEybfaV5UJNt+J4K4eOKuCQ7CeZITckZMpcgDsn+8
 YZ6IMmE7dEpLTMs3/umQX6kruPxONE5C2frPPSMbIb6Cj/MQl+WgJyQBX+088/TOZSdoBONvPQn
 Gv7Fcx2ag5JrdAEVNGjsiJHg77dVI2d76RGNgu4o3KtsqBbzWLTzON2OMqmoxYYyouSblz78NzF
 7VY2bX+q6DxM5YcQWaTdQMQBGItcgV2NvFOCFS1OhNjbIUJoCh+JrwnMs39KLOT3aMntdPSyZiE
 4rBVHSYO6qBZAW2xwhFh0ideW5J6Xaa3CFFKvVGl3x1gTYAfL/pTHYbZ07Lt4sK+wpePCEg0B5W
 HooHgTEF/MwOXA
X-Received: by 2002:a05:600c:8518:b0:493:d100:b487 with SMTP id
 5b1f17b1804b1-493f8780997mr96302295e9.0.1783959472032; 
 Mon, 13 Jul 2026 09:17:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950871cbd6sm7774515e9.3.2026.07.13.09.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:17:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2F0405F9CD;
 Mon, 13 Jul 2026 17:17:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 7/7] scripts/gitdm: migrate from contrib
Date: Mon, 13 Jul 2026 17:17:45 +0100
Message-ID: <20260713161745.53889-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713161745.53889-1-alex.bennee@linaro.org>
References: <20260713161745.53889-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

As discussed previously it was suggested scripts might be a better
location for this meta data.

Link: https://lore.kernel.org/all/CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com/
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260709080040.4157324-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index e25df9493c5..0be68396e9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4611,7 +4611,7 @@ GIT Data Mining Config
 M: Alex Bennée <alex.bennee@linaro.org>
 S: Odd Fixes
 F: gitdm.config
-F: contrib/gitdm/*
+F: scripts/gitdm/*
 
 Incompatible changes
 L: devel@lists.libvirt.org
diff --git a/gitdm.config b/gitdm.config
index 8764bf2f9ff..b9627de5eac 100644
--- a/gitdm.config
+++ b/gitdm.config
@@ -17,13 +17,13 @@
 # the information in the existing .mailmap but in a slightly different
 # form.
 #
-EmailAliases contrib/gitdm/aliases
+EmailAliases scripts/gitdm/aliases
 
 #
 # EmailMap does the main work of mapping addresses onto
 # employers.
 #
-EmailMap contrib/gitdm/domain-map
+EmailMap scripts/gitdm/domain-map
 
 #
 # Use GroupMap to map a file full of addresses to the
@@ -31,31 +31,31 @@ EmailMap contrib/gitdm/domain-map
 # identifiable corporate emails. Please keep this list sorted.
 #
 
-GroupMap contrib/gitdm/group-map-alibaba Alibaba
-GroupMap contrib/gitdm/group-map-amd AMD
-GroupMap contrib/gitdm/group-map-cadence Cadence Design Systems
-GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
-GroupMap contrib/gitdm/group-map-facebook Facebook
-GroupMap contrib/gitdm/group-map-huawei Huawei
-GroupMap contrib/gitdm/group-map-ibm IBM
-GroupMap contrib/gitdm/group-map-janustech Janus Technologies
-GroupMap contrib/gitdm/group-map-microsoft Microsoft
-GroupMap contrib/gitdm/group-map-netflix Netflix
-GroupMap contrib/gitdm/group-map-redhat Red Hat
-GroupMap contrib/gitdm/group-map-wavecomp Wave Computing
+GroupMap scripts/gitdm/group-map-alibaba Alibaba
+GroupMap scripts/gitdm/group-map-amd AMD
+GroupMap scripts/gitdm/group-map-cadence Cadence Design Systems
+GroupMap scripts/gitdm/group-map-codeweavers CodeWeavers
+GroupMap scripts/gitdm/group-map-facebook Facebook
+GroupMap scripts/gitdm/group-map-huawei Huawei
+GroupMap scripts/gitdm/group-map-ibm IBM
+GroupMap scripts/gitdm/group-map-janustech Janus Technologies
+GroupMap scripts/gitdm/group-map-microsoft Microsoft
+GroupMap scripts/gitdm/group-map-netflix Netflix
+GroupMap scripts/gitdm/group-map-redhat Red Hat
+GroupMap scripts/gitdm/group-map-wavecomp Wave Computing
 
 # Also group together our prolific individual contributors
 # and those working under academic or intern auspices
-GroupMap contrib/gitdm/group-map-individuals (None)
-GroupMap contrib/gitdm/group-map-academics Academics (various)
-GroupMap contrib/gitdm/group-map-interns GSoC/Outreachy Interns
+GroupMap scripts/gitdm/group-map-individuals (None)
+GroupMap scripts/gitdm/group-map-academics Academics (various)
+GroupMap scripts/gitdm/group-map-interns GSoC/Outreachy Interns
 
 # Group together robots and other auto-reporters
-GroupMap contrib/gitdm/group-map-robots Robots (various)
+GroupMap scripts/gitdm/group-map-robots Robots (various)
 
 #
 #
 # Use FileTypeMap to map a file types to file names using regular
 # regular expressions.
 #
-FileTypeMap contrib/gitdm/filetypes.txt
+FileTypeMap scripts/gitdm/filetypes.txt
diff --git a/contrib/gitdm/aliases b/scripts/gitdm/aliases
similarity index 100%
rename from contrib/gitdm/aliases
rename to scripts/gitdm/aliases
diff --git a/contrib/gitdm/domain-map b/scripts/gitdm/domain-map
similarity index 100%
rename from contrib/gitdm/domain-map
rename to scripts/gitdm/domain-map
diff --git a/contrib/gitdm/filetypes.txt b/scripts/gitdm/filetypes.txt
similarity index 100%
rename from contrib/gitdm/filetypes.txt
rename to scripts/gitdm/filetypes.txt
diff --git a/contrib/gitdm/group-map-academics b/scripts/gitdm/group-map-academics
similarity index 100%
rename from contrib/gitdm/group-map-academics
rename to scripts/gitdm/group-map-academics
diff --git a/contrib/gitdm/group-map-alibaba b/scripts/gitdm/group-map-alibaba
similarity index 100%
rename from contrib/gitdm/group-map-alibaba
rename to scripts/gitdm/group-map-alibaba
diff --git a/contrib/gitdm/group-map-amd b/scripts/gitdm/group-map-amd
similarity index 100%
rename from contrib/gitdm/group-map-amd
rename to scripts/gitdm/group-map-amd
diff --git a/contrib/gitdm/group-map-cadence b/scripts/gitdm/group-map-cadence
similarity index 100%
rename from contrib/gitdm/group-map-cadence
rename to scripts/gitdm/group-map-cadence
diff --git a/contrib/gitdm/group-map-codeweavers b/scripts/gitdm/group-map-codeweavers
similarity index 100%
rename from contrib/gitdm/group-map-codeweavers
rename to scripts/gitdm/group-map-codeweavers
diff --git a/contrib/gitdm/group-map-facebook b/scripts/gitdm/group-map-facebook
similarity index 100%
rename from contrib/gitdm/group-map-facebook
rename to scripts/gitdm/group-map-facebook
diff --git a/contrib/gitdm/group-map-huawei b/scripts/gitdm/group-map-huawei
similarity index 100%
rename from contrib/gitdm/group-map-huawei
rename to scripts/gitdm/group-map-huawei
diff --git a/contrib/gitdm/group-map-ibm b/scripts/gitdm/group-map-ibm
similarity index 100%
rename from contrib/gitdm/group-map-ibm
rename to scripts/gitdm/group-map-ibm
diff --git a/contrib/gitdm/group-map-individuals b/scripts/gitdm/group-map-individuals
similarity index 100%
rename from contrib/gitdm/group-map-individuals
rename to scripts/gitdm/group-map-individuals
diff --git a/contrib/gitdm/group-map-interns b/scripts/gitdm/group-map-interns
similarity index 100%
rename from contrib/gitdm/group-map-interns
rename to scripts/gitdm/group-map-interns
diff --git a/contrib/gitdm/group-map-janustech b/scripts/gitdm/group-map-janustech
similarity index 100%
rename from contrib/gitdm/group-map-janustech
rename to scripts/gitdm/group-map-janustech
diff --git a/contrib/gitdm/group-map-microsoft b/scripts/gitdm/group-map-microsoft
similarity index 100%
rename from contrib/gitdm/group-map-microsoft
rename to scripts/gitdm/group-map-microsoft
diff --git a/contrib/gitdm/group-map-netflix b/scripts/gitdm/group-map-netflix
similarity index 100%
rename from contrib/gitdm/group-map-netflix
rename to scripts/gitdm/group-map-netflix
diff --git a/contrib/gitdm/group-map-redhat b/scripts/gitdm/group-map-redhat
similarity index 100%
rename from contrib/gitdm/group-map-redhat
rename to scripts/gitdm/group-map-redhat
diff --git a/contrib/gitdm/group-map-robots b/scripts/gitdm/group-map-robots
similarity index 100%
rename from contrib/gitdm/group-map-robots
rename to scripts/gitdm/group-map-robots
diff --git a/contrib/gitdm/group-map-wavecomp b/scripts/gitdm/group-map-wavecomp
similarity index 100%
rename from contrib/gitdm/group-map-wavecomp
rename to scripts/gitdm/group-map-wavecomp
-- 
2.47.3


