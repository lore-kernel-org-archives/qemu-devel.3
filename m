Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBEAC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whjgf-0007i8-Q4; Thu, 09 Jul 2026 04:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjge-0007hq-K3
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:48 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgc-00088x-PN
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:48 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493d92b7db3so16260675e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783584044; x=1784188844; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oatKbJ36+GduX+fE/S3KuvMyX9o0BpsZdbs12LGT/h8=;
 b=cmChVbGN+CKpclGy8k+S+VSdX7OLXgOGfbyQk/dhf5bzFjtw9RgijIcZd+sixLgCwe
 OlfdFORsfRp0fmG+O62cZw/HnYT5gGPDCiegtZDBdAaokm4ZdGGjczoUEMIIBH3JKjl9
 bVKRZKrFMFxA01VmhhZetpu6Xmif6GSdkR/RblzNOkdyAaNGzFXOn0Rf80GYRunI02ZR
 t5bLwv5FNK/lZr8//E5Ds1XBfut5k7xg5GvkCs8cLLnCIwYDQ/Nr0V6XhCavtrEO6L9h
 8Cet2flr72EbGC1HvPxxDnDLM4FwaqoDcmJ61n0fFaiZ43yCwn0WMnsO/FExyz7uFamF
 geAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783584044; x=1784188844;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oatKbJ36+GduX+fE/S3KuvMyX9o0BpsZdbs12LGT/h8=;
 b=ov5UykgldiKNSQqPhAwCNiPEW2DPIHcWFeNXzFbPB4TGDARt177Q606IrjXolGn5Bj
 pthY/EnnEUhe/bOOhvCcE8eSmX6GHdDzJaXBBQEofQojRQkAwfYo6sQAgwvY1Wlrw8T/
 fxEEBOeE+/GWyIbQMTTlvZO5vcYG45mUxIXy6Mz/Ogre2hQ6VN34dhWPMJFZ3q3Vcs33
 3YOtNM06oH4ne1HCQH6daouFudWPLAzqv+JrDuahMJuC8PEOpulmWwV/6zIg/L5dRZOP
 ed3FX9TZl+GiYYWgqwBaQjIlmM9sr0fH3pFp60Aj5AyYbBBrHTLUQxYTL/3EYVUxvTpb
 K38w==
X-Gm-Message-State: AOJu0YzlesBJQdBJaX6bWdVHG3mLBZHxlhMXfxTMFSg/vY7A8IYf6Mep
 YaeXXVBdsxdBJvMaHVedP74+kq1wC0iOnN24GYC5A5XUm7FnV0FSEoQ9ey5LaoUh4IQVdo1xr9l
 hUoF+kUU=
X-Gm-Gg: AfdE7clqpJGJpd4UtLOeReZKpmkrOnJlmUHjb9iBecKYZRZI1M2UD/63wdmcJrluXPt
 sq9FgfvkLaClGJfjGq9v7SCcmyIa8axrD0GmDrmQdwMA1coSv4G9HMQAW5+4sVF1hcge7uDAn3P
 7s71j73jlNsgU383lqvSXAj/5/u1yodn7cz5TF8lTl9/MXQtAPxFkJkDqr/V/jlUJIv6MFRHjQb
 gogW8t0vVWKqd0oYJH+96kg3Qiz5a3ZsckEHN0t+gPZ9LqsivYD5tNLdXAo5iPhCIkjxNN74YOj
 iLF1gx4h5nkjasQ+IyNXBYEjfL2k71M/Swcx0ludSbPkudC5ox0vRQD9QT1vXyI6B96Q3aJtYab
 dXYy+S6rK13o0Ipvt+vH8zUwYTiTLD/62opFfvlesg5sCCXL4nJaOMxvPF0tnDZesFzzJZDrTqv
 /iFrjLS6mbDfqf
X-Received: by 2002:a05:600d:844e:10b0:493:c785:e0d7 with SMTP id
 5b1f17b1804b1-493e68e7612mr44763235e9.28.1783584044112; 
 Thu, 09 Jul 2026 01:00:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e5a6d752sm72118795e9.2.2026.07.09.01.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 01:00:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E6E65F82D;
 Thu, 09 Jul 2026 09:00:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/9] gitdm/next: more updates to stats meta data
Date: Thu,  9 Jul 2026 09:00:30 +0100
Message-ID: <20260709080040.4157324-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Including moving it out of contrib and into scripts.

Alex.

Alex Bennée (5):
  mailmap: add fix for Zhongyao Chen
  contrib/gitdm: add Nicholas to the IBM group map
  contrib/gitdm: add group map for SiFive
  contrib/gitdm: add more individual contributors
  scripts/gitdm: migrate from contrib

Alexander Mikhalitsyn (1):
  mailmap: add email mapping for Alexander Mikhalitsyn

Joel Stanley (1):
  contrib/gitdm: Update IBM map

Philippe Mathieu-Daudé (2):
  mailmap: Fix Ryan Zhang email address
  contrib/gitdm: Update Qualcomm entries

 .mailmap                                      |  3 ++
 contrib/gitdm/group-map-ibm                   | 15 -------
 gitdm.config                                  | 39 ++++++++++---------
 {contrib => scripts}/gitdm/aliases            |  1 +
 {contrib => scripts}/gitdm/domain-map         |  3 +-
 {contrib => scripts}/gitdm/filetypes.txt      |  0
 .../gitdm/group-map-academics                 |  0
 {contrib => scripts}/gitdm/group-map-alibaba  |  0
 {contrib => scripts}/gitdm/group-map-amd      |  0
 {contrib => scripts}/gitdm/group-map-cadence  |  0
 .../gitdm/group-map-codeweavers               |  0
 {contrib => scripts}/gitdm/group-map-facebook |  0
 {contrib => scripts}/gitdm/group-map-huawei   |  0
 scripts/gitdm/group-map-ibm                   |  8 ++++
 .../gitdm/group-map-individuals               | 11 ++++++
 {contrib => scripts}/gitdm/group-map-interns  |  0
 .../gitdm/group-map-janustech                 |  0
 .../gitdm/group-map-microsoft                 |  0
 {contrib => scripts}/gitdm/group-map-netflix  |  0
 {contrib => scripts}/gitdm/group-map-redhat   |  0
 {contrib => scripts}/gitdm/group-map-robots   |  0
 scripts/gitdm/group-map-sifive                |  5 +++
 {contrib => scripts}/gitdm/group-map-wavecomp |  0
 23 files changed, 50 insertions(+), 35 deletions(-)
 delete mode 100644 contrib/gitdm/group-map-ibm
 rename {contrib => scripts}/gitdm/aliases (97%)
 rename {contrib => scripts}/gitdm/domain-map (94%)
 rename {contrib => scripts}/gitdm/filetypes.txt (100%)
 rename {contrib => scripts}/gitdm/group-map-academics (100%)
 rename {contrib => scripts}/gitdm/group-map-alibaba (100%)
 rename {contrib => scripts}/gitdm/group-map-amd (100%)
 rename {contrib => scripts}/gitdm/group-map-cadence (100%)
 rename {contrib => scripts}/gitdm/group-map-codeweavers (100%)
 rename {contrib => scripts}/gitdm/group-map-facebook (100%)
 rename {contrib => scripts}/gitdm/group-map-huawei (100%)
 create mode 100644 scripts/gitdm/group-map-ibm
 rename {contrib => scripts}/gitdm/group-map-individuals (80%)
 rename {contrib => scripts}/gitdm/group-map-interns (100%)
 rename {contrib => scripts}/gitdm/group-map-janustech (100%)
 rename {contrib => scripts}/gitdm/group-map-microsoft (100%)
 rename {contrib => scripts}/gitdm/group-map-netflix (100%)
 rename {contrib => scripts}/gitdm/group-map-redhat (100%)
 rename {contrib => scripts}/gitdm/group-map-robots (100%)
 create mode 100644 scripts/gitdm/group-map-sifive
 rename {contrib => scripts}/gitdm/group-map-wavecomp (100%)

-- 
2.47.3


