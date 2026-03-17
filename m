Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C88F3382D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 09:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2R28-0001oe-JF; Tue, 17 Mar 2026 05:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2R24-0001nR-E0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 05:48:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2R22-00043n-PP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 05:48:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48628ce9ab5so5427405e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773740889; x=1774345689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0srI6lC7NklTkYTvsgaVvhomkxbDk+VOa5Qai6ZEJZU=;
 b=Swdt8K7DRzpccdX5KLNIdfs4uUFAztdTahfw6FRgGorUpkBk6T13He8a9b+WfrXDKJ
 G2Ti54SVueo518qFEEsWKi57txZSZ9YEbi/0CLpp8im1BexKJ1RoD8CJsYjoSZZwJib+
 yQtzKxa97nqSzq9LuJHo0wxAGmTOmEPX1clAF4rAg4D9oJOdACRjC+90qGkRVHC5G4nz
 rO8lAkhs+k/zbdEg4ucTqadi2XJ+zKkZ8aUphemdBdFPdACCxU1rKpskDnnSyfEdAxj7
 Qw09Qe91QgPh2aRU6CD+TmfhH5e69TZOwOT6F1MAgVh09KSomhuGAAif1Y8h013YUikM
 9//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773740889; x=1774345689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0srI6lC7NklTkYTvsgaVvhomkxbDk+VOa5Qai6ZEJZU=;
 b=mRWxgAA2Iu45O/w8psFXq1vnsgTxVDjN/0ws/yZ1JWEXCG/h3miyk9O6OcJ2kZEIcb
 fhMmPJ07Th0etPH6N8R9DV3JHKKdLpb2tEdB1as8sbm5GVNbDtB34dlkE1aBnEqqBDDw
 AaMX2wOYpBsEb+qDccDCCsUhbTZzyD0fRFr+s+XNJZ/HTmEPj8izj3AGQYYEQyXIwvRF
 K9KpgVK42+qaB0rI+bTjEXH7uqycwWKcerNIbUEhcsgyTlzfZbqVRpkTAW6OfV16ZO5C
 6UDqu0zqoLgrP5MBiaKYJlFrSst2QUVyI//5/kI2lUkeW4//WRL6vHvYz/wLHf+20UOb
 /jOw==
X-Gm-Message-State: AOJu0Yx7s/pK7JqRAYOl7PJTFgODOELfUomvxlETQLGzB7E6cc8b1EtY
 xcjMA04iZ0XH9ReJkN1HOhkVWx8rU0oobL/BJD+w/gyCXYQwe6SpaPYvB5AABkXtgWeiKPB/0cm
 LXRhv
X-Gm-Gg: ATEYQzwYNCWY3MPPKAbLZQFd4MriSpE74ycD8FQnde0UPHCSAwZOz7tPS2SuS+N4ZYv
 eZInUGea4TbmHIQlSlGOrmtb9zytLuM3FLGgKEQqwml1GdjT/OCfVbSwEURQOw1DgDi+iAhY9nq
 /igm2bLnlt/Nxm6HGSbvlP+7M4sV/ZHSRc+pkgQVvCavf8zhqzOcek+TyREf9fEgTkTrKxAFVsa
 kVIgsgqvisG+PVbUOjdUNaMomzw7w9+vry1tcQAq1cED3fm+yrEk69eDS06jkFSP5vbS/EDLnK+
 BlFyKv8yBopMp6hftOYtiLvyePiOOE3ydGti4AQfXCBhRdw+ZxrADSsK51WkPcQZicX0GdTEQWd
 3BzAVMX9+I0383nT67Z4G9WPYAkrOZ3YPwRch0EfJjxZDH5SDgDoejDJfmzM5SUVvuEC1FRBTdF
 GNPMD8A0G0x/M+TrPADGSBeOzTniG6MEGpHKHEH5/MaZpOgOKXSO5DhcoQxqYun8WYfpDJXMIRm
 sfxeTGQhYqfTE00A9UYdhqHK5UQ6zs=
X-Received: by 2002:a05:600c:34d3:b0:486:d76c:fa51 with SMTP id
 5b1f17b1804b1-486d76cff4amr9178085e9.27.1773740889346; 
 Tue, 17 Mar 2026 02:48:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea98070sm54329075e9.6.2026.03.17.02.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 02:48:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH 2/3] scripts/qemu-guest-agent/fsfreeze-hook: Avoid use of
 PIPESTATUS
Date: Tue, 17 Mar 2026 09:48:05 +0000
Message-ID: <20260317094806.1944053-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317094806.1944053-1-peter.maydell@linaro.org>
References: <20260317094806.1944053-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

PIPESTATUS is a bash-specific construct, and this script is supposed
to be POSIX shell. We only use it in one place, to capture the exit
status of a command whose output we are piping to 'logger'.

Replace the PIPESTATUS usage with the trick described in
https://unix.stackexchange.com/questions/14270/get-exit-status-of-process-thats-piped-to-another/70675#70675
which uses a command-group to capture the status of the
first process in the pipeline.

Cc: qemu-stable@nongnu.org
Fixes: 85978dfb6b1c133 ("qemu-ga: Optimize freeze-hook script logic of logging error")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3339
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/qemu-guest-agent/fsfreeze-hook | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-agent/fsfreeze-hook
index 6e2d7588af..21eb5c5145 100755
--- a/scripts/qemu-guest-agent/fsfreeze-hook
+++ b/scripts/qemu-guest-agent/fsfreeze-hook
@@ -47,8 +47,23 @@ for file in "$FSFREEZE_D"/* ; do
         "$file" "$@" >>"$LOGFILE" 2>&1
         STATUS=$?
     else
-        "$file" "$@" 2>&1 | logger -t qemu-ga-freeze-hook
-        STATUS=${PIPESTATUS[0]}
+        # We want to pipe the output of $file through 'logger' and also
+        # capture its exit status. Since we are a POSIX script we can't
+        # use PIPESTATUS, so instead this is a trick borrowed from
+        # https://unix.stackexchange.com/questions/14270/get-exit-status-of-process-thats-piped-to-another/70675#70675
+        # which uses command-groups and redirection to get the exit status.
+        # This is equivalent to
+        #   "$file" "$@" 2>&1 | logger -t qemu-ga-freeze-hook
+        # plus setting the exit status of the pipe to the exit
+        # status of the first command rather than the last one.
+        { { { {
+                "$file" "$@" 2>&1 3>&- 4>&-
+                echo $? >&3
+            } | logger -t qemu-ga-freeze-hook >&4
+            } 3>&1
+          } | { read -r xs ; exit "$xs"; }
+        } 4>&1
+        STATUS=$?
     fi
 
     if [ "$STATUS" -ne 0 ]; then
-- 
2.43.0


