Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD33FD8763
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2U3r-0004Uf-Ii; Tue, 17 Mar 2026 09:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1w2U3n-0004UJ-Oo
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 09:02:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1w2U3l-00035a-NY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 09:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773752526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X84dwyjbZoJMU1tLYMgVdKe9XEn4KqkiGjeoDFKXh0U=;
 b=jBc5Yvkyu/+Z2Vygjmww6fV+4jcT7AT0WJa0N6ovSqYh6LWy6pWB0/AhZ/UW+mW6oYF3FU
 Dq0fiTlhiCbbi+Wlv2GQdzJJtFnw8FkU/lsRfdrWTTnjGozdrwBHRqFst10qmlyuv8Ta6B
 niYwHU0oeWl03G5CA+2v5RYtEstHu9o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-G0exgOPsMCygbWAlBD9bRg-1; Tue, 17 Mar 2026 09:02:05 -0400
X-MC-Unique: G0exgOPsMCygbWAlBD9bRg-1
X-Mimecast-MFC-AGG-ID: G0exgOPsMCygbWAlBD9bRg_1773752524
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4868e691614so3855215e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 06:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773752524; x=1774357324; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X84dwyjbZoJMU1tLYMgVdKe9XEn4KqkiGjeoDFKXh0U=;
 b=mKSAfzzxuQUwAA+ER5WBsjmCOShyOq3MmGHbru+lKxF6lWVwfScNwqj3YmR7x1+On3
 0w0SbQ8Npluss4+CUR27KK+0tM9/n9WJYYHCEVNqsZTRtmQIyA+tGKzMdOevuGjqIJAg
 QW+nanJUHnyVrDktI34cVTCs/oFMseDaGRW+zdCwl4sFaHDPAM1/dv8HhM+L943/C21H
 d7RESYD65Cp9gbLI8db2e3iAZgKU0Obp1cYl8h7LwtVK/h8b1S5AfgWVTXsmTLR2wWKC
 ZeQsKk2WsJD+KQGUB+FYis31p2/1Z/rlMlpIwtYgxHAr8B+93O+M9odpVIRtos3nL//v
 zgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773752524; x=1774357324;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X84dwyjbZoJMU1tLYMgVdKe9XEn4KqkiGjeoDFKXh0U=;
 b=MFqXSVFL0fUUIogS4Itm+NjgMfbMxPJ6rzcRRMXV7qcNDFuFpesLSdB1WgN7X+H3AP
 //3fIoTLyXjUOokAqJffVoYmyp92lMkqDvLEhG8GBX0tQqoy7O/GgJLdCfDstCuIoLm9
 TEaOoEU/Ugc/Z/PvWZ31acRfVpAxCZ1QSIEv3UHnPIp28oDGvBZ65i7TxxavcoPUo0hu
 L6uTLGJ4W/pCCLtAhehVwU2E4GIBqn+ObsS9e5if6bw2GQml1rzhpGepg/2h+jZT1vFU
 6J9UAk6bFDHB5Ksuk0oyWR+YOy/tDQC6VV4Bo6nYqIvoxqLgwa9kTERdLmAJSS+H6hte
 3i7Q==
X-Gm-Message-State: AOJu0Yw+7LmGA3ER8+PmPtlQYY0LnDXL6WhsGknfNGWK+njEs24H+xZH
 je6OwWuMhPofwufhZ4sErjDBOIqiz1uicpFKGW2kRgGxLi6xAXd7jh4LpI3v/rIkM0cw5GkpRwV
 4WRoTPWezAApYiGd+wNsweT3CPFp9bur4gvn0q8vZDRh51nECAcrfFkK5
X-Gm-Gg: ATEYQzymlUAr2dadjZEy+mBjlXgB3hkwtInT9FSMVCBrw0AL7qABue8KfuG2IWI0qx3
 7Pqfj4e+iupHZ05hdVa6qwMY+TLUBRFaTNgP/gZE/7qv24ObtWsF7tft+RKvLEYF9X5Yl55OKrf
 QKaqf3gsMh/QLjoZwlpUrkBBiEp65fJUu3pUQ9D/fYnjdvQ9z/G3V8AmdLciHjO2UBmIhE1bsA2
 BST8/97VVa7qCgtsgmsNcfSTGzuVKhQAirAI4OvQ6fTe4jNehl+BQZz4Bqebvl0GjW+U0imWJr7
 fbqn6/gEjmZHoJS43t+Oakcy68cHKI1OXMCH89dwfHYKd3DR/oeVOTiTQNtgv8lApXF0G4Dv1rZ
 H/Y3CxfjZbN5Nom1yvNTTjelbiaA=
X-Received: by 2002:a05:600c:190d:b0:485:6e40:5584 with SMTP id
 5b1f17b1804b1-4856e40559amr64189005e9.6.1773752524046; 
 Tue, 17 Mar 2026 06:02:04 -0700 (PDT)
X-Received: by 2002:a05:600c:190d:b0:485:6e40:5584 with SMTP id
 5b1f17b1804b1-4856e40559amr64188235e9.6.1773752523414; 
 Tue, 17 Mar 2026 06:02:03 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eaee04fsm67125555e9.13.2026.03.17.06.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:02:02 -0700 (PDT)
Date: Tue, 17 Mar 2026 14:01:59 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Tommaso Califano <califano.tommaso@gmail.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster <armbru@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/5] i386/sev: Add TCG-emulated AMD SEV guest support
Message-ID: <ablPsAJl1k1raW7v@leonardi-redhat>
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317113840.33017-1-califano.tommaso@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 17, 2026 at 12:38:35PM +0100, Tommaso Califano wrote:
>From: Tommaso Califano <califano.tommaso@gmail.com>
>
>QEMU's AMD SEV support currently requires KVM on expensive AMD EPYC
>hardware, limiting development and testing of SEV-aware guest software to
>users with server-grade machines.
>
>This series introduces a TCG-emulated SEV guest mode that enables SEV
>validation without hardware dependencies, focusing on functional testing
>rather than reproducing the hardware’s cryptographic context.
>
>The emulation exposes SEV from the guest's perspective:
> - Exposed CPUID leaf 0x8000001F to indicate active support.
> - Active bit 0 in MSR 0xc0010131 to enable SEV on the guest.
> - C-bit manipulation in PTEs/CR3 for paging consistency with the host.
> - Complete SEV attestation workflow for injecting secrets into guest
>   memory (including direct kernel boot support).
>
>The emulation uses a new QOM object "sev-emulated", derived from
>"sev-guest", to maximize reuse of the existing SEV infrastructure while
>maintaining a compiling dependency with KVM.
>Below are the pros and cons of this choice.
>
>In addition to inherited guest properties, two new ones are added (binary
>files; default all-zero):
> - tik: 16-byte Transport Integrity Key (TIK) for measurement HMAC.
> - tek: 16-byte Transport Encryption Key (TEK) for secret payload
>   decryption.
>
>Code reuse benefits:
> - SEV detection via sev_enabled() and TYPE_SEV_COMMON object cast enables
>   the required checks for emulation without adding new conditions to the
>   codebase.
> - QAPI fields for query-sev/launch-measure inherited from SevCommonState
>   and SevGuestState.
> - Identical QMP interface (query-sev, query-sev-launch-measure,
>   sev-inject-launch-secret) as real SEV.
> - Shared state machine (sev_set_guest_state()); override backend vtable
>   only (kvm_init → sev_emulated_init, launch_update_data, launch_finish,
>   sev_launch_get_measure).
>
>Trade-offs:
> - KVM linkage: sev-guest is KVM-centric; even if KVM is not used at
>   runtime, its code is required for compilation, so it is not possible to
>   use emulation with --disable-kvm.
>
>Example usage:
>
>	-cpu "EPYC-Milan" \
>	-accel tcg \
>	-object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1,\
>		tik=/path/to/tik.bin,tek=/path/to/tek.bin \
>	-machine memory-encryption=sev0
>
>Build requirements:
>
>	../qemu/configure --enable-gcrypt --enable-crypto-afalg
>
>These provide libgcrypt support for crypto/hmac.h, crypto/cipher.h, and
>crypto/random.h, used for:
> - HMAC-SHA256 launch measurement (TIK key).
> - Secret payload decryption (TEK key).
>Note: --disable-kvm unsupported due to sev-guest inheritance (KVM code
>linked, no runtime dependency).
>
>

To give maintainers some more context: this is part of an ongoing work to
enable SNP emulation in QEMU, which would be very useful for development
purposes (eg coconut-SVSM). However, it should not be used in a production
environment as it provides no security guarantees.

Please consider this as an RFC.

Luigi


