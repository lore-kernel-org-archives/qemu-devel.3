Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F34C636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASM-0008A5-GA; Sun, 22 Feb 2026 09:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASG-00086W-2F
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASE-0006o7-PG
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nHJFAKQkQhzJOM5wxQIFWf/cckmeTE0+MbAxYSOGU/Q=;
 b=RhS1qaioqmudhYTnKZBEaYzzdjLkgZ8vVYt2etbegQxRdSQ1mNz8WoY8Nvi2aF5k5MGfut
 1H/aFAjg9D082VanBhtLchbYdBBY2WRxZhOELA3RgYNB3icMnBlOtxp3VzENGJOcEGMyrL
 +o481OXXU683LTwNSWaW1ouXwhjXTsM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-WcI20yp_PySkMFRO8Ki2cA-1; Sun, 22 Feb 2026 09:28:59 -0500
X-MC-Unique: WcI20yp_PySkMFRO8Ki2cA-1
X-Mimecast-MFC-AGG-ID: WcI20yp_PySkMFRO8Ki2cA_1771770538
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837b9913c9so37783515e9.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770538; x=1772375338; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nHJFAKQkQhzJOM5wxQIFWf/cckmeTE0+MbAxYSOGU/Q=;
 b=hUvDn2S8p5WJVZo469wjPNlMVbUlE6WSeD2xAfzkV0dsGQHwM9QItGffaBvcIup4gS
 1zD1qSDqf0pSvkIm6QSr2CQgBL4exDU78FSrPwFB9sg5WyHMkcRFyILiGxLzaRX/wGED
 OIohzrFYiVHqi+GaV9fNr4SD0NZvyfWrWE9yXxr+tUtjP/wpNVZMmZG+MNbPsml1tNVt
 ZEaEn+Hx84vJsKzb8PN+msqlT6Ky2OBbnu5kVYGeEEEH3DeiULdyexOtNDlr2Aj58FaH
 HBWYNpTsBImIMvjvjnEhH5fwGxrZbKTKm+gScc6g8cEvvTkVtTNq2YGnuneZO//kfVJa
 H4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770538; x=1772375338;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHJFAKQkQhzJOM5wxQIFWf/cckmeTE0+MbAxYSOGU/Q=;
 b=aFRoYFR1PlBwILap2DJHZdwWAPBDFVNHbjPnpsv/+WzhJPnwV5L/DTEPFMbDA1VQ5t
 AF5SwpHHwapzICSbo42DAnVjYizIw74TSSB7XKGxZf/6TIImpy7PevpSFPtqvlCR5e5D
 5+oH1MrKL8tUV926s8cBlA0FNvj9n20SREWimFq08xx8n9q3sQ+mOKL+mzob+J1BGPMi
 QQs1tQvxYBAPIKlNo5HxkgyeNQcdAB5kavbLe8j28lhmaGrXyC93EsAmrX1bSP74XFrS
 PcefWlkgU+QV6RINoOaMsvQZ1zkwNGW5szgmsDX1qHqRAPhcY/EbExSZ42WHgs6u3jwC
 D8pA==
X-Gm-Message-State: AOJu0Ywk+5XHLcXD6O3FDHlp/qB7fzcs6vQ5ve1mZGSTJE4wzvNR9H8F
 ipW0hQ04BigshuSgqJoVv96RlcxiVlIXgeyboB04RH0cT4gqKwjNM7/dwn9u9hrRomVDI3LadPr
 ENbFdihk7DV4jP1Rg8H90ULusRu+3nFPIM5wa1DpvJWqwKv3isYHnjZpjobnFtmFCtsLnwGRGj0
 t59TJl0rYaECpWDb2hfeWWTLjA6V2tUqYo3g==
X-Gm-Gg: AZuq6aKQVmD2+EVqTYjKAN7rlYEHYsuc7/ECpN+oxWIGCu697F6rflFoJ4alCOK5byM
 mDlOt3MOXjmhQuLIX8kmoJ7fCR+Lg3MShXbKK1sfWq7rHnTKookznAubV6W0IfQSGnGVYkArXiA
 awfk5bMruhaAhdj9efk8kPlucJvj+ZEpf/P87Y407waI/rsIhOa/Db+m8/S8TIjbsYELv2cpwqr
 CG0VnHzCLhJGJE/hi2yGSo+DQ2M8F/PEF0nCNffpxIsXoP7rIWOHN7TKROVbCPg5EjpI4Cvs5R/
 1+OV3w1G+QUcdwSh3T4JoRmSH/kdMd7RrkBprQvIJyr/P1Je7Yf6c3Y6zfYFykT2Q4SvpyXMKFh
 PO6Rs+uR0x59Ue6Fp0cTRpac1pTH1Z4yglugWrtssxR3Q6Q==
X-Received: by 2002:a05:600c:4e8e:b0:47f:f952:d207 with SMTP id
 5b1f17b1804b1-483a95e251fmr77064715e9.19.1771770538160; 
 Sun, 22 Feb 2026 06:28:58 -0800 (PST)
X-Received: by 2002:a05:600c:4e8e:b0:47f:f952:d207 with SMTP id
 5b1f17b1804b1-483a95e251fmr77064375e9.19.1771770537681; 
 Sun, 22 Feb 2026 06:28:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a3df4859sm115680185e9.2.2026.02.22.06.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:28:57 -0800 (PST)
Date: Sun, 22 Feb 2026 09:28:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 17/33] tests/bios-tables-test: Excluded CEDT.cxl for BI
 restriction relaxation.
Message-ID: <de6eb4409525eb76a841911921a30a0ee1deddc7.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The next patch will relax restrictions on the fixed memory window
to allow use with back invalidate capable devices.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260204170936.43959-4-Jonathan.Cameron@huawei.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..b4646b5b31 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/q35/CEDT.cxl",
-- 
MST


