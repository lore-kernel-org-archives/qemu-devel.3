Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18921C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 09:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGxnM-0003uI-Hs; Tue, 11 Jun 2024 05:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sGxnJ-0003tb-8E
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:27:57 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sGxnF-0007LI-CU
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:27:56 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7041a7d4beeso3085682b3a.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1718098069; x=1718702869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I8rhoRcSZADjEYlUb6+R/HBzxDupQrGRHiMqOwPQjO4=;
 b=CNv53EmfLp2LWDwlHrEUXSNjWQe6BgiZdb6FvAc7gUoMPgZNbStdYaov1/rJ4qtOG2
 1CCMO5KuWnpGSklBuOM+MfcA7mvgp4lgDgIT1d4+xcT+kmJZJg4WqhQu/cDhKOFCY7Ob
 jn/BInq0GrFspgBkc4VbOf/XkiRJlA/OrYh+nJ54PZ64rpjwydOyjwEbJofPPu7a/eQG
 VopuzTGla3+aZ3y2f+u2i5KeuGp7nj1dKYOdI3DG+R5FA+YJPLmOlw5dVYVBieFLlO6x
 41qpGkmsViZqmOKNAMHMZ2U+uYdi3/ZEplUHrOyoUE7A+wXBG5qq23/4TttIRcCGXQCS
 RsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718098069; x=1718702869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I8rhoRcSZADjEYlUb6+R/HBzxDupQrGRHiMqOwPQjO4=;
 b=AOkThNS+9by5iQ/+gABcKeSY4Lhn2/3L/gsir8m0q5R3M9GovK9g0cwUmOSdPBTY9l
 PWef2an7dW6YPwtwJXkc3DTfDLxASIccsgYva4PYibbgvwB3GPwHn4QvXK+hp0KFarUH
 +GmlAFC8YKSpv3qjBeiHRvApPeB6X5OJYvtJ3aV2AxmqvZnSywRcPweE5ja6DQJ4Qudw
 gOLz6CHLByq3KPH8N6n2UDNjJ/CXRwTbPP4+VbCRMxxv98jVHZGk784sTfsN3own3R9A
 HlQnZVhgiLxetlVjvSMvaJXUCKX2eXTRW8Dxd0aCLP7tcUelHuiogHVw7k4de78iOvW9
 cSbA==
X-Gm-Message-State: AOJu0YwsIIRk+RYhXYy6uzw88ZYRJuty8fY2MvD0GBS8MpCOP5xPjmZd
 gU07dWOr9QgfxtEN4JqC0nGTgYZKeiKOZXysOW9d6uBDU3jcfRRj/C4z+Cnn2eqUefFAAABJuAH
 AI/Y=
X-Google-Smtp-Source: AGHT+IGHOSO6HB+XkL0ulVQRENAIJozBuNONcpD35ivsqf6cgamdKKwHl/JKgnxTp1MyqqTr+cXlyQ==
X-Received: by 2002:a05:6a00:230b:b0:705:9cf6:bc21 with SMTP id
 d2e1a72fcca58-7059cf6fa8bmr4056121b3a.12.1718098069493; 
 Tue, 11 Jun 2024 02:27:49 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7041cda06f4sm5871153b3a.75.2024.06.11.02.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 02:27:49 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 0/1] meson: Remove libibumad dependence
Date: Tue, 11 Jun 2024 17:27:42 +0800
Message-Id: <20240611092743.59255-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x42f.google.com
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

v1 -> v2: remove libibumad from tests/lcitool/projects/qemu.yml

v1: remove libibumad dependence

Zhenwei Pi (1):
  meson: Remove libibumad dependence

 meson.build                     | 4 +---
 tests/lcitool/projects/qemu.yml | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

-- 
2.34.1


