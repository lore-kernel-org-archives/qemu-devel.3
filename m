Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9156C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH2Wa-0005Pv-3Y; Wed, 14 Oct 2026 13:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xH2WY-0005OL-DY
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 13:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xH2WW-0003f1-Ld
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 13:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791997935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OiXUJNylZx1LNYqSjxlyb9jsE7cazBYZSs9GOSX48+4=;
 b=Un+nHIWKpDkej2kU4P7ZJZuy9Q8qu1mcn7eQ1+OF58Jitv1v9qatkBjbgBiwgB+GKazLps
 JzeP2/fSetA7t68IQqmPHrb5WG019fM1h5Xusos1g9jFET5wKpndM4opzBk7x6enBXEp3+
 notSB0OVswhJM4N2OAdjwwNCF2vzydU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-bLkG968BMrOyKi-7tdo-Ig-1; Wed, 14 Oct 2026 17:12:13 +0000
X-MC-Unique: bLkG968BMrOyKi-7tdo-Ig-1
X-Mimecast-MFC-AGG-ID: bLkG968BMrOyKi-7tdo-Ig_1791997932
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a019d53f46so9617635e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791997932; x=1792602732; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OiXUJNylZx1LNYqSjxlyb9jsE7cazBYZSs9GOSX48+4=;
 b=pqruuBXLIB/QtG29qsG7cUt6r4feKEla4rxUEHM0i98CRzgMyVNraCg8NjhrBdtUMh
 xUAps/7+pK2yvcCtkSrUpgo0whkecOIp0Riy0jIXUdF0E4QZ10BEGD21ZpGFId12cXe8
 fIDFvxXtpUVPORckkxKJwhW4egwlsNhbum5wr4sm8EpOAnC7o3RRFWv/pODytFiijWO8
 onIyvx784MsBdAJeOAsMTqo4XSY4wY0ABEIs47nKamXmbB2vbYBrML3tf4ZAXcRBju8u
 BM2bH9Bz/jQ0+QxLRRuWrHnVDD6PtOM2exqZ6kfahEgt2KKq0qInT0voMB0GWB5s/qDh
 VF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791997932; x=1792602732;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OiXUJNylZx1LNYqSjxlyb9jsE7cazBYZSs9GOSX48+4=;
 b=k6ILuL4qUucw8OQt9sH+MIe/CJz60lNXUREc6ty0Knvm0WNyFyhsdstwZfCqXBYRLW
 I4hEWUonVjdx0Mw/a54KpgJN2td7dhEMxlFH6qTI9noCPVE4d9xqbNPMNbYrklTQJGi3
 26NLsyMlkxC4sLmYXP2QL3Y0f0VY2LSLPBeCFzCUgjRtAodSMClhF+Zod64qg0gA/9Ma
 5qdNHkx/r5QbZMPWGzMC4M9m1UDBC2YMGQ8lxICp3+cY7DsnTptVApdLmp/etApdrpOA
 NaaJEBkbOLkyEA/siVp3qTJtE0UIPiL+fNQ9GdKYKUm1q1l7MLT8k1mhsR3VsOZs3LPU
 LCiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz90RZRB8Pu5ek0/x52FvBgrSl5Z1iMVJHojhWaMg/4sLVj+XQ/LluOvLwBZ5pmJcgVrZEMH7nBpMtB@nongnu.org
X-Gm-Message-State: AFq9FYLsS2jeNLiDJRaWK0ippYjN6XjbLfDTK5yGJx2B8b1LD4mGtXPM
 MMiTUaxTWnLKCVFSf3Vl7NSqF8MqqbqMccEpqBHO5AprZVkuQCZcOOixXtqoVd0iFk3tx5BJNzO
 aW6OMFcOfJOm/fyEXHGN/uA/RfVHCR/YU6NRTquLEZNLjS1dSiNjXDqpm
X-Gm-Gg: AYBFou1suRIbp0fH3xYDyGsxj5syL6G+Xcqt7S4kuB2s0RGkBwprCdvMn5G2fn5mtEK
 2KO8Fis8yk2NsbmZ1ASY1FmtcxGpnIi/EJ0FDL4tGlu5VKxdpwxzkIuRP/kyZxdl4kn8vdbFYYK
 Pzz2MKxejiEaQCcNjR/X1nWCM7fXkKwjOV3kO20iG55/Df1ennOF86huN2i9kznKXg5NI+FWqyV
 eNWekmtmbltRBc9Xaf5sMv1ILnKi4FETRIjLqAhbs1WvxH8AYW0frIg/4ccwEP7hQzcQZN61Ll7
 3dXYzvkjGLyNlDLT4goWf1U5jkGdyGWKMJLnaypTyDOHOn8t2xyqRrm4rNHhf9DuP1VouYPWBz1
 nYw5wSgxtwbJvz82lnNDy1wiJlws2LQ+r78U2HDfG
X-Received: by 2002:a05:600c:154c:b0:49e:74b6:740f with SMTP id
 5b1f17b1804b1-4a18e4aa310mr334588715e9.17.1791997932289; 
 Wed, 14 Oct 2026 10:12:12 -0700 (PDT)
X-Received: by 2002:a05:600c:154c:b0:49e:74b6:740f with SMTP id
 5b1f17b1804b1-4a18e4aa310mr334588195e9.17.1791997931874; 
 Wed, 14 Oct 2026 10:12:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0acb1ebsm13541817f8f.44.2026.10.14.10.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 10:12:11 -0700 (PDT)
Message-ID: <1365f6c8-c44a-409d-a0d0-696adfc9417e@redhat.com>
Date: Wed, 14 Oct 2026 19:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Establishing an order between messages on the primary and twin
 sockets
To: =?UTF-8?Q?Matej_Gen=C4=8Di?= <matej.genci@gmail.com>,
 qemu-devel@nongnu.org, john.levon@nutanix.com, thanos.makatos@nutanix.com
References: <CAHPkGVdzQzqnW0MS9G-7xDuakHfjqYZCRR9HATDsBy0ZyTXLmw@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAHPkGVdzQzqnW0MS9G-7xDuakHfjqYZCRR9HATDsBy0ZyTXLmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/14/26 17:10, Matej Genči wrote:
> I'm writing a TCP transport for vfio-user. When I was looking into
> bringing back the interrupt message, I realised that currently we have
> no mechanism to establish the order of transactions across the primary
> and the twin socket. With a slow connection, operations can happen in
> this order:
> 
> 1. twin: Server sends an interrupt message
> 2. prim: Client does a REGION_WRITE to disable (or reconfigure) interrupts
> 3. prim: Client does a REGION_READ to ensure the write was processed
> 4. prim: Server completes the read
> 5. twin: Interrupt message arrives, client raises an interrupt
> 
> My understanding is that PCI protocol guarantees that 4 and 5 can
> never happen in that order - the read acts as a barrier and the
> interrupt will be sent before the device responds to the read.
> This shouldn't be an issue if we use a single socket. All multi stream
> transports (UNIX twin sockets, even interrupts via eventfd) can hit
> this race, but TCP seems particularly susceptible.
> 
> To address this, I propose adding a sequence number to every message
> on the twin socket (explicit in the message payload or a separate
> counter in the client and server, I think either will work).
> Replies on the primary socket will contain a `twin_seq` field with the
> sequence number of the last message sent on the twin socket. Before
> acting on that reply, the client must have received every message from
> the twin socket with sequence number <= twin_seq in the reply. Posted
> writes must be delivered to memory or interrupt controller, for
> non-posted requests the client should receive them without waiting for
> completion.
> 
> The `twin_seq` field should probably be a negotiated feature, which
> would require additional changes to the wire format. Alternatively, if
> we don't mind a backwards incompatible twin socket spec, we could
> enforce this for all twin socket connections.
> 
> 
> I want to get your opinion before I propose some spec changes or
> publish QEMU patches.

Does vfio-user support twin socket mode ? I don't see any implementation.

Thanks,

C.
  

> Fwiw I opened a discussion on this topic on
> https://github.com/nutanix/libvfio-user/discussions/883 as well before
> Thanos pointed me here.
> 
> 
> Matej


