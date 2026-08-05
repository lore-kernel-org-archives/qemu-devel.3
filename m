Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B09CC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraDG-0002Py-QL; Wed, 05 Aug 2026 07:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraD2-0002BJ-9g
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraCz-0007TE-Ex
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPLRNUH3dnEf5lNfRacEvCQIA+98SFfajwR+vJmGBo8=;
 b=bVANjffwZvhPiRnFTfju4YW2k9l2UuWK/rvq/Af0LSweIztKrZ9qC26c7byQEQFJi5rkj3
 rMjrrsginggclBowYZfBSc96ZerzmhF2oTlSTbxYZGzf5CiDD7qdGVkr6YxkR4T+5n0Qg4
 62aw0JEeuT2oIECmJ4yXpfB5UQpws4s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-sWFNEG8HPoOQyRUN2k7HMQ-1; Wed,
 05 Aug 2026 07:54:51 -0400
X-MC-Unique: sWFNEG8HPoOQyRUN2k7HMQ-1
X-Mimecast-MFC-AGG-ID: sWFNEG8HPoOQyRUN2k7HMQ_1785930891
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E454619560B4
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:54:50 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86D3718005A7; Wed,  5 Aug 2026 11:54:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:51:11 +0400
Subject: [PATCH 21/27] hw/usb/dev-smartcard-reader: report error on
 XfrBlock with no card
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-21-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1185;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=P3Zq+m9aEcCUmGiVB/yrql1wtSwwsWyAhXTfhnoK90U=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOuaDZKNmDX6WeupqPbGV+90AwJetBsFU/Uh
 E53NS48x8CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrgAKCRDa6OEJdZac
 5WPXD/9um1Ru1DjXBWFgjOYRXFqQOpdA73EFBBT91SF0n/QlyvhuRHixOzLBeI1XCxlmd5Ztptx
 MQ04NYTu5RyKz2eKlDi3jUIGQ9CNtTSROIgTUzeiTGglBK4ha+zvpeJIHjikrw9jqzFFIl91dvn
 5rR6K+8PNi0cv3dJCf+JGuvryeDcjx9xdfkcpj++qApPAdaj/aOmaQF8gJYH45NZ8M8ADqZelvF
 4L7/+UYXk2b+V40hf/IHtqgcEUIxRoZhWIC9qgDqF7pY/tyzNyN9fI2Pf6V6FETguXyhMpf79yT
 4vEbIoz/PEMSixzqwbwzh3rpN+Lfj8ST7I107+QFltfzViFcPu/a1UlXkgXu+B8iTETuT2e/y7t
 xQZV8iE13j92XgBPHuI/JspwpbUq7HAdzFrC4lsKVpTYzhhoQksTibfKAjaYvkwP6/2QrdfU8zI
 TbBJ5IyhmLs3Vklr4sPzy65Do3dOgXc7P8BCdy5lHHRZjKs9FEDzd8wY/I+UtFYRRZj7QwsnQzw
 JK+bGufB6XM50IzHyjxH7FszWQ4uwkgqflx9etIDFvjvZyduBhI1eqfsi/aDtNbYCaTkThMK9l4
 6gNaGBggiFqK3DS/LhLYvDlRY7C9hiyuxrKoKkItJOfl6PbdkBygQOYDXHrB2amZ992hAvpAQfK
 kGfSQApsHkCFkrw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

ccid_on_apdu_from_guest() returns an empty DataBlock when no card is
active, but without first setting failed command status. This makes
bStatus report success and leaves bError unset, violating CCID Rev 1.1
section 6.1.4 which requires failed status with ICC_MUTE.

Call ccid_report_error_failed() with ERROR_ICC_MUTE before queuing the
response, matching the existing pattern in the slot-busy error path.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 208a14dbd1b3..65ceed57541a 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1046,6 +1046,7 @@ static void ccid_on_apdu_from_guest(USBCCIDState *s, CCID_XferBlock *recv)
     if (ccid_card_status(s) != ICC_STATUS_PRESENT_ACTIVE) {
         DPRINTF(s, 1,
                 "usb-ccid: not sending apdu to client, no card connected\n");
+        ccid_report_error_failed(s, ERROR_ICC_MUTE);
         ccid_write_data_block_error(s, recv->hdr.bSlot, recv->hdr.bSeq);
         return;
     }

-- 
2.55.0


