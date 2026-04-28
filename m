Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89A6FF8867
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 03:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHZ7O-0000fb-K6; Mon, 27 Apr 2026 23:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHZ7E-0000fJ-Sa
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 23:28:05 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHZ7C-0001lQ-Dg
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 23:28:04 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bb662d56b5aso149466866b.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 20:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777346880; cv=none;
 d=google.com; s=arc-20240605;
 b=DtgC34XHRbEgsIZ5KgeBfQZJnBuH0C5ETBjYkIbElQRxRgpuFT8Ff8O76DRi1kmpfJ
 KDN94w+Db4M+ITisf60QhaH9hHq2z9vsNhhGhWAM6bIY/RPSvc4r4h0Xgjbb67f9QVvm
 TFytlcPtouJVXWNRtiYM5e//t1k8F+6nqhJT567bAFBcufPKC9wnFXUMNM2neJGqo4jt
 +zrbNx8/ppa0/rGzwqAbN/pEEiZC8FWHqo5/0AdpbC9Qa3bZUKRetbTHWfSAM+WW4f0z
 m0npDMpXvcHKCNU4oQw/k/f3KHwusyEQbv4oDMhAULCr9CoqwUsXTtBWmiteviw5am8O
 ggHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x5t7HPHDtXEVJ6HgKzKwemhTfsVPaNXzCBtDCQkipfg=;
 fh=CcR3C6UciAMzQsjP9eJH1hXnPzcf1tfpxRCDf0g8+j8=;
 b=NVKPr/lJAa8yuHNEY9Nve6khuGNb26dxnPxNEYOvgMFFZUVoc7AMQV64LFhEvWXkuP
 UCIgxg5bUytOUHDEeheT/kTXBrvBPd/g+eh057r7da9p5RrCWVfSeQ446dlvIjM/SA8H
 tAq/wi4qcWce8Ld3yK3HZk94sUp+4QoDdfTKGAw3oJd794SHmqLhTdzO78vLE6jt4EIq
 lOa0mCJ96TsJBRM2dz4YYzRaGjCYuPXjPSlKyiThhXFNERYB3eazOdso5Xo8rDw2wuqG
 /4ZELe5Jq8z0HtbQqQMsXyvWMfLeV6tTGeI1o4/Bx4U9E8xdWpDGHJ+chI6/aCxS2vTW
 Ih9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777346880; x=1777951680; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x5t7HPHDtXEVJ6HgKzKwemhTfsVPaNXzCBtDCQkipfg=;
 b=Xw1nGl1lE98EFLxlhyAN4ZZ7um2c/LrRzL6gNIOChDr7o3ijMba8VShjkybcc3toEG
 5JQ60iJvmCjT5KY1aikDgXiumY0vis0EBIE8FRQ5kCfo+CvSvibMU9Rncdr220n8xQEY
 i5FQUVpDlCDbjtBH07kinTnefNGyPRIzX5YvSsMnk7Njm/eiPxZoyrCYpwxWre0kM4qc
 GS923bCmEYdHXP5I4Y8/xsrdSIsPEmrOGredXVlxOaScz38Htlox26lNed5oGiVwqONp
 AIzkO9m/KVNj/T6U08TZDrkrLUbycKmej/gohhCKFFqWPXDuJujCEcjj+czWh4vYSVdb
 55/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777346880; x=1777951680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x5t7HPHDtXEVJ6HgKzKwemhTfsVPaNXzCBtDCQkipfg=;
 b=ndU+7v154B5YqZ17cow992IeKgBMmsdLNY1NpRaZsnmPLVUeyBl9K5d21+DFkVEv9h
 4RCNf3GY1WiJEazh5t4jOmONO3lOWcE2iuFfLpHXxC75p3pWhDpgFI2Al9YlCHWor7JH
 e4UiQgpCH1jDeXD5fOykux2RtvWcp3dcg6/8Sy0lf9CJB1PdG50mdgqxZyxSYLwGMKZF
 b74l01nUGOsUCiyohouEsA9HVd2ATjVuKCmk7CTdaTg3Yief/d46V+vW+LMDar2n+yMG
 dAl2JoJtuAhywdlvJWJo80hn7KNqYlPLfanbrsbRVJ7JlRFEi8S4el0ajk6SuGMyOzvk
 VoPA==
X-Gm-Message-State: AOJu0Yzwbk+hHzSO12Es1TgY7cz3uNaK0oRH/wLH8ELdIYNlQlS6ZgkA
 rB+eCZpzAtPpKHf2zTOzia2GvcqT4tQKqXZ0092Ij60O+XeTmhdpIMT6P8XqulFZBr8sRuYQY6Q
 8Ky//3dhSm+YG2MSbi0Io6pZ9xUgkugg=
X-Gm-Gg: AeBDieswjM3a4OuLA0W5xUoW8IZIHfSB6FYNWa+VryTXSNA0eNogIOu85PwMcMupm92
 gOJyv6ShRz6WLv4gmjQffSZdR3pWo6H472fPoLbw1HqACfvuSdhtkKRTIN23yMo3hyCCUhOVl9U
 3GwyDZBE01sa4PiAMiveGWatmdxRlUoqca8tXUnGz8TwnX8ORw5heb81H0LZ9gZTReM/RhMYbnN
 It4VH9Oui8vgko+z+EB3nEwMWSRel3IX8tSgawRc+YPgaH/oxtenTgyyqBCVa2xwv/jkoq7ea7D
 2Pry8Ym9HcnP0u8wgM6l9mTJbCn5Y1lleoYv+4xcWQwhxHVEtonhILXQ3Vo=
X-Received: by 2002:a17:907:86a9:b0:ba9:3f4a:1521 with SMTP id
 a640c23a62f3a-bb847f20815mr25909666b.19.1777346880229; Mon, 27 Apr 2026
 20:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260417120626.77415-1-antonb@tenstorrent.com>
In-Reply-To: <20260417120626.77415-1-antonb@tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Apr 2026 13:27:33 +1000
X-Gm-Features: AVHnY4IJAOr7BfHXQGAEo7xbBxDjjjjBXm6ppa4U1zfoqigXoTQjibB1J9a_hTA
Message-ID: <CAKmqyKN68wf-kTM1CtVidqY2s3iuS4VXnVDwn924cJB1mtcshA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: rvv: Handle mask/source overlap of vector
 reduction instructions
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 liujingqi@lanxincomputing.com, max.chou@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 17, 2026 at 10:08=E2=80=AFPM Anton Blanchard <antonb@tenstorren=
t.com> wrote:
>
> Masked vector reduction instructions must not use v0 as a source register=
.
> Check rs1 and rs2 against the mask register when vm=3D0.
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index d9a0027e0b..6e8d32636e 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3046,6 +3046,8 @@ static bool reduction_check(DisasContext *s, arg_rm=
rr *a)
>  {
>      return require_rvv(s) &&
>             vext_check_isa_ill(s) &&
> +           require_vm(a->vm, a->rs1) &&
> +           require_vm(a->vm, a->rs2) &&
>             vext_check_reduction(s, a->rs2);
>  }
>
> --
> 2.34.1
>
>

