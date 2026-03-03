Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F458EDEBE5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUwg-0001Sz-Oy; Tue, 03 Mar 2026 13:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxUwe-0001SV-QC
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:58:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxUwd-0003Bc-Iw
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772564291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h3jWJfd2By77YPm0nmu1FQRueQci0+HVf3IZ76mjdZI=;
 b=g7vIq4M4gil7ikTnwu5BIJ50wvxqiIEHyYiCy+nBsCgXp5zylTKebEysG3gi5ial/thTqM
 GpZMtwgt1UMWjGfNbHD3IEkXtZuWmcJfZErsCFA4VGEKsVT02Z/k/l/XuVu35/Mloaw7kr
 KUnBZ79Un1DnBXCjp5Ib2ga6qgH0w/w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-92yPNAWTNEOYrQ954aQY0A-1; Tue, 03 Mar 2026 13:58:07 -0500
X-MC-Unique: 92yPNAWTNEOYrQ954aQY0A-1
X-Mimecast-MFC-AGG-ID: 92yPNAWTNEOYrQ954aQY0A_1772564287
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cb4e37a796so3769664185a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 10:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772564287; x=1773169087; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h3jWJfd2By77YPm0nmu1FQRueQci0+HVf3IZ76mjdZI=;
 b=LtC2x3vWJtWPPeMQfc3fDyxVyYOtjQBa35VgSPjKciyP/OcXWnTkOxGLqX7jBV0B2Q
 5uwssMlKMz2EtmtfzgVTo50iNtKMma46JWp0DWWwbhfkPMB39QvRkgRJp9xtRapO9sqZ
 HQbbDYWAGVRx2ggUILh4jq67osD5lgh1aZvWzWjeHcNTSuR2VnxZAODHYMKG0p+/VthK
 isPfAiD6k45D8u7EalgZgns0HRAMfjXtGAPmhzwJcG+anoW1l+HyYj4yir0iBVw65XxQ
 LPgcvQ6EpRH6IpvhWMPV8aWYILKbkMN40I3fx1hAcIUhi6AYvuCmQlm61awGNpqrPIz6
 8aBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772564287; x=1773169087;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h3jWJfd2By77YPm0nmu1FQRueQci0+HVf3IZ76mjdZI=;
 b=BAssGIUmys0vt3zycd/p3wqumqT1tjtAEeRUYMbbN8kaUa68O+Vyy+6FFI0N3tEhn0
 UugMg3b/6r+3wNLbaznL84sV3YQn6cEexFKkFprwdDF36DrwMgg+Vfn1bt70gh9SqahD
 joNFekW95lmVMWLCndQGWv+1RrgGQuZ+YMiBJ9TgnlGkMMUOusIUw6X6gQ/UciA78jSv
 D7Fllmzhn5En/9X1trTqgQRW55XYjuYI4wpGu6YLgh9zJXhtb8lg5WgZBlyeiqTW2I/1
 +VF/XlJoRb6r7mkLMK1faz+NR0OyxEw0OpIQhEVRUisSzQUlvPSXJdPM0Azw5Vgd4pXX
 527Q==
X-Gm-Message-State: AOJu0Yw9BDwvHL2NVrivS6x6nsW00Vyl084bTswy1Z2xIwEw+cg7fYzl
 RpqxpbH2ByoGt2AKQB38wKi6c0Uk8/5DhKSMwp3wq+uEGgGXNk1Xe6IGqeRByxl8d3KILEcokuj
 VYn5wwVEDrfpDaD0/I28oumo0E+DXO9QWNpkGzmAFojosmFLzbtqYir9O
X-Gm-Gg: ATEYQzw++0C9XM8FxqrXKelgK4nCYOv6I6hmAKJk/ksPCsHwlFjushpH+DEaqEdayif
 kAuGFxGi37kPZ8xa9y0tQo+lAsD53vUfRwBD409WM8C5imoHT25eyFpiusg5E56jVXZrbgjW+/r
 blwHXJthCxdatRmKHvgFmja12cO4AzdFibF5e2netyF2KPFnseCMmWDVVWFRicOQQkvU+VuewZo
 wOIzuHHlHUI3vgimeJqOLOHZZ4Fvyugyex4w0H9fXIwiRkVt73RTQOLE28w6Kg5WdWWatURxZyZ
 wFWmn+M1zzDFfu22oFTNUdXpXewymES8s79/zjwVygZckh6USvo0AJEeSSFXyMB4jQ8k8y2DMEm
 jMkCsCj8ffSyCRg==
X-Received: by 2002:a05:620a:450e:b0:8c6:b14e:6569 with SMTP id
 af79cd13be357-8cbc8e3099bmr2268501485a.79.1772564287156; 
 Tue, 03 Mar 2026 10:58:07 -0800 (PST)
X-Received: by 2002:a05:620a:450e:b0:8c6:b14e:6569 with SMTP id
 af79cd13be357-8cbc8e3099bmr2268497085a.79.1772564286636; 
 Tue, 03 Mar 2026 10:58:06 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf71ac86sm1449210785a.40.2026.03.03.10.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 10:58:06 -0800 (PST)
Date: Tue, 3 Mar 2026 13:57:55 -0500
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
Subject: Re: [PATCH v3 02/15] memory: drop
 RamDiscardListener::double_discard_supported
Message-ID: <aacvM1v_2lBR8FSq@x1.local>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226140001.3622334-3-marcandre.lureau@redhat.com>
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

On Thu, Feb 26, 2026 at 02:59:47PM +0100, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This was never turned off, effectively some dead code.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


