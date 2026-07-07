Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC478C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh65h-00084a-4N; Tue, 07 Jul 2026 09:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wh65f-00084I-2I
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wh65d-0005xH-PF
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783431837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Q2Enwy0TDXTJm1BBGoUe6TiEvkTN05ITqH2Ra55CEs=;
 b=B0cE0R9sQ/OUu9/zvyqIyFEHUjN81Y8oooUmOQKDZQmXZ4N1kRcFwHEqvZMS6Slm54AvVL
 /VJK5Ep2foLxKafKWdUA631G6lXVghFEXnI+qVA6VQUnpnEfykDU2nMT5xBKKHEz4Tkr7k
 FFz+9141+CAoNhgMI9GjrqGgL4xGPD4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-BvGD6EAiNWKAMtnOvGMzhQ-1; Tue, 07 Jul 2026 09:43:55 -0400
X-MC-Unique: BvGD6EAiNWKAMtnOvGMzhQ-1
X-Mimecast-MFC-AGG-ID: BvGD6EAiNWKAMtnOvGMzhQ_1783431834
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c15b8701fe4so39113466b.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783431834; x=1784036634; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2Q2Enwy0TDXTJm1BBGoUe6TiEvkTN05ITqH2Ra55CEs=;
 b=TxLtwr6LCeuWNJIfvoPJQVp0MEOr2pi3x+HWWGuUsYt2qws6kNPHagCTFsXhFLv2lQ
 0/wlFQp8fVlm7f2APK8yQ6EOblc6mHWqyOYJUB8WVagzfhlAHtShraUD1EWQXqU/OJIr
 6IwKg7bZ05B7QB5uo1kJtCUniN7rDU58PMm+N21uLEjOc8WZb7wjS+MmgOsjq8VOXBge
 FGvwJv5I+J8dg3dnK5UHW+2ZPR20q7GtGjUIkNeItsMakdYe8D/gnD3Baq3/ypnJBXEE
 J4CI2ldQykFIs9vvIgixO1x4jqLbK1QzOwSYXzeaCBfM/8GCvEuiFKw/1r/XTiquKgcW
 DLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783431834; x=1784036634;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Q2Enwy0TDXTJm1BBGoUe6TiEvkTN05ITqH2Ra55CEs=;
 b=j46G1lL0hFdRZg8XysugKMolNtD/yuLOrlTarIhUEbrCWv6qOmF8BqMHmYAxKugEeR
 E7IUs7kjOC+P7thhHjOD6Qd9b797EUeglRRlbF9+EQRN6Zp1hqWNu3OLVMiasEnZgYGU
 usgwaTVh/BGXuu61meZ94sqg62ZMJsu7QuaFEcYgQLV0DrQQ46qIP0TFPyZRVvskKtM/
 vxPVDeEbDHRAGNq9KoL1NZCfT7zc8i4xcQlTbKqJ83N+dKeInD7w/wOOztMxEcVBfIFi
 GyXHVVV7Lf3YXGnEELvmbFZ7vUOQcZUJEve6TFGzoiBL7iPlU701nxN7Wuicn2jT5QfG
 kMOw==
X-Gm-Message-State: AOJu0YxRZ0d5c/rAahPTsQfwU9+I9rJL8oaQnwS17BxFv5Bew/EtMCn0
 JMPdvwn6zRQxlynLvQb1gGMwn5bh2bYq7/j0gbPW6iDmOPCxfKXCyqVm6PU8OV65HH84ORseSDs
 U86BYdunsD1wQa2RibmZ4x7S5x4LzUWt+7L+qlRHDSScY5qbo/o/bcZ7W
X-Gm-Gg: AfdE7cnsopJ7Uz47HnibRiDFwykZi+KlCUKpWU9bJxi1YaLwPjTwyrd1Qm3w1B/1/NQ
 s/7CEKXlJBhKMIP51x3HdUe7nD8gBMNb3EOO7plznqF4CcKMBTcgeiW5djJ7YX8t8Q1WVPDFs2K
 EdWtJ/7pe/DtfXmL2hw2Im1BIp+WX4Y9wVfS8bi4NwP86CP9jc7mXk3i+/m7TpqR1H3mkG6pKWT
 t3YF0LcowKZ33XjgQkERovB4Ev0nJfHOWjFTfIlyMp7rt0UDnV42XkdN+VmBfrFyYdg6ndua03Z
 VW16+tgXsyX1N/FHFi5IuN8ckW9HeHpqLWafFmrjoz5/QizFBWh53k/PqZqOUDd5hxIapVEhjcO
 OcXtlNFqmu+4pEQAYUs3QfrCo/a2zGkgl
X-Received: by 2002:a17:907:9702:b0:c15:b616:44b6 with SMTP id
 a640c23a62f3a-c15b6164f65mr108473766b.19.1783431834091; 
 Tue, 07 Jul 2026 06:43:54 -0700 (PDT)
X-Received: by 2002:a17:907:9702:b0:c15:b616:44b6 with SMTP id
 a640c23a62f3a-c15b6164f65mr108471566b.19.1783431833631; 
 Tue, 07 Jul 2026 06:43:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ada036efsm139580066b.45.2026.07.07.06.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 06:43:53 -0700 (PDT)
Date: Tue, 7 Jul 2026 09:43:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/3] hw/pci: Consider reserved slots mask when checking
 PCI bus is full
Message-ID: <20260707094332-mutt-send-email-mst@kernel.org>
References: <20260707084050.32137-1-philmd@oss.qualcomm.com>
 <20260707084050.32137-4-philmd@oss.qualcomm.com>
 <20260707061902-mutt-send-email-mst@kernel.org>
 <4e9aa2f8-71aa-40ce-b9a3-9521c9240b46@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e9aa2f8-71aa-40ce-b9a3-9521c9240b46@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 07, 2026 at 02:53:24PM +0200, Philippe Mathieu-Daudé wrote:
> On 7/7/26 12:20, Michael S. Tsirkin wrote:
> > On Tue, Jul 07, 2026 at 10:40:50AM +0200, Philippe Mathieu-Daudé wrote:
> > > Do not consider reserved slots as available.
> > > 
> > 
> > Philippe this is not how commit logs are supposed to look,
> > just repeating what the patch does with no explanation.
> > You know that.
> 
> Yes, indeed, you are right :( I'll blame the heat for sending this
> botched description. And I'll ignore Thomas issue for the freeze,
> we didn't care for 4 months, so I should not feel any rush.


Well it's a bugfix, can go in after the freeze.

> > > Fixes: 8b8849844fd ("pci: add reserved slot check to do_pci_register_device")
> > 
> > especially if it's supposedly a regression?
> > 
> > > Reported-by: Thomas Huth <thuth@redhat.com>
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> > > ---
> > >   hw/pci/pci.c | 17 +++++++++++++++++
> > >   1 file changed, 17 insertions(+)


