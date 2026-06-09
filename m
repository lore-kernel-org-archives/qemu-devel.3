Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6F4CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWprB-0005GS-46; Tue, 09 Jun 2026 02:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wWpr6-0005GH-EU
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 02:22:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wWpr4-00043o-UR
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 02:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780986149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8LuQehIcg/MZhpGZIY3NZOC2EAieoCwUV3mZFeAzcog=;
 b=dg0eI3ntKumCQGHiwktikHJv5ExfRqZU3ZGIm0+lX/ftJNGB7ISbfpZh/HN6csMe2DpvSH
 xIRkKSHrihdp8LO0clmQsRx5WnG6yQjsQt7HvBcdcrhx1Ij+eJ9Iwfhd6UtTNpVfTTHKe8
 C/l3GzRNMBxDVZzy9QzjzeG+HvAcYqs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-Qy5zDDEiOsqziJBs1ynZig-1; Tue, 09 Jun 2026 02:22:27 -0400
X-MC-Unique: Qy5zDDEiOsqziJBs1ynZig-1
X-Mimecast-MFC-AGG-ID: Qy5zDDEiOsqziJBs1ynZig_1780986146
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45ef2bd566bso2757318f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 23:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780986146; x=1781590946; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8LuQehIcg/MZhpGZIY3NZOC2EAieoCwUV3mZFeAzcog=;
 b=gdiBmqHK9oXXajYU1cQQlVzD9yt3UAn4d1zK3fYeCmqsRv6AuEAUj/2urZUvZbvD49
 3bIH8Zzt4qv/fNxx98euNGB2g1YfEbie3q4GBMVrijcZ68c7c28d2gzMeJT5ZoCKebj6
 xqHq2GULyiOBbzqPJ2rO5sdhUcFPMbt0rBEoFMV936EFxuOFSLzsD2qGdz2vyNsN5j6y
 XGsZh9lztQQzFWjRUiyyjCbSx15pJf1I+IbGpJZ84URZJnyztTOwrpBqGuDNPkRTFpOk
 UehXNkoEEkNRdbZhugihXuKlvlN63kpI4xJwZlMgPdNbTXZ2sZtR6TtLPZFcwQ2AZaCd
 ziGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780986146; x=1781590946;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8LuQehIcg/MZhpGZIY3NZOC2EAieoCwUV3mZFeAzcog=;
 b=R5ySRX9Kql4vUZDEClTYJktlSLXdBwhylvFCg31dU6kpnPPTYnO30liCxF37lGpmD6
 lfhfPIl3M7jx/7uP04nUWzl2/v4wt//PY7VUM80Wcz4y4yNsDXvY8JCMhRIk6vudejmh
 Ser7gsUviD8ulp+qel4mNFvblCVXm6xgDVD+FH7T3w8apNUSBfG/YLkhng9/05jXYja2
 X2++YME+T4o6jmVwr+lvGatiI2OZnWH3nzUQ6RuW/K4j18FS7H0BhqKWyE88AmmL3xVP
 CN6qLMlV3zUvew/S397FtIKFuYj0+DZk5uOfkvaFKVrxXnRTiCFrb2pu23g5cL47cUef
 +oig==
X-Forwarded-Encrypted: i=1;
 AFNElJ8W9mvPNc9JGXzTRPuCwmTDsbJ5VZH9MDFsG2VSg11/sRvWTK9g1v7Px1QMpJ1I1RfP3Os7AJXW4xWM@nongnu.org
X-Gm-Message-State: AOJu0Yzo6y1NFv1IYs0EF8ZP0Al3j0eBUIHDUoSzL2r1Yr5aTTdkxtYn
 TxqZOnbkdZafxe6YRhXNRp33Zi91pc31vGEtxiCU/qXbExmWeELZsog4allvjQVE6lmBM3rug2F
 KHTxhRaa+oitl6wj3JdkYy4HO/vPPCFljOfotWt4L6fhxPfO/Ytv9W92mb2Z68S9N
X-Gm-Gg: Acq92OFSnRnGOZyzPcHuNiLEA4fjcM1oikn7+v7nlHCEzU8AMQjln9CBGS6ZxpKZP35
 1dNEAOjP5oWiztFFdR4heQJEyWcFJ1ou19vyF+3jZ/AjXBM7pbL+azBgaWuUoD9bIFGrqm1I5nT
 dWhF0IX++EBJEHcXR1sk4OOfPMSeuHINT1ljaSlWjhmILXOG1ePs38BEtQkNN/4XHl/a8DCZKP+
 vTzKqg5bJjqowe9usrOQUmhRy/3dI1TR1hJ7gxcxbhxynnY/oG8MH02DaSkBBzDJ1y8XGc4bRPc
 vhRWS8QcrGIDlCgd27d5v32DZRqdNforoK7t6jRGrvzFjF9X1pDOewhcDc+uwUaSfeZVszqSpxs
 jbg7T106zQL+n2ctZ8XSqlPFWmqPW2Q==
X-Received: by 2002:a05:6000:2182:b0:45e:a225:6dfe with SMTP id
 ffacd0b85a97d-4603061c65dmr19648515f8f.25.1780986146151; 
 Mon, 08 Jun 2026 23:22:26 -0700 (PDT)
X-Received: by 2002:a05:6000:2182:b0:45e:a225:6dfe with SMTP id
 ffacd0b85a97d-4603061c65dmr19648482f8f.25.1780986145818; 
 Mon, 08 Jun 2026 23:22:25 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.132])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2eadefsm60579144f8f.11.2026.06.08.23.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 23:22:25 -0700 (PDT)
Message-ID: <9404eb90-9e83-4bd7-b061-6d1f700365cd@redhat.com>
Date: Tue, 9 Jun 2026 08:22:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: artifact download for qtest
To: Ani Sinha <anisinha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <CAK3XEhMNqHbkL2P6Xg3_hJ8WAxhPQgurjvuZg-vXUDZ5=x-RRA@mail.gmail.com>
 <f2516211-6fbc-4714-b674-4276464f94ff@redhat.com>
 <CAK3XEhPdaVqi9nECrJrcRaCKK0bVcRXw=t6hXM=EVwbxpu5wLA@mail.gmail.com>
 <CAK3XEhM3K1r3Q7zpqvQkLtuMEeXkb+nwDwN-j_+B0fwZpHhgkg@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAK3XEhM3K1r3Q7zpqvQkLtuMEeXkb+nwDwN-j_+B0fwZpHhgkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 09/06/2026 05.46, Ani Sinha wrote:
> On Tue, Jun 9, 2026 at 7:54 AM Ani Sinha <anisinha@redhat.com> wrote:
>>
>> On Mon, Jun 8, 2026 at 10:43 PM Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> On 30/05/2026 16.56, Ani Sinha wrote:
>>>> Hi,
>>>>
>>>> I am trying to write a qtest for which I need an IGVM file. I have the
>>>> file, about 54 MiB in size.
>>>
>>> 54 MiB is quite big,
>>
>> I was able to reduce the combined size of 2 files to about 400K
>> https://gitlab.com/anisinha/qemu/-/commit/6aef476b59443dd1bc570c29e8e5ca43140cfed4
> 
> Compressed size is about 100K but I don't want to introduce dependency
> on libarchive preferrably if 400K size is ok.

We already have logic for libbzip2 in our main meson.build file, so maybe 
you could use that?

  Thomas


