Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8436C5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwH5b-0001UK-TT; Tue, 18 Aug 2026 06:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wwH5b-0001U5-2F
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 06:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wwH5Z-0006f9-JV
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 06:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787049036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FufrT6QF5LjGVnfECdhMWiAuksb5oHrBpr4wzMjdAs=;
 b=hdO+vOuD9e64LB7fNrj+Wr+xYRwIjtb4FBFniR7GPQfRQsL16kpGJRIgW18T6s2o6t41Uo
 ffoR/DaJ3xElmuEqqoCa3reI8BN+5mz91DEclB0OCitiOlCfCmn9mop1mNe/N4QR4+tgKF
 6sY5hJcWN8RZw1H7gNepC8L3rCRna9s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-byvoxw7hPVmOfOU0HBnIVA-1; Tue, 18 Aug 2026 06:30:30 -0400
X-MC-Unique: byvoxw7hPVmOfOU0HBnIVA-1
X-Mimecast-MFC-AGG-ID: byvoxw7hPVmOfOU0HBnIVA_1787049029
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f726186c4so2546182f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 03:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787049029; cv=none;
 d=google.com; s=arc-20260327;
 b=q8W59dQUbKMspsVyZMvjWLjTnA+zfN6GPmd79QpaUrk4lBRm5wob9bfsJQevw80PdQ
 cheoFUzSRTA8a0anb+HJCUAdyaYvLgsebVNNvhIzYlV8s7XYVRD4o6NylC1Z01uShp6Q
 VXnL45h65q7cVxMzspNzefOIL/f7RqdjCcCvzEG8/l8lm993HFdLTYhpgRVheEaISy5S
 OIrbWwcWNCSV2lOS9OiQP+PKS9PgZLHlCaDNMKRkSlX0M/VqxnRDYVS2/lF3/SbA48aJ
 0B+++dM8mv78D4IQn4fFqxCAHVLYFL/sWUmB+hQBJzbIgkLvURZLbs6v+9yu+a1CyAjG
 j4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6FufrT6QF5LjGVnfECdhMWiAuksb5oHrBpr4wzMjdAs=;
 fh=MzsW4CNTaQg/nF8uXsJNtL8cHyz5A7gALAJCWlSUO3M=;
 b=ULX0Hbjvf1PCz85I1UiJzi1q8YGYyabpDSbCms7hQ8ELvIELZeb5PHhGkr8YI/ywrv
 JZKdoYtZJ8TZeW53kGT4kOQnSEP71qhzUsR0GjKnvMzz8bdlvHBIFWTeVEQVZp3EU/Om
 HjX5QpNdyC8mALoCoTgUvt0XFrs6f1BhLRJ+Zxjo5mMQOpOovoA0EtqlbEkG8kfL3sb9
 6px/HrtUGj9QXwMqgpRGHSM/qd7UDSjMg9ITb9v0HxtL/1OQEmvZ9blLj6fBPpklIj7D
 Nad4aByMDHP4EmDlAlpf/3x86iTR6ED4d3gtGnh4WPqBDF46X4yhRSHz2P2Tcaruu+hG
 YENw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787049029; x=1787653829; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6FufrT6QF5LjGVnfECdhMWiAuksb5oHrBpr4wzMjdAs=;
 b=JUt/ZGEpU9tcID6hWzh5i1WGL8UC3bM0fIX8Wi84e3XDjEZ+tespVJ8UZiZxtWsoRk
 aFF9/5gRg2WutmnKLHE7GCjXYYD2rBst6mBvc26xjf8mnXScXZi0qQXGZ9qWPCEPEyf4
 pScUH68T0jLZmLrhzAHx5P1Dzh+WxA5lpk3oSB7FZRg+2BgjoQWRLGS5k7T0dmRPEZrd
 3EiCqP57Iydx05Tm/3FjHd7uMDj7REg9MkfV5okAQIVpSH2nuuYNt3xbnglM2qRearDg
 3ITfpjKMJ8wOKYKTMyh9frX8CZA4ANAD4ObBd0fUD6T3DAFHiS6e81v5FvT9PayiY2nm
 4ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787049029; x=1787653829;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6FufrT6QF5LjGVnfECdhMWiAuksb5oHrBpr4wzMjdAs=;
 b=YLq7/g0cPIr+u2HM3bvPdnF7n/EmpTrSQHCCGpWlMhrk4sk34Ml8TTzZlrH5EIYsW8
 QQdI5Rdeis42R4OBJhBRRIjtSsAV10/mz56wuMZaevw6sCSFzYm8ubAWhPdCrxMuW9y1
 RhBZNB3xu25WT33NQ6odHpkVUOwt7JqHq41SnKD8RXekrM9NCS9reOX8Ee1ZHEF2/jo5
 thf0euRLQUsyRg+qxrJghVPGqx4u0AzMIThfDiUNGrUawX8JK3EzRI/m3F39Iyj3kyZb
 HQKQobYCv3QkRpQEGCK+oWUh1Ss0r50Ze3CelpJvnV6blY+JZVUljfWtJ6gld3VLJwig
 FDFQ==
X-Gm-Message-State: AOJu0Yzjuk9waCps6zKmFjUmpQJDfc1icyLyBTaUXRYu+ndIEhE5ffAv
 WAZObHvCGnL+p41ZSa8rAiDoV56D7FnyOX7nYYN5KcZjA3dcqF0zmrDxo9WzCQtzsF5y46vUXXi
 E9qb6u07bru0HodXOvmzlNQYanWGNKWOVgVhMbaE8lrMRw8ypd6zH1rjAINE27TzKr8nqe7mS4p
 ixZyC0Ere5ZzCAeBU8Ru9n0opLIujptdSEb1i0s+s=
X-Gm-Gg: AR+sD12LKFcUhg2zA4JangkRpBP4N3rEXsRz3dhUKAi7fvQWevlMm7KNgag0wxOJJBW
 mZC/ronNOgnyb/Z95rkj5axVby3kZlgbVUy+Mc8W0gkWhi4G3ham2PSJKVTymWyKhW0gf5VIbEe
 eDmXoJ8OAfkRBkjJimBamjZgCnLNumez2Ik+O1XMWxzvA7JtjFaNT38aEl7IHS7rvCK7nCZIfKP
 lGqFv6cJPWacqva6ae0urZSu++dGzasvtk56NfEXpGoXVFSkc57VRPzpO8=
X-Received: by 2002:a05:6000:2891:b0:482:a909:53d3 with SMTP id
 ffacd0b85a97d-482a90953f4mr11113071f8f.2.1787049028816; 
 Tue, 18 Aug 2026 03:30:28 -0700 (PDT)
X-Received: by 2002:a05:6000:2891:b0:482:a909:53d3 with SMTP id
 ffacd0b85a97d-482a90953f4mr11112989f8f.2.1787049028385; Tue, 18 Aug 2026
 03:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
 <20260813181640.6537-12-philmd@oss.qualcomm.com>
 <55cc8357-daeb-4315-9f3a-8be7a59c355b@redhat.com>
 <3ec603ff-65bb-440b-8ed8-72ae4e6c5a41@oss.qualcomm.com>
In-Reply-To: <3ec603ff-65bb-440b-8ed8-72ae4e6c5a41@oss.qualcomm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Aug 2026 12:30:16 +0200
X-Gm-Features: AcwNN1U9FkNWmAq29kJzhpwyumQVJaYATOb2EskO-A53Cr-akB0nGwo0bt8h3t0
Message-ID: <CABgObfaDAhrpnVqQaKgG6uxPQe1YDu77YOsUEx9nqrN=3M2cGw@mail.gmail.com>
Subject: Re: [PATCH 11/16] accel/kvm: Consistently return CPU halt state from
 process_async_events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, Alexander Graf <agraf@csgraf.de>,
 qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org, 
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 18, 2026 at 11:24=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
> > Your patch is correct because, even if cpu_thread_is_idle() sees cpu-
> >  >halted =3D=3D false, the flag could become true during
> > process_queued_cpu_work() because it releases the BQL.
> >
> > However, I think the better fix is to remove the return code, and check
> > cpu->halted in kvm_cpu_exec().
>
> Looking at it, even better would be to move *process_async_events()
> from inner loop to outer loop for all accelerators. For HW accels it
> seems quite trivial; for TCG I need to figure if it is safe to call
> icount_prepare_for_run() with the BQL taken, due to the replay_mutex
> uses -- here the win is cpu_handle_halt() ends restricted to system
> and we can remove the odd EXCP_HLT handling in user emulation.

Makes sense, but probably it would be a series of its own. :)

Paolo


