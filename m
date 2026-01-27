Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E1CD2FED2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCj-0004yu-W7; Tue, 27 Jan 2026 13:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBf-00035Q-CI
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBd-0000k7-OS
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0U/KC4mRCm94WnZf9o8vD7nPLPznEjZNoKjE7aKYY3o=;
 b=BtOcWeVQ42WYFMT9lKPfgCE9N9QA0UQiAac241SapyDCu6Kt/e0968l57+TcQHcOWuQ2ht
 j3BaHWnYL+81lj6M5i1yZ6WWmQNj56/nzhD2jKwIKXNt6xZKrBM3MtZ8P81yvR5JMl6L8M
 KBJ9NXc+3PvYlk1TyGyPfbvhSMWLo1c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-Yvnh7MxmMeKLaMDL2rcjVA-1; Tue, 27 Jan 2026 13:53:11 -0500
X-MC-Unique: Yvnh7MxmMeKLaMDL2rcjVA-1
X-Mimecast-MFC-AGG-ID: Yvnh7MxmMeKLaMDL2rcjVA_1769539991
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c52fd4cca2so1897544285a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539991; x=1770144791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0U/KC4mRCm94WnZf9o8vD7nPLPznEjZNoKjE7aKYY3o=;
 b=tAPWo7+aK3JBxpF159+6RIQdakrKQMWshbYh2hvE97BPwlUPmalNc+W/QXuNpozkaG
 Em+mLvxvrVtEMQqMisdX97j0iGL5opJLbRGm+pOmRqlN+8hkN9BRXOvT7ZGgYbW4ERtj
 5tGbgjvSvkgdwXNIuT0m6lSHKeCu5N7BmG4tAv0SSMdi7ftnyyBG0D3cQtusomcJL1ba
 w/KA3YJdKPdImSXUfKIsEgwejdKMAqcS53KS216E5oPB0ShsSFay9/V6AsxuKUrtTJ6J
 b+cQ3WX5+CZMuytFyXgfZD1VWmI18+k/y/Uc3z67opYiTepnQ1TbsbkX/yTvmsxggUAn
 Rsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539991; x=1770144791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0U/KC4mRCm94WnZf9o8vD7nPLPznEjZNoKjE7aKYY3o=;
 b=dKYe6UU+nYj1VUXuPWnADPrwww5J2LB4NluTGqg4U88LxilRTHoAA1O2nxfOHov0Yq
 z+j51RnMhi9l3dYyMlw13IiIbDWFJWdKVYlO/xuqeUAfJKSwuUjMUoOhSSb3IROUQ9oK
 BLP6GVzrsIDU2m4rCOM1chc5HYbxnVL4EcPQAg1qaaXZnqOIJ+fc2tCaADEBzrJM6JFh
 oGGD1VCvnkDo38Wfy6rv9IOH2bc/rG0itHi2EDd45cwrV+bXD/3IZK9CvcqZ13MuTH0o
 ffnN6bg6l8w++BBwj3hPR6YKR+PudS6rH8ewzCrwkM8lqJ9SCs+57bh+3Om8Zy2G+ciw
 Tt6Q==
X-Gm-Message-State: AOJu0YxBDRiHBOASJZ7EvzubYacoYV1lDdQewmk6D8MMjeDLvEF6R02i
 ixrzkSSKjHJ8DXz3HXpsujUYq8rFDLm1kVwm0Dh7q4OB4x4o5O//+9QSfIuJGw+scMx4CQv/Kb7
 PzLhExxoHo72AR48dJfZ6CuoIG8d3y72HjT4IDMb0ZPTce3CHduxkYAsq0o4VwWVGQRHSivXk4X
 n7FiZcRCDgmBGTsBc4RootK5tDPzDoHxiLgtlefA==
X-Gm-Gg: AZuq6aIFb0+c+qRaq3mgoTvz5FpbwSN4yStY5x34sx2s3pTRHSwHOhsqwyMos01YRS1
 IesIe2lwmuQ+Ovz3Gj5YCnC4Opo7RWf6QOslBMUxle4yToXWpAuw/PhsmJOXz/ZeoH8+T+Injx9
 WequoJiX0YqRgXGWaKJi6sve6Vw5nazLDdqfKwxglxyAtAs/2IhUkF3TbPbzPxUor3QoWZ8hJOZ
 dnhhU150BbpmDo0Fmlg4NNfMuc1Ed8Jv5MmVEXC39fazTyH+i7MtUt6BUazgYmZvHReKwFpt9Qz
 nJu3IWP7oSUDhyDi2oRSqz0PK3DTAaR9bLg7Nhwx5jZg7yYIwMqiQFvsrySBA2dmqHKiRzPm8dr
 Z
X-Received: by 2002:a05:620a:390f:b0:8c6:d949:1d8a with SMTP id
 af79cd13be357-8c70b84a786mr338900585a.6.1769539990597; 
 Tue, 27 Jan 2026 10:53:10 -0800 (PST)
X-Received: by 2002:a05:620a:390f:b0:8c6:d949:1d8a with SMTP id
 af79cd13be357-8c70b84a786mr338896985a.6.1769539990111; 
 Tue, 27 Jan 2026 10:53:10 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:09 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 12/24] migration/colo: Send device states without copying
 buffer
Date: Tue, 27 Jan 2026 13:52:42 -0500
Message-ID: <20260127185254.3954634-13-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

We can safely use the async version of put buffer here because the qemufile
will be flushed right away.

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/colo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/colo.c b/migration/colo.c
index 1b94e0f0ee..0b1a58cd8f 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -486,7 +486,8 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
         goto out;
     }
 
-    qemu_put_buffer(s->to_dst_file, bioc->data, bioc->usage);
+    /* We can use async put because flush happens right away */
+    qemu_put_buffer_async(s->to_dst_file, bioc->data, bioc->usage, false);
     ret = qemu_fflush(s->to_dst_file);
     if (ret < 0) {
         goto out;
-- 
2.50.1


