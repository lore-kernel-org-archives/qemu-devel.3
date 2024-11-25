Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7317D58D71
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 17:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFdI3-0003YV-LU; Mon, 25 Nov 2024 12:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFdI1-0003YB-RN
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:54:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFdI0-0002BE-Br
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732557263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ol/vM6Z/oWJPo79SkpvWCfBbpvnLJw47UBtZqP558/Q=;
 b=bWcm6kpEVPBKLt83ny8OGFBzKKX/yhGBmsQ9Yrxs56wbkNrVZn/RQFAStuZerI+VishW0E
 yaYqu2yh1OsZgjDT8CQCr6lWx1aFdkVVJF/e13HQdpKmHAjTNAY+Pxnqx3DFb1N/3EdMEv
 DQijsjaMvM/HhLnGUM1EJFtw1g0l+VM=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-D8P8ZwMwM_uxBwRK3S3e-A-1; Mon, 25 Nov 2024 12:54:22 -0500
X-MC-Unique: D8P8ZwMwM_uxBwRK3S3e-A-1
X-Mimecast-MFC-AGG-ID: D8P8ZwMwM_uxBwRK3S3e-A
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83ac354a75fso533523039f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 09:54:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732557262; x=1733162062;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ol/vM6Z/oWJPo79SkpvWCfBbpvnLJw47UBtZqP558/Q=;
 b=K69EqQ2qI0WdHosGHJQ22CfSe457G+gN2Iq/sAnDbe/eLC9SNZjln7dlzUKdojSS5Q
 KyBPiho7esHjPZ89b0yVsyeMRMja6UBmb8LLmlsyjxuepWB9yUzMKu3Lic1PzgTnoMIn
 uYU0/GomEgq2PYWlE4OKZPFOrSJEKrGPzjVPAnAamdhyYkxaRMV8odHtY8RFc5mZMbp6
 5psJOjoSmj3vIWOtxQ1wSc3SqAEbjtLZW14/oj1x5EO+l5Xym9DCaIqQbxAmRG0CpoQA
 pvdxoOLg5isu0+bH6Z9ypftzSn/k7S73SmCWb9ViDL5sKH9GmZzj8o88O13Ev8eHxK3w
 1BNg==
X-Gm-Message-State: AOJu0YwhL66hLbJYx3gTEIDrW1n8yFuOrialHATfpo6nMoH5ddUUPyHS
 ML7S/G8t6meNIY1znQTb4KPZIFKUEuGKqDUw2vGZc0AxWxtYE422fn00oDf41lL8APECJqi6fb5
 xysGxtRaMi080Z/RuZAs+tYPH5FHs+JaYzc7ElR5jXdUVX8Rm8+DG
X-Gm-Gg: ASbGncsKIF2ZmabpKFNGJDp8LkE07ZpxLXWpSmN9yFEr/DLOU/lhAauBLeTWdCjUlqr
 K76xxLHGP2iQMUTfEI281/aBgxvHFuQzBNWzoEh+1ICDIPgJ2NtV/kQ0VfpFrd9cMdc424mqVZw
 DQ8xMct2r0PnbiopnxeU2bem/AtNGRNV+KcwWYTcWZ2Rry5T5h+bdKAuHdxDbldPGVJgSDYnK24
 lh6tBBWrGnUDBNbuWavlPh3s9awBoPRMmxoToJl+4dZL/d4hmJWXPiIV3W4QAKpkupYzU+0WbDy
 9i4dtA3eTs0=
X-Received: by 2002:a05:6602:29d4:b0:83a:a746:68a6 with SMTP id
 ca18e2360f4ac-83ecdc611d1mr1651078539f.5.1732557261868; 
 Mon, 25 Nov 2024 09:54:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEut/z5Nv9tyiuVll8peogQ0GuZ5vg5rVUNRk+e+qi+ecBkvGLHiNq3j5abR0vVcbIV8WIYgg==
X-Received: by 2002:a05:6602:29d4:b0:83a:a746:68a6 with SMTP id
 ca18e2360f4ac-83ecdc611d1mr1651076039f.5.1732557261612; 
 Mon, 25 Nov 2024 09:54:21 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfee978dsm2264959173.81.2024.11.25.09.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:54:21 -0800 (PST)
Date: Mon, 25 Nov 2024 12:54:19 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 17/22] tests/qtest/migration: Split CPR tests
Message-ID: <Z0S5y6zk2jLeSO4N@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-18-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-18-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 13, 2024 at 04:46:25PM -0300, Fabiano Rosas wrote:
> Move the mode/reboot test into a separate file to hold all the CPR
> tests. Currently there's just one test, but we're adding more CPR
> modes and the feature is different enough from live migration that
> it's worth it to have a separate file for it.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


