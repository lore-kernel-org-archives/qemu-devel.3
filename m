Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FB8C5DF88
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8zZ-0000GB-I6; Thu, 20 Aug 2026 16:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8zY-0000BI-Hm
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8zW-0005KO-VL
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787256238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+XNk5dkobl6PxGlqJ+6K5lMIdMtBGjNOVaSzcufEeas=;
 b=Qc1SWzOM8Ix0E6wDhx5oRsaDA95BuDZ56u5uOdHVBSACMt9a+Xiey+VRdUIKEwJI4ohXCF
 P6/yl5OVt2dn37MYziqI+YAzrU8nvksQLTHb9pW5D4NaUbiAKGVhZZbiR1IaV3nJZWdnvw
 Z8emYGdDsZOWybA62jOJYDB2PYgvou4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-qHzI7NWQPjq1GJyRix1yjg-1; Thu, 20 Aug 2026 16:03:56 -0400
X-MC-Unique: qHzI7NWQPjq1GJyRix1yjg-1
X-Mimecast-MFC-AGG-ID: qHzI7NWQPjq1GJyRix1yjg_1787256236
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6b1000e2b5eso143946eaf.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787256236; x=1787861036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+XNk5dkobl6PxGlqJ+6K5lMIdMtBGjNOVaSzcufEeas=;
 b=JzHWTDJLjmXQ+yg0qifK2/J0Yusz+yAlbONQE85BhZLDdv5HJcOY2Eakn79KjtJZ5N
 DbgQ20z//jOX75Z8xztMK9YQq0/T/C2q9u6+aF54buA8wDQucHB38fNxYY4aej1NLUyK
 fI7k3jfsY6JcmYnDBkR2tCNMl0cVOrVL+WN8v/ssFrW0LkLPNCzMO42vhd6daiMeqi95
 yUQtbMwWLW8NIP/yPIyNYBwwZUMJd5ckF6yHABBA6l6qsBd+0XrhVibOlzIo6Q7EKv9y
 CyRTMXyPGtlUbU+Tr+Z1EX1FJJVtidAS2WsTkVdzFjf/GzXxUiqGQkds1Gb1e61ELeLo
 12GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256236; x=1787861036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+XNk5dkobl6PxGlqJ+6K5lMIdMtBGjNOVaSzcufEeas=;
 b=QM1hbAEcMcDrlAV+92du0HSt7U704YxmHIkL4OfjMSH901hbgBfrs5vKGJ7tQg2blL
 n/mMnpjvZ5OJh8d+kZsVT+EzbtSAGMkaZM7u7bk0S/bAq2ILJl3goceCUEEvqpAAonqo
 00I8+irXvdF/JtjoyPqj/oPMcwuKpWYK56SdryLs7gUE905DafefA7fF2WCY9HnW0GQW
 28Y7fco0sKKLZskovL2MaoHutoObawI6SsvOOBkCUDajVoKXCuIZc72Z7xYOAYwx0uUy
 TNMYAhEp+2mdX+KLnulAtFkxX7WXDwvN8X4i35CAc7/b4CgMQYjGfQQCkJq6J7Rntpv6
 ZDjg==
X-Gm-Message-State: AOJu0Yxu9ry1YUznJuXzWnYRr1PT03PuEafvZU8CDjfLEJhET+USRL+G
 AtL9OEIsk6jgoK+L595fAFXqxq2fGQBYnTpMtrpki34+SONqmXCTRrdaJiTPFGC/TyMVeT4QM1W
 yKlbG7A9agxld4e+HnlmrAl3BlyNlyeTmg8mRFZiM+1uYoyZVxx5myWFpcDayZJZuwnpUnQY0UL
 UEqkdH+Q3bRcbs5Zn/pWJ1kWr9a9BCo10gLTNdRQ==
X-Gm-Gg: AR+sD13yEFD949AvTxYuqjBrA6UrB46WeCMQ+vHPpfu7jlZGyW5FhcaiG6clJ+ZVsYT
 j7bg5yEPBdqnPnV9rt26Xsbq9Dqba7Z1bgWPi16COUWu+HXY07r2VkH+ZIMipCVqe/Ux/+Z8EWv
 4FM3cpxPfD5sAVzvSEichzg0NQEoI6SW23x1rloZ2B34uqZS6CXVT8YNGbRjfkIxm1FxGBiX4QX
 6Q7vFjw/tcnGmx0FVJ3niOM96TGXV6rKDp0+1g+4+UZQT/UJvXqFX3CkNiXUZeOO7/RsYF4zQbn
 DHgYGyaaHQ9enoog4R7TiNfNy8wnN1pM2VYnzHJXklVaFhbn//6un0s1DIE8brNsVLuuzF46eWz
 XigZ3JyoBtimauF0rFf0d7U/+Mkr0oPXet39y/vZnzhk4SHe/KRLYKyzLrKk=
X-Received: by 2002:a05:6820:151a:b0:6b1:2a4a:ca8f with SMTP id
 006d021491bc7-6b15ada2b41mr380496eaf.10.1787256235647; 
 Thu, 20 Aug 2026 13:03:55 -0700 (PDT)
X-Received: by 2002:a05:6820:151a:b0:6b1:2a4a:ca8f with SMTP id
 006d021491bc7-6b15ada2b41mr380426eaf.10.1787256235089; 
 Thu, 20 Aug 2026 13:03:55 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cebeb2esm6181314eaf.10.2026.08.20.13.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 13:03:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jack Wang <jinpu.wang@ionos.com>, Peter Xu <peterx@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Samuel Zhang <guoqing.zhang@amd.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v2 07/10] migration/rdma: Sanity check
 RDMA_CONTROL_REGISTER_REQUEST on buflen
Date: Thu, 20 Aug 2026 16:03:19 -0400
Message-ID: <20260820200322.3321036-8-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820200322.3321036-1-peterx@redhat.com>
References: <20260820200322.3321036-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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

RDMA header supports head.repeat on RDMA_CONTROL_REGISTER_REQUEST, which
can include >1 memory registrations.  The current code did check over
head.repeat to guard against RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE, however
it didn't further check the buffer size (head.len) to make sure the
received data is large enough to include the repeated entries.  Check it.

This is almost only to harden this piece of code, in reality on source side
QEMU never uses repeat>1..  However since it's a protocol, still keep it.
Check the buffer size instead.

In case it's not obvious to new RDMA readers: head.len should be the size
RDMA has last received, as qemu_rdma_exchange_get_response() checked on it
against byte_len (which was further fetched from ibv_wc.byte_len in
qemu_rdma_poll()).

Reported-by: Tristan (@TristanInSec)
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4028
Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index 683c24ba4d..f7356e759f 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3360,6 +3360,14 @@ int rdma_registration_handle(QEMUFile *f)
             reg_resp.repeat = head.repeat;
             registers = (RDMARegister *) rdma->wr_data[idx].control_curr;
 
+            /* Making sure the register buffers to read are valid */
+            if (head.len != head.repeat * sizeof(RDMARegister)) {
+                error_report("%s: Invalid RDMA_CONTROL_REGISTER_REQUEST "
+                             "(head.repeat=%"PRIu32", head.len=%"PRIu32")",
+                             __func__, head.repeat, head.len);
+                goto err;
+            }
+
             for (int count = 0; count < head.repeat; count++) {
                 uint64_t chunk;
                 uint8_t *chunk_start, *chunk_end;
-- 
2.54.0


