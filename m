Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B897ACD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdY3-0006Pv-Q5; Mon, 08 Jun 2026 13:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wWdXz-0006PL-9H
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wWdXx-0005mQ-Te
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780938836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AMS8o+uMadScrn1SbV0ZyHdgbWx2TsoNtYYJAaveu9s=;
 b=VAjmeRHwMuV8AEPKpyOQd4Lq8KrXbv+CoZn6Gw3AIxnEvYXxNBJvGr+06jRcfwLHWqzlDR
 yJGX/yO4VX9LsOacM4VsntZ35NisHzup4xH9yYeDxk+C34CcV4yssCpFJae34ZsFk22dzm
 pB/mWgkHdj9Heu2j6M81arvLk1csJgk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-nUO-UwB7MIWC72vza-mD9g-1; Mon, 08 Jun 2026 13:13:54 -0400
X-MC-Unique: nUO-UwB7MIWC72vza-mD9g-1
X-Mimecast-MFC-AGG-ID: nUO-UwB7MIWC72vza-mD9g_1780938834
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a786f987so52563555e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 10:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780938833; x=1781543633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=AMS8o+uMadScrn1SbV0ZyHdgbWx2TsoNtYYJAaveu9s=;
 b=c6krhrV52vYaGGbxS0a9yp3YmjRto1+R2Q7TlyfWgX7aLFLrGdIdN8pSChDs4mLBIo
 ERvOQt2r+IG1Y447h0T1xyW2bWtS1CDXI699Pz61iFUa2hTYkg5KgxmMsLt8xfOQyXZc
 Ee5c085AQ4SUR4xDluYmlwsnVcJa3Ykyskydg98QYkuUGBC44G7JfA4C5n2Zb6LFzXtB
 r9LCHeeE4W2NAtY7mKR1cadnh/YigUNgk4yIRP2QLtIkC1YqVo2uLiN/1FpHpn56KGZY
 afJXzdjo19pBPeGufISQqNPRmR2pv38EgJihH7pbSrfUGekLi39cIszxmjjmUlwskM53
 sOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938833; x=1781543633;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMS8o+uMadScrn1SbV0ZyHdgbWx2TsoNtYYJAaveu9s=;
 b=S0M9/HOrsCuELFcWip7n5xvLXoxCoPjy+q6F0Km0NnAiR3vJfhA/xVIHIUXockfXEH
 6x2EDzo4c4W4NPt3fFO2U3OAbhMQ4yd+LrwuWoSPez2ygi7CMkcNoZi6dttQbHFvKCZH
 bE0gXw8WyacgiH+ZqJ9/AUGE1ZkZ6ISn6Et9n5IN+It9Bi7kvdZ0w4LnvgQiw377lotp
 kjOnx1brmFDoRnTnhiozia9W7Mqe3iwvdbW1xoDzgdV61h1t21xe92oMySCDYixeDJZO
 5VuPcOokTLJKvdcZtq3ZF3RId6vAjd0cl7BPffJp0Blx/9kKboozQVOBjU8OsnDi+zM+
 hV0Q==
X-Gm-Message-State: AOJu0YwIWDs+p48LwGnp4xcVTyyCWdLs1MfY0eQ2VfuZYhucLawMpXE+
 RqQGPuIVeK0+ZkQDxkfwBZMCe/mMsa9DNurLzUtV0wjncAcFBIWYq3SDS9x5hn02Ic/KZ2MjuxN
 p6HnMo2Whkv8cYXSk8h409TzPrxIn5rXvqM+d6IXEItIof072x7XSmdZJ
X-Gm-Gg: Acq92OH9HcG1IuDfKKjK0LqoQU7bkYBtv6Of1b0TXg/spavM/U47uxn+K2mRooTFo5Q
 BxFIUnBEpGIJradcP/zkhmxwYWbNdivxbGIOcjp9i9OTgdqwEnjQJUYXoyITo3sOLuIOUGnp2l9
 qE13uTciie22UdK4g316PveSmdsNJtaZSjkHtenGOiTtO/U40eU90Dg8lEJxrpHrJNqNmS4Wdcj
 jgx3WIHah6NvvawHiIOtiWuXLCmULiQNI8xUDNSzknV5hKegba4o0nPeEqVE0YFi6pq9ziTLxbg
 iULycVb0zxIAH9V4eM9RuW+Lbv8lwBNuEPDtp56xn+BCdSofLdwpXHa29I+gLyG/qrCEkwL97zv
 4L1ofoLXe90DAuAjV+0P67Lj1ZFNdwg==
X-Received: by 2002:a05:600c:458a:b0:48f:e518:d110 with SMTP id
 5b1f17b1804b1-490c2614beemr242978285e9.32.1780938833474; 
 Mon, 08 Jun 2026 10:13:53 -0700 (PDT)
X-Received: by 2002:a05:600c:458a:b0:48f:e518:d110 with SMTP id
 5b1f17b1804b1-490c2614beemr242978045e9.32.1780938833089; 
 Mon, 08 Jun 2026 10:13:53 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2cbb4cbsm222324455e9.0.2026.06.08.10.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 10:13:52 -0700 (PDT)
Message-ID: <f2516211-6fbc-4714-b674-4276464f94ff@redhat.com>
Date: Mon, 8 Jun 2026 19:13:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: artifact download for qtest
To: Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <CAK3XEhMNqHbkL2P6Xg3_hJ8WAxhPQgurjvuZg-vXUDZ5=x-RRA@mail.gmail.com>
Content-Language: en-US
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAK3XEhMNqHbkL2P6Xg3_hJ8WAxhPQgurjvuZg-vXUDZ5=x-RRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 30/05/2026 16.56, Ani Sinha wrote:
> Hi,
> 
> I am trying to write a qtest for which I need an IGVM file. I have the
> file, about 54 MiB in size.

54 MiB is quite big, I agree that we likely don't want to check that into 
the main repository, especially if it is for a test only...
(BTW, what's its compressed size?)

> Instead of committing this IGVM binary
> file with the test, I wanted to check if I can put it somewhere, say
> in a gitlab repo and then make the test download it. This would be
> similar to asset downloads for functional tests. No this test cannot
> be a python functional test.  I am wondering if anyone has faced this
> situation before and what the best way to solve this problem is.

I'm not maintaining the qtests anymore, but I assume that there is no 
interest in duplicating all the asset downloading logic there.

What's the exact reason why you cannot do it as a functional test instead? 
You could maybe also start the qemu binary there with "-accel qtest -qtest 
..." to fake a qtest environment - a little bit cumbersome, but certainly 
doable, I think.

  Thomas


