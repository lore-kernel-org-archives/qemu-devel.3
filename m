Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31744D11188
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 16:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOIoA-0004bC-Hy; Wed, 26 Nov 2025 11:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vOIo6-0004aD-GY
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 11:55:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vOIo4-00065t-2b
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 11:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764176149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aJLUpd+rJEXzrKsCKI2u5XMM3fXsKV4AkeEBKQyzh68=;
 b=XKAVvEB/YRPqnokgPZHIGgZC37KDM/s0tGCnVuKhYrryDJQdBzwm5o73gqT5h/dthHJFwN
 LDdnQoNLopn/1kLfEeN2l6NrkwNMPkAXAL5fdoikZpRufhL1DjmvF0BpkJM/6EHL2y5YZb
 k4S7foUyeVGQ8kXBk5OomWApWx/F7Pg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-7FNsNhP9PWm84XjLUYu8sw-1; Wed, 26 Nov 2025 11:55:47 -0500
X-MC-Unique: 7FNsNhP9PWm84XjLUYu8sw-1
X-Mimecast-MFC-AGG-ID: 7FNsNhP9PWm84XjLUYu8sw_1764176146
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477563a0c75so37427445e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 08:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764176146; x=1764780946; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=aJLUpd+rJEXzrKsCKI2u5XMM3fXsKV4AkeEBKQyzh68=;
 b=FPj2xiOWKqIa7nGUaXa6YNaeerkJ0apl17DEguwwMik8aqyTnaKygAxuQQWD3zKoNN
 FO1mi3CD4TfzMNn4uTvkKTGx2+ePGce4R5QoaW8J8gjF0qrGW2l/D+EXMo6TV0tfTGM+
 2jntxRhR0spKGSK9+susnBW/arazDIzMEzFki/i9ChzbJ4mfwMVgXAGB0Uk2cnIKqg/+
 5qOpPmFspwLr9LO8XyMR2NT8n/TlC2w6HuqV6hNLFkKVhTFLOQnF/x0MX8n2f6tXzPmI
 68VLaseBvrSxlTJ5PKhioOMWMPebybnzyRt+rIcFIjso/Bfz2ii3eieHmTzCtQ59gYgd
 +Ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764176146; x=1764780946;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aJLUpd+rJEXzrKsCKI2u5XMM3fXsKV4AkeEBKQyzh68=;
 b=i3jg7W7ZhaCMI7dPUht7tshB7VPFSyZeH/ER7YS0FMqHJsltMV73lVYYKYM0oY4wER
 gNcIQiJwLgUbaD1AhyBob691bAE8qjELP9K1CeNez+X43mJGiy/hIYW6oGASk4oJU7Vw
 qyHJ/9wUuaEwwtfEIaECSe7ZF4Gpht/2EGyYiN+BTGLhL+kWeTTUQDybdzxR8ND3fBfZ
 MrPu9njSFYZdwMUvvifjmjj5IEBEPArT2s4Js/cCjw35M5RC9ddJ/mcYYTfWAr/WdVXq
 JwwGsL6nzCpV6uch4hfkaAmpcpoWnob8tu1k0dz1FjwQZNlYoMvFm9piK6hYb+FTXh+2
 5bSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMMD1x/mrVLOLFW6KK8dxd655VMH//irgT6II7WCFCtc13j0yyXJjt2FNTCauQrKHa6z1/8B536jdb@nongnu.org
X-Gm-Message-State: AOJu0Yz/LpdbnfAv77rNzn6C6EguZgOdHV2XMBCKThztkoGloWzm9aRh
 TfH3+NcZ6mtbbfbHzNQtUWnMqPPIsSmbSbNa7pc0kVdWUv++gaIc/HeOMMaswW9aklBA/oHYgKT
 RzAIEmWamPY4xx+T2JgLgOgyobCQdaz+Qw23DvavXnj7O2DRKR0pNowcyZ433tHBH
X-Gm-Gg: ASbGncubGq1V9mF5q/63ANqwD07GrubOq/JUKJMmDEoKYYRDodgEQuPu/uksWPRBrzK
 DC2u0inbAuFvpMHSmi/KKpx2fpE8DEWLGXeHDBUTPtCSFECatVB3GhkdyWeVTbyUCgpm5fJhIYn
 JUAwYkIsTjUQ5t+gUbu81s9YToNls9NBlEbbGlUgFK01M4hjTC5DDqEPuK9GYdi7F9PWvE7+Aux
 5EVxpbsOhxjDDBjo0cJFlIiE6ixo9qcgOAYPG7cWdhyNCbYCnKlTKsKsaZSpRA4g8XL+aN003OT
 QR7CSUmzkoRDPvxYM7UuKFecHVkuotMbyMxL31IYFgoBoixrHWqhE7bnXEiHlb20tkZ+t8xtMfZ
 tkPgEhnoJweVt9ursjg4dZf2/PisdBM0hra6j5W6CMR/vn3UYEqKaL8MOjw==
X-Received: by 2002:a05:600c:4f41:b0:477:942:7521 with SMTP id
 5b1f17b1804b1-47904ae2429mr84466505e9.14.1764176146151; 
 Wed, 26 Nov 2025 08:55:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF09IBIccivEpbmV01U+C4pbSSmmaQjR8iJhr0O/0dLP0/6/iTi6+8UUCpdI2Cv+sF9wRrZvQ==
X-Received: by 2002:a05:600c:4f41:b0:477:942:7521 with SMTP id
 5b1f17b1804b1-47904ae2429mr84466125e9.14.1764176145699; 
 Wed, 26 Nov 2025 08:55:45 -0800 (PST)
Received: from rh (p200300f6af35a800883b071bf1f3e4b6.dip0.t-ipconnect.de.
 [2003:f6:af35:a800:883b:71b:f1f3:e4b6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790adfd181sm54145695e9.14.2025.11.26.08.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 08:55:45 -0800 (PST)
Date: Wed, 26 Nov 2025 17:55:44 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, cohuck@redhat.com, maz@kernel.org, 
 oliver.upton@linux.dev, gshan@redhat.com, ddutile@redhat.com, 
 peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 07/11] target/arm/cpu: Implement hide_reg callback()
In-Reply-To: <20251125100859.506228-8-eric.auger@redhat.com>
Message-ID: <55899f12-4452-d788-c2e5-8716173dc515@redhat.com>
References: <20251125100859.506228-1-eric.auger@redhat.com>
 <20251125100859.506228-8-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, 25 Nov 2025, Eric Auger wrote:
> Check if the register is hidden.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


