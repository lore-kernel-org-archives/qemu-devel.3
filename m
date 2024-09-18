Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058D8CDD548
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 16:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqxnC-0002ll-2k; Wed, 18 Sep 2024 12:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqxn4-0002hp-CM
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 12:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqxn1-00072a-2L
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 12:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726677866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uj+sgWn8upkTsVFo2DikLkVHuJVGMxpTC6nqQ5i6ZxM=;
 b=MnuKggmSWQEt7RwTj7Ew/lZAiWlOuu3i0C6efVUsqN4xkD8VIphDjOwECEyN5vTSeH6W8O
 AF8AqEbnxv/MX/PDicjXrOoP5K1zneTpbjC8EYtNHVY36sNWf7o/Ge4uY1RMOu/C14ILcJ
 KVr7cOd4oZN2pxQeNc8r4ukHSodNfds=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-NKC6M-5MNEaLuuvrXW2fLA-1; Wed, 18 Sep 2024 12:44:22 -0400
X-MC-Unique: NKC6M-5MNEaLuuvrXW2fLA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6c5be17fa0fso13149106d6.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 09:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726677862; x=1727282662;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uj+sgWn8upkTsVFo2DikLkVHuJVGMxpTC6nqQ5i6ZxM=;
 b=InDSERLWKHuhveSHsZfFQvux49q8RJU7yySfj//IHxq5uQ9VziM4kF6bw+WPYpxtGW
 4PyjyUrHZBNn3KE7atB+QcnrWWi+hIQS83KSf2crkur2xSAOlYtTmAj8k9IVUP5p3eh6
 PdUNdU9J30SPJol0IL4NgUPK2GBNc05kBzTRIgRRGuALdlYX3zhePhYiY1knoecfQYej
 EBlbngolnVcgO0fentHeTgNo0ehUb0k6w4Gs4lmA4YmIKgp86CAh76KJfvrUV4raVn3Z
 6pNn/OVb9qSqNM/Mw6RnV7BH0193LM40l32G9v8fXWOcPRIXiX3OCfTzaQzRUh+1Cz87
 93Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCXknhfzWWamR/9dyqB4Rd7wWeosVYCsYAVHjrz+mDE9ew5f/bB27anlZZud57BNURLwQH+FbiTUz6qB@nongnu.org
X-Gm-Message-State: AOJu0YyDiUHbSXfORR1mwa5j2VOAHHSBkW32csPxbwMMo9pX5vGGixgS
 4BK4D3vwRxp0s3ePeyRvwuTFuB3f2PKTx5MIM8xjy5B9sunGlL5a3/ycrkNB9w8VV+nrtm0eFKl
 tD1x/p7IHlSyzVmhMZX3pS6DrzNUALfjduoH8BKmF0nP/Co7FAySB
X-Received: by 2002:a05:6214:3991:b0:6c3:5395:fe81 with SMTP id
 6a1803df08f44-6c5735a3b5amr311582426d6.53.1726677862075; 
 Wed, 18 Sep 2024 09:44:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIsmuGhDFO8FGnwP37Wr2YC+545o1TYFV9v8yAb+yiVrr4gZ0EzI+hm4lKCA/YsgOVvHobZA==
X-Received: by 2002:a05:6214:3991:b0:6c3:5395:fe81 with SMTP id
 6a1803df08f44-6c5735a3b5amr311582206d6.53.1726677861744; 
 Wed, 18 Sep 2024 09:44:21 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c58c636769sm45900336d6.55.2024.09.18.09.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 09:44:21 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:44:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3] memory: notify hypervisor of all eventfds during
 listener (de)registration
Message-ID: <ZusDY1NziNoet-BS@x1n>
References: <20240918064853.30678-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240918064853.30678-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 18, 2024 at 12:18:53PM +0530, Ani Sinha wrote:
> When a new listener for an address space is registered, the hypervisor must be
> informed of all existing eventfds for that address space by calling
> eventfd_add() for that listener. Similarly, when a listener is de-registered
> from an address space, the hypervisor must be informed of all existing eventfds
> for that address space with a call to eventfd_del().
> 
> Same is also true for coalesced io. Send coalesced io add/del listener
> notifications if any flatrage for the address space registered with the
> listener intersects with any coalesced io range.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

queued, thanks.

-- 
Peter Xu


