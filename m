Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F71C4452D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 00:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmLDY-0003qO-Kk; Tue, 21 Jul 2026 20:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wmLDX-0003py-HA
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 20:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wmLDU-0001Of-O6
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 20:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784681623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ms+PcctC3n342gRzN0mT9Eceor/2hR0BO6Lviff0Eg4=;
 b=epgIc/yuiaKe8p4pM5gRn8/QlJlyLz+SyFTI1PVsZq7fAwHOlY0vBiliiMRWV0syrTsv+a
 I9Mp0sTOvCPAODLZjFbOtbgO7HlZfoBkwXA1mWUYk/vY0v68C6vYgB1Ay5EG/d+73i0sZf
 fVZPL9XZ+x6/SAt5d0lLQ8Q3KCScESA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-YR1lO8YrMR6tb0GfkPkyEA-1; Tue, 21 Jul 2026 20:53:39 -0400
X-MC-Unique: YR1lO8YrMR6tb0GfkPkyEA-1
X-Mimecast-MFC-AGG-ID: YR1lO8YrMR6tb0GfkPkyEA_1784681618
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cca3673560so206432485ad.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 17:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784681618; x=1785286418; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ms+PcctC3n342gRzN0mT9Eceor/2hR0BO6Lviff0Eg4=;
 b=nCw3m2YDIGBJs8GIjjK60NOkPxJ7JufEJmwci3eHLsxWD5qUYPp7yeb5R1eqGkarfd
 AsfbtdeLL/WN5WF/LiaeHbDmQO/4jk+AYLcDzDLXPGcUBYikpU/gdVmbMkm6fajiqkMd
 9e82gh940aKpMMKkg5+1Effa5yT9PUMQQFIqivlhovBUphE1xlaL8XROF5r70wk/3Jr1
 ZLAVnI7tBvUUDi4a4pYjRLNzcK1DQn+bL7LTHqXGEPkF/03P+0GqNjf95ooKHp/nApcl
 NQoFNIGsFHnmRafkWnRjcexFDPMrr00919B1klyWHzWq9Aiu45/fhlEv+86GaoqSaBtT
 ne0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784681618; x=1785286418;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ms+PcctC3n342gRzN0mT9Eceor/2hR0BO6Lviff0Eg4=;
 b=UPe1UUV4c0cXYwRVFQzP0yFwB3PUHlJeY/8LMOUOQmuXwbRsfTpiunBUJrmnDd+sRL
 k8FijQGA4PNzBUpgznaKcp4UfhLGiwBpDTTnUt4WL6QvdhsxClHVVvaKQE93WrQstsC9
 Kziw/TxO8hnlB8R7zvWPomTpuzUemN3PKYdZDCsvihgfg53dVALEdJTwxJ44ZR482pGQ
 ABHdUbKUY5Zcet9lI3W4qGuNgyXkzeSU2/T0HTc7kkGta5fSdBcOl7TvJQrKxTruzNNP
 4rmV4dUthurOyBAhIIzO8nNBRPkd077+xpNP4qzFHHAZ6Urwgu2zIuPN689jvsTXu/Cg
 i7EQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoH8J4ioHfmM0oGZ6QaesMt4fBcT1GDT5TDQs9TrdC9qPSWckY0jyOcwFGCzNvnmrN9EygaC+imgWww@nongnu.org
X-Gm-Message-State: AOJu0Yw4DLyQkK16aSveVoMIVtkkvjMXBcSV8pzwMSduE7kjEU9buyse
 UQFnsV4ey5Edc8ZEgZW5n9SMqXbTqzshtQ0d35Z/ZO9oBBdhxRob+SZkCcL2KDrJKJzHR0IffMC
 eQH6SF7vNrk/hHgL5UBS2hxbtBAgvGZAOt54bu/W+gy5Fos8WVRMNH5cr
X-Gm-Gg: AR+sD11Cs6LU9fDNq2jnqPinBFZ1f/3q9NCJyF8I2PsoCQ1Hn2v8vPNA4U/G2c8uCFR
 dl+Lfq6ZQ+wPUPHOw2a722TsutJ7mSAqTmdoyM7T61vkwpvrkncTW2a6Xud8pZfnoFz9mQ3wGG6
 T4q2BsDcjgfetCMITQG6nZ1exJgdN/2NxUwcF6+Tw24fmdMjoZKjqxc1pXNW7vDOp/gQevODyn7
 rFzSU1lNd27sJQiLc0fbdS7II4lEDWy5hh5wNLX92v+Krzu1FTK3iSh2k4kOJ2BRYXDRBmaQwXZ
 gmj6E3SXHtMfrinMCl+yUbBrZWZVkCKzr/zDqLcFgvetMfgR73Tpj2ypon7xH+TQN2saBfNqQEM
 N5JRJvvITbDyuZCPH8ZeWjGRKKteXEUKAQiTcJ3MhAO0=
X-Received: by 2002:a17:903:8d0:b0:2ca:d658:d874 with SMTP id
 d9443c01a7336-2cf34a0a6aamr227057845ad.23.1784681618365; 
 Tue, 21 Jul 2026 17:53:38 -0700 (PDT)
X-Received: by 2002:a17:903:8d0:b0:2ca:d658:d874 with SMTP id
 d9443c01a7336-2cf34a0a6aamr227057485ad.23.1784681617889; 
 Tue, 21 Jul 2026 17:53:37 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf8efdbfd0sm5074695ad.21.2026.07.21.17.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 17:53:37 -0700 (PDT)
Message-ID: <6210e178-a93f-4411-810a-41edb1fb656e@redhat.com>
Date: Wed, 22 Jul 2026 10:53:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex@shazbot.org, richard.henderson@linaro.org,
 berrange@redhat.com, philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com,
 qemu-s390x <qemu-s390x@nongnu.org>
References: <CAFEAcA8-Un+Q1yBDqLWCLPRwtgTA_VhJqGobgZChrFhAeVfG8A@mail.gmail.com>
 <20260625123119-mutt-send-email-mst@kernel.org>
 <CAFEAcA8UjtXgmPC27fOKMwbaWs2piwGYudtwCNWQHuu3E_7A-A@mail.gmail.com>
 <5faf04b9-d596-4a1d-9fe3-5e9ad5f0a99a@redhat.com>
 <73f79841-8cc7-4ca6-8f6b-fb97b53a6fe8@redhat.com>
 <20260717091756-mutt-send-email-mst@kernel.org>
 <CAFEAcA-O6Z4JrVV0DL_tta6khRyUta_Zz5mJt6OszaW1mu0o6Q@mail.gmail.com>
 <20260717095407-mutt-send-email-mst@kernel.org>
 <9c2ad22a-e768-4a07-85a2-01ce1fc14368@oss.qualcomm.com>
 <59882c5b-545d-4768-8bf4-723fed97a801@redhat.com> <al-eCtxGjG4HHEbl@x1.local>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <al-eCtxGjG4HHEbl@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=gshan@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 7/22/26 2:27 AM, Peter Xu wrote:
> On Tue, Jul 21, 2026 at 03:37:53PM +1000, Gavin Shan wrote:
>> If Peter is fine with two variants for x86 and non-x86 architectures.
>> I can post (v4) for further review. That will be something like below
>> and let me know if there are any other improvements are needed.
> 
> I have a generic question on the "unaligned access for x86": I think the
> question is about the one Michael raised here on unaligned access may break
> x86 here:
> 
>    https://lore.kernel.org/qemu-devel/20260617022330-mutt-send-email-mst@kernel.org/
> 
>    3. (theoretical concern) also on x86, unaligned accesses are
>    possible on guest and host, so converting an unaligned access to a
>    series of aligned ones can in theory break devices.
> 
> Is that a real problem we need to consider, or can we start with unified
> approach and leave it for later?
> 

I'm leaving this question to Michael.

> PS: I apologize if I missed important piece of info along the way; I didn't
> follow closely on the discussion on this topic in the past few weeks.
> 
> One thing to mention is, what we change should only need to affect
> ram_device, AFAIU.. so most memcpy()/memmove() shouldn't be changed for any
> arch when it's pure RAM.
> 

It depends. This patch intends to fix issue [1] in the lower layer by using
the newly added accessors (qemu_ram_{copy, move}) on all directly accessible
regions including the regular (pure) RAM region. Otherwise, the newly added
accessors should be limited to ram_device regions only as you said.

[1] https://lore.kernel.org/qemu-devel/20260527091711.3901-1-liugang24219@sangfor.com.cn/

Thanks,
Gavin


