Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A87C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbtZ-00089D-BT; Tue, 01 Apr 2025 09:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tzbtO-0007PZ-Oj
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:43:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tzbtM-0006gW-Ui
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743514980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tnjkpzqpRW4hX7h9+mlM+/8i9Q3XeE+RY2fIOmtnGk=;
 b=HLeSgDMjxLLw58ZG5hUpSF3XCpuw2WdwjTrG9UcoHQ5PKJQhYKjlnxydfgr9faDLvWi6vM
 sFnuy9efrvJLYrMLeUBEr620H2yzaCNJ5COAtvuQUeOPt0mBg3CYEsdSfPpSlGMLhrfm1D
 Troh1Ud8hY456EyQDhQCs2v123qQ04s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-y2xV2wn-Ok6V_-4CSxDcag-1; Tue, 01 Apr 2025 09:42:58 -0400
X-MC-Unique: y2xV2wn-Ok6V_-4CSxDcag-1
X-Mimecast-MFC-AGG-ID: y2xV2wn-Ok6V_-4CSxDcag_1743514978
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912b54611dso2984195f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 06:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743514977; x=1744119777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7tnjkpzqpRW4hX7h9+mlM+/8i9Q3XeE+RY2fIOmtnGk=;
 b=SrCPwEGRdq0UvDJddFOUr/ORL3Bo68fh7f5BsB/qUnc0tfL5haY3PZlt4wUjdPyvQ4
 oEMlutyfgDhke6o/4zJhIfWqoalM7HQP9P4s2IZMt03KJ25kBz9bz0nGmEWQW2rX1yLX
 lO6Fa0j+t2I1hbYKKHtuFR04iVTjwmzHbnArvwsKryFwYgJGqg+LI1rTsVw19qNJ9zDi
 CgOuqg3PqsUHkjDi6uppS3iCPC52a5D2YrRAHpqwPGBnUJbRZPiZdEal0SUucgShxJEq
 8ceSoP46TzvJgqMd5K5dBOvJQZHQgbs6xcRrEZIFSfpZx4PKLVq8qQsCboLP9CpAK355
 npfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkmAvpe0agdVuMU31zF/c+gq0hNXPbXHkv+l9NU+LGkkhdBjVcvc3OVPtKA57EdyNqrK+0xbNtiOH4@nongnu.org
X-Gm-Message-State: AOJu0YzGfn1UXKKaGTOuHDOcvKyDZKgZu90lOPTdd1hFe5fZRCPTXrMj
 gc3UvrUpPaZO3GQQ4h/owsc2Pg6K75Qaf0CgiDWg2z1fksPWeXd/U9JyWdzf4egJ5KNtHHUOq51
 pZrYRKueZOCFrKXfnCt9CH9RDfbZH7EDU5S+U6Q83AB63ZNEc9YyrKDWGECDw9dg=
X-Gm-Gg: ASbGncuP2l0jfKpWZwuYU3Bj0iLgTh+WgSRVropLAndc2p6qW++YgQcb6xDvQXCGLU7
 mDPvED+4HPsF32cgioER9OlBmxR7pH+tJ1yyRbIRLfkvHvVUGGOFWe7ICQU1uKnxqdzKTnsDGi7
 aYMRCI2J7SkGPjF/gfHY4xsKX3r+Xp1AtX0Z9DRx3rembtO0VofyoCgJznmkn4ygJENSE+Dz9J7
 vhFrn86iNKiA+KM3udZBm8UFdDdoC07QNreGPsl0zxhTl6UeoLFUV0Ri6Vs4mogGOGqMp5RGk51
 qevKPbP/PEV8Cp3Utl2b5cORlg6AVOAB/B0J
X-Received: by 2002:a05:6000:1888:b0:39a:c9ed:8657 with SMTP id
 ffacd0b85a97d-39c120dbb06mr9206920f8f.17.1743514976836; 
 Tue, 01 Apr 2025 06:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRr3P81bjCiStnDLOiolqnmcwQDjZnisZ5UqYKR/nxr0lZqSe4UdhTQ3foLyVbYp2N0OD1Ig==
X-Received: by 2002:a05:6000:1888:b0:39a:c9ed:8657 with SMTP id
 ffacd0b85a97d-39c120dbb06mr9206898f8f.17.1743514976536; 
 Tue, 01 Apr 2025 06:42:56 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b663860sm14337975f8f.39.2025.04.01.06.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 06:42:56 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:42:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?=
 =?UTF-8?B?w6k=?= <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 6/6] tests/qtest: Enable bios-tables-test for LoongArch
Message-ID: <20250401154255.138cffc2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250228092729.543097-7-maobibo@loongson.cn>
References: <20250228092729.543097-1-maobibo@loongson.cn>
 <20250228092729.543097-7-maobibo@loongson.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 28 Feb 2025 17:27:29 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> Enable bios-tables-test for LoongArch virt machine, it passes to run
> with command "make check-qtest-loongarch64".
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>

I suggest merging it into of 3/6

> ---
>  tests/qtest/meson.build | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 8a6243382a..8628eebfbc 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -149,7 +149,8 @@ qtests_hppa = \
>  
>  qtests_loongarch64 = qtests_filter + \
>    (config_all_devices.has_key('CONFIG_LOONGARCH_VIRT') ? ['numa-test'] : []) + \
> -  ['boot-serial-test']
> +  ['boot-serial-test'] + \
> +  (unpack_edk2_blobs ? ['bios-tables-test'] : [])
>  
>  qtests_m68k = ['boot-serial-test'] + \
>    qtests_filter


