Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3C7C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNy5-00011F-5z; Sun, 05 Jul 2026 10:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxT-0000Fa-Al
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxQ-0001fV-1n
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RpMSj4rdk9L0MMYkgLlakUyWtfvCtO+WCOA+//P7Wc8=;
 b=O3MbXAl9Wxv/pQi67EJd8o6oeAkBt35oJ2B9YDjBtvGZLmUMvxNcHQvVjn3qPV+RK4UMTq
 QQ4rV+9woWt6tBnxzIu2/cXhOOO2FSEjI7gczwiGB9uP6/4RE+zwKc0E83nQdhpTODRDCf
 joD/7HXbGYA0t2vn59/13sjdbiQ2fnQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344--oASJh9EMjSSIhXS83xQSg-1; Sun, 05 Jul 2026 10:36:29 -0400
X-MC-Unique: -oASJh9EMjSSIhXS83xQSg-1
X-Mimecast-MFC-AGG-ID: -oASJh9EMjSSIhXS83xQSg_1783262188
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493b0fe95b6so11371225e9.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262188; x=1783866988; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RpMSj4rdk9L0MMYkgLlakUyWtfvCtO+WCOA+//P7Wc8=;
 b=cr3rYsFkDTpRJ9zH9LIfb31Ittl0ZU6xp1NLCEV7tncQfQF3l0GkGF7HzoI1n3OXK7
 QIRRHAgxYDSt8SNw9voYvUs90FOtW3yKY0TgwMTiJjJFK8IMOm+3RHaZX6g5/IlMMpUA
 5HYD4osH7CuzOgKCWRc+1w1j8yPgcgcPi1eQOhuvZdzZiB0PW7nf46G2FS7kAEAHq//N
 PGT/CVKXg898C2mAfHPgKa3nJeQiuM3muZ7JXn3wmnqky80jFKrD3NM8av2/7GDgiCWV
 2EQVltGqjkw6Nehebrpy6jd758OmqHQHnlnxzBts9sHp76RKbKCma0kpTZGiIC+U0i3s
 JcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262188; x=1783866988;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RpMSj4rdk9L0MMYkgLlakUyWtfvCtO+WCOA+//P7Wc8=;
 b=INDFgGQssMd0P/+7ZTGfhYqCtY/5YERU6wAGdycl6Sk2zccjzMfDFAZZEW4O/FfUp8
 C6ZfAjufGtWrk968shLaTFEcxhjLPdNI4sL6ZoU6CyrEYTaYR62lmsVfW0cHbplqyW2k
 9ffuO5pjgOd/Hn8V4umLuOMgFb0kLISPNH8Z2POE7+YXk6dCuDsIv/VUS+zmsnfMSLJC
 EV8m35T7HaPNwJRXv9m7MpeHVNj0vei0shddFS4sbZZzasnl1f20E2ErjPDW/DmMvoEX
 WDnrHDZGBPielaULXjqReMM6s3oDTxGdilSGQrR35ioyNdP3jbJfUlYe5YJ4Kacmvyxa
 r5qw==
X-Gm-Message-State: AOJu0Yxz+Kh7OLQapMjXXZCx9yRxOoEeJWc1fnXgxYxyPcMJtpCNNhLK
 9ip2W0NI+zwLnWIOHuki2SLZ7arnMyybl+48lkK0/2NU3KWfJtvL7bFBnUfk38rxP2iYzW+6F+v
 pp2UzoAft+tPme+GQnm8fOlrL3jWRmNhtwbcxENrsQRKmurcvNIbdu1U0B3c1r7zP1ECYyIsE7u
 2IzZ313BGsfJz9CjzxOCiUlOkSAgRphq4A2A==
X-Gm-Gg: AfdE7cnwn+XSlbI7GUxNuaQgFqRollhjf3Q8KTrvx4fOrvVpHdJU3w+ImP4fIK2hx2E
 iMrgzjFjnpaZft9vlgFqRmg/4nr4eiA7+4CqOZ1s+kQQANHBsfP3Vvr6Dm+eDaAJQsaqMVsj6i7
 w5+t4ahsRD7V5lQHTxV1Q5e3iCv0cYGfPhvJZj4uQS3CfTMz/RrwxpRHLO4zx3I82UiIeZF4zRG
 hhJwZnVtqGfJAF71VKpL/KZjH6Ig56uyVe4xkDkoI42YIw0A5KPa2mOrl/Ve0icfmL8DsHrDNVs
 B611KFpVh+YGqCnZDZmK0+VHDdy48Ipi69j96v6phMFghglZD8INZCCWiqzH2B6oj7jywEep1Va
 5UbRvtq+ZWo/JZw97yzNvLbtzVgSGNOox
X-Received: by 2002:a05:600c:3507:b0:493:bed6:85e6 with SMTP id
 5b1f17b1804b1-493d11db6b8mr76326575e9.15.1783262187984; 
 Sun, 05 Jul 2026 07:36:27 -0700 (PDT)
X-Received: by 2002:a05:600c:3507:b0:493:bed6:85e6 with SMTP id
 5b1f17b1804b1-493d11db6b8mr76326155e9.15.1783262187421; 
 Sun, 05 Jul 2026 07:36:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce0a7cfsm207616445e9.9.2026.07.05.07.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:36:26 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:36:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>, qemu-stable@nongnu.org,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL 44/44] virtio-net: validate RSS indirections_len in post_load
Message-ID: <32a90850e1e4222091df07b4b46d5f46a8b90d24.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Junjie Cao <junjie.cao@intel.com>

virtio_net_handle_rss() enforces that indirections_len is a non-zero
power of two no larger than VIRTIO_NET_RSS_MAX_TABLE_LEN, but
virtio_net_rss_post_load() applies none of these checks to values
restored from the migration stream.

A corrupted save file or crafted migration stream can set
indirections_len to 0.  Even if it also clears redirect,
virtio_load() calls set_features_nocheck() after the device vmstate
(including the RSS subsection and its post_load) has already been
loaded, re-deriving redirect from the negotiated guest features.
When VIRTIO_NET_F_RSS was negotiated, redirect is set back to true
regardless of the migration stream value.  The receive path then
computes

    hash & (indirections_len - 1)   /* wraps to 0xFFFFFFFF via int promotion */

and uses the result to index into indirections_table, which was not
allocated by the VMState loader when the element count is zero (see
vmstate_handle_alloc()), resulting in a NULL pointer dereference that
crashes QEMU:

  #0  virtio_net_process_rss    ../hw/net/virtio-net.c:1901
  #1  virtio_net_receive_rcu    ../hw/net/virtio-net.c:1921
  #2  virtio_net_do_receive     ../hw/net/virtio-net.c:2061
  #3  nc_sendv_compat           ../net/net.c:823
  #4  qemu_deliver_packet_iov   ../net/net.c:870

The RSS subsection is only loaded when rss_data.enabled is true (via
virtio_net_rss_needed()), and the command path always produces
indirections_len in {1, 2, 4, …, 128}, so an unconditional check
cannot reject a legitimate migration stream.

Factor the validation into virtio_net_rss_indirections_len_valid()
and call it from both virtio_net_handle_rss() and
virtio_net_rss_post_load().

Fixes: e41b711485e5 ("virtio-net: add migration support for RSS and hash report")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260324060100.1997-1-junjie.cao@intel.com>
---
 hw/net/virtio-net.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2a5d642a64..f0e3beb290 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1374,6 +1374,11 @@ static void virtio_net_unload_ebpf(VirtIONet *n)
     ebpf_rss_unload(&n->ebpf_rss);
 }
 
+static bool virtio_net_rss_indirections_len_valid(uint16_t len)
+{
+    return is_power_of_2(len) && len <= VIRTIO_NET_RSS_MAX_TABLE_LEN;
+}
+
 static uint16_t virtio_net_handle_rss(VirtIONet *n,
                                       struct iovec *iov,
                                       unsigned int iov_cnt,
@@ -1411,14 +1416,9 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
     if (!do_rss) {
         n->rss_data.indirections_len = 0;
     }
-    if (n->rss_data.indirections_len >= VIRTIO_NET_RSS_MAX_TABLE_LEN) {
-        err_msg = "Too large indirection table";
-        err_value = n->rss_data.indirections_len;
-        goto error;
-    }
     n->rss_data.indirections_len++;
-    if (!is_power_of_2(n->rss_data.indirections_len)) {
-        err_msg = "Invalid size of indirection table";
+    if (!virtio_net_rss_indirections_len_valid(n->rss_data.indirections_len)) {
+        err_msg = "Invalid indirection table length";
         err_value = n->rss_data.indirections_len;
         goto error;
     }
@@ -3427,6 +3427,13 @@ static int virtio_net_rss_post_load(void *opaque, int version_id)
         n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
     }
 
+    if (!virtio_net_rss_indirections_len_valid(n->rss_data.indirections_len)) {
+        error_report("virtio-net: saved image has invalid RSS "
+                     "indirections_len: %u",
+                     n->rss_data.indirections_len);
+        return -EINVAL;
+    }
+
     return 0;
 }
 
-- 
MST


