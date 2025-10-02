Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F73CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 18:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4OLd-0001Hf-9N; Thu, 02 Oct 2025 14:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4OLR-0001GJ-9P
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4OLJ-0001ZA-NV
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759430864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fZDaXiMsFrr6YOoS1pXzuQ2ws8ybe+9bubEsNZvkZSc=;
 b=EmDZ9Oy8hyECE4dTrAhJCv+yaKptiom3uvq6nheGtKrmbGvDW1eq+n9Tz85VFVFQnp453V
 XfZFG0rLuS2AzYHeUaZ9JUTqBnIBeN3/7Q03gHAAlzNNA4IqSsNVdxlikGdWuK0n62BwA5
 NbtjARJkAlJDhRgf23J2YhVKklv+7Uk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-v_lO51PWN8KrxetXeQuZtA-1; Thu, 02 Oct 2025 14:47:43 -0400
X-MC-Unique: v_lO51PWN8KrxetXeQuZtA-1
X-Mimecast-MFC-AGG-ID: v_lO51PWN8KrxetXeQuZtA_1759430863
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4de5fe839aeso33799651cf.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 11:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759430863; x=1760035663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZDaXiMsFrr6YOoS1pXzuQ2ws8ybe+9bubEsNZvkZSc=;
 b=EvQtZCsmBr9W3djANc+Hy7evsVpj3ljNJImG13kiRvzWBRS/Y4aD+gR9ofGddBPtTt
 m2zx61jBZFSmLkobt2wpWETfK/6siw1mGNbWiq7PRc9ZUzyhC5ysMAkQMMWYfroDPnV7
 lkZ/LFBdInA00c+R7elnHLjWKBCtiV5fhwJowCvEY8JKO2UWrHrtStaffaQiGRi6rRnA
 oB6K2T39gcWunHHTnobEeczbeg/n9PP+Y7eAcRRl69OwpxR3wTrWUTjcPEyYUU6D8umZ
 ldYdrBLpyeG2+tGfrVtQzm1GzEt7i4xJZRbnpFuhAWUJxuICKemv2wIxzaAkMQ2+VPpU
 LPvQ==
X-Gm-Message-State: AOJu0YwVnhIGOyQKD7H3dRsaX8FsgoXq8upemaHQtzZOSxLiqIq3jzBn
 a8K/P3kBD8dn1vFh+lfbaUVfGd0QpQVC7EiR60JFoXDfCXNy5r6tqqYFtruKjy8wZSlnNRarD+q
 8BzJwlMqwRediQHJ9yU0dDi+jXbttzo5J7pg5by9O2xmvzEnxEJGA0kIJ
X-Gm-Gg: ASbGnctQqnAiDavPYhQogX+O3kjVX5XJPjAhD07VpqVZr79WGx2HGnMpb9+WTDUAXti
 WmA2ssTQJam1T+ZJimKPwolXJJC5NNVChw7hTsLCwuQ34tiRGXpvKbopNTsr6kjhrfaTlFbMMLg
 WF1YmydA4hmECsKFBa/frzGyZTN5DggeWzAQQ0aQZw4FLximSmHnaFwHLP/ftMlJVZVRgUkRr1C
 j2vEjA5BR+owb13xYqtOPbLhscC0SiryFL6JY/p8Ij15REBEbAkq9k2JKtPYmRkrksKjYwO9hFp
 5zS1jD7WLNu/6Cl7Fa1QDufTY7WGU9h/daQYAw==
X-Received: by 2002:a05:622a:5889:b0:4e0:3cdb:d1d6 with SMTP id
 d75a77b69052e-4e576ab9233mr7028271cf.38.1759430862702; 
 Thu, 02 Oct 2025 11:47:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnsRgacd9zTTvtNBb925/yUzqc7Zt5xia7rBAenICKS+LhaEfDAjz7hi5nfg4k5xgirVsCdQ==
X-Received: by 2002:a05:622a:5889:b0:4e0:3cdb:d1d6 with SMTP id
 d75a77b69052e-4e576ab9233mr7027781cf.38.1759430862143; 
 Thu, 02 Oct 2025 11:47:42 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bbb1d86csm23236116d6.29.2025.10.02.11.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 11:47:41 -0700 (PDT)
Date: Thu, 2 Oct 2025 14:47:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH 01/14] hw/pci-bridge: Do not assume immediate
 MemoryRegion finalization
Message-ID: <aN7Iy7pZiriiAEHk@x1.local>
References: <20250917-subregion-v1-0-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-subregion-v1-1-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917-subregion-v1-1-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 17, 2025 at 07:32:47PM +0900, Akihiko Odaki wrote:
> When updating memory mappings, pci_bridge_update_mappings() performed
> the following operations:
> 1. Start a transaction
> 2. Delete the subregions from the container
> 3. Unparent the subregions
> 4. Initialize the subregions
> 5. End the transaction
> 
> This assumes the old subregion instances are finalized immediately after
> 3, but it is not true; the finalization is delayed until 5. Remove the
> assumption by using functions to dynamically update MemoryRegions.

To Paolo - you can ignore this if you'll merge it.  However I'm still
raising this as a pure question.

Could there be an explanation why it'll be delayed until step 5?

All the MRs involved in this patch are all aliases.  I believe this rules
out any map() ref-takers.  IIUC it is exactly what was marked exceptions in
the memory.rst here:

  There is an exception to the above rule: it is okay to call
  object_unparent at any time for an alias or a container region.  It is
  therefore also okay to create or destroy alias and container regions
  dynamically during a device's lifetime.
  
  This exceptional usage is valid because aliases and containers only help
  QEMU building the guest's memory map; they are never accessed directly.
  memory_region_ref and memory_region_unref are never called on aliases
  or containers, and the above situation then cannot happen.  Exploiting
  this exception is rarely necessary, and therefore it is discouraged,
  but nevertheless it is used in a few places.

I was expecting the current code should at least be fine, no?

Thanks,

-- 
Peter Xu


