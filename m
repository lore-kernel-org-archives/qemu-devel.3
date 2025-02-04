Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A19C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfMR5-0007mu-Sn; Tue, 04 Feb 2025 12:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfMR3-0007i6-R9
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:10:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfMR2-0007eu-7E
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738689003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xVCjVJKRa6rCGzbxsVtoaTu9+R8rthqeY0TG7PHLpqo=;
 b=CrB7sdOoJ7XZQ46lbsJClGfSjO9POcfVKT09panwRrCO6k4b+2agCloynQD7qDTYiGPKcW
 kB4rXyatgQ9nHyV44/OV8ICcXI5Pqj1hgYEpyT0XOiHpnfimK11frqqXIZeRZdA6PHqsXo
 nQdTDqWYd4lntAahKYDRoM3f72zOoc8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-Q2d7FA9MM5ue6WZxqrgpPw-1; Tue, 04 Feb 2025 12:10:02 -0500
X-MC-Unique: Q2d7FA9MM5ue6WZxqrgpPw-1
X-Mimecast-MFC-AGG-ID: Q2d7FA9MM5ue6WZxqrgpPw
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6e9fb0436so1802494985a.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 09:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738689002; x=1739293802;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xVCjVJKRa6rCGzbxsVtoaTu9+R8rthqeY0TG7PHLpqo=;
 b=UqgTm3BhYpl4UOOwBz0H23sa2eXbYM8DAC4edfMFZhVzCfZanfHKTfPKHeWFx4G8YI
 ow8dzTHgXdtkw981ZmwuwimmFdi1nZ+QNSXoBWELVY644UqpSdmnLQK0Ihp36xWk0JQx
 9UYPBqHdUyYAFM6G+8svD1KeXrSlbqoqiytq/RzfmVQmw/yXkAdvHTl5MU32gmyVOSbU
 f4AcyyPcUqozXpUhrcs4caSWmodD2QHfgfxW7r0Xxew9fHCrwdM1XVgC0+wZXwNgfuMU
 72/0cSHp+mO+tIALTG4IRBFq3QnY5VLxTuJlr5fd+8G5qSEmFWrZCwSJqI8QTy7zp6zd
 1NPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyj0+fJf+QZL88UVXetpUM9Y50N1l54ratfhL6kTeruo9DNjMdCqdzw/1ZFEepwxxppYhnjz7Fgvw1@nongnu.org
X-Gm-Message-State: AOJu0YzG73mLfnrxrJ7gLfffe3xkwDRgybxD6F+GH5ENBW6wBdYn3tQK
 anhPB7y32pRzmslv5BuyPIDbWYOXB6ewdW19nheGELDKSPEQ6iK43HT9iL2Lpw1gTJzi9Jz/0yx
 7JQ3ZuEUn6e+4nmWFVVFwVF3Y6q8WfEaTlVclwkUrhy/5Fma9x6gO
X-Gm-Gg: ASbGncsgfydBPfRks/cLolflLxR0/YSYZ5DILzfTP21j+91VkS56dnvumvrueNifne3
 ZNIAVYioFp5bT5yQpb62yD58bJQH3nuFFbMoPP5/HGxld/sbKtQ2DT47OiDmzyz5iebpc61W9pV
 YZRS1qCnLnAWWDtAPrnxcgTU+hxHL9rhMwGlOnsg8fBQz7K+6HKy2JbkZwnEsaj/vQON2p9xRMS
 C43KsWeT8AngUHEdEz7wXktOAzod3j5gGbCPRDyF4UxmR4G5PWNI24pZ3qL+tEbSHtiqtMKj80x
 cbE2nto4VIIUIu5RXfhX6pnMeO3lCqGSMLR2YRg6YvvVka+S
X-Received: by 2002:a05:620a:2b43:b0:7b6:773f:4bd9 with SMTP id
 af79cd13be357-7bffcd72656mr4004062785a.42.1738689001898; 
 Tue, 04 Feb 2025 09:10:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEC4lE0HJi92BGr28xSeI4M1nJBeQd9vtedvuNpDv0EWzjAYwIvs6C+dMvku0kr8+woH+SH8w==
X-Received: by 2002:a05:620a:2b43:b0:7b6:773f:4bd9 with SMTP id
 af79cd13be357-7bffcd72656mr4004058785a.42.1738689001642; 
 Tue, 04 Feb 2025 09:10:01 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a906518sm655190085a.84.2025.02.04.09.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 09:10:01 -0800 (PST)
Date: Tue, 4 Feb 2025 12:09:59 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>
Cc: david@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, imammedo@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v7 1/6] system/physmem: handle hugetlb correctly in
 qemu_ram_remap()
Message-ID: <Z6JJ5wapMy7PAhwO@x1.local>
References: <20250201095726.3768796-1-william.roche@oracle.com>
 <20250201095726.3768796-2-william.roche@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250201095726.3768796-2-william.roche@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Sat, Feb 01, 2025 at 09:57:21AM +0000, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> The list of hwpoison pages used to remap the memory on reset
> is based on the backend real page size.
> To correctly handle hugetlb, we must mmap(MAP_FIXED) a complete
> hugetlb page; hugetlb pages cannot be partially mapped.
> 
> Signed-off-by: William Roche <william.roche@oracle.com>
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


