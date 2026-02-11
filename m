Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E11E9E305
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 13:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqA55-0004SN-M7; Wed, 11 Feb 2026 08:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqA4m-0004N7-Hk
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 08:16:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqA4k-00032K-SL
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 08:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770815768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WZLwSS4avktfTUer2vMya0cB+gQVpSxZqqEB6zeNQcQ=;
 b=Rs+WHx99r9moiTprkaxFbyXXc2OsqRMZBWyZ3h1YytzocLYgJ3ImnHNMMiWCyzDxqt1Egr
 e2Vzj3QGRetcaWMcGLx2n/enMG2juHT8L7x4teklIqTlCPhhf9uniH8+TuSJGmZJRiEMKV
 tdzDF+qf99PkV6OuOvUsKa/9Trbw6io=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-Z-nhc6ttOaeLrBZ0aFTePQ-1; Wed, 11 Feb 2026 08:16:07 -0500
X-MC-Unique: Z-nhc6ttOaeLrBZ0aFTePQ-1
X-Mimecast-MFC-AGG-ID: Z-nhc6ttOaeLrBZ0aFTePQ_1770815766
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b8861544696so796436366b.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 05:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770815765; x=1771420565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WZLwSS4avktfTUer2vMya0cB+gQVpSxZqqEB6zeNQcQ=;
 b=dxLcx7yHAJ4jbxoTOs5xpSv11OA38woKwJXRckeNAO/tvYpnhntHF9XrnKRBnsMSoa
 sQFwzSdvAAwDVVbF57m6pc3qyoDdn2pXFjLy98nMR3uikKH2OTiZsnELirXTm/IqQvee
 /wHWIlZw7PWlRnVsi0LT8Iu0LlCJYFfasPD1qvWFnNWiFXZPqT+OsEcfikjz59+g9npz
 LXoALlyFkeYjOHxRZe77CzmJPTbtVHx6Lc4e3Yiaf9gzSHOcfGl0BMFulbLVe1s+4uwg
 J/uSFqOBqCNf4VuEyiG+dOERKlzu26PmH6uq2tN3vxCeslZdUFCYl+PQh2n+Amt/1moq
 DL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770815766; x=1771420566;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZLwSS4avktfTUer2vMya0cB+gQVpSxZqqEB6zeNQcQ=;
 b=kbjGoSFw/QsYEPC4p0emIjmRgDgLPygmW/nVgRfpXOXkttwvEKv+SzMNZb/uOAHdMx
 vwlHAzitPx77C5fP0iFhvG+/ntwmPCAxKN8/9b9+mQDsLvHUJt8c9XMshyvQW9syH8ef
 zY2j3xh/fmG33itOos2tadIA4rzF9iztGU38pwTUiS//upQ7pZpKJDOjH9jSqeoQHOJj
 FZlh+aKxj0RK+YBIR1fw38rcpDE+sLzdn0n9mBL12nX+vyX80B8udzhIj5vQZlfOZhpq
 0SxeD3fAFUr5fmRk3GGZHdzlCjYXblhSu/umltbjT552X/1CoAhRD4SwL3vJl8AJuhco
 oJRg==
X-Gm-Message-State: AOJu0YzkUpJROevs5psnisNh0y2d9b0W9Ah01sOGBO448fN9ibHnHlZo
 FUCTOo/JQeFe7NZpuK6hSRy1OmrZClHDlovlO4l5JI+ob2PY0kXBigl+1EpnJ7sXTzHA8qJmbyH
 ep4oXX1pbX2DC9rho+xCKkriv47YGd8b+1CGrh/6MLmMs+31eOZNwmhE8
X-Gm-Gg: AZuq6aKZfbfNhoYgcdGNjCxDszRxxwaBFkdfnb3EsGaVadJM6Xw6ur4BJHxJZlHjFqW
 YfrVKLDxqv0gYFYgDg6n5BW/L40G7ltceF08YGHUmWdvH0KOUeCDHqYv+4YnJwaMp7eaFXA4rmm
 jq7GD2il3J1TA9COS75XTIHbhEq4NGtiJ16Mg3nFjMvXuxMWdk56RrfgXI6BVXdsXaeI+hdWHzY
 UpUC9kV6m8ge2gktswtOaZXQLPM4oCmJmRcwlP/e/6acF/jEkFRVjpyXEZa1lgoSCfhdrbJz/ZJ
 tiRjskz7dpS5XPdE5W5vDzW2BBncQOkoM2f1nU5y+lGUqPLHPm135UOE5wczqQkqbp5OzmOS18/
 BU3AtQv4w/4D3Nc+KNzkRCfGu73S2pnpsHC/mcYmO5OifeQC2hrVKyC87QS75
X-Received: by 2002:a17:907:961c:b0:b87:965:9079 with SMTP id
 a640c23a62f3a-b8f6ee50f2amr124498366b.3.1770815765490; 
 Wed, 11 Feb 2026 05:16:05 -0800 (PST)
X-Received: by 2002:a17:907:961c:b0:b87:965:9079 with SMTP id
 a640c23a62f3a-b8f6ee50f2amr124496666b.3.1770815764946; 
 Wed, 11 Feb 2026 05:16:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65a3ceb1d79sm669916a12.7.2026.02.11.05.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 05:16:03 -0800 (PST)
Message-ID: <aa18ad15-580e-483d-8e29-20c7e6ebb6fc@redhat.com>
Date: Wed, 11 Feb 2026 14:16:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
To: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260202173406.13979-1-avihaih@nvidia.com>
 <24ea8ccb-d904-49e4-bd27-5378aac4a56a@redhat.com> <aYIqDAdld4a41VDy@x1.local>
 <87cadb65-af45-4bb3-8090-8301a1e67103@nvidia.com>
 <a0dbd63d-30b9-4c83-851d-abaf50d4c9fc@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a0dbd63d-30b9-4c83-851d-abaf50d4c9fc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello,

On 2/11/26 14:01, Avihai Horon wrote:
> 
> On 2/3/2026 7:25 PM, Avihai Horon wrote:
>>
>> On 2/3/2026 7:02 PM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, Feb 03, 2026 at 05:48:11PM +0100, Cédric Le Goater wrote:
>>>> Peter, Fabiano,
>>>>
>>>> Do you think it would be interesting to send VFIO migration events
>>>> by default ?
>>> No objection here.
>>>
>>> IIUC it's a matter of why it got introduced with default off in the middle
>>> of 2024?  If it's about compatibility of any old mgmt which may be
>>> surprised by these events, then we want to know if they're ready, and then
>>> if we need a compat field for it in older machine types (or enable it even
>>> with old machines).
>>
>> I disabled it by default back then because it was only needed for the use case I mentioned here (specifically, it wasn't needed by libvirt).
>>
>> I guess you can either leave it as is or enable it by default, it won't matter.
>>
>> Thanks.
>>
> Hi Cedric,
> 
> Are we good here?
Yes. Sorry I should have said so. It's queued. I don't have much
for a PR, so this will wait a bit.


As for enabling the VFIO migration events by default, I guess we
all agree it could be done. We simply need a stakeholder to change
the default behavior.


Thanks,

C.


