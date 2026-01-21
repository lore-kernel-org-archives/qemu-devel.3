Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929C1C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vigls-0007ge-6r; Wed, 21 Jan 2026 17:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viglr-0007gL-7g
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viglp-0003hd-Pd
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769034829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mLN37lJdAgxBE/XKVFsvnOge/dkSRkaPBYJX0ABeB10=;
 b=SpB6XW+gn1UVldfJWYEpM4+ohQbc/nCTww2XOMlF99osrOM/We+Ac1bfzmGAY7/DWRH0s9
 3kXXMhMRg32VxMcAAq7roFY6mlQJwZqxlkgYtUvBDw6qla72at10HcksLmHcvjYezvbpF8
 K3MtZfTC4DfireW/pCXi423o7DteCT8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-gyhcylW5Nu6JDTvQ_BT0QA-1; Wed, 21 Jan 2026 17:33:45 -0500
X-MC-Unique: gyhcylW5Nu6JDTvQ_BT0QA-1
X-Mimecast-MFC-AGG-ID: gyhcylW5Nu6JDTvQ_BT0QA_1769034825
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c6d9111960so78627185a.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 14:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769034825; x=1769639625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLN37lJdAgxBE/XKVFsvnOge/dkSRkaPBYJX0ABeB10=;
 b=aZaH59qBYLaKUgfK7DcLX+5/cazgXRXlLVw/Ka6GM1NedXUcFTX2m3LidUZCdyc2F3
 qgLhEQxitdVDvpelISngp8QQNEtfpe0splnetTsaGeyqNS9lSqxswMP+K+rhrOoqt8qK
 fAOPGUbyGE3A9vZ/wVsOvraKosSE+nOIklBo1A0BLj12GaaklgUpRRv494BBSKjuCYrr
 JBhstju8sl3C3ipaS8BCgG3xn7vmofb2zwtJS8GTHWR4YS4JFUqiU/uHhDZT3LV2RB75
 /21VzfZ7GJ0IhGjhk+umjy37fuwM9smjLC0o8iomCdAQ+2sNf8ATWnoYAgr/i4BADoUX
 EXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769034825; x=1769639625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mLN37lJdAgxBE/XKVFsvnOge/dkSRkaPBYJX0ABeB10=;
 b=dOZc9FusKXnd6PmW2oLWmp2RhcAvMKLBmWE4Y6Lo7y46JNFM45urnvzWLqVkLLZW+j
 hVvBqklJTFmLH1+CWCEmu7fmhIxZ4H9scL5ed+ALx2F/NIzrPKUwaW6v5VEOExb0DCLi
 /AMq8OO+MPntFQluT2Xo+mze9kCCAsrs6eUsTJYP2WYYYV5LA004auiG8A+9YXPuCtsO
 eaHUR+010pfhDqa/aHA+4HZ1qVeATj1cnsV8MhuiihbLK25Apqwl/yA9MDt8XI3jexeL
 rQV4CPGgJuF8QZY/cFEFSs6Cuv5gLoWmY4+bxXSqzCsDU1pgF3guC49+xb0X6HWcidwu
 prJA==
X-Gm-Message-State: AOJu0YwE7LfgFi+Vf/rwt0ek53HFfXnFIwC3AynS+9O/+uBQjZnIXfSB
 IimQvGSzrtmCeLBY+8LZF9SE8dOt+xIFAaKgyg70itbToK1RixDN0emImPsFBm0HRVJOdpg7Jsc
 vcNfSboAe+35U6kbcuoCgRjwu7PRtpo4xPueN21IRD2lK2W/YUY4A4xMzYp9oA3SWrbtSBvrX+K
 4LGcaQeHVDQVvuzEwbdx3oDOFsv45tQbbHMHh1RQ==
X-Gm-Gg: AZuq6aJlvQpO/Ob/vNJ7i5jF1G5pg+tEWR2Po45JoNXCR5coHwkT5s3J4MBqtZxROXh
 HdQ8gq95Mw5WkEg5UlwYY/h12nzukTmw5aKOZkUPGpXtfdTP8ZRF9tKlf9Iv/bEKE9BAnSjNFpq
 v08vZ6vhnzimZpJlq/Bt/N8EZpMmqMJZYorml2eh5hop+TbzIZtUYkw5t3h8CUYJ97g3Qr2vVhL
 BFCeqe6nTDf2smop/9m0TGL0ttq+5cCPcOEmE/VUnLQcEaYH5AwCkTCdnIbRVmRkuBJD08xruVM
 XsO7fs2H3ZzcEeeAwJeE8VGwiBPoQbVpnqA9ESiAT35YV30rKEsWQ69JNgOPTC1oK5NVLwqmuTh
 g
X-Received: by 2002:a05:620a:4627:b0:8c6:253d:5187 with SMTP id
 af79cd13be357-8c6a68bd2a5mr2523061485a.11.1769034824597; 
 Wed, 21 Jan 2026 14:33:44 -0800 (PST)
X-Received: by 2002:a05:620a:4627:b0:8c6:253d:5187 with SMTP id
 af79cd13be357-8c6a68bd2a5mr2523057685a.11.1769034824095; 
 Wed, 21 Jan 2026 14:33:44 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89470b0ac3fsm25598306d6.25.2026.01.21.14.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:33:43 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 03/10] migration: Remove one migration_in_colo_state()
 occurance
Date: Wed, 21 Jan 2026 17:33:28 -0500
Message-ID: <20260121223336.3381912-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121223336.3381912-1-peterx@redhat.com>
References: <20260121223336.3381912-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Move the send header operation directly into Xen's QMP command, as COLO
doesn't need it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 64bf445c98..61e873d90c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1871,9 +1871,6 @@ int qemu_save_device_state(QEMUFile *f)
     Error *local_err = NULL;
     SaveStateEntry *se;
 
-    if (!migration_in_colo_state()) {
-        qemu_savevm_send_header(f);
-    }
     cpu_synchronize_all_states();
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
@@ -3335,6 +3332,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
     qio_channel_set_name(QIO_CHANNEL(ioc), "migration-xen-save-state");
     f = qemu_file_new_output(QIO_CHANNEL(ioc));
     object_unref(OBJECT(ioc));
+    qemu_savevm_send_header(f);
     ret = qemu_save_device_state(f);
     if (ret < 0 || qemu_fclose(f) < 0) {
         error_setg(errp, "saving Xen device state failed");
-- 
2.50.1


