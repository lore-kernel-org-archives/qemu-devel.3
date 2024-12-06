Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F3DE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJe1Z-0003EN-5p; Fri, 06 Dec 2024 14:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJe0t-0002rk-RL
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:29:21 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJe0p-0005Fh-QV
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:29:18 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216281bc30fso2734955ad.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733513352; x=1734118152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YhN5xzTKOMEr8P5uJC22JY6ORCTpZxAfyG3HnT0ezPQ=;
 b=OIr98HjuIHsRG6TIwssn1A8MkVhJJ57zupvowlb9/rpn83KGED9zhMFJ2VRG7DTtD0
 Nf0aa3UCoksLN5RwNSFcykmOtkHL3VwGvWSkRKM7TTLlFj/Pd6gOmu7dCLw3SkL6lDID
 UmJkRoBnEr8984zkeksZD1E+A6ttq2UW6aEhvbsbWKHFvYKNVhpK9znxpgrtB/8auNBo
 QnyvZ0cdpsSu3po07gQFcpF8enjxv3Ak/57j2AaodatwuydO8kodtINm70QVlJCu5Clo
 C5t++6PsnWITQ2OcqXhMx6Mni1x/rZBbsuL7cmO2SOTKmWqjyYEzO5D095IMOVTGOeWS
 8j8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733513352; x=1734118152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YhN5xzTKOMEr8P5uJC22JY6ORCTpZxAfyG3HnT0ezPQ=;
 b=rnumVOnYfEynRn02P5+KpvStRp2PeBY+WbHiWFBpS/xFT2clgnet9C0oDELMoSY1Kv
 /la4D6ElpsgQFbX95kknK/8xgw24+j7Uw1jta4jy+DOFA8MmAKtJRxpacE6ruVCTyjlx
 Yn4bA4id4tz0Jp6pWCNrmF7nKV3FLkbGmRHmDpCLUItIQIYRDZopsF0kJR6tDGNbFnIn
 w1/jeaF3A0llvvQN8l9KFWbyQbc3hfzazsVabPWEENtHxH8PVHXl0YFQwZQb5lNi/9ud
 TxezmYztxTWNSQ2oQiH+Azv+Y2MXDCiBbtgNICoevjDyQ8yODKFWkym4oXQ7Cb0dLEFt
 E8Fg==
X-Gm-Message-State: AOJu0YwzfQVNS1VCaR5QcMMv/wBIEbQXv5mDxv/w7okHPx5WG7aAejFo
 mCv1dGldrW8XWkyjxjFnpuu8lSzDkszfsU4zu8lMZXrNRn8NOgQbpI0PQejhX1SYoBO3w2xsLCH
 FKD0=
X-Gm-Gg: ASbGncvPo3GNbn11+NsndXPhgmYgvzenMKIPcBK3IWzMMedS8adLNOJkxqiIWIMUAn8
 rMq5rYZIRC8leyYBuqsYh7bNr1ln8cj4vMqOERc0hEOwvJdlPY+Q3CEXIEG/d6fiUqTeh68upfv
 nofhl6N5iBgLG9HHdpZqwH1nkXp093yTuNVYt3iXG9z7ulOWwFu7lCrvsbt/DV63UjH8OM5+/DF
 bnVthr5fx5zyQKS5O5vK0F0zLlaTkqfcDsuzTVD/jCkznjbtRRUrTks9uOSyCwGZUy2lhULf91B
 qN6PmK07
X-Google-Smtp-Source: AGHT+IFDwS8hBE+y3jFfJJEZi4eQD0EEfUJjjDqdu9yebhzu6uqlKD0UZCl7qr1eNOsm3r3/DSXGCA==
X-Received: by 2002:a17:902:c405:b0:215:a3fb:b4d6 with SMTP id
 d9443c01a7336-21614d54353mr61890765ad.8.1733513350722; 
 Fri, 06 Dec 2024 11:29:10 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8ef9fcdsm32110205ad.146.2024.12.06.11.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 11:29:10 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Eric Blake <eblake@redhat.com>, Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 manos.pitsidianakis@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 2/6] docs/devel: add git-publish for patch submitting
Date: Fri,  6 Dec 2024 11:28:56 -0800
Message-Id: <20241206192900.3893118-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206192900.3893118-1-pierrick.bouvier@linaro.org>
References: <20241206192900.3893118-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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
 docs/devel/submitting-a-patch.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 03b2ac298aa..69df7682c5e 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -235,6 +235,31 @@ to another list.) ``git send-email`` (`step-by-step setup guide
 works best for delivering the patch without mangling it, but
 attachments can be used as a last resort on a first-time submission.
 
+.. _use_git_publish:
+
+Use git-publish
+~~~~~~~~~~~~~~~
+
+If you already configured git send-email, you can simply use `git-publish
+<https://github.com/stefanha/git-publish>`__ to send series.
+
+::
+
+    $ git checkout master -b my-feature
+    $ # work on new commits, add your 'Signed-off-by' lines to each
+    $ git publish
+    $ ... more work, rebase on master, ...
+    $ git publish # will send a v2
+
+Each time you post a series, git-publish will create a local tag with the format
+``<branchname>-v<version>`` to record the patch series.
+
+When sending patch emails, 'git publish' will consult the output of
+'scripts/get_maintainers.pl' and automatically CC anyone listed as maintainers
+of the affected code. Generally you should accept the suggested CC list, but
+there may sometimes be scenarios where it is appropriate to cut it down (eg on
+certain large tree-wide cleanups), or augment it with other interested people.
+
 .. _if_you_cannot_send_patch_emails:
 
 If you cannot send patch emails
-- 
2.39.5


