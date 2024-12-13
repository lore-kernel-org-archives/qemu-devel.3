Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C1CE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB2K-0003MD-EB; Fri, 13 Dec 2024 14:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1x-0002Wa-2B
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:58 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1t-0006Zg-74
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:51 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-71e16519031so1052230a34.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116925; x=1734721725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DK3m2qrYLo1FElKLISrWyflVJNfhiEXCCTPNj+B3ktI=;
 b=IUwYAKCXWVg33ADuClOgHWt+XER1Oh0NjAjIJRz3BBZvhzhg4uuZAJ7ZuUwEC9EmVS
 xOtm8SfU/IzWD+zk44LsHq8reIRHSjECNfXZ1wsPn2ddvFsxuoJLd/GETQkCyNta9YF2
 0L1GD5GBMI59WpG+T7JpluNH8vaj14a1lq2a8EJqRbjjnGgOEPHxbmRjr7LMrzq3+9ZU
 udGbOvJrljdw0udJ4rUva6woh0LR887pcZ4cLoQzaM0VHzf8k1n6K8qvHMD7gvT4/7oy
 6mgNf9ugbd80LRJMVndM58JPGHUyK67eRMwW/slQevynNdZB2nP18vIcrmV5QI37zYe+
 jlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116925; x=1734721725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DK3m2qrYLo1FElKLISrWyflVJNfhiEXCCTPNj+B3ktI=;
 b=CX/5vhXqHcxpB0VzbIDk2tD8kDLPTdcAQsQr6NwWDEZhtcokRf3VjnSy/jMaxrYahp
 I5ApbUMph8Jy7qjpXOqSeeovoefpz1klIo+M/dkk25tguHldTdnb4yngct57hTCViX6Y
 D5p3R74hVzVrVxqYxS4cAPkhIJ/SiLMoxb7353FHItm+goW1gjFWdU9hwGakNQY322a4
 cwn8IjkMlzhg5vceA1o0WjCvEORb0D32XrYaQWS2k6pS0lKo5qoyB62UPotIGoAKZ8Mj
 qhz+IP5cnLLkx3vzX/R1yP3iyzQgedttjPMlPr60ZTPjuS9oi1rVRDqrYboaqWIvEnxc
 1tqw==
X-Gm-Message-State: AOJu0YwdEJnjWlRr6+0mJsJYzTlpBJqP4q6vSj2LwkRg324L8Vx8HT31
 vOjDOwd4Ki9tvnxGNlqm+jlGcFDBxlB+ehpbUAyZ4AAtYjmcR+Ze92Xur85b0SAPPdiyHVB8jyA
 03V8MCOKo
X-Gm-Gg: ASbGncsBgZ3slaMNS6X347wVYMCWRhNHHQReEsLifHBkJJMXEomfjultlkSBWurovJA
 JtWmyq18BMmHuSzBXixt+CLh+vF4hY63c4rcmWyLXiGRa1T/nTbugFHcP9RGIwaId/tYuiziNaw
 wRoRL7STY6OqGeGsYTA0Jwj5fxa12KOk/goh7ETLlTHGfCzpr26fjrKe2AWcjeF3/u+kBCxYxq8
 tHVOiC5cI9TYFzf/kkXkt6MxIBWRRCy2VcIUaKqSuWiKWp78AB0FjjfJ/uo7u4J
X-Google-Smtp-Source: AGHT+IGgQJUhEEQYm3eXccexiZQ3Ka3v0ZO8L73EAZ8fhhYZUlw4lZyHEhqI6tlAZYFxfvGBhS4yJQ==
X-Received: by 2002:a05:6830:6a8d:b0:71e:15f7:1a3a with SMTP id
 46e09a7af769-71e3bd180fdmr1828568a34.2.1734116925411; 
 Fri, 13 Dec 2024 11:08:45 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PATCH 12/71] hw/9pfs: Constify all Property
Date: Fri, 13 Dec 2024 13:06:46 -0600
Message-ID: <20241213190750.2513964-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/9pfs/virtio-9p-device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index efa41cfd73..b764e4cd3d 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -243,7 +243,7 @@ static const VMStateDescription vmstate_virtio_9p = {
     },
 };
 
-static Property virtio_9p_properties[] = {
+static const Property virtio_9p_properties[] = {
     DEFINE_PROP_STRING("mount_tag", V9fsVirtioState, state.fsconf.tag),
     DEFINE_PROP_STRING("fsdev", V9fsVirtioState, state.fsconf.fsdev_id),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.43.0


