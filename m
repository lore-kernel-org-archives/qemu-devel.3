Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B87E64004
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 18:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECDU-0007m9-UY; Thu, 21 Nov 2024 13:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tECDS-0007lv-Mx
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 13:47:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tECDQ-0004Jn-Bv
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 13:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732214861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HczF12C9pQkV2vUIcF8B/fEAuSsrL42TTguu1Y4A5lM=;
 b=BSoYls4VH+9pIP8nWQpanF2pZH4ntCPz89PZ9mwvddNFhJ8s+48RdPaCB/2a5U+VOJmGNh
 DyvPEK6Gk5aXJDK3umG8TCkrnRdUhbsv3TCqrWfwkZYloiYc8jY/ZvfkEqHpWkG9GnpwE4
 dJ3gGS57SlUHGToZVhryTvzd6+HamJ4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-ySI4CraNMt-5iEfPwCY6qw-1; Thu, 21 Nov 2024 13:47:37 -0500
X-MC-Unique: ySI4CraNMt-5iEfPwCY6qw-1
X-Mimecast-MFC-AGG-ID: ySI4CraNMt-5iEfPwCY6qw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38229779bf4so765793f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 10:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732214856; x=1732819656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HczF12C9pQkV2vUIcF8B/fEAuSsrL42TTguu1Y4A5lM=;
 b=WKh3AhIWjmpeAxxobo6UGHVoktP6c9jp7ZYH1e1siOC3DsuttRJWXH0Gu4l3jKFLpA
 Pz4VtH6ozjZ++vLN/QAwygRWhjmjQYO+/u7xXzTO6vhU25HKQ7uP+oO//d0Cyr1+cp7X
 brf/YWgR3NjoU6ocui2f9QTTDQ21RDeL6YEdSE+5bKmB4IznueOe3UlIeD9GsFmJYSFN
 PPxsU21xuYMa7SfREi4gnsUyLuIKEbBrD1A+7+ZMjKoR5jenYB+NhB4+tlaecIfAPG8x
 4MWT55kQbApI15oy1bs6w5dk8nM3fiqfaVpjHUZU4z5U/rnBcwqoCt6BIcldGjxQE4jr
 gwLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp4WdhboWvaU/CXCl/ida1JvuAiL3f2tgb8Ghu0Yh0InYzEriwd62J/fZLrA8xQ4jqRtRdWMwmyym7@nongnu.org
X-Gm-Message-State: AOJu0YwzLotSIG9Cv2/2nP4gDL4ho7XqL9kqKh0SvV7WIqCmHTUr2ReM
 UluG3wrUVOPmnQzbozC3m6cdiAd7T+FyH4gR16Fymp2ZCwX2WhNBNbEOVXPXWv4EIRfvttkzmmR
 h5GKKasoEKPC5XfIZbTTZd3pyQaUdIpjRaAfxKr9q7J36mopwiP4Yn3hrWUKuTR+EYt2/vTPtkL
 +5TN3gqAUPpm/K7N/zA8UwB+3IPaM=
X-Gm-Gg: ASbGncuLfOB+tzmRafen7hZJ6aX5MRMiieYKjK6svIFS01ik+T/A9GYyAw2NjVd/BmJ
 znW9u9a46r6wu2gpOtzT0SKcOzAvxk73A
X-Received: by 2002:a5d:47cb:0:b0:382:4fa4:e52f with SMTP id
 ffacd0b85a97d-38260b5b0c9mr135446f8f.13.1732214856669; 
 Thu, 21 Nov 2024 10:47:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3klsm+haB01CRWcgjgpGYJbpj7mevS16wgUsUVFd9HCO3IAtXHVo6JVoHs5GWk6e7oXVWKDcYgivCCs7olLg=
X-Received: by 2002:a5d:47cb:0:b0:382:4fa4:e52f with SMTP id
 ffacd0b85a97d-38260b5b0c9mr135422f8f.13.1732214856348; Thu, 21 Nov 2024
 10:47:36 -0800 (PST)
MIME-Version: 1.0
References: <CAP52u7a_CA-PEw2gMgc32rCKGt8mqsjCkEedkzTgOosazrTs-w@mail.gmail.com>
 <Zz99VtNtZCx-P5Mx@redhat.com>
In-Reply-To: <Zz99VtNtZCx-P5Mx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 21 Nov 2024 19:47:22 +0100
Message-ID: <CABgObfY8fmSjQBU34NVhn-de5iWeWTBJr18u_GgFZpJXjL3NzQ@mail.gmail.com>
Subject: Re: QEMU patches for native windows support through clang-cl
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Erwin Jansen <jansene@google.com>,
 Roque Arcudia Hernandez <roqueh@google.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, sw@weilnetz.de, 
 lvivier@redhat.com, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Patrick Leis <venture@google.com>, Nabih Estefan <nabihestefan@google.com>, 
 Danny Rosen <dannyrosen@google.com>, JP Cottin <jpcottin@google.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> NB As a general point, we actively block use of clang with Windows
> builds (more strictly in 9.2 now), because it lacks support for the
> 'gcc_struct' annotation that we rely on to guarantee correct ABI for
> structs exposed to guests in particular.

Ah, good point. This is
https://github.com/llvm/llvm-project/issues/24757 for the general
tracking issue, and https://github.com/llvm/llvm-project/pull/71148
for a recent PR that attempts to implement this.

Using -mno-ms-bitfields globally is unsafe because there are probably
Windows API structs that implement it.

One solution is to add `QEMU_BUILD_BUG_ON(sizeof(...) == ...)` to all
structs in QEMU that use bitfields. That will prove very quickly if
there are issues or not.

Paolo

> Many people try to simply remove that #ifdef, mistakenly assuming that
> because the code compiles without warnings, it must be correct. Did
> you have solution for this, as it would be a blocker for enabling
> clang on Windows currently ?
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
>


