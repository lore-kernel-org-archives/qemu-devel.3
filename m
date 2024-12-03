Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFF9E74AC6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 17:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIWkE-0000r3-U9; Tue, 03 Dec 2024 12:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIWkC-0000qs-RQ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 12:31:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIWkA-0003D4-Ri
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 12:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733247084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ivEQ5KF4QjZZCmYBBU8dCuys1A/tXGfH7f4Cl/VKTc=;
 b=ZiVkGXJBPcDp/pUdC3LRINITwZpXnCBJE3q8E6z/G8BNmqtuIJiyjJW3J9u+/1Z1TnXS0i
 o0gzXBW6AXdCY4ZY7MBO1BXXaV7+FVI/G/hRCRKDAIGshQyS1Ppl4UHIq8FzC5dq4MT0vM
 nuFAJGae7b0zCi9DAkCkoZVkmjnDMiw=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-yh0OmuqxPgC-Jke7pqj0Fw-1; Tue, 03 Dec 2024 12:31:23 -0500
X-MC-Unique: yh0OmuqxPgC-Jke7pqj0Fw-1
X-Mimecast-MFC-AGG-ID: yh0OmuqxPgC-Jke7pqj0Fw
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3a7807feadfso52721205ab.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 09:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733247082; x=1733851882;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ivEQ5KF4QjZZCmYBBU8dCuys1A/tXGfH7f4Cl/VKTc=;
 b=pCyHttueZ7EeizAoFnZLiAVlrte3Zqp1VxaQxY6ze9FKLZSlKYMOj+vbeOWcFyQnmX
 MyqF49KZurJImiIhvC9tGDAqJ9HygzWP48o5morZsPvz4+FgNCRGQN5QH5rl8sxZa5Vr
 mY8lf7J2CXONzc19E51XcWnzhw9Gdm6wnHMV3NNimWhQ39UqqUGOAew3MCMmgS+xIBJx
 eCGVdpT3EQyKm3mhDQ3+8ce/gucpQw9aAbI3YuFCHTKY3xHwtPNWHSCpumHbvf5n5Gct
 ByD/NH57Tiirfs6iKlGDA5UnW/E8ipqfjCeoMfQHLGdyOhp0z6CD+ZWUvJmMXFcE7a9t
 jJ7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa6mTIHzDVj+pNDb82Jvhm6QAiVRAg3glkU8ZOIdJ8CE5MjiCxZIHjcnWJs6nTvOOzvWXE/vzue7B7@nongnu.org
X-Gm-Message-State: AOJu0YyUhHoB1bDV/MMhe022fO7NCR01DuqmpL/goegnVdENV8NgaY3p
 13EHwEaDPsBgpZJITQtjjVxTrTYZTn3izOUCvPdB2S3bqfMoSBecapb6uRKUQdCOysYj3+NEjOE
 x4/4F+T6rEueLOFU/e+qRTVKPBaZnlmaIHGBaD6co3raqKZNatp5h
X-Gm-Gg: ASbGncspJAwo47EAxbf/4fWQPsZEwULpxw5BRbTUPVnNV7JwWbrZTSbIbh55x3w/Pwc
 NVkvTcuqKSfRmegnA6MAOXxWyNwYO6mW2xKfwCkM24Mp8nfNRMAZaZ5ye4uVBEss3Lpqc79bz6i
 0enw0AUn3DE6YHZPoy61spPGreDqhJH2RCeCmd3FMJEuCTM+fBsYjUWxgfFA+NDM+t3Hidqo9su
 9wlA3/fLCv2xapeq4xdZXpbotj9emPQrxg695Nhrh2G7YQjKqFmg1LWv4XGYNq8P7q25oYyTQqt
 /xlznGQurAo=
X-Received: by 2002:a05:6e02:1909:b0:3a7:d5a6:1f9d with SMTP id
 e9e14a558f8ab-3a7f9a46816mr40697195ab.9.1733247082668; 
 Tue, 03 Dec 2024 09:31:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/XKI9zJ1dq3EiMuZJu1KRSGIeIzCRhh7mHDWweOkG0j2812OcIVGddSN7OKyVJWwxnuGCQg==
X-Received: by 2002:a05:6e02:1909:b0:3a7:d5a6:1f9d with SMTP id
 e9e14a558f8ab-3a7f9a46816mr40696865ab.9.1733247082285; 
 Tue, 03 Dec 2024 09:31:22 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7ccbded5esm27028225ab.6.2024.12.03.09.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 09:31:21 -0800 (PST)
Date: Tue, 3 Dec 2024 12:31:19 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, linuxarm@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH] migration/multifd: Fix compile error caused by page_size
 usage
Message-ID: <Z09AZ06nSg2R_TIZ@x1n>
References: <20241203124943.52572-1-shameerali.kolothum.thodi@huawei.com>
 <87zflcj485.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zflcj485.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Dec 03, 2024 at 10:17:14AM -0300, Fabiano Rosas wrote:
> Shameer Kolothum via <qemu-devel@nongnu.org> writes:
> 
> > From Commit 90fa121c6c07 ("migration/multifd: Inline page_size and
> > page_count") onwards page_size is not part of MutiFD*Params but uses
> > an inline constant instead.
> >
> > However, it missed updating an old usage, causing a compile error.
> >
> > Fixes: 90fa121c6c07 ("migration/multifd: Inline page_size and page_count")
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Wanna pick this up for your qtest pull for 10.0 altogether?

-- 
Peter Xu


