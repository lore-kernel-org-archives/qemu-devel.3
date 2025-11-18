Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127B8CEDD81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 13:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLLQx-000838-3b; Tue, 18 Nov 2025 08:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLLQv-00082z-GM
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 08:07:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLLQs-0003FK-Vo
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 08:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763471261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ko7ECn6H1CRGUW/M9tHiHQUUBIzYL8xrqIc0vLxU1lk=;
 b=Y1MtZq76Y8F+y7HeR5wLxym2AQBJOwWtjzWiywgCl9GnP20vTwkQVkXbqyLr2ei0Qfidcd
 S4XMx94rCsGR1WpFa6vlqPDsFG6EmxQa7xtNzSmFPcn0aiOv93dXFDlXnacO2DhY5gcnye
 v7FatVsC/leUUsojAMv59BVwVaH41/8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-WfQqHPd6N12rPD8X1HaRJQ-1; Tue, 18 Nov 2025 08:07:40 -0500
X-MC-Unique: WfQqHPd6N12rPD8X1HaRJQ-1
X-Mimecast-MFC-AGG-ID: WfQqHPd6N12rPD8X1HaRJQ_1763471259
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b570776a3so2598763f8f.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 05:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763471258; x=1764076058; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ko7ECn6H1CRGUW/M9tHiHQUUBIzYL8xrqIc0vLxU1lk=;
 b=T2JftNw9z/6CsGRMSXTdbVMT84dh/oPD3WkM7Q1m9Dz9Z1HhxNm7BnJlkhRk207cre
 HcMeuEAA/LCbH8imCHsakK7tpTlHr+OQbq3SSDd3bCHtsHoYN9F5ujVmBQBIgLzcKNoH
 YPLLOgblb3WCIx+9oHM4rXO/QzqXHrvQCnQUdLpE9DsfdPMUkE0PrEURbyrLLW8xw5ZA
 +rHY2UwDmXdLLRMuImdLD7Uu0JvU6Nl+X6s8cIFQU8FQ7E4OKA0sqN+Kv71Qe8cl50DV
 DQyVBvTVKxHRLyYyEQUsm2Xg1d2S8twgWxxoeO3NOyhUm968hsdWvPPTROmEmYKY6tkm
 MGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763471258; x=1764076058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ko7ECn6H1CRGUW/M9tHiHQUUBIzYL8xrqIc0vLxU1lk=;
 b=gdQgzSmMW+FLW2e+7GjxRUNfoBDyP2n9MXTQQ6xpauobyiY7VzYk4YFsivKwhvUmQc
 4ydKEppNC944FZFRY8rFHww90NJmnrJAwksaYfdtoS46JnBsuN/wjqo1KCUIEboXPYmJ
 LJeYP+8imqmnjazSo6OV9vBMcFldTrfh2URfKhQcnNsdo5CLaXaRgQE34AHPb0vbpAx7
 5PuNvUiUVcHXq+XXAhB8CD1xfjU80VHPIR9mO+PO8Cuh26TcXfB4jK0mJmhf/iyxwAD0
 zGlhifWQS11xsMtDKPhcY74uWyk86L2YQziDdLG6KqyCa131mHl96iBIju7JyWt+mWOW
 FnNw==
X-Gm-Message-State: AOJu0YytiJBFBDovc3CKs4J7IYyNoxp7tSSrDnq5hweUbVu7lpkVrbbV
 Y3+h8yAHrOLDPxOt+6bxUZSqk5pu9KvSagV30fV831xzWeeP62rgbCbCV81aKTTGuNpFhAfRsVD
 nzI67wPiP5MzOunl3dEWm7OgrIK+rvdn1fkdxwZIj3PuD5FxVtdGPx0L5ueazRP8muLFWeRzbGH
 LiKH80e4qELvootwq9LRa74v2L7N2c031Xpf0aKESHQA==
X-Gm-Gg: ASbGncvuB/AW0FPzBXD97aRt1myXJsL0iy+aRG2dNfniJpO6oU+snFxe86CiqgtYhZq
 Mo2smiPF3ERRShyIwrzeIxCVN/42RwPkI1X36LGp4V8zyO5/+1CdEdqPHVRpj3X2FxTIUf8Oo/B
 lHYGjtrgbnwF3ZCrEvboRZlmS97KwEpjDmpeQDwhu0ckfKVm/0mgJw06nWiMiC4xS/GAivSvQA6
 x0wSg/eMXCXo9wFsi+rWjILlrSfGdcGYgd95N7oVkXxETyPnkEIWhOlYNu0TiyMQTzAPsQ=
X-Received: by 2002:a05:6000:188e:b0:42b:3dfb:646b with SMTP id
 ffacd0b85a97d-42b593988dfmr17406025f8f.57.1763471258230; 
 Tue, 18 Nov 2025 05:07:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKarEA+LFaSn+qw7i46rYpfxbxybR2GiBvQhm0XHMsAekUZBpCNLUHrWPXOxNQZsmso1P3JpHDuOt5uZt1T80=
X-Received: by 2002:a05:6000:188e:b0:42b:3dfb:646b with SMTP id
 ffacd0b85a97d-42b593988dfmr17405992f8f.57.1763471257802; Tue, 18 Nov 2025
 05:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20251115002644.103889-1-pbonzini@redhat.com>
 <3e215a17-11ed-4172-9598-42a2e1bd9e9e@linaro.org>
 <851ab1f1-c05b-48e9-a08d-2076fa9ab67c@redhat.com>
 <24c4e4cf-ddce-4e93-8f0c-33e48cdc130c@linaro.org>
In-Reply-To: <24c4e4cf-ddce-4e93-8f0c-33e48cdc130c@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Nov 2025 14:07:26 +0100
X-Gm-Features: AWmQ_bma5jGIZKXTpHHPd4pYE6v_Gyq0l_tPQecuA9gZrcsMGVhRFW1ohhOgz8o
Message-ID: <CABgObfZHSY0AA1OFbjeOpx7GVhvdfBMYVXgc5h096q3QNK_Zpw@mail.gmail.com>
Subject: Re: [PATCH] target/i386: svm: fix sign extension of exit code
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On Tue, Nov 18, 2025 at 9:31=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/17/25 12:32, Paolo Bonzini wrote:
> > On 11/17/25 10:42, Richard Henderson wrote:
> >> On 11/15/25 01:26, Paolo Bonzini wrote:
> >>> -void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_=
info_1,
> >>> +void cpu_vmexit(CPUX86State *env, uint64_t exit_code, uint64_t exit_=
info_1,
> >>>                   uintptr_t retaddr)
> >>>   {
> >>>       CPUState *cs =3D env_cpu(env);
> >>> @@ -732,7 +732,7 @@ void cpu_vmexit(CPUX86State *env, uint32_t exit_c=
ode, uint64_t
> >>> exit_info_1,
> >>>       qemu_log_mask(CPU_LOG_TB_IN_ASM, "vmexit(%08x, %016" PRIx64 ", =
%016"
> >>>                     PRIx64 ", " TARGET_FMT_lx ")!\n",
> >>> -                  exit_code, exit_info_1,
> >>> +                  (uint32_t)exit_code, exit_info_1,
> >>
> >> Why cast instead of printing all 64 bits?
> >
> > Because in practice exit_code is either a very small negative value (-1=
...-4) or a
> > positive value.  For QEMU in addition the positive value will also be s=
mall (less than 16
> > bits); values between 0x8000_0000 and 0xffff_ffff could happen in princ=
iple but are for
> > use by software and by the processor[1].  So the high 32 bits are basic=
ally unused, and
> > the cast removes eight zeroes or f's from the log.
>
> Then maybe you really want the signed int64_t?

The problem is not in the type (int64_t or uint64_t work equally well,
they're all just constants), it's in the format string. Positive codes
are written in hexadecimal in the manual, so:
- %ld makes it hard to match the positive codes in the manual
- %lx still prints a -1 as ffffffffffffffff.

So all the cast is doing is making the log more readable.

Paolo


