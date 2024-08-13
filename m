Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0362C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy3i-0005EO-6S; Tue, 13 Aug 2024 16:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3c-0004zN-2I
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:23:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3N-0006Be-5a
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:23:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4281ca54fd3so44492315e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723580615; x=1724185415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1AVh2j6pk/5XaCd8FbE/7mpmYiPG8pggbKweEGs0KY8=;
 b=swYFf/2BZxSSNajIQqL04N5uSZn50Dyk1MS2o4kLoWDMT654RGTbVmJEV3WBaZExLp
 AgFBB+E5tcLSAs8oqOIMNI0xpX9a4Wm0bXOWStaJSgjwo8mzA8x6wS+0rOO+vaXIiuxm
 jqQaFejdK+I5lyrHtiiKVPLnUpq35D9Y0aUUqxY6t8E7Sx+GwNGpY7E2D41ELrqWAZWC
 dknDBtSgn0wXBcN2g/z75vbqj2/Ct4vESxy/zYO+siHaB8zRkQPYpiWu67jDvBE5FiG/
 SI6wZCmFGqn0I05ILZ1mlAbUijVccIOwCOZ/U9LAx2qCLmwR0zsPBGhRed5XJXdmzuxf
 IYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723580615; x=1724185415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1AVh2j6pk/5XaCd8FbE/7mpmYiPG8pggbKweEGs0KY8=;
 b=EzzNMulmTlK3msD6iF9DKFyyeI5V9L/yMeJ9v5KByJp4nfcihtHfwRJsnh/kl88JGe
 2/HDKBGsT8goDnxfwAoB4YZKNEJ1ffNmyF4C/No/S4JOx3v8p4mdingCVM1O/6qWQP6b
 /0w3lQpNZWygEMOMqZlpG10q5X8X3emVaYgpzWuNf1Bn71NsgNGhuwH+iFA2qjSjQ0hu
 pneL0xTq+OWPBdTxpNHKGTptMx1sAc7kQRasPuxtSXwMor27YJZ/fAYKDllxVEs31qw0
 3Xl0vUiZKIHLVrSddh0FLPYbNIZBGXboO71vO9X58uaAsxUV4ETPun3w/jwqrDbClBDO
 o3Kg==
X-Gm-Message-State: AOJu0Ywft02QD+mBUPMWe8oUI+i6jnePwqkmyswUGMq49WWljebLBVDi
 NksjXHHEg+hM+TF4ULrhinMH5VL0KggBQFLiMshy8NzJbNVtsRgNOjoU4pQI/A8=
X-Google-Smtp-Source: AGHT+IGdwxx3Yarp7KGAlSqIsgRmbEoqUx0ZN2t2rvjV2uSlSTWCBlXOqUAML9ogR29JYA305V8rYA==
X-Received: by 2002:a5d:64c9:0:b0:367:9107:9e11 with SMTP id
 ffacd0b85a97d-37177830523mr605930f8f.62.1723580615118; 
 Tue, 13 Aug 2024 13:23:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429d0642979sm98513095e9.20.2024.08.13.13.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:23:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E95A25F9CF;
 Tue, 13 Aug 2024 21:23:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Weiwei Li <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 06/21] scripts/checkpatch: more checks on files imported
 from Linux
Date: Tue, 13 Aug 2024 21:23:14 +0100
Message-Id: <20240813202329.1237572-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Stefano Garzarella <sgarzare@redhat.com>

If a file imported from Linux is touched, emit a warning and suggest
using scripts/update-linux-headers.sh.

Also check that updating imported files from Linux are not mixed with
other changes, in which case emit an error.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20240718072050.9503-1-sgarzare@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240807114059.2339021-7-alex.bennee@linaro.org>
---
 scripts/checkpatch.pl | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ff373a7083..65b6f46f90 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1374,6 +1374,9 @@ sub process {
 	my $in_header_lines = $file ? 0 : 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
 	my $reported_maintainer_file = 0;
+	my $reported_mixing_imported_file = 0;
+	my $in_imported_file = 0;
+	my $in_no_imported_file = 0;
 	my $non_utf8_charset = 0;
 
 	our @report = ();
@@ -1673,6 +1676,27 @@ sub process {
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
+# Check that updating imported files from Linux are not mixed with other changes
+		if ($realfile =~ /^(linux-headers|include\/standard-headers)\//) {
+			if (!$in_imported_file) {
+				WARN("added, moved or deleted file(s) " .
+				     "imported from Linux, are you using " .
+				     "scripts/update-linux-headers.sh?\n" .
+				     $herecurr);
+			}
+			$in_imported_file = 1;
+		} else {
+			$in_no_imported_file = 1;
+		}
+
+		if (!$reported_mixing_imported_file &&
+		    $in_imported_file && $in_no_imported_file) {
+			ERROR("headers imported from Linux should be self-" .
+			      "contained in a patch with no other changes\n" .
+			      $herecurr);
+			$reported_mixing_imported_file = 1;
+		}
+
 # ignore files that are being periodically imported from Linux
 		next if ($realfile =~ /^(linux-headers|include\/standard-headers)\//);
 
-- 
2.39.2


