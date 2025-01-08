Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB8EE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 18:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVaRp-00045c-By; Wed, 08 Jan 2025 13:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVaRo-00045E-OK
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:06:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVaRm-0002yf-45
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736359584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v0pEvL10WI8Li3AFy5zxtxLbDSZO+5YyIxzTkXMmTuA=;
 b=WUO/kDVeWCA51XIJoMzhkB2lyPl0IPTpE3dnLGOpLs9PDJFmfhb8C3jQsG74srcTyNaoDW
 Hb9eO+NE7HUW61KPKJJGd8zGvbLDWPtAyUDj3Nez4kzN8udc0q3pN6LZvvvSX7QXiKKOmY
 pGiVDYuIIQbrjz55nECIXV2/oGutx3g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-DdovRlzMNPiizSK9d2IHEw-1; Wed, 08 Jan 2025 13:06:22 -0500
X-MC-Unique: DdovRlzMNPiizSK9d2IHEw-1
X-Mimecast-MFC-AGG-ID: DdovRlzMNPiizSK9d2IHEw
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-467b19b5641so347157641cf.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 10:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736359582; x=1736964382;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0pEvL10WI8Li3AFy5zxtxLbDSZO+5YyIxzTkXMmTuA=;
 b=b/T0Yc06KogQ20BXihhbeuUC8+iKhqMHckjOYavTlQCxlW2Gg98tlvn09O1JF24p4m
 n/CPvXy2nSsrej3zA10VRrc2q+tOoEbX7N/a0Df0khte9AWkRKLj5j08dl0xUvsApS3W
 57VzzQoDAbh6o9otURzEcieEhnCS+P+MnXEqsk0U3l2oJwwjqcXFnZjJxLFXFjMBlriZ
 2Y9CGgkzWTDxU4/sQvJ5JRNP6cJe21dKrTui9HtVvnuRJruB8+lSI2ednlu2NKsv/6Dh
 O1YxM5iPhcXu0NHAZoWvEnCCApwFYq7Cqc9ZcJlNaH8xcnDjCA0YgybqulyrkvIaXtwT
 wBDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtwysf+DDZA+0+2a0kc9+AazvLjY5+I8B3liURVaVM7s8ZmDJuvl8WOPAe4Us+LlKvJBSKCtxBeVw1@nongnu.org
X-Gm-Message-State: AOJu0YzNzhPaUuyRDoyl9XIPu2VijeywfA/cSuaYd1ZVnFgl1jMuMVxd
 WEm6S4HTEQgmtCoHg/VfYCs6eUkTn3cFmcIwgDpW9P2Hc1no9sd9nMAOOFoCw01V+43sk0GLJlA
 /lcSvJ3Ukkb+Uxtm5ont13GJ1ecknRG6YOoPGm02GVkoAKmPlB7J2
X-Gm-Gg: ASbGnct0ef5x/qgPZhkRm++nKDY4Vhk2VwJc12co4Eh9dhq6F7K7tTTTpFD40Dj3o9N
 BoAcZXfz4CPpqfmziXdBJuiF40c4FBt4dr6ot8wYR43j90wkeJrQMTzRIJcT0tZmX5C7LIb+mH+
 dm937AwEMHuoqdeeogLxMqvLy1wdbZxNs0CFhzWAOcFCZr6YfD15GRMnfe8SPAbvY3heDrAnJyQ
 x7IvN/rP4CFHa41HK8SKHNJSUH1th4oUxrsRRP31VYUPJ1880g7tjpg4FpXAnuTYd1XCHbdMBON
 bUo2FcR40DsySgKpWQ==
X-Received: by 2002:a05:622a:118a:b0:466:9938:91f6 with SMTP id
 d75a77b69052e-46c7108eee0mr55482001cf.51.1736359582263; 
 Wed, 08 Jan 2025 10:06:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/Wo6zSCCtNLFjObrUpu5Nd0mTTp6hO/TAwpM2kHZIOvEu3pSTViNiPG6MdF7GGU7PhamuIA==
X-Received: by 2002:a05:622a:118a:b0:466:9938:91f6 with SMTP id
 d75a77b69052e-46c7108eee0mr55481571cf.51.1736359581936; 
 Wed, 08 Jan 2025 10:06:21 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb16c7bsm198935231cf.63.2025.01.08.10.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 10:06:21 -0800 (PST)
Date: Wed, 8 Jan 2025 13:06:17 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
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
Subject: Re: [PATCH v6 1/2] memory: Update inline documentation
Message-ID: <Z36-mSpLJevHbInb@x1n>
References: <20250105-san-v6-0-11fc859b99b7@daynix.com>
 <20250105-san-v6-1-11fc859b99b7@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250105-san-v6-1-11fc859b99b7@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Jan 05, 2025 at 05:56:18PM +0900, Akihiko Odaki wrote:
> Do not refer to "memory region's reference count"
> -------------------------------------------------
> 
> Now MemoryRegions do have their own reference counts, but they will not
> be used when their owners are not themselves. However, the documentation
> of memory_region_ref() says it adds "1 to a memory region's reference
> count", which is confusing. Avoid referring to "memory region's
> reference count" and just say: "Add a reference to a memory region".
> Make a similar change to memory_region_unref() too.
> 
> Refer to docs/devel/memory.rst for "owner"
> ------------------------------------------
> 
> memory_region_ref() and memory_region_unref() used to have their own
> descriptions of "owner", but they are somewhat out-of-date and
> misleading.
> 
> In particular, they say "whenever memory regions are accessed outside
> the BQL, they need to be preserved against hot-unplug", but protecting
> against hot-unplug is not mandatory if it is known that they will never
> be hot-unplugged. They also say "MemoryRegions actually do not have
> their own reference count", but they actually do. They just will not be
> used unless their owners are not themselves.
> 
> Refer to docs/devel/memory.rst as the single source of truth instead of
> maintaining duplicate descriptions of "owner".
> 
> Clarify that owner may be missing
> 
> ---------------------------------
> A memory region may not have an owner, and memory_region_ref() and
> memory_region_unref() do nothing for such.
> 
> memory: Clarify owner must not call memory_region_ref()
> --------------------------------------------------------
> 
> The owner must not call this function as it results in a circular
> reference.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


