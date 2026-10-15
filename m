Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CB5CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPKh-0002cS-HT; Thu, 15 Oct 2026 13:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xHPKf-0002c1-S1
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:33:33 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xHPKd-0006Y6-Rx
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:33:33 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6aa9164072cso8385841a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792085610; x=1792690410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H9tIKPfI35WAcHndiECmi4UF6Zx6T9vPnIHLT1k/0xs=;
 b=SKC6LDMoWjvmyta5a7ZfU3DYgXKhIwhu4rRwNb+6SorT1wJB/AWyI3JtgWzYLSBuOo
 tNrNDvH9tAWjB/rhOk277dGp6NMU+tDtbuBRHxzWgwYSBds39NDOja09zj1zOd2+ouP0
 pDgeNmYR4tK1eV6vtXbqeRWtRsEBW4SD6Xh6IgKJOvJj1LzLDa/9CtG20rbhzRpCJuGO
 VoytrcTaStNdKE3RtIM1K5Swg0pvZ6YAzCj0jYQccJ6f7T6DKbWY/5wckmCtACzD+m0V
 znrpSZRF8cgQfx24dh6OcFPXe4yqdHz0QNd+v8CaZCFPYDd8TKbWZhCeHIKANTy2FSxD
 nH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792085610; x=1792690410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H9tIKPfI35WAcHndiECmi4UF6Zx6T9vPnIHLT1k/0xs=;
 b=kPeShoVc1YLvT9Y4J6NkTlOjzN2lC7yO87v7GvDGfeu57xjY8trLOkripb/oo0Cjdh
 nynoEtb2pDQ43bWiyblJV+e6IRTsxnduE128tyZ+8CHS5LudfBhutd/RSjooe0XS46z+
 D6r6WuTEQUVR8MVKE0CFXbzo6MuCC7wr35POuJhkvEzYrVKYu9meOug9XGQx7LFnci8d
 xOv0O8BpMqF7wNzKMEH/FBeOrvoWe6qug8JoyR1I9iXAB55/qwFtvE9hhOJ0ieKm8noe
 91gSQn3WGIsWg0s/6sZmN3gpZEN5783mhR/EcFgEZeFBZ7cdnF8XW3YxMdvFP7MkEfwy
 YK1w==
X-Gm-Message-State: AFq9FYIWbvrPhmYdD3M9AvIJRVPxowYy2VgNKQNtAqU2ZdHLKYX3XXPs
 c3IWZaTt6v1HKf1G32XKO0zkMmYCPWg/Cq7zLre4TidEZcH58mx7F1SPMnP78iHNZOA=
X-Gm-Gg: AYBFou2EfIiN7uOy1mMwEiYi+kNNKppLlJlvr1DRLu/hc817cWKkO9/SSMFNxeTUrnw
 pTwsnptlLys1er/Hx1ac0IRI9R0qPsduXfUCeC6hqAIFZxQXWOHjgfYK7qptbbx1Ruf2XBc1qww
 ZI+DWKJFdYLckP26AwgQShK/knr7gClDYdTB7QLri3NHm5It5S+tX01cwGOMmhJ8f0B86yigbb6
 GrNOPJA92AuFSDxfL1Ji2vDhcq/TEtdF4DbLH2YZdAqWP5UMaSPqmV6WXOZg67hpkdZVVYVR3sj
 W/DGsTLMabuwEiKkEvf/Trj2ywNcsWhgo8YaHHMkcWdNJlJfAYXaU2JpEiZqoQxGTl6MRDCNZ0R
 VzwCIclCd84b2mhQZnaU8F59WFi8COPkWt61ZvlShny9P0DHk3oBSRTvRzMpq6W5JTMQvvxevIT
 N5xuVC6eU8A1pdOyH1xrCvq9o2l98ZDwYb87txZMGmLtL9Ry/soAFTbic8I5Qu7KRtKjp7/bf22
 n6QPPHsFgWUeaG3TdX9kO/hTGM1yqWNr76REfl/n077KGqCtjsaiUx7msePR86u84GboiQSgU3o
 IbwI/tHRMg==
X-Received: by 2002:a05:6402:4025:b0:6b1:c2d3:6a79 with SMTP id
 4fb4d7f45d1cf-6b1c2d36d69mr10747161a12.12.1792085610223; 
 Thu, 15 Oct 2026 10:33:30 -0700 (PDT)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b20388cfe6sm2791433a12.28.2026.10.15.10.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 10:33:29 -0700 (PDT)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, michael.roth@amd.com,
 kkostiuk@redhat.com, Roman Bogorodskiy <bogorodskiy@gmail.com>
Subject: [PATCH 2/2] meson.build: fix getifaddrs() detection on illumos
Date: Thu, 15 Oct 2026 19:32:50 +0200
Message-ID: <20261015173250.65942-3-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015173250.65942-1-bogorodskiy@gmail.com>
References: <20261015173250.65942-1-bogorodskiy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Currently, getifaddrs() fails to get detected on illumos
because it requires linking with libsocket which meson
is not doing.

Fix by adding socket to getifaddrs dependencies. This
unlocks 'guest-network-get-interfaces' implementation
for illumos.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 432a333f56..20407024fa 100644
--- a/meson.build
+++ b/meson.build
@@ -2644,7 +2644,7 @@ config_host_data.set('CONFIG_TIMERFD', cc.has_function('timerfd_create'))
 config_host_data.set('CONFIG_GETLOADAVG', cc.has_function('getloadavg'))
 config_host_data.set('CONFIG_ARPA_INET_64', cc.has_function('htonll'))
 config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_range'))
-config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
+config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs', dependencies: socket))
 config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
 config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul', prefix: osdep_prefix))
-- 
2.55.0


