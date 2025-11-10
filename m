Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60CFCCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU9X-0007WO-6E; Mon, 10 Nov 2025 10:50:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9N-00079O-F6
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9M-00012n-18
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OqSM+dsvZXQykYJy5mQtdb8MApZH6DwF1cy9voui00c=;
 b=O3rZydZZim3mM/gtnh3/PRkUnSk2b78Zvn+bm3SLT3lWgX9d54/uSgGR6y2qN7uxbqg/tW
 f+2iRBbl8vz7F4AMixz5rpdlX+ro9o3gqebGbN+ANK/KLuqAFEiEbm7aAGJIB94nnw5Uej
 s773jzjjgWOYNwW7a62mSg649gfdecY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-8TAaWoohNp-MwO56TyED5g-1; Mon, 10 Nov 2025 10:49:44 -0500
X-MC-Unique: 8TAaWoohNp-MwO56TyED5g-1
X-Mimecast-MFC-AGG-ID: 8TAaWoohNp-MwO56TyED5g_1762789783
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4776079ada3so27928885e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789783; x=1763394583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqSM+dsvZXQykYJy5mQtdb8MApZH6DwF1cy9voui00c=;
 b=FGveysU9jLhHQDkmZeH7whiNIhq+k3VsB+T8AY4WDJ7EcP9f1Tosal/cIcOhfrGbRu
 P+VRWbcFtX9SkM0D0jpzcm+kmNCU9xa5a+pN3CzexrZiexw22ynEaMfsQw7u/WD4Qqm7
 zYePPNznyKe9kd1ufVhHhVKkgTNOrpY5CQ0r+OcRB1JARdljK0IUeusXdQgW3gB4rHRA
 z/xavleZjdgEnCcFi0A3eDRFHpqa2f6FVCdq6YAgXrFui/SPdbV6qk8fyBvNiwq64Izm
 PbxXAQcFolydwY/GIgLinRWV179VvMHa03hjDbMmwTjsfl+bJaPD2qpYRzWysUb7Atv7
 iUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789783; x=1763394583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OqSM+dsvZXQykYJy5mQtdb8MApZH6DwF1cy9voui00c=;
 b=Zb1N6akExNxlpsUCiS+d79TxLT/zqJunajG/9oSB6xZx9z235tUJs4wjyfQORlZAqE
 R6aytA+5JfBUc5Iie3P+qfqqKiWEPJBZrq9kIpFVYqDhTLd12DT8/fEHY6FfrNZSn/RY
 IOe9ZAxjwPRmm8MUh5XHGnuX99/v+MclatT9oiu4Zkl5c+06BuchekUMlFny93vx9hNH
 aPVfFWCKECIuCtMxdEGXRs8KJoy0rvn1nn3wg3Po4udgjochddB1BOqVcGFPB+BiJOsa
 QU7vr8CyXkEfQQuPZduorPrktNhSRXKy3uW1b4uJnYEL81TSf75onXaKs/mRBZ+B9MvT
 MWyA==
X-Gm-Message-State: AOJu0Yy8I3BDGTuFASmkzjGdjwPOoNol2wZfrG+pKyANClEavwkXAuXl
 OWSfU1lwPs8VA1hS4mRYqmFHOMHpl2ko6Cux2nuBH2+ElsS1TL8JHnb1XwzMITIX1VshVNCxS0g
 nxFStrklkOWcS1/dRuseayvjZv/ztIaEaC9826mdN5ZJGvmdaiE91d+BP
X-Gm-Gg: ASbGncsJAjEg87hpJg6sOW0tlGh7BNaRMEroUDDyz71Wdlpfoyk/pcELJNC2qw3+cDO
 29bNVV38BpAkOP67Ffg7sYLkHIuI7BA1i6YowUYTjwYwDnzYjqJ1ZajHMJupJhWgsEkhqcMgeTJ
 4XQbtbItbFVopcHY8XGdYL09O9XKPj5R1qL6FLvolbK130mhJgReqoceGNvReoI8SKRakLn053e
 yt+0PKnjUf079EG9jlu17X9EmXbugJKYKEokaD0+2O9ipSK5TMj/3EUwkfkIsM1iYyKkcFyx/1d
 WukiXTZac5aLqBo56WC/zFSA3rMdoOAPaXLUKULVeymV2E4qwM7AaJianizYrE7j/7ocMdLueMX
 U+JqIH4gCX9ozT+YwPW9FU4N1c0B7TpdTa5BdDB9MAPtRZkgy5gNVPN6blA==
X-Received: by 2002:a05:600c:190d:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-47779c78b39mr53508915e9.30.1762789782915; 
 Mon, 10 Nov 2025 07:49:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt1YxYwg76iKXDrdcv89UqTKluLoQacPtKwgvQ545WvmCgRkSi7Q3yxgEFjIoxtvkSWRSKQw==
X-Received: by 2002:a05:600c:190d:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-47779c78b39mr53508685e9.30.1762789782414; 
 Mon, 10 Nov 2025 07:49:42 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4777bbb8cf3sm29825355e9.15.2025.11.10.07.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:40 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH v2 13/19] qcow2: Schedule cache-clean-timer in realtime
Date: Mon, 10 Nov 2025 16:48:48 +0100
Message-ID: <20251110154854.151484-14-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

There is no reason why the cache cleaning timer should run in virtual
time, run it in realtime instead.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index ecff3bed0e..d13cb9b42a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -846,7 +846,7 @@ static void coroutine_fn cache_clean_timer(void *opaque)
 
     while (wait_ns > 0) {
         qemu_co_sleep_ns_wakeable(&s->cache_clean_timer_wake,
-                                  QEMU_CLOCK_VIRTUAL, wait_ns);
+                                  QEMU_CLOCK_REALTIME, wait_ns);
 
         WITH_QEMU_LOCK_GUARD(&s->lock) {
             if (s->cache_clean_interval > 0) {
-- 
2.51.1


