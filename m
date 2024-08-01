Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A47C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 07:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZQcM-0004YW-D9; Thu, 01 Aug 2024 03:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZQcK-0004XK-Um
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZQcJ-0004wA-Lo
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722498775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cxy2hibFYZcQeb34hxUIT47sx1u4r1h6Fef4J4d4X3I=;
 b=dEU+W/rd/cTnMS9C8DWQ7Tu8j9ajQx8QWkXxB4LZP9GL4LcLHTrcihvTtvDIwsRgQGervq
 AkolTtHJwcmoLUmJ3b3ql4vcswinSGMcC+UFLGQDfUWMIRLiVUQLvfFcfm69R2kgBVPgj1
 qo126oIlReJR66M9zHij2NQCFuBgMx8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-REEAMrTIM3GC-4zGxLGlOA-1; Thu, 01 Aug 2024 03:52:53 -0400
X-MC-Unique: REEAMrTIM3GC-4zGxLGlOA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7d2f42df2dso244567666b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 00:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722498772; x=1723103572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cxy2hibFYZcQeb34hxUIT47sx1u4r1h6Fef4J4d4X3I=;
 b=Zjksn/NBFLufrSRWUNm39ThNzB8RD9waJBuHoAcSzeGP+XJmmxfGzut7os0PUBJRhO
 STxLwYgbSomwduaxJ0tBdnY2uvq/ZDAH2pShElQAJZq12GJF1m/Bts2TzSNyHfEc4vzg
 ecPPH39fp6+F5QceDN2pld/Kch23ugPeHh5hwpQdzHZXtMYsYp3tHl1+KrqCDc4WLtOz
 Ja4xw0eiiRHsWwZ4O8/yOrWHt/+9GHy2l/4QPBFM5+MME+CmPQ5Npaz60SqzUBhivvKK
 Ny6JX5s/IOft1aG9SUDkOQfmsTPOAEEwNxwOXemRFdJ9JIfG8L8ncDbhihRz8NhUuq1M
 7dOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9aYyInp2kJthObocX6GGMUqyYRQiIOylASK5BRHhLsqYEt+vzXyStz3/XjhzieHuaADkvJNXF1ouiD7IhOzbwiUPO740=
X-Gm-Message-State: AOJu0YyQ8kaAOYqd4WLC1GdJZy0zZy36Gh6yzgWXcxVm/lYOdHuJkkOa
 9AM88ImnTenevS3tzay78ykE7eTuMX73/fv2U/LQ4/VPG8bmbzGC76+x/Ssjvi61I2GUJIpb8/v
 cnigODzpvDglShIu9AGmsYoMmwc+Vs08TgOAmUPO3S8k7ukmIIa0w
X-Received: by 2002:a17:906:6a1f:b0:a77:ab9e:9202 with SMTP id
 a640c23a62f3a-a7dbcb903e9mr44376866b.4.1722498771798; 
 Thu, 01 Aug 2024 00:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTJc5GY6Iq2/SM4NowoO6tBmg09aOwnGkBKl7+9qNzl15iM7x1fvO1To2vt//q64G5ARbSig==
X-Received: by 2002:a17:906:6a1f:b0:a77:ab9e:9202 with SMTP id
 a640c23a62f3a-a7dbcb903e9mr44373766b.4.1722498771062; 
 Thu, 01 Aug 2024 00:52:51 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acada2b1asm864476666b.158.2024.08.01.00.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 00:52:50 -0700 (PDT)
Date: Thu, 1 Aug 2024 03:52:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto
Message-ID: <20240801035118-mutt-send-email-mst@kernel.org>
References: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
 <87a5hyj71o.fsf@pond.sub.org>
 <8ee4464e-f9b3-48bc-9fa3-0b5f0d2a5faf@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ee4464e-f9b3-48bc-9fa3-0b5f0d2a5faf@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 01, 2024 at 04:01:44PM +0900, Akihiko Odaki wrote:
> rom_bar_set() and and underlying visit_type_str_preserving() are ugly, but
> we can remove them once the deprecation period ends. On the other hand, if
> we don't make this change, dev->opts will keep floating around, and we will
> even have another use of it for "[PATCH v5 1/8] hw/pci: Do not add ROM BAR
> for SR-IOV VF"[1]. Eventually, having this refactoring early will result in
> less mess in the future.
> 
> [1]: lore.kernel.org/r/20240715-sriov-v5-1-3f5539093ffc@daynix.com

I don't know that this should worry us much. Is there some project that
requires getting rid of dev->opts for some reason?

-- 
MST


