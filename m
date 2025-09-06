Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FF1CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 21:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uv032-0003hd-Ag; Sat, 06 Sep 2025 17:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv02z-0003gx-BQ; Sat, 06 Sep 2025 17:02:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv02q-0005tj-IW; Sat, 06 Sep 2025 17:02:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 31E95150F82;
 Sun, 07 Sep 2025 00:00:55 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E73C327868D;
 Sun,  7 Sep 2025 00:00:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.20 23/34] scripts/kernel-doc: Avoid new Perl precedence
 warning
Date: Sun,  7 Sep 2025 00:00:43 +0300
Message-ID: <20250906210056.127031-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.20-20250906235950@cover.tls.msk.ru>
References: <qemu-stable-7.2.20-20250906235950@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

Newer versions of Perl (5.41.x and up) emit a warning for code in
kernel-doc:
 Possible precedence problem between ! and pattern match (m//) at /scripts/kernel-doc line 1597.

This is because the code does:
            if (!$param =~ /\w\.\.\.$/) {

In Perl, the !  operator has higher precedence than the =~
pattern-match binding, so the effect of this condition is to first
logically-negate the string $param into a true-or-false value and
then try to pattern match it against the regex, which in this case
will always fail.  This is almost certainly not what the author
intended.

In the new Python version of kernel-doc in the Linux kernel,
the equivalent code is written:

            if KernRe(r'\w\.\.\.$').search(param):
                # For named variable parameters of the form `x...`,
                # remove the dots
                param = param[:-3]
            else:
                # Handles unnamed variable parameters
                param = "..."

which is a more sensible way of writing the behaviour you would
get if you put in brackets to make the regex match first and
then negate the result.

Take this as the intended behaviour, and update the Perl to match.

For QEMU, this produces no change in output, presumably because we
never used the "unnamed variable parameters" syntax.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-id: 20250819115648.2125709-1-peter.maydell@linaro.org
(cherry picked from commit 5ffd387e9e0f787744fadaad35e1bf92224b0642)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 240923d509..133d6d1e08 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1594,13 +1594,12 @@ sub push_parameter($$$$$) {
 
 	if ($type eq "" && $param =~ /\.\.\.$/)
 	{
-	    if (!$param =~ /\w\.\.\.$/) {
-	      # handles unnamed variable parameters
-	      $param = "...";
-	    }
-	    elsif ($param =~ /\w\.\.\.$/) {
+	    if ($param =~ /\w\.\.\.$/) {
 	      # for named variable parameters of the form `x...`, remove the dots
 	      $param =~ s/\.\.\.$//;
+	    } else {
+	      # handles unnamed variable parameters
+	      $param = "...";
 	    }
 	    if (!defined $parameterdescs{$param} || $parameterdescs{$param} eq "") {
 		$parameterdescs{$param} = "variable arguments";
-- 
2.47.3


