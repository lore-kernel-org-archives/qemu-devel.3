Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CD4E92FDA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 21:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaKNT-0005Rq-6r; Mon, 29 Dec 2025 16:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaKNL-0005JW-UG
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 16:02:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaKNJ-0006p3-En
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 16:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767042115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6tL+yQL4qKJZf8eXA4wKlnCXuRSaEem4vHJ5nQ9iL0k=;
 b=IIGEEhplCYMeRnF5bX2ORF0ZhWDIkoQAT9CfvVhl9YSRUs0W/IjMu2sYThQbWrunAl1Mzo
 4o8P/8apFrY3tC6z0gRUU3u4jOrGeb7QqHpPQtDPi7fUdlW5OfZuPeNdLrk0/cjRiQmwhH
 jhjdThBQi9UolsE4r/8blgJOBwwP+hQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-wNC5rZUgMIasbMCgfF4szw-1; Mon, 29 Dec 2025 16:01:51 -0500
X-MC-Unique: wNC5rZUgMIasbMCgfF4szw-1
X-Mimecast-MFC-AGG-ID: wNC5rZUgMIasbMCgfF4szw_1767042111
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b2f0be2cf0so3507222785a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 13:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767042111; x=1767646911; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6tL+yQL4qKJZf8eXA4wKlnCXuRSaEem4vHJ5nQ9iL0k=;
 b=mQgUmfrLj0kYIhhuLkmeAZxRFw1iVXc2GyahrNmmSYhreCK1y3cmjxj8y8q5erOeH1
 JyhW3KqaNTkffUJ2WM7cDsbbkpv69ZGFaLGsXBqBe7y6+9rV6SkKaYF/Czdhoo4ohqz/
 ++MeOIrZwbDMz/bcn8DieVBCzdIPwUqo4bl2UXcsIAv3coIAdVVWK9sAbcefaKYa8w4G
 xLyAMicSiGBgbjGOgjMXwy8q8blUY5vesix6w69j+TQq9DwQOdb2Mosn7LSvPpDmGV4x
 kBRIj/2ln6uzR2EVd8adCE/IfB3+llHMlZfzdsww65EZPdZ+hni27bDAbEb35quBRaxN
 CgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767042111; x=1767646911;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tL+yQL4qKJZf8eXA4wKlnCXuRSaEem4vHJ5nQ9iL0k=;
 b=DPj/wVEDKRXjZIdJXfIbcZFCN1jjiEKUp67kR7a+VNp9YWZWm5CUeLaD5weUsBifGa
 p9tLYFyADWfJTNwZT5y1JjET0DoLi3DYx63RGSKgM108saBq4INwKwaP0NhSnKaHyH7J
 gtBCTD0xKYx8WfabwCD0EjQWC8ybRmKFlt6+LWL+w41X0hvcMBeLOA4SgmQkvuTywC3f
 yvu6xl1JQ7KKPq4hTdMqNhP2FyjnKcyaNVdGGD8MWv09WaHQVpL36bFfC2cC7tCMZF0D
 kLgMGYSRNichEsUoh7FqQOhMAOgtx6YjtZQffcHUnKer8D+Zh+iV9QKSqTeULCn7apKd
 X0VA==
X-Gm-Message-State: AOJu0YxSXJVBiaOzpNUtnyLStjUDBG/+I3AXG1R1VoSyrg52ICNyJtFE
 FiyNul9zUOYyUGOm3rt0Co2rTQGKJpm9To93zAdaY4DSuhRUM4io3o5lCN7rWDhEM6NitlQ1D3H
 YQDhp7LoHMR639zl3YTt5YH6MWPlsL1hSTRu1uE4XnWI5Lp8PO9bM11VM
X-Gm-Gg: AY/fxX4Da3FndWw5JYbiM1eM9h/o8xdjjT9f6LRl4TTnDTYCnpW/0i0Z00wVzzvbs4S
 AFZb4UpLMTcu0VdpJg25d49oUYp/h+434MLuacLpH8FAhcsdShT0E35SeX9p8Zkc4+3zM7YM3kj
 hy1F1VX/YNnPIR2gn7/UhXiDd6NFiu9bdfLRIpyO215HjNFUYStN0ETHSirqB8zaX4mZ4w76jN7
 1CgS3wbXL/F5WG9VO2+Yl2JjVet0d9kXxIN/8sxFN8uOGNSPnxT7C2uGhJCADe+J+wdsByC9RtT
 4snWvCXAaZy9qmGEZTRkM28IYfOioKO+A00e7jd/arcL0aWslatkQpJmbUk+xjXtya8AtSjDb6q
 pkrQ=
X-Received: by 2002:a05:620a:1a0b:b0:8b2:ea5a:4152 with SMTP id
 af79cd13be357-8c08fd1a9c1mr4940443585a.87.1767042111017; 
 Mon, 29 Dec 2025 13:01:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw+XfGDTRrglSGU2Qpa5tXvlvnkumuyzIV9/VYwtNBtN4Z06whO8sledq37xxPagv1JrKBgg==
X-Received: by 2002:a05:620a:1a0b:b0:8b2:ea5a:4152 with SMTP id
 af79cd13be357-8c08fd1a9c1mr4940439685a.87.1767042110540; 
 Mon, 29 Dec 2025 13:01:50 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0968927c0sm2495466685a.21.2025.12.29.13.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 13:01:50 -0800 (PST)
Date: Mon, 29 Dec 2025 16:01:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 23/25] migration: Move channel parsing to channel.c
Message-ID: <aVLsPRdvxduqs2V6@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-24-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-24-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Dec 26, 2025 at 06:19:25PM -0300, Fabiano Rosas wrote:
> Encapsulate the MigrationChannelList parsing in a new
> migrate_channels_parse() located at channel.c.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


