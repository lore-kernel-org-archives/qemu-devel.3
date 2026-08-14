Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31387C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wum3B-0007rk-PX; Fri, 14 Aug 2026 03:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wum3A-0007rb-AA
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 03:09:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wum38-00062o-Ux
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 03:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786691394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gM9okrigd5sXPiDlWQjW0Jx3pfnj4AtEr5g3TopqvzI=;
 b=ONrqvAMyZ+dJ6H3+4wMULgahLEh2qHqwKOmzLrm6B7VP0dvNkcha6iX5lEyySE8nRgw70d
 qbxvrfX787gRRrcKAx7OrBn1LfHiMEtaargkvjDxJfTkm6Nr1uyVI1htIpY2BliSuKMO5g
 0aP1XcEOTsvcR+1EL/wMr8JaBA6nSWo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-lYJMPQSYOuisfIvXw5TaRw-1; Fri, 14 Aug 2026 03:09:42 -0400
X-MC-Unique: lYJMPQSYOuisfIvXw5TaRw-1
X-Mimecast-MFC-AGG-ID: lYJMPQSYOuisfIvXw5TaRw_1786691381
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-472c330e555so262444f8f.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 00:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786691381; x=1787296181; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gM9okrigd5sXPiDlWQjW0Jx3pfnj4AtEr5g3TopqvzI=;
 b=nttM6CAe6+T53Sg3deqHdToh7sLgflghRcklwKb7CHB965KMDux9hpejxtrc+WgHoo
 fYc0jVBaaXvBAF1HXvmcskZY3JGYxJPRvREK3oURjFshIq1vGMeMYE5WCN2ZB9Jz7LUk
 l5irqlQyRzbmJzvCyoxcurg1W7tbXTcGn08HZu6AzCeJ56p/yaKg0NuX71Yec0Yg9P4b
 fqWoQIOtr4uXXMdpvI5LeM2lkqotQ1PeKWtPU5rPifmlfg5zyGwylD/gxgzttrYD24c/
 wlsUtKidmD5sVGgZekL0qyJgp0+06hybO7fQc9H6ZeacXIg3KuDx1u4ixhMwZYgp+h5f
 m8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786691381; x=1787296181;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gM9okrigd5sXPiDlWQjW0Jx3pfnj4AtEr5g3TopqvzI=;
 b=INGeTCHY1VCdBk4VmUVNw9YZEDsciwOiu39Z+ANZrU+5Zwhe7ntSp34j7OPciElOQg
 6mXyyV1Z/RV5r/B6zVV3prE7mGWTthYE/3mYkfl2v237Y+EZ3qbLGn4EHZzCPOZwByMf
 GaTo5nddK7+knzFdjgcTZEO6fYkcZImhl8GuczB7PrOJjdB+1H7QH8BEPCKpBeEQR4hH
 8fcwgpvL5mtrQsUEFYzbsJILy7RKUj7ezKj5R5JZ8N8k0FRo1Z/370aH7Mn1VWw72vvK
 gU9dHJIjmjPGpocWePdjkFc//GUg5otS+aXCYDfrqvKqmXLbKy544wu/HZlB3HLBKf9W
 xUMg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXdNUw0CUymhF9DQNB9WLYZjJms/vrqjs4+kKtOEsWDmyvgCt6MwH40eUCjsBK1fyOxMJUN+MrCjqC@nongnu.org
X-Gm-Message-State: AOJu0YxJDVOf5ZJCdp/yKMWqgX3GQs0fIFOkkQnzC6sWWlSn87eJYMgH
 Wukik4zD38SYPgaqZVzDh2UkozSJubK6wJwCmuGrT5vx6CveZHbe7zqYhHlHtf7E2FG1TrgK/y1
 2niL79C3dEoVffylE8GLpictq8Mqoyb0C2Y/ZHCt6eFhBebJfkl6cCz0J
X-Gm-Gg: AR+sD13YBuDo0wfPN7+OsiDn4/6niuRT14yUwBe4jY5nFcXcgaRy3H3y86FluZAwMvc
 nHopy80wHNkLdg/maaSTl9w1GjCB3in26TGRnNzii8dhTpIuRTgwyD2sAvqDBs+XQJKDXfUUYwK
 txMQwy28HF89CJdHruXichNrtcoBPT66gho9PVRpXxlaHeRlyi+okkrgAUeya3PNMJsJ15CKxoD
 bNTo43RzYexRQqs7hRPbtFOxdL+wVoqUsXoeDwxWf9plM26WtJ4ZPMPCYKzMUOBYmf8dabIIZxO
 pmI84f6Q03QysUq8hBkIkV0GfVvcf48Tm5eIVz5paWhyssg6XK9RDbucKlvqB3D8a0rIf1MS
X-Received: by 2002:a05:600c:4295:b0:495:5e3d:15e1 with SMTP id
 5b1f17b1804b1-4998799e0f0mr30034175e9.16.1786691381264; 
 Fri, 14 Aug 2026 00:09:41 -0700 (PDT)
X-Received: by 2002:a05:600c:4295:b0:495:5e3d:15e1 with SMTP id
 5b1f17b1804b1-4998799e0f0mr30033735e9.16.1786691380923; 
 Fri, 14 Aug 2026 00:09:40 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.27]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988aa2273sm25571495e9.0.2026.08.14.00.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 00:09:38 -0700 (PDT)
Message-ID: <5fbdbaca-02b8-4772-b786-180c5e884dd7@redhat.com>
Date: Fri, 14 Aug 2026 09:09:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] tests/testcase.py: passthrough monitor_address
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com, mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260729093146.1893719-1-vsementsov@yandex-team.ru>
 <20260729093146.1893719-5-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260729093146.1893719-5-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 29/07/2026 11.31, Vladimir Sementsov-Ogievskiy wrote:
> We'll need it soon to implement test for cpr-exec mode of
> tap-fd-migration.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   tests/functional/qemu_test/testcase.py | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
Reviewed-by: Thomas Huth <thuth@redhat.com>


