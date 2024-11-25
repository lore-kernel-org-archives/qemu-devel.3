Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DA4D58D69
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 17:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFciJ-0002Wt-BZ; Mon, 25 Nov 2024 12:17:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFciD-0002WE-4F
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:17:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFciB-0003kB-2t
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732555041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oe0Fo3inwwA4inD2dasWJLmGUrxNB5pFvqKSxVVP03g=;
 b=Bc9UYzC8aTG/zxIXIRtpmUrSVgfKAjbSN8szJ6XOaNgjCF63Olsfly/VIPLPvtnPEubN8Z
 cjqpPF7NdhLgpdeSiBHlwtKSGi6u9S+fo9PUDgl9D7LGHFHLe1SNH6VBOmCDGw/paY7+uS
 gc8zTqWEE3F1sCXNpGQrXShBtCHTGzE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-4StW0SsKNkCN_MNXPKr76g-1; Mon, 25 Nov 2024 12:17:18 -0500
X-MC-Unique: 4StW0SsKNkCN_MNXPKr76g-1
X-Mimecast-MFC-AGG-ID: 4StW0SsKNkCN_MNXPKr76g
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83aed4f24a9so511791039f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 09:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732555038; x=1733159838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oe0Fo3inwwA4inD2dasWJLmGUrxNB5pFvqKSxVVP03g=;
 b=r6VCEgw7Z1t1EB+ElBMHGEIcoqtWfb81ixprCfCP9cTp/r87/8msprnbA1NT+XOfAT
 vwW7XOVr0yzpC0rESHHNIh912Pemui7S59q+fzBNOCII/0JyPPyl3zuGB1L9Djel22U3
 Sc7xwrQDXRAwVYVoDpyj+ESO0/kkZOWUJKfdD0pqI7B46CuS0Jl52BPxaJ1NBMZAldio
 sKJSmUneduj88JLPWAaXGkIYF6WWSOPhMcosdOl1C6ATXK9tltAh6hBSzCYLizQj/gCQ
 m2mZoI38J9Bd9cNqGFeP/zGo3bDMz10vgToxY8JihhWD24gy3lTXCgBdRrLFwsEcgIG4
 Z6Cg==
X-Gm-Message-State: AOJu0Ywhmqhlfu6N9WYEAasm5eXOrtzZtxrx4OB79nUtVqM+RtaWEoFA
 jrimnoeN6QiXxio/8ooylqfYK0KZ1sg6rwOFLXipS33noBJIyrh3WaYQ73puFISbP3xzBU0BWAo
 pUevpG79sxJ0F05uqYKG04yWREL8IIpP0HEW0kP0wv0mq/rJAuQ4S
X-Gm-Gg: ASbGnctDCda03xkFgIV4lLJ2J+fbQyNJUnAiDaElH591+T1q4AA/rNrWE9w+Tjgy8a1
 SdgOmcZrTCAhaDrzdpXRIVT4ZYdz1apwOGuKNGxsuRbNcwqf3NO/Vu9zx+Z/GVOLXqbylBjmuV7
 uk2mkKqqBCeK2bwfmLlTpKQNDlmrYCsH/mD0wqzFeBbms29F1t7P38vuLwzkLOfs/49JbGz3rro
 35HoFcO+p35b8NVIVPGGmCMojjPSUHcpx8S2tYrLr8p9RYwHg5YZWgjZsvDM53ssM1MJlZtwmfy
 633586Krvcw=
X-Received: by 2002:a05:6602:164c:b0:83a:a9cc:69ff with SMTP id
 ca18e2360f4ac-83ecdd2ff2cmr1306644339f.13.1732555038160; 
 Mon, 25 Nov 2024 09:17:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4NStYuYnNFVe31ZYj24CNbTr1F+LcsqbI42ltRcK96JzPmW4rxWdjB/4HHrwa/x9NCHNvTQ==
X-Received: by 2002:a05:6602:164c:b0:83a:a9cc:69ff with SMTP id
 ca18e2360f4ac-83ecdd2ff2cmr1306641739f.13.1732555037858; 
 Mon, 25 Nov 2024 09:17:17 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1fb9fc168sm871532173.139.2024.11.25.09.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:17:17 -0800 (PST)
Date: Mon, 25 Nov 2024 12:17:15 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 08/22] tests/qtest/migration: Move ufd_version_check
 to utils
Message-ID: <Z0SxG5H_F8926l_W@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-9-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

On Wed, Nov 13, 2024 at 04:46:16PM -0300, Fabiano Rosas wrote:
> Move ufd_version_check() to migration-util.c file. This is a helper
> function that is used during tests definition so it should be
> available outside of migration-test.c
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Nitpick: may want to mention the thread_id change too in the commit msg.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


