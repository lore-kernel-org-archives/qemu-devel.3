Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448F4FED3CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 14:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGHAd-0002Ej-6F; Fri, 24 Apr 2026 10:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wGHAb-0002D8-WE
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wGHAa-00072W-ER
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777039571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HGWJOzmDgVRkNTfSSnRBxyLT2WjGlEsbKI4y2T3hvC8=;
 b=i8ts8uI2XCo2PideQBOYnlA5Wj3YrSXckf50Kwh/O2NqMMnvNVNUwojDRfcOz4kfXXVsdZ
 /s6vVXt2ITe6EVSp4cqvx6kUVgaZr4plNJXjamJrKBuWbSktb5PE10HpbLjFh6lkD0jVS6
 z9bWx2cXPFzdlgc20rHevyqXfzrsZlU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-nEq6jBcfPzGCFszFRaG-TQ-1; Fri, 24 Apr 2026 10:06:08 -0400
X-MC-Unique: nEq6jBcfPzGCFszFRaG-TQ-1
X-Mimecast-MFC-AGG-ID: nEq6jBcfPzGCFszFRaG-TQ_1777039567
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7de442b3402so5148255a34.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777039567; x=1777644367; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HGWJOzmDgVRkNTfSSnRBxyLT2WjGlEsbKI4y2T3hvC8=;
 b=H11OTjq7iJN7SqqaIgtBsUFv55u70QBmcam8j4L0AjmptevKj+c2Ab9OLO4Wk/K7ab
 UsF5rjLDFywPEGU1WQBg0IdZq6trv26+1q+AWXa7P6GLWM+GMMISqmMHk/gX8Lw7B2r5
 CGKoe11/gEghznUL/zB49tjXpvTgTHuPxUanzc2Pffp2vD9KZ4fOmrx5TPAXcnPOpVtv
 E2IKpzhOqdJzkKiE5GmHVsUivWaGvCP067xz5bUErj2nwkwVIbAYKKPQEI6n9LWD+EB2
 A9sWmSi2fPOTr7RbsGom66+3u7GT5vbea3C0mjFXGlg0c3CvbTLQBtkYGNfETWIN2uKl
 XbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777039567; x=1777644367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HGWJOzmDgVRkNTfSSnRBxyLT2WjGlEsbKI4y2T3hvC8=;
 b=p7eDuO4Z6gS9gdMvTl/hen68m7eS8TQml0pMnmW2y0uVKuWaF/iZkAEPPx7YuCcy7o
 8RumO2Xl67WB3mjjK7a5A0oWo7VrKreKaehVcdRy0Qpu0DUjLeO/xdIK3cnRrpNkMU9D
 exFWg4mdJiH2Bqmfg7ot3PnIngTX9ms8v2h1CEewi+f1TUQzn7CtxHIG1t73f+b5CbPJ
 b2deRZJSnd1cad7TxdEIr0ltDAGMVVwio+5VcvqqsyEaxzEiCFF5YlusoXVV5ziAHHxH
 RNwudPicmfYRIrzVtjmLlVbZFBU2FSHXjv0NLm3CxebTTVIxJan6xPkZnIQ95seD9h1B
 ab8w==
X-Gm-Message-State: AOJu0Yzqu4wEi8pnE72YsFCqGxFnvJyGPym+1yYC/ugHSL8MUy5RO4e6
 Fg8KTMsnewQ/ULjWA82HqSd8BYU9B24MovE8sYspUQ5CJwUkVUaSJMdOXXwCozb3/AfulBt4aIm
 bMUek/TI/ijfJ160rTGnIZLzhP0hW8rTAw0ZuKj37fklWEbfe3EatEroT
X-Gm-Gg: AeBDievuUGu614+1ELHvl3aQ3wpz1znU8To2VeQNg/Dv+mBVyyHK14UlVEVDW2eQM2K
 8igDI2BVzSXqT2mMThNTS/0YwJSo9Qa/OCjH+x6NDS9Nw710P8hCiaZh/UlpqzaSfX/RRffSGFn
 ZItkK4H4WC9XEq/l+eyWP/2jMm9SxR/OAB4xetfaBfVg0nsm91/PN13ycebpaIj2IhWosN0G8tI
 Yz/JaJrzA/Sf9YpRvlOyafXE+FCHuNhZQrG+NouijVks8qxfdyLCkNkv2rivR0VM0p0V3K4sL7H
 JfI8n1fCv/S2NDF7B8CjMb953oMeciDvBGLVD1JBaPI2CW54YDL3I8WNVgMAm5HE9sPiAk7CO76
 aIdkdFgv57hJelY7kgh7hEPOeK8vnLAYQtUaqkLOlnJrSAQQ/7ptwWH/8ew==
X-Received: by 2002:a05:6830:2b0a:b0:7d7:fd71:f2e4 with SMTP id
 46e09a7af769-7dc9518becbmr19395319a34.14.1777039567062; 
 Fri, 24 Apr 2026 07:06:07 -0700 (PDT)
X-Received: by 2002:a05:6830:2b0a:b0:7d7:fd71:f2e4 with SMTP id
 46e09a7af769-7dc9518becbmr19395253a34.14.1777039566566; 
 Fri, 24 Apr 2026 07:06:06 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac7d4e6sm185486416d6.20.2026.04.24.07.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 07:06:05 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:06:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Samuel Zhang <guoqing.zhang@amd.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 eblake@redhat.com, armbru@redhat.com, Emily.Deng@amd.com,
 Victor.Zhao@amd.com, PengJu.Zhou@amd.com, Qing.Ma@amd.com
Subject: Re: [PATCH v5] migration/rdma: add x-rdma-chunk-size parameter
Message-ID: <aet4zLIat1S1KzOi@x1.local>
References: <20260413035703.2602065-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260413035703.2602065-1-guoqing.zhang@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 13, 2026 at 11:57:03AM +0800, Samuel Zhang wrote:
> The default 1MB RDMA chunk size causes slow live migration because
> each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
> 1MB chunk size produces ~15000 flushes vs ~3700 with 1024MB chunk size.
> 
> Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
> faster migration.
> Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`
> 
> Performance with RDMA live migration of 8GB RAM VM:
> 
> | x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
> |-----------------------|----------|-------------------|
> | 1M (default)          | 37.915   |  1,007            |
> | 32M                   | 17.880   |  2,260            |
> | 1024M                 |  4.368   | 17,529            |
> 
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Li Zhijian <lizhijian@fujitsu.com>
> Tested-by: Li Zhijian <lizhijian@fujitsu.com>

Doesn't apply anymore..  Samuel, could you rebase to this branch and resend
(the major diff is Fabiano's recent pull; it'll land master branch too in a
few days)?

https://gitlab.com/peterx/qemu/-/tree/next

Thanks,

-- 
Peter Xu


