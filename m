Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2464FC4451C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 08:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wl0Wm-0004TP-Tz; Sat, 18 Jul 2026 04:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wl0Wm-0004T9-2Q
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 04:36:08 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wl0Wk-0000TK-Ic
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 04:36:07 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-81ee6b2da98so26229967b3.3
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 01:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784363765; cv=none;
 d=google.com; s=arc-20260327;
 b=puz7HDwu1O6auaCqs4AzdD2Re6tMZFpeCD0UJE4khhNyYQF/pfjVMZ1qc85ZuCBrvK
 QZuoRlUGLj4OWp2D4RIpSNuwFdzU+WceMCTFPYUujeKCb40LCCeV9bqa35ZvZyA1cpNe
 YF3tqQ6tzQASw2EdbiuKEaOqI40oPAmLHbHnfAZoLIL14+BgN6t5rgDwHgAWBzKYMpYb
 FvJe8EDLX9fM2mNroLbWus/1I4ePH/TlOgsZJ970QkUjBAWbZS+z9DA15UHcu2laBYSs
 6FZDBfQG/46ePbqxDz4vcGGbcktVSp6Ig04aWjmWCj43UEW5BXra07vHumdij+GN85q7
 Qdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1bhdRA+bAZrwL/W/YVvs3hmG2rI0cukExJuEs58QV0A=;
 fh=UK46FRujlLSHd574zlUsGBGtMkrs+EaeweF9w4665qI=;
 b=NZq0Dt8FdmThP/TQv9YKESCj/Bq8i+2TjBTfkx/k4oxWtdnrEe1T+34l+onwv1t8oT
 NsgTSMGwMnrN+hij2Drjnx+AtEougtF7COCfSgZJF+SpFQgXlZTJVvxxzLsxnPc8jyVe
 kgTaz12GEP4QTZQqPzyMvVkzRIgAGpIWvL4nmvJDx+TzjIrrYJay3q1VhZ7Ro6aJqbnd
 puR0rZuwJAklaZi9vy0ZLfd0anAPnpHaog1mv8NhPslDa326yAOOvWCNYCBmLEJ8VgcI
 vgtOEXL732SwGqSSdltuYW1stVSHvnfuZGhAduduCp6uYmiawshQ2wjw7E+w4gfmDhb3
 Dw2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784363765; x=1784968565; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1bhdRA+bAZrwL/W/YVvs3hmG2rI0cukExJuEs58QV0A=;
 b=nDGYbfpwFQNxXCRPK1/ypB85KWDNNCLcYW2279ETW+zuwMPc9p9LUwadv47GgKu5uJ
 L4RTieDCu3A/8U4kLbV9XvAKJkRKSmy0ycet0TImmnQM+ItzKmwpp/Zffmz+u0wg9dGo
 ORCWC0//RJwlrMXpXw3sJgq3EXbPTAXFLJXnJXq1DINOZcbYm9fVWvuShO+eB3Kjx5e/
 3gJFv9pzN1bdZwiHCotmtM9u9rj4VtJpc7rkuMlplFeDLFuZbyuWXiKey/fvHPePEwaz
 nh2FgSM+MZHGrPhxDnW8XPL4x/sNK2SZ7EKYLKk9No4Wl8E7QS9+tgcNvkmO/m2F4j9V
 Aztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784363765; x=1784968565;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1bhdRA+bAZrwL/W/YVvs3hmG2rI0cukExJuEs58QV0A=;
 b=RahqLFyyKrPVrL/RPhO9339CyAQB8+VlIIRarKGUUclGcGG+Y3EeLt1WcsZWsiv6XM
 NxNHqKbqsemXHDM+UbXsI6XQM9Ox7T6k/BYWSnul1Kq8ItxqA+4pXCsd9BMzijNTDOgB
 mZLvTcGk3YkaMErHqQYaBSNOvDBYRNfjw2Z/k7fpF5TLUCip8TLVnAxV2u6V1xH9wZlc
 wbnB+S0EDKBJlScK51p0qMcEE5AvFzmIVJ4ctl/fW0IEj/qrauX1xJO+8Bg9B5rXWEGZ
 A9zKviCCTyC7lFgDL1WhXoyCCmnzAjCAjnowYH+QRoXBsfH5KAYWc2E6ex3sEC51JBl2
 vqQg==
X-Gm-Message-State: AOJu0YwKmAfsk4uhtdDz1Hm+EdSLByIJw02fnjvDl0XofqrOMlyYTGi6
 lt3bTLZoKffNeFwcIhOEOIC9YXrCAInReI3hdiRg9yKSOMUzfQbE1x4NN/AnqUQQJ5ubIq6VWP5
 illUV7xaMnVT3ChCib6GbLe4OO9f+dE6d+1UT0eXJ4w==
X-Gm-Gg: AfdE7cnWn7rTaCm8E/2fz6ffWP0zIckUL4C7iUE4LUjSOGl5YRyB02so/TQidMSQyK5
 7lgLZ29L3L9wR9ZCQlWiIVet25KtEmKFqLqeWsTT7lIoYtGPMK0biC14gi7P7ZcWeZGQ666QwFw
 bF/gxZBVnFK5QqDD7sZycgS8WCuDCjKd9vVZV2pBXUMMZ0EHTcaDsAJNOQBFLZ2pb7zcb6cymVu
 iAkP+BFAk1uUeMy+FGSkSOxXXjIgI6QM7UoSowaDlePp567LZh+/2ghgh/KeAUjKGjQ5d3cx2eE
 rqwq+e3wI7rZfv+IUnQ0UqjojHhMdMb+mU0I1asVKweBdQ==
X-Received: by 2002:a05:690c:6107:b0:81e:bbcd:f5c3 with SMTP id
 00721157ae682-81ef25e16eamr20044647b3.36.1784363765260; Sat, 18 Jul 2026
 01:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260713064617.85374-1-jay.chang@sifive.com>
In-Reply-To: <20260713064617.85374-1-jay.chang@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Jul 2026 09:35:53 +0100
X-Gm-Features: AUfX_myELAvPEZOQ84O3IQo3tQ5Iritm3JvnM1UFUffMQLDNjrHx4iHCNzjBWr8
Message-ID: <CAFEAcA8B6aT3oSpB86Kxxkb6sFJ3GXf306UUtWhDsK8qrRw0EQ@mail.gmail.com>
Subject: Re: [PATCH] hw/net/xilinx_axienet: Fix PHY register 17 link status
 reporting
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, Jason Wang <jasowangio@gmail.com>, 
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 13 Jul 2026 at 07:46, Jay Chang <jay.chang@sifive.com> wrote:
>
> The Marvell 88E1111 PHY register 17 (PHY Specific Status Register)
> bit 10 reports real-time link status. Previously, this register
> returned a fixed value of 0x8800 with bit 10 always cleared,
> causing U-Boot to always detect "No link" even when the link
> was up.
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>  hw/net/xilinx_axienet.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 970732b162..9f5f65ecfa 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -103,6 +103,9 @@ static unsigned int tdk_read(struct PHY *phy, unsigned int req)
>          case 17:
>              /* Marvell PHY on many xilinx boards.  */
>              r = 0x8000; /* 1000Mb  */
> +            if (phy->link) {
> +                r |= 0x0400; /* Link is up */
> +            }
>              break;

This matches the Marvell PHY datasheet, so seems reasonable.

Applied to target-arm.next, thanks.

-- PMM

