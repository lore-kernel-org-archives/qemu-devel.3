Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BB7FB44C2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGAhm-0000j3-BF; Fri, 24 Apr 2026 03:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGAhj-0000ii-TX
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:11:59 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGAhg-0006FO-Oj
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:11:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso71879035e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 00:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777014714; x=1777619514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MW2/G9TTsYqA6jxuX2jKu1nRSMEGG5MI1HQoXjEOg6c=;
 b=XjTbv05DEEbS8jO72ZgWk+56tXzFrJApbS4nHzLuIu3psury3JvuH7xh8veZYGTMYZ
 XmVRKI4eMh1YDWTvpKro3T9taJJWj5LVeUCBOu/GaeERzEV3imAy9cYi2MhZB1G2vjeP
 RDjiMqId1+cjCu6DYE34xc3sL/pAcPHhPUWafkf7z1wl8XV3/vlgQMyZB+Rd422MsUCB
 eVm4jDQONRHGfRVRvuHS/Ai5FXh5v8mB4xef8J3fRZl742NuK9cifDo3OZCZyq3UNi+b
 vLntInpAgBdILjcnwg4/iUXXZO6HDFEJ6+7KLiEuc7R9HFuCtf/XY9QAnJ/JeAOu4Wl4
 uEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777014714; x=1777619514;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MW2/G9TTsYqA6jxuX2jKu1nRSMEGG5MI1HQoXjEOg6c=;
 b=Ww1+TmKNChyow16liN9CSHwcyH+Bgz3uchXtHLHNH1HQFbVEb7Dm423cnaNsQZJ6iM
 ZJ0Am+MHH92cAIqk3c1taB/c0CkUE5TCfcAt18EYLVouriG0evBJ0q5cYPur6q+zgjAL
 H/gti+kx71ba8qMU440JTHFWeZGvkwjZjeQjAD3XGZ5SBbnWj4sWvSVxKSFYfC2QrpXA
 ZepIEgGr2e6zAc8MlUA3osQa5MCRR7LDTk72Km8/+3gH/j7lkHffH398Tg8zqi0j5aFY
 N7Siqybdx+Eq8ryp3aW/z5mUMVztFtwUBBKxLqKJC44+uUaSUexvxgE7W4dE4EPaDfit
 MsXg==
X-Gm-Message-State: AOJu0YxPEaUW1eWpVZeEvJ/c2jpliI3yNbS2i2OA+/5o7/j209rlZWSB
 Ua89jIRynJYm12Y+XOSFCJY2rkxIj4vfk/JiT6vtrv2mfkEMRblWynGQdig1oC6+4Ho0kTl+wza
 pQHa6AYo=
X-Gm-Gg: AeBDietNxcK8zjlErYB0dhVwAiJ9yeYArhjWP5ySXL2drU59KmbteFJ4pUVjSRZAGrk
 hyi5hWgagSLyNoSFr1O+udhzv1HHomTYQvBU/vy5KK4Lv1NZAJJoLKA9JL9zHLHTe4MVyB4JL3+
 dCWHiZwmrL5zGACffN5fP056P66KGjQwoZ3w3z7N/pFeYffodEpJa26DkEqU9/XhnxpWRWzW2/y
 1zWB1hVY8JH00OpFwBEVS+TQlfaUGZ+sjQ1Uw2qMBeJzKudlwUfuzIIL1lyI8Qwrx7xJcKJPG42
 mwsonWO4zULslYtr9Yjll27kxRRx8dqeFOp9w23S1s47awaxDJTujY8eEdJx2FcX9xatTxxAREE
 Q912elBSoWRnjWttft3mo4WqXZXJSTmYQAN7VZc6sULTJZerpkQFjegYGH/2IUlspGYJ+oWuhx4
 J29cXStI/2Aefu8H+AYknjSfeMxT0aRZNCwd1WEfzf91hCMgWdgGa/9zXdRDYmw8sM/b0j9T0WM
 CQzcvidCybVoV0BIMIvYSFOoqTsgEz/d2iVQ0OyhiDlxdwGQewLVLHoR+9MVw==
X-Received: by 2002:a05:600d:8447:b0:487:338:b4f3 with SMTP id
 5b1f17b1804b1-488fb778734mr334080265e9.17.1777014714173; 
 Fri, 24 Apr 2026 00:11:54 -0700 (PDT)
Received: from meli-email.org (athedsl-338307.home.otenet.gr. [85.72.177.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc100162sm590075955e9.5.2026.04.24.00.11.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2026 00:11:53 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:11:39 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH v20 14/15] hvf: enable nested virtualisation support
User-Agent: meli/0.8.13
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
 <20260316130642.13246-15-mohamed@unpredictable.fr>
In-Reply-To: <20260316130642.13246-15-mohamed@unpredictable.fr>
Message-ID: <tdzlbs.136zmg52jco0k@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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

On Mon, 16 Mar 2026 15:06, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> hw/arm/virt.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>index 90769936d0..391ec722c0 100644
>--- a/hw/arm/virt.c
>+++ b/hw/arm/virt.c
>@@ -2393,7 +2393,8 @@ static void machvirt_init(MachineState *machine)
>         exit(1);
>     }
> 
>-    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
>+    if (vms->virt && !kvm_enabled() && !tcg_enabled()
>+       && !hvf_enabled() && !qtest_enabled()) {
>         error_report("mach-virt: %s does not support providing "
>                      "Virtualization extensions to the guest CPU",
>                      current_accel_name());
>-- 
>2.50.1 (Apple Git-155)
>
>

