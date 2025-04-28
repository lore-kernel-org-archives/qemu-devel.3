Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A8FC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9OnB-0000Pm-LB; Mon, 28 Apr 2025 09:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1u9Oft-0004GD-2J
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 09:37:42 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1u9Ofp-0001DU-R4
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 09:37:32 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d16a01deaso2826925e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 06:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745847447; x=1746452247; darn=nongnu.org;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/3gG/ZaE7DaiwKoxmsM3/UdNWWdxYHJtBxnwxmPe3k=;
 b=NqMw0zh562GAjJWO0FZZPoDDZfpfnDynNDNMi0UU2AJkTtl6zMAa9VLjboVTTerd3w
 5MI8zdIZyH3N8xLnxjMhf9ew+e863GDN54Zezt+PDzpIdfWqM9wueGuJclpUgnUVYl7q
 TKOaiHJtCTek5GguJXaoKSNtBpZzEuHIeWon6P9Z6zdAjkhEfirYaDLA2iVBJXszj8XZ
 mLvHwklUyTfsND8QeawjRxviepB30OzP8OpKx09mJvrCSmSdiNXWkIuTtxtIhNDn78NP
 gPSYsoj4xaiwEV5vjlmIIgXgkl904RFcKxZ66gGExAoKzaWm1OX7xcIZpbz6c2/8/Lym
 wG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745847447; x=1746452247;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G/3gG/ZaE7DaiwKoxmsM3/UdNWWdxYHJtBxnwxmPe3k=;
 b=dAMK0mr4kxTdIHbs/h0Fz2CTJCVY+wyN/UsZIw9zZ0PgcOshTIFcyiB1FvyrtvS+QI
 UOQcCTWKORT9gwqcUnd0vAiFJNK2H6dCL2EqXNA9zjFhSbFONvavza7gkTfyhL+pAJ9u
 hmf2MFdF0OeYRQbC2NRFPr9KSbqqHTCFiSydYWvjMv+W0AGg/sODJZKxYnf+NOEBEGC7
 BsFbwwp273yYfX3FLjjsmKHjbZONYiYpeEukSY5R8OG2TD5/TrgT2SrUpQwzE6n3lvt3
 /IPvFb11ow9GE/WdMYWQnQqFpibNipP5Z4lXVdmYYzuqgd9D7h8aLXDAZQh697TVuQGE
 u75g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7mOFLxRgE8KU0m+ZzDZHI8Vr//I/8dPfmws819tRo+5R+TZJ3PrGPzW1XsNmEirFyMsK4P0ix/ExS@nongnu.org
X-Gm-Message-State: AOJu0YxRkfLIKaXVt6yN8I4FtnKE1HYJrPbBSyVt2AWQNP0U2EJbuAEx
 GseNWwMlsaGOR6hMQBZ4dIml6Y3/MlNTo/Ga0W4nls0DywGI92ifWcJETVUU7OU=
X-Gm-Gg: ASbGncsuUOcQh/q7XeY/cNU92kVoPfb+DOxGF63D7k9socdTddhOx3HrYL20yarNcOT
 sL2KNJX3yjnc9tKFjZT2BWzyExGpKQEsBSKnavz2ELG6Ix3GfZqRHWtMFR5xJj+fIW2QlbHsHrF
 TcSvy5dfxP6zOEUG7McjtmjKXuLuuftSWHm2pYqflfF3J7zR3h68SNrqdhxsPlDSQ1RTrb59mSM
 SoNSMDVSJLPEGWEutWF75F1ZpjR8+IbSNNQ7VZEB/zUqOLNg2nNWpx4H6tzZdLWwSXaVE9SbNtz
 lpqz1TTogiZaKI9DKGdweiQhoQfANGCMLIYS8igYIsxplxk=
X-Google-Smtp-Source: AGHT+IEnTFNJ18fmzAaiDVTJ4NKdELQHx/MVKWGT4I2VMPcsz5zkPws0tQ5PTK712u+S0Bq393mnSg==
X-Received: by 2002:a05:6000:4210:b0:3a0:87f1:1900 with SMTP id
 ffacd0b85a97d-3a087f125b0mr442850f8f.2.1745847447041; 
 Mon, 28 Apr 2025 06:37:27 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:785:f3a7:1fbb:6b76])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ccb8e1sm11345667f8f.59.2025.04.28.06.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 06:37:26 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Apr 2025 15:37:26 +0200
Message-Id: <D9IB9OMTGUZ7.8UBDDIX7RW0J@ventanamicro.com>
To: "Andrew Jones" <ajones@ventanamicro.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH] target/riscv: add satp mode for kvm host cpu
Cc: "Meng Zhuo" <mengzhuo@iscas.ac.cn>, <qemu-devel@nongnu.org>,
 <qemu-riscv@nongnu.org>, "Alistair Francis" <alistair.francis@wdc.com>,
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, "Weiwei Li"
 <liwei1518@gmail.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Daniel
 Henrique Barboza" <dbarboza@ventanamicro.com>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
References: <20250427132557.1589276-1-mengzhuo@iscas.ac.cn>
 <20250428-00fc862d2d2d628ffa4c8547@orel>
 <D9I60P8TG036.2ZHSS9EHW4W8N@ventanamicro.com>
 <20250428-4cb96c7f0226e15a40006dee@orel>
In-Reply-To: <20250428-4cb96c7f0226e15a40006dee@orel>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Apr 2025 09:44:41 -0400
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

2025-04-28T14:08:59+02:00, Andrew Jones <ajones@ventanamicro.com>:
> On Mon, Apr 28, 2025 at 11:30:36AM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
>> 2025-04-28T09:00:55+02:00, Andrew Jones <ajones@ventanamicro.com>:
>> > On Sun, Apr 27, 2025 at 09:25:57PM +0800, Meng Zhuo wrote:
>> >> This patch adds host satp mode while kvm/host cpu satp mode is not
>> >> set.
>> >
>> > Huh, the KVM side[1] was written for this purpose, but it appears we n=
ever
>> > got a QEMU side merged.
>> >
>> > [1] commit 2776421e6839 ("RISC-V: KVM: provide UAPI for host SATP mode=
")
>>=20
>> KVM satp_mode is the current SATP.mode and I don't think the other
>> SATP.modes can generally be guessed from the host SATP mode.
>>=20
>> Can't QEMU use the host capabilities from cpuinfo or something?
>>=20
>> Do we need to return a bitmask from KVM?
>> (e.g. WARL all modes in vsatp and return what sticks.)
>>
>
> The widest supported is sufficient because all narrower must also be
> supported. Linux should be figuring out the widest and capturing that
> at boot time and we should be returing that info for the KVM satp_mode
> get-one-reg call.

Linux has command line overrides for the mode (no4lvl and no5vlv), so
the active mode in Linux might not be the widest supported by the cpu.

Let's say Linux decides to use 9 on a host cpu that has 0,8,9,10.
set_satp_mode_max_supported() will set supported vcpu modes to 0,8,9.

Should "-cpu host" contain the 10?

> If the satp_mode we're currently returning isn't the widest possible,
> then we should fix that in KVM.

The numbers are even more complicated... Pasting the values from manual:

  0      Bare
  1-7    Reserved for standard use
  8      Sv39
  9      Sv48
  10     Sv57
  11     Reserved for Sv64
  12-13  Reserved for standard use
  14-15  Designated for custom use

The reserved values make this extra juicy, let's say Linux uses 14 on
machine that has 0,8,9,14.  QEMU sees 14 and sets the vcpu modes to
0,8,9,10 -- it's not even a subset of the host CPU.
(There might be similar problems even with future standard extensions.)

