Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D43DC44500
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viglv-0007j2-My; Wed, 21 Jan 2026 17:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viglu-0007iD-8q
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vigls-0003i9-QY
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769034832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WGRYLYJGZZIVkaUOB+J/cgVl22pX3OXzem58+/XJpsQ=;
 b=gKV3v61phv+CikoZ9NLxldfM2ndVIg4QoPegi0ytiZzCkfgTqgweTcT/j43MXcAWodaFio
 HBP7YWmgdxoKjJP1zE7GFntsOCBs0pbxtNhF4UKhWeM+B6uQDlRmZxqf2F3wBELfkPYWNE
 AzK0LHBXd4AE9TA1WeImX7gfjIpih98=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-Rp8ueTAXMhuHoqv5e7cTmw-1; Wed, 21 Jan 2026 17:33:50 -0500
X-MC-Unique: Rp8ueTAXMhuHoqv5e7cTmw-1
X-Mimecast-MFC-AGG-ID: Rp8ueTAXMhuHoqv5e7cTmw_1769034830
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8bb9f029f31so135917285a.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 14:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769034830; x=1769639630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WGRYLYJGZZIVkaUOB+J/cgVl22pX3OXzem58+/XJpsQ=;
 b=cnWGLqMmsc9dixq3dF5rz73c1AuVezYPwHw1pvF2oYVN2/ie5Urs1OHhLgw9BkrKUF
 NKn+X0nbD3tNHvRBZRL7fyFmFb48J8JlX4m6m/Oe6Gk7mvBH2YMwMTuDkGCWcfwe81+N
 4LChmwQl4s62sDhT2RfTW1qXaWCp8FrQB3RG0y+HbjkieD7IRstiXbOWIeh9keKZJy/6
 YxRsfiQV/ETCyc2eSyaEUf4Hmrr/6FPBIrkowaDnfC5FNFNm0bAsfxmvUd81wY+Tl0Hx
 rCagywHWD5rI9T7O6GAjHfSzy2+/GoTgtg6OqvLxw1VgqaFyCJKzbKu3S56AmvNbmn6n
 6GVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769034830; x=1769639630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WGRYLYJGZZIVkaUOB+J/cgVl22pX3OXzem58+/XJpsQ=;
 b=AwVHww0TMXXOkc0H6b3bbRuGsjXA+LQTD+Dm4ZO1j2eNsM/XwZuEtJ6WfnJRokXWyS
 WUvTsiY/uOhqMgcBkFRdJRZx9ldBI67hq33EsWbB5WRA9+KWSh18eaZF+swI67Spw8Fp
 QoQLsTuoTqCmjfqmh7nmrOloppowTtNunSBjUfOA2FrErIoxTWTbX/kv+9i/GHAJHZIO
 vGhjdyM6dsSqv6GJ17n2la66t8JCg6aZifdzbi4sGj9X5Eqj1p92oOVyX0zGBPWcDoSb
 FR+baBnF4TeY32tdeEGo9eIu/2SIPZsBCaACSuJO3pYtSpvH8sX890Gi84dcHkjomLDj
 bt8w==
X-Gm-Message-State: AOJu0YxYNq0aKb/baI2PUZixwMVAu3RpSdXVGfsEWJwPL7XABSHk5LiW
 /UoBuANBb1yupi3ooT8oooYpNwlMnb11fSogad7dAK0Yf9h5GIRvscWKbJkUFjE7YFmvdwXI5g2
 QWCP9cDrxOH6bEhJp8Smnv4czgi9k6KLwlBqNqThb0aGxOCaokZuApYWJLzQ2QGjqP95KfnZMMk
 Sq9bb0FgPyNQjd48gdAZRvs9rR9W5SE7XwPV/wzQ==
X-Gm-Gg: AZuq6aKFulNbQOiqYNadYkl7M9O35GoJL1hcwaeevv8d9ip2GGLU9LgY3kImceTQjnY
 iWo+2rVvJsZannOjKzJOw/VfvoTh39NtuQij4UxLQOI+UzMQUV//fdN9tADO/LyTGp95wHFESwv
 CAvIabP17nun9OY9DUNEWckERfXZzLymBHbeyh+ElSOkAE3EEb68x0ivOZIUqDFe1TijAZdPs+c
 IqAFuvTdYcXPGMswpHI7uDGMvdlZRKlH0VN48PGz6d9HObXOE0VGJSYCfVj4Yr91VZHq6el7u19
 5in8oVNRmqqSyCV9PYmzvIPhFYnI2kPkDrElEP3HrR4qdd2TZcCEED//VcvuZMA996zyyN3Ef5K
 q
X-Received: by 2002:a05:620a:4116:b0:8c0:cec4:b6fa with SMTP id
 af79cd13be357-8c6cce50011mr860303485a.65.1769034829713; 
 Wed, 21 Jan 2026 14:33:49 -0800 (PST)
X-Received: by 2002:a05:620a:4116:b0:8c0:cec4:b6fa with SMTP id
 af79cd13be357-8c6cce50011mr860300885a.65.1769034829285; 
 Wed, 21 Jan 2026 14:33:49 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89470b0ac3fsm25598306d6.25.2026.01.21.14.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:33:48 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 07/10] colo: Forbid VM resume during checkpointing
Date: Wed, 21 Jan 2026 17:33:32 -0500
Message-ID: <20260121223336.3381912-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121223336.3381912-1-peterx@redhat.com>
References: <20260121223336.3381912-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

COLO will stop the VM during each checkpoint on either PVM or SVM.

Accidentally resuming the VM during the window might be fatal because it
may cause the RAM and devices state to misalign, corrupting the checkpoint.

Hence forbid VM resume during the process.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor/qmp-cmds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 1ca44fbd72..0c409c27dc 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -84,6 +84,9 @@ void qmp_cont(Error **errp)
     } else if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
         error_setg(errp, "Migration is not finalized yet");
         return;
+    } else if (runstate_check(RUN_STATE_COLO)) {
+        error_setg(errp, "COLO checkpoint in progress");
+        return;
     }
 
     for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
-- 
2.50.1


