Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E34CC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 16:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY625-0002ek-Gl; Wed, 15 Jan 2025 11:14:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tY624-0002bX-I0
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 11:14:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tY622-0006cw-2Q
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 11:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736957652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEnTgy9P0oCNThSOyV83qirNcqbp7OVYWD/yzxX6B/E=;
 b=bxg1A1s4r4fp+BFVxR8uDfMUb4AYUwkAf2fUJ9G25WfnMo36aXEQIFo/Ekzv6kuvjrMC/k
 fDaS04yl+QzaJTVQYKywm2D+Tci/Cu4LJDRzwEzkdRYotWIAI0/6ZVg/HIHY6WKUusEfns
 LEkmyGKoOeQsXT2H1F1gn99FvkSeock=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-5cZx4WvHPMmdahvu4-W7Eg-1; Wed, 15 Jan 2025 11:14:11 -0500
X-MC-Unique: 5cZx4WvHPMmdahvu4-W7Eg-1
X-Mimecast-MFC-AGG-ID: 5cZx4WvHPMmdahvu4-W7Eg
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d8844560e9so144995086d6.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 08:14:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736957650; x=1737562450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEnTgy9P0oCNThSOyV83qirNcqbp7OVYWD/yzxX6B/E=;
 b=VX7z3ccT3pkN50OeLHbuND/TOgwoK3Oree8ZzBCuGvkl8sRVwKo7no0uTlZ1utE8au
 4BMHu8wXwX9YHEpZ6fkIjGeMZgGU8nY0V8jnF2Y8btZMceYjyOG1pFiAfndPDPyQvXRs
 Bpf5UAK7YXTX5tJ+y8zSyKIlpSB8mwdl9ze+tMxYvFkHEMupAidmHtGK9KgrtBbwNxYr
 eNt24Acwwwc6RaOa74D6RM/LFRQ1R6o7kPkmxl/CpXXcEH90AKqH2jNhFeq5N5f21SAi
 rBwnHBRrgnKSm/piWxqMW13HCloT9Pj3V67Xz4dRMVBALillcJRigHsZuwZbWnhMHFoe
 C4tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMcZj7fD70vHtRTkzicosDSxWrh1e3pfUnWZCFlKSQrKGm7TdIK+2hNmq3zHqKS9eKuDH16qunf3qC@nongnu.org
X-Gm-Message-State: AOJu0YxOJ9W3P8GHWkIEmk3+DNWMplmnRL0Vk9rxcHIAe4Ij5r5GYcjD
 ptXJ71SWkmqZsmYkmagWt3Hw7P5bcQO1hsiKTpANcp2i2QET4f6nDHvgj1p/73fAdyjk96OQHLB
 gYKm5H7qI+zEe2stQH1C8NA17Ykasp1q1zdnGuNudY0Knpo1n/ilj
X-Gm-Gg: ASbGncsDyXlr6MQIANWcxdq02HxWcfASlaZdl2uCgbXpNBr/E4if9NVU+3jHAsxQLyN
 ml/L0JwnA+hDNiUqJCCBL5cZv+HE4P2wMHKnlOISoa229Nk5j0EE0jh0OdrLS6WurM9/+kzZ69c
 P/688VJB5GiQ0qzPHLROJJo4Ivp6j50pFSShgGY4BpDK7kzYzJiFAogirlziaOfN2K3XfokwY5X
 iwzLjK8r60Kp97VnU3kO6YKYmuxswrXtbOmY7cessvMpOXK9VoNjrcwqPSCfoSuv90fGLZ9luhV
 VcqhuwY8W1yg0iHA/A==
X-Received: by 2002:a05:6214:3289:b0:6d8:ab3c:5e8 with SMTP id
 6a1803df08f44-6df9b2b31c2mr416009986d6.29.1736957649231; 
 Wed, 15 Jan 2025 08:14:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfMuTma6BUfPM3SixTlinV9ZIvvAeL+AGvMZes+QCj8V3fbYHnpKx/EdK3VSMcXo58ti1FRQ==
X-Received: by 2002:a05:6214:3289:b0:6d8:ab3c:5e8 with SMTP id
 6a1803df08f44-6df9b2b31c2mr416009606d6.29.1736957648873; 
 Wed, 15 Jan 2025 08:14:08 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad85f663sm66015316d6.13.2025.01.15.08.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 08:14:08 -0800 (PST)
Date: Wed, 15 Jan 2025 11:14:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
Message-ID: <Z4fezdR1ApN8ZLTS@x1n>
References: <Z4E6TnKaUt8FMWIv@x1n>
 <9bb5f964-f930-4428-b800-8b589920fe1d@daynix.com>
 <Z4U30j9w1kPnKX9U@x1n>
 <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com>
 <Z4aYpo0VEgaQedKp@x1n>
 <00a220df-b256-4b70-9974-f4c1fe018201@daynix.com>
 <Z4e7gFSqdhcmJPYb@x1n>
 <dbf863f8-6174-4c37-9553-a2d94f06de00@daynix.com>
 <Z4fW_rI7Mfrtc1Fg@x1n>
 <af018f8a-ce00-4ce2-9fe9-b6ba3f97bfa1@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af018f8a-ce00-4ce2-9fe9-b6ba3f97bfa1@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jan 16, 2025 at 12:52:56AM +0900, Akihiko Odaki wrote:
> Functionally, the ordering of container/subregion finalization matters if
> some device tries to a container during finalization. In such a case,
                      |
                      ^ something is missing here, feel free to complete this.

> removing subregions from the container at random timing can result in an
> unexpected behavior. There is little chance to have such a scenario but we
> should stay the safe side if possible.

It sounds like a future feature, and I'm not sure we'll get there, so I
don't worry that much.  Keeping refcount core idea simple is still very
attractive to me.  I still prefer we have complete MR refcounting iff when
necessary.  It's also possible it'll never happen to QEMU.

-- 
Peter Xu


