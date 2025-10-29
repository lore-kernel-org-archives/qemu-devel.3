Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E42FCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 11:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4GK-0005ea-45; Wed, 29 Oct 2025 07:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vE4GH-0005dj-8Q
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 07:22:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vE4G7-0007HN-SX
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 07:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761736941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BQcCOHUvTVxWph8l4h6Lf9bJZ+ViaRDcj/sZwb7Kj/g=;
 b=g7ex9zYuJb7aJA0+oqsPVDr2w/X3ll2U3EoA9oXkDXTBweB0pkUsw0mit4nGiAjffpV7Cf
 Dr3ru+M6hPDFix9uL9jmcr7oup892LrYXElOga8hKdk8OISmc9BUGU8q3IcoLgvAI5Z8qz
 yP3Kpr9pN5ihjwJuoaf2nIHwBW3cIkM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-oRCmuykgNba2iRFJImp8LA-1; Wed, 29 Oct 2025 07:22:19 -0400
X-MC-Unique: oRCmuykgNba2iRFJImp8LA-1
X-Mimecast-MFC-AGG-ID: oRCmuykgNba2iRFJImp8LA_1761736938
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-429b2172196so172459f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 04:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761736938; x=1762341738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQcCOHUvTVxWph8l4h6Lf9bJZ+ViaRDcj/sZwb7Kj/g=;
 b=EEDnbBrSVXq8qlkq2BbrAUL5I60urzSEQfE/xjAH0op1ZKH00Yq42SQMBoxPAURgFH
 aWkilzbuuYHEocGqGkCa9nYVRuaaDbVscb1RXWqV6kdPCi9kCDCRZh+gqNKxQFRBB81Y
 Uc3vov1ep/m/LuoJx7W71BaQZMv2v3CjgKbB4J/rWrYbpJX9ZI2OvpLmPmu29tzqs+Dt
 0qYxdWq9UP0+rqqvA33Qsj9Mqn+stQwLOyQYy+zrbzQjTK29c3q6zCRu8vBV2rlgJ1dX
 imPpSkM6K5B07sviTw6gLyEC9gEMhOYgHzSL8XyJQMlzG+WOkozjv2gYW0R3facvbC7r
 8F1g==
X-Gm-Message-State: AOJu0YztjjoYsw0ILX3R8qMTaz4+f4jWLWu3nFhZ3tggvQlntoXNK4q2
 7tTO+Hp0vPfXMtRNQrcnAhfBFl8IWP7YKk1MgiVHyE2gZFD9+blwD/zgv4t1aufREsDYYpjYaeu
 npV2wrPt0ujsMcqXdKvVjb/n5H1mmTrqV4acsnHtqNCPd03EQi7N7kPIN
X-Gm-Gg: ASbGncvzmuhfipcvnx4z9WujrWewPAngLOBtlGD7KyOrUejQvlXEcnVh+DINmUqI2dz
 mp6WsOUrUoCDSCeRAKSsKJL82gwFFvcMSMAmprzkKBzdjWKRi38u6Q52IkictCP/eI3vKxFWXiG
 nNSwCx++ELVqVAbFkXegElaPnauPXhSvDUj9+VGrtsBA5r2rF9vx7v/C93n/yWGYM/WxvVraag9
 5T7St91awTUpycJvybdKKleTtasI9bIIuKq3yu8iCM8LHfYadVxI5oF8rP50yGd3TMFyHO99t4K
 qAxsC4SNSXFtq954VnfGFBLoliQzfegPJVimvdPQ41n9xWBG0I3QkmQ5JuDA8R67CJY3NPBIcki
 1CTMuZoI1kyyQy8wqpqqf+muP4X1sBg+ZbMlCkVitjfcDaVkWwsc=
X-Received: by 2002:a05:6000:2084:b0:428:55c3:ced9 with SMTP id
 ffacd0b85a97d-429aef80135mr2157533f8f.22.1761736938481; 
 Wed, 29 Oct 2025 04:22:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm/BzqiO9S9rlPBTCjB/Oq8kpvjVxc/l0jKMEIYpB+6GfaGAG4m9/xpWX0X0DcW83pfokb3g==
X-Received: by 2002:a05:6000:2084:b0:428:55c3:ced9 with SMTP id
 ffacd0b85a97d-429aef80135mr2157517f8f.22.1761736938030; 
 Wed, 29 Oct 2025 04:22:18 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df473sm25758306f8f.42.2025.10.29.04.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 04:22:17 -0700 (PDT)
Date: Wed, 29 Oct 2025 12:22:15 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Roy Hopkins <roy.hopkins@randomman.co.uk>, Ani Sinha <anisinha@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 5/5] igvm: add MAINTAINERS entry
Message-ID: <hyvhf4cggtfzo67zvs3mdkuf2mur6d4mn32on5qqvrsluhydju@jdvney3ihbbr>
References: <20251029105555.2492276-1-kraxel@redhat.com>
 <20251029105555.2492276-6-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251029105555.2492276-6-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Wed, Oct 29, 2025 at 11:55:55AM +0100, Gerd Hoffmann wrote:
>Roy Hopkins (the original author) does not respond, so the new plan
>going forward is that I will maintain this together with Stefano.  Also

I confirm my availability :-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>add Ani as reviewer.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> MAINTAINERS | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 64491c800c2c..a79eb495d047 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -3906,6 +3906,16 @@ F: roms/edk2-*
> F: tests/data/uefi-boot-images/
> F: tests/uefi-test-tools/
>
>+IGVM Firmware
>+M: Gerd Hoffmann <kraxel@redhat.com>
>+M: Stefano Garzarella <sgarzare@redhat.com>
>+R: Ani Sinha <anisinha@redhat.com>
>+S: Maintained
>+F: backends/igvm*.c
>+F: include/system/igvm*.h
>+F: stubs/igvm.c
>+F: target/i386/igvm.c

Should we also add `docs/system/igvm.rst` ?

Thanks,
Stefano

>+
> VT-d Emulation
> M: Michael S. Tsirkin <mst@redhat.com>
> R: Jason Wang <jasowang@redhat.com>
>-- 
>2.51.0
>


