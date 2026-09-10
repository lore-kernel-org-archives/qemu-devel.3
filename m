Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B320C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nLP-0007fD-1h; Thu, 10 Sep 2026 18:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lPY-0004Iv-En
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lOM-0001OK-UX
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5re7lxkrkt8+upQzc9fNBwoUOfPVSS5sXD8pGJHek6w=;
 b=Y8rwoGUk39utt9HPO4M7aR7Wg/K9rtlfLj51sotnQVJXKZCm5UZt9mDTGtUxFSDTCq3k9g
 49R6mlWbqGoLB2q7KPX9gsxZmdiFgnmfyTqNIbUL/kpEOjqKM7KVdHDXmM8T+TyL/lAkD1
 QuOVz90gLfiCwOytGZJ6Ty/12ADjwwg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-pvvcdLKQNhGNFBS7CkuZNQ-1; Thu, 10 Sep 2026 16:13:37 -0400
X-MC-Unique: pvvcdLKQNhGNFBS7CkuZNQ-1
X-Mimecast-MFC-AGG-ID: pvvcdLKQNhGNFBS7CkuZNQ_1789071216
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47d81cf0c4cso68893f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071216; x=1789676016; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5re7lxkrkt8+upQzc9fNBwoUOfPVSS5sXD8pGJHek6w=;
 b=XDUK8bYQ1KHbOc8VX6LCJBW6jgYaQJsNB4GWzWQvhmXTI6zj/3EA9+gpCw7PA+5DdN
 LhGdIw/np/ZBOqkKCNLPi5wmmu1LKWGQTNyTsScHyQyHevu8WEgitGWZAbBxtUApF5/r
 NVeByPCq36t2KJ8wKSLGM66AVe/plptZFEyVCM5mMSmJG6Mt1+/Pdju4u5afwh3VciPj
 IMSgdlbUotl/Sf0rAH68QWQak/0laeVhYwuRymnfcb6S73I5RCqz/u0HqS3jD8L0rj13
 MuFNaDtc6nionZcB5FN+il0gytqjjZVYQvQI07U4s5wCW6hzRT+83UhfD6KWukmC7dEg
 ZVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071216; x=1789676016;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5re7lxkrkt8+upQzc9fNBwoUOfPVSS5sXD8pGJHek6w=;
 b=Ryz8pxdbcuy4iHcvzq5vz3iP6iw3K2f+mY2bykkOfvvSt0DYXL9g+fthlc9J/yTFSn
 UJCgwh7BRr1F53lj1KyVyqvtXAO/Ktg0lDGWYbgqrjzkGBSo0PBn0WWBG9IILOOUlLsj
 S6e1+fsSNg42KqzAnZ1kqeDyu8K6l5UliM9vwx69CAAfQJfAe29jdyHBHdDYqYRMCs6v
 q2zASyYC7Gu8TZ1nNIr8fobzJ1aA5XrXNCBQG13W/MQuGpTupyUsWWW/Dlz3poclKhEj
 5fJe3b6ePjJEaTpwd+cT/chHcT+hSsb8T8pVNJbTundUfuj8w9qBorLtEgXit5KfvxSu
 qW2A==
X-Gm-Message-State: AFuF++nQBFYpkYtsFEmlhZL/e0RojyiW2SXReFByFOJmxQIN9LOwozDE
 CauHCa3HExOuBgEW+iPSq+3dBMr7vJniYFMTpE4VPDEUp1qcIhUYaissPTGZjj1ZpQjV5gc3bWY
 911MFw8GiB4TEvHEvx+hbDoyFupo2E/yZyJqv4hWINYRChajegYaHEH7KdJYsDrCaq4gsgolLCf
 PbG6C4e0xD2q6QSoVXnShSz2FH9l7Ue6uy0g==
X-Gm-Gg: AYBFou3O1DhEGcyFtkFLA2p9F/7nfvQIXYtqTRXyHhCgAHfWTQ2nwY7Cs7mVZF9lwg7
 MICb/MHLt/7clSgGiAdmzEfPR4Rx68l6xKCdzyV+pmbhzPEDPkdTUd5GxZY0T5DEmB6x1Qm0Kg9
 1TwghfU/DEUY6REv/30YMyeXEzLXSeTJJUw22jfJpIsr1NbUdj5GKDMJmAgnOuEJjEVmtf7wMpV
 L9RI9LOocb6WOzWNucZwStOoEdQ1OKibij2D/oh4JxscNqVVouivLR0lzJEd5qodmwrBOCmwU6Q
 QGU0NR8fVNvekp7++A+ZiH2Np85P+yXPkEjDTuBC33Zmi2fbtFVdIQn6/SZRqRzWdQWrqBpz3Tv
 rQJ7lzVOLGyxY9BlpDDlYdjM=
X-Received: by 2002:a5d:64ea:0:b0:486:e91d:9f99 with SMTP id
 ffacd0b85a97d-486eb2e40c3mr1542163f8f.10.1789071216281; 
 Thu, 10 Sep 2026 13:13:36 -0700 (PDT)
X-Received: by 2002:a5d:64ea:0:b0:486:e91d:9f99 with SMTP id
 ffacd0b85a97d-486eb2e40c3mr1542098f8f.10.1789071215667; 
 Thu, 10 Sep 2026 13:13:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ee8bsm728004f8f.15.2026.09.10.13.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:34 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 51/90] meson: disable "maybe uninitilized" errors with -Og
Message-ID: <5dbc8c2fd7c824ba6038118acb6b6412ead67194.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

GCC's "maybe uninitilized" warnings depend on optimizations
for code flow analysis, and produce false positive errors
with -Og. Default build gives us coverage with that,
so let's just disable with -Og.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <f559b622eb2d1a384b4f30583a8af10531f4b032.1785144729.git.mst@redhat.com>
---
 meson.build | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meson.build b/meson.build
index ec9b05414a..e2da31880b 100644
--- a/meson.build
+++ b/meson.build
@@ -746,6 +746,10 @@ warn_flags = [
   '-Wno-typedef-redefinition',
 ]
 
+if get_option('optimization') == 'g'
+  warn_flags += ['-Wno-error=maybe-uninitialized']
+endif
+
 if host_os != 'darwin'
   tsa_has_cleanup = cc.compiles('''
     struct __attribute__((capability("mutex"))) mutex {};
-- 
MST


