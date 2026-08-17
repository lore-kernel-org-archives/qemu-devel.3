Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23696C5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww3t9-0003tP-Vp; Mon, 17 Aug 2026 16:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3t8-0003t5-Ci
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3t6-0002oh-L9
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786998292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HwPNBAsVyZnQYazdHmHIZ1jujVvi0DPnF4lKOqhqlLk=;
 b=GAe1GyBgjaUHR2t3m9lAbGCRvkTbIH+aUh3XzLKeXsNnUugIAXXLuaSrvldeVH2rkk8l99
 OyuIEutRXmvzxdQAze3sQB6Kh32NWnHy+rP0BbN26Jz7uj5W4//gRAKSX5QIh57QrCwv6U
 9/ZQJQkeOWLQzFhjgc022y4I1a0s2yA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-5pCqHLvoMVuJWe6rDMPIxA-1; Mon, 17 Aug 2026 16:24:50 -0400
X-MC-Unique: 5pCqHLvoMVuJWe6rDMPIxA-1
X-Mimecast-MFC-AGG-ID: 5pCqHLvoMVuJWe6rDMPIxA_1786998290
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d137a68so35699191cf.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786998290; x=1787603090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HwPNBAsVyZnQYazdHmHIZ1jujVvi0DPnF4lKOqhqlLk=;
 b=SwlP6H2wBW7dNrx4t2z7YJxmQmTs8XPUu8ar5xOKmsrYHbirdfuJqTUsahBpOjJldF
 KepU46UqctGH4xZHeSo19txubTJe+K7cujDfVhbF6A7trGssczMGrXLsNCi9MFl5xnvr
 V2KKnROHDJxbnqRl6uVKc0iGP5vCaziIUn1VJPrmY2mgfabEnVMbb/rqDA6PAgOb7N3+
 7dtq5dCEWMSttM84WSwuDY9LEUWqE3w8/w8vzwt4bIRe9jqU+HjdoTRtvoFn//wIMJsg
 7ZYiZc7QzF7/PzR/oSvYMbUlHyE/zKCDIFpp1psv8kdr0gsXSUQAX+6VN1yZh26UQbQL
 mV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786998290; x=1787603090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HwPNBAsVyZnQYazdHmHIZ1jujVvi0DPnF4lKOqhqlLk=;
 b=W7sPDJV4c54187kYunJAuyw2w9sibTDbpcYpuNnkF1DZg060Fr7kfh5ImD3qrTKT4g
 GOMlQg30t++JaDa0NMF4oBNZYZE+J2jOcEPnIhm/3Fa+X4Fptf3x631L2l6pRQW16mKS
 dXYw5W89ygJ1rotV5qEG2AEhPdbeiliZbhTx4nf2nW3b90mWXzHd/FWrZxNcbPs1l2Tm
 p1gi5hEQKnv025+vfexncAaMCUHDkI/nO9GdeANfi2qAj3U4ZtL8ZuQFVKDdtrfmSJ7K
 b2YEqrPArEg/n5LA24UMZoxqhbrfOU9fEh4BOrrcWN2OdJUchsnS94m+oNbR/i7+hVHc
 +Z9A==
X-Gm-Message-State: AOJu0YzlG9LvqQtzGt+lZhss8scgrPJ9qgPpNA+iWa/HU1GUle0Lhia+
 RthnyqDV/0WOwOsxMa3XtrGhqUaF5xY2RBZzHiBXEa0A77Ft9ljNjJBYtyHVO6nt6HeL7mPuvSO
 h4X14xJxgJEKAMGxmdeO+dImfNcw0CzdQhaP1gFGDJS9DiPpzeXXr8OejFhsfummt82wOnY0j6R
 C6oetSTLQpLu1MISB5m4eG1QTsFh+e74WL65lMcg==
X-Gm-Gg: AR+sD12NO4tMm2jb+XRsJmtf/8bDLKUqb4FtLFELlChTHJSL9iWqknYGGWZTF3kb6pk
 WTriVdw7Q5g742TZvpxiUcvweKWNa+MGrno/p3GIndSIqoP1PalbtiphLG2QILktRfGPBed9bj+
 R5UWgc/dIzwk4wIXNOmK8kWRktYtumKqS3Ol/oIqh4vSNS6P9J6PkoHOlMaxdLeRd8aPP6Qpd2L
 e0z42ywG1ax1Nq/JuZbTGe8KpsoGgtAWCGYEORx9laWcVlpPwHGPqOm/+yC3KfBLaje480uGSD/
 BN4kPBMcU50VH3vsJV/kcHZr7q6ImBZBcey/7mvZ6z+Lz/DuAKQUcLFYMY3NpnxW3g==
X-Received: by 2002:a05:622a:58cf:b0:517:9570:c1bd with SMTP id
 d75a77b69052e-52d854c2d90mr322450631cf.25.1786998289888; 
 Mon, 17 Aug 2026 13:24:49 -0700 (PDT)
X-Received: by 2002:a05:622a:58cf:b0:517:9570:c1bd with SMTP id
 d75a77b69052e-52d854c2d90mr322449901cf.25.1786998289306; 
 Mon, 17 Aug 2026 13:24:49 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db6136569sm22865761cf.12.2026.08.17.13.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:24:48 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Jack Wang <jinpu.wang@ionos.com>, Juraj Marcin <jmarcin@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PATCH 07/10] migration/rdma: Sanity check
 RDMA_CONTROL_REGISTER_REQUEST on buflen
Date: Mon, 17 Aug 2026 16:24:21 -0400
Message-ID: <20260817202424.2901438-8-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817202424.2901438-1-peterx@redhat.com>
References: <20260817202424.2901438-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index f64bcee418..5ce8b06818 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3362,6 +3362,14 @@ int rdma_registration_handle(QEMUFile *f)
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


