Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DF7CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyhR-0001ve-C0; Thu, 21 May 2026 04:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPyhP-0001vP-Ly
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPyhO-0005kz-8n
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779351849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kXJaZXcu0LKgZ/6LBO6R69KjgP8dzEWPyECmQEBK4ps=;
 b=A2VPa0/lRxtZTjzcx/c/5ruob4oioJiQY8w/dYbi7CM8bxhEYgUDE4LPsr09ZdG7ty3i2m
 m9Ypc4vBP0aHYO/YYgvvQWB2A5Fh921PhVXh9ptjDcr2ZT7GX6Tf+4JnqfSlXb5qVOte4g
 WHR/zwK2pRtCyo1ET4k0brxfNWeLnF4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-5Zb-H4RuNmm3sk6UdmbTJA-1; Thu, 21 May 2026 04:24:07 -0400
X-MC-Unique: 5Zb-H4RuNmm3sk6UdmbTJA-1
X-Mimecast-MFC-AGG-ID: 5Zb-H4RuNmm3sk6UdmbTJA_1779351846
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48feb0298d7so45333115e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 01:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779351846; x=1779956646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kXJaZXcu0LKgZ/6LBO6R69KjgP8dzEWPyECmQEBK4ps=;
 b=sYX60YNz2ydSXO2kayqA6Ny0ivncOWP7RWb4qHvoJZmcg/47oLCJMTKUzYMvUJGaUY
 yE1FYFkDdyyO2WRx4vmBLUAPPv96gRv92VbFQt3lICKfH0AR8mCU/Y9VNodM9jXbL/nw
 +ummWdiYpiEnsN2bSnC5RkK9suZVtBhWEbgMWJ366vXHskreDUJPs/GiLjDf6/z+rqvR
 qK1dtFtqQVXG4JsJWivUvd+L9+uoEb94XUiJeIPTnGHGe5/kiHTPI84qZrDomqt/q6ax
 s4jez0c725nScSpR/Jjqc6AgLOC318mZjRfpJHKkbL8cAQ5ryPK5ZOaZPnve+Sol7ro8
 9lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779351846; x=1779956646;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXJaZXcu0LKgZ/6LBO6R69KjgP8dzEWPyECmQEBK4ps=;
 b=dgxXbX8zG31OT5Xi63mEZ+VXPxJ8U8caoDcD6wKirfe0+V3LjvDQ/SvBy5ePI5a1QD
 kO3aDrOtd0aBEmpl78QwoRHeDSwF3tXLcIFOm4FZGYgn7ir1VtlajS4baU/XwdspotEb
 rJ+uA/Lc1zXfBPXnRSk9X/+OtmOi/Nsp6qGNIleUrKyVuCVIklD0jsbpuWL5uuXBCWnX
 JL0VCRToeKHY4q1ysmjz8B99LHoCpZgDMjnzHS/1plPpKsDRRPHQFEWWLBV7mgkbBObD
 souUXhUwaP6oCLQkjJc4IyOA/sKQss3jE82X8C0xRYpV/N9oYC/Ixw6LQk9ev0z09I2C
 ZibA==
X-Gm-Message-State: AOJu0YxJqIj+eNOAlnYD0pe51mMkdOtFSZZ8vhFhKdRN1P41aoAANDy5
 n02JW9lPeYvmtX3dL1QcM+8+S8oHi2W0xC9RO9t+RShqppdu4Vc1v1o4UCoTPStbzNPy+pH4KOK
 VBdkHTHflmUxXiHgFCwjj2KP7Md723fzGmE3ZfOcWEoOY6LoENig/pw/3
X-Gm-Gg: Acq92OHesTT803wh+MMRq88VGiU2JbYMQcI2ntFhKumGsopIydH5icYRmzGKMWdkpC8
 AKNtJwf99f4U+f6H1+SUuC79OAEG9xNS6FgZuVdMBNvaFc4DAJdw8iF0uPsvD6818oCNq/9Oxws
 NZHNZoNZlkZK0Nz4c5ZnrTyJKVLktsBrzemsgKxnBp1a1foDZ/CuIlsY2Jtgzebqz3x+y5J7nJz
 5OEeBLaOg7owWY1X90f6QhI5rYv2pdIP5fkJYul6hVKtLe499EN+vqLQXtck5oM3yp/awV0GXkX
 7VvLufisls65ql6ykGzZqoG1LmqsHm4pOGC6lBuQw1wNtX95i6rDV7eUhlRoFNJzs1n4g4VzHw+
 7B1BrHIH5f+t/JTiuf+nTHaQQqhTmSqDc9B7UL8be9XgFH6iv+AxvVrFn/374
X-Received: by 2002:a05:600c:a414:b0:48f:e518:d110 with SMTP id
 5b1f17b1804b1-490360ebc07mr19593375e9.32.1779351845843; 
 Thu, 21 May 2026 01:24:05 -0700 (PDT)
X-Received: by 2002:a05:600c:a414:b0:48f:e518:d110 with SMTP id
 5b1f17b1804b1-490360ebc07mr19593035e9.32.1779351845417; 
 Thu, 21 May 2026 01:24:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035eba897sm13748975e9.5.2026.05.21.01.24.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 01:24:04 -0700 (PDT)
Message-ID: <67f25191-a755-47e4-a560-3d1c755fb77d@redhat.com>
Date: Thu, 21 May 2026 10:24:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
To: Jagannathan Raman <jag.raman@oracle.com>,
 John Levon <john.levon@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af3zEgHy7UMYN4Ow@lent>
 <IA4PR10MB83013C640DBB740BE8872FE4903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af31Oo6gXE69c7eb@lent> <d7c29d61-9146-4cf8-83f7-e650572b338b@oracle.com>
 <af3_CqQf1wSSWYYY@lent> <f91cc783-0284-44c5-bfb5-a95b4abba380@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <f91cc783-0284-44c5-bfb5-a95b4abba380@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

Hi,

>> How about the following:
>>
>> 1) mark the whole subsystem as Odd Fixes
>>
>> 2) mark the legacy backend as Obsolete
>>
>> 3) if we don't see any further work on converting mpqemu over to vfio-user
>> properly over, say, the next calendar year, then remove the whole feature.
> 
> The above strategy sounds good to me.
> 
> Thanks!
> 
Were changes sent for step 1,2 ?

Thanks,

C.


