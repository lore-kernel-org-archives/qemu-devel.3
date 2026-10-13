Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386C0CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGeNA-0005Ty-QF; Tue, 13 Oct 2026 11:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xGeN9-0005Sb-1Z
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:24:59 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xGeN6-0001va-RR
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:24:58 -0400
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C9C9A3F5AF
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791905094;
 bh=6jiNeAliYafa4bUs0pjZT8uFVXO/wLtW5yB9yhn8PPQ=;
 h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc;
 b=n/dxbnnKOAxFFoHHHlVobOYVSt26TVszgegE0ePAYhS7L4Y+AOfbJsKxAjMrTZ5UU
 FLfJCNbYCW+E9ExlQiujg2ihRSBWBpGAg1wODZr9H2lsdE74f4M2Vix9YAQXJunQyw
 Oc+brMh8VGJcSM+iLbZ55ALOtJHvPBXW8TF1gAN2RzaHoBQEngAagaFqLmX40PdhE2
 PubhY8nGhZRpuY1trhfTwDvE8ubnZDJECurz591Q4IE97xPlXB1+9Ip1204gXKK5Yj
 ogYUQdYX/86sT/zZopu3hIC1A6zof59xmhONxx/KClYy6+vfeWtvcF4k8e/rnXFkCo
 OX2zOJpLTMr674oSN2wig9vz7CH4lT6wz5pN4Iv6V1Ll6k7krlBWGs43soySyCCv+N
 jS198L+BYsI2Jz3PXBRRIdE8gTWH+ZD/OQG2TaKLTkkw6IofhWhSyYDbflV8vG1u6D
 UD3HSz67al8Je64NgZEhBiaFH5r3RavNwQThFNkwbw8UsATiK/Mu/r91CSPsy9S2sI
 GKqURF74R+QTnxLwMCpMydPjkVHHmG/YN07dh1p7fSfVtmtbXX3NHykMS3eIkHjN/w
 iIbHOwG/kZS5N9WybnsgZhf3oXS1Gg8GHVJUZsN0cMTcNCJFzObhqY4UK4UM2U++qW
 7bsiobuu58M7r+i2NKysjUMY=
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b0ab72a6e8so21160097b3.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791905093; x=1792509893;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6jiNeAliYafa4bUs0pjZT8uFVXO/wLtW5yB9yhn8PPQ=;
 b=Xy/mTFZT23pdxXHkr5BZHdzBAwgb90YYK0p1fKtsrAjExxwao/n1CycLThTkU8ZuT8
 BmKjCrvoMkPz1iK4+pQ8ZLCTDPCEkTVrqklAbykkbv6WzG8KBi4JdpcvMxxJaXMt3Ayb
 Xkh2zydLE0FSlSkMeW0pJnAI/ZbGjrbfOxIZbROmLSzzAcS3jmy/lt/k4a7OyLzX3H2m
 G5v5aE6lid59/4Rp2N78JP7OXHkDEt/Pw5zv6K04u2qmkki0uOy2WGKgFlfzgzJN2rVF
 iRi6wU9w9NV63fAdhvaxr0igfebNeeWmLN49wGzaYEIflAkhkabbG53L48abSsIuHp9h
 7FFQ==
X-Gm-Message-State: AFq9FYI+ijRJNr16utXa4qkcd2SiO1j+BrfA7f5R5qioJnqMPUIA/3/n
 fEoWg3nObkoeDF+IEi37Mx47VOkDHkqCOsFHGMXcmijccg8rCm67g0zT9EVmBBaVPqX0N5pKVfL
 4HuLHG9YVUiN0pijjOeY3JEERnznNdb7Iusrb1qtNIDK6Xc7A1pFz4+X3pSsCjVZAf5tR/oq6
X-Gm-Gg: AYBFou3S8e8Wd7laHOPmlYByD/i6ZwrLyNgXnXxZrHF6AY6T1ZiJzwIkSxNJTHGnJE5
 t8gfYjXyXN1AEMZyZM9ffTfbRmLmAnvIdvmC2fsNPnhKLKnu+RNj0Nnzp97mLwSMK/5oQUGM2Qp
 laWn16uPERTwZPTJHGAdJK5KHL/Du3tBRpgU6qDn4iS8Vkt8WMNgfptdO1Xb2L8jIVNonwsb7wS
 V3m5enT2+00qvD1JKEgNEUULwSAKJVE7JR5Gt0ANi9LHJXHlxSqNIUma46yG8AoUuHwviZucXHF
 KwlW7atiADdAH26zPSKRAf+KshJbPL9EeKJrDKnS9+QcaWV5Ji+rojl9ge7rzo1dCd6oOzbwYDM
 GvrW2bpULfA4+GNjJWiees2Kl82qKgpA+AGzXu9EbGoIdcg==
X-Received: by 2002:a05:690c:e1d9:10b0:8ae:dfee:cd30 with SMTP id
 00721157ae682-8b07ee80677mr32226517b3.56.1791905093120; 
 Tue, 13 Oct 2026 08:24:53 -0700 (PDT)
X-Received: by 2002:a05:690c:e1d9:10b0:8ae:dfee:cd30 with SMTP id
 00721157ae682-8b07ee80677mr32226377b3.56.1791905092639; 
 Tue, 13 Oct 2026 08:24:52 -0700 (PDT)
Received: from [127.0.1.1] ([97.87.60.46]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b07ee8603fsm47203617b3.4.2026.10.13.08.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:24:52 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Subject: [PATCH v2 0/2] util/coroutine: Reduce default idle pool max size
Date: Tue, 13 Oct 2026 10:21:57 -0500
Message-Id: <20261013-set-default-pool-size-v2-0-f4fd6f2a3303@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7Zi2GEBX3sOwKMNUJsGWtEhUw
 t2tXMDle8l/f4XEUTjBpVgh8iJJgs9gDgXQYP2dUfrMYJSptNIlJp6xZ2ef44xTCCMm+TA2nal
 JObINl5C3U2Qnr717azMPkuYQ3/vNon/2X3HRqLHuWJ9PylhX0ZWsD17IjkcKD2i3bfsCI9dDh
 74AAAA=
X-Change-ID: 20261013-set-default-pool-size-8b27c0fca8e3
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hector Cao <hector.cao@canonical.com>, 
 Wesley Hershberger <wesley.hershberger@canonical.com>, 
 alex.ramirez@canonical.com, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=985;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=mDL9GCPRQPEirMsTYd9ZFnXZh6IABrb63axVsVjs2EM=;
 b=kA0DAAoB+SiArOI6HbkByyZiAGrOTUKg6JTfKN8tBEDJcor8rJ0BLJkiJmjzi9XxFAx2cUPWd
 okBswQAAQoAHRYhBCwgfEUvCl6HERtDyvkogKziOh25BQJqzk1CAAoJEPkogKziOh251fEMAIwA
 KaqBSuL/B3+kTyJ65FgrnGo/I31pcN5PojZ169NHbZXPnS7M7am0WADMTkip+LXi9uhQizB5orl
 7zC73UnNRjBxmCSKd0MHKbu9B/ogkvO0nfDfWUs2/on2N4jr43ie6x5ju3AruHfdEVHDs4012jG
 esecFbjwJ/CbN34vMb5uXmX7c3NbYSLVnkOtXUbkg/sH+IDCuTbvhYI50O8KOraOfwFqQvfRDKX
 62CoEh/57lyD463Rita0PaCln9SxMP60pLgI0Hj6mkLboT+/w2vdBB4tQWlUTrhw9tN4sawUzuV
 wvICP00YDn9CpeoLAMsmYk34R4owJO4N30bgpnBGs0yEmV/HIrTFy9+Ra6HO51gney0UX+RYHe8
 vM0COQaNk2Um1W5KBieQwMDr7tD3Mke0jGCZ5e78oDmgqBSkHpUDFgY1Npc3LmaB2D3qqoyiXAk
 fXFb+GGQYxhZgRR/d1koIJewa0YIGCDy/dIVEn52OjUrrqv9WWq/SHsRs/UA==
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

Apologies for submitting twice.

Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
Changes in v2:
- Rebase on Hector's patch
- Link to v1: https://lore.kernel.org/qemu-devel/20261013-set-default-pool-size-v1-1-7be19402af6c@canonical.com

To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>

---
Hector Cao (1):
      util/coroutine: trim sysctl's max_map_count newline before parsing

Wesley Hershberger (1):
      util/coroutine: Reduce default idle pool max size

 util/qemu-coroutine.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)
---
base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
change-id: 20261013-set-default-pool-size-8b27c0fca8e3

Best regards,
-- 
Wesley Hershberger <wesley.hershberger@canonical.com>


