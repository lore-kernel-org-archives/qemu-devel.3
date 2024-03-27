Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF54C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 13:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpTNu-0004jc-A8; Wed, 27 Mar 2024 09:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpTNp-0004ik-St
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:32:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpTNk-0006S0-F6
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:31:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-414925ba716so6867365e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1711546313; x=1712151113; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ry50isKBz7xwB9eIS98LGGV6NnwE9fBPbss1bZmyVbc=;
 b=GdjipIdu0R50H2gujRlkkZcYQiF6V+H62qV00GBlA6ghLytC4NN/Lgu03AiTN2UZH6
 mx4cwZ513mOcEKYFdEzdlEyyhZzJf3/FM9s3z1RsN6NB7LO5qbu/zNDFDPtzT71Gbsfg
 Z1oSkRwl3mDGCUXbH4D5T9WH/6o3tsGTrgMcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711546313; x=1712151113;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ry50isKBz7xwB9eIS98LGGV6NnwE9fBPbss1bZmyVbc=;
 b=YPpn/a4DavEZKnbFFLOPmwGjqBGfQt2DfY2dQzLyFf+8mbKIVMpvVJSU53PfwYQ8Ru
 UuOq5tAJqA4Fy8ph6COG1sj/h2smn2/eCj+LE9YDBK5eccM/yNdQr7tRLfA2Cu/fPQnK
 mrl17oEm5JpHWc1yXVzdxf3xH/LJfgND78tB5SNNXOGe5wuFn9ZiMW8gcOneflfcDCK8
 wpyNpD2+sIB20IbpVGQXW1Lig2dMHz0vGuar4I5O+cR8Y56IANplw3toAPD+mHwGX3ox
 BCYdl4WraDYcHs9rBgUpAyRsQZHe8XCNyMYagIXbzxA24nfrwZudMAMJqUyqBm6kUVNt
 MsNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/htnRCXHH47qgIOzy09Hx6ozWXPZJP63azu9rdSGJPjuqY+qlcq9ba9dECOSnlvwHh1BXqd23mW0nR0evtQd6h+ueyv4=
X-Gm-Message-State: AOJu0YzryMECn+XbBs+HhH5vrkT8QqTg2pHMl8+GqkBd67crRyybhtrB
 VpvOfCuOEkHWpr9C034V8AUVKnSO0X1LQrFSACrtFQGl610MC5qFLLpUaYLKhYw=
X-Google-Smtp-Source: AGHT+IFYIuYEr12t4v0Td8b3I1GnsgGQezqwN6hoZoxCPeltmyQmrmwtG5G0fLSfp8l9b6esrVdj4Q==
X-Received: by 2002:a05:600c:198a:b0:414:8d7:8292 with SMTP id
 t10-20020a05600c198a00b0041408d78292mr52993wmq.0.1711546313427; 
 Wed, 27 Mar 2024 06:31:53 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 j28-20020a05600c1c1c00b00414807ef8dfsm2209230wms.5.2024.03.27.06.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 06:31:52 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:31:52 +0000
From: Anthony PERARD <anthony.perard@cloud.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [RFC PATCH-for-9.0 v2 09/19] hw/block/xen_blkif: Align structs
 with QEMU_ALIGNED() instead of #pragma
Message-ID: <76ae46e6-c226-49d0-890e-c8fd64172569@perard>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114143816.71079-10-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=anthony.perard@cloud.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Nov 14, 2023 at 03:38:05PM +0100, Philippe Mathieu-Daudé wrote:
> Except imported source files, QEMU code base uses
> the QEMU_ALIGNED() macro to align its structures.

This patch only convert the alignment, but discard pack. We need both or
the struct is changed.

> ---
>  hw/block/xen_blkif.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/block/xen_blkif.h b/hw/block/xen_blkif.h
> index 99733529c1..c1d154d502 100644
> --- a/hw/block/xen_blkif.h
> +++ b/hw/block/xen_blkif.h
> @@ -18,7 +18,6 @@ struct blkif_common_response {
>  };
>  
>  /* i386 protocol version */
> -#pragma pack(push, 4)
>  struct blkif_x86_32_request {
>      uint8_t        operation;        /* BLKIF_OP_???                         */
>      uint8_t        nr_segments;      /* number of segments                   */
> @@ -26,7 +25,7 @@ struct blkif_x86_32_request {
>      uint64_t       id;               /* private guest value, echoed in resp  */
>      blkif_sector_t sector_number;    /* start sector idx on disk (r/w only)  */
>      struct blkif_request_segment seg[BLKIF_MAX_SEGMENTS_PER_REQUEST];
> -};
> +} QEMU_ALIGNED(4);

E.g. for this one, I've compare the output of
`pahole --class_name=blkif_x86_32_request build/qemu-system-i386`:

--- before
+++ after
@@ -1,11 +1,15 @@
 struct blkif_x86_32_request {
 	uint8_t                    operation;            /*     0     1 */
 	uint8_t                    nr_segments;          /*     1     1 */
 	uint16_t                   handle;               /*     2     2 */
-	uint64_t                   id;                   /*     4     8 */
-	uint64_t                   sector_number;        /*    12     8 */
-	struct blkif_request_segment seg[11];            /*    20    88 */

-	/* size: 108, cachelines: 2, members: 6 */
-	/* last cacheline: 44 bytes */
-} __attribute__((__packed__));
+	/* XXX 4 bytes hole, try to pack */
+
+	uint64_t                   id;                   /*     8     8 */
+	uint64_t                   sector_number;        /*    16     8 */
+	struct blkif_request_segment seg[11];            /*    24    88 */
+
+	/* size: 112, cachelines: 2, members: 6 */
+	/* sum members: 108, holes: 1, sum holes: 4 */
+	/* last cacheline: 48 bytes */
+} __attribute__((__aligned__(8)));

Thanks,

-- 
Anthony PERARD

