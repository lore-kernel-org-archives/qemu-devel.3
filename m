Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020D1CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 12:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9jnf-0001SS-6r; Fri, 17 Oct 2025 08:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v9jnc-0001Mi-HF
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v9jnV-0000kn-FH
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760704980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vDKvQk3xxnWOQbsp/iLBmfza/QSwqqEwlFhje7OVN+k=;
 b=D959+Ra1WzP3LBBB74khaq+PZoBQhrY/LeanzgBDDkq8uyx2oAoFCEldaRRoWlcJZ4cUK+
 PWhOyqwGYE4pBC75DQ/LJ+GkiJ+1l95oDzCPJ55lVPRw1n8Sr4LvuBd7B84IJT6GEnI/KA
 pf0WZN5Ajnr4RbVnuD7MpgGgDO3MO4o=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-P6OfbJ_qMJqf3jcSfmOGtw-1; Fri, 17 Oct 2025 08:42:59 -0400
X-MC-Unique: P6OfbJ_qMJqf3jcSfmOGtw-1
X-Mimecast-MFC-AGG-ID: P6OfbJ_qMJqf3jcSfmOGtw_1760704979
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-86df46fa013so832228785a.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 05:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760704979; x=1761309779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vDKvQk3xxnWOQbsp/iLBmfza/QSwqqEwlFhje7OVN+k=;
 b=CQxrWoNfSDUxemwFBIQIoN8ykDtrzufn2JBB9xtQgieCH+7aVSGmQYsrC6kYR8RZD/
 oxIywuEAK9w+3m2N1m0NPNN4/JwOE8cVq8wo5AWBEeZT4itKORIIYEWKijmKqTuN4/7p
 TK+OMRXmLgOxnq+09PzW1bdCRvBJm8dybm6y7wSfz5FZG87we9Kap0ZPMJa+SuJ2guqq
 FuppqJRGcl6NuYWfz9xS/DKCX90X7c7uWl5Bo49zD/Dz4YcCbWtl23ZU10WQJ5gcq/XI
 q/oLthkw0p38q1N0SrsOHx0CMpMgs/HZzdhZsBP8CiemzQLVUVikh8cIplKZu14RlHcy
 CNKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXONXT7isdEUKjgWM7Y0VtTLTG1hyrFy2Y0ZrBzz8fUxld5ds4gI7r34WFzp4s3ONiNACapWVEzuCiq@nongnu.org
X-Gm-Message-State: AOJu0YzqcpiVf/fWxqt4gYAXsqviZKfCgki0Es6wjCNIaUY94TkrAKca
 BquDtA3Fxa/bf+v6UpMD2toYx4c8Xib1kHqYIi+fWTXxaucBc5JLXLr2a9Fu3/qdmxufGKXmkjZ
 +474igmzGss+1KywWkU091sGs6srxELsHR5a6u6boQmOb9gCe0cqw/SGQ
X-Gm-Gg: ASbGncv+31qvkdgOdVFQ1wYiuvq5KXgyV3+4e2MZCPEQvsVq7ReNeauFAlwJr91I7A3
 lGz8B8bL8geAjqUwhkQoXRf3asVeMivZ3NnPPGODX6fucKXr7ZCLVs7KlkML7ym4wbNmqyeoUvP
 PgWqOXRDml6+vO309KRVBysHxWYGcZL5p99GDI+A8IAZDaXy9wknvcTriSMgxdZnDByv+bwBkMr
 +bqAt1hZsq2Q3HkTN8chZG2CDBoAtb+8cTv73ydf6pGVvqxLvthy0ijo88f72M/iZU54O0KXit8
 vBekCoUUrpPbNW0f7luJoCx/bcuGX/ZCKpi4wuz2GB9mlh4uH3PhsBMXQG/obw6ZPxC+bIBkNK5
 7qPkJJkGi0MKnU/p+H+f4xuNG+mH6bVxfNjr9ZH8/RsYYQ5rS2UU=
X-Received: by 2002:a05:620a:4621:b0:82b:2bad:ba33 with SMTP id
 af79cd13be357-8906e7b2f75mr432221085a.2.1760704979126; 
 Fri, 17 Oct 2025 05:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4SVlYl+45Xl/FehhmE6T6yfyMje9a8lvbQWm4v8V8TmfUlc4dT3DxbY1mutIBg6kiPGqryg==
X-Received: by 2002:a05:620a:4621:b0:82b:2bad:ba33 with SMTP id
 af79cd13be357-8906e7b2f75mr432216385a.2.1760704978511; 
 Fri, 17 Oct 2025 05:42:58 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-88f37e50ebasm411685985a.31.2025.10.17.05.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 05:42:58 -0700 (PDT)
Date: Fri, 17 Oct 2025 14:42:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, hi@alyssa.is,
 david@redhat.com, jasowang@redhat.com, 
 dbassey@redhat.com, stevensd@chromium.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 slp@redhat.com, 
 manos.pitsidianakis@linaro.org, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH v10 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <42yt45ixh4y2j5z72rwpswf5fv4eoixtohiafp7sqzepd4u6wk@mph7smq3dmuo>
References: <20251016143827.1850397-1-aesteve@redhat.com>
 <20251016150544.GA1174075@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251016150544.GA1174075@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Thu, Oct 16, 2025 at 11:05:44AM -0400, Stefan Hajnoczi wrote:
>On Thu, Oct 16, 2025 at 04:38:20PM +0200, Albert Esteve wrote:
>> v9->v10
>> - Fix transaction_commit invoked without transaction_begin
>>   on vhost_user_backend_handle_shmem_map() early errors
>> - Removed fd tracking on VirtioSharedMemoryMapping, it
>>   is handled by the RAMBlock
>> - Reject invalid BAR configurations when VIRTIO Shared Memory
>>   Regions are in use by vhost-user-test-device
>
>Hi Michael,
>I have finished reviewing this series. If no one else has comments then
>it can be considered for merging through your VIRTIO/vhost tree.

iI left a few comments, and I still have my doubts about the error path, 
but as Albert said, it doesn't seem easy to manage, so for now I think 
the series can go ahead as it is.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


