Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78561CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxY7-0001w0-1A; Tue, 09 Jun 2026 10:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxY5-0001op-Aw
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxY3-0006wy-OA
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781015723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bCFdaleLAqFZOybhIPB+08n2Tsh51f2ld96XW2TReag=;
 b=IgbSDBqA62bZttnCLdVgnmofy1UfTRj9tN31VTjr0nznVOar+0iJxQK378O5E7tnv5IYWj
 VplQhuPtIjf20gII0hqGs4a1mKzrF/qc+7UuJK6nLRn6s0h7CXe5mnGBBz/POlnfMAjKky
 ZGFcWs4FBsPLsac+/Qco1RFxpm9ATwc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-6R9tz2XiMOKb52SludvxSQ-1; Tue,
 09 Jun 2026 10:35:21 -0400
X-MC-Unique: 6R9tz2XiMOKb52SludvxSQ-1
X-Mimecast-MFC-AGG-ID: 6R9tz2XiMOKb52SludvxSQ_1781015719
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76B16195DE7D; Tue,  9 Jun 2026 14:35:19 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A20D18005B7; Tue,  9 Jun 2026 14:35:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 09 Jun 2026 18:34:26 +0400
Subject: [PATCH 07/17] ui/input: remove double-notification on qemu_mouse_set()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-ui-input-v1-7-42615deb818e@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
In-Reply-To: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=500;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QKTfJXkiYTlclQdjxc806Ee/VaUL+ZAjxSUBDEqQqXU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKCR3mFtqJcuLcmlomiZ03NnbUcVvRKL7E4tQG
 WOpdW2SFKeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaigkdwAKCRDa6OEJdZac
 5YHZD/9usdAuvBf0SHd+QiEFdBIONLZnzC6EXPU3HcQ7yNEiL5jwSiF/i8DTnF08Gkh4Vdm34aQ
 eWEkXpgmWQbCp/flfJp16vDKb6DP12QB68dTeWKFtwASrblGk4KxhcXx7+FhD8yQNWUsjeF1chS
 dWfGtLpIbu7QXDn0CUOTVZk5EJYZYnjPQRnRchuq9X75kdPXVAT6+mwvz0/LM+DSOzT86JZvzIg
 FaQECKhy8ZdrymYnctIBpD9c6ACxQthHqT53Zkt6t8pPrPEeZdEuHw1mZerSNTOYbVtB8Hml1Pn
 8FcB4hmXq9doyI1rb2xK33Bj51kd/uI77dVxvx0V+xYuNNeszZ36c0AqtNQh7gU5Vd1/mJz/r+v
 7olNfjISHWZB8+vvlzTzZEHm6HvSMG1s9231d+VR7DkS8KC9IUVt4ufmSvSTQ7Ws0RV+HrkUXgC
 TxV4yGsBt7WHSAFZ+z9C/D+QYWHT/ltCIbINGsomT6MEXnkQS26kd+XQgdhl/BVwio+nzKVSEBt
 9fwuJyCr4yDuCWIOmBp11RTqej7HI5XcsGYzR5PtgjiyQbKPIUzkF6/uffYtLbZm6uwrPmBIZj1
 oWXWBoYseLFq8sl/mzhWiDBqv5efJNifT9gzWKliF4f0gL0Ra/Kgv5uNo452B6sFxwCIWYUBcIh
 LAm4i81TqXy4LJg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

qemu_input_handler_activate() already notifies.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/input.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/input.c b/ui/input.c
index 55769c66fcc..15affeabf44 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -580,7 +580,6 @@ bool qemu_mouse_set(int index, Error **errp)
     }
 
     qemu_input_handler_activate(s);
-    notifier_list_notify(&mouse_mode_notifiers, NULL);
     return true;
 }
 

-- 
2.54.0


