Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D69CF45AE
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLLK-0006xA-VP; Mon, 12 Jan 2026 12:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfLJK-0006Mp-Kv
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:02:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfLJJ-0006Cb-8M
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768237352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7rKFUdQx23abFlJVm0uQPQFiuDu8lmtmxqOTgmBnKZI=;
 b=EN/mLACyTo+RJ0aTPAg/BTaaoffKHpDROrgzsFWCRx+SC4kzGwHwUTCV2JrHXjYYs9sgEr
 aI+aGphlzu/dAKt3G2LOiPzJIWqBqJWc+mGonaY66E8pus/BeKXJICXscKVWmkrY2BxQoD
 WlweRHOvyeDh8DMAige+YldLgvxFcUk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-7YLTAihNOLC9akxp06Hojg-1; Mon, 12 Jan 2026 12:02:30 -0500
X-MC-Unique: 7YLTAihNOLC9akxp06Hojg-1
X-Mimecast-MFC-AGG-ID: 7YLTAihNOLC9akxp06Hojg_1768237350
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477bf8c1413so44795655e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768237349; x=1768842149; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7rKFUdQx23abFlJVm0uQPQFiuDu8lmtmxqOTgmBnKZI=;
 b=k6KcYr4U9sGP2kgboHiMPVZ8eHsEb5fHX71RXuSBh4R2cWH1lZmG3xiMa5VsVioWTB
 U57XVOdPOEawZc3VVmdQI9ciI86/+vgrOJNE5Z+9DcfiK8iWmEEtVENVBqRdRh1sEJga
 FBiCsJ627b6wwVbDmzg75Tdwp7Ib8X+AEU+bTJMHTCN4C5PIo14CdsbWpcFgiW7ShKqy
 7WbXwzcXtxZ+Qz1UmXtXH6fPv3T9wGS8EjO9fRMySel1kvslqs5BMXQjc4Uw3fPgqvc4
 DjP0P22Byd5WX8XK98+mlw22GhH+3GtxMsCOzy2GjlQDNf+KUibnTbaDfnJu7J/Y7djG
 CJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768237349; x=1768842149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7rKFUdQx23abFlJVm0uQPQFiuDu8lmtmxqOTgmBnKZI=;
 b=f+f4gM9of3k7M9xw1PCAGBirn/UsFlNrF2Ok/1YXeSTW6iUKrAaRi/2t6ACWbrxvsl
 QSHVM+5+b4YAj3Bxr7C/WvgIKkwkU8n6+iuWuXULMDBWwDt/+E3bBfeDunHwHkfSr8u2
 muhkrUISd6fxyZru/z36QavN/bBlhefJLy1JAKrq66p2mArAoqCRfZ4grJlZyVYzQgIG
 +jifDFxYJXEsfpvaUzAWK4Yw6E6PYYcEzDWonrGRM3QNi0Q1I/WM+F0RZVrt5meVI3mv
 RvUd5vWYdjxKGxmvH/vuWfSHyLnoSf49DkhZ/1bO/YaM/GtfuaS4kP4mtQV/GXu4gbyl
 BC1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrHBlfVOBpPhLcmAYScLmfgHYTq4lcq08S/TdgujXZRctKrF0Se8N5G53giYEPcPQEADy9QqAPIUyr@nongnu.org
X-Gm-Message-State: AOJu0YwSJc5pulyUWiaW8q+fIfq0grJWHly1gEecExrhRRKscAtYswrn
 XrHy8sCpedVeS7F8BstRvsUWsTvcRHFOdKEoqg/bPm7MNow43b+ToRDqd/uOLWSC9GwCig7lZbi
 1o207/KMBe0tDTi1TSkaQh2cKCRzAh6qfNlpSnErZRPi8qQYQSP7yBOY3Cbe74N1d00RxfuUr5P
 gW5Zofb3AR8TDvfvXXXugJbEopc9nSHrQ=
X-Gm-Gg: AY/fxX7qg8xt++tF9tyTZCAi3N0x2YJjPh0dnK2+ibuhmjGU6fc0zgtuytFawDXHkCO
 q5MhNy4gLyQRJ4sT68d+Tzi3cgm0ClSmnbmZwuqAChQMdyyMU0FOhdR0V448ymb8O/zhKL8f8rW
 fcF+8P8bZyXbYQLN6hr4UQl+OzpF5RGG7elkwoz9aYC7gYzzYck+jJyCnKY4bxEyAfI5gBwn5cY
 0GlLMXzxlnuiWdohkSE/fOl2t51yySYLdUtnP940+kkLwWYUBfkdmgCWHa2Nr4MSANVMA==
X-Received: by 2002:a05:600c:4e8a:b0:479:2a09:9262 with SMTP id
 5b1f17b1804b1-47d84b18037mr244900635e9.9.1768237349477; 
 Mon, 12 Jan 2026 09:02:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUkrA/EFIxVDM9YasT0A251/Gyn1594BDFpmWhdj7boyiZzv/zO4AO7cbSLgAcvcRPwuDBrYXkZ0Raazwm8y8=
X-Received: by 2002:a05:600c:4e8a:b0:479:2a09:9262 with SMTP id
 5b1f17b1804b1-47d84b18037mr244899935e9.9.1768237349058; Mon, 12 Jan 2026
 09:02:29 -0800 (PST)
MIME-Version: 1.0
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-5-anisinha@redhat.com>
In-Reply-To: <20260112132259.76855-5-anisinha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Jan 2026 18:02:17 +0100
X-Gm-Features: AZwV_QiPnwcipYRTdzj7RyQ4o9zK-24ynHKg3jtYwESKklZ6rTj1MR4pRLLSp6w
Message-ID: <CABgObfbDTAvm6E0imC=HSm2=BAC4rzUDmuHcoUbVjJ-YeXFw-w@mail.gmail.com>
Subject: Re: [PATCH v2 04/32] accel/kvm: add changes required to support KVM
 VM file descriptor change
To: Ani Sinha <anisinha@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jan 12, 2026 at 2:23=E2=80=AFPM Ani Sinha <anisinha@redhat.com>:
 > +int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)

Weird name since there are no "operations". Maybe kvm_arch_on_vmfd_change?

Paolo


