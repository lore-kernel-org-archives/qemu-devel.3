Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F0FC25B74
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4c43-0005ME-0k; Wed, 08 May 2024 03:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4c3t-0005Jq-T2
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4c3s-00037d-0i
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cUwsiivt4wIpheqIiLMhaZ8u3qvativBF7BiLk6pO+c=;
 b=AXmwCtJv+h0qLlg6Q99JudVJPQlLQEZ3q4/7/uNOyUvR823QOw1A/midw96HUFhQgkCkNI
 tFLowO7Xrt1Svg/ia6Usnh68rPllLku7whLi5tU20P9mjJpKEpE7eb5xztsuk9CruukW3o
 hhE6nOZg3TEEdJVLG3rwBjO2V771pIw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-_Cn4TTmUPnKJkEQDTBXRGA-1; Wed, 08 May 2024 03:49:54 -0400
X-MC-Unique: _Cn4TTmUPnKJkEQDTBXRGA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59c3cf5f83so224250066b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154593; x=1715759393;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cUwsiivt4wIpheqIiLMhaZ8u3qvativBF7BiLk6pO+c=;
 b=bsE0oFh49Z1P/SoBUK/P+bSED6QPc036Duw5mzvC3ET5+46vZgg7zKM0eUWHq1wgyA
 U8dTulUUJdfMQwC31JyPPnqW47rm+qu8VqULxr3Gi4Fw2KWYUSAvc5WuLQyTb7x5BsYN
 5mhCXXoduW9rCLVTbQnA2/JOc60IsuW8hQFSBi5O56Mxq+dLAzkeA9BzvLc1keZAZArg
 DZSFH0RO5pJqQ7+YkWv6QpGwA4h+tW5vWOqt+vwzgoJM5yr0JDuIPJPjkq22PAMkEPxu
 WPYS3W53GPjYXGMYlxiTOaC5fkSLqmjjQL5SwjkClORFQ9zTth7R0qkOYrm5bwYQjTsP
 VbgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuZD/l+V2MocoCqGy43mOJwdvO5VzibuwC5p1uaNVFM0CjCiz0QElHCoentgBDRtD2c6VD/T+LnKa033ABJsw7GZlZ9W8=
X-Gm-Message-State: AOJu0YwWTrhnA8dKDEw+RnoRyqpZ2Qj92jcqDxPYFMjrA76mNaHyHDfB
 p1TBm2tcAgVR4rhGA5Z8aKtF8f3gmW91g0Os6hknHvs2VDMo6t/tKE/fbx2WtBoHoUGnMTW0xFE
 Vo7GPnBKJfij6N+KQ3j/aAxjjjNmsYN8mpTGip8kOpkY09ylVME63
X-Received: by 2002:a17:906:3715:b0:a59:aae5:b0bc with SMTP id
 a640c23a62f3a-a59fb952c14mr94042866b.42.1715154593073; 
 Wed, 08 May 2024 00:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG7LWBfK2/ClnLQVW1UbMCAY3zsKv3sytk8kwUbKcckx+3SQ7ck8HC+YFwaeyoeTko4kL5Nw==
X-Received: by 2002:a17:906:3715:b0:a59:aae5:b0bc with SMTP id
 a640c23a62f3a-a59fb952c14mr94041966b.42.1715154592749; 
 Wed, 08 May 2024 00:49:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-56.business.telecomitalia.it.
 [87.12.25.56]) by smtp.gmail.com with ESMTPSA id
 ag3-20020a1709069a8300b00a59a6fac3besm5286698ejc.211.2024.05.08.00.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:49:51 -0700 (PDT)
Date: Wed, 8 May 2024 09:49:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roman Kiryanov <rkir@google.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 QEMU Developers <qemu-devel@nongnu.org>, 
 JP Cottin <jpcottin@google.com>, Erwin Jansen <jansene@google.com>, 
 Mehdi Alizadeh <mett@google.com>
Subject: Re: Hermetic virtio-vsock in QEMU
Message-ID: <zyj7huwfzji6c5bkq44o56nizo7fju5kn2nqg2n5niuwdzsnkl@ykhg5yqruvwr>
References: <CAOGAQeqOVAHJ4VxQNKqO43hmLJdxpA6E_JEQrfL380SwT4Y73w@mail.gmail.com>
 <Zh0NiI9ZfS5uzs5Z@redhat.com>
 <CAOGAQerx0DmHvJNf05wuJFOtXVwDFTt7fy0-GmBZ7xKoLAHTKQ@mail.gmail.com>
 <ZiDpM7ZusU0SvH7K@redhat.com>
 <nga2k5uuvpqm2sovguofglw6u3reiqqurbn7vbdexanzrhmw42@vuje72e57egu>
 <CAOGAQeqU692hHf3dU7udz8hwzP6KuFTNWir0mLcV-URF-JkFnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOGAQeqU692hHf3dU7udz8hwzP6KuFTNWir0mLcV-URF-JkFnA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Roman,

On Tue, May 07, 2024 at 11:20:50PM GMT, Roman Kiryanov wrote:
>Hi Stefano,
>
>On Tue, May 7, 2024 at 1:10 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> I have no experience with Windows, but what we need for vhost-user is:
>>
>> - AF_UNIX and be able to send file descriptors using ancillary data
>>    (i.e. SCM_RIGHTS)
>
>As far as I understand, Windows does NOT support SCM_RIGHTS over AF_UNIX.

Thank you for the information. This is unfortunate and does not allow
us to use vhost-user as it is on Windows.

Thanks,
Stefano


