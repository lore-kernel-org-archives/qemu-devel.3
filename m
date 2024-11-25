Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B0CD59D6C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfzo-0004Al-Sk; Mon, 25 Nov 2024 15:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFfzn-0004Ac-GT
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 15:47:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFfzm-00046Z-56
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 15:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732567664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TNwIVqVXb9l5u0YJvKgR99pq/AUUWXCrVzK61oZQiLc=;
 b=M0Vrgav5dgeOCVb/dbfYJw6cahI1qRB0rFXfDK/x2jbAk/qSPINFJ95qN8ne6p+AiYA2//
 mwoVWVG4DexGYgHJrQro9eiMdXBAAaQMWNLq0czxcOFreNQoK0nFOpUPjC8gP7qOBxi0lv
 8OBDSqcmI9I3NW6D2X8GxMMRaK1oTWI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-sq3ODaC9Pd2LuTUQ4xa80Q-1; Mon, 25 Nov 2024 15:47:42 -0500
X-MC-Unique: sq3ODaC9Pd2LuTUQ4xa80Q-1
X-Mimecast-MFC-AGG-ID: sq3ODaC9Pd2LuTUQ4xa80Q
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83acaa1f819so534782939f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 12:47:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732567662; x=1733172462;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNwIVqVXb9l5u0YJvKgR99pq/AUUWXCrVzK61oZQiLc=;
 b=DF1lymal/Bj4VUZUP5MJVP+yrHXx2e9nXJSgFF8lofPOJZuIk9smfXPSXIwXd4DIIB
 9Tia3pdCjUJHtrCQDCoyCwBZZyhkd2+MZiaPgYBe9giSdrgO7Yka4ic0DymLXoR9jFeH
 PSkUmm00EDT4GmmD3hzuiYJDsz/dhrxN9hIQJtMBouj9eJi95O0iacJNeoUgJnY9xnC9
 3L6LSAHMAqMLe0Snls0VGpo92rcJPvSqjI5yVewGxZ+CYALYBbQwfQ00N7kelJhGlE7Q
 aSksi4wczObrPkmAVRXVx8mYdbHX9TlWfuEwo/nYAUxrCeT2olF/+V/cZ/GTjNJC6QQc
 NhnA==
X-Gm-Message-State: AOJu0YzABRpvdaBoy0h4EQpBR6XmXghq1H8EDSnNFXOPIlF5rbVj9REO
 o0faXBNz+pxCDEqfJZgCfl+mIrU81zGzkZC5BCd+qtIHtEM30COG40EBrrlQRIDg7Q/cOEB7Kpc
 Dhp4iOnspkHIjr4W4kk1dgP9vOt2hwCSuJCVF4CotbpVfuUS3qsTe
X-Gm-Gg: ASbGncsPF6CgF18D/Npgb9/RdiyQR3SCk/vFklKNxQeCTQbe6duw1Qc7uHjWbbXgdDN
 fEXyNCxylcZLNY4DGUtQBbdcra8Zb6J02ch9wXI3XrJZVngEKzmHTCCYatZEfmXbn5I76egXaow
 apQyVQvhhiHhw4/xfUkFvRk1vDGqOHxM3R3QgccxnpB7udQvk61sPKy2i2c+c9MhfIWWjSGs+t9
 VthZBXtEC41S5hPmiTwaq5Jh+I2+mgLGil4fM3iSrvcqqj7vnA7KRpFs9cdbYAVHID9LeUI/QDh
 YGkB2fs08Ro=
X-Received: by 2002:a05:6602:164c:b0:82d:129f:acb6 with SMTP id
 ca18e2360f4ac-83ecdd3a4acmr1363223039f.14.1732567661769; 
 Mon, 25 Nov 2024 12:47:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQbPb8YBklQ+LmIko4gId847u1JO/DXxE/PF6nbYaZ9/ki25TPVvnKb5SaNu5wWkyGCt040A==
X-Received: by 2002:a05:6602:164c:b0:82d:129f:acb6 with SMTP id
 ca18e2360f4ac-83ecdd3a4acmr1363221139f.14.1732567661504; 
 Mon, 25 Nov 2024 12:47:41 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cff34f35sm2249266173.152.2024.11.25.12.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:47:40 -0800 (PST)
Date: Mon, 25 Nov 2024 15:47:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 03/22] tests/qtest/migration: Stop calling everything
 "test"
Message-ID: <Z0Tiak48i3JnreBj@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-4-farosas@suse.de>
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

On Wed, Nov 13, 2024 at 04:46:11PM -0300, Fabiano Rosas wrote:
> Test frameworks usually prefix "test_" to the entry point of the test
> code. Having every function prefixed with test_ makes it hard to
> understand the code and to grep for the actual tests.
> 
> Remove the "test" prefix from everything that is not a test.
> 
> In order to still keep some namespacing, stick to the "migrate_"
> prefix, which is the most used currently.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


