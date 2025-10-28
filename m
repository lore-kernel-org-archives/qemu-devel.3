Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DCFCCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd5d-0003zy-AA; Tue, 28 Oct 2025 02:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vDd5S-0003qn-TI
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vDd5P-0008Kk-8D
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761632498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ByCSKi9r1vAXRTDrxPp/LbuSRwyChFrEImzbNaS37bI=;
 b=GusZXvvRIDXQneeFoxaJLophpwgYvmYbYy/lx7q2JTWbkXTfN4fQQtsFo0dm2ACXJmUrBx
 SB0HgD2ORov7J9zYhU7vHelG9X+YrF9yjCSgKkk/GEYs2U2yi8od9xNPZU1sGoX5hK1Sje
 Knj+qFzAbJudREagg3algbCGrWwks7g=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684--Td8gi8YP8Wu2_9Mcq834g-1; Tue, 28 Oct 2025 02:21:36 -0400
X-MC-Unique: -Td8gi8YP8Wu2_9Mcq834g-1
X-Mimecast-MFC-AGG-ID: -Td8gi8YP8Wu2_9Mcq834g_1761632496
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b6ceba8968dso4055796a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632495; x=1762237295;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ByCSKi9r1vAXRTDrxPp/LbuSRwyChFrEImzbNaS37bI=;
 b=PgoCEoqWgubWTMVPZf6dRIa0RSqSFQimQMf1y2Eiwa9TW+cRkWG4kTqRskoVAfmxNy
 kenElzk8+ZCqDXFsST77MPNE90lJgr1/ujfGGJLd6QXwOxBg5vY9Nm5pYXOcQRQx4P9d
 3N5UT2+gkv14WSimiOL0P/7lObZpwC3RM8lRp5xUhdocgjV4hDxHLlln8x58XzL8rfaT
 idCvDqQa3KjLKYl1bo8S3D2d+xq3w2zVXdHg3qkw7xv1IetL/jXL50aYCjsJwvypC9cD
 0I7FVDtmfBWUMx7BpGFQ8mwKcwLiIeAMALGBawECaaSabhLV6WAoSS0EZLNxqyE2BmDa
 B4HA==
X-Gm-Message-State: AOJu0YznpQwsqoGhrrtbPbbHm/qlrFaVwLIhp7HSEr3ya8GlPb2YXD6S
 YsV0HezB6GfZ7stAf6Pn3SeQGJcZ+zKZmLFiRCmuzoOMcerdY9l0Ajqh7XkkZq54T0cLqbKtP1p
 vgzE7Dva7846uiAUrSkSoEp0LMVe3wfKmz3tj1PeFr76WmfQjZHH53Kcs
X-Gm-Gg: ASbGnctRZTvMiwW21C2mbLkjuHH+jT56H1EIM78ke8I0f0O/Ih72OzK16aY2Ntsyukt
 f3p6FN+MbgNsWs+//Lt459jOQ1usfsKYbANpK1kpDrrlde45JF9ZIAucVWtBj7BdaQ5cPc9HDEX
 hcJqgrInhrl5/KP2i3q+DYwrKErI8rrh0t/nWLTAHicZNAnHc+y4RD+h5O6FxgLLDuGGIswP+TJ
 eHRdOZenfZX9pa8Rz7ChzgG1Pb5pOl2L8c8CbLUXhPk9BsMlWDjrxoK7h3cD5FEAl+RyJdBFIsR
 3yEyFXPUeIiFyQ6tIMGflh7Cm37YKPZ01CiqjAqXpkdmdlPrkLrCjdi+0nMZbyzojmB/Z8+LaM/
 Wnh0D6+B4lQ1F
X-Received: by 2002:a17:902:d50c:b0:293:e0f:3e3 with SMTP id
 d9443c01a7336-294cb52e567mr30662375ad.29.1761632495605; 
 Mon, 27 Oct 2025 23:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgTTnwN4TOSJQLen1Fi7P7iQV86LWgqbMgovO2a2KvPOFKyqpWPHWZzfS3Wmn0EuQ9OKGfTA==
X-Received: by 2002:a17:902:d50c:b0:293:e0f:3e3 with SMTP id
 d9443c01a7336-294cb52e567mr30662015ad.29.1761632495216; 
 Mon, 27 Oct 2025 23:21:35 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d40de4sm105463995ad.77.2025.10.27.23.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 23:21:34 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 28 Oct 2025 11:51:03 +0530
Subject: [PATCH v2 2/2] migration: Fix memory leak in
 postcopy_ram_listen_thread()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-solve_error_fatal_regression-v2-2-dab24c808a28@redhat.com>
References: <20251028-solve_error_fatal_regression-v2-0-dab24c808a28@redhat.com>
In-Reply-To: <20251028-solve_error_fatal_regression-v2-0-dab24c808a28@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=armenon@redhat.com;
 h=from:subject:message-id; bh=l7kD73eZZkxINafbqQuwKNBcfj7gqAa+0anvmpEQrm8=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQyZDws2NivGuO77t4Kw5GVPW0Zpx1i4le8Zaxw7W7Bfzm
 eY7vHnVUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCL1mowMrcWeU40PzqypPaz/
 qYGh0vH5/CNPlqhfvRR+vcjv29dlAgz/7JYvd2bWefXxlv8pu06VeIvVEqZy09sSvqxdWrp9r5Y
 4PwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

commit 94272d9b45 introduced a memory leak in the
postcopy_ram_listen_thread() call.
We need to free the local error object in the if clause as well.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 7b35ec4dd007c6ed494201be8528a9e4f1c13843..f18c6ee659c1b9a005ff8ccfe51875f81d37694b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2141,6 +2141,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
                          "bitmaps may be lost, and present migrated dirty "
                          "bitmaps are correctly migrated and valid.",
                          __func__, load_res);
+            error_free(local_err);
             load_res = 0; /* prevent further exit() */
         } else {
             error_prepend(&local_err,

-- 
2.51.0


