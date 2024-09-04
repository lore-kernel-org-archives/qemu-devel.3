Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC10CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sloy2-0005xy-MV; Wed, 04 Sep 2024 08:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sloy1-0005wa-2Y
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:18:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sloxz-00035K-DP
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725452310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=cMCM/7XyCriLdzNgTLnG8HjKr/vlh6Ys7GFX2sYTYbcmE4wJIudK0ErSrQLw3vD719Iltn
 F6conDElBnhvPcJbSFbrE7TIMHYZO2vatK6LPDYr/8xGQTnO7aoHfWtAdolzJylUzZSvm1
 ZyTKkNhPtBfDkMjC+QV3sO3HzoSa4sE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-CIuqTtsBPwSEdgBrPUh1eA-1; Wed, 04 Sep 2024 08:18:28 -0400
X-MC-Unique: CIuqTtsBPwSEdgBrPUh1eA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5c25cf44030so2177769a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 05:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725452308; x=1726057108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=fIdNIieU+s2DNDEy9zjwE2ax6NhNBfgFe2mRSs4wa3/FlJeCgwmlGOX6MZArM6H6pu
 oi21EGur8zm5rzeuB+CqFnod4UrabwnHVVyQhoIvkBVhJlyzBoQUxMWOkTI5MtwD0lCp
 Lh1usYZUeFystYvkh/pmVmF/B/saqBoNGgks/VaeR8/J4QPMdCCGPB2fqzXXhuCvuOst
 6p4uMkCUyxAdAMwlrDToh/8WxGi/n9nhbqWfuBxa0VD/9LBrubSgXjGTWjVgJaPC+52S
 D+FDdmN1fL7Khk3HMmr2r1AuTPYbLoUXRRsO2MAP2M7uLgLU6qDq3HoFl2zauSgWMYBC
 kLDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/wFnnJjG6h+p7foJcN3uVSqXbq6B8kAU9lsyb7fLzwEJxdGlAvjLxLonH2v5vmvnXZKe0wk/G0iOg@nongnu.org
X-Gm-Message-State: AOJu0Ywx+EtHv7IZC2hzbq7Fg1nX100ps3Qyut39ECLlfqo1AZ9GWIaS
 kfYkVt1JqwfxG90NwezSDthKaOwo3+VDveQzpUD2w9dX6X9sxIiurs8uth2xr0XyMfyth/MFp8c
 tA3bAui6w0/Dvtro5aTjjh2eCVFBZWNmJX/umHwhfaoOpyHNgJG0E
X-Received: by 2002:a05:6402:5109:b0:5c2:6bcd:f6af with SMTP id
 4fb4d7f45d1cf-5c2757cefccmr2755816a12.1.1725452307778; 
 Wed, 04 Sep 2024 05:18:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxvZGZ+CXLF+BO8Fb3vGxvEvg/Sz+txqAK/+ZP+dLSRUU5wDK3OwAq0iF4xr71oELwsYlksA==
X-Received: by 2002:a05:6402:5109:b0:5c2:6bcd:f6af with SMTP id
 4fb4d7f45d1cf-5c2757cefccmr2755796a12.1.1725452307247; 
 Wed, 04 Sep 2024 05:18:27 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c226cd18a3sm7480202a12.66.2024.09.04.05.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 05:18:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, philmd@linaro.org,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] kvm/i386: make kvm_filter_msr() and related
 definitions private to kvm module
Date: Wed,  4 Sep 2024 14:18:23 +0200
Message-ID: <20240904121823.279720-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903140045.41167-1-anisinha@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Queued, thanks.

Paolo


