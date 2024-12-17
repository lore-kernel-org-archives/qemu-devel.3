Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A3CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZsn-0002IF-Dj; Tue, 17 Dec 2024 10:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tNZsm-0002I7-Hy
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:53:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tNZsk-00010l-9W
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734450786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wzennjzeMe0eG121NMe2rKOI5L4JFb5kJ2yz+HODSU8=;
 b=P/aGNL1av0g53Ntgp4devpkOrvIlRC+MTe8r+ZFB89BQJCroL4cs+Dx9lsN4GtGsNSdcJ3
 LwLnFgCHmQNPp/QNnsAJyupRkwtihHIXMgEui4xHHRQ2oPAG915e1OoHfIW2h61eAHe3pI
 whhMBAKOwW/P6tZKnyM2OifiiWvsKpM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-xTSqRTlXPTudyRmnTvIx9Q-1; Tue, 17 Dec 2024 10:53:02 -0500
X-MC-Unique: xTSqRTlXPTudyRmnTvIx9Q-1
X-Mimecast-MFC-AGG-ID: xTSqRTlXPTudyRmnTvIx9Q
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-467975eabdaso99396591cf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734450782; x=1735055582;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wzennjzeMe0eG121NMe2rKOI5L4JFb5kJ2yz+HODSU8=;
 b=B7T1y2WQQcfQ3CeAHqYtdMnvuSpl+KP9Cl1b6ChPRpINWvjG2OD4ueDSjCzjus+QU5
 aVrz6a5ElDwo7oxwvvDD6J798GPl9bOzl4TzE6Nr7d2MbytaTy/Z9kJUulj8vnjv7UQr
 lRxbo6P9IoC2CBlCWgW5B0ECVHWaCTW6Mg4RIsp+O0kW+O4BTjr5PM2KUkwkl9pH2GbA
 TFqrdK+0QXT63NXVpdgQjmD/tZKdVgq1eQIA/mirI3UKEHkQFAzIYBZxR1YRc2FFvNY3
 kU7FHy7Vt97cQ5MMADaquSA1ATdZbLDvqcQ0ZaTbbPmrOBymUY82vv/e5YPTzIaxyL8Y
 ETBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKuLExB9gGQ9UVTVNVbHIzqhE7etHKcCKeh5fjQ3pEMkeuMSZa+O3jIVjhX6pmRY7E7ehXpWub9aV2@nongnu.org
X-Gm-Message-State: AOJu0YxVfwFur4bggwlW68k7zF8pTXTV7QYu7NswSHakRHPmylG4Wxex
 +yytK63R5D05ejsW4pv7oXZYU2byCVQ2jgKkeQ7zk58xHd/xzEcasFV2UiCUj6oecVNtIvG3CuP
 N26tzsyllGgffLfpr0EVhfTDSt/XGEgmEvtHZ2RjFAiBM1Gl81YgB
X-Gm-Gg: ASbGnctzNFp8uhamEtxDortxt+QEksQr5Y1jkPb3aKBlI7eOU4MgazbM3L5l9CLngY/
 M6C2H06aoTvVpCSE0ZLwQrqdr8NwBGoyeccKFr+PRTwSscu5yjcK3qImVM5di+W7lSmICjheNIO
 9ynbMQGxIPoaMJG/w+bOuV5zjijO6ropkNHqZ+ysxVcBwOMdHWZ0giQWn88sqeV3629v13nvJ54
 eyPG2JBlj8GqrFmBJaYfc9reuLIx0tQAgXj3DwlXLLoNDIvO0f4BMUhWNVYw1J4nzbbomuyJ2wk
 y+ULY6dx6Sj+iqShrAOUdUkD9Kew
X-Received: by 2002:a05:622a:1a26:b0:467:5734:da89 with SMTP id
 d75a77b69052e-468f8df3b5fmr63327641cf.23.1734450782415; 
 Tue, 17 Dec 2024 07:53:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkwNFWLyaGG1LGPTUOx0CBN25BNFFb/gl4Iul/Qr+zU6p5jsKBlLherfPXzvux45xh3yj8lA==
X-Received: by 2002:a05:622a:1a26:b0:467:5734:da89 with SMTP id
 d75a77b69052e-468f8df3b5fmr63327441cf.23.1734450782126; 
 Tue, 17 Dec 2024 07:53:02 -0800 (PST)
Received: from rh (p200300f6af0bca008282df582fad0b68.dip0.t-ipconnect.de.
 [2003:f6:af0b:ca00:8282:df58:2fad:b68])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2c6fd59sm40579461cf.11.2024.12.17.07.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 07:53:01 -0800 (PST)
Date: Tue, 17 Dec 2024 16:52:57 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, 
 Zhenyu Zhang <zhenyzha@redhat.com>
Subject: Re: [PATCH v2] pci: ensure valid link status bits for downstream ports
In-Reply-To: <20241203072809.3431fe80.alex.williamson@redhat.com>
Message-ID: <6a741fa5-8e6f-1c11-9879-378bbbd56c75@redhat.com>
References: <20241203121928.14861-1-sebott@redhat.com>
 <20241203072809.3431fe80.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Hi,

On Tue, 3 Dec 2024, Alex Williamson wrote:
> On Tue,  3 Dec 2024 13:19:28 +0100
> Sebastian Ott <sebott@redhat.com> wrote:
>
>> PCI hotplug for downstream endpoints on arm fails because Linux'
>> PCIe hotplug driver doesn't like the QEMU provided LNKSTA:
>>
>>   pcieport 0000:08:01.0: pciehp: Slot(2): Card present
>>   pcieport 0000:08:01.0: pciehp: Slot(2): Link Up
>>   pcieport 0000:08:01.0: pciehp: Slot(2): Cannot train link: status 0x2000
>>
>> There's 2 cases where LNKSTA isn't setup properly:
>> * the downstream device has no express capability
>> * max link width of the bridge is 0
>>
>> Move the sanity checks added via 88c869198aa63
>> ("pci: Sanity test minimum downstream LNKSTA") outside of the
>> branch to make sure downstream ports always have a valid LNKSTA.
>>
>> Signed-off-by: Sebastian Ott <sebott@redhat.com>
>> Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
>> ---
>>  hw/pci/pcie.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

Can someone pick this up for the next qemu release?

Thanks,
Sebastian


