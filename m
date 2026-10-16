Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5285CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHlGf-00084Z-Ec; Fri, 16 Oct 2026 12:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xHlGV-00082m-Rc
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:58:45 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xHlGT-0005js-Nm
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:58:43 -0400
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 80D693FE37
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792169917;
 bh=DtcXCe5iR7zfIacCA/HwuEuzJt1PHYbYs84sTh3I3NQ=;
 h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc;
 b=org41iFWuydwuqB+w0f1BR25YwpQEyA4CHFYchSEnDjjpZvDvSGT5ofqzjS7gz2rb
 FeK54+z95UW6F5acnogCt24TDBjp2IM/AykSGPQ5YttD8BA+gqTHPTGy5WdM3OlCNX
 q3/wApTIVDhppF/uLWKIxEiH5bDsgeTyAFhYn9Q5u3lbbm2ZTJCAfb99t1CNd1WiGp
 74VBrdRuL6Hu4TRVRlfLjU5dV4SkWyDpcnmDlb2WCwwbChNit6zCN50MqxcW4EaZWm
 Qf9nEyd5v57hF4HuWZP1wHPN1/RCvTbbMZ4ymQIt/CAPI0uuZEVQILxDiyzZ+Yvq7i
 /VAe/9BbrrSCbCqgemgv2gfciUO3LKMdGk0rg8hX2nXFIvna76lb6TADZfLXuS2mDl
 GbiRHoXjHZM/IgboRxaxx4lN/gEsyoiobFtkq0APykKMe17YUMWjsmfeT8/NzCGC//
 ntUblhSSiKWY+z5vmReJfuoPEuxE0t7WJf6YwN6AlSwSFfJ3FaAe5KI7dFEwNo5xhL
 n2zOd0g9Z78/kjU19tYgU5njIR5aPMT74rKVHtvS4ak4zWZ20hN6ZaMBhdr0SLVnaW
 9iHosyMuKlLcPCFl/hvufCP2H9P1NIez9bMtI4gOvfvsw7Jrwp7ASOyxS1GSCkP70s
 wppyGH2gg8reZfUm2ZH/S2FM=
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b0a8c1b87dso1281847b3.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792169916; x=1792774716;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DtcXCe5iR7zfIacCA/HwuEuzJt1PHYbYs84sTh3I3NQ=;
 b=AXhQOpxjvThZIFk+ELiPtSMXZXp6m7hpt9AnHQTmin9WHB5GdNXO26H++Yl1O23yrM
 z/5KuKwYDqhdmmQUTST81Pt2Dbh7M9cge5ZmKXmBFv0x1c6Z3xTvwC2VW/kxVoBr0Yjt
 /OahMc6ChgGNZg7l2wROcXwT1exlHkZh48YEr/3Lkdqty+BGfGgfW0fM5fiWaJ4NgP7C
 AJpFzGvwIXR2I7Fdty39DLESDckI7Sahpo77sOx4N41INJ6gV+BFoTQstzKHz1xsBCFQ
 DJcoseiPV61jcFHC+WuHyvVP8RfmJ+bu6haaQajC6A/d0iPiFl4ELuPKSvO6txGu+bc1
 Hpaw==
X-Gm-Message-State: AFq9FYJYNvwwQlkd3hM4M9edj7uNvVWbj75TsHmerqSY363ZP8EyDd4X
 NRZKBF7tWDY5oJ2JIzuh4qXlO+El+qxsDdGX0NyvfHW8BxSF0qeG1qtTpiyQjphYBBf42McJXDm
 0WdedzfUDJsQfObmX3S7ff2Phy07/gNCNUg7Q89/EQOFdBc5eN5WIJIlqr0HQzOVoDZnOXmV1
X-Gm-Gg: AYBFou3wh2zZmoKIxcoTnZ1tCn3uYjbzkpC7yhj6xI5CvNVtoCsVWmrDiGDCToRtUwZ
 dasBAGj2w33pl3SFqpwKXTzbqJj5caJb+bASZRklzIdk0gEUnrUSY1a4DM253/lmfntLvwhezqd
 jBJPDbzqqAu+cMJ17OdxMqa7dTD8UUGO4OKbfcVvI4r2pBfaqYu9QZGs6kA08kPeY1QWsWzoR2i
 3J1ShtiViSrfZVVr/32taHPae6ci48Uvn9SlFU2GjM8qmjUgAs3okPoRP7v53HWRzXm9hO1+Jj8
 a9QkW6cZAqPZwaRPRcaD6CJM1YzWRMzuynQI9XeP7vC3Cf18tPWaItTqjsqINX+54YupFQpFmNo
 QxXCxlZI1bv1YU7Lp+TPZKM+/OuNNnt8xkjCNol3dL5zsKEXUTDjLvQ==
X-Received: by 2002:a05:690c:112:b0:8a1:781f:4aa0 with SMTP id
 00721157ae682-8b0f21c33eemr2298557b3.56.1792169916262; 
 Fri, 16 Oct 2026 09:58:36 -0700 (PDT)
X-Received: by 2002:a05:690c:112:b0:8a1:781f:4aa0 with SMTP id
 00721157ae682-8b0f21c33eemr2298347b3.56.1792169915692; 
 Fri, 16 Oct 2026 09:58:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:6c45:3000:1420:26da:25ea:7a28:6e4d])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b0e58ad1b4sm12193167b3.18.2026.10.16.09.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:58:35 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Subject: [PATCH v5 0/2] util/coroutine: Reduce default idle pool max size
Date: Fri, 16 Oct 2026 11:57:50 -0500
Message-Id: <20261016-set-default-pool-size-v5-0-719e9e4d3f9c@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NwW7CMAzG8VdBOc8oiUNod9p7IA5uao9IXVM1p
 WJDfXcCJ4RA4/j/JP98VpnHyFl9rs5q5DnmmPoSm4+VCgfqvxliW1pZbb3RBiHzBC0LHbsJhpQ
 6yPGPoWrsNmgJVDGqcjuMLPF0c3f70oeYpzT+3t7M5rr+J84GDGwbNrXTlsSHr0B96mOgbh3Sj
 7qqs31LsqBBnLReLCFqfCbhWxIWqUXPVUAjNflnkruX3CvJFYmQRKq6qZ3oR2lZlguyeKmQnAE
 AAA==
X-Change-ID: 20261013-set-default-pool-size-8b27c0fca8e3
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hector Cao <hector.cao@canonical.com>, 
 =?utf-8?q?Alex_Ram=C3=ADrez?= <alex.ramirez@canonical.com>, 
 Wesley Hershberger <wesley.hershberger@canonical.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=t2ZVSkPMUGVUveIDlsFP1e2G+GRo23/snrLbz0kf0IA=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBq0le5rMe6O3jpod7jEMnl/ox2z7pCzXE4igSMO
 VAzOvJFtTWJAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCatJXuQAKCRD5KICs4jod
 uSOpDADJchI03sRlewb13Jj0xOYiHjPjGTx7ylyrwbo1Hhly5QFOo2lzTASKI26vELJxo7OBAp9
 GLpj/GnDBww3Sg7buL77mGrg0Cp8GBkrLyFTVN5OP5m5us2SqpCt8U1aciL6ZFheVwfoT+bUqSo
 nGOvXWjkvQzgPajIyBMZUVk09Rx4Id+chq1eeiPbf+3TZjpOyA3nABevyT5ujuTb9d1ESLjTDW6
 /8wF5TWaaD7curzjam67BZn21YqPK+ifxilgEZIDxALrxPii/2j/LLq41+t1T2ZhKEt9ivKXbTm
 U2XmDzE3HSZ4OGC3gUyPk+rPmKIDzqzl0Y0yAW7sdNWK3ACFhw2aKF/tPRPtfiZw562DCiWdL7/
 FrvWEnAtfofkceLnRqHHIUiDiBB93Ibw7LTUHvhhn/Ml9sFjF+4kdN1bRd1zos/S+tHHPr7nHw9
 58BeFQe7FC+4tEW29MxwI2W80pWL3FY8z/ZRfYIGoPNZOD+o53Ap3/MetsJxtcErSRUas=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Adding Hector's patch since mine depends on it; please let me know if
a different approach to sending this would have been preferred.

Thanks for the prompt reviews!

Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
Changes in v5:
- Use unsigned int consistently (as vm.max_map_count is unsigned)
- Link to v4: https://lore.kernel.org/qemu-devel/20261014-set-default-pool-size-v4-0-a3aff89b94f0@canonical.com

Changes in v4:
- Return DEFAULT_MAX_MAP_COUNT from get_max_map_count
- Link to v3: https://lore.kernel.org/qemu-devel/20261013-set-default-pool-size-v3-0-d36e8c31f9a6@canonical.com

Changes in v3:
- Use Daniel's suggested implementation
- Clarified comments to drop "LSM"
- #define DEFAULT_MAX_MAP_COUNT
- Link to v2: https://lore.kernel.org/qemu-devel/20261013-set-default-pool-size-v2-0-f4fd6f2a3303@canonical.com

Changes in v2:
- Rebase on Hector's patch
- Link to v1: https://lore.kernel.org/qemu-devel/20261013-set-default-pool-size-v1-1-7be19402af6c@canonical.com

---
Hector Cao (1):
      util/coroutine: trim sysctl's max_map_count newline before parsing

Wesley Hershberger (1):
      util/coroutine: Reduce default idle pool max size

 util/qemu-coroutine.c | 73 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 25 deletions(-)
---
base-commit: a19f59a72d96056d9a8f48cf6c77f5787491e414
change-id: 20261013-set-default-pool-size-8b27c0fca8e3

Best regards,
-- 
Wesley Hershberger <wesley.hershberger@canonical.com>


