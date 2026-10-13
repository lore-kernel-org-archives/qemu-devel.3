Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9386CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXP-0005q8-O8; Tue, 13 Oct 2026 09:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVp-0003Qg-8z
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVn-00052X-KW
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FuULZ0tHNbXqq2KnmmAatRNalvsJcZ8lkD3Kp0kGWXk=;
 b=PnaopPuxSNDxQlOgKRjPcsyz0hqx+EhDPLo6XVhJ1fiURDGlL5badyJgPipcOvDGAMnBrj
 z1xkwu9Qf3VOWRU3z1lbcN7g5o2undJGiX/XXtAtovkSIuUUX72sTusui6qsVHAoH+DyGe
 eXmQHRamoRy2wYSTfhwQ92hU9Bcl45Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-8n036u3INjquxcW-417juQ-1; Tue,
 13 Oct 2026 13:25:43 +0000
X-MC-Unique: 8n036u3INjquxcW-417juQ-1
X-Mimecast-MFC-AGG-ID: 8n036u3INjquxcW-417juQ_1791897942
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9118195C25A; Tue, 13 Oct 2026 13:25:42 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1E031800446; Tue, 13 Oct 2026 13:25:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:36 +0400
Subject: [GIT PULL 39/40] chardev/char-udp: clarify read_poll return value
 with pending data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-39-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=909;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UPhdr7DlrEuGI73JlZ9pXaSyaJRxsDVn2DWzJ24aOmw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDEb9EX+bVhBsPvKWQ6zG5BwZcnK1yV5iO33
 R7oH0liH2CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wxAAKCRDa6OEJdZac
 5ftQD/0Ta6Jbv5kvCaiQx5WaoEck4eybnaBOLn7ruYFjydzpwBKhUMSrtLSKVKU0tq7qn92VEML
 vPDCK8EtpAxUx6VRKR4DLHS9VDseaBrLhd4tfBkin7w7bSLcrNIt7QQ7pNZYUf5l9mCErLvq5Px
 XN1mvptH09JnEvUNX0Uth4eIEO7ApjlMK31MvVys4WLOkOpY3+/8JAOKGuXgiPM4gkNdZceAsDK
 fgOj+DkzzwYCRVtgQ0HjLPqMUXVBP+cgXOs6YJGGkD1XfB7IOHUOrPQR0dvOqOoz7SbHEJYYpFs
 7nrC9ac/OGDzaxRz+6Dt2Jbf9oltpyQflJ1v1p3ito69VRSaNGe130r0F/F9CaSgbmKMnlfgkoV
 /QVjKOasqL52xzmXYYRVxgWGzEbWXpwUSPAdPgf1/WdXg5vdyz20g6fQYZlLcRqWiKxDnW2qZxc
 Lnxd7ZgMpNCkLwTARvK5dxPe0Df67Qr6Nxyxz7wGGe/Jv3j/xyFP6ZsYo7xUCUD41DNflQUpGGn
 UeefCfusXOuhPaCjyD060fT+nhIqFjhEeZdKZYwY25nKwFbxzFJ8BNaFOlJtgzjXTVqKFd7mTsn
 7cjiwzA6k1mTaenWXCISmAuQX860Q7Fk+ykL7KgfHeLW2xHvOJYqXb9PIaQd7AaSBE/z+m3eVpo
 zDULagM8OMREKrw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Add a comment explaining why returning s->max_size is safe when
there is unflushed data in the buffer: udp_chr_flush_buffer()
loops while max_size > 0, so max_size is guaranteed to be 0 when
pending data remains.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-22-ccbef537cbeb@redhat.com>
---
 chardev/char-udp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 423000832ffb..618fd8f135a0 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -81,6 +81,10 @@ static int udp_chr_read_poll(void *opaque)
      */
     udp_chr_flush_buffer(s);
 
+    /*
+     * udp_chr_flush_buffer() loops while max_size > 0 && bufptr < bufcnt,
+     * so when pending data remains it must be because max_size hit 0.
+     */
     return s->max_size;
 }
 

-- 
2.56.0.116.g6de20f6092dc


