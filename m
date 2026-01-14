Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26F3D29FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfzrL-00087j-P4; Wed, 14 Jan 2026 07:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfzoZ-0006sx-E8
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:17:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfzoV-0005F2-PC
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768393046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uIqWyiVmE2rGO4djY5LZmF6N4itRvVGSElB72IFmMXM=;
 b=cIS/kTX2F9pq1k7hUxnekR2NVVq1vj87QVDJfWikD4R0BPluvVrqtDGb5QzLXa7fMx8RML
 PCApY45BVr4q7cXMIa8U6AG2NZq8QV/hfVpmDgNv5T37lAbgNtyYBpHG+XAUv/Mdoujn2x
 fPtj5dXBFhcSNhcD4MNnY+G2g8GMi8c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-1x69aDE3NzyAn3cTS6altw-1; Wed, 14 Jan 2026 07:17:25 -0500
X-MC-Unique: 1x69aDE3NzyAn3cTS6altw-1
X-Mimecast-MFC-AGG-ID: 1x69aDE3NzyAn3cTS6altw_1768393044
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d5c7a2f54so4505345e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 04:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768393044; x=1768997844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=uIqWyiVmE2rGO4djY5LZmF6N4itRvVGSElB72IFmMXM=;
 b=sPM3Cmvi3zoRw24nDo0EC6XBP9kt+lRfiBgFGL1ctbPFG/N4SIjVwkB/Pv21TV1G60
 eDTGiImlcf016vszIXbLeamo+lDnmDQQYwe5+FN4kiptJJrNSmaWjFk5qT6RtJEkLkAx
 wXk0cBTBpfoGfor65Y1Gcroy+ltHBrHw2/gHMRyTIxCMUCkkEBe3Dh0a/VKS9/F4W20/
 1sUc+RcEbu/D7Cu5G+mrGFMQbG24eJJJImJSMbjtBOfOPBAd8H5uWiyOW6bZEd63cKgj
 2U1+R0Fxo30RPZimvBZuCYVLcCJoCpdEEB+ZTmYNReco74EMhU32Lar1IAGcSU8hh+tX
 3kRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768393044; x=1768997844;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uIqWyiVmE2rGO4djY5LZmF6N4itRvVGSElB72IFmMXM=;
 b=FC8MZOUCcnPafo8c3QyDUTNtWxHKxkY/EPRTpXc3JF8DpriKyA/0QrdvWeES0crhhY
 xTufIRzJNNoy+ZhYZLnzbfTV/C1QxX8dOAECrJc231MJsHe5hQTsRDX2oxBa4NGMZ9/v
 yWEBop4SFdpyAaPSU7ejM6kxnh2iHY3RQMe82Ytk5/b9xULe4NacA3dZmVSZADVimg39
 Ox4IZRpZSVC/pDWgxZESUYF92W62K7rmDqzlKYXgvVlTTQy6H/2TVe7JsETmkkKpDqJS
 r3a2eU+A/XMFqQi7Jwpnt6e45yA/QjjI2BDblZb0thIOfNsSPP3C9ARPSvJ6CO8HBdR7
 y3wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4JT6eUwiOlX4oNIIK1TtMSGZgpIcC5KY4WP5wt97WvChA6P73FwEdqSOclwLfSgoTocchEZQ9DhQE@nongnu.org
X-Gm-Message-State: AOJu0YwEU8GVXknUfJRNDx3ypc3doOaURH+DHC/hOOYj9/+1Zw57U7Qm
 PRDAdhoekQwWZL8CB6YyjCplTvw2/Ip4eSQ2t2t8K0g9Kh1fK5aXo+xDcGtMLaaQFqgpX5yotct
 1+QVs0BDI/oFgfZ9lX6PIKQtWYu+BFZLOtuYpzmgu2C3h/Xa95bDNIFWL
X-Gm-Gg: AY/fxX4HfOfLnN90Qnom24t4FbMxIFXG4RvNprabiwvzQm4zyxw9lnjbXQtuf+npgu5
 NgAu6Oela0WDl/A74Mw6B+PSGVrUiIYyIPBwIN83YB8hW1SRksRzW3m6TUbYpGsF+p+0GMgCvtZ
 WE0sq+aK/5A/Di2mJF8zmyCChBGZ9QTAF45OoWZlY5T0ElY9pnP0EadKXs5Q2bRB383YC3BgIeF
 N36Ty5HlLtP7ojjUCNO06WQuvWl2gMGhove92iFPlJ79kGflkD1qlEak+x3YZHMoVxjI8oT8MZN
 Vf/o57uL6BDiBaJpHVNzP4MQ2o8Cqu9KBKPwSAth9Q9MBl28y9rbeUCmGPPq/phohHg4m3Dwo83
 YN5TwgYguvIxqdjqUjDppXyg/ToCzH4PT02w7vMCZJ1NtENBsQxjjDh/pcY1xocEKnuCzIv4ROj
 y/oFfZSzeJOiB91g==
X-Received: by 2002:a05:600c:16d3:b0:47e:e0b3:2437 with SMTP id
 5b1f17b1804b1-47ee0b329d3mr27970755e9.5.1768393043717; 
 Wed, 14 Jan 2026 04:17:23 -0800 (PST)
X-Received: by 2002:a05:600c:16d3:b0:47e:e0b3:2437 with SMTP id
 5b1f17b1804b1-47ee0b329d3mr27970455e9.5.1768393043251; 
 Wed, 14 Jan 2026 04:17:23 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47ee28144aasm18320775e9.11.2026.01.14.04.17.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 04:17:22 -0800 (PST)
Message-ID: <5279bbb4-a4b8-4c71-8275-92643b8796d7@redhat.com>
Date: Wed, 14 Jan 2026 13:17:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 13/31] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
To: Reinoud Zandijk <reinoud@NetBSD.org>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryo ONODERA <ryoon@netbsd.org>
References: <20250704101433.8813-1-philmd@linaro.org>
 <20250704101433.8813-14-philmd@linaro.org>
 <44ccfba7-21a3-4c24-aa6a-4b2bdb989792@redhat.com>
 <dd7fbe03-1458-4c44-b8db-a9d5e9ae33f1@linaro.org>
 <87v7h44pal.fsf@pond.sub.org> <aWdfqvJhtDt14lTJ@redhat.com>
 <ea1e0e45-f864-4a43-a40e-48fd82c26c56@redhat.com>
 <87a4yg4gmo.fsf@pond.sub.org> <aWd9wP9-9rx0ELhY@gorilla.13thmonkey.org>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aWd9wP9-9rx0ELhY@gorilla.13thmonkey.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/14/26 12:28, Reinoud Zandijk wrote:
> On Wed, Jan 14, 2026 at 11:45:35AM +0100, Markus Armbruster wrote:
>> That they didn't immediately post the fix upstream is a bit of a
>> disappointment.  Deep in the weeds, I guess.
> 
> Sorry to break this but even submitting simple patches and getting them into
> the qemu source tree hasn't been an easy nor enjoyable experience to me to
> understate it

Have you actually tried since 2021 when your last commit was? 
https://patchew.org/search?q=project%3AQEMU+from%3Areinoud says you 
didn't but I may be missing something.

In fact your only contribution was a really big one, and I say this not 
to understate you work but because *almost anything* would be easier 
than submitting a new accelerator.

> so once in a while, a new version is pulled into pkgsrc and
> patches are made on top and if they start to grow or diverge too much a patch
> round can be made requested on the qemu repo. This is just my experience of
> course.

We're not asking you to keep CI up-to-date (which Thomas is doing now, 
despite having no specific need that I know of to support NetBSD), just 
to *report* failure to build from source and tell us "hey, that's how we 
fixed it".  Otherwise we have the false impression that no one even 
cares about new QEMU on NetBSD.

Thanks,

Paolo

ps: sorry about the previous copy of the message, I somehow fat-fingered 
the "encrypt message" command...


