Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CA2C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4oeQ-0005gO-TA; Thu, 10 Sep 2026 19:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lX0-0006dY-RZ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWh-0004Rp-Od
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P/dt9G1EklZEpM1Y9s4cFZiMEKzuwD4r1pjdVZY4uXc=;
 b=D7O9GGQGMWUmnABpNt1Thng0A71krWYM7y5Lxf/o4cxbIn/2iEq0fjGR41S8hudZvA7J51
 6XtDTPrtc3tLxD39i9Nz/eszziLN46qVaNLUxQGJAgiiItG5/V+HKQyZFEwiqqjpuEOTAW
 mY7kO6eONbHH+DLubjVrhhGdlaOdaOk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-UEXuqf0fNRKEs0cwut_nHA-1; Thu, 10 Sep 2026 16:11:30 -0400
X-MC-Unique: UEXuqf0fNRKEs0cwut_nHA-1
X-Mimecast-MFC-AGG-ID: UEXuqf0fNRKEs0cwut_nHA_1789071089
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b667b38b04so303881e87.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071089; x=1789675889; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P/dt9G1EklZEpM1Y9s4cFZiMEKzuwD4r1pjdVZY4uXc=;
 b=VfoR9VIoTcVahXoA/YVfZXHipLMgEZHwVfp2irdfKS0ff+wcsVnxPUAxAR5iHX7FOV
 UKTYQQX5W1CdWnxhc0lAreAuVGtLsU2ASCOVpc+CFR9EPySmOH9TQidK/uv+vFCv+W/u
 Jhc0OwOcEeCsuCftxP52inO5ZR6Atm8llz8cmxepYIPQSOZu1gFYvB6FKWglzGMdefwz
 GSwQAHISFAhoHRX1YW2c3Ccfmks9jqX3h15dAkloVJku0iwxRA+6fyNmvsVWvC8oURRq
 H8kDRhtNU8mKMtfddZYxCLaRdDh+GfY+hNA7JBSF+XDzQUqq0MXJS8QzE8fhP3sCD751
 Z9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071089; x=1789675889;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P/dt9G1EklZEpM1Y9s4cFZiMEKzuwD4r1pjdVZY4uXc=;
 b=DQo6sSQSgNnZLVHMn3zR+yMsBCYAqvDR2/3/P4riL+GZ4FPs7DKZBO8gchuCu0VFRR
 pf/wnZ79g+xt4qmDAwv10ZJlotlV5bpq96QJU0LRTyAEsr6w2BPCEUL/VcgCzYaMv4ZC
 LwF9KGpbRFgrIaaHGo5srHmxLEDsKVCZpzEVe27a7Dkn3MwSfJ0LCwtyu8U8P35768Eh
 HtzsLNbS1sIS6CM/UarGEq3A7cgD9cC+rUfYJWb6uYl7nuvfCv8H8v83x/i39ab/4iEz
 3Fgwp26iV7qWEs0NmJroNgtibCpy5XKKYRS31wcgj/C1R28Ja4kfKXKhz/67JZN5FXns
 2QGA==
X-Gm-Message-State: AFuF++kgcOV5PnGh2elrLbXn0R0aIB/ixsj91DxOmTKflPeILHx5qqP2
 E7hEkOJtX5SnSNmrV8p/NvVcElfN/SqSdx9+7EmIWdxYx+Ta/0Hf+WPOhsgGI3Dfx5TZ/3zlC7J
 fwWa3zQ66T7kcmR3m9nsOrR4H3bIDYDRMwmaiz/ABnRS64JMrzC+qn84BjL13dUSesW0Xb46Fpz
 v3jJ1OHqSjI7W8LshSOxHwm9CrsDBg2frLgQ==
X-Gm-Gg: AYBFou13T6Ew7Q1ng/NnaNuZ+IBsPhELPZZP53VBlCbaGu8Mq7EEQzTk4hF0fnCtQdT
 E/tV94e1xHqDrpAqIz+GtemZiB5+ZK9eHFUGvrecNLwRhkAg738/J65K8RTfd+HchZ80qBmtC1z
 ASzFBb9YFTyaHNKfTbX2oyRBWOYoGMH4Q1Gw4BXhqLfiSesHBAn+NDlRhMiMYvNJqua9G/tpD/l
 wzfg6Mt2HNpdECpzyJzss3GhOKQCszonK2SwAIId6DhHOLR1CvHE3c2Mam5JXDTKabbFdJ/6fJm
 mOSVQNSYpcjKAb3p0AXV4mZbm7jdfByZ6iHR8RBVX9j1+FWUYxH5o6w5XgfriWTCgNW0MLQPPBj
 o4tijR04OAwtNub2FJjxH+x4=
X-Received: by 2002:a05:6512:1296:b0:5b6:183c:5ca2 with SMTP id
 2adb3069b0e04-5b8a032db71mr187416e87.64.1789071088633; 
 Thu, 10 Sep 2026 13:11:28 -0700 (PDT)
X-Received: by 2002:a05:6512:1296:b0:5b6:183c:5ca2 with SMTP id
 2adb3069b0e04-5b8a032db71mr187405e87.64.1789071088087; 
 Thu, 10 Sep 2026 13:11:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a03a76a6sm115004e87.9.2026.09.10.13.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:11:27 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PULL 02/90] virtio: fix config_len DoS in migration restore path
Message-ID: <2b35ded9c235145cfb31a8553b29e6faf65899fb.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

virtio_load() reads config_len from the migration stream into a local
int32_t variable and then, if the incoming length exceeds the device's
own config size, skips the surplus one byte at a time in a loop.  Two
defects in this loop allow a malicious or truncated migration stream to
cause a prolonged CPU spin on the destination QEMU.

First, the local variable is int32_t while vdev->config_len is size_t.
The C standard converts the signed operand to the unsigned type for the
comparison, so any value with the high bit set becomes a very large
size_t that exceeds the device config length.  The loop then counts the
signed counter down through all negative values and back around,
effectively running for up to 2^32 iterations.

Second, once the file stream reaches EOF, qemu_get_byte() returns 0
without advancing the read position.  Without a check for file errors,
the loop spins until the counter reaches the device config length.  An
attacker who sends a large config_len and then closes the stream can
hold the destination QEMU busy for attacker-controlled time.

Change the local config_len to uint32_t so that the comparison with
size_t is unsigned and values with the high bit set are treated as
large-but-finite skip counts.  In addition, check qemu_file_get_error()
after each byte read and return failure immediately when the stream
signals EOF or an I/O error.

Fixes: 2f5732e964 ("Allow mismatched virtio config-len")
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3891
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 34f1df260b..848fe8539e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3584,6 +3584,9 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
             return -1;
         }
         qemu_get_byte(f);
+        if (qemu_file_get_error(f)) {
+            return -1;
+        }
         config_len--;
     }
 
-- 
MST


