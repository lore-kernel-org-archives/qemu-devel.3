Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7268ED5B17D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 15:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVAF7-0002Xi-Up; Mon, 15 Dec 2025 10:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vVAEt-0002WS-9W
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 10:11:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vVAEr-0005xI-F7
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 10:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765811512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OgEheyzVjzwXpcNLleCe7PGQL+jLAHUpHaEbWmDug2o=;
 b=EgFbv5KhmyvUjjBca8vAu/wailQ6VN/vYatvHu2zZR3FRwucwgMlbgTZpgEkRP88jHO+xW
 hGuEDAY2jM+e9w1C9fUTWyrGZ/kbCopQgNI2SpOaDkJURPz4h6R5gmNzzIbYzPrvADpOTt
 jKlAgX3/d640rEIp3YkEGX0SzE5Bktk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-nFmRm7QmMgmGlJz0CtS5Mg-1; Mon, 15 Dec 2025 10:11:50 -0500
X-MC-Unique: nFmRm7QmMgmGlJz0CtS5Mg-1
X-Mimecast-MFC-AGG-ID: nFmRm7QmMgmGlJz0CtS5Mg_1765811510
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430f79b8d4dso794833f8f.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 07:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765811509; x=1766416309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=OgEheyzVjzwXpcNLleCe7PGQL+jLAHUpHaEbWmDug2o=;
 b=qJPKTHUew3suhYFhFyuMjYLgTCfuppRtJHzweksS9PBG9VURedJipqYw0EiTB0cRGc
 /5pzNQKCRf9DBpyMSobA7VQKPz3HO3/QFOvbVKJVg2RAklbwL8uFvSzsl3ApVS9yrnnM
 lcqq0SeefMq27aJ26T5n44bE+AkpK8DNRw7QU+YrNCcyc7vCpXq/0NfhYTH16grotWw1
 7sxGZu+NWxU1/sr31mZngfmsaJ3LFfQ1GfDIZSHzBwoMIEMtIZUcgYqZWBUYDwoGSMRU
 tbdcEQirY+YQjUingfnD9/NNLlAXEt92xiGPf6NUAGs+rK96FjzComIhvTtp0XDwNF7L
 ReAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765811509; x=1766416309;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OgEheyzVjzwXpcNLleCe7PGQL+jLAHUpHaEbWmDug2o=;
 b=oe+9gjRRmHPEKDUmMYDxPSGn81lorBxPF8PXgooYvNso8k6R5naQrOfPUxJVI8chco
 i+hw3xjeBcg/NncPRqRp/D7BkkUUO6aIIkZttQPpY4t51pR7DFPBExS4bKzIQFLHEaOT
 AdsQ8ck+Um1m/Zu2MljptAdp9RGPsuAChLGW3KvYJF8uwsfaH5hswZwYOLCP5wRKeHEt
 LOBcPZk/cBNroJd39bPDAzEtFuajPVCd7xwHBEigp5v+jCfIQ901AEZGVSkmxulVItMD
 J9JnGibrbNvbsJV53buz19yBtOGWmKLjlOuMxRGoJySbGvLKq9E3aYEjTCPxP7CTGIud
 r7zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+P3IPsIFtj3qUv6ZdZ5Or40b3ukcNdx5eXq3CBPFIjDV3uEfF8H7RQAwA6dwKqBGPr7YQn7bTROf9@nongnu.org
X-Gm-Message-State: AOJu0YxO/TVz9nlvUmdwm55oQmFjjarhK/hMm8UyfQa3eNRUyMuY+5VE
 inTQl2bVLrk6O8SdbBnjW5iPxXgHjlC+998OxYB+8YwbF2PSKg8K/jazCeTkwEHBmMWrYePDmFM
 lbo2cUkkj/iejMx4fkUC/1ZUGU7sBfcvwnmIGbKG2RVZhg1iUjwfzakF3
X-Gm-Gg: AY/fxX6H5aIVAKY5MK00d1D0mu7+VRxeGDtsiJmO6R1qzfaXq4RR3ftC5fbGpNTkbF3
 7cvIoD831RPj+vMpMEQyhc4yaZu+0NJUw98S4dmHcXKWMvDu2rvRCyf+A6ckJrPOHWbc/HzojKq
 q/9bcXAqTA+4iCJtUz59hDSi9XRs7n81kO5OsCW1RAuSpsO0C45dY2q9/viOTrPSMrfsmG5DY+e
 OIcFnNSjEDjPZP/lybIqDkW7pvgC/auwnpa6pNh+NrGd0QrX8iR5Frs488BMvm1eRoePZTnxUW/
 uwkMrp5zfjkgNUagNil6iYsN0thqeQaE+5GEm02g4hXx97N3Z/Grh9TDic+uvgy8eNCI3U2UsZ/
 506F/z6V3LKUVaRoMMpdxUFm4mW9I6GMTrmp27AFd/tW9
X-Received: by 2002:a05:6000:178b:b0:430:f40f:61ba with SMTP id
 ffacd0b85a97d-430f40f6414mr7068190f8f.41.1765811509524; 
 Mon, 15 Dec 2025 07:11:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhNiMrjDE+FvIc9DZiHRtLTs9NmgcO7v0ewdZEwdujBzafkb6Z0WWzh8jBERchZziqZIqcuQ==
X-Received: by 2002:a05:6000:178b:b0:430:f40f:61ba with SMTP id
 ffacd0b85a97d-430f40f6414mr7068143f8f.41.1765811508927; 
 Mon, 15 Dec 2025 07:11:48 -0800 (PST)
Received: from [192.168.0.5] (ip-109-41-115-194.web.vodafone.de.
 [109.41.115.194]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430f6c20781sm11952350f8f.24.2025.12.15.07.11.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 07:11:48 -0800 (PST)
Message-ID: <e62e8105-7add-45ed-afc2-9d6b1403b135@redhat.com>
Date: Mon, 15 Dec 2025 16:11:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Fix a possible crash when halting a guest
 during migration
To: Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake
 <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251208135101.271417-1-thuth@redhat.com>
 <20251208144525.GA1341938@fedora> <87jyyxkna0.fsf@suse.de>
 <5b510f3b-796a-45fb-a63f-e87b02dace61@redhat.com> <87jyyrv1br.fsf@suse.de>
 <aUAQNaA_sW8hxW2Y@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <aUAQNaA_sW8hxW2Y@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15/12/2025 14.42, Kevin Wolf wrote:
> Am 12.12.2025 um 22:26 hat Fabiano Rosas geschrieben:
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 08/12/2025 16.26, Fabiano Rosas wrote:
>>>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>>>
>>>>> On Mon, Dec 08, 2025 at 02:51:01PM +0100, Thomas Huth wrote:
>>>>>> From: Thomas Huth <thuth@redhat.com>
>>>>>>
>>>>>> When shutting down a guest that is currently in progress of being
>>>>>> migrated, there is a chance that QEMU might crash during bdrv_delete().
>>>>>> The backtrace looks like this:
>>>>>>
>>>>>>    Thread 74 "mig/src/main" received signal SIGSEGV, Segmentation fault.
>>>>>>
>>>>>>    [Switching to Thread 0x3f7de7fc8c0 (LWP 2161436)]
>>>>>>    0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
>>>>>>    5560	        QTAILQ_REMOVE(&graph_bdrv_states, bs, node_list);
>>>>>>    (gdb) bt
>>>>>>    #0  0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
>>>>>>    #1  bdrv_unref (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:7170
>>>>>>    Backtrace stopped: Cannot access memory at address 0x3f7de7f83e0
>>>>>>
>>>>
>>>> How does the migration thread reaches here? Is this from
>>>> migration_block_inactivate()?
>>>
>>> Unfortunately, gdb was not very helpful here (claiming that it cannot access
>>> the memory and stack anymore), so I had to do some printf debugging. This is
>>> what seems to happen:
>>>
>>> Main thread: qemu_cleanup() calls  migration_shutdown() -->
>>> migration_cancel() which signals the migration thread to cancel the migration.
>>>
>>> Migration thread: migration_thread() got kicked out the loop and calls
>>> migration_iteration_finish(), which tries to get the BQL via bql_lock() but
>>> that is currently held by another thread, so the migration thread is blocked
>>> here.
>>>
>>> Main thread: qemu_cleanup() advances to bdrv_close_all() that uses
>>> blockdev_close_all_bdrv_states() to unref all BDS. The BDS with the name
>>> 'libvirt-1-storage' gets deleted via bdrv_delete() that way.
>>>
>>
>> Has qmp_blockdev_del() ever been called to remove the BDS from the
>> monitor_bdrv_states list? Otherwise your debugging seems to indicate
>> blockdev_close_all_bdrv_states() is dropping the last reference to bs,
>> but it's still accessible from bdrv_next() via
>> bdrv_next_monitor_owned().
> 
> The reference that blockdev_close_all_bdrv_states() drops is the monitor
> reference. So is this the right fix (completely untested, but matches
> what qmp_blockdev_del() does)?
> 
> Kevin
> 
> diff --git a/blockdev.c b/blockdev.c
> index dbd1d4d3e80..6e86c6262f9 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -686,6 +686,7 @@ void blockdev_close_all_bdrv_states(void)
> 
>       GLOBAL_STATE_CODE();
>       QTAILQ_FOREACH_SAFE(bs, &monitor_bdrv_states, monitor_list, next_bs) {
> +        QTAILQ_REMOVE(&monitor_bdrv_states, bs, monitor_list);
>           bdrv_unref(bs);
>       }
>   }

Thanks a lot, Kevin! This looks like the right fix for me - I gave it a try 
and it fixes the crash indeed!

I also threw it into the CI and there weren't any regressions:

  https://gitlab.com/thuth/qemu/-/pipelines/2215426210
  https://app.travis-ci.com/github/huth/qemu/builds/277063452

Could you please send it as a proper patch?

  Thanks,
   Thomas


