Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2391D66BA2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 20:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVy7B-00056r-AO; Wed, 17 Dec 2025 15:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVy7A-00056F-5W
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:27:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVy78-0005nV-LZ
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766003234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TebtAd+gSaWqNVJFJPHtCbG9b9Zh6VR7vcxAdvehGcE=;
 b=WOPNNGnhnJvRSgqtpi5LwNtikskE+9wjReAYxqesyYhoUPEJm8zhIQ/ZMvIUv50Di8HED4
 fe+GQ2s8lxO/Jv3pXhb5EN6X4d5gkHTX2PGqExHW5P/D6bifJgACwKwy6ImbbuWRphkmTM
 ItHAf8jIkdpqN0vA5Gzq90aB5/IebaU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-psb6Y7wxP0KyW3Wz9pZa6A-1; Wed, 17 Dec 2025 15:27:12 -0500
X-MC-Unique: psb6Y7wxP0KyW3Wz9pZa6A-1
X-Mimecast-MFC-AGG-ID: psb6Y7wxP0KyW3Wz9pZa6A_1766003232
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88a344b86f7so126342956d6.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 12:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766003232; x=1766608032; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TebtAd+gSaWqNVJFJPHtCbG9b9Zh6VR7vcxAdvehGcE=;
 b=T/4Epz830m+hkhmmHKnYjfKAydAhEhMaZt8vvebVNGkdrECqQ6akajIGstL9Nwy5Ru
 KAV8amjQ8kC16hw2Zl4tiu5SmDdmNYF7YHYbHuU9z7UWL5BS3QsHoDufekS4ngfuaTAz
 9UScvTh28z8cZXkU7yRiM3FT69yGNcfveO/qm3GqjAmiIiiFpUPlCXC3zcSURtmyfZrP
 Gap8MFdXq7wEOuY6ScRLTClWw98hcto3sqFsPxqMPZmXMc6PwHoJeGt6hgZ7djzn2xZU
 mqGkyI1Gj1DIQxdTjIF3LuoB+PzU7VGLhi2hf49Hs6oqBjPKB5FjXKylG0EKCXuerVVe
 bzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766003232; x=1766608032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TebtAd+gSaWqNVJFJPHtCbG9b9Zh6VR7vcxAdvehGcE=;
 b=pNqpWynWbqbAbebL6aWcSkTn1BtoI6w/pOWbUUUWP2721rl8JcGJDmKKY9wUL7YKkC
 AYxCvAeo2axrFUwlvQtIKrlVdL2APrsJyYzoAUiCAuMPGuTkDOSohrOgPK3lSb90JR2I
 b4aMYvLGJT2/vBkJHcNiIcmhmwJaXL7fKxgzk2EmA5MgFa7/MolfMnqpKHy7rgMcMgpV
 /1JH8W+9AGXpQPaWbjzFs+qv0YZPCR9dLFh0iqDJ3QwIeNd253r0QAEB91ds5o17qxfU
 2iWm4ID0m3OXmhMogURnmwR5XOm528pDG3exq7V0ksFqdiOHUrVXLf3b1hFNBHTIkC/n
 ZZ2A==
X-Gm-Message-State: AOJu0YzDmBRp9aNf4O2B9IIPmdlhof4nIUrnFsetVxd01I7pEJP78Kq2
 ctrbGQsOrK7IExt89VOXV7LYFYCe8y6+GpKvvl3F+vaCSMVkhs6e/t5Mq1DR4NzDBSM0U3c1CIT
 qnB4hGdCCd6MwFFVlcgPb13hnLZNrexIoGv4EBg17Ei4D6dg9yh0VtZ7C
X-Gm-Gg: AY/fxX6J9ufL7J0um0CAb6V8+BEvGbSE7HtKQAJTii+/1nTyor7hLGViSiJMTGHXEU4
 mc6+rIskXWwTmmeh+UFfM5O0RDphSvEuq+TXnGLftf6pUA6GekD5ozDD7zLdb1Wq8qA57qR9ANI
 i80mQrtOzftY7wtHXU16mPSmkW8YB1wnl4R9nEzuAt6Dxud8+lkqjwl4ZyXiKxqLz9ZTz5itxJs
 aHr2W3Mcb8GTsPenI2fV+YxER+tDWm8MQxiobjDRr/xCtxw1mhL0oHI+JIjaO563Xxke0M/WDOy
 pF41AXmnqh+vWfqS2hnpqU/Gh3jnBMjgp/IBVXuBqKANNYRgcF8zvAtaXzDn3Jpr/UZD9v4Kvdi
 cPI8=
X-Received: by 2002:a05:6214:3bc8:b0:88a:529a:a531 with SMTP id
 6a1803df08f44-88a529aae76mr65584656d6.48.1766003231944; 
 Wed, 17 Dec 2025 12:27:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPcDPhjRoq1rYfhZPEDo+FwMs51zyMfL2vwPFNFdYron07B3QP8XII9l8XT6sOrHMjTyDrOg==
X-Received: by 2002:a05:6214:3bc8:b0:88a:529a:a531 with SMTP id
 6a1803df08f44-88a529aae76mr65584346d6.48.1766003231546; 
 Wed, 17 Dec 2025 12:27:11 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88c5db7a7ffsm2968206d6.11.2025.12.17.12.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 12:27:11 -0800 (PST)
Date: Wed, 17 Dec 2025 15:27:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 29/51] tests/qtest/migration: Add config QDict
Message-ID: <aUMSHnmPCIXa0a3t@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-30-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-30-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Mon, Dec 15, 2025 at 07:00:15PM -0300, Fabiano Rosas wrote:
> Add the config object to the MigrateCommon structure and allocate/free
> it in the wrappers that are used when dispatched every migration test.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


