Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F06C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 11:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtkHS-0005ia-Dx; Tue, 11 Aug 2026 07:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wtkHH-0005gz-0e
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 07:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wtkHF-0001Gi-GC
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 07:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786446250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+FkPEdueLwHWFyrKrhKgCEWI0VHQD9Y7/FLtdLDcRU=;
 b=eEbxYO6IhE8UeYYsoEK4SKaL1Fc0c2GY4Zog/cwqeeyu5s6TTLYa4tREut9FRNUASVdUD3
 gVuStdHFr5trG7AGmq3if19H22/BIFsWnNgYT7NrqOj5Le0d1yS87k1dGXsayU9Ga15bqg
 NrUcjwLbAf9d2esl8GizqFhw3wrjIsE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-TUeNG3vFOVuJyMffmuGgTQ-1; Tue, 11 Aug 2026 07:04:09 -0400
X-MC-Unique: TUeNG3vFOVuJyMffmuGgTQ-1
X-Mimecast-MFC-AGG-ID: TUeNG3vFOVuJyMffmuGgTQ_1786446248
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48000d75326so1826454f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786446248; x=1787051048; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x+FkPEdueLwHWFyrKrhKgCEWI0VHQD9Y7/FLtdLDcRU=;
 b=YDDWPXpBdazW2gnO2PVYYyznwqEidP4LNeuSztnqTceXkKXz0XksU8RVdxfCMeuXNU
 v0apzPYq6kVQn/QnMGBDfaLL6dzCjA5NSFjaIfLypR7WgMfEPwPMxoK9NFTQDULGLeEr
 mQSDtuYJOdQtASCtZVJXnvHmA86JvLrivQOzlojM2FKfJlyYDII1eEkc8n9jEOsD1Poe
 Nxh6Aje4kCSCIxr06RjvTk2OxxJgewpMTZu4ElU2sMuJv0knZzEsQpOpP/7layQ5J7bt
 tfmmhomIm4zt3A575aJayNn9/MxRCXiWY/xHFRtvViJkZWudLzs557uRhOoGNWzyY/wu
 sezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786446248; x=1787051048;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x+FkPEdueLwHWFyrKrhKgCEWI0VHQD9Y7/FLtdLDcRU=;
 b=Z/xiXAu9p0yzugRHt17IvIQ5vOdTuEW3s1MusmiUuDmwl+efFdFHJcOIVSl6DvGv1t
 u3x9PGusWPGfdDldthqX+EsMBEt+NQk1OcwsbUzrtS1ROh3IvuWsZFt9c3XR9lZPcLe/
 y0EGeGI5gUyZwXEQ2ht6PcZBtVH1QrdhxqeDft79VJTiJuwLUUz74SNsTn7kOHCRFJM1
 af8oJEpYqbnJrVP55SI3515kEubh1evPkq2ztB0CuQImHyVvS0UinsaKVaAr1Jwt7SBu
 EwPpo/V7VrkGkUJZJiCOFbpVA7oWX/s31jmamOZ3IQMuCMZR2Wv+lqUlFtO59tldfZUP
 aA7Q==
X-Gm-Message-State: AOJu0YxQHLA/WiCYZefvhP/lo02fRNmqa3YP3I84YyWHUvCyJmNe6Ftc
 9q3WL/qjdfF2NMgConafVAnIA0B3qiwIT9o9Nk3+x5+jsJQi9bEbS3TnL8v0eJh935hxH02lT4c
 N5VwTnFAqRx3ads34IDau5A8W3LIGSUGD3rSZFBWzlyy5D9kWzMGejBjz
X-Gm-Gg: AR+sD10WtvKI3ZZuVc1FXnlaWofjFJlF84H1n3tyjwyL76VUGFPGYPlOX5gXuTTr0/y
 ABWSUxxy2325cZ3HuYSfruNALN7uWptYhbzLWC4vGxga8OoyNKkpKeiE+uP+xNQBBF5VWkjeLAz
 mtqzPBC1W2y5o+3FdLVO3USn5YbzEzoFo7BpUt4hBuKlr+mqVFUzZ6XIGfAKbraIX1suCJhhkXG
 uzDoKaE6w2EYsU3qtCg4O3VDz4PeTj/0wCnH2ZQvEHMl594R5ZqsUKTvv9FZyHBRVlB6Z+BouGo
 C0w7YrQgFeG7exdiodMWWwcLPLVaePyzBbOmrgSC8OjWIvY4DvbJovH10WWR1GFa9VseN055TOp
 nMIYm85MWaul+ZLbS8sHlrFXsQ5x4AirdUoDoZwEb7UN9xJe97WLodjVddpbLCQP+DYeqfah7yL
 XO34kSYazV08zWiuxKQNKvrf9tQdtncA==
X-Received: by 2002:a05:6000:18ab:b0:481:45ed:cb50 with SMTP id
 ffacd0b85a97d-4814adc2590mr4032324f8f.16.1786446247859; 
 Tue, 11 Aug 2026 04:04:07 -0700 (PDT)
X-Received: by 2002:a05:6000:18ab:b0:481:45ed:cb50 with SMTP id
 ffacd0b85a97d-4814adc2590mr4032229f8f.16.1786446247445; 
 Tue, 11 Aug 2026 04:04:07 -0700 (PDT)
Received: from ?IPV6:2003:cf:d706:f1cb:272a:2c7d:bb01:94e8?
 (p200300cfd706f1cb272a2c7dbb0194e8.dip0.t-ipconnect.de.
 [2003:cf:d706:f1cb:272a:2c7d:bb01:94e8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a5ac6cfsm3224864f8f.4.2026.08.11.04.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 04:04:06 -0700 (PDT)
Message-ID: <1355454f-0dfb-463a-86d8-a09ef6204dea@redhat.com>
Date: Tue, 11 Aug 2026 13:04:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/15] hw/virtio/vhost-shadow-virtqueue: range
 boundary in translation
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 Demi Marie Obenour <demiobenour@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-10-6b97c439eb28@gmail.com>
 <ba6158dd-7b7b-4457-9256-497ab60a27d3@redhat.com>
 <CA+spn3qP1xahLRTNutmOLvDEXJXHh9W1tMeGeKiiDiz-ntyknw@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CA+spn3qP1xahLRTNutmOLvDEXJXHh9W1tMeGeKiiDiz-ntyknw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08.08.26 07:52, Connor Kite wrote:
> On Mon, Aug 3, 2026 at 5:56 AM Hanna Czenczek <hreitz@redhat.com> wrote:
>>
>> It’s not immediately obvious what is ensuring that `iov_len` can never
>> be 0. Sure, it would be wrong and makes no sense, but that is why I
>> think an `assert(iovec[i].iov_len > 0)` would be appropriate.
>>
>> (Looks like `virtqueue_map_desc()` is what rejects zero length, but that
>> is not really local to this code path, so not immediately obvious.)
>>
>> Hanna
>>
>  From the QEMU Coding Style guidelines on error-handling it looks like
> errors that
> could be initiated by a malfunctioning guest should not cause Qemu to
> exit. Would it be
> more appropriate to return false when zero-length is detected?  That follows
> the existing error path returning up to vhost_handle_guest_kick, which
> renders the svq
> unresponsive to future kicks.

Sure, but it’s necessary only *if* a malfunctioning guest could cause 
this. As I said, it looks like `virtqueue_map_desc()` already rejects 
zero-length descriptors, so an assert should be sufficient.

Then again, if you can handle it benignly either way (without an 
assert), that’s always a good option.

Hanna


