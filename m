Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88AAFCA178
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzgH8-00022Y-6m; Mon, 09 Mar 2026 15:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzgH6-00022N-OG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 15:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzgH4-0004Wb-T9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 15:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773084497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rbgWYjkthYIOSTddrLM7TxbryCIauGeCCATpvk8Vcjo=;
 b=g0ZXl4CUL2Fi3nckrdJXjkXIcQxxCE0H9jHpjCvGPympANA4QeakAZjW4M3OSsRCw5KGXK
 bt5IqXjg+HXRMlBKTlWPJFbs7mRo2YDtp0C7Smil7ComsCDh43nT1uoOgAWS4UOqpPKgTW
 +bP2TxlXRRxmiI7zXrgK2XKdhKzGka4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-g8B-YqlgP3-0AkTSvM4LEQ-1; Mon, 09 Mar 2026 15:28:13 -0400
X-MC-Unique: g8B-YqlgP3-0AkTSvM4LEQ-1
X-Mimecast-MFC-AGG-ID: g8B-YqlgP3-0AkTSvM4LEQ_1773084493
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-899e89bf366so452119196d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773084493; x=1773689293; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rbgWYjkthYIOSTddrLM7TxbryCIauGeCCATpvk8Vcjo=;
 b=izCO3kLcdYHFdU4KSONot2GaHPbpn9qfyw7kYwRvOG9sJgtwOxHncvL2+EYhOLQzXc
 hU42prHMiYlgbFdvKAgecaqzH7d+1gRmbI1ehgxP0xermSPsyzYxGubpzLOpaGtE5Yea
 s6ONj8Dbj8QdVRi50PDgunInJ8mbyEC45WC9oedpFNgA4kLVLfiR2fOG/MtoKIkdVByp
 XS27aFf0EAfBek34eD9pH6cHXQIu5mTG9TmWEfkox3qJUS94IP0piXy2n0IJQt5GN7dr
 l6bTMc5ThRR4ZtYW4US/aiaU8xbMqNt0m5tf08YMmg31wawZauygfqDn2yPYOM+prtl1
 Ejuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773084493; x=1773689293;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rbgWYjkthYIOSTddrLM7TxbryCIauGeCCATpvk8Vcjo=;
 b=MGplEFSfYy+uG2mCLP6oiGSi7Ia45olvCvELdly8XVIIqW91iGG/THPir2unt5Pj5t
 1at7uWOlLLif/jRGMdFIzZWAuwk/usd+2Tu5pNB3nEzlEwt4F+sTE5fP1L1yk680y661
 97/ATnAlDLsPE9ChH8HSKc/bEOkNMNTevIroC/9qWSWEdeuG9FCDH0SSquRvPL6/OB7d
 w38OwiFBXKva6O/hAzGcd2wxBSQn+WQkFn6l1KSjrrlX1vlO+n/ojoFNJgt6TrpLbzLw
 AZi9B5DrAzN/6Dxx7dNDwOdfW5vSNT9A8zR63T7E4uSMzXA1BKxKLneyZmBO2dh5zxE0
 Ez3w==
X-Gm-Message-State: AOJu0YydMaSSoFRqMrnXi/XcPDqXFvbqkDM7hFhQnlMKy9ORWgpTeHV1
 SOWtaHWIhzR/bOi/ptBICSyU3e9+nfjERGBgHSBY3uxB9i7vg5Z2fw+r85FBJ5g6VsTzeqgVe96
 //mg754RBY1zghEp0JeW8lk6D4RRBVdsbBNrSaFDWZKrEHr6QK2jf2Eni
X-Gm-Gg: ATEYQzzO0+4B8YKm7dlzKp/LAJidxymkZBAjbS33SXO3aYfuOd4t8KnFqsWA3cLAdUm
 suPBSxLH9gnp5pE0mjsG2U4Pn1OZoYI0bfe1shjAh8TJKG1t56eb0xx3H4vExl/l/nlJjo/PlYL
 +XhWPqsSKxHGr43zWzYStUEyHMr8ePKu3Ne6re04za2yGUkKXn/UP2n7P4u9snVB/OcNjnFl1MK
 o0lacGZLGGHihECn+t2fJkiq5BUELptEYL6q106UfjZvm10imw+2H3rRQkpGaQgGyAZ2XQldrWG
 naraH3QEVGfToNIeqQcYa5KWMBO0TjZiFTI29f/mqWtbCuDBLfQdE7e+oiSZFrPSKGpZGep5qlp
 4VGd7PjBCPQChuw==
X-Received: by 2002:a05:6214:cc4:b0:89a:865:75d7 with SMTP id
 6a1803df08f44-89a30a5c913mr195502326d6.27.1773084493140; 
 Mon, 09 Mar 2026 12:28:13 -0700 (PDT)
X-Received: by 2002:a05:6214:cc4:b0:89a:865:75d7 with SMTP id
 6a1803df08f44-89a30a5c913mr195501746d6.27.1773084492577; 
 Mon, 09 Mar 2026 12:28:12 -0700 (PDT)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a57c21650sm3965026d6.39.2026.03.09.12.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 12:28:11 -0700 (PDT)
Date: Mon, 9 Mar 2026 15:28:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v2 0/4] system/memory: Constify various
 RAMBlock/MemoryRegion arguments
Message-ID: <aa8fQIialE5xMAnf@x1.local>
References: <20260309183536.88976-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309183536.88976-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Mon, Mar 09, 2026 at 07:35:31PM +0100, Philippe Mathieu-Daudé wrote:
> v2:
> - Dropped "stubs: Merge physmem.c within ram-block.c" (Zoltan)
> - Dropped "info mtree" patches (no time to update doc for freeze)
> - New Xen patch
> 
> Philippe Mathieu-Daudé (4):
>   system/ramblock: Constify various RAMBlock arguments
>   system/memory: Constify various MemoryRegion arguments
>   system/xen: Constify various MemoryRegion arguments
>   system/memory: Have memory_region_type() correctly describe containers

queued

-- 
Peter Xu


