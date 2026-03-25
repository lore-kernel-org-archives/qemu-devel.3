Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3482B109C033
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5R5S-0001TH-NX; Wed, 25 Mar 2026 12:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w5R5R-0001Su-Af
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w5R5O-0006tn-2Z
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774456079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFPbjTtoeWj89rtHTlV3LhnSsMhNw/vlmLqn9yhxk34=;
 b=exEAFuTIm+sgsES6ZRkT13X4C9BY2AbKKqca3b079adFl2V7R5dUYLPXkzjI7E7Q8ZV6dr
 MlE7m19i8dURDxUv63UyRIv+YugcWJE2RU5AR0igVMs2uWjfgDBnDob+X8Tzbphg1VMXqn
 lDQnmV+6NKTx/HSp6gmNNHRdxdd58NQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-XZNYlebiOKORWZgw8arSkQ-1; Wed, 25 Mar 2026 12:27:58 -0400
X-MC-Unique: XZNYlebiOKORWZgw8arSkQ-1
X-Mimecast-MFC-AGG-ID: XZNYlebiOKORWZgw8arSkQ_1774456077
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-486fb29a8b8so440705e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774456077; x=1775060877; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VFPbjTtoeWj89rtHTlV3LhnSsMhNw/vlmLqn9yhxk34=;
 b=mp+ygNS9nMaOBKAqddHCVFSJmWh0BHtRiHUi5WsbX2r+OE+/iCfw6I4jvuVXbi2KCF
 VfIQpTKIuM7zFNAj8w24mlU5dSL+ERk2Sk+pQqX5/swDfdJyCHXc0+qnk0wTbMj+1LfA
 BQv+Wo11uWXqRjD7Eyddze5XgySiRHO5YUNyNPjY9gqwGVnoWiQqwUttRWieOSPsHYuy
 8BTo41B1ljT8Vyu0epqkHTRB3+2jBRuRYfTbHzGiqa8j21gF3qy1f+06iP65Dv+UT4xL
 qT8ca5V7WcciRtZJxD+Ne1kgQ1JsIEgkdHWyy/WF3Wdu33grvudZkhUL8saDG3bILq3i
 1ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774456077; x=1775060877;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VFPbjTtoeWj89rtHTlV3LhnSsMhNw/vlmLqn9yhxk34=;
 b=U/kREJBmAvi40omv6kOSxZJuM7x40PIfve1kELzk23FVGA0YB2PKe7SOoxoP0D2LkD
 Z+5/AL5azZP5WndanyiNLX7vlePIwwm0Iwe3snGMwGAaVEggeSZBTarRfmr4anpOvN/w
 TmD/kvEF38D7IvmxUdgqpGvYLpvLx3qnyVBtn659fnwT69jf4dGoWzRZoUJF6hak4kMb
 j5RDgv0LwRRs3vLqHKDaOg/JCyZwqFjBaEDZCTdS3GYrPMh8lYHstFWElHMmIhEPEFHa
 9iD+2z0xGp/bVOudXDpvumO9dt9AfLPz5YkUk1EA3AVPAihWBlYD7NQFYviPuwgQDnSD
 HoVg==
X-Gm-Message-State: AOJu0YzfTnv6i/0U75YY9rgAva8tvig11y8csC38C3ndqOQUw2UwHr0A
 A/3aVTlt0dqI2ycRcEOpLvPooR+e/0BLiOVU/H72l70+xaX1MrWg54I8BsgMrcBIG6yVJEPmkcv
 a6X7IigmL3dDbbXVcRrsoX/pESdda8bxPbBajJoheY1fHmEAfa8K2gllv/0bE5Oto
X-Gm-Gg: ATEYQzzs8YjrsQ6msvC2ufQZrhCsivatnyj9qfjMfpIuemOMWUrweaNT922/a+LHn/M
 oReOmSaJt0BHykFwI6Fpp8yctUwjXgdrp95nEfzvBe9IwDlsnrI2QmZa+AS5UYniYOPtYIErEHA
 MZau+y7N1S1bzV9UQU1sawAlVFR1eDiDWMFq4v77lRF/QapVOax0oc67ISb9Gzf8shQC5TdY4vR
 aZA4oDIxQh8WEUxeAYuMUgdwz9p9V4JbbzOs72+F/qWFkQZOwDDNRHyadBgcJ5RwVLCt+seHmll
 YgSkgz32ykPNjNxlD+TlaAn24POBIZgzY5k7yJZO3QpcNGJ2anl9jTCWM1pH6Xkg3dQVrewbR9e
 jnR3Nr5SBR3nAqi1/jo0NwEPZi3LuWM6eHpX2tZaZiK4PsIb1em1aLz9+bUp4nChw+wEd5UjuLf
 fr1ZD7x+x9HF9ztkEinMxmv1P/eziDNwOJn+cBHHqgfSjWCbCxcf0=
X-Received: by 2002:a05:600c:4447:b0:485:17a7:b9c7 with SMTP id
 5b1f17b1804b1-48715fd4d49mr58490515e9.10.1774456076604; 
 Wed, 25 Mar 2026 09:27:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4447:b0:485:17a7:b9c7 with SMTP id
 5b1f17b1804b1-48715fd4d49mr58490085e9.10.1774456076146; 
 Wed, 25 Mar 2026 09:27:56 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d06d:9c24:714a:5194:3c7e?
 (p200300cfd737d06d9c24714a51943c7e.dip0.t-ipconnect.de.
 [2003:cf:d737:d06d:9c24:714a:5194:3c7e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871a937bdfsm110893265e9.9.2026.03.25.09.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 09:27:55 -0700 (PDT)
Message-ID: <a8f2eae1-f9d5-43bc-80e9-66fa4be7ed36@redhat.com>
Date: Wed, 25 Mar 2026 17:27:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC 2026] vhost-user memory isolation proposal feedback request
To: Han Zhang <ihanzhzh@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, tfanelli@redhat.com
References: <CAHjCdDAJomXwQ8Z0kkiDGn_8hLWredsby3Nwy4rRgeC9sywc8A@mail.gmail.com>
 <cf2e482e-65fd-418e-bdda-9948c2b39ff3@redhat.com>
 <CAHjCdDAju_svU-RHMP11JYM3G+yu6gwNFTHrAEP3GZnRGLodyw@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAHjCdDAju_svU-RHMP11JYM3G+yu6gwNFTHrAEP3GZnRGLodyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 25.03.26 03:11, Han Zhang wrote:
> On Wed, Mar 25, 2026 at 1:26 AM Hanna Czenczek <hreitz@redhat.com> wrote:
>> Hi Han,
>>
>> I’ve taken a look at your proposal, thanks for submitting it!
>>
>> It clearly shows you looked into the code and the vhost-user spec and
>> made yourself familiar with both, that’s very good. I find it a solid
>> concept. I also like your clear separation in fundamental work and later
>> optimization.
>>
>> I have one question: In the optimization section, you suggest using a
>> memory pool. I fully agree that’s a good optimization, but it makes me
>> wonder what model you have in mind for the original implementation. Do
>> you plan on allocating a new buffer for each request? (To be clear: I’m
>> not saying that would be a bad idea for the initial proof-of-concept,
>> I’m just asking for clarification.)
>>
> Hi Hanna,
>
> Thank you very much for reviewing my proposal carefully, and for
> raising such a precise question — it is extremely helpful.
>
> To answer directly: yes, in the initial implementation phase I plan
> to allocate bounce buffers per request (more precisely, per
> VirtQueueElement) and release them once the request is completed.
> This is a correctness-first approach.

Agreed, sounds good!

>> To help make these detail questions clearer, could you lay out how an
>> example request from the guest to the vhost-user back-end would go
>> through all the layers, and the response back?
> In the initial implementation, the request path from guest ->
> vhost-user backend -> guest is as follows:
>
> 1. Guest submits the descriptor and kicks the queue.
> 2. QEMU intercepts the request in the SVQ avail handler.
> 3. QEMU allocates isolated bounce memory for the request and
> registers it to the backend via ADD_MEM_REG.
> 4. For the guest->device buffer, QEMU copies data from guest RAM
> to bounce.
> 5. QEMU constructs shadow descriptors pointing into bounce memory,
> injects them into the shadow vring, and forwards the request
> to the backend.
> 6. The backend handles the request: it reads input segments and
> writes responses to output segments as needed, then updates
> the used ring.
> 7. QEMU processes completion in the SVQ used handler.
> 8. For the device->guest buffer, QEMU copies data back from bounce
> to guest RAM and completes the request for the guest.
> 9. QEMU performs REM_MEM_REG and frees the requested resources.

Yes, that sounds like the right path.

> Once this path is functionally correct and covered by tests,
> I will prioritize evaluating and rolling out a memory pool approach:
> pre-allocate and pre-register a reusable set of bounce memory
> at device start, then lease/return during requests.
> The depth will be decided based on
> implementation complexity and measured benefit.

Agreed.

> If you think it makes sense, I can also add this "request lifecycle example"
> to the proposal text for more clarity.

I think it would be nice as an illustration, yes.


Thanks!

Hanna


