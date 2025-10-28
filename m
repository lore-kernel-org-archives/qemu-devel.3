Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD22CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoe2-0005Mc-Lr; Tue, 28 Oct 2025 14:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDodh-0005ET-R3
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:41:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDodP-0005oW-D2
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761676884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FRuQL0V5jEYZXhTBhriqZ7fEok/jJhmd8zExR7Hsjo=;
 b=MBfZsGGF3DwQ8lWIkPbo9VD4YzUiCEEtfKPA22Q1Sohb6zgKdk6FSUcs9bkw2GvBxtZngu
 w/fTdxy9doCGuP99vS97hlfY/XVXJ2xlGPSwgeI1ZjXcMAzIWHpEWjVTYQxnu3aKPyaMEN
 7h4dD/qNH5kuqIdipJZ8ZawROdtyY1M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-zyEM8zQ-MuCXFleNemN8Sg-1; Tue, 28 Oct 2025 14:41:22 -0400
X-MC-Unique: zyEM8zQ-MuCXFleNemN8Sg-1
X-Mimecast-MFC-AGG-ID: zyEM8zQ-MuCXFleNemN8Sg_1761676882
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-87c1d4853ddso166845626d6.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761676881; x=1762281681;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6FRuQL0V5jEYZXhTBhriqZ7fEok/jJhmd8zExR7Hsjo=;
 b=KToM8pQq4Dd/Nj/CBKV0DHKs70YyvoBPNmTnyFukCOzheOL7lwL7uBETs3YyKHcMdd
 r0IUL4bEO3LR0tN85erovS81ax28x+X4vVuFGOME9vfOvbceR/L4576nRDgZjqdOU7e9
 RKJEM8IcGwki4C/uhpW3Ub7hOPd/S453N2DhucsYFM1Mqlz3apUyDFlkA29o5VpuJyIM
 ASGDlU58pnY7p1rY78jW3hjaLVuI6VnpHLIpkSAH9bUwCKWtEiB9itwvX/d8BnMH9PI/
 oEWWkehFrfsxJoXlu21ShyXCOVjKF1uvDis0uid4DuI2ImEXfcKidm8877mRKZlrKKOR
 IWVQ==
X-Gm-Message-State: AOJu0Yzh+oUKTU/jH2rQ8dT79nSZbATvnKIBYZURwpyO9+suui5WHJMV
 3TugP2sPyVGhjr4YvtLmL4TH/32dcA1/5vXXLnZ6lNQmq2eKs3UKmp+NkyTpLw8L4n8EsLIxepf
 mf1uhfr46hxR3SFSlpCHS4HAsdaJcynOsDwvPEAPqVpdKb+b7x4fQqAyf
X-Gm-Gg: ASbGncuT1gzey3DEbLPt3JGKdTJPanKsiBNGg+UjIQs45RkyL9O8qqlaIUW48kPSDnc
 8Jc5C8WldNg8WXr2mzVyX9B8mWU2VoESz500M4TRfh95lWQ1Q6nnEy7JTg+CPTVGnyTOAc0fmT/
 bJwXm0eO/Z+ji4vLmQeoXfzcjJJavbvGKXKzlZc7OSWJ+g5ecW2fBizsHMIzE9DtZy/g5TTqytw
 Vvcpug5t4wsBtebxKHqV8JWm3DavRbsHqQXNwFL1+RjThzSwe4dNKs1K7Y4MK4x/5zINvuOHlxr
 VjHTAsQYF/Eb/2HJsL2CMrfFTrXRD7L1sngmpE1AQHBmrlI54dlbVLRyJ9aJM3wXCWA=
X-Received: by 2002:a05:6214:d49:b0:87c:24f3:6693 with SMTP id
 6a1803df08f44-88009b37690mr2049036d6.30.1761676881532; 
 Tue, 28 Oct 2025 11:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkPsEnnE7g1Uf6RH2HEE7aTYdjS7+iR4eial9xlbs8HpB7umH/sACTpW0SpBZTq08cA0PITg==
X-Received: by 2002:a05:6214:d49:b0:87c:24f3:6693 with SMTP id
 6a1803df08f44-88009b37690mr2048446d6.30.1761676880987; 
 Tue, 28 Oct 2025 11:41:20 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87fc51e3746sm80213396d6.25.2025.10.28.11.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 11:41:20 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:41:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 11/25] system/memory: Introduce
 memory_region_get_address()
Message-ID: <aQEOTg_6csrNmiPn@x1.local>
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-12-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028181300.41475-12-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Oct 28, 2025 at 07:12:45PM +0100, Philippe Mathieu-Daudé wrote:
> MemoryRegion::addr is private data of MemoryRegion.
> Introduce memory_region_get_address() to get it,
> similar to memory_region_set_address() to set it.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


