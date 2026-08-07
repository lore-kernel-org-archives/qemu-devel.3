Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0185DC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKUt-00068I-LJ; Fri, 07 Aug 2026 09:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsKUs-000680-6w
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsKUq-00062G-QD
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786108824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=dYew+HP9vYuz0hq5Zgtjzu8HwltTLeuG2mvMPuyY2H3iWyZu6a8GSb+gTmHPXcVjOBteQM
 UvzBO7UkJVJTjG3E86VkFhUcwzjoAGqCFyS8DR9wuyIi+jZQBECD3Msfj6P+zvoEbYdLhs
 R+Gz4sf8DCZJbMaUqP1MNWzwRsFC/fw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-LLs-9I46N9S2beamhA-akA-1; Fri, 07 Aug 2026 09:20:22 -0400
X-MC-Unique: LLs-9I46N9S2beamhA-akA-1
X-Mimecast-MFC-AGG-ID: LLs-9I46N9S2beamhA-akA_1786108821
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f90dbaf84so2534601f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 06:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786108821; x=1786713621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=lfKSXTq/mgaUn6wRa0SvuBB1IZuDxz0HNWCcDIxKzrNDxEzvnrr8wuSGYc4m6APuzH
 uoYSSBD5N3nt8awr1K8wCijPklsljIr5HU6hqJ/I09ELEphEa3+QQz4/X73n6EAukkeE
 eLs403IAbKIYPWp7OltbZeNwTelqir9gdRx/6cLLg5E4lyLFW6JB+dVVHO1S3NVj67o8
 QPjW2a4eFhwfrjMmoqxf/wMcTG4CERCzURfqw/s+KrS9VKvjMsnA4TkiRRZ9h85/ZccJ
 /nsoYb5HVUqfgszZw2JqmTpu/5+KUb5ErAcXqRaCm0AQQnvlRjxsbIGDnk41TRvm24Ee
 xvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786108821; x=1786713621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=mmgtSvBA2iYr0WlNs3+2jPzz+deEfEweS79uKsgIVgHn19Qe6LcuQX2DkZew2msnzo
 OV8FSWrixLowBhMzZmz+IAldRwrfLY5GSdq8LdjGIloDH8P7w8n8SVXKY6aYAZxrW9Ax
 Fp+H5JLaeDHv9J/G8TMbKNghjvhGdTpw2H33+nUb/UndvIkb5avFXMKzHZeuAhYOEIC4
 4/s8SMdvDOQK5YaU1vpzZFmdqn/JRh4MiPalMep1+tBG6w31MivV0BkA9fJOiDGF3GnE
 3M9ObQucFx2+4313z0+MIwXS5djVGcQ+84FRsMfQBXL4wTmvLdovWJwej/hhgCv16gLI
 HCdg==
X-Gm-Message-State: AOJu0YxUdhuyJoee1nhb8G2P9dVLQQDiGpqjZcYphKZXbrx1VU4yVFSx
 vzvH/nvOSbCJf18fKJXy+NhaFHCnkNJ6zqhaDMuJv3rF/MDk3RQ3F9SE4VXc+CekPNdcjdX+82u
 cN9rstiRPxUCkitvfj+vT4T9k+K2o50y3XfnouwLDdWOOpBwoR47hyObz
X-Gm-Gg: AR+sD10jQUDOeTwXwha0XcmzFGI9xVsUMwqi0hsPgymkyK79NaicIdtB1Jd8FuDzcUn
 X9MXKZ2rT0/daXfYKWPYaXzDMH61DmIFBkAtGLnh0A7LE+qXC8TSo7vc70sNR6iU1ZNxZWNSNG9
 u9CO3lE93y5df7wIQDSpzc3Bn4fbj51v00ZgxPtde/rf8TWHwSWt+sNk0XKxAPHq5iv6+r8sD4I
 kI3D16NBGE9cEvqJAf1tjmcscj+rRh103kBsfSFnRsv4ArGrMO6fZXo1fmsnTv9xd8qL5JXX4gX
 ZE97Uty+0q78//AlzqFjnrHzaH/7TWf51fTVcP2RFfGRS90mnEz7pGCdJZSMsmcg7taFnwzd3z/
 Bh46tIP6QVnZn7PlLBTnKc1OJpLTX+MfZ3kRgw2N/fid19IBl7M0Qdek+KH1Qb/3xO49oA4BCN0
 H+XJc=
X-Received: by 2002:a05:600c:4f82:b0:495:4cb8:42b9 with SMTP id
 5b1f17b1804b1-4994e7112a3mr266715475e9.4.1786108821460; 
 Fri, 07 Aug 2026 06:20:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4f82:b0:495:4cb8:42b9 with SMTP id
 5b1f17b1804b1-4994e7112a3mr266714875e9.4.1786108821122; 
 Fri, 07 Aug 2026 06:20:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995427a244sm144184275e9.10.2026.08.07.06.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 06:20:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Saul Freedman <fre3dm4n@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 kvm@vger.kernel.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] target/i386/kvm: Fix CET SSP MSR read feature check
Date: Fri,  7 Aug 2026 15:20:17 +0200
Message-ID: <20260807132017.2609409-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260615033338.1563854-1-fre3dm4n@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
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

Queued, thanks.

Paolo


