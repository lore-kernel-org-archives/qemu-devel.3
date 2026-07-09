Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E21C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whjgo-0007mH-Je; Thu, 09 Jul 2026 04:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgk-0007ju-WC
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgi-0008AH-1P
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:54 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-476a130c138so1754698f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783584049; x=1784188849; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pX69CymNUDmWLcrFVn/SwBlnniyZUxzm0QIsJlVhrmg=;
 b=QewrRJXu/lhEadWwltnAdGW8q6SRWRiP1PpolH4xOEX+f5lbsuwYrWI5KMRC00BN1l
 jN7yuPUjh11NEtPKGUqP3DQ5Pqg+1X5hKiAnjNhPQF6M1/SEoXQbEFlzLqxG2EUbvPNO
 dKUJ4RE0zYyOyqVyvPF8r1YXdPykojTY+FaM9IK6X9Ha68R/MJDmQ7p+HfbsMc6iUxde
 /u6kdPoMy77ql9zhhKKxBpvKWN+i9EBSw4bU62AVUqjc52Fjg0/l+wpPhkcqN8yz2n4d
 dfOesVjnET1KmOnKxy4yhFG5qI1CtmkatdiKk+JdlLDWoEh9Jw+T0g5OdNjxPgljWHpv
 SmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783584049; x=1784188849;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pX69CymNUDmWLcrFVn/SwBlnniyZUxzm0QIsJlVhrmg=;
 b=d1ArDFmpSjnqc4VdqoQrGa1cbfBbNknITvzUeUaPuFpKUOGpf2/pQu4gCi8BOmtkdT
 jC+DOO6cqh5g2ExvriHkhe8zNP0hJQkKw/+Wuv4/FHPKcDwXR5XmASmBrVbdqTWk/WQW
 oR27yxx6tAEHJixNC3oofvFI4BqXD2PjDWiFXNtjkUDcHipQBkkHd8sveByrS0hS9WJH
 WvNJah5WTRXdlPGSj2qQT/83lzJ0socO1fHlwE6d48hlqQnSjvIspbdgMy9ZHC5I7i7p
 bYNmrySd+VQnQL4z9Bjs5rQGGmSMb3/e0ytjZxlmvJubgrxuyNlX9CbWSJtX8dPoqdEp
 b35Q==
X-Gm-Message-State: AOJu0YyBOuo9zbsrWE21ucrqJiyQfYTcaGFZw503ACdxXB+eq/ZyF7uN
 bzDeQxl/rl6GvB6kskY9iHlsbsih+gz4keSu52M+qC6Gbo3IibJ46iVa+h5oI0EtHRs=
X-Gm-Gg: AfdE7cmarH25iHEZapwxbf1vZm+PjbWfaIV3dev29vvjbGuBg3i/5QxpomElQh3b2fZ
 ddWgUC40Ex8yRNRQNmao16doFe222MLeBAXZHy9V867D7X0XszvxRbruyyODqTt5GMYxI1OtPgv
 8QEpwdcq/mwD3d4fwzRbkAeWemU7FVsfGvOFgZ4bLnhpfHESwQxghXgdIxzqI612MxwoI+v9Rj3
 2c1imWjMzJJ38bAdUtZNSngn7p/zHNSLfDtj2NrtlG0LrT2tqy/WqVbIPAqSR1tKRuOHv50KL5e
 KxNWWMxQYxtjey/gDS6iYpYw5YKTtmTcYveE53FpBVt8lchiPdj7Gu9MO2KR+sVrKKbyJldA1tP
 knwDk9J9SGFngc+wxeh5bor1C59p6pp9lj+P5lFzOrnVlWj3MUrHzwAkcliIS3km9umRr4lXfz3
 xRwXEQDJMLwSllUTN+zfAXHTM=
X-Received: by 2002:a5d:5f89:0:b0:470:2fb1:3db5 with SMTP id
 ffacd0b85a97d-47df075c099mr6305389f8f.30.1783584048700; 
 Thu, 09 Jul 2026 01:00:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d8cdsm52849745f8f.1.2026.07.09.01.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 01:00:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0B4D4601A3;
 Thu, 09 Jul 2026 09:00:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 9/9] scripts/gitdm: migrate from contrib
Date: Thu,  9 Jul 2026 09:00:39 +0100
Message-ID: <20260709080040.4157324-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709080040.4157324-1-alex.bennee@linaro.org>
References: <20260709080040.4157324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gitdm.config                                  | 40 +++++++++----------
 {contrib => scripts}/gitdm/aliases            |  0
 {contrib => scripts}/gitdm/domain-map         |  0
 {contrib => scripts}/gitdm/filetypes.txt      |  0
 .../gitdm/group-map-academics                 |  0
 {contrib => scripts}/gitdm/group-map-alibaba  |  0
 {contrib => scripts}/gitdm/group-map-amd      |  0
 {contrib => scripts}/gitdm/group-map-cadence  |  0
 .../gitdm/group-map-codeweavers               |  0
 {contrib => scripts}/gitdm/group-map-facebook |  0
 {contrib => scripts}/gitdm/group-map-huawei   |  0
 {contrib => scripts}/gitdm/group-map-ibm      |  0
 .../gitdm/group-map-individuals               |  0
 {contrib => scripts}/gitdm/group-map-interns  |  0
 .../gitdm/group-map-janustech                 |  0
 .../gitdm/group-map-microsoft                 |  0
 {contrib => scripts}/gitdm/group-map-netflix  |  0
 {contrib => scripts}/gitdm/group-map-redhat   |  0
 {contrib => scripts}/gitdm/group-map-robots   |  0
 {contrib => scripts}/gitdm/group-map-sifive   |  0
 {contrib => scripts}/gitdm/group-map-wavecomp |  0
 21 files changed, 20 insertions(+), 20 deletions(-)
 rename {contrib => scripts}/gitdm/aliases (100%)
 rename {contrib => scripts}/gitdm/domain-map (100%)
 rename {contrib => scripts}/gitdm/filetypes.txt (100%)
 rename {contrib => scripts}/gitdm/group-map-academics (100%)
 rename {contrib => scripts}/gitdm/group-map-alibaba (100%)
 rename {contrib => scripts}/gitdm/group-map-amd (100%)
 rename {contrib => scripts}/gitdm/group-map-cadence (100%)
 rename {contrib => scripts}/gitdm/group-map-codeweavers (100%)
 rename {contrib => scripts}/gitdm/group-map-facebook (100%)
 rename {contrib => scripts}/gitdm/group-map-huawei (100%)
 rename {contrib => scripts}/gitdm/group-map-ibm (100%)
 rename {contrib => scripts}/gitdm/group-map-individuals (100%)
 rename {contrib => scripts}/gitdm/group-map-interns (100%)
 rename {contrib => scripts}/gitdm/group-map-janustech (100%)
 rename {contrib => scripts}/gitdm/group-map-microsoft (100%)
 rename {contrib => scripts}/gitdm/group-map-netflix (100%)
 rename {contrib => scripts}/gitdm/group-map-redhat (100%)
 rename {contrib => scripts}/gitdm/group-map-robots (100%)
 rename {contrib => scripts}/gitdm/group-map-sifive (100%)
 rename {contrib => scripts}/gitdm/group-map-wavecomp (100%)

diff --git a/gitdm.config b/gitdm.config
index 8206c0af8a9..665000ad2bc 100644
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
@@ -31,32 +31,32 @@ EmailMap contrib/gitdm/domain-map
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
-GroupMap contrib/gitdm/group-map-sifive SiFive
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
+GroupMap scripts/gitdm/group-map-sifive SiFive
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
diff --git a/contrib/gitdm/group-map-sifive b/scripts/gitdm/group-map-sifive
similarity index 100%
rename from contrib/gitdm/group-map-sifive
rename to scripts/gitdm/group-map-sifive
diff --git a/contrib/gitdm/group-map-wavecomp b/scripts/gitdm/group-map-wavecomp
similarity index 100%
rename from contrib/gitdm/group-map-wavecomp
rename to scripts/gitdm/group-map-wavecomp
-- 
2.47.3


