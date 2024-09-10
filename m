Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98265EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 13:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so0oq-0003oK-E2; Tue, 10 Sep 2024 09:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1so0oo-0003lY-P3
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 09:22:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1so0om-0001gq-Mp
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 09:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725974519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLeKU8WrvV1e4cNBtpuLsG6oHufEB5R3O2TqQlVJyWA=;
 b=LPqBhE9wN3ROQe7qKRKZjVQcP5MvtJco3kZim8Dj3FS35XRVDtGQEMXQDdM2GTPJLlkxcQ
 dMeoK5WMW/Imy9Y9U79d/glunEnoHkGHlyt9UEccBzKBrh9B4TNcptqW84HVv/gUvP6vTM
 kHnU5Wjlt2iqVVClAuDSCn39Z0vLpMk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-hDCUPknvMfm1RcIR5LC8gg-1; Tue, 10 Sep 2024 09:21:58 -0400
X-MC-Unique: hDCUPknvMfm1RcIR5LC8gg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3780c8d689bso2688982f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 06:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725974517; x=1726579317;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PLeKU8WrvV1e4cNBtpuLsG6oHufEB5R3O2TqQlVJyWA=;
 b=gmO/RPtrdJWnh9jHf/7kduS8iYl+O4E0vojAjAL84qa/DiaxzCyXfVGyClwUEvZgDY
 GTbpOfxRqlqnLSrxrUEflWsn9StY3MkhOpjiyuKSzhQZdCeiJtc0UPmxulnOYxGUW3+9
 oCfdQaaTAJgbW64PQ7q/6om+PokL4i783Xo+tAY7DaIM6AlaeRYUUVc8B/mzLrZipZJj
 4BlUHCcISFH6n8rHRBXxA0IlzEvWVXTTNrQWHSRRM1Jf7VIw3/DQYVndU1zDbVge3/Hq
 pui5LYEm+nfFUhU5zD8qUfwny2z0Mbt8Kupzv/kjmEzXJw1koK8/FWcwKiDWgIElIaah
 +2wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW66NF6w+JjUEVv/nkon5Uf9D7P0CVY4J7WzW7gpkn2Lb1ajDqU5ClOYRV6jIcChWT5WiT91zuRFY28@nongnu.org
X-Gm-Message-State: AOJu0YyhBs7jA1/I0aKWETEi2LQkj4W3JLBueiWygDkmLm4y37squhhm
 yaPoFW8dzUAyGLU5adKJNIjbOi1TkJczDxskRgf/sCBGPC5gyt/FNci30daaVZJsG9r1yxz1Egs
 rzC8NUhTERBjUUdXJjqRck4azh0joTMGK8VRbWalT6xWiQIn02OpH
X-Received: by 2002:adf:f0c1:0:b0:371:8763:763c with SMTP id
 ffacd0b85a97d-3788960ed0fmr8778915f8f.33.1725974516813; 
 Tue, 10 Sep 2024 06:21:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5bpEhkoraAg9ht4O+7kty9OYBuLCAU22xp2y0nhAks3tAzW4CrDfF8KJJiw2p0C7XKi+LyQ==
X-Received: by 2002:adf:f0c1:0:b0:371:8763:763c with SMTP id
 ffacd0b85a97d-3788960ed0fmr8778877f8f.33.1725974516210; 
 Tue, 10 Sep 2024 06:21:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956dbf42sm8886797f8f.102.2024.09.10.06.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 06:21:55 -0700 (PDT)
Message-ID: <4adc32d0-02c1-4375-8618-2692a9b1da76@redhat.com>
Date: Tue, 10 Sep 2024 15:21:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v15 00/11] hw/pci: SR-IOV related fixes and
 improvements
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
 <20240910052046-mutt-send-email-mst@kernel.org>
 <08975798-2484-4aac-a032-5ab8a6475bde@daynix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <08975798-2484-4aac-a032-5ab8a6475bde@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/10/24 11:33, Akihiko Odaki wrote:
> On 2024/09/10 18:21, Michael S. Tsirkin wrote:
>> On Fri, Aug 23, 2024 at 02:00:37PM +0900, Akihiko Odaki wrote:
>>> Supersedes: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
>>> ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
>>>
>>> I submitted a RFC series[1] to add support for SR-IOV emulation to
>>> virtio-net-pci. During the development of the series, I fixed some
>>> trivial bugs and made improvements that I think are independently
>>> useful. This series extracts those fixes and improvements from the RFC
>>> series.
>>>
>>> [1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>> I don't think Cédric's issues have been addressed, am I wrong?
>> Cédric, what is your take?
> 
> I put the URI to Cédric's report here:
> https://lore.kernel.org/r/75cbc7d9-b48e-4235-85cf-49dacf3c7483@redhat.com
> 
> This issue was dealt with patch "s390x/pci: Check for multifunction after device realization". I found that s390x on QEMU does not support multifunction and SR-IOV devices accidentally circumvent this restriction, which means igb was never supposed to work with s390x. The patch prevents adding SR-IOV devices to s390x to ensure the restriction is properly enforced.

yes, indeed and it seems to fix :

   6069bcdeacee ("s390x/pci: Move some hotplug checks to the pre_plug handler")

I will update patch 4.


Thanks,

C.


That said, the igb device worked perfectly fine under the s390x machine.


