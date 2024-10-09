Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC050CF0436
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 09:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syTHn-0001KF-9a; Wed, 09 Oct 2024 05:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHP-00015j-De
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHN-0008RF-8A
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728467208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DbehZlttuAvRWwiYZMnj8a7+ZQoZJPyuQGCQjndPlg=;
 b=icF2oSF1Ur4AdAvYxzgO0lHzbGV0YHNd61KA5SQCbM5VuWLC2wTxJ6amW4dQ91lmVvye4L
 ppQ0gek8ik8t6zfXpPW3Zghw+/Cu8KxZl9vfE0jIKwXhdYlhPBBrHfzL29bh+1ws/LkiSB
 jv/t+9Ed3wIl11QVLtp6BQMevoahbkY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-YgJGUBUlNyaAVy1HnfpcZQ-1; Wed, 09 Oct 2024 05:46:47 -0400
X-MC-Unique: YgJGUBUlNyaAVy1HnfpcZQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d389ffddfso692774f8f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 02:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728467205; x=1729072005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DbehZlttuAvRWwiYZMnj8a7+ZQoZJPyuQGCQjndPlg=;
 b=Vf6qsYM+NsVA194E0FzPIiSn2HDMsekUDyOqHdxDMetbsEupdHfOAycV3JxvJa8CpB
 UHoPPdLh9m88antsZQ2ce4VcXIevOhBAXkqheU7T4Ypu8KCK699430ZuVf3COFK/Agpy
 r3Q5Ds2QLUL7us0p6M7DSP9/igGozjPChZtm6fMUq4ozNzDKcn25ASt5N4TMPnzROrSw
 VTzoxUi64avYaUJx64amv2B2qcT9LIEn6FO6zPSt8vs7TDQMRyN8RkbWWmm+MbWKlsVo
 Jra/neZe8PyyVNWZ6G9suo1gn0fM1AgJjsa4dUr8JAIedsJlh+og+Zuo5VPFPa+0CKL8
 wUIg==
X-Gm-Message-State: AOJu0YzHCovy00AR3aj3TvQwXxiSFqutfFz5WJ5rtNMLwCCRvfe7FNLJ
 P+GwW7RTl6kzNU3OapAuR2pDNNzau3g20640CBRSUWYa7AdWfeaHmXlCejScOpDrb6cyEB+wvUv
 YVPEUOdCzZlzzIrEECGf0+dY290LzlTvcI8hR/2I0tXprX3I522AED8+PLs9icAlhs8trbpAvlZ
 iBWzlAD61iF5p0admAoeWJnLRY/qDGWrCeASeryxk=
X-Received: by 2002:a5d:630d:0:b0:37c:cce6:997d with SMTP id
 ffacd0b85a97d-37d3aa400fbmr1493690f8f.20.1728467205112; 
 Wed, 09 Oct 2024 02:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiaGs7zZ4QswdY/NWQl6/0ICv8iHm5ZrBpy80Nor7sd2QK+iPwNLTyBI5aHNHgF96SHyMtzQ==
X-Received: by 2002:a5d:630d:0:b0:37c:cce6:997d with SMTP id
 ffacd0b85a97d-37d3aa400fbmr1493666f8f.20.1728467204495; 
 Wed, 09 Oct 2024 02:46:44 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d3b229413sm1098112f8f.103.2024.10.09.02.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 02:46:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 06/14] meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag
Date: Wed,  9 Oct 2024 11:46:07 +0200
Message-ID: <20241009094616.1648511-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009094616.1648511-1-pbonzini@redhat.com>
References: <20241009094616.1648511-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Rust crates, introduced from the next commit onwards, can optionally use
the glib allocator API and need to know whether g_aligned_alloc etc are
available.

This commit adds a define in config_host_data that depends on glib
version >= 2.72.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/23f7b0cc9801d315f5d7835e30d775e133ec2fb9.1727961605.git.manos.pitsidianakis@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index b9a83dfc744..aea419a8317 100644
--- a/meson.build
+++ b/meson.build
@@ -948,7 +948,9 @@ have_xen_pci_passthrough = get_option('xen_pci_passthrough') \
 ################
 
 # When bumping glib minimum version, please check also whether to increase
-# the _WIN32_WINNT setting in osdep.h according to the value from glib
+# the _WIN32_WINNT setting in osdep.h according to the value from glib.
+# You should also check if any of the glib.version() checks
+# below can also be removed.
 glib_req_ver = '>=2.66.0'
 glib_pc = dependency('glib-2.0', version: glib_req_ver, required: true,
                     method: 'pkg-config')
@@ -998,6 +1000,9 @@ glib = declare_dependency(dependencies: [glib_pc, gmodule],
 # TODO: remove this check and the corresponding workaround (qtree) when
 # the minimum supported glib is >= 2.75.3
 glib_has_gslice = glib.version().version_compare('<2.75.3')
+# Check whether glib has the aligned_alloc family of functions.
+# <https://docs.gtk.org/glib/func.aligned_alloc.html>
+glib_has_aligned_alloc = glib.version().version_compare('>=2.72.0')
 
 # override glib dep to include the above refinements
 meson.override_dependency('glib-2.0', glib)
@@ -2529,6 +2534,7 @@ config_host_data.set('CONFIG_TIMERFD', cc.has_function('timerfd_create'))
 config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_range'))
 config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
 config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
+config_host_data.set('HAVE_GLIB_WITH_ALIGNED_ALLOC', glib_has_aligned_alloc)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
 config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul'))
 config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', prefix: '#include <stdlib.h>'))
-- 
2.46.2


