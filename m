Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE96C98307
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9KaS-0003ix-Nm; Wed, 23 Sep 2026 06:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x9KaR-0003iN-8A
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x9KaP-0001Ax-4C
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790160743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h7vrrf8bMt4CnzPaEK76AE1JPIq1XxXJmo33XhIVtRo=;
 b=ORvmHwHg9Avk6Ji9gGypBBqKmw4DBEyY/uerKqaqYqRO5dR51m0KhudS8WmPWVKLut9VYW
 0+uC1eIltUo9+gLEo1atJJw5SNMvqikbKAnv717NJ92ORlCO6G6hgpjOcbwVoNRXNIiEoc
 xKFxmwzJ/VDz2oBlPlVwJcTXgF2yNNg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-rj2PNZ5iNVy8WG7gOPhlfg-1; Wed, 23 Sep 2026 06:52:22 -0400
X-MC-Unique: rj2PNZ5iNVy8WG7gOPhlfg-1
X-Mimecast-MFC-AGG-ID: rj2PNZ5iNVy8WG7gOPhlfg_1790160741
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-485866e0066so344161f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 03:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790160741; x=1790765541; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h7vrrf8bMt4CnzPaEK76AE1JPIq1XxXJmo33XhIVtRo=;
 b=Wx8FT9psPevs4rNX6ATaWg6N7G10c0Wc1jOXcKGjn/bsaQN3cEFTINMnK51Ay8ey/r
 mJE2Rbk8BaWRzYcF7YWUHX2XgkVUSvz5qNEFamzXrU01wIVVDubimU0TrR/8PU5dd/ao
 8qPNP9M5uPpkyCsTXrDZrVSGswxhcwIHUVCrrZMhVqhK0x9Is3gRoXWBcypeRkYfd5In
 z36esiOKzMmAPHNWGzp6jlI1QSMVpmpkntLdhHLbDppe9ODnV363KMj2c+5Jsl0e1OYT
 ISGwIPngcpYA27o9aafVex/eRr5KV6Ew6oSQbFxQ9HkANuikRqOSdAe7V6kh61GyBxyc
 mkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790160741; x=1790765541;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h7vrrf8bMt4CnzPaEK76AE1JPIq1XxXJmo33XhIVtRo=;
 b=PXMlCG+YGWOmltvGWusW23vEaKxgKSakt/DuQsNf1n7bsu2lfkXMUmYPmxTZr69wbZ
 7sYu3g/1NIz8MCv7mMmgcoE3nrmx21JzGDnQQn08/REsUYfQ7U9tZfKXoCgoHcs0/eNI
 fMRaKnBnHeXDngH8/nQwm/3tVUyN9uFgIz2/4NjZnsxxZg5XHRfX6f1ttA3IpjWkWtq4
 Ykfd8WhO1IT8zIeb9kNZiLTzhzyn9LFL19BzVoHVTxe5c6UnKM65c0km7nLmXkcDlija
 6cLPXwNQzQwkKT81Y+VP/ZoiiqY2LN3psDOOqkYIgZvkVYiPQK94SaK5nBNfyqsxcwxt
 eFtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7Jo1vp6ZcY79ZbR0kEDKEoXY49x++k2aS//7o4eEny9121N3DsXW+1MUlYxohj2w0Ty4okvq5fl6Q@nongnu.org
X-Gm-Message-State: AFuF++lwf19xaeGJmjcNtppSla44EZPxS8E8hBevljV7K2PCpZVdrG2O
 cEYEKn3K2Oc2jB/yeGC27m3e0Ul0vwuYEcSQtJHV/3F4+mhHa8HkyJtQY/sN4TFfCvwWdtCriNu
 PRoHO4cU/vji5S/ty3f+9zjWGuttXQdH9zuVZOQwGAsPl8fbIi9oHoDJf
X-Gm-Gg: AYBFou3esLv9YjObDbXZDxRmpq1fYl2eGRrA57rvhRiam2hRNGotzHKCCGbJV/Szndq
 pj62TatHKBv+SJu1jawBrarYDPqmKj70EDZfYGSyIGDqZyHDMyrwHaoB+iuPhlOjRS2uGYP/zkJ
 XS5MNgb0Cw+OVAHDftPq+3OyacVF98R/EgnfkBnsOWHTV6+9XoMsBAGcAWPefI1cht5QuxQueyp
 lDq+x44LACZFfqs5ycEqp8nLZrpwao5vgF10MMoyLFfQLkMKaUoa6ai50KMSlJlrrmpcvomLQuW
 3Ho0w1YkhhWwGD8SL/WzyKoE+lGvwFzrs6XAVDUKzkjjIWW2xZ7/Z8QbIb4jRWfJMSZOdIjSRlU
 7kucIXlWjamJfjQKuRCrSF3I5iOZXAmCzyti2i7gmGfYyE2rcD3V3yVBSuNR/xMCKrWZg1ozLmi
 uUpl8y09X0MqaIeUJKIbyMwq75CDbeLQ==
X-Received: by 2002:a05:6000:420c:b0:486:f9ea:796f with SMTP id
 ffacd0b85a97d-488670b6fccmr3791150f8f.41.1790160741278; 
 Wed, 23 Sep 2026 03:52:21 -0700 (PDT)
X-Received: by 2002:a05:6000:420c:b0:486:f9ea:796f with SMTP id
 ffacd0b85a97d-488670b6fccmr3791117f8f.41.1790160740949; 
 Wed, 23 Sep 2026 03:52:20 -0700 (PDT)
Received: from ?IPV6:2003:cf:d749:526e:3864:2ce3:24f2:e6d4?
 (p200300cfd749526e38642ce324f2e6d4.dip0.t-ipconnect.de.
 [2003:cf:d749:526e:3864:2ce3:24f2:e6d4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488682673bdsm6091331f8f.2.2026.09.23.03.52.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 03:52:19 -0700 (PDT)
Message-ID: <2c3712c9-24ba-4657-9ef3-f835fec48afb@redhat.com>
Date: Wed, 23 Sep 2026 12:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] block: BLOCK_IO_DELAY event
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, John Snow
 <jsnow@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260903140815.GC825275@fedora>
 <8592119d-665d-482e-9502-8f4a1a69c10d@redhat.com>
 <20260921204126.GC115897@fedora> <arKDQRZ7q7k0JvG1@redhat.com>
 <20260922171838.GA231912@fedora>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260922171838.GA231912@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 22.09.26 19:18, Stefan Hajnoczi wrote:
> On Tue, Sep 22, 2026 at 03:31:49PM +0200, Kevin Wolf wrote:
>> Am 21.09.2026 um 22:41 hat Stefan Hajnoczi geschrieben:
>>> On Wed, Sep 16, 2026 at 10:04:51AM +0200, Hanna Czenczek wrote:
>>>> On 03.09.26 16:08, Stefan Hajnoczi wrote:
>>>>> On Mon, Aug 31, 2026 at 03:51:56PM +0200, Hanna Czenczek wrote:
>>>> The problem is that if the destructor has to be called explicitly, we may
>>>> forget to do so; and accounting is done on the device emulation level, so
>>>> there is no central place where the pairing of constructor and destructor
>>>> would be obvious and trivial to verify.
>>> This is the part I'm asking about: can accounting be done by the block
>>> layer? There might be cases that are purely handled in device emulation
>>> code without a call into the block layer. In that case the accounting
>>> still needs to be done in device emulation code. But when device
>>> emulation calls blk_aio_*(), it should not do accounting itself.
>> Apart from cases where requests are completed entirely within the
>> device (like for all block_acct_invalid() callers), there are also cases
>> where a single device-level requests involves multiple backend-level
>> requests. I was thinking of IDE TRIM initially, but actually I think
>> splitting can happen for any request that uses the DMA helpers.
>>
>> Conversely, virtio-blk can merge requests, so you get a single request
>> in the backend that covers multiple requests in the device.
> Sticking to the requests as seen by the device seems like the cleanest
> solution rather than cheating and counting host requests in some places.
>
> The idea to move the accounting into blk_aio_*() doesn't work well in
> light of this.

Does this mean you would be against separating delay monitoring from the 
rest of accounting?

Because to me that still sounds reasonable: To do delay monitoring in 
the BB layer, separate from accounting cookies, to have a simple 
lifecycle and timely reporting.

(And as you did say, if one wants the guest-device-request-level delay 
information, the histogram is there O:) )

Hanna


