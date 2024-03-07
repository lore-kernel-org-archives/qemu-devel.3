Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9451DC54E58
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 18:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riID3-0002SH-FI; Thu, 07 Mar 2024 13:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riID1-0002RU-R6
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:11:11 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riICy-0004RI-PT
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:11:10 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33e2774bdc7so926148f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 10:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709835066; x=1710439866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FP1Q7CJ3ufIn91uB7tqy2T7aeez+sSRO3vzBm+o+KRQ=;
 b=PF3E3R6+j6VLY6Jl+W7pE1u4PqpvsI1BONH18gTe9NfNs1/DvDKobIA2E2i5kydQUI
 +NJAQcg8iNtvnAzaeoEijg5EFQiqebmEf/w1gr1ESOIrn4bb8K2rjn36eNqFFDUnBHYS
 owE9WMUwe7C6Evz6IE6oaCajU96qwD2IFpJmoS1VkcB/Cu0TlPhCSw2dQynpwkVZNnpg
 8otjnl/o693NAE+fJK4lq1Z/Mh9igEvHRvQ14iIpsSSW/L2Fxzli3Wf9f14vxXgARN+w
 rqJ8cCnnIJQEK8fj1CIOUMZKM0X09xZi4rUPn30+4FKqocue6Wu0oAoB3V/mIeD4Lud9
 j7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709835066; x=1710439866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FP1Q7CJ3ufIn91uB7tqy2T7aeez+sSRO3vzBm+o+KRQ=;
 b=ciTps+SD5xo876v5CDJoXG4LJX1WwDpHYRanBfKGbIe6NkoFNGe3WAszzrmMlGvHz9
 XIEKlwB5pJ6g5EUc7vkp6rZI6S8JxgSPu8p3Gznd1a9GRq38N4H5xd/0lTyD4Ik1WTJ6
 v1kR2W42moVCIpMgO4UiNQGF1cgfC2HLIukiBgGhB77qVjZoc+R39lTSJTw0q5yXfsAg
 3lyu4WNqUwKFyiMzXtgphun+9MuCA+chtI8SMSp8OQSG49c77li5BSHbR6HImVuqh47w
 v18+IMG0J9UyEj5PYLA3W0uMnNEufmTfVnVavpp514IhrgPqGxobTJpEKMR0j5MaE1rF
 MHmw==
X-Gm-Message-State: AOJu0YwKe1svzlksAb2H6A1LGlgLlRhS00zr6N+WOrd/rPCUTIujdVpy
 uSS7AgiQ+HQZ6jAA9dDNjGq9xzQHEVMOrr3ZGW1A/dDly9K8vkLi5781m3v8bOg=
X-Google-Smtp-Source: AGHT+IH/OxZrTSOCBVuAysVaBer68U37JxerhjGQdG2hP3831z5YOBAhOhrIV5bd96KX/ZPFfkfPIQ==
X-Received: by 2002:adf:f584:0:b0:33e:726d:e963 with SMTP id
 f4-20020adff584000000b0033e726de963mr656930wro.17.1709835066451; 
 Thu, 07 Mar 2024 10:11:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v9-20020adfedc9000000b0033e712b1d9bsm713243wro.77.2024.03.07.10.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 10:11:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8CBEB5F8E1;
 Thu,  7 Mar 2024 18:11:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Xu <peterx@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 1/5] scripts/kernel-doc: teach kdoc about QLIST_ macros
Date: Thu,  7 Mar 2024 18:11:01 +0000
Message-Id: <20240307181105.4081793-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307181105.4081793-1-alex.bennee@linaro.org>
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

The kernel-doc script does some pre-processing on structure
definitions before parsing for names. Teach it about QLIST and replace
with simplified structures representing the base type.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/kernel-doc | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 240923d509a..26c47562e79 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1226,7 +1226,14 @@ sub dump_struct($$) {
 	# replace DECLARE_KFIFO_PTR
 	$members =~ s/DECLARE_KFIFO_PTR\s*\(([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
 
-	my $declaration = $members;
+        # QEMU Specific Macros
+
+        # replace QLIST_ENTRY with base type and variable name
+        $members =~ s/QLIST_ENTRY\(([^)]+)\)\s+([^;]+)/$1 \*$2/gos;
+        # replace QLIST_HEAD, optionally capturing an anonymous struct marker, and capture type and variable name
+        $members =~ s/QLIST_HEAD\(\s*,\s*([^)]+)\)\s+([^;]+)/struct { $1 *lh_first; } $2/gos;
+
+        my $declaration = $members;
 
 	# Split nested struct/union elements as newer ones
 	while ($members =~ m/(struct|union)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;/) {
-- 
2.39.2


