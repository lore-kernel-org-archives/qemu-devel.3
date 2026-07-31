Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A67C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 13:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpnTu-0001rg-GG; Fri, 31 Jul 2026 09:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpnTt-0001rT-60
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 09:40:57 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpnTr-0003ol-0Y
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 09:40:56 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c15dd4b9132so154219766b.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785505250; x=1786110050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z9s32wvCavotKoTGfHvCMSBystm/xHKrYlx37iykbLE=;
 b=kJ8kt+LjMokCh2HNQr4JBGl8SRLrnFZgboTuN4rD3gkJECkg0i33MJjuCF/INaGh/8
 Gi2hbUveD+iW0J8HFzaPJ+zmzrO0J+kTyBcbavgXTQhsvYBCVky0vlvRUR6TIOZq9/N8
 7N53eIjYE6zmusbwjjuzYjW8tJsd2bU1Hm/1DBe3vsS38ndrPSpgDvfx7ESPVcgOzmqg
 wl7TOnUUSuykoS5JKVrf/s21WMyCtNQbB7Ol2WdWE0YKglye6x7M0ccDAAX9D79XBP01
 ic9tl6O6XOqvhAAKhTW//PqRXsvDl8CghZxn+LPSVSlBWJV663/38VPFAnCTkPp9gdgc
 O/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785505250; x=1786110050;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z9s32wvCavotKoTGfHvCMSBystm/xHKrYlx37iykbLE=;
 b=U8m31HigWImYeSZ22SsXjnRms9ALmMbBZmX42hba+N0e05nTAXIjLtsoQMBLY1XGdB
 I2LURVxUimWx/rXtuoe4UYbMgyZ4YcJmoxaLHlIArZDGoTp0k72OLXYoXOWmk+Sd3PIs
 i4fZC+GD3thF5m21DBOaeGgYdUM10Mj0jVbZqoLu+HUyGQexhcW8GF/XVM3UVbEzjfDw
 RFfpLtLFhq23aCIUpD71eQibnH4E//98Jy0z46H3k4iquYwLA8gq+9+MnoLz0bOmkhDB
 CUwAsld88R9+A3X5tp1WT9WZVXh1DOJKPStLS/ZUjcaioveB2FFPcZdseap08iCOoBJG
 6IoA==
X-Gm-Message-State: AOJu0Yygjw1IWMiAGpkuouNOd+FqDrkEUcyx/5MFtO9gq6mPb/RQ0jA5
 GVGdSYMCd2hRBtgbJ1n6RZ9j8MjA/pOphUy9qxKKZnNlLjouYLunzVRmepvJs2LzMcpHjhppPf1
 myVdZ
X-Gm-Gg: AR+sD13LpnWZHp9L0gvTnUxY0knLvs/y2tbw+IYhLDJoPvix3mV+X9qfYYWMymoThLg
 qipCW1d63ArRHRTTcHl/FpQQLvd/l2MYNw6SHa81prUrMxsnD4vu1WzO3VD38baiPhSVCP39OTJ
 vKXhZ0+hGB4yDrxrGJZKPCbk7gSsSUDUIGkFoTJ1rpNeVoiISEEOt30Y7kn8XuuAQ7V5VdIGB4m
 j4xaRV2bEFH/eFigFIxmSRwxI5t97l9Bz7XRnRbX63oC1ScVZJdDyQi1Nrw7PSpNBHhN/JBv50N
 qNws2xK+1k4/7BN9i2cdVB5JWeVtKum//rETA2UnTHrP1qAebT6Fwcz5PFgg6dNGvRZiLqurPR0
 I8yRZcTvESPMz9UOBgB6rzAeFYuVVnIS5Go3uAkF4ssXMkpbGvaPwHKFCUVPidamARcUEuE3+55
 itrGd2a7N/6Get7oxhUTp8UKYl52ZbrUVmEPmdyN5dtaHaAnao/Dl5BZ1P
X-Received: by 2002:a17:907:961a:b0:c1c:332b:7611 with SMTP id
 a640c23a62f3a-c1fd27539eemr122463466b.65.1785505249605; 
 Fri, 31 Jul 2026 06:40:49 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:1758:fc6:a5f8:a15f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd3c9e3e6sm152309466b.22.2026.07.31.06.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 06:40:49 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Chao Liu <chao.liu@processmission.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Philippe Mathieu-Daude" <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] checkpatch: warn about hunks which only add blank lines
Date: Fri, 31 Jul 2026 15:40:46 +0200
Message-ID: <20260731134046.1015479-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=den@openvz.org; helo=mail-ej1-x633.google.com
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

Patches sometimes carry a hunk whose entire content is one or two
added blank lines. It changes nothing, it makes the diff longer and
it survives review because nobody looks twice at a blank line. The
blank line itself is perfectly fine, the gratuitous hunk is not.

Tally the added blank lines and the other changes of every hunk in
the pre-scan loop which already walks the raw patch, and record the
hunks which only add blanks. Such a hunk is then reported at the
first blank line it adds, so the warning carries the usual file and
line context.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Chao Liu <chao.liu@processmission.com>
CC: "Daniel P. Berrange" <berrange@redhat.com>
CC: "Philippe Mathieu-Daude" <philmd@oss.qualcomm.com>
CC: Thomas Huth <thuth@redhat.com>
---
Note: this patch is sent on behalf of the yesterday finding inside IDE
      pull request. This should be found with a checkpatch.

 scripts/checkpatch.pl | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 03f35e7501..dfa9878006 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1567,6 +1567,10 @@ sub process {
 	my $first_line = 0;
 	my $p1_prefix = '';
 
+	my %blank_only_hunk;
+	my $hunk_first_blank = 0;
+	my $hunk_has_change = 0;
+
 	my $prev_values = 'E';
 
 	# suppression flags
@@ -1583,6 +1587,10 @@ sub process {
 		$line = $rawline;
 
 		if ($rawline=~/^\@\@ -\d+(?:,\d+)? \+(\d+)(,(\d+))? \@\@/) {
+			$blank_only_hunk{$hunk_first_blank} = 1
+				if ($hunk_first_blank && !$hunk_has_change);
+			($hunk_first_blank, $hunk_has_change) = (0, 0);
+
 			$realline=$1-1;
 			if (defined $2) {
 				$realcnt=$3+1;
@@ -1633,6 +1641,13 @@ sub process {
 		push(@lines, $line);
 
 		if ($realcnt > 1) {
+			if ($rawline =~ /^\+\s*$/) {
+				$hunk_first_blank = $linenr
+					if (!$hunk_first_blank);
+			} elsif ($rawline =~ /^[-+]/) {
+				$hunk_has_change = 1;
+			}
+
 			$realcnt-- if ($line =~ /^(?:\+| |$)/);
 		} else {
 			$realcnt = 0;
@@ -1641,6 +1656,8 @@ sub process {
 		#print "==>$rawline\n";
 		#print "-->$line\n";
 	}
+	$blank_only_hunk{$hunk_first_blank} = 1
+		if ($hunk_first_blank && !$hunk_has_change);
 
 	$prefix = '';
 
@@ -1780,6 +1797,10 @@ sub process {
 
 		$cnt_lines++ if ($realcnt != 0);
 
+		if ($blank_only_hunk{$linenr}) {
+			WARN("this hunk only adds blank lines\n" . $herecurr);
+		}
+
 # Only allow Python 3 interpreter
 		if ($realline == 1 &&
 			$line =~ /^\+#!\ *\/usr\/bin\/(?:env )?python$/) {

base-commit: e1705a25aff35635c360bbaba4c2731d019a422a
-- 
2.53.0


