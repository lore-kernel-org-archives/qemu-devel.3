Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE82FD3A67C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 18:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5r9u-0003Ek-As; Tue, 29 Oct 2024 14:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t5r9r-0003EC-F1
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 14:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t5r9p-0007Vd-0o
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 14:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730227291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SBskgoXwgCQ3bcV+8yC2YCMYgCh5cogJzuk0jM5BAds=;
 b=WfUhkRJHHcw0EwPzsV9WlIr2F5xJNSrVXveGQdI+oLnsnkkPbxU870WKJpVzkB23b1H1uh
 2v/x7f8nlPo+PS8Ayia/UnnQ1o4RILqINEEnwFXKqSbwFHGwaYs1DyrTr+z3yU3EA50nXK
 3moX+kTVcydduLmkRStiJNUO4fLj68M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447--86Yinm9Na68zG_7U9WDPw-1; Tue, 29 Oct 2024 14:41:30 -0400
X-MC-Unique: -86Yinm9Na68zG_7U9WDPw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d45f1e935so3213958f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 11:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730227289; x=1730832089;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SBskgoXwgCQ3bcV+8yC2YCMYgCh5cogJzuk0jM5BAds=;
 b=lL7BMBi26xHk7oYFTuucuIEFfHqtZ/dRl411lHtw+4+dE1ch2Q6GN42AkCKthvN4om
 Am0bkrms9ATJOQ0c2YQjZouaLTIDrBcPL29Gc0ITyBrJWj+3OWgoZOx3npBBcetRDkum
 +szQfnQesYSMl8U51/AlJC7Jdlnfn9v8eRZjB30sWijXmBcP4n50xH8bK55X7L/RqYPX
 y06puPlNU0gmJSIWzlel/8blibb1XUsoSX6Se4GZcGW8fInR24N1RNp/NO8BHtwDT0zR
 sPwpu0U78b4Tp538LgreXa+JhzQRIZmnkfXsKdEtLEMwJQVofmyq0XXvycUnQaDXKBKY
 klnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOSImanHMACLBY2OC8d/RCM1UWEV/NHyFJ8jf5+4sPReaOnTnEYUcOsAdeHk+Dgtcrr7/gmPxJjsTg@nongnu.org
X-Gm-Message-State: AOJu0Yw21p2kwILdEjMHPUTKUy7ytWesbddHqYW/gBAENT8oCDVHO4jG
 dtQuJdn6VSYvQYoVIzYOdphxaeXjT8s1ZyXZcfMiFx4vj7GGHkFWDEF+6FMXUwxVIDW6tSSoGah
 PxJLij27/YBq/D5576/uJYWbZUvK4vsCVbRZJm8RAgUV6iUhu9/kA
X-Received: by 2002:a5d:620b:0:b0:37d:940c:7394 with SMTP id
 ffacd0b85a97d-3806115a72dmr8008842f8f.32.1730227288742; 
 Tue, 29 Oct 2024 11:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVZKCfCuLcOsDUtjnq3YrbWHLUD08Nl8IAdExAXD+UOKn+u0qf50R5b4H8SoluYBgwlLDR7w==
X-Received: by 2002:a5d:620b:0:b0:37d:940c:7394 with SMTP id
 ffacd0b85a97d-3806115a72dmr8008831f8f.32.1730227288365; 
 Tue, 29 Oct 2024 11:41:28 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-251.web.vodafone.de.
 [109.42.48.251]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b70c44sm13236593f8f.80.2024.10.29.11.41.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 11:41:27 -0700 (PDT)
Message-ID: <e4d010dd-cadf-4c23-bf13-3da86713a057@redhat.com>
Date: Tue, 29 Oct 2024 19:41:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: Add a test for sh4eb
To: Rob Landley <rob@landley.net>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20241024082735.42324-1-thuth@redhat.com>
 <20241024082735.42324-3-thuth@redhat.com>
 <17599c22-6aba-4855-b8a0-43412131823b@landley.net>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <17599c22-6aba-4855-b8a0-43412131823b@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 29/10/2024 18.58, Rob Landley wrote:
> On 10/24/24 03:27, Thomas Huth wrote:
>> Now that we are aware of binaries that are available for sh4eb,
>> we should make sure that there are no regressions with this
>> target and test it regularly in our CI.
> 
> Any progress on restoring this? Didn't see it in "git pull" just now...

I'll make sure to put the patches in my next pull request before the QEMU 
soft freeze starts next week.

>> +class R2dEBTest(LinuxKernelTest):
>> +
>> +    ASSET_TGZ = Asset(
>> +        'https://landley.net/bin/mkroot/0.8.11/sh4eb.tgz',
>> +        'be8c6cb5aef8406899dc5aa5e22b6aa45840eb886cdd3ced51555c10577ada2c')
> 
> Feel free to pull binaries from my site, but from a reliability perspective 
> "some random dude got hit by a bus so a site went down that broke our test 
> infrastructure" seems a bit dodgy. (Even the Internet Archive has been 
> having reliability issues of late, and "as long as Brewster Kahle's dot-com 
> money holds out" seems a similar bus number.)
> 
> Building it yourself from source seems more reliable. Is there any sort of 
> policy here?

We don't really have any infrastructure in place for building such assets 
within the QEMU CI, but the binaries get cached locally after the initial 
download, so we should at least be able to retrieve them from these caches 
in case your original site becomes unavailable ...

> And even do automated smoketests on them showing it can boot, run a shell 
> script, and access a virtual block device and network connection:
> 
>    https://github.com/landley/toybox/blob/master/mkroot/testroot.sh

... but if you're using github anyway, maybe you could also build the 
binaries via github actions and publish the assets there? That would make it 
easier for cloning and reproducing the stuff, I think.

Anyway, thank you very much for providing the binaries already on your site, 
that's really helpful!

  Thomas


