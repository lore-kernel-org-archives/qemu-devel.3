Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5097FD29DC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 05:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfWrq-0005MT-JP; Tue, 13 Jan 2026 00:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfWrn-0005LV-Qe
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 00:22:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfWrl-0007p0-DM
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 00:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768281772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UuSFWBRTF/a4F2rYUMOuTIPAqFb+YSyzOAe/OHdCM6Q=;
 b=eTHLnmOYxVufziRZc0mOuJGBaOBrs0FgCJz6o/6WElKbwPfVWdlRJIvGksCxy1klPgT8R3
 ltVqGvAmj02sxBmgWb8QwCWxmJbFMl4ITP64tbmeqniyOfQZPrx4mrMTe3OQwHtYljXE4X
 KrqVC+eB5iwa+EZsQ4FCCsAsJ8EBxSs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-1_FD9fvkOwGGO5XQv-k-XA-1; Tue, 13 Jan 2026 00:22:50 -0500
X-MC-Unique: 1_FD9fvkOwGGO5XQv-k-XA-1
X-Mimecast-MFC-AGG-ID: 1_FD9fvkOwGGO5XQv-k-XA_1768281770
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b6963d163eso1838176985a.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 21:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768281770; x=1768886570; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UuSFWBRTF/a4F2rYUMOuTIPAqFb+YSyzOAe/OHdCM6Q=;
 b=dkm1C6hD9JI3mVZPRpwcsr3yHzQeyn9pJbTzBW+dPGp0zqxmzZdQVkDInsdW/X6vZi
 d8LEliYrr/aF9aQg67F4jy3Au+qDTj9moepz0p47hjjaDVSmS93CJKn1nC8BaMB5s7Qa
 QBd8GBfTozvWZljjeMJgN+/33egghBLeuOuhgsEj5eK2FgnLr0wkMe2JSePl+QCpdeys
 qDWlZreedTDX+MudlDnH6BlM9fj6H8Xs8/OjoGmNVMgdfa7TFRk1EsfRFK+2SECpJQhN
 ueUSoHlPxPo1QXJ1EDeu2E9Xs/qFqsMCfWTTM1IFR6v5jfSxMGzS92Sz3GfN05cR1rmO
 f2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768281770; x=1768886570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UuSFWBRTF/a4F2rYUMOuTIPAqFb+YSyzOAe/OHdCM6Q=;
 b=BaxmdmtTAmOtJsuGxg5LLZKmXGN2Q2fVvbZTBRIN+xbyVap43EPQ31rMgcZKyDs01y
 B16XTz1twG59MwHOksVLtO0joKg7qVV8zFY0tzzmvvgkV0nlV3RVw68Zdt/qrcHE2aXF
 3ATM4AsPtBXy1XUaD74+sugCyNGBAZ3nAc26xrGcx0Cu3kAsgr5nDFQBFYejEl/6fplc
 db/LM2jxs0ENBjtibMoRtEXsDoLqZsmeLR1m4o9miSZ28/uF6ffazyDzI7HK/lAWRoFK
 6BdO1g2XI86MlogTkR326U/uAsv1VnPeA2oM0dLruwxMH4ZXWghtLyuHFJsqgzAqeNlx
 RqQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0zdXoqifk82TJRodlHxKqO90wo88PU2bBBtl4Cs+XL/AQhBEmjHsszvDDT9t0eUbNOGXtvMLoxdqF@nongnu.org
X-Gm-Message-State: AOJu0YzurCwdEFJu67qxEvy+qZd3k75JAdhtn4e37jQsmMGWmmZ81RSP
 1m6tV6mfsPq/DjjkgbL36rzF399s4PCGLtcbbR0CHKKpsUHWWkDtywcg5V73sga4LMKalouZX85
 AxTUgW4SkAFA2dYm/Itf2vTUq3KEa3gUUuul7W6eWGfMzOToWhyf3EGDy4EKhoMeVTyDPzIknCh
 XXIVulVMbp5S8lKIcEirkLVT5P1Wj3lLs=
X-Gm-Gg: AY/fxX6qVgxajvjv4FYruF6En+MpNqx55LK2yeFdvVksXGmK+kwZl0+UP9WOUTp+Q3B
 CK5YQfOklW1ZCJnTKD+rgBeRLwquVo5GApoRnOVjJLpVKennl1md6hqV3FSd6VNO7nnGIIFspHx
 WcppYWvS40w0P1qJVJzSNX/0LdrOCBc/vojIPoeRj4FPQbCHR7SX4JBHX9z7SY4Y/kt8TVjZIfc
 vfmetALJYI9DdFEjg4qhPIhSqo=
X-Received: by 2002:a05:620a:708e:b0:88f:ee0a:3d66 with SMTP id
 af79cd13be357-8c389414f29mr2813737785a.80.1768281770017; 
 Mon, 12 Jan 2026 21:22:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiH8WsY7O+xC9FcuVzBoC//WNKiyql+/5CHoVxcW31leO6vvM+yMfQ0AGwfBR8EBJ7MkShs5cyX1cMDyDXACE=
X-Received: by 2002:a05:620a:708e:b0:88f:ee0a:3d66 with SMTP id
 af79cd13be357-8c389414f29mr2813734385a.80.1768281769619; Mon, 12 Jan 2026
 21:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-5-anisinha@redhat.com>
 <CABgObfbDTAvm6E0imC=HSm2=BAC4rzUDmuHcoUbVjJ-YeXFw-w@mail.gmail.com>
In-Reply-To: <CABgObfbDTAvm6E0imC=HSm2=BAC4rzUDmuHcoUbVjJ-YeXFw-w@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 13 Jan 2026 10:52:38 +0530
X-Gm-Features: AZwV_Qh-HDldufjqbgWd4d5gXuNVRPG-KFr5tvZM8MpWL8MTjAupkr2EFt14Opo
Message-ID: <CAK3XEhOWn_zecQjvFvzsRu_dmHBAjJ4gaSfKKp6BHviQmz2D2g@mail.gmail.com>
Subject: Re: [PATCH v2 04/32] accel/kvm: add changes required to support KVM
 VM file descriptor change
To: Paolo Bonzini <pbonzini@redhat.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Jan 12, 2026 at 10:32=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> On Mon, Jan 12, 2026 at 2:23=E2=80=AFPM Ani Sinha <anisinha@redhat.com>:
>  > +int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
>
> Weird name since there are no "operations". Maybe kvm_arch_on_vmfd_change=
?

I meant the operations the arch wants to do on vmfd change.


