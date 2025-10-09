Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02ABCCD18D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6sVW-0007Uc-Qg; Thu, 09 Oct 2025 11:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v6sVU-0007UE-Uc
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v6sVO-00026A-CG
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760023470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i6GoWMcmxgmC9Y6qqKYBdHygD+Q6jwy7RqMGF3U92k8=;
 b=P+Rusfzeq7y9XykNYX5qZF3Rkpe+k8N5HegEREBDTGPOEP16tiqb3vQwzi/zPsKIdgUQiW
 le5q5XmtBYFEZD/hr1tKIYvUgt6NvoPtc1OGyTLqIPQp4yjJ03fzP6wMDcNK36n8vV4/XD
 WUcAMBe0rLlJY1T+sy/COKAId5uKh+4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-oSVvrF6cMOehTjZI8n6itA-1; Thu, 09 Oct 2025 11:24:28 -0400
X-MC-Unique: oSVvrF6cMOehTjZI8n6itA-1
X-Mimecast-MFC-AGG-ID: oSVvrF6cMOehTjZI8n6itA_1760023467
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ecdd80ea44so1064373f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 08:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760023467; x=1760628267;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i6GoWMcmxgmC9Y6qqKYBdHygD+Q6jwy7RqMGF3U92k8=;
 b=uW0Kk/789DucYe7frGYzzgq8aMsE0e3rQ5GSUIV9DYAtVUJNWBkgHdbhDCMgjl5MTL
 mESAjSA61H9mjdYjCA6FmGeN3N2KwX2WmhFmfRqmQgZlMR7bDJ+t5RdPPI7hLCR3322I
 Fy62ePIQu1Lw27qajNE597zeJM+sjq9U0yZiD028EMn1yEmwCy7Nn0ZaBoWUOR/2raZ4
 3ph+ewgVBHlF3hazLTnE5qSQUSvr2SbhXIL17G9SRl3cMfkqnpkADBcfR8zZvmOdrsLF
 167dVZcYOrIRWHoMKy45YzOnkt2LU2SOzKPajgIvcDrfnJZ0xkOCu2gBn6GbWCrVWt99
 0E7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWk0ZWqFa5y8AzIzQjEp9IZLGE4bJIII598uOFk1+3S4x4TyqYoKg6dYilA3DSYXFyw/J5uhaA7V2r@nongnu.org
X-Gm-Message-State: AOJu0YzGpjCVculqjSiVxr13J72Z0xaI7TfuHJb2etqpwqQNh/SYBt96
 3P4c9T20HRcXWds2YihqEy7tb9Z6nATzydvGgY43FXw2kDpOgZIrdRvC4vnAr28yNpbtIi7Qprc
 eT+OggOdVxLWJNsvG6RHGl0kEgmNhMq37SYvPz6Kn/PnVLiTN6SHkOuEg
X-Gm-Gg: ASbGncsy3JP82agTEq4k9R+WoDlB5vmxeMuB/C/eATSoKydrh1lwZyvhBnThYwTkwQh
 86o9HzmOmtqnlzA6+SWdV/2zDgggRUI/paxDNpikxaSc+lzNZHlD6/ULeP69MW2tatZ47+dhMid
 MTG51i2nBJkN3acvd7qII014FsswyCLwmD3aqkiH68zxfi0Bh72Vg5PCo7ru6drhdWdKCOdKm4q
 L6G/JYY1D7HCsIQQAH5lmj6vF+ZIGcnQtsofyhRi74I+ligYA+e3nWh21VYePXCBjI/QClsQ7Vh
 Plasx1hVV+tNC2lnGCDi5akdDzxEBnydidNLWALudSi+y0lPPmdDUay6O0hS+W/mU6j6E82yROH
 uQvFGp4DX
X-Received: by 2002:a05:6000:26c9:b0:425:57dd:58ca with SMTP id
 ffacd0b85a97d-42666aa6384mr5111362f8f.8.1760023467395; 
 Thu, 09 Oct 2025 08:24:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1jLuAfs7+yYFTVW1w2ZnY3wHUqK7PbgG7YG4IOkOJTWUznxGS77PhQSWjA/ujFA/gnTnqcw==
X-Received: by 2002:a05:6000:26c9:b0:425:57dd:58ca with SMTP id
 ffacd0b85a97d-42666aa6384mr5111344f8f.8.1760023466933; 
 Thu, 09 Oct 2025 08:24:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f02a8sm35649249f8f.39.2025.10.09.08.24.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 08:24:26 -0700 (PDT)
Message-ID: <210ae8c8-0654-4240-be35-fcff67f11282@redhat.com>
Date: Thu, 9 Oct 2025 17:24:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system/devices/vfio-user: fix formatting
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>
References: <20251009140206.386249-1-john.levon@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251009140206.386249-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/9/25 16:02, John Levon wrote:
> The example QEMU argument was not rendering properly, as it was not
> indented.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   docs/system/devices/vfio-user.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/system/devices/vfio-user.rst b/docs/system/devices/vfio-user.rst
> index b6dcaa5615..7c110b1644 100644
> --- a/docs/system/devices/vfio-user.rst
> +++ b/docs/system/devices/vfio-user.rst
> @@ -20,7 +20,7 @@ Presuming a suitable ``vfio-user`` server has opened a socket at
>   
>   .. code-block:: console
>   
> --device '{"driver": "vfio-user-pci","socket": {"path": "/tmp/vfio-user.sock", "type": "unix"}}'
> +  --device '{"driver": "vfio-user-pci","socket": {"path": "/tmp/vfio-user.sock", "type": "unix"}}'
>   
>   See `libvfio-user <https://github.com/nutanix/libvfio-user/>`_ for further
>   information.


Applied to vfio-next.

Thanks,

C.



