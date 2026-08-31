Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4A6C624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12g1-00025J-Q0; Mon, 31 Aug 2026 10:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x12g0-00024t-8O
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x12fx-0006F4-UT
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788185272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zw6an/2EhhJ5W4wnSO5Y4YLVwQ7GrB0FsgM2E6YvV0o=;
 b=QCRXxBd7vPDyN0mzPCfb2ym0oOZaXDs7qjg17Ra3fjIEicyGcY84mAg0cTL7gEY3x3yWR8
 3hy+1b2IG8zMfDnEzgw5DGQCK0uAONkyGN0Vx4vgkeVL+4bnvLyeQU4m8dkFCRfAsn8El7
 1aVnH4beA85lgtgvbd2paCWFnQbS7QI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-w4PxSnA-NUqlaN8WEj5NPw-1; Mon, 31 Aug 2026 10:07:50 -0400
X-MC-Unique: w4PxSnA-NUqlaN8WEj5NPw-1
X-Mimecast-MFC-AGG-ID: w4PxSnA-NUqlaN8WEj5NPw_1788185269
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c15f4732dfaso315754566b.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788185269; x=1788790069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zw6an/2EhhJ5W4wnSO5Y4YLVwQ7GrB0FsgM2E6YvV0o=;
 b=TcguOWVUGhewBlz/LBh/MZ8qZeYqrnDrMFGZdPKESC5/sqc+7EXLzpILkZ/GiqBDFh
 NZgHJBu420w24BpMkI2Vcd91DTBdmETFE00rC/7mPtsQikYX+pPB0WWf9l6nYmXRu3bR
 Ls05BRATaaZuFcnsRl0dRxepQ6uzExTMcHkdaU/W/YvMaAXsK5aGvrpKZS5k7EN1GJ18
 AT9idw0eDnpvZJuES2yW3uuxS2cCnmO9RuES11GxZeGxau8mjCq7QXSz1yvQbLgrghC7
 pzsjALIlX+0/B8WNM4XTFCnBJBy3FJJcShymH7uD3OrJdc9dTPLF6HkWtDE09Xsm0HHh
 62iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788185269; x=1788790069;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zw6an/2EhhJ5W4wnSO5Y4YLVwQ7GrB0FsgM2E6YvV0o=;
 b=Ts/W39BKLBWrwiFknVCXmEWXiG19JOqBApsdWxBTPWrEgC4Lnhf1KHegh6T/BSIArl
 XkpNQ0QudckLw/9OQS1nE0a8oV/tnP9JnBDJa3EibN9XD6MYHTn9CywbUWb1y39GKoqg
 M6INSf4/nXquj4IK1rbhYPBha5c/NJ0GJqzJRdqS3/CSOHyU21GcFdUXJapbDae+AMUV
 FMhBBbc9WS2l2xyy/ZO+/2IPLGu7xuOK+KvumV7M+4yTLkADHXWNzu2Q4OAXCrhnCJ2d
 1Ic8gUGBcHcAYb0Wxm7uXipoZTmrjka6mhsAJeVyxWdnXghbzGs0qvD50Q2a7Ll+cUuj
 QVdg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3AM100S2NrU4f8EnOINBXnjO+l2X82fjadZPtJj2j/oMfbNILUogxowGjzeQknjorrCZC3j+3O10e@nongnu.org
X-Gm-Message-State: AFuF++mInW250HqsX6oBYWFN2/i4p4yKOZSfXcngeUa5AXNU07e4q3x6
 jUKaB4kg9QZ4T+Dvl6bw/G70qDSfvRsHf4Wc5FQ5a6wOwB/K4YR+y+d7UNTYXsNQspQmK7jpGOl
 aV/OeGBZEUYVUbIqgteF1lALuHx2ovyH+S2C/zhzMSp+CBjbzyrYskOOR
X-Gm-Gg: AR+sD12Dbf+75fsLQWUdAf84GZy7dPU09TOc8VnuduCXnbeG54VFf3Yj5HbhgRzxMas
 6MaAriQudE474BFYMIQmTqf/0kaGKwo63LXvPGkhC/Le6tZFVncVmoHMVLoCVBRx3LhqpL6y/2q
 XgNBj73Wx+VNy8mSSHaJhQyKSXDFLHi7aBAn8ygwZnRi6Y9EljH+f79o63m4q7UszjJQlA/+iSR
 QMPlMeL4hURQXZ4w8n4gDWMbeM6RMz5D/MeUTxVl/7lZHJ+rXnSZ4pe+MEdeNSkuoId5vlaI8mM
 lu0BGKQFZGWKD//yj2y/5BbQul915hwP719VWtczAfW6/4dFTYoY3morQf526XPG6fZqJfF9dPk
 +6lkhygaHIPLKuSsatZS7Dn4XOHkz8iTLOAD16jI=
X-Received: by 2002:a17:907:97c4:b0:c25:6e17:9b4 with SMTP id
 a640c23a62f3a-c256e170a28mr1236351666b.24.1788185269275; 
 Mon, 31 Aug 2026 07:07:49 -0700 (PDT)
X-Received: by 2002:a17:907:97c4:b0:c25:6e17:9b4 with SMTP id
 a640c23a62f3a-c256e170a28mr1236346666b.24.1788185268714; 
 Mon, 31 Aug 2026 07:07:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4?
 ([2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee09f4dsm466979166b.6.2026.08.31.07.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 07:07:47 -0700 (PDT)
Message-ID: <fadc5ecd-f939-4258-841a-e80f488c080e@redhat.com>
Date: Mon, 31 Aug 2026 16:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/43] qapi: convert trivial intro sections for
 vfio.json
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 linux-cxl@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>
References: <20260826193840.2152000-1-jsnow@redhat.com>
 <20260826193840.2152000-6-jsnow@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260826193840.2152000-6-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/26/26 21:38, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/vfio.json | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/vfio.json b/qapi/vfio.json
> index 17b60468712..3d61fc38ecd 100644
> --- a/qapi/vfio.json
> +++ b/qapi/vfio.json
> @@ -49,8 +49,8 @@
>   
>   ##
>   # @VFIO_MIGRATION:
> -#
> -# This event is emitted when a VFIO device migration state is changed.
> +#     This event is emitted when a VFIO device migration state is
> +#     changed.
>   #
>   # @device-id: The device's id, if it has one.
>   #

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


