Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD525C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 16:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiFp2-0008Vc-1n; Wed, 12 Feb 2025 11:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiFoy-0008Us-6Q
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:42:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiFos-0003Uf-Ms
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739378556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0zLN15kW/sVRsgQMPCXeO7L2hWd3oYwz2dqJdaQO3to=;
 b=Y2Zt/N6sB50BWXXfp4LTwAUoWICIJHB9HAj04iUu7IgehlfmEtbin8/SJ66IEvBeQEAOBX
 CZ5uuak2GMpd1F2OagYKhfYgMqRvgezy6Nl/seMgqTKQxN7pcQsz2Wxw4E2Wns3uVJ1w9h
 zJiswI/YlSo5xLDhLLlkr4sd6KmgEFU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-q1JHAEtyMSyLTZc7ZFEGsA-1; Wed, 12 Feb 2025 11:42:35 -0500
X-MC-Unique: q1JHAEtyMSyLTZc7ZFEGsA-1
X-Mimecast-MFC-AGG-ID: q1JHAEtyMSyLTZc7ZFEGsA_1739378555
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c067ec2de7so188485785a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 08:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739378555; x=1739983355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zLN15kW/sVRsgQMPCXeO7L2hWd3oYwz2dqJdaQO3to=;
 b=rC95siGiqdO8Xc0GQV/Oj7OXKQczrYQ5r6ZJRKg89wg5n5IxTl4bnfCnEScRVMhZh0
 FD28O8Ev9zcowYqNJHOYTnJaxqpohs/VQzibTYX9YAWrnFc8O4HQmc5CSZnurodEE/lu
 x393EjS6Mbhcbx3ih6Sjny5nenh1WDvrjVrIW1KgM+c6mGTpda7KZkEKo3XSSVjFv8l8
 lCb3IN7/LZlFTmgdbKoOsgelZ8q23UdvUxWnHt1RdOeXhTmS5tYSsTLBPrt5IYHPNCnf
 DSlx5RC8DYR2WGJQ2qtN7jtGYsY9R4FFY3l44JkAxfYGNiQeWP+SZ+H4T6/en82121AK
 SiKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4w68WYToGaJITdFzUBW9hVgoCx1zWGW8ujeCacorAWUb3q1frTSuM7TjB0JPd8/2ulC8Tr4ommcA1@nongnu.org
X-Gm-Message-State: AOJu0YxDQR4asQ5wt5w163AWDS8liFUV4CJ48LDa5n8+dwhagXReWd0N
 RVXumAYTW4n981eeHBf0MMd3ncIjDn2Io41tOn92g0s7mI0racgnnPDnzjvw3qPgYkTxIAb/xVj
 sijnPFYFT0XcTGJ+DjUU8OptBZ8bEKkBbgah8AvZWfMwNq5kVLbud
X-Gm-Gg: ASbGncsmIBWnhCOSHCWjR5t7MNrFKJ1ZPEnGLCkuGKKdnmdjEvpU9t0nvmPc/0hT3Ge
 xKPsV+MjZtTiw55FQlWyUF7mOZs5mkUZ3VQKzoWqyCKl6LnvtBy6eiLX5bKt2CZRiKxDGMjV3P5
 7A4dKVPIE/S2dcQQpD5yNfurUtdatbRR/hBbupj6kEr3iGdrUCHvvBaeY+zUBmaZLm1E8/PHF+H
 zAHjQYg3m0R8v2GUdvaFF+FslaV5Fy2GvvobNafjvlcu1KZHCpiHHVAc20=
X-Received: by 2002:a05:6214:174c:b0:6e6:5a83:dcf5 with SMTP id
 6a1803df08f44-6e65a83de6dmr13492696d6.21.1739378555093; 
 Wed, 12 Feb 2025 08:42:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1RJNozA95pzVTPIU3PPaCUF/wK26B0umP/YgMQlE7SM7MJvfEnPtblMjw6aIkdJf/xeXnfw==
X-Received: by 2002:a05:6214:174c:b0:6e6:5a83:dcf5 with SMTP id
 6a1803df08f44-6e65a83de6dmr13492486d6.21.1739378554836; 
 Wed, 12 Feb 2025 08:42:34 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e658ae283dsm5345376d6.51.2025.02.12.08.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 08:42:34 -0800 (PST)
Date: Wed, 12 Feb 2025 11:42:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 1/4] os: add an ability to lock memory on_fault
Message-ID: <Z6zPd7DM1yGWXokt@x1.local>
References: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
 <20250212143920.1269754-2-d-tatianin@yandex-team.ru>
 <Z6y-jdFOCVz8mEXo@redhat.com>
 <c78c911c-d7b3-412b-a6d0-b4bcca070a6b@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c78c911c-d7b3-412b-a6d0-b4bcca070a6b@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Feb 12, 2025 at 07:17:45PM +0300, Daniil Tatianin wrote:
> > > -static inline int os_mlock(void)
> > > +static inline int os_mlock(bool on_fault)
> > >   {
> > > +    (void)on_fault;
> > Is this really needed ? Our compiler flags don't enable warnings
> > about unused variables.
> 
> Hmm, I was not aware of that, thank you.
> 
> Peter, do you want me to resend, or can you squash remove this as well?

I'll do, no worry.

-- 
Peter Xu


