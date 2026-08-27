Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F68C5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVUn-0005QU-Nj; Thu, 27 Aug 2026 04:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wzVUm-0005Q7-D2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wzVUk-0004P5-TR
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787819396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DBdUyAsqfJt4r9dXvva+et1CD5naD6J/mWEbiwE2yWI=;
 b=GXAPAteaprWmIak12NxiLgEeedmDhTD01D9nKkCYy2BiuxDWYaioySrQjedO4qWHkLIpEc
 cEfC01W0S2NQVZa2A6exB+TxisnzK6n98N07tnavBn4C0//2uwxoTRhqT6b4uGlU5dX023
 oU8gEG6FnEmusPA1Kx32hZpkH1BHk5I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-3ofVVbwIPxCy3jD9zUMfPw-1; Thu, 27 Aug 2026 04:29:54 -0400
X-MC-Unique: 3ofVVbwIPxCy3jD9zUMfPw-1
X-Mimecast-MFC-AGG-ID: 3ofVVbwIPxCy3jD9zUMfPw_1787819393
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49808ea1b64so5500815e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 01:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787819393; x=1788424193; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DBdUyAsqfJt4r9dXvva+et1CD5naD6J/mWEbiwE2yWI=;
 b=DYZFyKav4S/EgCGt4xw45cxImJjtrBupD+nbrN/RSueASFaQBUpmYpOCo62SSuZnDC
 /SX14nptGwJW9aqhY9njY+aYKfkMqDgG3WOQomT6x0Miupa/vI3QGMnUJqUkmHm+U3Zs
 nYUzNdF5btTzy/DsgdlhNgUJyhzrqgH+s62RFAQcOAvSa6u0dyi7v7D2ZIumxXy+iKmA
 uvKDWWm3k4rzN3nhncJWLWcP7AEPMU5+PzP3AGWK0B63QtUW4eRlbVzH4dxZt0TMnr/y
 6/dOymv9Cniq3zmtZ0ThVAfLdIS9whXANGHoIHHsjBQzkWkThDVOH4fON74C/1Qt0fRQ
 0Sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787819393; x=1788424193;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DBdUyAsqfJt4r9dXvva+et1CD5naD6J/mWEbiwE2yWI=;
 b=DhHhRAAINKJuTxs7M3KJFSS3jjKT4hExs1lEJdNpXgb7Hg1Qck/dCvjV9OfTDHbcm8
 TJHaQtW2udgzQHPwYupFTuDFxuv1qLduWi2z4XqNjmSnozyyWCfzYb2BNoyVgojZ/sqU
 NIxd4L7FAhrGtm6wGTI3kEB2lhmoyii5eqLR2ruRqHQLANmcaJaqFxbD6AO6HKIfpigG
 QmkkRmkBFvWec8cY6VZMbzunGp5ZF8t1bV3YF5zoEr+Iqf5ebCDTCI2E1fyxlXilz8cP
 CdDxYxX5DFzmjcaW9g+WVmm+Geo77sKbkpVqoyR4L/kciPPU1KSyGsswOBA7m8zFSqTL
 74cA==
X-Gm-Message-State: AFuF++kLM1q3wg1VyheqmNE1D4ibtMus+C0SkL2R14So5eetl/osT8hw
 F2eZZdckxu/YUnyiYuDb/mFRwTJTcb9Yuugs4Bix+D+d3ZHrIHnyAYuRRrBgS5MoGMPc2KbfpWD
 Yhj61HV5N3l2Tkz5wynuEZmdjBR+nNKShE7ucMahcQxq/gtOWmJdpjbCo
X-Gm-Gg: AR+sD11QFsZeH6SKKT6dwhB4KzvET6bM1mFBgYYhcIeMvJBh+pJ7Eqn18cfSIdY0V/7
 GfzhfEHN3tWoyYKE61QXyT0CIAF0yIQYxxTqImV/ltPHpzJ9l6iJHIrQc6KulPIbx55F9VxyFy4
 hykJo0RLhrGL1xGLhNj/aQWutxlq/oeXzqa8S1ydL+0IJadAFN+rT+TS/ajTmLlFdBswHOjE1By
 HCuXoW4oGyQNAG/HQV447BPdtg9dWKH/Hoct7ADFIIvtJx0S0QPFK6nuIS1gxLTn2hHtC7H6GmE
 NBukgCaRUsr9VNr7ejZHXjCEmLw/O4+Og3zqik7sCAq+ZFtvMSD+rBS574vuZbg18xyYPNSsczD
 SiVSy+w9LIoAgQOOfNFIoYaw7uAoTWjVN/+JU
X-Received: by 2002:a05:600c:138e:b0:49a:ce8f:1a5e with SMTP id
 5b1f17b1804b1-49b0dea94a8mr47891285e9.2.1787819393214; 
 Thu, 27 Aug 2026 01:29:53 -0700 (PDT)
X-Received: by 2002:a05:600c:138e:b0:49a:ce8f:1a5e with SMTP id
 5b1f17b1804b1-49b0dea94a8mr47890615e9.2.1787819392771; 
 Thu, 27 Aug 2026 01:29:52 -0700 (PDT)
Received: from leonardi-redhat ([109.52.148.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5616f7sm57605615e9.2.2026.08.27.01.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 01:29:52 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:29:49 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 03/12] edk2: update submodule to edk2-stable202508
Message-ID: <ao_1WPt4pzUf5M-J@leonardi-redhat>
References: <20260824164751.1700783-1-kraxel@redhat.com>
 <20260824164751.1700783-4-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260824164751.1700783-4-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

nit: /s/202508/202608

that said

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Luigi

On Mon, Aug 24, 2026 at 06:47:35PM +0200, Gerd Hoffmann wrote:
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> roms/edk2         | 2 +-
> roms/edk2-version | 4 ++--
> 2 files changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/roms/edk2 b/roms/edk2
>index 4dfdca63a934..2970e5699ba6 160000
>--- a/roms/edk2
>+++ b/roms/edk2
>@@ -1 +1 @@
>-Subproject commit 4dfdca63a93497203f197ec98ba20e2327e4afe4
>+Subproject commit 2970e5699ba6267f3384ffab20f96647578aebc8
>diff --git a/roms/edk2-version b/roms/edk2-version
>index 069f19f8bf49..8a0cf62749cf 100644
>--- a/roms/edk2-version
>+++ b/roms/edk2-version
>@@ -1,2 +1,2 @@
>-EDK2_STABLE = edk2-stable202408
>-EDK2_DATE = 08/13/2024
>+EDK2_STABLE = edk2-stable202608
>+EDK2_DATE = 08/12/2026
>-- 
>2.55.0
>
>


