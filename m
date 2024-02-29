Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA28C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 08:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfc7V-000229-2G; Thu, 29 Feb 2024 03:50:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfc7B-0001YY-M9
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:50:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfc6x-0008UG-Of
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709196591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nwpr6HpL4v7VoJaEQ1d8CgoryVjz2Yk4lpsty95ei8o=;
 b=hA8dVSdOyAdKOkR5iHUeO1dWGSbARiv+7U3IF0AtMnvWGr/sECKYLBFjLElueSoGzW8G0s
 +3CkK2t45nF5RWQFF4JjwRDLSGA9EuVT9yBUD/Xwpw5x93m3DcnBgnGWakUD17IjvcTV+Z
 qfHxE6fSDBl15wcZSUWYndPRlo4OWz8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-IHrlkiP6NjuEQxX8sWDazw-1; Thu, 29 Feb 2024 03:49:49 -0500
X-MC-Unique: IHrlkiP6NjuEQxX8sWDazw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7816e45f957so97595985a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 00:49:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709196589; x=1709801389;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nwpr6HpL4v7VoJaEQ1d8CgoryVjz2Yk4lpsty95ei8o=;
 b=cg4CYp/6w0Oo4WZL8WwrKv5nMop/ojZTnk68NmDU7k8/bzHn3A311gtp+54ZFKO4l+
 xJrV/JEXu52Pf2/wFr/+yX5Wapsu0Qh1ZlDj3TVQf+B0GNFlbZv0irg2Brk/8mq1UnCs
 EEP7NUOAoS+RLmhWzGZgEDUPOkczfNpHbbS5SGfQeGJpgxwgK3rBp6lEVpdQ/YUBWwCx
 ERHerhtsRmsVwUZHoN1tb3JyXxTNI7E0KyGIc1KlY6LbIPaGsg2JrDFRTgv/VPPXgxxb
 hdYV2Tzp/hujPHzDxwiL6E01udeHfUlb3AJk2sOj/YFF/6blcnTFdsCerCKueEZyGmn6
 E6og==
X-Gm-Message-State: AOJu0Yw68faUlnJs6okzFyevcFgdK5YE93A1klRxoGyocGfe3la53Iy+
 ElScjDvcVpGdtkmYUMev1FVy8eferimQvJpIp/YEabqlEVbupaLGEwEUO8U0sYzxufUuhvt+wNI
 fN0Zi+kkLFUhTmZZSeCSYOX1oIS2YA/xb12bQbbIA1aLMo8gFyfif
X-Received: by 2002:a05:620a:2e6:b0:787:ec95:586b with SMTP id
 a6-20020a05620a02e600b00787ec95586bmr1633805qko.30.1709196588938; 
 Thu, 29 Feb 2024 00:49:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqwLUIljGVDp1n6C8UkP7QEP48AvrqZXXY1sFZqGU5dwQELZvQnJIgz/dqXvpgbQlP7vqlag==
X-Received: by 2002:a05:620a:2e6:b0:787:ec95:586b with SMTP id
 a6-20020a05620a02e600b00787ec95586bmr1633795qko.30.1709196588663; 
 Thu, 29 Feb 2024 00:49:48 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-64.retail.telecomitalia.it.
 [82.57.51.64]) by smtp.gmail.com with ESMTPSA id
 o27-20020a05620a22db00b00787b7b9ccffsm471398qki.24.2024.02.29.00.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 00:49:48 -0800 (PST)
Date: Thu, 29 Feb 2024 09:49:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, 
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>, 
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>, 
 David Hildenbrand <david@redhat.com>, stefanha@redhat.com, gmaglione@redhat.com
Subject: Re: [PATCH 9/9] hostmem-file: support POSIX shm_open()
Message-ID: <wcbvg5sa5df5jjifbjuk6taschoiayihdnyyyfbemrctulprk7@gifk7sr74dsb>
References: <20240228114759.44758-1-sgarzare@redhat.com>
 <20240228114759.44758-10-sgarzare@redhat.com>
 <Zd8iRWHaFqDxSJp2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd8iRWHaFqDxSJp2@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 28, 2024 at 12:08:37PM +0000, Daniel P. Berrangé wrote:
>On Wed, Feb 28, 2024 at 12:47:59PM +0100, Stefano Garzarella wrote:
>> Add a new `shm` bool option for `-object memory-backend-file`.
>>
>> When this option is set to true, the POSIX shm_open(3) is used instead
>> of open(2).
>>
>> So a file will not be created in the filesystem, but a "POSIX shared
>> memory object" will be instantiated. In Linux this turns into a file
>> in /dev/shm, but in other OSes this may not happen (for example in
>> macOS or FreeBSD nothing is shown in any filesystem).
>>
>> This new feature is useful when we need to share guest memory with
>> another process (e.g. vhost-user backend), but we don't have
>> memfd_create() or any special filesystems (e.g. /dev/shm) available
>> as in macOS.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> I am not sure this is the best way to support shm_open() in QEMU.
>>
>> Other solutions I had in mind were:
>>
>> - create a new memory-backend-shm
>>
>> - extend memory-backend-memfd to use shm_open() on systems where memfd is
>> not available (problem: shm_open wants a name to assign to the object, but
>> we can do a workaround by using a random name and do the unlink right away)
>
>IMHO, create a new memory-backend-shm, don't overload memory-backend-memfd,
>as this lets users choose between shm & memfd, even on Linux.

Yeah, good point!
I think there's enough of a consensus on adding memory-backend-shm, so 
I'm going to go toward that direction in v2.

Thanks,
Stefano


