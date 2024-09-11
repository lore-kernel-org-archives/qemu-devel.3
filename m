Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDE9EE49BD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOV5-0007Jx-Mp; Wed, 11 Sep 2024 10:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOSj-0007ye-Qr
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:37:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOSd-0005AB-Kk
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726065378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A6eDVf/zEKloh6L1vbyJ6Dyv9h+LB8eriJxy/LvgZnM=;
 b=PAlC/BUjY/ItUVRes6V+VbpCQSdrlnZ1prpBv3HNZIzNSIf0rhsBlfb/CUys0Z/gH6CEeE
 c17Gps5dyic2y1f9H2ZRWVLoESXpJcAHWyUu7J/gM9R0bsQem3wPTKm5E+I24tFeL61Q/c
 RuzferYfcZznFgGc+4tcH7nncqQFmQs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-Nm0IOHVuORW9b6kpRMtQcw-1; Wed, 11 Sep 2024 10:04:56 -0400
X-MC-Unique: Nm0IOHVuORW9b6kpRMtQcw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374b981dd62so1087594f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 07:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726063495; x=1726668295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6eDVf/zEKloh6L1vbyJ6Dyv9h+LB8eriJxy/LvgZnM=;
 b=sCWT6+BGKJRSqj2LYUK+p8oJkUD/tdZwsb5kWex1O+Q51747tdcvc0kvBbW+xgPtV+
 UqNDwGsfQho4s5hudq+/5/u03hYTkR3YtePCcITYvCgfxBR0t2kapCfjlM6EJaReA/1Y
 rVPgxLML2p345UPCcG8auGN+RRLebKmtXzSxR4O6bQ2km66svSg3bY2tmLDd6INSS71r
 kcN5woeDj+J9GbN8+SGPWrFCV/RwpLsn0OAT4S7IYH6OpIJn6yIfPY7p9Yr6RudmEwOz
 Hj+LH5EzvHp7OqOWiW7/+eRaLEY4Du2//xeGuksLaQ0lbSAfF9plfEaX2+vwIgfjcBFH
 YK7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1Bj99OyYpUyvDMvT+z95Rc8UAvd2oja/fHT3BKyUJRDWQVEQdi9daJQhRo15lLcxruZ9d2xy0KBTj@nongnu.org
X-Gm-Message-State: AOJu0YySWt1Uc/eecrkdI4SuryXPczEcMBQIRj52rWPEAHxMScEOJl/4
 KOxo4BuZ5hD3lANj1vJnqoYSG4djUHwORIK/Kcp9YUFIqF+Au/fU8UcOXeHIxaQy/5pvdcUp1AM
 2pJhuVoQYkVc/5DlacSRnhnEo6InfJWvU1Y25qK3Ikov57FFfn3Y3
X-Received: by 2002:a5d:4a02:0:b0:366:eade:bfbb with SMTP id
 ffacd0b85a97d-378b07f6fcbmr1995923f8f.46.1726063495497; 
 Wed, 11 Sep 2024 07:04:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw3Mj3f3QbV65TxK4gki8JGn80V4Im9vxdHw1b5JGuOLMueZkY6fuubvVZ7nofSv/gz8Z7gA==
X-Received: by 2002:a5d:4a02:0:b0:366:eade:bfbb with SMTP id
 ffacd0b85a97d-378b07f6fcbmr1995892f8f.46.1726063494908; 
 Wed, 11 Sep 2024 07:04:54 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956de0e2sm11649501f8f.105.2024.09.11.07.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 07:04:54 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:04:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v1 00/14] s390x: virtio-mem support
Message-ID: <20240911100415-mutt-send-email-mst@kernel.org>
References: <20240910175809.2135596-1-david@redhat.com>
 <4429b29a-a022-4507-a358-1a16b5032395@linux.ibm.com>
 <9dc58bde-7979-4ffb-9ba7-a501d9fcc416@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dc58bde-7979-4ffb-9ba7-a501d9fcc416@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

> > 
> > I'd rather have it in a shared and bigger repo than in your personal
> > gitlab one. Maybe there's a space somewhere in QEMU or the Virtio team's
> > repos that would be a good fit if the kernel's docu isn't the right place?
> 
> At this point, outside of kernel/QEMU feels like the right thing to do.
> Conny is already a co-maintainer of my "personal" (;)) gitlab.
> 
> 
> And now I realize that I CCed Heiko on the Linux series but not the QEMU
> series. My bad.
> 
> [1] https://lore.kernel.org/all/20200727114819.3f816010.cohuck@redhat.com/


No prob. Or if you want it in virtio spec, that's also fine.


