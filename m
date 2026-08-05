Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659FFC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraDz-0004tO-59; Wed, 05 Aug 2026 07:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraDx-0004qO-Ok
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:55:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraDw-0007id-Ak
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0JOWpxgYHVraQyk7JyYhUXwt3gc/+3Ds3TfPwVGKtY=;
 b=XNWHhSCmEJX2Tmqfia+UHs4l2v8UP92jTyHlt65c/wsf8hsoYEjTXss30ExUvYMvMPoq5f
 DXAErnNu6beB/A30Dy+s0j6nEJAGzUBSs0n6qcMWfVOt1Jvn/QbDqo9tobNzHVBhqmVkLv
 LhRj1w1WCV3p2n9MCJ7wD7Q+3vv4Mi8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-kA3r6nWBMRyvnLTvTcg7_A-1; Wed,
 05 Aug 2026 07:55:50 -0400
X-MC-Unique: kA3r6nWBMRyvnLTvTcg7_A-1
X-Mimecast-MFC-AGG-ID: kA3r6nWBMRyvnLTvTcg7_A_1785930949
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93BD21800471
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:55:49 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65E36195DF92; Wed,  5 Aug 2026 11:55:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:51:17 +0400
Subject: [PATCH 27/27] hw/usb/ccid-card-emulated: free libcacard context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-27-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=857;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0u/9EGX/TshoNoHcdDiBVT0hKpwYKdo8Nl67CxZjKuY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOwVJ2mMrF5uaWhgyNISQ00j3Nme4cpbRp1g
 hAUdiWSUtCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjsAAKCRDa6OEJdZac
 5SMJD/98UxtuDZhzm+EIb83okk+oIJuf/7Kcr2kueInmBZFkHxattA+j4QL0EDoKYy5Opj5KHQP
 stLzIbf2v/tySbpIoZpwRiOxZYI082gpbmIebihchnYWFiv++cFGHtWtHQwkd0hOkyyIYtKhPyh
 Y21I/nhzgy6Uy1n1J7wzkdBHxvepy40MzTRBLFgJf2VDC0FQUZjz078jus2LiZZSUAgafFi8BF7
 UFQ9ZE1abAW9XYM+srcnYIFKWPxcZJNege18tTDeAkB2IAk0tbK/RT+1wXdLsaoxKaNgcteXzTc
 pJ5ljaO72pdvgFELwLbFedo6hqR9fvQHL+q4vJS2Se6SaqwvUfW0IeJ/NqkI+L0Ln//Q1Yuj/MT
 tJ6SdmvjkoSWTE/2p+WI9paHFUPuxL2wo5MdXGPjyaCdYfnCPoA/ikZdlkaOs6ryW6LNuPBDuSP
 M4dE+VmqdWPGu+KjYoyLbMcuLfg6ljv6WgP95lQwLB88umSSehKOIqS6m6sS0vaPUU1qUzsX/Ho
 x2I/UXLVKu8fBMBDG1QD8Dl6gDceMBYwGoVkflQfmEgmlmLVBDZPhcPcu1ge/t5m7pz1n6mNRm+
 x/RP80Pgth4abD7pkLJNStdM+YWEu8v2Txu3Iq5uUTN5ndTV05yd0+mvsB6VuEs9P6vywF7Et46
 tVKoMN3gKCe7L5w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

libcacard uses a global context, but we can call finalize since
vcard_emul_init() would have failed earlier if a second card context was
used.

This fixes libtss2-fapi leaks spotted by ASAN.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/ccid-card-emulated.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 985f21997aa8..6c8eec39faa9 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -580,6 +580,8 @@ static void emulated_unrealize(CCIDCardState *base)
     qemu_mutex_destroy(&card->handle_apdu_mutex);
     qemu_mutex_destroy(&card->vreader_mutex);
     qemu_mutex_destroy(&card->event_list_mutex);
+
+    vcard_emul_finalize();
 }
 
 static const Property emulated_card_properties[] = {

-- 
2.55.0


