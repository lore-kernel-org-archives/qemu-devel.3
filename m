Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7FFCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ6b-0006zT-0H; Thu, 15 Oct 2026 06:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ6W-0006lt-Ss
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ6U-00080B-IB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxr0z/y4/tXxPDnG01KOZoiuFmwPosLlrBpWrd5hotg=;
 b=FfNWpeTIkyCV03vMdkCxVWynuzyIqsYvMK5+lnVdiK2FUHqK7ASTVgpMxlaPHv02CZfN9H
 3GnndX/vuVgOawLsB3fDgZ/NsDjLhJ1tUNwVZF1Adcs4mJKlP3N8/Y02d0OJEVJKgFEsiV
 aj+koTa1wf5fopYHYZ4BN97JX4Tib2Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-Arf7_9fnPSyZYYrrDhilpw-1; Thu, 15 Oct 2026 10:54:28 +0000
X-MC-Unique: Arf7_9fnPSyZYYrrDhilpw-1
X-Mimecast-MFC-AGG-ID: Arf7_9fnPSyZYYrrDhilpw_1792061667
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-486f9d150c3so3233532f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792061667; x=1792666467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hxr0z/y4/tXxPDnG01KOZoiuFmwPosLlrBpWrd5hotg=;
 b=l9qOqDKI46/scH35o1phaP8d79OTzOHjAwcCDhlDMVCejsLl6mP51hpMWz9qE5es2b
 KXw6HgpWrjN2fEb7IRusPBejvavYEOwrI9sNfpPm8sO6FuF1Q7Q1CNSFH/Gt79z6Lpzb
 3HtSl283uc5UjyjTGmmprfA55holtHWpkCX7cbGT2KPCQGXNFgDx+xSQOfyMsj7Drfu9
 Pt7TTkeNCYmwWn/I3k6GdyjBb9C6i108Xn3yTZ6KJ0cSQi3F8+rSLpEVKEtyWRwkXjTK
 I6aEGn4uyyLwN00B09N489LUIUpfNTC4s4VjDnZJYNJlVZW6X19hCFJ7bjPk8tHVQor9
 k4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061667; x=1792666467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hxr0z/y4/tXxPDnG01KOZoiuFmwPosLlrBpWrd5hotg=;
 b=M/3AVQ59BKkmQT57CesHtmAKmaRtpBFqAVqiQ04MHFOHfMbFyh2UsLAmI+TQleDCIQ
 ZLxpVE86+QELHbl2LdFbQ1NGVJ9b6fz/d/atwWqiKuFo45AfqSrxSoApjOsDoL9i4KFX
 FKpqXIFJ7aFS1hDu3jb8D/9gxr5lQvNfwSHpRyV9FwlCmRmIchayrob1l+DjwLppq7KH
 bbCuuqqVjNybjLj1YfuHhHz07cp/dc23XKNnyAq2HW1tNsjtYa4DDFGNQabHt6XnwvSJ
 +4ATbJYyUf2vWiAR4KjIMyAw0dQyAQcCE9u+q0ERx+cVdiT9FZvRN5y+hAotkrMb5ZXR
 rSPQ==
X-Gm-Message-State: AFq9FYKnQ3VOsT/QU2K732XnmNN6c3suLKtpKjWLJ+SyoUhrl7BFN4YD
 MMb46qGpS/IE2+UDjB4qXQXe24iS5svcBT7K84tmAZBPX1V/KeOWenOD56xFo0AtMf6zGp0lZik
 YWPtbCTh147GafH8Msgc6GxSsel1zknPZgXYrDZQhiQsJBeokXxE6gxxCZlo4KOy7FBFfaEaj1x
 VM/il9dcHr2UKA2z3jD7WH4PSvYsL5TT69o6MWdDdt
X-Gm-Gg: AYBFou0BpuORr15eW/QyeBgwF+CvOyi5bd/zn9iYLngkszs2cVStYl9CWVv0XxuvJZy
 oKpH8sKJnIh+GF25gRKM/bStyUBDfzAvn8lOXxXCiZ6KY1fMIHcckIfuUYTO87I74XAzTOvCuDL
 SCvQpxabovsQ09QKDaTWQb8k+DkfVrt3Q8owAWpPGILr+SOHMTE078QnXqVlIOXM1Wvc5o+994h
 5DmTEFL6iJoeFPIUTHiaDAKyUbtQu8ncfW83s5YYIaen1Y5F6FGT9SN95RzCUjvU4lhSWfw36I0
 1NRNxmBsUrZS8VZiL/nbfRV+H4WA1iDH+si03Bak1X7bMf/28tw1V4xph3wC5xVuWWt+D1Bj4Me
 MC3e/6NP/GvhSbSsCxWHZwDU64XYmJepkbB8SZ0Fg5W1d5O3/ocSvo0XPqn8Vb8LwWZpzZZECeb
 Z+qQsb
X-Received: by 2002:adf:e185:0:b0:48d:f56d:be56 with SMTP id
 ffacd0b85a97d-48df56dc2c4mr3669252f8f.13.1792061667028; 
 Thu, 15 Oct 2026 03:54:27 -0700 (PDT)
X-Received: by 2002:adf:e185:0:b0:48d:f56d:be56 with SMTP id
 ffacd0b85a97d-48df56dc2c4mr3669207f8f.13.1792061666621; 
 Thu, 15 Oct 2026 03:54:26 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de72c7e36sm12025282f8f.37.2026.10.15.03.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:54:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 05/13] pr-manager-helper: fix sense buffer overflow
Date: Thu, 15 Oct 2026 12:53:39 +0200
Message-ID: <20261015105347.827029-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015105347.827029-1-pbonzini@redhat.com>
References: <20261015105347.827029-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

scsi_build_sense() assumes the sense buffer is SCSI_SENSE_LEN (18) bytes
long, so the caller's buffer with an arbitrary size cannot be used. Use
our own sense buffer (resp.sense) as an intermediate buffer and honor
the caller's sense buffer size (io_hdr->mx_sb_len).

This is triggered when scsi-generic.c:scsi_SG_IO() calls blk_ioctl()
with an 8-byte sense buffer. There does not appear to be a way for the
guest to trigger this buffer overflow directly since
SCSIRequest->sense[] is 252 bytes long.

Fixes: 9bad2a6b9d0a ("scsi: add persistent reservation manager using qemu-pr-helper")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Link: https://lore.kernel.org/r/20261013181752.1299456-2-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/pr-manager-helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 53432e6d606..26ef3876f0e 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -234,10 +234,11 @@ static int pr_manager_helper_run(PRManager *p,
 
 out:
     if (ret < 0) {
-        int sense_len = scsi_build_sense(io_hdr->sbp,
+        int sense_len = scsi_build_sense(resp.sense,
                                          SENSE_CODE(LUN_COMM_FAILURE));
         io_hdr->driver_status = SG_ERR_DRIVER_SENSE;
         io_hdr->sb_len_wr = MIN(io_hdr->mx_sb_len, sense_len);
+        memcpy(io_hdr->sbp, resp.sense, io_hdr->sb_len_wr);
         io_hdr->status = CHECK_CONDITION;
     }
     qemu_mutex_unlock(&pr_mgr->lock);
-- 
2.56.0


