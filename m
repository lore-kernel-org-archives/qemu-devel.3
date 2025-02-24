Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03CDC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmebL-0003Gk-C0; Mon, 24 Feb 2025 14:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmebJ-0003GU-N5
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:58:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmebI-0007J4-DI
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740427127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kVHBOkdjbGw4JfzVFa7jYYMlBB4TDR1UmIxPDPlGFfY=;
 b=fL+9ESLSQZ+Ncvunx5Yn6w1jZsHCy5Q3TmtHo1WY+T5KJs2/yoLXCwfdUWhA4rTXdpy8oV
 c/UiR/P9GNSOstjUUBTj1nNqMRhSLaHLbVr06p9evqGJ5RiAAdYdErevFYZu10HPAjQbmt
 wi+m4ZAUxF0F0NbVnNc7KiS87v2r7q0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-7oTiIKBVNJaZsWI7KDLaJw-1; Mon, 24 Feb 2025 14:58:45 -0500
X-MC-Unique: 7oTiIKBVNJaZsWI7KDLaJw-1
X-Mimecast-MFC-AGG-ID: 7oTiIKBVNJaZsWI7KDLaJw_1740427124
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c09f91e480so851873585a.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740427124; x=1741031924;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVHBOkdjbGw4JfzVFa7jYYMlBB4TDR1UmIxPDPlGFfY=;
 b=Kz0KandNtfR16TOPibsgu8TnX9YcpKqwKhcaR6MNRrgX4uVwW1m3GWgjjQw3gC6c3C
 5eCeemUPGoiACjiPIH/C255Y3+Jrruflwe67eT5QYDYjfNVaTLYcsHuB3+M4etLhXYYh
 e+/C3HVfvTc1J4bzuyCUHdHM2puAGKaBO88KJikZwIG6pb3k5irvxB+gi8C5OtsSex0x
 DgqJewwyaBCH8sii3ah8oh38+jHB2rbvz+2aN6NRQXeI8Vu3fN2cPBTGUYUeoSoPMUZb
 SQFaRLYBN5+Sg68voIQ8vErXrdPDdGs5D9oueiRd/mBW+ZK6rZi4yz4HC35tTkSWMTVD
 E7Hw==
X-Gm-Message-State: AOJu0YwqirKjGGOUODMsmFqNJJcRPhWuGL5Xtw0bj8WDLSpJgsh87qUE
 FyObJtdpt8TRM6jlaY1WTi1YrJ9ykEroRc0M6qaR2wBaC57uYU+dhEKDV6tfSmeAQR83GcVsCJq
 3DdZbIC93hAm4Oq3x9SYLcXnV95jkiPkLAd7pnPx5xDJy0wrm8S69/S+DIGTz
X-Gm-Gg: ASbGnctPjMo6ymrHNAwBPLRKfdBw5PBIBafIhXm7KRFO7aJsErGDWyZBY5Sek0MX4ht
 +GTICZTqioYa6hOMrxTYlRsiZyIZpk2jE/tvleuLNpGQ4FyX0HvwH+g786bi76mXZZJmjgRYmNE
 LGYXJ/w3i+nX+PtZi5uX6uATVvqGBpM73mhcuA8YwD6qg6YKPJIIdWtys1M61MnikLTLVDR4VQG
 f796FmdEGDK1s/30RKdgsHBSxZHM64GpnPhVSl+hbIxgqjhVxLAOHs80n+TNXfyHPorLg==
X-Received: by 2002:a05:620a:3916:b0:7c0:bc63:7b76 with SMTP id
 af79cd13be357-7c0cf9504bamr2662551785a.36.1740427124435; 
 Mon, 24 Feb 2025 11:58:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt8u5oo2a9OEeJzrAAtiG+eqOvTJzK+bmUDBkHkgAP+eW+DeQ0xY8x1gKvynH0rfKQiFEPMw==
X-Received: by 2002:a05:620a:3916:b0:7c0:bc63:7b76 with SMTP id
 af79cd13be357-7c0cf9504bamr2662549085a.36.1740427124173; 
 Mon, 24 Feb 2025 11:58:44 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c23c2992ffsm13986785a.7.2025.02.24.11.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:58:43 -0800 (PST)
Date: Mon, 24 Feb 2025 14:58:40 -0500
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 6/8] migraion: disable RDMA + postcopy-ram
Message-ID: <Z7zPcODXives2Ct8@x1.local>
References: <20250221063612.695909-1-lizhijian@fujitsu.com>
 <20250221063612.695909-7-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221063612.695909-7-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Feb 21, 2025 at 02:36:10PM +0800, Li Zhijian wrote:
> It's believed that RDMA + postcopy-ram has been broken for a while.
> Rather than spending time re-enabling it, let's simply disable it as a
> trade-off.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


