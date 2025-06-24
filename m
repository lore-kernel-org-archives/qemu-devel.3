Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20B7C7EE2A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 08:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTz9p-000641-Sn; Tue, 24 Jun 2025 04:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uTz9d-00062V-6E
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 04:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uTz9b-0006zp-BJ
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 04:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750754237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=C8DBmhW7rePeH1J1v+NnWuwz3YBYy1IS4WhvrtwoY7A=;
 b=M6H6TvQ9Og3vgGBR3jI/13bZfRH7rVeWKXArHwfFuOA4UpgTCsxLUQj+YRp6bNwPvSJz0w
 1qlm8LGcLADRAhgMyZgPCUKo1pbcHBiWTJ8rAAgvmMWXqUim1OB9RccUJstyL94QVvpYKd
 MoGAkbFMpgr/y7s/TMy14gj4QjJCLms=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-Zm84SMH2NMSX1akxnBEiBA-1; Tue, 24 Jun 2025 04:37:15 -0400
X-MC-Unique: Zm84SMH2NMSX1akxnBEiBA-1
X-Mimecast-MFC-AGG-ID: Zm84SMH2NMSX1akxnBEiBA_1750754235
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451ac1b43c4so1195375e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 01:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750754234; x=1751359034;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8DBmhW7rePeH1J1v+NnWuwz3YBYy1IS4WhvrtwoY7A=;
 b=py35TPMHPY8te23mzQ4TbABHVglRv1jVJGrPBvSq2ok5kIlYJhoFYQ24fdN7UrufQp
 cJM1pYDrv1D4KsA36A1eFXhJiw7rAiV0RYDUAJwk2Ttd2tIT/seO5HowuvZw8pc3Rz5B
 dRkbC4416PT1cHjMW/4lB62djIOm+Ifusin+N9KCbxAw8KEBJEhVMJ4enbahBbbBLKK6
 xq1O7dK+rwfMQG883Pmduj6/+9z0GGkNnNxyvDLbmL/FKosHs3ZtUVxeXjwDIBxOsshc
 cAWtqE9qW7uGW82KUQ94CWKDpiHr77RBOo21Yl1sfHrAkxAG4/FRs4ipRm8zrWM6c2P5
 irkg==
X-Gm-Message-State: AOJu0YxNDWrSNt6+UgkI3nCpMKmMeR5X/rBHxqkEtIGs8Qdr1eb4nHP3
 3Gr6Xq5V5pRe9ADEs0oQJd+46G/ooblHPBCS2lBw3DosM67srdBAW2vZnZybwP3COIElCLYHAWC
 DxXW87Deuo+rXE0DNHtUIrwOtMryjJtWVGCR6RDrJj9EGaQ2gLqMpwq0H
X-Gm-Gg: ASbGncsHEmqrjr+IBj8Iss0E25MveCEBMpaH2z53oHvNN2WOr+zTeZ8eLbrJD1Wko2z
 xRLaXV3QkQViIYT5QEUXSb2fYNf9oCeQB9mmLYvitkgmkev6gJbmiWLQYebu0FMvADtnE2b0IRn
 vLfrFQFaK3YTPf1x6kkN7ipw+jYDSbUNeLAoQaCd1/pnySM3U80aRwm7MVHrpIzgRmOihyvaY/A
 lpwNoJJvksF4YEcxTpIa+9Wh19f8ReiZrqmhR4trIsyvl7WHvByUHu/LSZo0+NtmttS4cJAucr7
 R/KjZX+BbLHPpSIr28d2S/nr5R+DSApQp6Z0UJtaSQbLjBXeTiDqURwKBsd24Q==
X-Received: by 2002:a05:600c:6995:b0:450:d367:c385 with SMTP id
 5b1f17b1804b1-453658ba6c1mr137174185e9.16.1750754234563; 
 Tue, 24 Jun 2025 01:37:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPIsnChN8M5GhmCxZUfZSitaEWggiBeTEs+uTzV1fPSwVYoU9/b4zckoVaJaoPVPGz7ck35Q==
X-Received: by 2002:a05:600c:6995:b0:450:d367:c385 with SMTP id
 5b1f17b1804b1-453658ba6c1mr137173895e9.16.1750754234204; 
 Tue, 24 Jun 2025 01:37:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4536c77b980sm92606935e9.23.2025.06.24.01.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 01:37:13 -0700 (PDT)
Message-ID: <957e1b39-bb40-4752-9d61-84f2b1ca7aa2@redhat.com>
Date: Tue, 24 Jun 2025 10:37:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] net: Add passt network backend
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250618155718.550968-1-lvivier@redhat.com>
 <20250618155718.550968-10-lvivier@redhat.com> <87pletlflp.fsf@pond.sub.org>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <87pletlflp.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 24/06/2025 10:16, Markus Armbruster wrote:
> Laurent Vivier <lvivier@redhat.com> writes:
> 
>> This commit introduces support for passt as a new network backend.
>> passt is an unprivileged, user-mode networking solution that provides
>> connectivity for virtual machines by launching an external helper process.
>>
>> The implementation reuses the generic stream data handling logic. It
>> launches the passt binary using GSubprocess, passing it a file
>> descriptor from a socketpair() for communication. QEMU connects to
>> the other end of the socket pair to establish the network data stream.
>>
>> The PID of the passt daemon is tracked via a temporary file to
>> ensure it is terminated when QEMU exits.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> [...]
> 
>> diff --git a/qapi/net.json b/qapi/net.json
>> index 97ea1839813b..76d7654414f7 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -112,6 +112,125 @@
>>     'data': {
>>       'str': 'str' } }
>>   
>> +##
>> +# @NetDevPasstOptions:
>> +#
>> +# Unprivileged user-mode network connectivity using passt
>> +#
>> +# @path: path to passt binary
> 
> I'd prefer a more descriptive name.
> 
> Elsewhere in this file, we refer to programs like this:
> 
>     # @script: script to initialize the interface
>     #
>     # @downscript: script to shut down the interface
> 
> passt isn't a script, of course.
> 
> I don't know, perhaps
> 
>     # @passt-filename: the passt program to run.
> 
> or even
> 
>     # @passt: Filename of the passt program to run.
> 
>> +#
>> +# @quiet: don't print informational messages
> 
> What does the printing?  A peek at the code I snipped suggests this flag
> is passed to the passt binary as --quiet.  Correct?
> 
>> +#
>> +# @debug: be verbose
>> +#
>> +# @trace: extra verbose
> 
> Likewise for these two.
> 
>> +#
>> +# @vhost-user: enable vhost-user
>> +#
>> +# @pcap-file: log traffic to pcap file
>> +#
>> +# @mtu: assign MTU via DHCP/NDP
>> +#
>> +# @address: IPv4 or IPv6 address
>> +#
>> +# @netmask: IPv4 mask
>> +#
>> +# @mac: source MAC address
>> +#
>> +# @gateway: IPv4 or IPv6 address as gateway
>> +#
>> +# @interface: interface for addresses and routes
>> +#
>> +# @outbound: bind to address as outbound source
>> +#
>> +# @outbound-if4: bind to outbound interface for IPv4
>> +#
>> +# @outbound-if6: bind to outbound interface for IPv6
>> +#
>> +# @dns: IPv4 or IPv6 address as DNS
>> +#
>> +# @search: search domains
>> +#
>> +# @fqdn: FQDN to configure client with
>> +#
>> +# @dhcp-dns: enable/disable DNS list in DHCP/DHCPv6/NDP
>> +#
>> +# @dhcp-search: enable/disable list in DHCP/DHCPv6/NDP
>> +#
>> +# @map-host-loopback: addresse to refer to host
>> +#
>> +# @map-guest-addr: addr to translate to guest's address
>> +#
>> +# @dns-forward: forward DNS queries sent to
>> +#
>> +# @dns-host: host nameserver to direct queries to
>> +#
>> +# @tcp: enable/disable TCP
>> +#
>> +# @udp: enable/disable UDP
>> +#
>> +# @icmp: enable/disable ICMP
>> +#
>> +# @dhcp: enable/disable DHCP
>> +#
>> +# @ndp: enable/disable NDP
>> +#
>> +# @dhcpv6: enable/disable DHCPv6
>> +#
>> +# @ra: enable/disable route advertisements
>> +#
>> +# @freebind: bind to any address for forwarding
>> +#
>> +# @ipv4: enable/disable IPv4
>> +#
>> +# @ipv6: enable/disable IPv6
>> +#
>> +# @tcp-ports: TCP ports to forward
>> +#
>> +# @udp-ports: UDP ports to forward
> 
> Is there anything in this struct that configures qemu-system-FOO itself,
> i.e. isn't just passed to passt?
> 

Yes, all parameters are just passed to passt.

Do you think it's better not to add all these parameters to netdev backend but only one 
generic containing the passt command line parameters?

Thanks,
Laurent


