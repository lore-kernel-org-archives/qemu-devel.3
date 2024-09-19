Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA11CF3962
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 17:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srLET-0000Ew-5p; Thu, 19 Sep 2024 13:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srLEH-0008Kh-TU
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srLEF-0001Gl-NW
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726767967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nhU0TVVjiOwfSHNcNgNnJbcqIFXpQ2RgMN/pm5hZsDc=;
 b=AA/EVf73+7fmZHauBSuAowV3aS0aE0CVOalDpi2PtGDglJyje/JT32wzxXJyGsfn/xiu+a
 p++B3Mg0h79PV/r9NQorYlRdBW6g6Ke7mi/cTpyCWoDCHDEgEfl4uyH26+yPsY514JcwZG
 LKxhPx7n2+nd4HJjL7V69hXdNmyKrf4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-vLz9X8a7Odi-CJH0uFSBTw-1; Thu, 19 Sep 2024 13:46:05 -0400
X-MC-Unique: vLz9X8a7Odi-CJH0uFSBTw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7acb19747a8so191748185a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 10:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726767965; x=1727372765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nhU0TVVjiOwfSHNcNgNnJbcqIFXpQ2RgMN/pm5hZsDc=;
 b=seYoQLu+iXFKoFb6Ea4z9JUAyKpTXqVRm9s4xWro5Ur1xMtjcIB3dqdSB1WEfoOVT6
 7IAdVMemPxsy62Unuvvh8KyDEI57iJfFNBLG2BUm0ndfgiEUnie5nI09n13Rv/LiY+Gp
 TqZIraieJjc6lYtxnfFEUuNavtWHNZ1mljuaD/U2YxBmzii9vqSg4yYG+JBiwxnqmF3H
 zRGLfJhiFMBrU/sLO/3PYQecmJYkymvcc6nkKfDjADBXBp2stShJ0j4gHwt4MkaeTQKT
 4WHem0Al7ynBkrqgTDLw+HUwDpBbuEMXb9mMbzLsdbi4nha/SsXtMuoPlSbK8pWRezHm
 +MmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDKfaXAg34hCsz7k53y7QkzT3RK+ib5fxPDb3Ud6xp84H3rwA1Uy3qaXGYcyNklb/gQ5xRPNiMH/95@nongnu.org
X-Gm-Message-State: AOJu0YyfOtEMbbbqGJB2U3QSvTiC9RsF2eP4OjPUwoPYqYRDeQeODEWg
 DGmA3oqpah5NHZXzHYzRBKui/JOzgZpH58hLe3d/wNioZ7ikFuu8zYB6XJP7EwpzSuKvup0755p
 9Z9C0lMQk3R3X9jdYC7NeTkPcS9hbvQpFSfEUi8ksFs0H94VL3byu
X-Received: by 2002:a05:620a:f03:b0:7a9:bba4:161 with SMTP id
 af79cd13be357-7acb820de70mr30998985a.46.1726767965028; 
 Thu, 19 Sep 2024 10:46:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDEQNz2P+cSQQ+9NgloYoyNP56PW0aatLgvWkoHxYkGWaXeyBL5jnYabjVEyi0ayyHT+5JpQ==
X-Received: by 2002:a05:620a:f03:b0:7a9:bba4:161 with SMTP id
 af79cd13be357-7acb820de70mr30996885a.46.1726767964728; 
 Thu, 19 Sep 2024 10:46:04 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb080a036sm94824785a.43.2024.09.19.10.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 10:46:03 -0700 (PDT)
Date: Thu, 19 Sep 2024 13:46:01 -0400
From: Peter Xu <peterx@redhat.com>
To: dave@treblig.org
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 5/7] util/userfaultfd: Return -errno on error
Message-ID: <ZuxjWe9H0D8DbWuR@x1n>
References: <20240919134626.166183-1-dave@treblig.org>
 <20240919134626.166183-6-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919134626.166183-6-dave@treblig.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Sep 19, 2024 at 02:46:24PM +0100, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> Convert (the currently unused) uffd_wakeup, uffd_copy_page and
> uffd_zero_page to return -errno on error rather than -1.
> 
> That will make it easier to reuse in postcopy.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


