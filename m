Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAD7CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 20:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGjnC-00070a-S4; Wed, 05 Nov 2025 15:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vGjnB-00070B-GA
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 15:07:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vGjn9-00082J-AO
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 15:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762373258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FW6noPqvQCseYxFLXveec5doJiFcV2u+a/DN6ICgYd0=;
 b=Kx3zAIhz2Abt7wZq4Iy/1kwW5mCqf4x4OnYOwljvwta0/jswzYIZz6P32Dw+g5hmP5uWml
 QuzaR1iC1TP2ymYZGGr4fpb8+0DrbyPySEHwQjgF5jHRLjsUkqFSyySX2EACuWXbrkQ17i
 CNPrGYu94debFI7JG2KKylIv6OeCU5Y=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-ckb8zdDEO9-5WAEpdczSAA-1; Wed, 05 Nov 2025 15:07:36 -0500
X-MC-Unique: ckb8zdDEO9-5WAEpdczSAA-1
X-Mimecast-MFC-AGG-ID: ckb8zdDEO9-5WAEpdczSAA_1762373256
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4eb7853480dso4820391cf.0
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 12:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762373256; x=1762978056; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FW6noPqvQCseYxFLXveec5doJiFcV2u+a/DN6ICgYd0=;
 b=nFCKpU+kSotNLcN8LzQcj5/vUGSDarNFzVACIT5gTJz/p6eZJXuHOEZyMdj6ANGb+T
 x8t2r44e2FwFbxh3CVUPgBK75B82WQxvq9Nz5BE6MtyALKA56dYdB6sC0IQ15CDkTGUt
 E3TNrP/rur+kMrEUyH1TEoal9nflkbb87wAjiVG0DuKC1KOsmpndM7nBVt0e8KnDbwNu
 oR3tuRFT3rhWK9Utmyg6tFQgs4xBuR3zYOtjbejaH1tYkS/19ltBrRNGUUxDaUFRfGKS
 29l5n8cvovM8JzjXC58UzcYq18qm3vkRgkBLWhtd9RXMKCZ1Ip+D+xuGW73lo3k8mElv
 s52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762373256; x=1762978056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FW6noPqvQCseYxFLXveec5doJiFcV2u+a/DN6ICgYd0=;
 b=Byd0uYcTwaeXKkeDbKcRr9kecKLysCskFI2DgF5wgiA38/WKS65KXZ3SoBGOHb5ymV
 q+s0nWFt95zvX6cDN+rkV1CY9X5ceoGu/c2kPg40Jax9lOH/LNAombbN0u3ScZw2h1Y5
 ZF3OuSkfHqyPnmhyYWb6sLoHUaEkzBPwE+1+xG6/AbV08Gs/EybOCqofbZF6nvcECtjY
 QvFMWfKbYlebEVwG0UyKEpWfR9IY8huMasXoMaCe/MPhjRlMr7e5CoOsNWc0Svn9tSgz
 6qynDEs85XGUEc9/JYsRvnQP/RZGpqvo7/hu1ietx24RUaGCepyqQi8GfNqu6kvg7Tmy
 Q4hQ==
X-Gm-Message-State: AOJu0YwR7uHMK00KmPgDjGSpn8b1fdnD9fifY07Mg6JEE32e8NCK8C1x
 RcVW/kD8/Za6CFFu4TyOOkznu3BI2tbFyFkJAknBT0pVIQXNC0ydhj2N2/Rj31jH4Qy+Bp/stBt
 d0E1VtpFFrLSD9TvCc2mjD8ortoW33RnAinFb9qYHZrwTJmGhld10+/9J
X-Gm-Gg: ASbGnctXcBoigYTilTar6EeJ3Wc/66kfpk1J9g/i+afuPO3nkgzQ78iGm5qnhlShzh8
 p4Qb7WubIxvBpyHTXOFYDHDFsg6iqrJ+sjLIC/7cH9GZlMOnLZD+H4kS4NO2nFLG+EfS1j1IrZW
 /IiCpPbSe7qHeqwoTNaIHYiv1uVNC7VPcXUjhMNCHrCk18d9QkUYtngqcJ9kRlJosaibjdK/xZz
 qbjcjFDAxonPYNDbNzEicskEMddmIS0B1Qag9DDLE2PZISbO3jcqBSIDrRd3B6jZJQO7Iw3jNCo
 d2Aec728PIj26TTXPgCj0ddrtvDod5XwEyiRBCPAFxQLl7ohQQgu0OdhdJKGhZOICTk=
X-Received: by 2002:a05:622a:4cc9:b0:4ed:8ab:e7aa with SMTP id
 d75a77b69052e-4ed7212aacdmr63189691cf.11.1762373255961; 
 Wed, 05 Nov 2025 12:07:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM2X8kvDrD7ENRNfLq6vbX7rgk71+Bmua1LfZq7bNyaAgNgRpT20wI1YdLkd0IL9zrZWOc1g==
X-Received: by 2002:a05:622a:4cc9:b0:4ed:8ab:e7aa with SMTP id
 d75a77b69052e-4ed7212aacdmr63189231cf.11.1762373255464; 
 Wed, 05 Nov 2025 12:07:35 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-880828f5b32sm3677106d6.16.2025.11.05.12.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 12:07:34 -0800 (PST)
Date: Wed, 5 Nov 2025 15:07:33 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] memory: Make FlatView root references weak
Message-ID: <aQuuhSL6rXmyqm8x@x1.local>
References: <20251027-root-v1-1-ddf92b9058be@rsg.ci.i.u-tokyo.ac.jp>
 <aQE_M1qsr78RrQaw@x1.local>
 <376f8d41-6ffb-4e1b-b50b-93a0f307d017@rsg.ci.i.u-tokyo.ac.jp>
 <aQIxA8MzkSO7qm4Z@x1.local>
 <13cb4e7e-1949-4dc6-b5d6-a976f6f280e4@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13cb4e7e-1949-4dc6-b5d6-a976f6f280e4@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 03, 2025 at 08:18:00PM +0900, Akihiko Odaki wrote:
> It unfortunately does not work for pci-bridge. It has the following
> function:
> 
> void pci_bridge_update_mappings(PCIBridge *br)
> {
>     PCIBridgeWindows *w = &br->windows;
> 
>     /* Make updates atomic to: handle the case of one VCPU updating the
> bridge
>      * while another accesses an unaffected region. */
>     memory_region_transaction_begin();
>     pci_bridge_region_del(br, w);
>     pci_bridge_region_cleanup(br, w);
>     pci_bridge_region_init(br);
>     memory_region_transaction_commit();
> }
> 
> object_unparent() happens in pci_bridge_region_cleanup().
> pci_bridge_region_init() reuses the storage.
> memory_region_transaction_commit() triggers flatview_unref(), but it needs
> to happen before pci_bridge_region_init().
> 
> memory_region_transaction_commit() also has an undesirable characteristic
> that its effect may be delayed due to nesting. To make sure flatview_unref()
> happens with a particular call of memory_region_transaction_commit(), you
> need to traverse the possible call graph that lead to the function.
> 
> So I'm afraid but I don't think there is a better way to ensure correctness
> without a codebase-wide audit.

Ah indeed, I missed that. :(

One way to work this around is providing a helper (abstraction from the
current memory_region_transaction_commit) to enforce a flatview reset
before reusing.  However I feel like it's an overkill too, but at least
that would also avoid weak-refs.

I think in practise I'd vote we fix pci-bridge only, either with your other
proposal to dynamically allocate the alias MRs, or something like you
posted previously:

https://lore.kernel.org/all/20250906-use-v1-3-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp/#t

Personally, I don't mind fixing pci-bridge only even if we don't audit the
whole code base.  The audit work is time consuming, and I'd simply trust
the tests from all the QEMU users covering whatever devices are still being
used. We will always get an issue report when something was wrong.

What do you think?

Thanks,

-- 
Peter Xu


