Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28EBC6369F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASm-0000GY-DW; Sun, 22 Feb 2026 09:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASi-0008Od-98
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASg-0006xr-Qh
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KS5MDuR4OMK9CX015rS11PKDv5GZRhv1uZXIyizwmFE=;
 b=M6gctbQrT9AFShnp9ZVVy6d/UOjD0CvPWlPz2bexkp2V/hsq6UV6FRVmAYvoaGHryrfhu9
 fDu661YOPBzQLBj1cq/JbJo9ZSviGvF2kTFzppblj9m6D/OwM6Rb9/ic7Y2RDFmplUdG7h
 9Fwp99W7zPSG7oRiPlEQMfnq/oOMcBk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-sqQvnwRbM0-2ZFL4_BMlxw-1; Sun, 22 Feb 2026 09:29:28 -0500
X-MC-Unique: sqQvnwRbM0-2ZFL4_BMlxw-1
X-Mimecast-MFC-AGG-ID: sqQvnwRbM0-2ZFL4_BMlxw_1771770567
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836ff58111so46686985e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770567; x=1772375367; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KS5MDuR4OMK9CX015rS11PKDv5GZRhv1uZXIyizwmFE=;
 b=Ui4vlPI4GiN50VL4yLXaTtwuu4ampNW2JMUjI7fZmQVZBv3lXsQVeXwwquIJb+DqKm
 2C2QPjnObBJ0VT8Xkgd2W5bTbtHA5DE2dFrRH2fPC87xFOAbwG9Eb9S1WfCUAKdqAaY9
 TC/7ZLomPrp46Bu7S7sJHCiP9GFg49C1oq1VYh/0mNKwOWgX/uMmjZUCxqcYMCDEfSv1
 CE2wn1sd1w7BzU6WaxlpkawelbPNJ+uIswad64ZsGoxwX89VLqTk6BGpLgVbjyLpIte+
 MFsasLCaZZyH06DVBK93Z7aZqUu+DHcHbTtI5XJ446LZ/vBWLKCtWd+83MsuA1jlG4O3
 agpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770567; x=1772375367;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KS5MDuR4OMK9CX015rS11PKDv5GZRhv1uZXIyizwmFE=;
 b=bAifyIRGPrX5JvASl5Gm9NBkVJNjnJeyWYnZs6DpNCLEm4dcTNGy6k61khEf0/PgoI
 JuTLa9eRvaQNvwh4RNT3iOgcAAelHBkgTj4qBG5svCRE+RYuImjIONvTBZxx13cooLN7
 ddwx6TaPfqmY/abMF4I4zKje51QFPMVX7EDG45YT50QhAz8LyS11D/AzZXgFt7IESXpl
 E87VsgbDMHuEVcHq0w3tMPGIGqVelFtpFyyzv0Gj754t+La6BrnfeePXqZAPMoovC8ar
 ludMvekP66JkDgq4sg4XlE+tOYqhMyLtLXzmxwvhu+Zq5JwLI8EKmrb+70CTHafJQRaV
 o/Kg==
X-Gm-Message-State: AOJu0Yw+8vFGlPv1B6yZKlI9ClN9ZN6Vhs1MXm4orlhlwG3vfpkB6gPM
 jyqu55AqnCoZHhht9isgLAe0whAwGekWKeE+z3QQZDVFUBM3mpynnSWPciZNDarTYiCky6IPJHv
 kvEd7q6QDUDlD6etnObY3LIvhrxUMSC+c1yfissWgMxe66ElmHcgoTPq9o+LjWQaXoIty+K2SFK
 RQl0kBJ9rWTlNo43I8vYs9zE7K1UpH8vDf4A==
X-Gm-Gg: AZuq6aKcgaRqJaVrDIbaQRHrsDkvy7NxrRkfbltj5ea/bxgRbYkrLEEHfLaH73snfLC
 nIpBJfskPRkVONibCfeJag1O1D+AGX3GLwFEWGAFkoPdY/UPcg7UlR6kF4mYkuQaLLwNdXFqUvJ
 2uuGctc8QF6lXdaImARrlTJdW6dgu94mxBmlh+BrxEjWby5qhYUCgGxAnhxBUjjPcQZzpp2aoWl
 /Zk/yu7nqQhXAavmaOLoujecH/vbo1w/Hw4kxoAKmqoj9c24R7jdIUhwJbhlw47GucmYGc8aEFC
 Ei1iMH5okcXaq1g0U4EOw4EMSYzJdv8HkIWCFfiYnPmQ1KdHv5C2mFUc+3LS97aneJfZ0BxihPu
 LD4V/UFQDzKeP73IHJ7tbCdaook+VcaknVoxEcnm9R4nhnw==
X-Received: by 2002:a05:600c:3b11:b0:483:79a6:e7e1 with SMTP id
 5b1f17b1804b1-483a95b5a72mr99729945e9.7.1771770566580; 
 Sun, 22 Feb 2026 06:29:26 -0800 (PST)
X-Received: by 2002:a05:600c:3b11:b0:483:79a6:e7e1 with SMTP id
 5b1f17b1804b1-483a95b5a72mr99729545e9.7.1771770566024; 
 Sun, 22 Feb 2026 06:29:26 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4c96csm13631938f8f.30.2026.02.22.06.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:29:25 -0800 (PST)
Date: Sun, 22 Feb 2026 09:29:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: [PULL 28/33] MAINTAINERS: add me as maintainer to virtio-snd
Message-ID: <5cf298a394f230d919a8b44a2bdc17fc3149c0dd.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260220-virtio-snd-series-v1-1-207c4f7200a2@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8df82f313e..4918f41ec4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2602,7 +2602,7 @@ F: include/hw/virtio/virtio-mem.h
 
 virtio-snd
 M: Gerd Hoffmann <kraxel@redhat.com>
-R: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Supported
 F: hw/audio/virtio-snd.c
 F: hw/audio/virtio-snd-pci.c
-- 
MST


