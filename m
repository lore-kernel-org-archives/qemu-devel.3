Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A9BC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaEv-0006it-NZ; Tue, 30 Jun 2026 11:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1weaEs-0006gC-By
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:19:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1weaEq-0001Lc-Tn
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782832743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hAvJZ597DYNnRIApt06Wv6DPjl5miq5JAjxjZq620tU=;
 b=HAmdp2MRRehAC0FWUO657MirM3vyBkoetVxuK+M8exlI5thDTpStFbIx//CSXMKb9eRbX8
 8P4R0psrhCdSw0/LzeW2fId2EP2y7zhyECeqWTz5q8k3VSM6EOIFFjfSroc/c2b3HEan0y
 Sz/mQYxQZNXy5Sp/l57CNPrFsPMPkpc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-lYm0R8hVMyCMKssHe8eBPg-1; Tue, 30 Jun 2026 11:19:01 -0400
X-MC-Unique: lYm0R8hVMyCMKssHe8eBPg-1
X-Mimecast-MFC-AGG-ID: lYm0R8hVMyCMKssHe8eBPg_1782832740
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4740be00302so1803010f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782832740; x=1783437540; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hAvJZ597DYNnRIApt06Wv6DPjl5miq5JAjxjZq620tU=;
 b=QuhuXDgsZf7ru5xAhjZeUECiy3eV5AbPbwEcEk2VArOTKAFRsC7UZEhRyn5sDtJCov
 pMlUjORE3Uw46LEUJOgM2jp6bqDsKbHjT1OjxLvgrhmJR/y95OVTL7mQEiu4a09QQ1FW
 KgiAnaAFGJXg/TLolbKp6Rg0iUQB/uhxjBzmHxDSttc+imgBAM5Tdi+XqpXtOcxspVRw
 K3XIIynZrMlinBzIwhMBRZfkDkGJ/Go+gSh8pHAM4sZRMuDABs4tfum0gYWT/8wWQ1X5
 SeuKtlq9kXnlsPQh7iREOqbTZdB/7YzyXLJiorEXGn/SZBHtuD24S/DpBITCqQnnwd20
 aWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782832740; x=1783437540;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hAvJZ597DYNnRIApt06Wv6DPjl5miq5JAjxjZq620tU=;
 b=aWShs94ryd/ekMD0JGD1ZwxLxWXMfZ/5mMSMYROxlRCIITa19xhNJTLtJ4Sx5mkb5U
 FAJbYnDtROoVc6Zxt1RbuGXYyChO88i16X3IzYoIltZuiOhVlJIeXysao7u5lsHv5abB
 /NMSFQEGZU6WA2MugesL6C6u3MkcOxG+XzKZD3ZyimnYY1abgsWQCOzVyYiZ+BEW8YDQ
 tO0R5bfLI2KFYAxnYUNOAURLuCzxhs0+3pEnz/XeihVNCPcicW0czz6KEqr2MfMN/Yax
 3E6VtHOZ+4yTzwt1ZEhggNi/WepydWLjvIUT2wPslB2HksTyjwGgLWwmEQ+K3PIwQjRk
 C6Pw==
X-Gm-Message-State: AOJu0YzDqzL2TbY1MMzaRIf6eqMJe9WOK57j+fG9nTYYZMhs1nZOATxs
 HhyvpOdSVKwTdLfWFlDjMvqp21DI1XFJJFjgLwV+Xa1Ss6x35PUTRLVFc6IOp4Liu4hU7X29rMm
 Xq2SvWL4B19aXZxOjKU6vYeIDPw6v8uZst4v86qYnRl8AfUWbFoVwOyuiZnGE7z2B
X-Gm-Gg: AfdE7cniBGNGNSxqohPrBbxcWjC0V8S8Xe+mkEDOwj0EgNJEYbNzqJgAraw6lh8Amyv
 DxDAeT0Pwo99VfYBlx8IpOsLVkeYDKuhMB/WtP8ELxjzO1LQdcC+qAsCVmjWyLZ7JXpcDRmiErL
 B4FFTgRttkXuzRKhAJcV7Wq7rSOaZ7JEFtGeqSWBgquR+cz7KSXsFFXl7tBCabgm2p9LKCYw2uA
 yP7WyNy6Kf3tpP1NBMsNX/rbVBR7g7giaWtjD2NfKT2u+Kvg4pB+GlcaHAYVXFHMvhraEDFohKo
 yKls+SYAmUkr6ymfxqyhEzAcN3q23K4Cj8e1sdBdbRrS8ptrHLX51xHNnUoElD5QKgsbVO8fY9S
 suPF1gAM5UKMhYtz8oJi0NkOYrzF8ckN+x9lkDd1S/q3Sm4Rzpcqejho/Czbw
X-Received: by 2002:a05:600c:8b0d:b0:490:b294:c652 with SMTP id
 5b1f17b1804b1-493b82acfb1mr59147525e9.20.1782832740273; 
 Tue, 30 Jun 2026 08:19:00 -0700 (PDT)
X-Received: by 2002:a05:600c:8b0d:b0:490:b294:c652 with SMTP id
 5b1f17b1804b1-493b82acfb1mr59147115e9.20.1782832739644; 
 Tue, 30 Jun 2026 08:18:59 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it.
 [79.34.22.35]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563e0eee5sm8508286f8f.5.2026.06.30.08.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:18:58 -0700 (PDT)
Date: Tue, 30 Jun 2026 17:18:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Oliver Steffen <osteffen@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 2/3] igvm: use idiomatic meson conditional for IGVM
 build files
Message-ID: <akPeV8yW2e0Ub6D8@sgarzare-redhat>
References: <20260626-microvm_device_tree-v6-0-9cd13cf057e2@redhat.com>
 <20260626-microvm_device_tree-v6-2-9cd13cf057e2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260626-microvm_device_tree-v6-2-9cd13cf057e2@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Fri, Jun 26, 2026 at 12:04:02PM +0200, Luigi Leonardi wrote:
>Replace the explicit igvm.found() check with system_ss.add(when:,
>if_true:), matching the pattern used by all other optional backends.
>
>Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/meson.build | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/backends/meson.build b/backends/meson.build
>index 60021f45d1..aabfaea5fd 100644
>--- a/backends/meson.build
>+++ b/backends/meson.build
>@@ -34,11 +34,8 @@ if have_vhost_user_crypto
> endif
> system_ss.add(when: gio, if_true: files('dbus-vmstate.c'))
> system_ss.add(when: 'CONFIG_SGX', if_true: files('hostmem-epc.c'))
>-if igvm.found()
>-  system_ss.add(igvm)
>-  system_ss.add(files('igvm-cfg.c'), igvm)
>-  system_ss.add(files('igvm.c'), igvm)
>-endif
>+
>+system_ss.add(when: igvm, if_true: [files('igvm-cfg.c', 'igvm.c')])
>
> system_ss.add(when: 'CONFIG_SPDM_SOCKET', if_true: files('spdm-socket.c'))
>
>
>-- 
>2.54.0
>


