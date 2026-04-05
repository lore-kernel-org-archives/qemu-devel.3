Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1D1E9D80A
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 15:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9PMu-0006jf-MM; Sun, 05 Apr 2026 11:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w9PMs-0006j2-Vf
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 11:26:31 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w9PMr-0008RY-7s
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 11:26:30 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-823c56765fdso1556098b3a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 08:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775402787; x=1776007587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fEjJ0vYqH3FMuiZ8Ejies3mW8gSGC9QDtmSx0t1VKas=;
 b=LIDe4ew+kacVV6uWxSrCWQCdOwsWIdf62t0PVeLE/7+jrV6h9T8l6ODLJgOMtYH7aM
 mrvGdWoGpBkMDU06Yz99QjWBcBqPqpo3yc6k4n0KJWQ83Y+O3CIbCdwIBnzznRV9Rizq
 jSs8RONmxyoScKlmGNOd71fz+hrBzYDA/mFEE6NMQhixRGK95YzDv+hT7Nn9FOb5WV48
 VxVzx+55tUfIws0W1OmeRfXBesNhpIYB/brN34gWz6alQbZyDObs3nChJ5bCDRYsD3Nj
 wytvp8wDxqZ2ZTVGDctSnMg5uNgLkxv2Qe0Rq0ldMan9WJwNJNlhnmimHQB+097zQFos
 fszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775402787; x=1776007587;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fEjJ0vYqH3FMuiZ8Ejies3mW8gSGC9QDtmSx0t1VKas=;
 b=G90SSs6bT5FTTcTLm0wNb++kjGOfIY3hZD05mPBn9KptQq6SJXAhSTCfymyfva0rgX
 Zhtmt0PQQjbQVy27iSyxnhO42NhwZtq81/fvaFFcJgI/1+7FWzCDZufd8hAsbL16aom/
 F8X5YyemeVVW6K5kvZ5SY+f2vgX+xpMDaUd8ra13VRTmqn58Z4ozOE+K6MAXJxEZwrGz
 I+iDs+UPIuN1wVIneaZxuDSGO//ixA0/w2a2eo6TtXEBOKSiTIV/KiNP8dRTtRJPmCmb
 2oTPklWF7mx2VS6uMRgZs1OL7ljyH6H4WWSwEwd7iO5FQ6Zs5zk9cjC8UdR9+aDS18rJ
 /73A==
X-Gm-Message-State: AOJu0YzQ5iKg2QOYZh1oGZpOelrBXEdQPpqus8vmU+cSbb997Mn3JKVj
 2jNN27iRIDipHlZjTdU3FFmp+Pss1JIIB4WPx1z4GtKS6YtBfEvlFZhj49XCS+M9Bnw=
X-Gm-Gg: AeBDietquNycqf5pLgjv8EmtAu1wdu/UqPAWLqGt1uPLddpj2vOhzcHjSSBhz4m5NVo
 292KLaV/mQyUXlsA/plkeVnFCU1d7MMUYvftn7X9096+WmSeASPeXRYOh7JaWaiBaRJ9jPj1lOj
 P659rqi53TZMZlYvBAceO8vCdMSuJz29GVruU/GbmzqJvviDlKI81B6b0ahWKQEW6eN5JnJ8QSy
 /c5a+Gwx4SqHPrSgckabvLevve8VuB7BkwIWh03OBgcrpYyYZo3X5Q6krqoQ9eoGY5xDPrwNpvt
 g+GTmKoM9512mefF5v2SG8afj2tmLyZjOOwoVBQ49M/5axmE+hVuvN05nCGVc9qJvimoHOvNHE+
 GwUdrtv6OXLn0CmYb4N5N6GKuy+30jtyuFONgMl1f3fMtOfQh9ZS2FT3e9cGdpjk1SvsGEX8Usi
 EowfdyGZN30DfEpHLHY+foT3TcSfv97qnDIYv9wKs8FLwHKLU=
X-Received: by 2002:a05:6a00:a0b:b0:829:8942:2c93 with SMTP id
 d2e1a72fcca58-82d0da45d60mr9016305b3a.9.1775402787245; 
 Sun, 05 Apr 2026 08:26:27 -0700 (PDT)
Received: from localhost.localdomain ([123.19.199.205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c72967sm11187938b3a.49.2026.04.05.08.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 08:26:26 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [PATCH 0/2] migration: include timing and RAM stats on destination
 when query-migrate
Date: Sun,  5 Apr 2026 22:26:06 +0700
Message-ID: <20260405152612.93027-1-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=vikingtc4@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Trieu Huynh <vikingtc4@gmail.com>

When query-migrate is called on the *destination* QEMU after a precopy
migration completes it returns only {"status": "completed"} — no timing,
no RAM statistics.  The source correctly returns total-time, downtime,
setup-time, and full ram stats.

This series fixes the gap in two commits:

* commit 1: Track start/end timestamps and per-page-type counters in
  MigrationIncomingState, recorded in the receive path.

* commit 2: Make source-only MigrationStats fields optional in the QAPI
  schema so the destination can populate info->ram with only the fields
  that are meaningful on the receive side.  Fields computed from tracked
  counters (transferred, normal, duplicate, mbps, pages-per-second) are
  shown; source-only fields (dirty-sync-count, precopy-bytes, etc.) are
  absent.

The QAPI change (commit 2) is ABI-compatible: optional fields that are
not set are simply absent from the output.  Source-side callers are
unaffected because populate_ram_info() sets all optional fields via
has_* setters, so the source output is identical to before.

On dst, {"execute":"query-migrate"}
* As-is:
{
    "return": {
        "status": "completed"
}
* To-be:
{
    "return": {
        "status": "completed",
        "total-time": 94,
        "ram": {
            "total": 554508288,
            "pages-per-second": 1440234,
            "page-size": 4096,
            "remaining": 0,
            "mbps": 97.955404255319152,
            "transferred": 1150976,
            "duplicate": 135101,
            "normal-bytes": 1150976,
            "normal": 281
        }
    }
}

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3151

Trieu Huynh (2):
  migration: track timing and received pages in MigrationIncomingState
  migration: expose RAM stats and timing on destination via
    query-migrate

 migration/migration.c | 37 +++++++++++++++++++++++++++++++++++++
 migration/migration.h | 17 +++++++++++++++++
 migration/ram.c       |  3 +++
 qapi/migration.json   | 14 +++++++-------
 4 files changed, 64 insertions(+), 7 deletions(-)

-- 
2.43.0


