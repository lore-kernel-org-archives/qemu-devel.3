Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEEDD0EE1C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 20:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNzxC-0007l8-Gi; Tue, 25 Nov 2025 15:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNzwB-0007C1-Om
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNzwA-00030Q-7I
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764103616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpbzNPRtki18pB+Bwa2yNmzCzERPQhJos9MVBn/adac=;
 b=BuNvdNDLqzS6RlXNuHp8lORxBcBwAnA0NxzaOMlDtkc09nc6zZqNd0vl9TEBBaSk4iXF+f
 dwCnpb3LnNplhNihbGXNVAvcy1oj0OuMD70sedPQtHk4tpYOZIzKFgkmcKNam5pDL0eFwN
 Y5ZqRwXMbmO35LZPp2+6ueNre0v5CGs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-gVkgESvCOaWPrMBiq1GYCg-1; Tue, 25 Nov 2025 15:46:54 -0500
X-MC-Unique: gVkgESvCOaWPrMBiq1GYCg-1
X-Mimecast-MFC-AGG-ID: gVkgESvCOaWPrMBiq1GYCg_1764103614
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b24b811fb1so50963485a.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 12:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764103614; x=1764708414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tpbzNPRtki18pB+Bwa2yNmzCzERPQhJos9MVBn/adac=;
 b=fPtKPPixtZta2ScLe8yM284zxLF2+U1BNj9q1TfRTPEEYaJ3qW8GGOe3/KnwMI64eV
 5UpaUhf3t5egCNctswprETLdJZ04pA0nUWrChrSQv9TbqZZ7pHFiTYA21QXf+C71Axlb
 XDZZcDbKYXCHerFHO8i2EjV8QUVzYrRu3azDDz2uapzVTYf3AGReGQwNm1Pdpg3nIFmz
 rubxeOaKyfsigEQxb0kKt1gGZYWBjJOzb2uQrrfPEQ6sahqexIB7b1aZTARRqlXxXptw
 afCr0PUy92PFJz4kOgixxdwFu87FkyhJzrTyf3HhiRyEysUYss8sE45DRdp0m4yUMGHa
 9lTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764103614; x=1764708414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tpbzNPRtki18pB+Bwa2yNmzCzERPQhJos9MVBn/adac=;
 b=f6pVUicYT9JQbmZ2Icag5/O/7ODuQgyCP83lEQem+cf5dv/o4aq5L2JajXtlwP1J8m
 OyQo6ngaDR+Puam89KpHuNpd5xGwB1CJpBogGMRG5+I9i+Zs1vpqiNwb3dxNJiiIXHIK
 E8o4bu/e48ou1XUxJhVUqkEC12uY25z2HD2OUlNvZcshz6kOV5QVKMu+IJdslQ8tttCi
 HLi9CaSqrS6E5I14yTEqDw4H7Sz+EHLwpG0gc2LO/bTrfBUQV4NfgxlRJf5We3OE/ost
 mE6Uphxr2lVau1iPZp4RBztH7GsSjk++0Tx5btRf4q8Y0DoQJ649KWi7a/yDNoFBau7W
 T4mA==
X-Gm-Message-State: AOJu0YyRSNwL8FUrnSdNm5hlTIKO1sEHuB3IXxIuTSKrA2T/fbKLFiaM
 OowREpLPFzJomS1QDdxQ5NOCooSl8TBC+YaPLNvWpDfolPXGqRm3F/U3WbU8TruLyDeR4FaEPud
 N4O9USzvfX9Csvld1HOsmrKZjZPkJXdyTmhfv89glbhX2BYPEDs1InvMLT+DsXy2eiE4cGrzBJ4
 0eANb4Q3whnWXcjgh7bd7nuFmRV9QfgOA/xX6poA==
X-Gm-Gg: ASbGncsl0Ee+23QcNVup/K4vt6XzTIKOrJ6Ozj2dJZxSqDaMm8TI0v5/S0HjetCvUl8
 HpVhAgeLn1Pz1ExUWJqYyvcHa086RoAJiKIdePuPcRbbOUaZ3BiPtLAc0WYbV66oS9rWeX10jzi
 UdIVNbPFjbFXL6vQYbdgLeZaUmkD0JYaxDzxBmViYLSHsHVz8hiC7fTHHd0tIV60PckE/HRPAYS
 sDN7G49K+Lbq9nsC0PiQt3pa32GG1M4SEm3LyctuVkk0tQAxTfiLOmxPM9nEiGJTOXAttAFRwb4
 +MGB7tsdsgQ2KvAM/Z7e11YxK9KBUuaAMfGofh9/9YyhhhHz6WysWcZRlE4SGMFXWAmmG8Sycx8
 dXXI=
X-Received: by 2002:a05:620a:28c8:b0:89f:5057:9753 with SMTP id
 af79cd13be357-8b32af32b8bmr2893348185a.41.1764103613934; 
 Tue, 25 Nov 2025 12:46:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdQneGvER2Ml4PYWZVQ3wZLr3sN5URh2j4kQc8rAomIogjApTCRZyOucvK3i7hN3xci3GSCA==
X-Received: by 2002:a05:620a:28c8:b0:89f:5057:9753 with SMTP id
 af79cd13be357-8b32af32b8bmr2893343785a.41.1764103613317; 
 Tue, 25 Nov 2025 12:46:53 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3295c2276sm1250794085a.30.2025.11.25.12.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 12:46:52 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-11.0 2/6] Revert "error: define g_autoptr() cleanup
 function for the Error type"
Date: Tue, 25 Nov 2025 15:46:44 -0500
Message-ID: <20251125204648.857018-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251125204648.857018-1-peterx@redhat.com>
References: <20251125204648.857018-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This reverts commit 18eb55546a54e443d94a4c49286348176ad4b00a.  Discussion
can be seen at:

https://lore.kernel.org/r/aSWSLMi6ZhTCS_p2@redhat.com

Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qapi/error.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index b16c6303f8..f3ce4a4a2d 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -437,8 +437,6 @@ Error *error_copy(const Error *err);
  */
 void error_free(Error *err);
 
-G_DEFINE_AUTOPTR_CLEANUP_FUNC(Error, error_free)
-
 /*
  * Convenience function to assert that *@errp is set, then silently free it.
  */
-- 
2.50.1


