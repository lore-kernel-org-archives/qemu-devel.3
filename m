Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5853DC4452D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmRZ9-0005kx-3J; Wed, 22 Jul 2026 03:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wmRYq-0005St-OA
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 03:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wmRYp-0000gN-0o
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 03:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784706010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pwr0pISNDb4yeSQL7FH7IcMqN/+xkS+lxwmUQY3lcXo=;
 b=eCMEi40z+HJkV4uD4ILWgmA2uHL2NULyZgYRukPsV7BfWgIvM+hFG5S0CxWJ1hrGSIB8gq
 /KZ1KW20KKQD+uye9i3Vp1xe6ciEZG3iNpBCoNTaeR2AtYZ7IG+59j+w1iwo0QvHz+hk2r
 EDRO404D6wO6zDoiK9C4GNwSQOYq1IU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-BWBG4z2CMQKV-ld8QoayWg-1; Wed, 22 Jul 2026 03:40:08 -0400
X-MC-Unique: BWBG4z2CMQKV-ld8QoayWg-1
X-Mimecast-MFC-AGG-ID: BWBG4z2CMQKV-ld8QoayWg_1784706007
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49560dddaa4so14465595e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 00:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784706007; x=1785310807; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pwr0pISNDb4yeSQL7FH7IcMqN/+xkS+lxwmUQY3lcXo=;
 b=bFgb+tTNQEnoRBttLAxCFgtl5gDu5sAQqy654R8LcYDeEj9R+80FD3lEcZF0Sd8pmF
 xpd0FeROrvQ80XygYUeAChD0yVrJrl4UBscBZt5J6HrWLtCkXf0+RtDlmCT+NgyhSwco
 iFOjGj9OgmiwNMHvB0g2nl9WTNgwH28IjTrMU8uH2ATUBDAORDR+6TdvgnoM8TqIrFOX
 07y5BJe0tkqbvM4McHSPB+KeOUhSAT8b3IFueBeWTsy64e7PWdPAzv4c8Ic+KfrLU85q
 lS00TYqIFTJxL3bJ2A8DIuoe5TJnLxLXZi9D36nBuzi2prqXf5LVJUNrzcVpbuwd1un0
 5Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706007; x=1785310807;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pwr0pISNDb4yeSQL7FH7IcMqN/+xkS+lxwmUQY3lcXo=;
 b=KcQtbDEBW08R6T9wLe+3rWYHv1AogK7I29rdTZFZ9WUMRfPSPUEUOpXXIx5If1rZUS
 YHTmli2j8CiZw/UcClE0dL9n72m8qpHNStajZRx9lXCszIU1WMecLFd1pP2Ai8h3iOcf
 csv4OltGd9vxa1jmeJuox6sIABcxMbHNyYCZuqsuKfo4dJ0Kzos1v8uEpnW+0CC3daM3
 /ML+OD1okY8CUd1rPHTu7eLH0WapfmNB+YmDxOClmMtHNyE7B0CGEdYXorHHZFTHLE+U
 BDqQyMOyNZRjxAnrqVtGSWsbO5W2PQH04l1qvo3JB2gmvlRLm11cc1akCdEBVNikG25F
 oAaw==
X-Gm-Message-State: AOJu0YwtDleUtXQ49R+JwzHPqq+P2cOZZy35pYMNtu7ksxklnxOy6M2E
 HdwbebWMlEkxuvVXiA7OfaFoatuaNAQPCnrHxDa5BvaUwZ6QMUGx1Zm+UdD454xsyJYL+BZDoks
 H8PB/33OqBBcnRopyd9La/TKNdKY3YbZ2ncG8HdFC6W23JMRQcXRVkMXdSFD2LZDbCDRWRVxkQM
 swYOcpR6Ct+qctmr46aKkzRPUvIkWjBSzoLCArjARw
X-Gm-Gg: AR+sD10IMOQzWh73HF0zvFQ+urwxQDouZlKvaxNYBFS0aangImarS8qKaibotoCi0QT
 Y2zStXGSbcxUaUGRXR4XYdw2JpUh9+ZrqKH+UMYkOTgfa0Y4V9i7VKzO63eRFr0q5uuNBkIVdsh
 M95EHYRjmfXKYIzGBQPbE0I2QOO4c+dDjHCO0v+xMowMzIxIKfMcJdyAeU8fS6Stbd0kko14+5+
 hcAB3sYvk4rWHMSRErZQLAl3WY2RkyQly3HFNRKhQ4beYGYQUqpValK1END6wv/eB6PD2N7M4Xa
 IJubfZWhEE1oKPPdP285V6NukRbDrf2HG8aAxaeT3+n85k1RWIO2lJ8/6pff2N+3xuhrS4KnXBb
 JP4ZfzO0dpaTJgDKKk3R1Q2pCTSMdMQPRAOgFr9A8sCMe/jODCso3xDBi1M1IDKxTgxaMspjaf9
 W5pWqP
X-Received: by 2002:a05:600c:3b0e:b0:495:6bc9:62b0 with SMTP id
 5b1f17b1804b1-4956bf8631bmr11907515e9.17.1784706007309; 
 Wed, 22 Jul 2026 00:40:07 -0700 (PDT)
X-Received: by 2002:a05:600c:3b0e:b0:495:6bc9:62b0 with SMTP id
 5b1f17b1804b1-4956bf8631bmr11907135e9.17.1784706006889; 
 Wed, 22 Jul 2026 00:40:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b01a758sm40274325e9.4.2026.07.22.00.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:40:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 5/5] scsi-disk: fix off by one in assertion
Date: Wed, 22 Jul 2026 09:39:43 +0200
Message-ID: <20260722073943.396872-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722073943.396872-1-pbonzini@redhat.com>
References: <20260722073943.396872-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=pbonzini@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

When documenting the invariant that mode pages need to fit the smallest
output buffer of all callers (which is SCSI_MAX_MODE_LEN), the expression
used by the assertion was incorrect.

Even though SCSI_MAX_MODE_LEN is indeed 256, using "length < 256" had
two issues: 1) it used the wrong operator, since "length < ..." is more
related to having room for extra data; 2) it missed the extra two bytes
for page number and length.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 85d0bd0b811..1b0cce128c5 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1321,7 +1321,7 @@ static int mode_sense_page(SCSIDiskState *s, int page, uint8_t **p_outbuf,
         return -1;
     }
 
-    assert(length < 256);
+    assert(length + 2 <= SCSI_MAX_MODE_LEN);
     (*p_outbuf)[0] = page;
     (*p_outbuf)[1] = length;
     *p_outbuf += length + 2;
-- 
2.55.0


