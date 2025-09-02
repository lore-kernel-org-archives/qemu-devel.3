Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3752DCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 15:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utTHk-0006CU-LW; Tue, 02 Sep 2025 11:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1utTHe-000683-W3
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 11:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1utTHc-000084-BJ
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 11:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756828252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O1z93Pub6Mp61IS2E3/nCiNg21wlLukxFEpvL9CDvMM=;
 b=CNvMCcJEYVMHp/lY2ep1bN78LfL9UpgW1m9cH0ZK2MZcQNDvOY99Pmc+QkVYEuRE7KeNBE
 yKK4OwbqorFD71w1LVZLzIMEOA+A2ORII3JwDcxTbFOqleDgckUP65XjxMYyyiFOC57tB2
 xDU91idziNaxeNXsn6dRlYPNYgkdtQU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-PSIv5fosNkKM1gZv3VYO5g-1; Tue, 02 Sep 2025 11:49:37 -0400
X-MC-Unique: PSIv5fosNkKM1gZv3VYO5g-1
X-Mimecast-MFC-AGG-ID: PSIv5fosNkKM1gZv3VYO5g_1756828176
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b9ca27a11so9555e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 08:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756828175; x=1757432975;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O1z93Pub6Mp61IS2E3/nCiNg21wlLukxFEpvL9CDvMM=;
 b=hGwGoe3T8hSIVYD9NIsG3YMXZ+1W73ymk5RbePNsvpdZVpJYXyHJrdkzFfovBzzoUl
 S3NwCx7BPIZFUCiDZ93QYPuNH7y9c6I/8V7cwthu9McwHlaTAxJDmumOx4pBcjJM4Awy
 KdypxpQ7mEqoRmTafC5rnqlHnCWANs1aqt7twYbdvB8FjpM5i/3EsqUgmEk/7zmAShTy
 UeI2XGYNX1zRe4dbSNxKBMS72WdfpBulK8tWbrCJRD5PTZhjqpW7US8ONhYLC6o+XMOn
 BCbykDn1NVoftIAuQjqPhY3JnkxAiXKBDza++rnENh9x9p+gIXpeN+DBYhqVm3e67gxF
 UNZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZzapX4TsmTJ20UxVH0hDbdDB4qMBd9BbV0qTA5AviphqVWDqBznXMTLMc+gm1HaGxX7pQAnVeioYT@nongnu.org
X-Gm-Message-State: AOJu0Yw3r0/Ze6h3Geq9ZKDjP9BBPeK+hCzxEkSlt0TtSU0niCUS2pfc
 HfM9XuhX1hdFHlSk9V0fwi8M+KGGL2PgrhF1xvTbJGSsvNMoLhcRslOgt7gMNUk2Jo+xQaLtVXr
 6Ady36FGYtUTXfjKxlUmCn60vfcpeiBdtcPGGhF9jjaGmceG9aiwzAOOE
X-Gm-Gg: ASbGncsF/RKP09oS+7QJ3CFZF+YIicDatxAkcRq5DANIme7rTqiBOXblxe5U4/r3QAG
 JESkaxf4MCeWozKwqiUn0QXcQD9AWkabfv7upq46B4ieDjnocSbodWICv+VbQdxwwao6p7/CJOt
 1JXYajgcoG+D09cNdeRgZwwLv9P05nMb56rWJSR9rmutCF3/FI9Gy6ZoVeRl09yXV3z4XXONo1A
 W3ZtUPDaekx5vy9u2mYUyT6lIcDGvc5GZL5IiifW8ktMAwq2cj7w5P9aWh/9kRZlVj1rLlx7mbO
 G+zu1tIJbayK/MYJMFkEczFuoXnDLA4ud04rSdUtzDx+MBxXrTn8vgZ7OX7wer6tmGX+rPjQZV5
 EOj2f8PLLA4Zrjw==
X-Received: by 2002:a05:600c:6818:b0:45b:733b:1feb with SMTP id
 5b1f17b1804b1-45b84c58673mr87438025e9.10.1756828175625; 
 Tue, 02 Sep 2025 08:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5F50p2Jjn0NMfNYTGSC0rcw62uzpx0Pd6HVdBpsVpb0sq/at7wOiHh5kJ9Fz2RTvLmDE2QQ==
X-Received: by 2002:a05:600c:6818:b0:45b:733b:1feb with SMTP id
 5b1f17b1804b1-45b84c58673mr87437855e9.10.1756828175189; 
 Tue, 02 Sep 2025 08:49:35 -0700 (PDT)
Received: from rh (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de.
 [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d1007c0dc8sm18485519f8f.53.2025.09.02.08.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 08:49:34 -0700 (PDT)
Date: Tue, 2 Sep 2025 17:49:33 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2] arm/kvm: report registers we failed to set
In-Reply-To: <20250902092732.706338-1-cohuck@redhat.com>
Message-ID: <eecb8e82-f4a3-5def-30ff-690082f6b582@redhat.com>
References: <20250902092732.706338-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 2 Sep 2025, Cornelia Huck wrote:
> If we fail migration because of a mismatch of some registers between
> source and destination, the error message is not very informative:
>
> qemu-system-aarch64: error while loading state for instance 0x0 ofdevice 'cpu'
> qemu-system-aarch64: Failed to put registers after init: Invalid argument
>
> At least try to give the user a hint which registers had a problem,
> even if they cannot really do anything about it right now.
>
> Sample output:
>
> Could not set register op0:3 op1:0 crn:0 crm:0 op2:0 to c00fac31 (is 413fd0c1)
>
> We could be even more helpful once we support writable ID registers,
> at which point the user might actually be able to configure something
> that is migratable.
>
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

I did some basic tests - this one looks good!

Reviewed-by: Sebastian Ott <sebott@redhat.com>


