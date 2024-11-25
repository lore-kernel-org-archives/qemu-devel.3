Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07093D58D69
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 17:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFcjE-0002jF-Jt; Mon, 25 Nov 2024 12:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFcj4-0002gO-Mm
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:18:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFcj3-0003qq-BJ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732555095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lxvFaaXBjMf5ZZYoPMj9beVs/vspcT7kQL9o+y2rM0Y=;
 b=YVxg3Lbx+nageV9pP1IyMi6cnViJ1VGtQ1AGvG6VlWm/tZ1zxchXDfUHnb0LNRyRnJb3O1
 jdMoByEv/UA6uPch64s2wmdXD+dIfHoaYX28WdMUT/GComDo4qZ0HfFIt7suYpzFMYZlLV
 NEb9ArEahryIZRU4fMJ81tyQGdQjW4Y=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-S7GG6b8DPf6s8ogo4liaUQ-1; Mon, 25 Nov 2024 12:18:13 -0500
X-MC-Unique: S7GG6b8DPf6s8ogo4liaUQ-1
X-Mimecast-MFC-AGG-ID: S7GG6b8DPf6s8ogo4liaUQ
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-843671e13c0so18092739f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 09:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732555092; x=1733159892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxvFaaXBjMf5ZZYoPMj9beVs/vspcT7kQL9o+y2rM0Y=;
 b=Ph9VKV2k3FOYgFvo9FOtkrXgfAlkdgOBTyBQ31K/xHb9ZC+lhEs2UxwpiG8fQnFLJM
 oK32xhlq04HlnFd37SGlFxXlCyT8LLBAZtDBiyIV7FoQr8aTJtPmMitqhncufwjGh226
 77H53zcR2QP/Do1okwYyVKzOXFPikQAqUL2FD6jCtcA+Ancvzw5Hc3cQkAWkeyRNTBfU
 LIxUpCT8QNpeJpwHom/oScOPcfhSFlN965D2i+BLD8fw4nHQ/2eTbpTYRi/FAFDfeZ7u
 tTsQ1im55UUmC0AxOvOqEb2sRz00FWiPdE3N8M0pyjavmPD7fhSFrCHMJMPcNTAa/emN
 V47g==
X-Gm-Message-State: AOJu0YzLrsRUms6RrRISJ7E3LK/ca4kZ9vIFetPHynWFMMsPk+es68ih
 oC5bFpmxJ85JkRIemNfcUJAQhRZ7JN6HI6gikqSdS5/T97v23UWqbWv7lvcQO18vpp116lKxQ3h
 vPgNS385/RTQy+wiexodQWmaMqF6lkCoE54ITUx0KiwLEZcHxfIanngXTbg1U
X-Gm-Gg: ASbGncvN1Szu2ouq7ryvZqHVWNfZYN02d6GThFrIrLbhSQ2ZPka/R5AQe0xJ5ki/L0B
 19WDttmqnvIS1rqrW9gqSGeAG+QFA5FSXcrkJ2f7Fpu1uzpVsuIyVV2E9Y0BmdL3hZjRPsrFYeB
 D/F7xoEs+LHCtT9y7TcNBBcz6AMZL4IzT0/fGIpCiihu0n4ZOMmgVztl8Um8sr7BjrjSSxav6nW
 1X+jwE5CBDT6gdqHU1GsLA30WnFVdzpNgFZ+M+/rGdmoOr894Tu2MdgfJxXnncuWG85nqDYRXAS
 td2qkCXtqOs=
X-Received: by 2002:a05:6602:1350:b0:83a:a82b:f856 with SMTP id
 ca18e2360f4ac-83ecdc4ef80mr1610840639f.3.1732555092607; 
 Mon, 25 Nov 2024 09:18:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZNuIBwZ26y6hybwSyJCipMV1Yo0YvPFdql5qAHUAhIn2qlTDnBpDs65cxZl6L1RzjhXubSQ==
X-Received: by 2002:a05:6602:1350:b0:83a:a82b:f856 with SMTP id
 ca18e2360f4ac-83ecdc4ef80mr1610838639f.3.1732555092394; 
 Mon, 25 Nov 2024 09:18:12 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83ecd16a560sm187276139f.11.2024.11.25.09.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:18:11 -0800 (PST)
Date: Mon, 25 Nov 2024 12:18:09 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 09/22] tests/qtest/migration: Move
 kvm_dirty_ring_supported to utils
Message-ID: <Z0SxUWtpeJs3xVdA@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-10-farosas@suse.de>
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

On Wed, Nov 13, 2024 at 04:46:17PM -0300, Fabiano Rosas wrote:
> Move kvm_dirty_ring_supported() to migration-util.c. Similarly to
> ufd_version_check(), this function is used during test definition so
> put it in the utils file.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


