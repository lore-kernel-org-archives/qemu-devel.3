Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CB5CCFA07
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJwl-0007gT-EV; Tue, 04 Nov 2025 11:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwI-0007ce-7d
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwB-0003yL-Rr
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762273874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWdMa1znnBSu2wgLltL31AcGV76n2oLZuhzJyyM3hwg=;
 b=Uf6VzoSyzOQHdXSutxFx1wxIKiWbKDenmx7w63Wssg1fdzceKC3KmhHaAzvQxnaxbM93Iq
 JHv9zz+hvFY/9bEORzNSVadyUrXFkJ4cRujrDzxCNE9xDzGuZ75J5H20yagLN6njy4G1kQ
 sTtHMGRoIQWqAGfHT8nhcaGfDRDlo1k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-u6uullqNMMWk8Q-kPUlf3g-1; Tue, 04 Nov 2025 11:31:08 -0500
X-MC-Unique: u6uullqNMMWk8Q-kPUlf3g-1
X-Mimecast-MFC-AGG-ID: u6uullqNMMWk8Q-kPUlf3g_1762273867
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b7067f229b8so458987766b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762273866; x=1762878666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWdMa1znnBSu2wgLltL31AcGV76n2oLZuhzJyyM3hwg=;
 b=FNp7K+330ER14FGh37Ghlur5g9tQebUGVcxH759yhSy2VrNTrRLUfajDltlVu48gjs
 +RZUhqCu9XIEb9oyRV9ND0eopRPOHUZuWIHphR81c1+ANWaeRcMo+2HpyhB2oBHO9l+u
 eUKoY1ctt2uxRAg6wrQNcgOr1+4GStxF68RD9rPVPbMP7PRW4Er5i8o+VEkBbxM0P7Ru
 3afO3PdIrnUg+fVqfW5eJLxWb2+txMVkTRwN5kK+PyfCMlDXyxFX6DMOg/yjVnbg8pgJ
 uepka0++b9jfmpbvyusaCRp8b+ODzYOoDgpp0QnrT36pXi1DowjEyowvM9LwZJynluzu
 JCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762273866; x=1762878666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWdMa1znnBSu2wgLltL31AcGV76n2oLZuhzJyyM3hwg=;
 b=NJgMC4rPbt6iVTpriSKgc0GxEqrEVVGYG1leluj+4lgt5Z3I4p9YhQbd0bh0g+QC5T
 sbEs6hiw0a7LgmPWBwLIKGIGVtRXOixubkNllQlDj+FtfnfIDXtT+JXfMVgOVdGaRUXI
 pBECYcL36nMyoH7wF7D0KB9bLtLMD302jvwqhFEM+Z+i2SmN2VDtN8bkeQtYh2fCwLXR
 sdmYt/ToQvSAH/8PwJFH8yB6lcchPjiFw0r+GrHGxXA91QKGNKot1tEM74pK7tKRB3ib
 6DvWM2xHL08/CdPwT2P9E7h6OsSk5gkLThiQYPo0ayyop0GbziIr4J65RTqQwGEEqvbT
 EMtw==
X-Gm-Message-State: AOJu0YwudlI11I2ZNc+bv5dgj8Hfok6Ucz/21QOfxexcJH8JHXMpK/U4
 ebp19mVXvgeWJfBr29DGHEHKOX3emiy/tkFMRKM4yj7/7ud3+Ru3U7VuQEZYNP+O9LrF6LfFLgb
 ATEKe3qF13hhem4/5T71EAy9vPEuzlazF6GJH+IbJ1ddBoKUwxS8d0blUVTP3Rb5jVU8zZ9RUcy
 CYLvtxXo+QCxJd6uXyzQdTALVrq1cfsqBaXgyT0trN
X-Gm-Gg: ASbGncsPa7LGNKm+8g8nRaVwGwBft4NgdTbHOYoT68/SeCQVLXuyx/hjy4YxH2KeQWk
 KP+zFRizU84K2pzBy2QZTfsUjfqiSYJAUFII4xTQRWHqonihCHR2dJkLzH9DT+syOWqtFaW3vMN
 DY7VkPOyWVS1QGFaI3LCGFwn8w2yANlclOTmcwFMmEuuxSfqM4rqX9eBnrBvq1fGJxcZ0yMWEuA
 gup84PsnHcXHihFBP/0BZu+rOhTHvitPm1JJ4rV8c6KpFMeqPugJAfU38EEPTs4HHbC0BpPRLQU
 rKESpuHVMyD+EKHRxXi0CWGxuI7QwLJoVuT2cbn7KGYNR9rJ+JGuGS3M9vr9qRthqGwuqcVUCR/
 JtIL9ptgkrATWCeWileO8DlwE6vu+jPZur/0VSt5XovmXNEfzhd4f5TqlLsuV/RpufdduSjXzvK
 sMv2rx
X-Received: by 2002:a17:907:724b:b0:b43:b740:b35d with SMTP id
 a640c23a62f3a-b70704b95afmr1857181266b.33.1762273866583; 
 Tue, 04 Nov 2025 08:31:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgiWTNigbEv10AEYJe4BdwZsngYwVhyNsSDi8INqz/6G8HofgC48SncRK/MLxpVvnsDASahg==
X-Received: by 2002:a17:907:724b:b0:b43:b740:b35d with SMTP id
 a640c23a62f3a-b70704b95afmr1857177866b.33.1762273866089; 
 Tue, 04 Nov 2025 08:31:06 -0800 (PST)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723d3a3d6dsm248826866b.15.2025.11.04.08.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:31:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 1/8] scripts/checkpatch.pl: remove bogus patch prefix warning
Date: Tue,  4 Nov 2025 17:30:55 +0100
Message-ID: <20251104163102.738889-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104163102.738889-1-pbonzini@redhat.com>
References: <20251104163102.738889-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Remove the 'patch prefix exists, appears to be a -p0 patch' warning
entirely as it is fundamentally flawed and can only produce false
positives.

Sometimes I create test files with names 'a' and 'b', and then get
surprised seeing this warning. It was not easy to understand where it
comes from.

How it works:
1. It extracts prefixes (a/, b/) from standard diff output
2. Checks if files/directories with these names exist in the project
   root
3. Warns if they exist, claiming it's a '-p0 patch' issue

This logic is wrong because:
- Standard diff/patch tools always use a/ and b/ prefixes by default
- The existence of files named 'a' or 'b' in the working directory is
  completely unrelated to patch format
- The working directory state may not correspond to the patch content
  (different commits, branches, etc.)
- In QEMU project, there are no single-letter files/directories in root,
  so this check can only generate false positives

The correct way to detect -p0 patches would be to analyze the path
format within the patch itself (e.g., absolute paths or paths without
prefixes), not check filesystem state.

So, let's finally drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Link: https://lore.kernel.org/r/20251030201319.858480-1-vsementsov@yandex-team.ru
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d3d75f3f139..d0f4537f25e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1741,13 +1741,7 @@ sub process {
 			}
 		} elsif ($line =~ /^\+\+\+\s+(\S+)/) {
 			$realfile = $1;
-			$realfile =~ s@^([^/]*)/@@ if (!$file);
-
-			$p1_prefix = $1;
-			if (!$file && $tree && $p1_prefix ne '' &&
-			    -e "$root/$p1_prefix") {
-				WARN("patch prefix '$p1_prefix' exists, appears to be a -p0 patch\n");
-			}
+			$realfile =~ s@^[^/]*/@@  if (!$file);
 
 			if (defined $fileinfo && !$fileinfo->{isgit}) {
 				$fileinfo->{lineend} = $oldhere;
-- 
2.51.1


