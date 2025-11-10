Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E037CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vISWO-0006xj-FC; Mon, 10 Nov 2025 09:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vISMG-0007uj-5T
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 08:55:04 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vISME-0006un-34
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 08:54:59 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-640f4b6836bso5576729a12.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 05:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762782896; x=1763387696; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wa+kuJOu0h++TrjcxztXc/AK43K6/9Cimfh1mrzlijk=;
 b=NrbSfvjh76JiWoC6ISjyRCoxllLNY5Pd3TWQi7ahQkanv75YOv6caCcNlELiu+Kfix
 uJrSOhuKlqDG8dcGjzzlXMuDtfY1eGKCBZH8VUrZ1CL79gvkILplDOPvAf8FT+VbeUKQ
 olRE4QyeS51ozoCAX/DLWdm4IAGuiuSSlYiA+Ve97V7IczI3G/B1JNoRzOse5hL+Kpyg
 wxPyaR3LQlxyuWZ5D/iGsD6lq7UviEKeH6ScKar1kKcHBM5EoJNccR60mjrHFOCZr6nN
 vu5Aaby4+2cjtuB+ZMJDyeliotwXspCi30mRh7RFdeb9ZJ1w99fbF/6g1+ya0cLt8xcI
 /E2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762782896; x=1763387696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wa+kuJOu0h++TrjcxztXc/AK43K6/9Cimfh1mrzlijk=;
 b=X3irwvlNmD5zhAjgpfyiKfMnEOLOYeoNM5smrzCWtVxaeUwtvgYzSnD9vJI6QY1yG7
 fj6OHyLHiQCVNAMiD5lkr60xj2XY+SRXlcQF0hBWOED+C4ML8fFv+6pxofXZMGp1NCqa
 PNjQDNMoB4EI3UKIu92kx2YmTKoS/ZViQbxTktuaXlhEdqlDQ0STReLo2xOVpq3/KkFl
 3EzDfpTrZ1u9S/e++r8csodW7LfAAW7FirRiga7Q3WHQvwEw2A6/6+siriwrggYkfxBY
 XDkDbsj10CuVCgyEYt/gJ6ncimRqUSPZq9l3oSWva9E4kKNGNTfl4MyhL1+db6pG0iR0
 eKkQ==
X-Gm-Message-State: AOJu0YxYcVtJPIYJiTAz72LKoFrH4uqkGlNjzpWaLBJ8uBPOkNzlQoMt
 FSMxVrw2VkwqlIUCdX7NSmIzkiOag0ry9nUAYLDwsdpM7zDP+KTDoncPOvS6+Y0oKsBLTbIUwQA
 7b3OcYrsF8TvvW28PnPml0gDUadBW0SXZmOkfQ1Gz/g==
X-Gm-Gg: ASbGncsxvjypNcB5/Kz1aP/pl8Cx1QVDZ5VqB/aA0JqTcs2NneTj4mNLpvsOXGL+h5v
 Rm4hKNu4aJjIcfgBR90USDJiLWa58RtCUG5ixK6NDT8gX5pOhj/WjdLjpsMn9Pc1PHdb0CTWX6L
 yMmeyVEIIs3wTzitoxFSg9LHlE8quTGls5OKGx5OMlHYxrkwwhHaKZJpCOlTw2mtMIEWSYIISX9
 KOH3E6WxiPkcMlpRmfp+fRcxrzjZW+dWTusNsfNfJ1HY+eGTudexTSKSgMRYRh8WDqO
X-Google-Smtp-Source: AGHT+IHexwgYS9uaq85sLmruf+NGdyV+asIeuqKhxuaFRrQH2lUQPryWX00dYirIEOa0Tsap8gexLN7NFmWclvFNEIc=
X-Received: by 2002:a17:907:96a4:b0:b04:aadd:b8d7 with SMTP id
 a640c23a62f3a-b72e0285d38mr784107866b.13.1762782896289; Mon, 10 Nov 2025
 05:54:56 -0800 (PST)
MIME-Version: 1.0
References: <20251106215606.36598-1-stefanha@redhat.com>
 <20251106215606.36598-3-stefanha@redhat.com>
In-Reply-To: <20251106215606.36598-3-stefanha@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 10 Nov 2025 15:54:29 +0200
X-Gm-Features: AWmQ_blMYXlLBTBO7IQqFFZejGhw1RKk48Dj6ANS_TVVyaYgKOFxPBdDKoKhisk
Message-ID: <CAAjaMXY=QrO1iHhe8NkqVHGochQbnceTAj9SL796_+wv8b6Tug@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust/hpet: add trace events
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Nov 9, 2025 at 3:57=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> Implement the same trace events as the C implementation.
>
> Notes:
> - Keep order of hpet_ram_write_invalid_tn_cmp and hpet_ram_write_tn_cmp
>   the same as the C implementation.
> - Put hpet_ram_write_timer_id in HPETTimer::write() instead of
>   HPETState::decode() so that reads can be excluded.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

LGTM but let's see what Zhao has to say also.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  rust/hw/timer/hpet/Cargo.toml    |  1 +
>  rust/hw/timer/hpet/meson.build   |  1 +
>  rust/hw/timer/hpet/src/device.rs | 45 +++++++++++++++++++-------------
>  3 files changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.tom=
l
> index f781b28d8b..5567eefda4 100644
> --- a/rust/hw/timer/hpet/Cargo.toml
> +++ b/rust/hw/timer/hpet/Cargo.toml
> @@ -18,6 +18,7 @@ bql =3D { path =3D "../../../bql" }
>  qom =3D { path =3D "../../../qom" }
>  system =3D { path =3D "../../../system" }
>  hwcore =3D { path =3D "../../../hw/core" }
> +trace =3D { path =3D "../../../trace" }
>
>  [lints]
>  workspace =3D true
> diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.bu=
ild
> index bb64b96672..465995bb5a 100644
> --- a/rust/hw/timer/hpet/meson.build
> +++ b/rust/hw/timer/hpet/meson.build
> @@ -11,6 +11,7 @@ _libhpet_rs =3D static_library(
>      qom_rs,
>      system_rs,
>      hwcore_rs,
> +    trace_rs
>    ],
>  )
>
> diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/de=
vice.rs
> index 3564aa79c6..90b0ae927c 100644
> --- a/rust/hw/timer/hpet/src/device.rs
> +++ b/rust/hw/timer/hpet/src/device.rs
> @@ -32,6 +32,8 @@
>
>  use crate::fw_cfg::HPETFwConfig;
>
> +::trace::include_trace!("hw_timer");
> +
>  /// Register space for each timer block (`HPET_BASE` is defined in hpet.=
h).
>  const HPET_REG_SPACE_LEN: u64 =3D 0x400; // 1024 bytes
>
> @@ -402,7 +404,8 @@ fn del_timer(&mut self) {
>
>      /// Configuration and Capability Register
>      fn set_tn_cfg_reg(&mut self, shift: u32, len: u32, val: u64) {
> -        // TODO: Add trace point - trace_hpet_ram_write_tn_cfg(addr & 4)
> +        trace::trace_hpet_ram_write_tn_cfg((shift / 8).try_into().unwrap=
());
> +
>          let old_val: u64 =3D self.config;
>          let mut new_val: u64 =3D old_val.deposit(shift, len, val);
>          new_val =3D hpet_fixup_reg(new_val, old_val, HPET_TN_CFG_WRITE_M=
ASK);
> @@ -435,17 +438,18 @@ fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, =
val: u64) {
>          let mut length =3D len;
>          let mut value =3D val;
>
> -        // TODO: Add trace point - trace_hpet_ram_write_tn_cmp(addr & 4)
>          if self.is_32bit_mod() {
>              // High 32-bits are zero, leave them untouched.
>              if shift !=3D 0 {
> -                // TODO: Add trace point - trace_hpet_ram_write_invalid_=
tn_cmp()
> +                trace::trace_hpet_ram_write_invalid_tn_cmp();
>                  return;
>              }
>              length =3D 64;
>              value =3D u64::from(value as u32); // truncate!
>          }
>
> +        trace::trace_hpet_ram_write_tn_cmp((shift / 8).try_into().unwrap=
());
> +
>          if !self.is_periodic() || self.is_valset_enabled() {
>              self.cmp =3D self.cmp.deposit(shift, length, value);
>          }
> @@ -512,6 +516,9 @@ const fn read(&self, reg: TimerRegister) -> u64 {
>
>      fn write(&mut self, reg: TimerRegister, value: u64, shift: u32, len:=
 u32) {
>          use TimerRegister::*;
> +
> +        trace::trace_hpet_ram_write_timer_id(self.index as u64);
> +
>          match reg {
>              CFG =3D> self.set_tn_cfg_reg(shift, len, value),
>              CMP =3D> self.set_tn_cmp_reg(shift, len, value),
> @@ -689,15 +696,13 @@ fn set_int_status_reg(&self, shift: u32, _len: u32,=
 val: u64) {
>      /// Main Counter Value Register
>      fn set_counter_reg(&self, shift: u32, len: u32, val: u64) {
>          if self.is_hpet_enabled() {
> -            // TODO: Add trace point -
> -            // trace_hpet_ram_write_counter_write_while_enabled()
> -            //
>              // HPET spec says that writes to this register should only b=
e
>              // done while the counter is halted. So this is an undefined
>              // behavior. There's no need to forbid it, but when HPET is
>              // enabled, the changed counter value will not affect the
>              // tick count (i.e., the previously calculated offset will
>              // not be changed as well).
> +            trace::trace_hpet_ram_write_counter_write_while_enabled();
>          }
>          self.counter
>              .set(self.counter.get().deposit(shift, len, val));
> @@ -787,11 +792,10 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HP=
ETAddrDecode<'_> {
>          } else {
>              let timer_id: usize =3D ((addr - 0x100) / 0x20) as usize;
>              if timer_id < self.num_timers {
> -                // TODO: Add trace point - trace_hpet_ram_[read|write]_t=
imer_id(timer_id)
>                  TimerRegister::try_from(addr & 0x18)
>                      .map(|reg| HPETRegister::Timer(&self.timers[timer_id=
], reg))
>              } else {
> -                // TODO: Add trace point -  trace_hpet_timer_id_out_of_r=
ange(timer_id)
> +                trace::trace_hpet_timer_id_out_of_range(timer_id.try_int=
o().unwrap());
>                  Err(addr)
>              }
>          };
> @@ -803,7 +807,8 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPET=
AddrDecode<'_> {
>      }
>
>      fn read(&self, addr: hwaddr, size: u32) -> u64 {
> -        // TODO: Add trace point - trace_hpet_ram_read(addr)
> +        trace::trace_hpet_ram_read(addr);
> +
>          let HPETAddrDecode { shift, reg, .. } =3D self.decode(addr, size=
);
>
>          use GlobalRegister::*;
> @@ -814,16 +819,21 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
>              Global(CFG) =3D> self.config.get(),
>              Global(INT_STATUS) =3D> self.int_status.get(),
>              Global(COUNTER) =3D> {
> -                // TODO: Add trace point
> -                // trace_hpet_ram_read_reading_counter(addr & 4, cur_tic=
k)
> -                if self.is_hpet_enabled() {
> +                let cur_tick =3D if self.is_hpet_enabled() {
>                      self.get_ticks()
>                  } else {
>                      self.counter.get()
> -                }
> +                };
> +
> +                trace::trace_hpet_ram_read_reading_counter(
> +                    (addr & 4) as u8,
> +                    cur_tick
> +                );
> +
> +                cur_tick
>              }
>              Unknown(_) =3D> {
> -                // TODO: Add trace point- trace_hpet_ram_read_invalid()
> +                trace::trace_hpet_ram_read_invalid();
>                  0
>              }
>          }) >> shift
> @@ -832,7 +842,8 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
>      fn write(&self, addr: hwaddr, value: u64, size: u32) {
>          let HPETAddrDecode { shift, len, reg } =3D self.decode(addr, siz=
e);
>
> -        // TODO: Add trace point - trace_hpet_ram_write(addr, value)
> +        trace::trace_hpet_ram_write(addr, value);
> +
>          use GlobalRegister::*;
>          use HPETRegister::*;
>          match reg {
> @@ -841,9 +852,7 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) =
{
>              Global(CFG) =3D> self.set_cfg_reg(shift, len, value),
>              Global(INT_STATUS) =3D> self.set_int_status_reg(shift, len, =
value),
>              Global(COUNTER) =3D> self.set_counter_reg(shift, len, value)=
,
> -            Unknown(_) =3D> {
> -                // TODO: Add trace point - trace_hpet_ram_write_invalid(=
)
> -            }
> +            Unknown(_) =3D> trace::trace_hpet_ram_write_invalid(),
>          }
>      }
>
> --
> 2.51.1
>

