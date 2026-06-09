Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4682CD8CAE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 05:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWoeL-00019p-1O; Tue, 09 Jun 2026 01:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWoeI-00019O-2T
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 01:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWoeG-0004zR-DR
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 01:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780981510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jS7UYgs6bH82wjNz1oXUdV0xpbKiRNl7p45AfS7ZBNg=;
 b=jRfVyAYm+1QsmjzVHx/+nQ+41NOkhp/VNLTOFQyrcAAmedZBfTaFv9m+ZgboOee6CGkaky
 WADiHAPg2sGMKCYNvt0tdWRxuONw41XQIbr7eJnU1KL+mWlqVoEjpvtPcLD2eaOPi1RlQO
 UIVOk9zV+i+XIr8gDnRdTa62Boqocwk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-r_1OyFOHOYejK7NMzIk8Kw-1; Tue, 09 Jun 2026 01:04:23 -0400
X-MC-Unique: r_1OyFOHOYejK7NMzIk8Kw-1
X-Mimecast-MFC-AGG-ID: r_1OyFOHOYejK7NMzIk8Kw_1780981463
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490abeb7298so52084045e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 22:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780981462; x=1781586262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jS7UYgs6bH82wjNz1oXUdV0xpbKiRNl7p45AfS7ZBNg=;
 b=tr65irWfSMd3zpLlLqTNjy/j72tHDD3z50UUb3iCP0JmlKjHmx+SIB4HbpnH1Pj9p1
 2wdb+xJEr1WFVW8uhlq+vEYErAvl/MBt5Fj/P0ENQativ9dDm6jbx3k8ODBKENcc1uRo
 Tnj4113OzslW7FmYthiQfGZ/m/929zdOI6wJZqo3EYlVBEsjTSi9l/nGOoCvla929UNX
 nCQocTgIMvn8UwjDWm81hjuFh+X+v1RPf913e+W1uF4PzuLwLTfAP6bYh44N9Me+Cc+W
 pa+hCLYycEB3r1NXWdmfhsfbVca1jj0Kp0Qj6vMUoSavv9myvQ9VoWyDgJT/v1fCWA5n
 u2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780981462; x=1781586262;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jS7UYgs6bH82wjNz1oXUdV0xpbKiRNl7p45AfS7ZBNg=;
 b=XodGXCy+nBEghTGQvTUTr+TxN3klQA08Bq+1FKQHhBvU5sZkQrMyFya2vdfTRiWUyk
 Dc1IA0SKjstn7wZ3/5TtZTZ5paArqJzXNMTBO/knchP0p4+e9XhD72tvSkqtP4B9QTDb
 dz2Ua8TYGQq7QeCuYvVtAHSj3niqKgQpimIIyZO4TGK1PSgsdKn3HOZqCIayvnB50OoZ
 cvom3+pg5DbASpg3Ayl+lUulR6PQL93YOXloXNqxfugeaBrtGv4nrS/bXO9AILEu/Y1q
 tFEGYxPygS/lyLkpQjFdT5tf6G6H3EUiX3nd3FiCi7zYuxuG/FikPcLaTK2mqPvc/f3q
 Ypng==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5zLh00muCRxiOkIGAPkdTGB4o5zpoZiERmVjsWQqh5rgzLPv/oGfA0Unn17t/LZuiEioH1YHWzvq2@nongnu.org
X-Gm-Message-State: AOJu0YyNoA82jtbXH4OBNiAttAFKQ13KJR6Fiqbaztynr4xl/CNzSAhE
 Q0ybZB6KtlbK0FSw+A0MO15D8r0TktJCRoiqRgu3JEQeByRBq1IJwJWN+2xLmBavvCWWPFQCBbF
 jRi+zEuAQabDOGdmAjGsgYg+fdOSlj5pIgUvr8HDhLLcgEbDOqIgZVqd5
X-Gm-Gg: Acq92OHp/IFffb6FMzt7yFE48PQgfhWZu15gEBaW+AWLYiwxU7Zw2WK+5lm0s+5M8UY
 Llr/ui6sN13vy2mZD2t0H9rqihxLQFfhsmPU4rW00nHJ9KJtQpxFb+g7I19cEVdwfhk2IAV8cRs
 ot+0PPshg+Ys/M+sFHSTBUU90aDwfODokQ4vC45ZHYJpQ/3XZqVslXBpVvVxcD933DkEAhcoigB
 BpHrzse1WUp/tzfNs/FqP3CIOlMu0E8l9ugXb5Z+uNibQ6RAe6H8gGYoiCJBZJV+XhMwWEO4kYi
 2oNetqQYb0aUIAnrrZbNgWhgANxMPwXiZn740dlXkRMp5rrgx8MHDejIUwfAuBn3x1mg+gFUrAX
 85zWHT0+y1qDw2WEZfNMTnyWUi1YyZlYaG5EywVjmZruBdFxlt6Q7Lhf7ZucO1Il/GPDrhQQ=
X-Received: by 2002:a05:600c:1f90:b0:490:b00c:8e6a with SMTP id
 5b1f17b1804b1-490c2602971mr311523395e9.28.1780981462652; 
 Mon, 08 Jun 2026 22:04:22 -0700 (PDT)
X-Received: by 2002:a05:600c:1f90:b0:490:b00c:8e6a with SMTP id
 5b1f17b1804b1-490c2602971mr311522965e9.28.1780981462213; 
 Mon, 08 Jun 2026 22:04:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d5d2b4sm293725405e9.2.2026.06.08.22.04.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 22:04:20 -0700 (PDT)
Message-ID: <98c4fb74-52f3-4d1d-a236-a2f92bb1ce7b@redhat.com>
Date: Tue, 9 Jun 2026 07:04:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at
 load time
To: K S Maan <kirandeepmaan45@gmail.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20260608134559.23971-1-tomitamoeko@gmail.com>
 <20260608134559.23971-8-tomitamoeko@gmail.com>
 <e5927d36-5947-4c0a-a165-e07c426568e5@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <e5927d36-5947-4c0a-a165-e07c426568e5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello,

On 6/9/26 05:05, K S Maan wrote:
> Hi, thank you for the fix i just tested v2 patch on Haswell platform with legacy mode guest where grabled screen of gitlab issue #3093 is fixed and regression it introduced in [Patch v1] for UEFI guest about romfile checksum is now ignored, so UEFI guest grub screen is now visible and no VBT table found issue also resolved, both Legacy\EFI guest i915 dmesg logs are clean now.
Could you please reply to the cover letter email with a :

   Tested-by: YOUR NAME <your@email.addr>

Thanks,

C.


