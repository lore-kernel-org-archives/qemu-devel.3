Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48040D3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 14:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2WXg-0005vv-TB; Sun, 20 Oct 2024 10:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2WXf-0005vV-2g
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 10:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2WXd-0004Eu-8E
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 10:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729433059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8FlJt8mPZIXVABfLuiOXyn44/7JT+JqMaoMZBDZJknU=;
 b=RSiLm3bdk10O+5DzsN5cuMAC5+RS6Q9I9OsrgPFQTUxTOzG1g/mSbgiBarW3vF6KVayxn1
 KNeP0piUFK4EdawSyYh8uGR/XkFR2LveHCeyeQtRkD86ctL6JktHMa5WdNlhx5XX8yA8Kx
 EDiiUw087FzJpR/GeSU9ai3c5erQ0VU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-j_m6gUE9OVKNcyr4P5OurA-1; Sun, 20 Oct 2024 10:04:17 -0400
X-MC-Unique: j_m6gUE9OVKNcyr4P5OurA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315a0f25afso25282265e9.3
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 07:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729433056; x=1730037856;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8FlJt8mPZIXVABfLuiOXyn44/7JT+JqMaoMZBDZJknU=;
 b=lFQFA8Ze4AzZcGTLvDr8NiDMxSwRod0eb+KIRYl6xchWdHs8JOoV+LjeA1xAoNCf7m
 RFs9C31u7kk3+3siTevWkMaD7P8iTYMkYrRtZmCqXWD+PA58xJnVLL/6mejzEIuH39Eb
 sGmBDIDzjoI/DsU/lFeWZqJQu4OGoS8u7LSCmuXkqxpp+wFhX6seYD7BiMZpAdXmNgjv
 61zjYKX1wTSKplKxxqzZQ1LSKQQwq2DaNyNT8i4uD/sF4b73wHFxsZje6DLBgJcG77yo
 2XFnQFkvz03cpa5wpcOkVz5NKX2kQnh1UM62Hr2vw+Ie0Vv5Idr3TOdRB9V1NOpfvdOM
 v1hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI0Ub9rATmbaNtd/1BmNRl+kDaO5fPoBBR47KEG77CoRegF6qpF+OA0ugtwzwuf0+GDPfXvkMAl6PZ@nongnu.org
X-Gm-Message-State: AOJu0YxELuJt1VQ6XHBnYfsSOt+j11ML5epToMbNtSZzecAiRdt6ZBln
 qYuwY+m+8lRLI8jYcT7gvDUB2WbLDPhq7pT25Csc2nIxaLuEPbsCJBemfIIDIdfotbdTDe7siZO
 Kn250dTOprABwkF6TGc9w+Ie6LunI310btQwcbEYrshoOYTmVKOza
X-Received: by 2002:a05:600c:5489:b0:431:5df7:b310 with SMTP id
 5b1f17b1804b1-4316162800bmr62230505e9.8.1729433056086; 
 Sun, 20 Oct 2024 07:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH+mew9NZxIKpufEAl7qhfK3U9q6zL/jFCmLUul4HxBP0dnCqNmDKaK0F50fNMV6hx38fOAQ==
X-Received: by 2002:a05:600c:5489:b0:431:5df7:b310 with SMTP id
 5b1f17b1804b1-4316162800bmr62230355e9.8.1729433055738; 
 Sun, 20 Oct 2024 07:04:15 -0700 (PDT)
Received: from [192.168.10.27] ([151.95.144.54])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43160682586sm77271525e9.1.2024.10.20.07.04.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 07:04:14 -0700 (PDT)
Message-ID: <e98fb78a-ff2a-4c32-a7b0-95b73b54d94d@redhat.com>
Date: Sun, 20 Oct 2024 16:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] Revert use of clock_gettime for benchmarking
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "cfu@mips.com" <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
References: <AM9PR09MB485113D76C5AE02516C08E8E84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <AM9PR09MB485113D76C5AE02516C08E8E84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 10/18/24 15:20, Aleksandar Rakic wrote:
> This patch reverts the commit (with SHA
> 50290c002c045280f8defad911901e16bfb52884 from
> https://github.com/MIPS/gnutools-qemu) that breaks for mingw builds,
> where clock_gettime and CLOCK_MONOTONIC are not available.
> 
> Cherry-picked d57c735e1af1ca719dbd0c3a904ad70c9c31cbb7
> from https://github.com/MIPS/gnutools-qemu
> 
> Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>

Can you change it to use qemu_clock_get_ns(QEMU_CLOCK_REALTIME) instead? 
  It's the same as clock_gettime() on POSIX systems and works on Windows 
as well.

Plus, because the result is just use uint64_t, tsub and tdiv become 
simple subtraction and (double)a / b respectively; and timestr is also 
just as simple with:

-    double frac_sec = tv->tv_nsec / 1e9;
+    uint64_t sec = nsec / NANOSECONDS_PER_SECOND;
+    double frac_sec = (nsec % NANOSECONDS_PER_SECOND) / 1e9;

Paolo


