Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617D2CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 15:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uve2H-00026F-SD; Mon, 08 Sep 2025 11:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uve29-00021L-2p
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 11:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uve24-0006Lp-OV
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 11:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757346230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=22+7tnTQEOBpRkEwDFkpmV9p8xLXN6CJm8/tz4g0+Ek=;
 b=Tqdw5yEJtJXLpVQDFkYKQvI4PEUcWkeAifPpxGgCIho5YhhU3KtZs2aTcgtT4kLaf/iUAD
 3itjfgTcAbphbTsgroiIGy34q4ZdM3frgnMFjlty2hcuboHAYjqwtiViN2u2I6vhKdwLoM
 f8dY8s9/IzoZPMY4Q+m9Zq9iPJiJ+aM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-Qdm9AdzPP--HXFixHLYeXA-1; Mon, 08 Sep 2025 11:43:48 -0400
X-MC-Unique: Qdm9AdzPP--HXFixHLYeXA-1
X-Mimecast-MFC-AGG-ID: Qdm9AdzPP--HXFixHLYeXA_1757346228
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-807802c9c85so1172624685a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 08:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757346228; x=1757951028;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22+7tnTQEOBpRkEwDFkpmV9p8xLXN6CJm8/tz4g0+Ek=;
 b=n28uq7bdRonyou7qHNehZb7V1TWudfFvz9mApPjq07ln/xbhFyZ/HSPWu5CrzK27ev
 AkjmdwkGsi/D38d83Gxh1Fo9/evRoMgq6ocgKvytjR/YrPJimcnxxKVUy24zKxfdbRKy
 2XdPXMRwljOk4efAEvtfxvTE6skjMba9lKOYowRKUI9nccsut2YIlLb8VZReO/yaRgmL
 UzITA07C1HEwI/rxeYwIMHJ0tXMjkHFGqeGKPgLMX87aBQX7RuWPz+OzE4GW128HWVvW
 m+VS/7UifnB+9EXqnxEFxogE8Mu7i2TOJcYUdz2RgseaN1Dc9VcStqtVKZtr5GWoDPn4
 5ZaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdLtyp9qbD0cJqnnc73F5tWxLUDs6h+5JMuVIyRNegDnoVyKhxWlZdgrorJyLDBS6+V+aWIxItbEUT@nongnu.org
X-Gm-Message-State: AOJu0Yw0YseN7Joq6OMTdm9JkHJeUWtDz0VnURGtwz+1lrNhSP2RkL5O
 b5kQuK11cZQu/zLeAznZ/OdmBISuXfnHYT1fAib8jBROu1ZccyZA0zn1oqQdiNUsPlKBaoomvYH
 +qyKcS+30TN7qGAQiGj9zfU5kPgOqfN9SaHiohrXnn6fOrS1TfwXLwjmQ
X-Gm-Gg: ASbGnctnwCwnt9g1WfoNEtSoyQBkJ28QbZYpbtJAJNN5CTBJALZPhBsJjFeOjzk0M6t
 yo/acBKW5INEd51XIB9NNEvpkDtL9c8oiXM+EZd/NUXETI8nkARMdlhyQ169JoJDQoNikLKkr2S
 aAHtAym7fgAwnH1DXkSgzmw9vqCfhH/gTq9x4fZmbey7P6bbIJ7xfVR34ggyWC4mVarQr34M9e/
 3b9THGo13HDt0UaEuw2NNke9WaJ9UqGZ7E3Qeh657AAyrdGoZeiIWASEDUNwA1/beZF6L0kdEGA
 TMUfxKfizWCUnIlARYajKFCRJtN4LuYf9D7g0zGj2Q1lCp8yWsbKLQJyUR5sy0mXE6uApeodaZA
 yOU5q6p60UmOvk5My7zUD/g==
X-Received: by 2002:a05:620a:1a23:b0:810:a206:7e0f with SMTP id
 af79cd13be357-813c0d092d7mr875249085a.26.1757346227862; 
 Mon, 08 Sep 2025 08:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQS0pK2V1XM0husk41Q8iHOu1C3//SVnFhfiEMrSA1NN327jU5r8UhMTKPPqmv4els2etDhw==
X-Received: by 2002:a05:620a:1a23:b0:810:a206:7e0f with SMTP id
 af79cd13be357-813c0d092d7mr875245085a.26.1757346227303; 
 Mon, 08 Sep 2025 08:43:47 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-80aa712bc92sm1088982885a.27.2025.09.08.08.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 08:43:46 -0700 (PDT)
Date: Mon, 8 Sep 2025 11:43:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, mst@redhat.com,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: Re: [PATCH v3 6/9] virtio-net: support local tap migration
Message-ID: <aL75seOzauBDqk5j@x1.local>
References: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
 <20250905135039.2202924-7-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905135039.2202924-7-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 05, 2025 at 04:50:36PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> @@ -3525,6 +3609,15 @@ static const VMStateDescription vmstate_virtio_net_device = {
>           * but based on the uint.
>           */
>          VMSTATE_BUFFER_POINTER_UNSAFE(vlans, VirtIONet, 0, MAX_VLAN >> 3),
> +        {
> +            .name = "tap",
> +            .info = &(const VMStateInfo) {
> +                .name = "virtio-net vhost-user backend state",

Just randomly spot this line; likely we need s/vhost-user/tap/..

But of course it'll be much better if this can be a subsection, as
commented previous..

> +                .get = virtio_net_tap_load,
> +                .put = virtio_net_tap_save,
> +            },
> +            .field_exists = virtio_net_is_tap_local,
> +        },

-- 
Peter Xu


