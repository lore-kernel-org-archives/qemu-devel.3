Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4333C5320E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 10:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh4yZ-0000OB-UX; Thu, 22 Aug 2024 06:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sh4yX-0000NX-TO
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 06:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sh4yV-0006DA-0b
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 06:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724322203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p8TCXvCWgxtXFMUStr3F9V8j9njXv3aRj6bHOWUs+fc=;
 b=HzuWmG0bWhC7YSAApKP4IyplY9oW/emtARkpV7Cdh+TGMHZw5rT/q84/W0Yx4HFEzXBH9h
 kBTxHZJ0gXzLnLGmNPhM2VuLcPhRPCXm54kDBKM+NqkvI6COfiRFe8MPzDuuQLbzL436rs
 woa3XDbD8KFzznmMbULxwUbtFJdotXE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-0w4bbpnwMr2xzf1mefiQlg-1; Thu, 22 Aug 2024 06:23:22 -0400
X-MC-Unique: 0w4bbpnwMr2xzf1mefiQlg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4281f8994adso5128345e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 03:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724322201; x=1724927001;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p8TCXvCWgxtXFMUStr3F9V8j9njXv3aRj6bHOWUs+fc=;
 b=abvXXEARrKxkD6E3aiyPopIxr00Kgs/Rapo4qeESZw/KmuNi2OQPqFE5yAHTwvTCxe
 NW/xJMMgcgIEPAebHkszEup6LGowfP0Eb4SMGWfVVtsLO7nf/axEiQkuvUbOjgE+bKVU
 tsuyLBHUEC4wbH3hWfkV5buuhlNjrWfVCEJc8f95YpwtffRc6tweJjdv8EQBfRVsVaoK
 YMQ1qKjsVb+SytXKppHQehVt2MaKNpztKCcNgTPdNDv7gKP0CkSamFJu0/8vNQzcWHDE
 3rI/uj7xkpTcsaWXoqgE6jRJEuN5XOVYB0FrXee6ipby/K2Q4u1ByPnivFw+UjB7wCrA
 PHsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdt1qNeNOOIV/Y96B4p9UUUF/kFBtwhilxNUTBbVXfxSERBv84WGWaVzk5SrPUleYReXKpn0XO0/We@nongnu.org
X-Gm-Message-State: AOJu0YyeKbHq03KA9OitEZ17PHi1+l7M0EJgoTYS7VOz2oDIGLxxHTJZ
 5CRysaIlgENqv3vaPVQkDkKnuOrA/9BlCbXsAmJrVxoaoWiwNpr9Pu8IVPf6XQ3LVCw85rk9bc5
 I9Vbli3P5elAbBXlfLMV40UirmexmzolSLjlSk3myjHxSTiSVccwnCwcZqaaXMJbQWbHCAJjZOb
 6XB6c/KMGF4CCovE25307S7Bw3mFc=
X-Received: by 2002:a05:600c:4584:b0:426:6551:3174 with SMTP id
 5b1f17b1804b1-42abd2458fcmr42636865e9.29.1724322200824; 
 Thu, 22 Aug 2024 03:23:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV5CGf4hAPeLtQLb570tt+Azfx9vTgsPMTCiKoPdhCG3jw4N6VWBsB/81EWXXdA3P/rXivc1FFQRSMBJdbPcc=
X-Received: by 2002:a05:600c:4584:b0:426:6551:3174 with SMTP id
 5b1f17b1804b1-42abd2458fcmr42636675e9.29.1724322200253; Thu, 22 Aug 2024
 03:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240820170907.6788-1-yichen.wang@bytedance.com>
 <20240820170907.6788-4-yichen.wang@bytedance.com>
 <CAE8KmOypgmrWR6dxAz7iQ=3k+fTXSMKs6kUTUdRisGcq22p8Pw@mail.gmail.com>
 <CAHObMVZh_Y5g8LZbt1r__RX_BXzg3jqm+HFmC3_s3JAj-3YWDg@mail.gmail.com>
In-Reply-To: <CAHObMVZh_Y5g8LZbt1r__RX_BXzg3jqm+HFmC3_s3JAj-3YWDg@mail.gmail.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 22 Aug 2024 15:53:03 +0530
Message-ID: <CAE8KmOzz3vPViCMT09GOhmMdL9EgLEtXopOQkc_MdNXBXL4NbA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 3/5] migration: Add migration parameters
 for QATzip
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>, 
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, 
 Xiaoning Ding <xiaoning.ding@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi,

On Thu, 22 Aug 2024 at 02:13, Yichen Wang <yichen.wang@bytedance.com> wrote:
> After discussing with Intel folks, I decided to align to the existing
> QPL behavior. In QPL, the code path of compression will always go
> through regardless. When acceleration hardware is initialized
> properly, use it. If failed, fallback to software path automatically.
> So in this QAT case, I do the same. The line of "ret =
> qzInit(&q->sess, true);" will do the auto software fallback.

* I see.

> Oh, this line is purely for breaking the big patch into two commits.
> This one plus the following commit [4/5] together implements the full
> feature. I can remove this from the commit message if you prefer.

* Yes, that'll be nice.

Thank you.
---
  - Prasad


