Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9218C369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 12:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3D42-0006Fa-RT; Fri, 11 Apr 2025 08:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1u3D3n-00068C-FX
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 08:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1u3D3l-0003mP-Cr
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 08:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744372834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pzgcQLE6HFBLZCHVeaIlQLHjWuR1b79GNGGpIio7Aho=;
 b=c7j5gySpKsggOBt1cL4dTT+ZEMNrgDHb4llfBPRRTH8hgaxdSHqRzRJ9xONHXo0olMDxm4
 VVn6p0+LMOfV04dKECllgWPYwy1LYjFElAC+OLJz5sI8G2fUYuj2gx3pzt8Of3DjdaAMht
 GDvvBdlYYEnsLrXtuK2DW4JVX7SonzU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-2FfU1wneMh29qBf1rH4K5A-1; Fri, 11 Apr 2025 08:00:32 -0400
X-MC-Unique: 2FfU1wneMh29qBf1rH4K5A-1
X-Mimecast-MFC-AGG-ID: 2FfU1wneMh29qBf1rH4K5A_1744372831
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913f97d115so1018058f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 05:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744372831; x=1744977631;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pzgcQLE6HFBLZCHVeaIlQLHjWuR1b79GNGGpIio7Aho=;
 b=kJoZTM7MCKBMoh63evmBrAgmUGlYblrb1gVArNmwZQ9sCttz4mc4jIanRlBifEUt7Z
 RbIahesNXmbZ9zhKlfyVJsdMuQq+HGHeRpngqQ8ca+2uKckTn54QdWxbZGUNUMyNLjsm
 JZeEzv+RvRCqdDC02CrGFAjUgAm1M6LBJvbDNVkoU1Oyiy6ILkIkK3B3+5YcJjbWICDA
 fX7G5is2npGURP4fWzas2E6ZHOm4+0JniRv3QWaXCxLTzIdvrTdCN6h7q0xzHzSxopNm
 QDW8MRM0G3nQLfsJjCPyPoJuMhdcGX34L4T8mFX3D6ERN0r5IE3IRE/13Ut/kbgIPvEy
 FZLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcgzw2lkq0ui3YT+BuP3VQtJJn/PVs5PKZyOojMb/mm4kPJH/vDwQ86F6LuvnErCJiwm9A5IR2Gk/Q@nongnu.org
X-Gm-Message-State: AOJu0YzuXJqYXGSGLCXJTQ4z3H11RC95nrxWdgAfcAOYR4rcfOrT41jX
 LD9VVk6ubox1lxbEB1BHwRc0D74JMZ/MaB0YBt0q0p5KhB0laqyfT+TFTXns9TqWIKcRj0H4EKa
 MkGXJFoLqYqTNCShXWH1Nlg2Aq1hIKa0mfgkoJwCgR8IugYEztqid
X-Gm-Gg: ASbGncueaGtuGM7VPA6ZMrSsyHAzmHLh12XRUXJ7plinO2Nk3Pfjm7s4ndv6mI9NeW0
 Ke42nP1Wxv7oj7fWxmOTnPTQQIgrOKE+D1A3bZJ9FCufuA7WXetx4Pv/dRTTmAyXVW9eyDgJQHU
 D0tr2MldFj6W2ZolILu5kMVMLRKPfrrv9yhoch9v0dsbpQHC34Vloqjx6z36QhDQ0B+9zAC/YqT
 uIzHDkG19LwAqEGbbHmK/NtNDQF5b0WZQZscW4khEASE8VcDSw9mvophaClSAhs1LKzm8zA12In
 I/ZJTBEZC9QjFwm5NT+fOWdg2tatxjAS0jdW91+lxrySbzRhkbXafvHoA1q16OIGcIotEfbL0Lq
 Yy9EIiMGgsMWLC2mfs6t7whPEk4beVX88CCRk
X-Received: by 2002:a05:6000:420d:b0:39b:f44b:e176 with SMTP id
 ffacd0b85a97d-39d8f4dbfd5mr6004451f8f.24.1744372831282; 
 Fri, 11 Apr 2025 05:00:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBsq5VDmpvIhj34XpA5WJMURaLRODyeyMImDEdB7wSeETUNsGP2Dl1mmCnb1JwCvV693oE3g==
X-Received: by 2002:a05:6000:420d:b0:39b:f44b:e176 with SMTP id
 ffacd0b85a97d-39d8f4dbfd5mr6004417f8f.24.1744372830848; 
 Fri, 11 Apr 2025 05:00:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:6800:7ddf:5fc:2ee5:f08a?
 (p200300cbc72668007ddf05fc2ee5f08a.dip0.t-ipconnect.de.
 [2003:cb:c726:6800:7ddf:5fc:2ee5:f08a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cdfdsm1830677f8f.61.2025.04.11.05.00.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 05:00:30 -0700 (PDT)
Message-ID: <88359b3c-c7dc-48b5-8927-f5f837c5c0ce@redhat.com>
Date: Fri, 11 Apr 2025 14:00:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Management applications and CPU feature flags
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, devel@lists.libvirt.org
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
 <87friheqcp.fsf@pond.sub.org> <Z_YolW1Nw6Q_tsz6@angien.pipo.sk>
 <Z_jq5drO_25w0bC6@redhat.com> <87lds77zgx.fsf_-_@pond.sub.org>
 <Z_jyVQMfRbWaM66y@redhat.com> <8734ee9b4k.fsf@pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8734ee9b4k.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11.04.25 13:43, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Fri, Apr 11, 2025 at 12:40:46PM +0200, Markus Armbruster wrote:
>>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>>
>>>> On Wed, Apr 09, 2025 at 09:58:13AM +0200, Peter Krempa via Devel wrote:
>>>>> On Wed, Apr 09, 2025 at 09:39:02 +0200, Markus Armbruster via Devel wrote:
>>>>>> Hi Steve, I apologize for the slow response.
>>>>>>
>>>>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>>>>
>>>>>>> Using qom-list and qom-get to get all the nodes and property values in a
>>>>>>> QOM tree can take multiple seconds because it requires 1000's of individual
>>>>>>> QOM requests.  Some managers fetch the entire tree or a large subset
>>>>>>> of it when starting a new VM, and this cost is a substantial fraction of
>>>>>>> start up time.
>>>>>>
>>>>>> "Some managers"... could you name one?
>>>>>
>>>>> libvirt is at ~500 qom-get calls during an average startup ...
>>>>>
>>>>>>> To reduce this cost, consider QAPI calls that fetch more information in
>>>>>>> each call:
>>>>>>>    * qom-list-get: given a path, return a list of properties and values.
>>>>>>>    * qom-list-getv: given a list of paths, return a list of properties and
>>>>>>>      values for each path.
>>>>>>>    * qom-tree-get: given a path, return all descendant nodes rooted at that
>>>>>>>      path, with properties and values for each.
>>>>>>
>>>>>> Libvirt developers, would you be interested in any of these?
>>>>>
>>>>> YES!!!
>>>>
>>>> Not neccessarily, see below... !!!!
>>>>
>>>>>
>>>>> The getter with value could SO MUCH optimize the startup sequence of a
>>>>> VM where libvirt needs to probe CPU flags:
>>>>>
>>>>> (note the 'id' field in libvirt's monitor is sequential)
>>>>>
>>>>> buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"realized"},"id":"libvirt-8"}
>>>>> buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"hotplugged"},"id":"libvirt-9"}
>>>>> buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"hotpluggable"},"id":"libvirt-10"}
>>>>>
>>>>> [...]
>>>>>
>>>>> buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"hv-apicv"},"id":"libvirt-470"}
>>>>> buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"xd"},"id":"libvirt-471"}
>>>>> buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"sse4_1"},"id":"libvirt-472"}
>>>>> buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"unavailable-features"},"id":"libvirt-473"}
>>>>>
>>>>> First and last line's timestamps:
>>>>>
>>>>> 2025-04-08 14:44:28.882+0000: 1481190: info : qemuMonitorIOWrite:340 : QEMU_MONITOR_IO_WRITE: mon=0x7f4678048360 buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"realized"},"id":"libvirt-8"}
>>>>>
>>>>> 2025-04-08 14:44:29.149+0000: 1481190: info : qemuMonitorIOWrite:340 : QEMU_MONITOR_IO_WRITE: mon=0x7f4678048360 buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"unavailable-features"},"id":"libvirt-473"}
>>>>>
>>>>> Libvirt spent ~170 ms probing cpu flags.
>>>>
>>>> One thing I would point out is that qom-get can be considered an
>>>> "escape hatch" to get information when no better QMP command exists.
>>>> In this case, libvirt has made the assumption that every CPU feature
>>>> is a QOM property.
>>>>
>>>> Adding qom-list-get doesn't appreciably change that, just makes the
>>>> usage more efficient.
>>>>
>>>> Considering the bigger picture QMP design, when libvirt is trying to
>>>> understand QEMU's CPU feature flag expansion, I would ask why we don't
>>>> have something like a "query-cpu" command to tell us the current CPU
>>>> expansion, avoiding the need for poking at QOM properties directly.
>>>
>>> How do the existing query-cpu-FOO fall short of what management
>>> applications such as libvirt needs?
>>
>> It has been along while since I looked at them, but IIRC they were
>> returning static info about CPU models, whereas libvirt wanted info
>> on the currently requested '-cpu ARGS'

Not sure what the exact requirements and other archs, but at least on 
s390x I think that's exactly what we do.

If you expand a non-static model (e.g., z14) you'd get the expansion as 
if you would specify "-cpu z14" on the cmdline for a specific QEMU machine.

Looking at CPU properties is really a nasty hack.

> 
> Libvirt developers, please work with us on design of new commands or
> improvements to existing ones to better meet libvirt's needs in this
> area.

Yes, knowing about requirements and why the existing APIs don't work 
would be great.

-- 
Cheers,

David / dhildenb


