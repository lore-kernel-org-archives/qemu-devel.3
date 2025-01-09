Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78D7E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 15:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVutJ-00082R-4u; Thu, 09 Jan 2025 10:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVutF-00081E-7Y
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 10:56:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVutD-0002uY-QX
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 10:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736438167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xb1DWJQJIpAVhNoiJGrVPbdSMrw7C3HTWgrmbNuX+mE=;
 b=e67/kdoZhIzYYgFdWwrNiOYlx7lTmS74wOAw3nDhc57XSYgBEjAebSkgD/Yqurk5tuaARM
 4nYzA4MKavyMvKAF+BOrfgiX2OJ0PhvHOqq99fWxz5+JqWsPNp7LL8MYjfRZ8lC2yp9rxm
 1tHYIdqc81aitxmNQQAdxpGjLvAOm5E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-BdZJGIHQNl6YMAUdT4RR2A-1; Thu, 09 Jan 2025 10:56:03 -0500
X-MC-Unique: BdZJGIHQNl6YMAUdT4RR2A-1
X-Mimecast-MFC-AGG-ID: BdZJGIHQNl6YMAUdT4RR2A
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6f943f59dso185122585a.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 07:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736438163; x=1737042963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xb1DWJQJIpAVhNoiJGrVPbdSMrw7C3HTWgrmbNuX+mE=;
 b=sLEJbzg7YDOpHnYBvnSBNFcV4mpKkYFA5CEQOBL1aNJ3cAY0zJ6f7Rk5Kx61QTEK+F
 i0nwMbzlGCVd+GLJ/laRx68bd563A2vADU+i93eWdzCs4BIEuku93wujiKO7CNov1owi
 7F1RppMMCVfK/J5Jbv07K5DjSbM2HPh3tPPt2aSsBAMF9wPgpL1GFNd0fpYwSckOCkHa
 6sGBnRGI5qCtfeaII7RlgFrMCDi62mqP9jgVyCLrWvCg4bN+EhWbG6h/p0GsY72ghjXP
 B+YU3ajwX0OvBFjDh0aJNXG8Vg3Pogn+ClvMITfCGCK+zLy3oq6h9KxhbiZzu9AfW+l2
 YdMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV62c3DHdVxW1YFnXvVG2t59ZROFOcfX9rFg1OW15fbo9AV/c54az9ACILyx70DwuZ6A3qMf6VLSWhm@nongnu.org
X-Gm-Message-State: AOJu0YyjXFhAdlISjAMmco9rtRETK3tyWmVv+vQTk6g1oVXKiHtVOVSy
 Z802kE3iKMhSy44UaqOR2SkjIQFf+cRcDw8zJ9j3GVrbvUS5utWlKnFNM51VvR/+0reLi9U5knl
 9QmyV+7tkbwciQuo2Jfx0d3A7vD0vE4AvGrNAFv4QUbt1cvitOuv+
X-Gm-Gg: ASbGncvo01tOoOPiebXWoFjmd3WlTo1Cs6W+Z/d5go+yOPNQzeqaYp0V7JopbHWbLZS
 BhlPhgM9Xx8B4M59j8n3RKir4Y/VZ8Hlov2FReV9XQZoVD89Ya9vQtWgbjRtuF0jhMkeGC5Zy3t
 6oAuQxd9ijF4n6uCdaKsrEJH/6PPN3MW4ZR5BoqsNU2sNj6G8kctYJF9F3jvSvt2y41FVShlXIM
 ycdSugWj6NqXCeAmnzKzz37rjl5EHqFC+VKYJjJyzxTU5W4jn6hD7+Rx2gU+EvdPUXAX+Vl4Pn6
 3XTZe6KSOjEoSr5f3Q==
X-Received: by 2002:a05:620a:46a7:b0:7b6:d237:abf4 with SMTP id
 af79cd13be357-7bcd97a4eb7mr809852285a.39.1736438162992; 
 Thu, 09 Jan 2025 07:56:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaHBxA3K2p0wvmUSCuS2tGfbbpbDCQ5HELsxMLbzCzBbrTkB6zNOyODV55tZga6co/qSEOdw==
X-Received: by 2002:a05:620a:46a7:b0:7b6:d237:abf4 with SMTP id
 af79cd13be357-7bcd97a4eb7mr809849285a.39.1736438162585; 
 Thu, 09 Jan 2025 07:56:02 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3237fa6sm79615585a.14.2025.01.09.07.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:56:01 -0800 (PST)
Date: Thu, 9 Jan 2025 10:55:58 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v7 2/2] memory: Do not create circular reference with
 subregion
Message-ID: <Z3_xjlqNyIJAQTYq@x1n>
References: <20250109-san-v7-0-93c432a73024@daynix.com>
 <20250109-san-v7-2-93c432a73024@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109-san-v7-2-93c432a73024@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jan 09, 2025 at 02:50:21PM +0900, Akihiko Odaki wrote:
> memory_region_update_container_subregions() used to call
> memory_region_ref(), which creates a reference to the owner of the
> subregion, on behalf of the owner of the container. This results in a
> circular reference if the subregion and container have the same owner.
> 
> memory_region_ref() creates a reference to the owner instead of the
> memory region to match the lifetime of the owner and memory region. We
> do not need such a hack if the subregion and container have the same
> owner because the owner will be alive as long as the container is.
> Therefore, create a reference to the subregion itself instead ot its
> owner in such a case; the reference to the subregion is still necessary
> to ensure that the subregion gets finalized after the container.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


