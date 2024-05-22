Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039BFC25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 03:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9cuL-0003Su-3M; Tue, 21 May 2024 23:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9cuJ-0003Rd-5w
 for qemu-devel@nongnu.org; Tue, 21 May 2024 23:44:51 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9cuH-0004AG-Dj
 for qemu-devel@nongnu.org; Tue, 21 May 2024 23:44:50 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c99257e0cbso2559931b6e.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 20:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716349488; x=1716954288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANXC48sQiPcmwS+xOFwDre7pgTyWtySeXqXMB92Q6A0=;
 b=KXpx+4jgwPxFEJQAB6kaBqdAkphKeWZ6wDTgybIPtWiBukj5AyZd27DGCrMXEYH0QG
 DhPjV09mU/NG48nvU52e1s5ZDhVUJnigYO0N99vXTDe1O9ES98RSPuJjII4m0UrN2EX4
 ND3PaCHjVj8kz7cNKtbsQKSmHEO6rm3JZue6jze2a9t+NXjYIGUvD5XZIbdMjukaw+FP
 Gd1aq6I3JGems8c9pqXNZm3X46PKQbv0kNdjcf9QQwD88J3bD7aMX0HIYaAbOeqmqppT
 S+fdp65ffCEtcq71KP7XLwkNrV5BWmmKMQB/zaIrXh/rf6RI+boITlAM5/s64r16Q4Hw
 SoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716349488; x=1716954288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANXC48sQiPcmwS+xOFwDre7pgTyWtySeXqXMB92Q6A0=;
 b=CL7pd8d/JrgzTgpZr84Qz0D1KM7Zg7vnASgoDpRcifEQ8UyBuogRT2qBzUyfwObdG0
 CojdLt75sirmrgzQMU8ialOJGkZG+ojIMG0Rat5AL+dIzKWle6Qy5TBySGvKPIiNR4Zw
 CxU0eAAIF/64mBLbVf2m1a0bD970fKmZVQeE/mdf+JwPr5szySO31qHlRy+AS6D6+/nB
 RD4u/XKRJHzSrU0nefzPsHP/aOEImd3vimAiMQpv52ycXkuvfHawGDgiEvLLj+JyMvCS
 9LRwUqCy/5yW/eEq4qeFTfY1rtyBu4njC4Dp+8MSQBqvxan8nk7MCP33yY1C7UxEj7FF
 NltA==
X-Gm-Message-State: AOJu0Yxy2in6sYQodtmb4IPE9KMackuBODId1jxotePRRyLp5SOBATOt
 jG8ehu92SRQ1gyZbs13YWlwsCLgWRo4osIEwGCoJ3G8Sdcus9yDQNcyzwteMu7td0QJEDdQ/+6q
 6
X-Google-Smtp-Source: AGHT+IGSNEX5G9vutdoBSvbTK/y7n9ZUzqejze1hX9h7o386DVoyKuW+PeFr9RJS6gsmXfH14em54A==
X-Received: by 2002:a05:6808:9a9:b0:3c9:94f2:5cae with SMTP id
 5614622812f47-3cdb32e44b0mr997628b6e.17.1716349488011; 
 Tue, 21 May 2024 20:44:48 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2bafsm21416617b3a.162.2024.05.21.20.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 20:44:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 5/8] risugen: Be explicit about print destinations
Date: Tue, 21 May 2024 20:44:39 -0700
Message-Id: <20240522034442.140293-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522034442.140293-1-richard.henderson@linaro.org>
References: <20240522034442.140293-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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


