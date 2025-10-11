Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9088DCCD183
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 07:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Tet-0004UA-Rr; Sat, 11 Oct 2025 03:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Ter-0004TQ-HW
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 03:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Tep-00084p-6m
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 03:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760166284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RhiHGKFAh8Z6wgLniyL4CLx+giSyiW0RLL65qJ0l6dM=;
 b=J7hBjeYAIXWAkPsTb/ias28AP+deA2JB6O7gCARy3mpyljaJyeIQ3Yvx+5m/eg3azk8CB/
 vpVWFXpZ7k2r9aFIQHklMTi04Ny8n78xj8yomJ+K3Jy6dq9dIJXuL8RMif4LM9fQ5OBI/B
 ifXIC1YIe/7wJvPH+Fw/fJ+dAFU7Qi0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-vjyXiGugNQqOYaA4TcchuA-1; Sat, 11 Oct 2025 03:04:42 -0400
X-MC-Unique: vjyXiGugNQqOYaA4TcchuA-1
X-Mimecast-MFC-AGG-ID: vjyXiGugNQqOYaA4TcchuA_1760166281
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b4635c413a7so211077066b.1
 for <qemu-devel@nongnu.org>; Sat, 11 Oct 2025 00:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760166281; x=1760771081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RhiHGKFAh8Z6wgLniyL4CLx+giSyiW0RLL65qJ0l6dM=;
 b=k9oAw1mxhB4DOvboNGtcGKzMp/xXn4JV3hYc9gDUl3TxNTDjH8mdLkc+v1KekdBA7f
 MJFtmM63i+K3k8I8J1lDawJIbFKdgwwkjMwmORw+lQkK82QeXXpHE8xqwA63XmF0NMZ0
 t+d8fd0rSJN4gqTbsxWJKy/FFNjQMRnmeYac/X/EB9fUmjqY4vjUXdCnRHxN/o2KoxGn
 95cfXwGYMlyMIbdx6P8ltTRknml2w5Whj3JzAmvv8jH3685xSzgUoHYeQoDDzuIzk1p/
 myhsHglTE+jFC3wLnSW2M9T0rBldaxliB7IRkvTgIZvaE/Kia5V/sK6FrGtPLO9Fn56K
 lWiA==
X-Gm-Message-State: AOJu0YybeHLkbIyB2GfNOu12uPg3kAerwzgEQgsDPsV+3L5cX7OhanQZ
 9z5BJrw2tTLomK42Oic84Ow1+wCGKgQdod8aybUfmHjAgm2V8s9n2AE4y9v4NyqL5ElVXdlOWb0
 oEDVrK+CU2eoRfL2p75KQ+MpE1QDlBfHfYe6LtU5Nkn7/d1j4oxL9plYL
X-Gm-Gg: ASbGncttFD97MYqnc38Qk53FdTG+h3rvEJCGQX8o2uE7NoUqhrGrteGLSRTii4t1laA
 kKa6coiLldrvWhZIKXwAB1N25dTpD9sww3B5h4Y5IimfHsIufeJjHmyBHnic7p3b4b7K2kc72h/
 OdGi5CPKJAGjh7mnz0MszTO1O0E4S4Ew6td9FieFQarXMhFzgGdVqMmQAocNbzr9URRTuyhWIWG
 elOke1wVgDDft9RXnPvTo60y8fr2RG7rFZghk/rtJedn5dUy1p9XfivhuO0Wsla2+sQ4g0qt/HU
 k1lnNu2/AFQv3VPHm4vOqXVtWoyBTQFWCgqivNXZI4E7kHJT9lYQWrq8JUYHJNZn87L5T65LKS8
 Br2EEB2QOfeE6CtRE+xCWyaiBYacgaKmSZQ49QCsulMPw
X-Received: by 2002:a05:6402:518a:b0:628:7716:357c with SMTP id
 4fb4d7f45d1cf-639d5c4fe6fmr12208871a12.25.1760166281286; 
 Sat, 11 Oct 2025 00:04:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9n3uqdrolOp0oRQFc98iGpAa9NnBDM/PKNZpAmtUcMz8AHOuFayZx2yD3ns4LycDHDbYs/g==
X-Received: by 2002:a05:6402:518a:b0:628:7716:357c with SMTP id
 4fb4d7f45d1cf-639d5c4fe6fmr12208838a12.25.1760166280801; 
 Sat, 11 Oct 2025 00:04:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a52b0f3aasm4013815a12.13.2025.10.11.00.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 00:04:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, kvm@vger.kernel.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Song Gao <gaosong@loongson.cn>, Weiwei Li <liwei1518@gmail.com>,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] accel/kvm: Cleanups around kvm_arch_put_registers()
Date: Sat, 11 Oct 2025 09:04:21 +0200
Message-ID: <20251011070420.864887-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008040715.81513-1-philmd@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Queued patches 2-3, thanks.

For patch 1, I think it's better to have consistency in the use of >=.

Paolo


