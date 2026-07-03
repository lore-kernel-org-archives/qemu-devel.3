Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62B7C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfcgx-00028I-Ai; Fri, 03 Jul 2026 08:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wfcgo-00027t-SZ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wfcgl-0000Ay-TQ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783080490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fmrfsvzbIDRaI6xa2GV6XP0StcNn3klH0jg0iaT217o=;
 b=GOsUr6D9PDfF3rB2REmSTBVFyoHGMLo4hGSjtLtZ+9IL/WYC0GBPD3HtXFkOPDvz16zdV1
 /6dlB2JsZm8ynDLKtJOySIzp2ewEs+E0BMyWspUlmh3JtqYfN/q7qRGuYVZYhSRVWduH/X
 4ZhdIluvcdkVDOx2vJSPVkFM/2kXPwc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-g_ulbimROWqfCD222r771g-1; Fri, 03 Jul 2026 08:08:08 -0400
X-MC-Unique: g_ulbimROWqfCD222r771g-1
X-Mimecast-MFC-AGG-ID: g_ulbimROWqfCD222r771g_1783080488
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493bb6a4336so4541825e9.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783080488; x=1783685288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fmrfsvzbIDRaI6xa2GV6XP0StcNn3klH0jg0iaT217o=;
 b=X8mPTN2Z6LQlhEqRzP3kpaARMrdU7uOPbtL05mbI+Wiye5PUp5XHsuhsY6yjBjucV/
 O0i9/zTD7c9QNpdJmJvc6FrRYPBOD5TgQ+4JwSIbJU1yU1GeK/PZetj7T6YvzZvdPl6Q
 I2jy8poWnO3EKq/u1nac65gbhYrFSLL6n4s8h3T746FoCOUKUJYaTgOd2EpqIp/aQYHq
 4DXRKgsEgT6W7+Q7q3QCE4Y7GFgbWgJg7CotDAxjHQoZxkhoQ24i1CO9GkbsUwfFBJo2
 qPhoLYG2h07isZq0+Uu3Ftx7WJM5bW2Yu3vgkFioVcgVcxi5QQfqQsQPgYRYpmlqJOsm
 92jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783080488; x=1783685288;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmrfsvzbIDRaI6xa2GV6XP0StcNn3klH0jg0iaT217o=;
 b=K6W2U7Xy15V7FcrQ4qWhm3fDwde4yWdW0qFHmVtt3Wx/71pipQscjx5QE3V0bEuS3R
 zNN+2sctG3hnPi/81QM+T4gZm0nqZzG95tKyu59Vjcp8hrXbLHO30FZFSUwFr5OqLDZw
 nJMt3pwWFFWwH2e9IYM+5SIp1jaJHtMJvfbhHZQWvv0O/H+2pQxci9MHTydaLJ25wpdw
 tRyQvlWC+yjjGq+ZvBc0PYqhPFVDnDZFWFerwFPK06GrHQGJoRjJMZPtgckHmcey7yUk
 Si/RLert+/HVAdXw0MF/sb9wXbAUmPdsLTbKXYtRICxX09acci9Sw3xfyLLZQovzyk6n
 hscA==
X-Gm-Message-State: AOJu0Yxas3s9FHh+tumpY4a9ZU5UbnsKvh1vSOdsrLP37ep09ue/k2ub
 0x0CqvptJx4GBBX+k5TpqEBtsn/ZJXzv2zJezbtv/SyXOk1RwFnjv92Cfqt22WeRjCDl6xOr0iR
 yuxoidrfTHUGNXnEcXHyCCOGpdJldViLQ6aMB8hNE6zw7dxFFzpbNHWCs
X-Gm-Gg: AfdE7cnkb6mLFwe6FLqzAK5pbAMzGWl+wzU0GJ4vzlOItus0K/Zj5UmLFZ5TosK1uoh
 SkiLI+PxvjMwNmERhi8sg4kVZbyU74PD1jFVtt6/F6iB/XubSlpElLNtvfkVMmddD4VRSEA3QlR
 cjLRS0yElWlO1VH28TmB+R+VzkCEQkOlIXxEPgU1pRGbxI/b5JaLFuHPlblorZ1gHwr967U8HsH
 fhd+QZDzOAOXcauLJSZNcJc4GLnx4YQInSDuK/71UixCjDjiaCWP/Y2154ztauJP03i0paTzjjE
 xFDtXufR6pzm7UPjGhjYL8wpOAikyBU9e79OXqBW8NQ9pJKRyAfL9UskjQin0U9mR2n9NbLDmLp
 RwQCDUTABJVvIXB3l4I+Jt3FZKlPsp4xxS6dkaJN5ZAmWReYrag==
X-Received: by 2002:a05:600c:1550:b0:493:c389:d434 with SMTP id
 5b1f17b1804b1-493c389d4c0mr129164425e9.15.1783080487614; 
 Fri, 03 Jul 2026 05:08:07 -0700 (PDT)
X-Received: by 2002:a05:600c:1550:b0:493:c389:d434 with SMTP id
 5b1f17b1804b1-493c389d4c0mr129163985e9.15.1783080487126; 
 Fri, 03 Jul 2026 05:08:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63172fesm221287235e9.0.2026.07.03.05.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 05:08:06 -0700 (PDT)
Message-ID: <6622b05c-115b-4047-8865-c18cc99db959@redhat.com>
Date: Fri, 3 Jul 2026 14:08:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 1/8] tests/functional: Add remote interrupts
 test for PowerNV
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org,
 Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>
References: <20260703085955.2318600-1-adityag@linux.ibm.com>
 <20260703085955.2318600-2-adityag@linux.ibm.com>
 <b1d16c72-3485-4cad-ae51-5db4a78e3a48@redhat.com>
 <akeMqNUv2UlN80cV@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <akeMqNUv2UlN80cV@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/3/26 12:21, Aditya Gupta wrote:
> Hello Cédric,
> 
> On 26/07/03 11:17AM, Cédric Le Goater wrote:
>> On 7/3/26 10:59, Aditya Gupta wrote:
>>> <...snip...>
>>> +    def test_linux_remote_interrupts(self):
>>> +        self.require_accelerator("tcg")
>>> +        self.set_machine('powernv')
>>> +
>>> +        # Have below setup in this test:
>>> +        # 1. e1000e attached to pcie.6, which is from 7th PHB, belonging to 2nd
>>> +        #    socket (chip 1), in a powernv boot with default 6 PHBs per socket
>>> +        # 2. CPU on 2nd socket (chip 1) disabled
>>> +        # 3. RX IRQ's affinity to chip 2, and TX IRQ's affinity to chip 3
>>> +        #
>>> +        # Then ping is done, to generate interrupts from e1000e which should go
>>> +        # to IRQ server on the remote sockets
>>> +        self.vm.add_args('-smp', '4,sockets=4,cores=1,threads=1')
>>> +        self.vm.add_args('-netdev', 'user,id=net0')
>>> +        self.vm.add_args('-device', 'e1000e,netdev=net0,bus=pcie.6')
>>
>>
>> 2 sockets are enough.
>>
>>      # grep -E  "eth0|nvme" /proc/interrupts
>>       76:         12          0  PNV-PCI-MSI 268959744 Edge      nvme0q0
>>       77:         62          0  PNV-PCI-MSI 268959745 Edge      nvme0q1
>>       78:          0         67  PNV-PCI-MSI 268959746 Edge      nvme0q2
>>       79:          0         34  PNV-PCI-MSI 2416443392 Edge      eth0-rx-0
>>       80:          0         20  PNV-PCI-MSI 2416443393 Edge      eth0-tx-0
>>       81:          0          4  PNV-PCI-MSI 2416443394 Edge      eth0
>>      # echo 0 > /sys/devices/system/cpu/cpu1/online
>>      # grep -E  "eth0|nvme" /proc/interrupts
>>       76:         12  PNV-PCI-MSI 268959744 Edge      nvme0q0
>>       77:         62  PNV-PCI-MSI 268959745 Edge      nvme0q1
>>       78:          0  PNV-PCI-MSI 268959746 Edge      nvme0q2
>>       79:         10  PNV-PCI-MSI 2416443392 Edge      eth0-rx-0
>>       80:          0  PNV-PCI-MSI 2416443393 Edge      eth0-tx-0
>>       81:          0  PNV-PCI-MSI 2416443394 Edge      eth0
>>
>> A non-zero count on eth0-rx is good enough.
>>
>>      # ping -W2 -c5 10.0.2.2
>>      PING 10.0.2.2 (10.0.2.2): 56 data bytes
>>      64 bytes from 10.0.2.2: seq=0 ttl=255 time=7.339 ms
>>      64 bytes from 10.0.2.2: seq=1 ttl=255 time=0.673 ms
>>      64 bytes from 10.0.2.2: seq=2 ttl=255 time=0.405 ms
>>      64 bytes from 10.0.2.2: seq=3 ttl=255 time=0.369 ms
>>      64 bytes from 10.0.2.2: seq=4 ttl=255 time=0.516 ms
>>      --- 10.0.2.2 ping statistics ---
>>      5 packets transmitted, 5 packets received, 0% packet loss
>>      # grep -E  "eth0|nvme" /proc/interrupts
>>       76:         12  PNV-PCI-MSI 268959744 Edge      nvme0q0
>>       77:         62  PNV-PCI-MSI 268959745 Edge      nvme0q1
>>       78:          0  PNV-PCI-MSI 268959746 Edge      nvme0q2
>>       79:         34  PNV-PCI-MSI 2416443392 Edge      eth0-rx-0
>>       80:         10  PNV-PCI-MSI 2416443393 Edge      eth0-tx-0
>>       81:          0  PNV-PCI-MSI 2416443394 Edge      eth0
>> That's even better I agree.
>>
>>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks for the review and the suggestion.
> 
> About using 4 sockets, I used it so the receive and transmit interrupts both go
> to different sockets, so more sockets are involved, which I assumed may help
> catch some rare cases ? Also, with 4 sockets, affinity setting also gets tested,
> which won't happen in 2 sockets as we don't need to set affinity in that case.
> 
> I will send a v5 with 2 sockets if you still think otherwise. What do you say ?
No need. that's fine.

Thanks,

C.




