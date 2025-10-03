Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A50CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huS-00055g-5P; Fri, 03 Oct 2025 11:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hty-0004qm-DP
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htU-0007fC-Pj
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/LhqoHvjnUA/YT7CnUYKXPqSYZoyGnlE1fxboV7/fw=;
 b=gu549MXY5zbwz06LOvHrEyCtlFXZxJAOI4M3rugTc9nT2rlg0GSHPxWEzDqFBkNwV8/eGY
 mPbE9KF+4TIbcZY07hr5wNmnus6RY074almRIYLlyKEKUMM7pA4pG9eEbenYcLs/G/6DTB
 rlSIO8gpQQqJTyWM1q+1AEXxfGPJhLI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-1gtKEBxUPpGqSlMyXKO_eQ-1; Fri, 03 Oct 2025 11:40:22 -0400
X-MC-Unique: 1gtKEBxUPpGqSlMyXKO_eQ-1
X-Mimecast-MFC-AGG-ID: 1gtKEBxUPpGqSlMyXKO_eQ_1759506022
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-78ea15d3583so48502386d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506022; x=1760110822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f/LhqoHvjnUA/YT7CnUYKXPqSYZoyGnlE1fxboV7/fw=;
 b=fGMHWFebJgx7Ky0b3QaFP4lB325VBOjkN+CFmKI/LBt/ezTv4oYF5Sx5u3Ag/cVMbO
 TzcmxTP4/eeZDL0Cqnjv/RpPQJeUcm8D+JdJDxR18StD8bNm7TQkX/pRU0OtFEvgl9HI
 FgRiVK6k4SzNbO+7+u/uZotX+NotYSlXSDRJw3IgYn7KCX+j5P4eJuAuSZopTn29ElRa
 f+UZOQEyii/BUR1mmzMfnXyCEKTGdOgA4JWIWGJKhxq7hz8Sa3NOarqSNBG2GZ0RxN/G
 cgMpb0xp5uVOCamproANRkI6G6ZmcngLnwvbuc3N2zziTvfV2y2JXYgNLUAJu6BqVNrW
 iWow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCaAdg4/w2DcmMtzTZm9tdpwdWLvTOpBY96mLbsu8JH97ihN3ZID4K0gzfpylUvU9dQUlk7pxmih1F@nongnu.org
X-Gm-Message-State: AOJu0YzcaW1yuVQ8Wce7AUJCwa8A1MOq0sjZ2JcHXizz4wX3SlJhjsOD
 fhA7GeLBFkYYBPplARGBNJVbzzb/1Xvc3SIEJ2Z245va8a21QMIa45UvD3hJL2F6aD1UeiwwSrF
 /XjFa67a8qYdh6tkMicgEIlL8aWFwdQ0eqaZB+lhq6AnY0/4xxn7DKA6O
X-Gm-Gg: ASbGncuKc8SLfD3/bkdvsdWlZ9pywM9Imh84dlWAadws5D2qR1FbMOoVDd+e6SN3vk6
 colDQAaqwnEksngm8pKZShXk5xVr3Ma1ykKKYyaoz2BAUGbheib2H8dK9J/7rqws+I7Xwpm6sIx
 T7hU7NXLNQEQ+6q842icCH+TGPARdf3DymQbUGRZMi+0bx64MAiTxqsBoQn9GMC9Brzp7kDQP8s
 poHZYNSVakZcBHgVhEvvDKhgQ5D8KopvdwtsZnEKvltAPokGBB0kGsOKIsyJvyiST2gkddCVfi3
 VE5l2ln453mE7Op/YgJc8lGctv3QIdyLe9oEZA==
X-Received: by 2002:a05:6214:20ee:b0:81f:f243:f222 with SMTP id
 6a1803df08f44-879dc7e191fmr41134886d6.22.1759506022194; 
 Fri, 03 Oct 2025 08:40:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoU8a+jP8Dffztn8kyB3/MIDBksVYPUTLDUFxUzcwacU3DbDo85VglwIMYKzwAAGyMJhZFyw==
X-Received: by 2002:a05:6214:20ee:b0:81f:f243:f222 with SMTP id
 6a1803df08f44-879dc7e191fmr41134336d6.22.1759506021625; 
 Fri, 03 Oct 2025 08:40:21 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 20/45] migration: Return -1 on memory allocation failure in
 ram.c
Date: Fri,  3 Oct 2025 11:39:23 -0400
Message-ID: <20251003153948.1304776-21-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Arun Menon <armenon@redhat.com>

The function colo_init_ram_cache() currently returns -errno if
qemu_anon_ram_alloc() fails. However, the subsequent cleanup loop that
calls qemu_anon_ram_free() could potentially alter the value of errno.
This would cause the function to return a value that does not accurately
represent the original allocation failure.

This commit changes the return value to -1 on memory allocation failure.
This ensures that the return value is consistent and is not affected by
any errno changes that may occur during the free process.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-20-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 6a0dcc04f4..163265a57f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3575,6 +3575,8 @@ static void colo_init_ram_state(void)
  * colo cache: this is for secondary VM, we cache the whole
  * memory of the secondary VM, it is need to hold the global lock
  * to call this helper.
+ *
+ * Returns zero to indicate success or -1 on error.
  */
 int colo_init_ram_cache(void)
 {
@@ -3594,7 +3596,7 @@ int colo_init_ram_cache(void)
                         block->colo_cache = NULL;
                     }
                 }
-                return -errno;
+                return -1;
             }
             if (!machine_dump_guest_core(current_machine)) {
                 qemu_madvise(block->colo_cache, block->used_length,
-- 
2.50.1


