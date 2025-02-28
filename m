Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAF0C282C1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 15:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to2Kn-0004H2-6p; Fri, 28 Feb 2025 10:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1to2Kk-0004F8-GM
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 10:31:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1to2Ki-0002of-6q
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 10:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740756682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=er+N8wc63IiPJA0XSWrxnqNShyXGuxVKGvIMv+w8+qE=;
 b=b25A2bnfX5rGnSQT50wI1WaOtfZbyDyuyNh7ECFhXyvbiZNlA1gt1UD0RVKh/uPrP75hX7
 vZDGsncRJmsnYl/yE5laYCSjTTn940JygzuqI1awH9hYFMo6ACWWfUGpfZUY/GysaJ02mB
 2SCZQSe4lBFHOvvZFKOwBhRmj5tJXi8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-_JkTiqkINLS43WaBrYclsQ-1; Fri, 28 Feb 2025 10:31:20 -0500
X-MC-Unique: _JkTiqkINLS43WaBrYclsQ-1
X-Mimecast-MFC-AGG-ID: _JkTiqkINLS43WaBrYclsQ_1740756679
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3ce865eff29so4680395ab.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 07:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740756679; x=1741361479;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=er+N8wc63IiPJA0XSWrxnqNShyXGuxVKGvIMv+w8+qE=;
 b=N/iLPG/JgS0InV5AtTKY93BH3u+1tNDbQrzE7wx4X7ZiqanM2yHaGD2/cEHE7grVuJ
 MsKOMOJH0CVcXe2GEqxmP+HUd8aiVyzSsl5ArC3yizGhRsFl2czLU/KxN/MLYXf0m9z3
 fV/ListQ1aKwjkG9UXKqTMxqSum2Dz5F71KINKbKKe76XzYqO9qTGuHbf7xxHWeUEfp6
 ay0M5en5huloJsQSiFSLyuU3JnN9l+E7v0KAnL8Gwq0C7E7vcJskGG8b93QQwErHHFQy
 8pqikgN0+3na5+GPUzozNKuZGxgflh8Kx+DpTqV/UzT7rLnOZL1/hRm7czAwvzDltiWo
 LyIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk76cV3PbsgeclB+YIRRonCGyn6KXwjLcsZ4PJB4draFakCdo6o/MwafqboGWFvpG+JxZwnXnylIRn@nongnu.org
X-Gm-Message-State: AOJu0Yw5PUGdJdSrX4bmbBFyIqkExi+j2A6xEMe/Kx1M/8OmUbfrZt1c
 UnRrvLyTSRXCvAnrpKtVlGLxEhsmB6R7fupCRP4c2K/YL7BFlt0X74MEmEI8Lb38yOZ/3rvEcIC
 8XyXfXRZvIRisHNAIHBoCTs8+dWI9o5B74RCs9eKc2mkvfuXLIR1Kh6Y4KMcw
X-Gm-Gg: ASbGncvPs5jDoxi2UeA466Kxs7eBNz3uEGv/zVbBKfRVxz1HG3V4k2E9Iy5ZLqyw7EV
 IH5OULAuYfXWvQAMTVJodCuc4S05nmZ83QVAOort5BbdQHHfWZb5/xgPtSYnvNXQfZxf+s9aBjN
 1XdIGkbsurPEsA6yc97E4s+qqkj/ivB+rZwX8BLGMm0Xp/n84/GmP9+Wa68ZDJOfw+g4P//CbpJ
 2tWcMeltRIaaAbm8UKEZtN8HoavAhj8OK1nr2FrgDYFlGVmB15j6r8OQ7HzbkOiEPSIZW8MIH0L
 jtxchNy7XVokWy/Ntwg=
X-Received: by 2002:a05:6e02:1fc7:b0:3d1:936d:1e22 with SMTP id
 e9e14a558f8ab-3d3e6e45d8emr8746135ab.1.1740756678749; 
 Fri, 28 Feb 2025 07:31:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOlWMfrABngDbBo20hUHjrIVNBESk69IOnlAj0VwQy2KXBurafR2LeYAsSbmcKSDZ41CgHcQ==
X-Received: by 2002:a05:6e02:1fc7:b0:3d1:936d:1e22 with SMTP id
 e9e14a558f8ab-3d3e6e45d8emr8745925ab.1.1740756677769; 
 Fri, 28 Feb 2025 07:31:17 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d3dee5d9ebsm9158395ab.4.2025.02.28.07.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 07:31:16 -0800 (PST)
Date: Fri, 28 Feb 2025 08:31:12 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as vfio-igd maintainer
Message-ID: <20250228083112.07d6a183.alex.williamson@redhat.com>
In-Reply-To: <20250227162741.9860-1-tomitamoeko@gmail.com>
References: <20250227162741.9860-1-tomitamoeko@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 28 Feb 2025 00:27:41 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> As suggested by C=C3=A9dric, I'm glad to be a maintainer of vfio-igd.
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  MAINTAINERS | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

We welcome your expertise.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


