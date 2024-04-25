Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F020C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwro-0007ka-G3; Thu, 25 Apr 2024 07:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwrj-0007ju-R1
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:02:12 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwrg-00088I-Th
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:02:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-418e4cd2196so6833835e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714042927; x=1714647727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wjoLmpbwfS6wFuFSJimySduX47ZEmh3QOL6abPkvr5o=;
 b=LiSA7jOVkbTokpNSinr3zsFN61oPTSKAuVYvpHfbHxwIk+tJAek43Wlr7awXyBC3/V
 DH5Q8v1rO/VFtXzpKiVCaqtH299eXylf3Xjx+r+EikvMffQg3UGS0ChbbEH52Qxuo6H9
 Qoe+S0gFCgOpxhny2r1+51pgBJOOc0EcpNi1jBcItdH18SLba5xCaalowv+cFYuAflDq
 chgAS5l9hZNOJYVOgOdWF4U3btPV1/1i4FpLeC+LnO3ru8gDZ6FUYKUYKvHcIsNYH6dd
 s8MA1FP5W3zvPN5TOTx6Ff8lg1VRMRzpGkj3//vj7LeTqIWU+zleYuIc9g4FZPGI/0kQ
 NMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714042927; x=1714647727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wjoLmpbwfS6wFuFSJimySduX47ZEmh3QOL6abPkvr5o=;
 b=HDTJfggxeqpht4dLrBO4cAEbs1EMibxVvLaYq/lib0uSDCYs42AXrcGh9HqV9DnL0O
 5idTv6rG/1FAWgzES+iVCoRwEgJIn2rgPeuoBXvsO1kZjU3K1dmVW8hagqDnkB8AdIiD
 2KUKkkFA/WPZTMvVFIiSQHzGcv19s4d3vdyT4MCFYjvnbXJXavWykn0wDPb2lYuUV5dM
 JQwsDdsSkr8Ay5dumv7Rj7UI69oasHdnsISQt/ez6J/etG5j0VcREB0cPtO3yd2nGjsq
 fCiGVBbRolpIG/dZzMSOMAh3mUrU0CeBmV6XGRRtOn2Nw/7e2G1isAEP0mNhVpZ0N1Yg
 dOVg==
X-Gm-Message-State: AOJu0YwKZMPFtO4SkAf90iPtMw6HuJbk6GqtgiXN+yymvcjM0v/rVBa8
 +3P+jDlAVS478e1PDrNIJnyTYlpnc4qFBkkl+fbKN/ll5KZ6ijQNdFKX9hulMKb95ILuMTTzmjp
 1
X-Google-Smtp-Source: AGHT+IHQ2mv+CeJro9jqWlhkOIlmdcn/MGtTGdAo7lLFcltymnD0f4bSsdMfj0nsoNTC4MxDjpUT3w==
X-Received: by 2002:adf:efcf:0:b0:347:d21:6855 with SMTP id
 i15-20020adfefcf000000b003470d216855mr3965037wrp.14.1714042925092; 
 Thu, 25 Apr 2024 04:02:05 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 b16-20020a5d40d0000000b00346406a5c80sm19587104wrq.32.2024.04.25.04.02.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:02:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 01/22] qom: add default value
Date: Thu, 25 Apr 2024 13:01:34 +0200
Message-ID: <20240425110157.20328-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
References: <20240425110157.20328-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Maksim Davydov <davydov-max@yandex-team.ru>

qmp_qom_list_properties can print default values if they are available
as qmp_device_list_properties does, because both of them use the
ObjectPropertyInfo structure with default_value field. This can be useful
when working with "not device" types (e.g. memory-backend).

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240318213550.155573-2-davydov-max@yandex-team.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qom/qom-qmp-cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 7c087299de..e91a235347 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -212,6 +212,7 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
         info->name = g_strdup(prop->name);
         info->type = g_strdup(prop->type);
         info->description = g_strdup(prop->description);
+        info->default_value = qobject_ref(prop->defval);
 
         QAPI_LIST_PREPEND(prop_list, info);
     }
-- 
2.41.0


