Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C8AEDEBED
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxVis-0001b3-TQ; Tue, 03 Mar 2026 14:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxVin-0001aQ-8Z
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:47:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxVij-0001Fo-PF
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772567263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZ5mwgUAG7XwfmuP1U/gK7vblRqb85qDjOlUL7FdzpY=;
 b=gryl/edK3cSFQ3p7jv3Ihvk6E0sIflVUgiJ6nx90WWogPlc9IZOSmaGhyk4ZVBXfXpemif
 rXGypAkbFK32dahK8WG/1Heo4f1BkP/BSpdKjKc1PC6Kymu3WRCL+BfFdw4GhnM39YOxD9
 gsthzAO9q4snwyXd1xlwUaAyrxN5t6s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-NJvrlzumPNGFlVgVlg6BNg-1; Tue, 03 Mar 2026 14:47:40 -0500
X-MC-Unique: NJvrlzumPNGFlVgVlg6BNg-1
X-Mimecast-MFC-AGG-ID: NJvrlzumPNGFlVgVlg6BNg_1772567260
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8ca3ef536ddso834623985a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772567260; x=1773172060; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hZ5mwgUAG7XwfmuP1U/gK7vblRqb85qDjOlUL7FdzpY=;
 b=VBgSf3ZYC5z1AeuCUI719Ne7Mdo6rZuhiRVD1C+YDle0fYRdsgEVT8nuwbuTNlk3ts
 s/d4n6/w4h7oO9UYdk6IcBrtXo/HvlFcqKQHayD9iMtbXWR53YW37kUwWfR7IIc8y/V7
 o7wmpPbXRC2TxzbcXxHlfxbId2bLqDSgC1UmhvkkxfawHccxSltS21DjUXB5Ok1jYr7y
 o99SxQrY42A1daYrglRbojG+yIH9tCr3SahA0h8XzVWRE+D0/eOrlN4hmg5w7uEEQLvL
 Z/LbfrhFNwZ8sz6Is0/YQk19Hpc+mtYgXaPamhxN73cC2p8R6YDVPWHMIZaDXaIe5GFV
 6luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772567260; x=1773172060;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hZ5mwgUAG7XwfmuP1U/gK7vblRqb85qDjOlUL7FdzpY=;
 b=maKVNjeSlBITSsDwyZNDNTaLCT8c+bFCgk9NMphZ6EQJYXTLNvqFAdtKbC/mOkXrSS
 WUnCwCvvS50L+fGIj5yrD+dOUB8hikfY1+Qas/85optYYbUKqQClCPC8AcVzjWtO73vE
 DL/kX7DOGxspLGJ1aABk8R4LnNQ5KzxHdgMwXFNYC1Dd9+aB/ZoZ6DIkjoEV2bV91VWB
 8nI2CI3LpkqLGp15JdZC9jrLnuB+ABa+bnTM8HV1newlbHvSgzGJHthLc+l2oFcXyYRL
 32LBL5IxYX+7GdJJ45wBKsRGnun210KNTA6upxSdGs/V9aA9V278qN2zjs8UARoNZZFs
 79rQ==
X-Gm-Message-State: AOJu0Yw947iF4wsQ4HemQMpH7ICMnjOncAZIWLBjnW5ZNF+aAD8M0vus
 2C7TfIydLubLGaAxvq/DUUXzr8Amb2HbZSwpCHpmshsCcvNSMIerjEixD3iucNCHfsU0ma/tlWv
 LIIH2XY2vl+MO6ctkUChWp/NPJp0HB7J9Cvn5Bn9aqXtNRTDVr7l7jOnx
X-Gm-Gg: ATEYQzyyqK4LEKF1aNQpIBdOdvxCR01iGvyXJOOG2swoUKTp4ymgfsDvOti3yNYWLCT
 OIJcVR7oXn8QPiNVvjLGkHYrowaqsNJ6ITHI+fr8IiCC/01n+ZlmiQSdOtyMXQI+O4yzr/G/4Vc
 QqUxwsdTO9+bBaxPVCvoCwNeUZ4dgtlzQXltx9W4ZDSvkwVih24Gj6Wo5DsWJjqC+q5C32C66/B
 9uUzuNt987r17WyAaqXPiEgsgNSfDceGpOwYRFs9JWdeD80AyRm4kE9M/FaxPO6Ao961YU3t5Le
 tt9PeqZbCbpTr/pAy1HIvoDeNqOJWCPAyPWRlxmHqRb+CPKWm8+7LRRwub4AbYFUTpUjtZAOjgZ
 +TeuG+t8Xk/2Cog==
X-Received: by 2002:a05:620a:d85:b0:8b2:f102:b904 with SMTP id
 af79cd13be357-8cbc8d834ccmr2332141985a.12.1772567259767; 
 Tue, 03 Mar 2026 11:47:39 -0800 (PST)
X-Received: by 2002:a05:620a:d85:b0:8b2:f102:b904 with SMTP id
 af79cd13be357-8cbc8d834ccmr2332137785a.12.1772567259303; 
 Tue, 03 Mar 2026 11:47:39 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf6f948dsm1454211385a.30.2026.03.03.11.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 11:47:38 -0800 (PST)
Date: Tue, 3 Mar 2026 14:47:27 -0500
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH v3 07/15] system/memory: move RamDiscardManager to
 separate compilation unit
Message-ID: <aac6z557C4oVU5ej@x1.local>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-8-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226140001.3622334-8-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 02:59:52PM +0100, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Extract RamDiscardManager and RamDiscardSource from system/memory.c into
> dedicated a unit.
> 
> This reduces coupling and allows code that only needs the
> RamDiscardManager interface to avoid pulling in all of memory.h
> dependencies.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


