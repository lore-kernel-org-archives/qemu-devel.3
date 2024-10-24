Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06839D0BB79
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3trL-0006Zg-Ii; Thu, 24 Oct 2024 05:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3trI-0006YY-R1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3trE-0006Yt-G8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729761014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFsW1Es4qKkBPayF2dULsO4QdkaD+eeRC0Qv5me2VI0=;
 b=fDqHE+1UaSKYhTKdzaeEM68p5l7b+c9vkNvjJwZR0daXVXm/cyhm8L8dOriicGdZVPO22g
 AbNEosZFokMIGdQjD3sYPjpUvz7e+keUiV1U8h6QGkCcqRmuBMSqgebJ59yAf6Xsrb7MLz
 cxPC5/BmRpE1eGPTOngd0sdFLFOq/m8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-cD3va-PKPm2lCiu2K1ACVw-1; Thu, 24 Oct 2024 05:10:13 -0400
X-MC-Unique: cD3va-PKPm2lCiu2K1ACVw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d5ca192b8so359744f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729761011; x=1730365811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nFsW1Es4qKkBPayF2dULsO4QdkaD+eeRC0Qv5me2VI0=;
 b=ssG/WsqAW7cvMpWMn/kxYie0PMiJD96R2seL/9/IBV7+aRYIojod5GbUEQ3SB1pocN
 F7BxMyBm9BCk9+cgPusHVkilnwhv2Gcz1BtyYebkw92PWu01WCuooqIVjNaJHuAvdiRO
 MFBD8LXRLLibQPqcS/uEElMdgojm7Zt+zzUcoujWw5vJTOR5kvg0bo56B+ioBM+5RT2E
 f24/XHpWkaLMT0SyAs3L41zbF5NNnZ5E0qYMnamp2f0iA3NtDNpnYmG/ed8xpb3NRM59
 McgaBNLsYcCCR9453WNS3nMSdMByggS0xObuuXwRYdVOtDQlnuKVsVIf9+Wd+dlbD7HS
 /+nA==
X-Gm-Message-State: AOJu0YxNToHyxY/fset1GZ4QKEt6+ZqTj28mDuEEpdcIMA4p+/rYLwsl
 DmD23w2wfYSIls3p1xTF6xpBPsj64SH2xRSPS6hVqag/C+0hTS+EHabiEoQLRbb3tcg9J5oB0lM
 IEx3Jksj5IPh+XRqPCErHBQ+qRqxRBRW61WKBxD8Ok/cIX5+ugAE1v8KrdaBjFkDcdKr/ocPP5X
 GV9hatEsOd79Xk16wJ8/iS67wCEnCt776K0dze7mCt
X-Received: by 2002:a5d:4535:0:b0:37e:d942:f4bf with SMTP id
 ffacd0b85a97d-3803abf2349mr894510f8f.12.1729761011221; 
 Thu, 24 Oct 2024 02:10:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW81j5yl4z1X38wl4jRc74z6cxJJfyc4sWxtCmzJ907CWEp966yBfikRTAApcZPazovYY8WOmCPZQ8NVmB7M8=
X-Received: by 2002:a5d:4535:0:b0:37e:d942:f4bf with SMTP id
 ffacd0b85a97d-3803abf2349mr894490f8f.12.1729761010897; Thu, 24 Oct 2024
 02:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241022100956.196657-1-pbonzini@redhat.com>
 <20241022100956.196657-3-pbonzini@redhat.com>
 <SY0P300MB102639B5E87A78ADE3CCA650954E2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfaJmB31ibFwf1eaxN4ve_FAF2huNX-oHQsLe39ednSDTw@mail.gmail.com>
In-Reply-To: <CABgObfaJmB31ibFwf1eaxN4ve_FAF2huNX-oHQsLe39ednSDTw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 24 Oct 2024 11:09:59 +0200
Message-ID: <CABgObfb6Vxb+L0zpwnofA+J877iqRVNZoeYgHUMdTSi7MnhMoQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] rust: fix cfgs of proc-macro2 for 1.63.0
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, kwolf@redhat.com, 
 manos.pitsidianakis@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On Thu, Oct 24, 2024 at 11:02=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> > 'span_locations' is not subject to any version check in build.rs. Is it
> > removed because of its performance penalty and the fact that we are not
> > using it anywhere?
>
> The docs say "When executing in a procedural macro context, the
> returned line/column are only meaningful if compiled with a nightly
> toolchain. The stable toolchain does not have this information
> available. When executing outside of a procedural macro, such as
> main.rs or build.rs, the line/column are always meaningful regardless
> of toolchain". So for our case it seems useless.

Ah, it's also removed because we don't specify it the feature in
qemu-api-macros/Cargo.toml, and therefore the build script does not
emit the corresponding cargo:rustc-cfg line.

$ OUT_DIR=3D$PWD/proc-macro2-0b9b0b4e3b86e043 \
   RUSTC=3D$(rustup +1.63.0 which  rustc) \
   proc-macro2-0b9b0b4e3b86e043/build-script-build
cargo:rustc-cfg=3Dno_source_text
cargo:rustc-cfg=3Dno_literal_byte_character
cargo:rustc-cfg=3Dno_literal_c_string
cargo:rerun-if-changed=3Dbuild/probe.rs
cargo:rustc-cfg=3Dwrap_proc_macro
cargo:rerun-if-env-changed=3DRUSTC_BOOTSTRAP

Paolo


