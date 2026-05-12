Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686C1CD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMcuE-0003g0-SL; Mon, 11 May 2026 22:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMcuC-0003f3-BK
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:31:32 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMcuA-0003Ci-TB
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:31:32 -0400
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-90d2acb9936so11493085a.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 19:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778553088; x=1779157888; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nhFP7hGs8ICqYOUqMML+hYb8Pw/MUz+qcAnPdAAtg8s=;
 b=PGOHDUdPRAhbc156rrc73Mh/ps2f3PMEpWh1vtvC9yQv8DZwu+Hy7sDXjK7oQOFblr
 K3Asg+F40zCHEzKnN2/VZngNL/KghxdIj086Slm5s/dYqlGALcSw9JZKZwZy4jPIx89e
 T2JfyWri4CD59qBm/5ao1uRLt5LZOaleRc3RtxUcFyN/T42w0UivVOGt44C0GWwtD0Mk
 CkhWQtWu+2bYaOL/kGqSb8e7znjBjLiRFxgK2YytBDVmamwHEN9A2l1liWkmyLRqRisx
 0xc48aHMEv+JnheH9MA3twVqSPRenvEgHh/x/WMqV6V3InwxkM50YNxOqOzSlCW7Dirz
 uULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778553088; x=1779157888;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nhFP7hGs8ICqYOUqMML+hYb8Pw/MUz+qcAnPdAAtg8s=;
 b=gN2nyWzjzxLz/O9p4jjcNeog9XzKdMtzCTj66j4uwZNBKyvoTDXwMjcoKE0phVNrW9
 6IVf3A37LD+T20gwwkyIhTCm8A5AYLY2SC8tDjMoon9OrDJEane5htlJMm8uQJX4GcSB
 eTk4v9gGaPkVblN9l6qc/oH1P+fA0LYDNPnZ4S04UhX6D5Nz8andEv0tDsCfylXRQB+Y
 Lk9JVpfTJrDvr57aIXCRffJiXgSdS/rGO4qJPUmNkeEPefoGQmRkrnBJtAaEhxQr/ulz
 42v9UM2cBsPX05VG+dq+9CsO7TAgpvo8xViC2V3vjUzEeTmwTmo8CumLN98WkhDSh+jT
 tkzA==
X-Gm-Message-State: AOJu0Yxo3cMs2yNwsCjKbAMI6UftZ8Mrifj3aEYnDRvO4irU1h9EoNlw
 D7G/CQo5t4sOyjfnc5Sf6cBDhljv9bYReQ80C3oMXsMDqYP1KiTqobbn
X-Gm-Gg: Acq92OEyZ6WhLN6Y/LMxwSUykPmL7cUg4xnqI9sgOZNCJ7ZFu1QbmhwVCc/B4fZXEjJ
 5drc5Du+pE9eyRM+y7VCIFNXqTFZLTTSVCYoL1CwQYN47Qeoy8Yd+i/jXSDqEMxcIURX+rvjbGj
 1wkmZVX4S4rFYVaN46Toki94GTQVeCozheSG5yOIP+JjTbvUMzTJtxO44SOUtcLxVsGuWVPot/q
 PwYvJ52BYi7r6CIjR6MnlCoimKFMgj/C9HKpUuDoAdcP0XVpb4Is0bm2HhCRTJ97UL2CBAwrbD4
 3z7qkLceXWitmZTEY6PWqdDlcoFEQQRxdPKg2YT5Dud2KdRLROa6NcyQqRze2HqIFBDTTPUbQ3P
 9l72Hq7XIoz7YtKx+myJrmvR3wBXZnGDET9B/7qYZStu4p17+qNJNfKPGGScXLw1co4BR/E9HoH
 mTrFKgLUTPS4JAVvxJPrgH2Z4OIHU9WUrB4dGktFperyxstsdDHFo+7hBVIFiyahrnYY8HPwrm
X-Received: by 2002:a05:620a:470c:b0:8f8:7765:27da with SMTP id
 af79cd13be357-904d66e27f4mr3853897885a.42.1778553088171; 
 Mon, 11 May 2026 19:31:28 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fc2c91e11fsm3186453285a.40.2026.05.11.19.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 19:31:27 -0700 (PDT)
Date: Tue, 12 May 2026 10:31:12 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com" <cfu@mips.com>,
 "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, 
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>, 
 "thuth@redhat.com" <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v9 1/7] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE
 bit masks
Message-ID: <agKQ4Gbo1nJNMxs4@ZEVORN-PC.localdomain>
References: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
 <20260511083819.206216-2-djordje.todorovic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511083819.206216-2-djordje.todorovic@htecgroup.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qk1-x741.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, May 11, 2026 at 08:38:27AM +0000, Djordje Todorovic wrote:
> Add the RISC-V privileged ISA defined bit positions for the Supervisor
> Big-Endian (SBE, bit 36) and Machine Big-Endian (MBE, bit 37) fields
> in the mstatus register. These are used alongside the existing
> MSTATUS_UBE (bit 6) to control data endianness at each privilege level.
> 
> The MSTATUS_UBE definition was already present, but SBE and MBE were
> missing.
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  target/riscv/cpu_bits.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index b62dd82fe7..c2a3ee4bf3 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -628,6 +628,8 @@
>  #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
>  #define MSTATUS_SPELP       0x00800000 /* zicfilp */
>  #define MSTATUS_SDT         0x01000000
> +#define MSTATUS_SBE         0x1000000000ULL
> +#define MSTATUS_MBE         0x2000000000ULL
>  #define MSTATUS_MPELP       0x020000000000 /* zicfilp */
>  #define MSTATUS_GVA         0x4000000000ULL
>  #define MSTATUS_MPV         0x8000000000ULL
> -- 
> 2.34.1

