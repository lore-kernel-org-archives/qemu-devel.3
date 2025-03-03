Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BEBC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 09:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp1iU-0006mM-Vl; Mon, 03 Mar 2025 04:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tp1iH-0006hS-Id
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 04:03:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tp1iF-0003Yj-GI
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 04:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740992626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aQKoTCBgODksrRKetZMr54c44RcRu/27ocoHPHSnK8g=;
 b=A7EmYcnDE/kihT+O+FLj02fhXo7QIfIWpLl7/8svBj7y0lW7yN4FZd0sIufyDpZtEfEm66
 zfxUiJhG9hFxN2h4UoEH2J5tl02UwoBrWLQ6mRtd+z7fGmVfwRbArzQyABdeSK7GWPqn5Z
 ualUpZe204PdgrFiyOCvnGxU5L3kP5g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-0wIcaOpJNESPbGxsG0IHhw-1; Mon, 03 Mar 2025 04:03:44 -0500
X-MC-Unique: 0wIcaOpJNESPbGxsG0IHhw-1
X-Mimecast-MFC-AGG-ID: 0wIcaOpJNESPbGxsG0IHhw_1740992624
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4398e841963so28485025e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 01:03:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740992623; x=1741597423;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aQKoTCBgODksrRKetZMr54c44RcRu/27ocoHPHSnK8g=;
 b=CRSuY7+f0CbhOn0PnDO2YY2gm7uikLQ8B1QWfk9BPTiSiMqlwbTMibjsgWLo3Ci7V5
 f21O69KlF4tMsGP5invdmLGd4Y1A5n24QtHibZttXjTVz3xqB/xV6+DzBJ/OboT2jFMD
 FwE06PMWek3ba3pQ3U2zV5r2d+TZD7ZeKJU/fgFsljOmb4KpLNdvBY/tK2c5vFRWmIXV
 PS3+bBXqjSrVR+3TDg6Byn2XpBakXD82cu9jA8tcHVHXDMCiZ6gvNYiZdw2e4NKUMhZy
 kl6m6wfA9pkfq1l0tdEQlQAJmL7c47GnW3rmFMrXxrkPA+yWr0BjzZH+4hZTK+yweCsY
 ap+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTCypfadVSvuG4lza99CJI7elY2USmYF9Ovmxf7eHe53mFFqm9r+X0hTJv9Hbsv+JpqeUucSa51d1U@nongnu.org
X-Gm-Message-State: AOJu0YyKdPPpR5+7w7dg/tOGtY7G22TSei8Rku5jRfBmcZ6R6dRGE+di
 VJgFUtqaxch/n2EgfVEVTPFbURFDgHhEIAWY/HJWt+gE2akWNs0/ZHC4Lw66vPbbgzbXE42FNvg
 MzK40H7/HNfWklE+RQXWx21L8pnY7dVOBsm2GduuGgziJ4VRb31hg
X-Gm-Gg: ASbGncuBIBa/3aD9/1N6PNPSRJlMIpfQ6Fcb/uPQqrt3zA1WOiVY0UGMcILnt35fLka
 LtK+dcNwF9TtB4p6Ep4DGdcY0HSdDcPnEB/h9EbWfFed/Qng6x6OEzATvZw3YaowCyeVG5cBDY7
 H72F5WmmYmq34Y5afU9XrZgzfOzZHwFNYbvAALgHmmyAg05l5UfBFQ2Qa2WQORO5ubKkjI/xlwp
 M1bm/LoQ09UdIOvVVeJnrJPndRK3SLtuQc5DFkyQQQWLi8t2AVtGWaUTieYCL4F/C3Z1iHe6f8j
 sdaUxmhkDx58WB3sSdYsqbDgrsxrsoh/peOfxt+ESLljNk7ilnfXpzvCxVZ8tf4Tv5YSMsm44+X
 S32/9f2c9J+ak+tz+0A56Ox7uDnYSADjBJxPVKnoRUHs=
X-Received: by 2002:a05:600c:3c86:b0:439:8346:506b with SMTP id
 5b1f17b1804b1-43ba675a810mr93420095e9.19.1740992623551; 
 Mon, 03 Mar 2025 01:03:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFr54ueYuHUtJbq1rJJNWfQnLhhFzfJvP/DhkrIxuNVKnvMoxWHJWtm6UoT6US0rb4HHqLnkA==
X-Received: by 2002:a05:600c:3c86:b0:439:8346:506b with SMTP id
 5b1f17b1804b1-43ba675a810mr93419855e9.19.1740992623236; 
 Mon, 03 Mar 2025 01:03:43 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb?
 (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de.
 [2003:cb:c734:9600:af27:4326:a216:2bfb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc38986cbsm21076815e9.35.2025.03.03.01.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 01:03:42 -0800 (PST)
Message-ID: <7fd33c84-191f-43cc-a513-f0f762026b11@redhat.com>
Date: Mon, 3 Mar 2025 10:03:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/16] backends/igvm: Add IGVM loader and configuration
To: Roy Hopkins <roy.hopkins@randomman.co.uk>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Joerg Roedel <jroedel@suse.com>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
 <928b7178f2960441871dbb8145f639b10ac84ccb.1740663410.git.roy.hopkins@randomman.co.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <928b7178f2960441871dbb8145f639b10ac84ccb.1740663410.git.roy.hopkins@randomman.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On 27.02.25 14:44, Roy Hopkins wrote:
> Adds an IGVM loader to QEMU which processes a given IGVM file and
> applies the directives within the file to the current guest
> configuration.
> 
> The IGVM loader can be used to configure both confidential and
> non-confidential guests. For confidential guests, the
> ConfidentialGuestSupport object for the system is used to encrypt
> memory, apply the initial CPU state and perform other confidential guest
> operations.
> 
> The loader is configured via a new IgvmCfg QOM object which allows the
> user to provide a path to the IGVM file to process.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   backends/igvm-cfg.c       |  52 +++
>   backends/igvm.c           | 808 ++++++++++++++++++++++++++++++++++++++
>   backends/igvm.h           |  23 ++

Just a general comment that could also be considered at a later point, 
after this was moved: Is "backends" really the right directory, and if 
so, would it make sense to start adding sub-directories? For example, 
all "hostmem" stuff could be moved into a subdirectory.

Would an "igvm" directory also be the right place for 
backends/confidential-guest-support.c, or would we be looking for 
something more abstract?

-- 
Cheers,

David / dhildenb


