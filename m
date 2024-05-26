Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C03C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJft-00081o-KK; Sun, 26 May 2024 15:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfq-0007zf-LC
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:54 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfn-0006U4-Ba
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:54 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2bf5bba7a7cso1980085a91.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752203; x=1717357003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANXC48sQiPcmwS+xOFwDre7pgTyWtySeXqXMB92Q6A0=;
 b=DX+lzi7ZX36GtfGItUJLJpzfoO/m+acfHmvtXo9FKP0249AmJIDaLu3xlktDgFNrUm
 qmtzH9T4xhgaQ5qnjGJ679N+aixs6fnT0Kal5shEYiCO/LfyaRPB8i7MULrtr2PlhmvI
 1dIu83DDmLm28IWw7h2btSQ5KR7mC1gHbh89pamKGYgcYqf7waCYWuxEHn7+xBJa7dOn
 ILNfChM5l3bB9FMLSbf4WavT48xhsFSAfH+OHzlaJ3Jwe9E6Q7hO300H0N6D9N3tfpPJ
 XshfL1lTy5ASAMPg506LaIW0tUjOht7N7fT+yqnoKt703nB+atNX06jGJsbB0emfJl59
 h40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752203; x=1717357003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANXC48sQiPcmwS+xOFwDre7pgTyWtySeXqXMB92Q6A0=;
 b=Om+aLsGfcCnLR1bCc2aZaFypPVihl2SXXruQkyexreK+EoosPwAugjO6ZhqaXeDzJ+
 +dg7JLX2rUgqHhxx2x4em++/9H5uuvomDsNO+AyANVCCztcEKLce9saw2jdPbUjxoLSv
 jKPdQzkQ8N+3osPkUHMvnYTsQvVjbi38JMAo3znp85FtjYt+JQLlJdM1X2XVbRKc965S
 Vi3h9kK7ZzdX6G5qxwAsyQIP9wZwHi+/CugxpvOABLqiF9fU1qYZlRe1DXpUKsVyuN2i
 POL+Qu7v2bSfUO5cpGAvygrnz8ezZjOrj6AO3f7oUbleaJRjlRcnSMS6Fm4w3rM6pg1k
 zV6Q==
X-Gm-Message-State: AOJu0YyEBCGNikXRmMnr8m7he/k+d14VeyRy31iykYQhCh0ZclvYXfQA
 hg1g2erfBxqXHxukx/1czYasxXU5s1UUDI/F6+lsLqMafEJCf40fYFGz63USk3iZiH9y7sXu6ba
 g
X-Google-Smtp-Source: AGHT+IGC/b356/JkBCFy+x3cCSdVOJ4kKHjhU0OW0YSpAzn29hx1piQnfY3aitSHOqzliw/0vaSDOg==
X-Received: by 2002:a17:90b:8cb:b0:2bd:e68f:34b1 with SMTP id
 98e67ed59e1d1-2bf5ee170fcmr7023716a91.31.1716752203198; 
 Sun, 26 May 2024 12:36:43 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f6155b6sm4943761a91.29.2024.05.26.12.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:36:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 05/13] risugen: Be explicit about print destinations
Date: Sun, 26 May 2024 12:36:29 -0700
Message-Id: <20240526193637.459064-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526193637.459064-1-richard.henderson@linaro.org>
References: <20240526193637.459064-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Printing directly to STDOUT and STDERR will allow the
print destination to be selected elsewhere.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risugen_common.pm | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/risugen_common.pm b/risugen_common.pm
index 71ee996..5207c0e 100644
--- a/risugen_common.pm
+++ b/risugen_common.pm
@@ -76,7 +76,7 @@ sub progress_start($$)
     ($proglen, $progmax) = @_;
     $proglen -= 2; # allow for [] chars
     $| = 1;        # disable buffering so we can see the meter...
-    print "[" . " " x $proglen . "]\r";
+    print STDOUT "[" . " " x $proglen . "]\r";
     $lastprog = 0;
 }
 
@@ -87,13 +87,13 @@ sub progress_update($)
     my $barlen = int($proglen * $done / $progmax);
     if ($barlen != $lastprog) {
         $lastprog = $barlen;
-        print "[" . "-" x $barlen . " " x ($proglen - $barlen) . "]\r";
+        print STDOUT "[" . "-" x $barlen . " " x ($proglen - $barlen) . "]\r";
     }
 }
 
 sub progress_end()
 {
-    print "[" . "-" x $proglen . "]\n";
+    print STDOUT "[" . "-" x $proglen . "]\n";
     $| = 0;
 }
 
@@ -124,7 +124,7 @@ sub eval_with_fields($$$$$) {
     $evalstr .= "}";
     my $v = eval $evalstr;
     if ($@) {
-        print "Syntax error detected evaluating $insnname $blockname string:\n$block\n$@";
+        print STDERR "Syntax error detected evaluating $insnname $blockname string:\n$block\n$@";
         exit(1);
     }
     return $v;
@@ -163,20 +163,20 @@ sub dump_insn_details($$)
 {
     # Dump the instruction details for one insn
     my ($insn, $rec) = @_;
-    print "insn $insn: ";
+    print STDOUT "insn $insn: ";
     my $insnwidth = $rec->{width};
     my $fixedbits = $rec->{fixedbits};
     my $fixedbitmask = $rec->{fixedbitmask};
     my $constraint = $rec->{blocks}{"constraints"};
-    print sprintf(" insnwidth %d fixedbits %08x mask %08x ", $insnwidth, $fixedbits, $fixedbitmask);
+    print STDOUT sprintf(" insnwidth %d fixedbits %08x mask %08x ", $insnwidth, $fixedbits, $fixedbitmask);
     if (defined $constraint) {
-        print "constraint $constraint ";
+        print STDOUT "constraint $constraint ";
     }
     for my $tuple (@{ $rec->{fields} }) {
         my ($var, $pos, $mask) = @$tuple;
-        print "($var, $pos, " . sprintf("%08x", $mask) . ") ";
+        print STDOUT "($var, $pos, " . sprintf("%08x", $mask) . ") ";
     }
-    print "\n";
+    print STDOUT "\n";
 }
 
 1;
-- 
2.34.1


