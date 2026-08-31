Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF9CC624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12R3-0004Ak-2V; Mon, 31 Aug 2026 09:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12R1-0004AR-Mj
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12R0-0003x1-3B
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788184345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBILngA/o03AQ1uNpTJlz0pKm/hnPgAOBsC92GJh0xo=;
 b=YruXVkzDKhzywqcT6IBYuWDdCH6cKmO2Nm6RUEzNA4mr01eJPrZWOThQRswpeoUjvaQbPg
 SxL06e0o23+9P29nonsLmQynD2yklxSjzyzytENSsLija/QkwQFuFGiagQo/LRKXjndhzL
 SslDRLJ4DVVuYGBSgRE0iBA1tjPkl1I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-x2e3IXxAPGi05TPYndh73Q-1; Mon, 31 Aug 2026 09:52:24 -0400
X-MC-Unique: x2e3IXxAPGi05TPYndh73Q-1
X-Mimecast-MFC-AGG-ID: x2e3IXxAPGi05TPYndh73Q_1788184343
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495529a93f9so32698295e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788184343; x=1788789143; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gBILngA/o03AQ1uNpTJlz0pKm/hnPgAOBsC92GJh0xo=;
 b=NbohQkgJE+qIuaZmBR7s2jwit7RKGU5JxwiaNBeHuYeQmbQhQP6viJF03JeYzTaD8A
 aibwL82lJ4IUtrRM9VuHLezB5h1ex5cTnjg/WOMArW81nUFyRSLsAmXQDyJDdgEpk1w0
 sICJiRMybODtTYrHWPWgoM1/k3P/P3rBcbyDm6zIrTK/GH7eqxthgNh3/hdKN/IQFocP
 HJu3igj4nULnghsygBASoIe7GtmKEmQUWyBP7iMAufIkFhZiK0c9HmKgVh8SjDb/5bKf
 3X84Z5riW4BZwqKkcfDDI+8+NqkffZha4mv+q9c1q733dfZkZFZiU68H74SUB8Lk+EBU
 MezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788184343; x=1788789143;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gBILngA/o03AQ1uNpTJlz0pKm/hnPgAOBsC92GJh0xo=;
 b=rgADii60bvPyNEQ0FOQPj1VGaHIUSG46WrbU4gSKhCU6bNljHtH+qWgSf/ZWL9z3W0
 7K8eHr1ZjrZ51YaqqKA/ebufyPJLMoS8T78QFouISnNqxRG6HhnsOIZHsVfRXeepykn+
 4mOq3guwpQE7/RciOlWQ1CLbEZjHe3azx0DUeROZ/uSwwxhLYR9wJ3vd/yz9gCgdDc2s
 57hIOUIsseu0aKlAYKxlhl3oOwM0i0p1df1B8auXhfJbhC6MI64QBRTVcbhzPkWSJwDs
 kraqiodheiW3gI5jWRGt8mQFEpYCLPoM70v+zyOrLYd7eMYO9lhe8xPcGBlQAxsW51kA
 626w==
X-Gm-Message-State: AFuF++n9p+AuVHksYS2MrXCzEUddFYH+NUUmTZHn0Z9QIdWaTlWBGvxd
 qBjGJD1sosCluFH44HXThUqySrKvZ2HFEXOBWcqeFySMTlDLG3X5ZVOjcZd+jUgglhTob92XxOe
 5ECFJ0mlPBL93rOuGEJIZ8vPtR44VwtVIA6XcJlcE3/86CU8jQza0Fjm3
X-Gm-Gg: AR+sD10epbPetUI+zLg3Wi3i1xVGv/VIuGOEVEDej8erNEB7IAnWt6t5UDWk130K8hg
 czGYItvxv7256UR0GlfA2pBH1Zpl+mBu1ggy/qKo2mnJBkFBZEbpJ7fub3pXfC66xbsbReLpxSA
 U9j0nsCOgGYtJSXEKzwaxWUZ/DthiWxqogqg5Y62p9E5aIFdu1Ta6gyNLpMgaQwbaJFZfbYzFqN
 jU6nr9WMZti6JoX0cOuizltaX42FEJaN7pMULDqWwI7YY8cPQj75babjj205rDU87NUIeahWMTr
 AwTwnHkLtNRot+Pgn6uiDHf6th64MZ5/0aYiuMU/QeaAOfraXgOd7e+FK1wc+TT9dM6b5HLG02s
 U71HqOl8PR2k5G5hmyfApxXZCfe4QXFpaEoToxJYdPJtEpR54xJbI+FMU0sY=
X-Received: by 2002:a05:600c:19c8:b0:49b:c8e:a211 with SMTP id
 5b1f17b1804b1-49b91c20bfamr403766725e9.5.1788184342736; 
 Mon, 31 Aug 2026 06:52:22 -0700 (PDT)
X-Received: by 2002:a05:600c:19c8:b0:49b:c8e:a211 with SMTP id
 5b1f17b1804b1-49b91c20bfamr403765615e9.5.1788184342169; 
 Mon, 31 Aug 2026 06:52:22 -0700 (PDT)
Received: from localhost
 (p200300cfd72080187472d8ceb75e67b1.dip0.t-ipconnect.de.
 [2003:cf:d720:8018:7472:d8ce:b75e:67b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdb13f094sm35792465e9.3.2026.08.31.06.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 06:52:20 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/9] qapi/block: Add IoAccountingOperation enum
Date: Mon, 31 Aug 2026 15:51:58 +0200
Message-ID: <20260831135206.126184-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831135206.126184-1-hreitz@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
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

This enum gives more information than IoOperationType (which is used for
the rerror/werror distinction) to identify operation types for block
accounting.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 qapi/block.json | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/qapi/block.json b/qapi/block.json
index 46955bbb3e3..456118eb0b4 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -603,3 +603,25 @@
            '*boundaries-zap': ['uint64'],
            '*boundaries-flush': ['uint64'] },
   'allow-preconfig': true }
+
+##
+# @IoAccountingOperation:
+#
+# A more finely grained enumeration of I/O operation types beyond what
+# `IoOperationType` provides (whose read/write distinction matches the
+# rerror/werror policy settings).
+#
+# @read: Reading data
+#
+# @write: Writing data
+#
+# @flush: Flushing data to disk
+#
+# @zone-append: Appending data to a zone of a zoned block device
+#
+# @unmap: Discarding a block of data
+#
+# Since: 11.2
+##
+{ 'enum': 'IoAccountingOperation',
+  'data': [ 'read', 'write', 'flush', 'zone-append', 'unmap' ] }
-- 
2.55.0


