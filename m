Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2220FEFCE33
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxr2f-0007uG-9c; Wed, 04 Mar 2026 13:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxr2c-0007ro-H5
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:33:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxr2b-00019t-9I
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772649228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4vTB51sPkRl3HmVs3ZNpkdYRgIeCssv5lrzeXxvE2sE=;
 b=KX7cw7250JV8LKBW5AbKoy4PJPRNusJE3Pv6jJ9c7JfkaQe9DyjT74j4gvOqtYBU9fMD8A
 wLCCq306OHyF6YqOBl3IquZawqruMh5Wu5itpynN+IA0tZy4jabx7+qlStCKaJRyEcHqNq
 +0iRwymhiAY5WQAxwnMUzd3kREHCgw8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-fEKmYcxpOt-U8LGDj18KKA-1; Wed, 04 Mar 2026 13:33:47 -0500
X-MC-Unique: fEKmYcxpOt-U8LGDj18KKA-1
X-Mimecast-MFC-AGG-ID: fEKmYcxpOt-U8LGDj18KKA_1772649226
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cb0595def4so5488276885a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 10:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772649226; x=1773254026; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4vTB51sPkRl3HmVs3ZNpkdYRgIeCssv5lrzeXxvE2sE=;
 b=m/nqZPYNY0QzDw6Anynvb7E2cHu8i5xkfgN5r7zLHWmeEMnPrLmhbHbLi9HZKUVU1c
 j1hSGvgbfoQpi+NDqI5gCpKIAAw4govE+XobG5QGVMRoPrjPxIXbsaanYcD0IblxdHbM
 +/4LBjs6PNBRiNoVwPWrNFvYOYmHQ923JTnWJ7ZUkCTnbQ9lwSxzE9KC4+GVHBXub4fq
 SSEOHDvDEOcmoaGCU4q1v3kzdSzsG+L/izVYX3d99tKDR7EquSCYXOoU6wrvpRr2pVed
 zB0A164+37eLUxmN3Dab49pHWwz/JB+h04Nr44BCOSf/NKwrYkWC9KKg4PMdNXtkUKsR
 f0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772649226; x=1773254026;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4vTB51sPkRl3HmVs3ZNpkdYRgIeCssv5lrzeXxvE2sE=;
 b=Ewr3etuVp2TMra648//GxgOO0f6wH2cyO++M+/y6hbtMiGT9Q9FYKEXqcnaddRoMSw
 hc0sKmcRgrdryJs0USFUxScDat28h/tY1UYdka2T2mlDDCOjRz5ZZhmF4FwH+tFmxYNY
 LkxMH9qOFTDd2aJi8RrZRkvEEFiRGLiWGBA36cNuGADg6REqRJXwS1zDpVSoBemkq5wS
 hKEvCjR/NXSiRY/7SKe0lppf274xAc2htNyGC97jjOly/ghjqrBxU8UtsVW/Hfen56Q3
 ofYKI9wSfuQAvyKbl4eDFRPzhK+w/3MBPgJ2p2G+j5quZeBE6/7PkdrM3sQbITuBziVZ
 msBQ==
X-Gm-Message-State: AOJu0YyyQIGm3HaNbCuqb+FswHZ0/hKH54QnHxWaSbPX2zQJRjsK2l+Y
 3JqAT36+YIkmLYeBA+y8IEuISRzUNs25b2VOA3+9D0LBnKHmxAOEzZKiYH0rIFSJQugSf2xRXJr
 yzQkaYqxRmFN31R/q9nxXN2a6VwdPhBc27b89xxKU0d+Ee//CBi+ba8Du
X-Gm-Gg: ATEYQzxLG/YiNHUVC1Q1HnOax5p9+6V0aXxeVYNv96Fqq/MopOWuOT8lTANklQAIlxd
 Pkotg8PddDtr5CxDg4hn1e8ExX0iJCg9X8j2WvdB3ujUgj92PGu1woMXc7pNk+8U7BJVMcCfs/4
 vfD5hAVyxWjWJS7g2yAstI3Y244rkuHzTqRXxa4bBl94HelE8wKYFzZyCJdfI/C5k4BcnqdtUxm
 BZe4LpU3ceIYeuphhctFfYPt1C8NMfYhnGsDTC0jpSypsGojuwOJL0BLS4LonjGeTwYyVjeoz/k
 rKr01NJucOnwOFJvOBXZ4nRXZ+cH5BCfEHSGKgGRo/iWaAxesvaAzPGJ20gErvDy4QWIFQVcg/Y
 ARrBVxs6VvkTixg==
X-Received: by 2002:a05:620a:468b:b0:8cb:79ea:2b0e with SMTP id
 af79cd13be357-8cd5b31ed50mr325552585a.20.1772649226025; 
 Wed, 04 Mar 2026 10:33:46 -0800 (PST)
X-Received: by 2002:a05:620a:468b:b0:8cb:79ea:2b0e with SMTP id
 af79cd13be357-8cd5b31ed50mr325549185a.20.1772649225504; 
 Wed, 04 Mar 2026 10:33:45 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf68b014sm1706423785a.21.2026.03.04.10.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 10:33:45 -0800 (PST)
Date: Wed, 4 Mar 2026 13:33:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH 3/7] system/memory: Constify various MemoryRegion arguments
Message-ID: <aah6_lyuUheb-4v8@x1.local>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226220226.20164-4-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

On Thu, Feb 26, 2026 at 11:02:21PM +0100, Philippe Mathieu-Daudé wrote:
> Mark the MemoryRegion structure const when is only accessed read-only.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


