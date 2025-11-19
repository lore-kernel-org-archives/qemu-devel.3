Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53164CF2566
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 02:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLXae-0004ZN-AR; Tue, 18 Nov 2025 21:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vLXad-0004ZF-6H
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 21:06:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vLXab-00062s-8m
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 21:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763517990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4LUmZiZ/syqPCxXhEaPhv6G3lKaDrUVbAaZpoFcJboQ=;
 b=ctVj7qbTWFeAEDjJhC52eX+3xoXIL9Djx8HbTAZgqGJaaSJCy/o91KivFExwei0NKVrlOR
 OJMdhKUoiOI7sdJEP0kZoBOpJy9pJh+cyNFBegC4NxSE2wZ/yYwE25/FevbIfNc2P+uIj3
 7U6zb1cnnOtIdSRpTMkaawzN/f6gmBQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-xl9AauhWPXmRCW5rC7PqJg-1; Tue, 18 Nov 2025 21:06:29 -0500
X-MC-Unique: xl9AauhWPXmRCW5rC7PqJg-1
X-Mimecast-MFC-AGG-ID: xl9AauhWPXmRCW5rC7PqJg_1763517988
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2955555f73dso73681145ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 18:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763517988; x=1764122788; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LUmZiZ/syqPCxXhEaPhv6G3lKaDrUVbAaZpoFcJboQ=;
 b=cPkQW0GtC78tQb0GoAiipqOk7v2DPrNejMK/FVJpzlle2E7ymZLuJplkq33eJ5/DgR
 fzH13cRy+4cXXfE9NnwUoY3h4/cLVip6VskIqPjA4PKLPJHiyHATLiseBux6hZrGeFBw
 u1ohWYdGUpV3wT9YEeGD7WLgh7D9fWy0QWE6oywZ38ijy/4rQP222XKqo4QxX9HVIinW
 TiuX3352qR1xgQQxB/JXw+Z7d0bx1kYEd26JZJBarURSvBj9vau3aEsQ0XMe5gzpu8/9
 bh9h9zINkWqovHf/mB5GoiDBd9+J9aNjfPE9AhwtAUlOUxHSvAwgPG5yMSA3G/tlk9GD
 IIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763517988; x=1764122788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4LUmZiZ/syqPCxXhEaPhv6G3lKaDrUVbAaZpoFcJboQ=;
 b=TU1x+6RREYiSTXciQm3rstRzGSZP4aBDbn0H+O1aA3SvvOEXAGoMESEUqNufBZM8RS
 IY7MN+KBsZSOrRVkk3od6iEXoa+/RfS3qucm1iQt7Him/Pmgho40wcJXW49IuSLecYaI
 0VTgW8rPvMkMTdcazgKcwm56GA1jDvBawXFCuM5m9Ul8Q5MClJMetyYerh3Kr2URpgV3
 KSN1bqkTGuyQeXneVT8+Fjg30PprErWMQG80gfluJn2NpPWN3uRTy7kAYSdMQrLYeCJm
 wwoBuj7QmuZLeMSOw5+9osKVkCSts5VWCbgasyVWNB6r3qS0qBiY5OkpnfYuN2Me9LAk
 YH9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhX2S/yWT9qIBwZxLs0fjuIVGIaMzezm5RVzM704X0ZG+LZjnYyI3wn9j4ufRrgFPniM/myie2QasR@nongnu.org
X-Gm-Message-State: AOJu0YylckEq7IiYaGF/qL6CYd7pQosTOfOB0i/Rl1p3XaweNhw2YS/V
 gU0FxwSUzHinC9vJqzWC34kzI9IIKb7CthPNyZ8IFICg13VChAj2wXvLZ3T8RuEfMMuGKF4iOtw
 Rr8g661Qx19GMJGvN73lOM4nZn3BsNnpKvqd11Nmza/uu0iUqMBteWv9doRhsLF6QEeXWeIig3p
 /9k3byr2USi3hxtrPOFo7Ro9j3PZf8xXk=
X-Gm-Gg: ASbGncv2ASSsNEsyh/oymtCGq2bhGyWSBNuBTpGJW8VXWJQO20NUih7W9bJ/CQyiElM
 tFUdO8OWjlZ5Eme+5tpRVyENh+2OJH0tpn7kOhYJc9hAGPiPnNZf/66Q/1LGw1J3OurKmnkkzXO
 OmYXly6v4ATJUQs1zf/cZVc5hbEDaQhSNbJ8l1CtUcg6iL3UnhkMzUZ/oNeAKUrjQ=
X-Received: by 2002:a17:902:dac4:b0:296:549c:a2b with SMTP id
 d9443c01a7336-2986a6bad08mr228983545ad.3.1763517988084; 
 Tue, 18 Nov 2025 18:06:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6dLUC7FheOhaLgg6PbtImxoLD1QsMxaDpDZjVy1TKWAhi0PilJ0tzO3PZfqwcM+fE/RloR6vWZXzGJCuIMoE=
X-Received: by 2002:a17:902:dac4:b0:296:549c:a2b with SMTP id
 d9443c01a7336-2986a6bad08mr228983145ad.3.1763517987621; Tue, 18 Nov 2025
 18:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20251107020149.3223-1-jasowang@redhat.com>
 <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local> <20251113114710-mutt-send-email-mst@kernel.org>
 <aRYRhg7lKDCBUIrf@x1.local> <20251113124207-mutt-send-email-mst@kernel.org>
 <aRYyTeNNIPW_WIJW@x1.local>
 <CACGkMEsZtgmreUbd8BJQb9V7V2Pw-dafjLao1aVxPowuM3LHng@mail.gmail.com>
 <20251116014436-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251116014436-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Nov 2025 10:06:16 +0800
X-Gm-Features: AWmQ_bmNl3_4zxQvKbYHBYj0-XkMhDAgVoAwqs85TUsLuV8WaMKNNWFtmHB24c0
Message-ID: <CACGkMEtgvfnanNQYejO+7f_by+04HsNNBBNdT+iot9_T3i2nUA@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 qemu-devel@nongnu.org, farosas@suse.de, jinpu.wang@ionos.com, 
 thuth@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sun, Nov 16, 2025 at 2:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Nov 14, 2025 at 09:51:00AM +0800, Jason Wang wrote:
> > > So IIUC there will be a cluster, it may contain different groups of h=
osts,
> > > each group should have similar setups so that VMs can freely migrate
> > > between each other within the same group (but may not easily migratab=
le
> > > across groups?).  But I don't think I know well on that part in pract=
ise.
> >
> > Towards this, we may need to develop tools somewhere to report TAP
> > capability. Or as replied in another thread, developing software
> > fallback for new features, but it seems a burden.
>
> Or more generally, host capability from QEMU POV.

Or you mean managment POV actually, for example TAP is usually created
by libvirt.

Thanks

>
> --
> MST
>


