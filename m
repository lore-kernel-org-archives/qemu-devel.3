Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F42CCF2D4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIcw0-0003HR-1T; Sun, 18 Oct 2026 22:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xIcvy-0003Fh-NB
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:17:06 -0400
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xIcvx-0000tI-07
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:17:06 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 598811D00167
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 22:17:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Sun, 18 Oct 2026 22:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1792376224; x=1792462624; bh=tKFJMMISpVFzMIhx/1zsF2ujdEw3CBi8
 YejptbD2rys=; b=sN2kcskNANkEHUbuHh2evCM1ZAAbIe92MaV+762noeWOcoDV
 uxPY2pEqLbaB40qVHv2Zv10x4QQ1w9almn7B5ONdMEy9YIBYcBpBDoML4VwNmI9P
 4mwmZRBb6bKyI/ldd/dqTVxdh3HILpcmTOXUhnl0E0YCLjRGpuuuQowlHw00nIDY
 tsPzwjs22OUNUcyNtny5wc71TFLtRkv9aSUFE6wlIUU+5uqMeSbQK2jPlc6iefVo
 2DeunOgrsrjhWWkwBvv1YE5YT35IyAuJe3PRE5mxTMrEuSxWQXdsDTOWQVFyvSb5
 08J6PI+0Ug4jeM34cNihxEy990uO5VgZoCy+PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792376224; x=
 1792462624; bh=tKFJMMISpVFzMIhx/1zsF2ujdEw3CBi8YejptbD2rys=; b=c
 r8s2kuM9TDbTNGG8ni395Cb88Vq750h260w+37ihe8MUX3RhCurRIknQ0mhghtsg
 uWR5R8UivEeQSlwhE3i6DicsO0WC/iMPNbocTIObLAKschqrI0R5mfiIvIEwkisb
 1UP5JqUaAV/7O46+p2pW/9HvE3/XfoC8ujtAVxVJ4yf14M8H36qTQvW6hCr2jn2G
 lSuD7iMRg7RPyWUBkaJ+7HfnAgkyLFOgy84U7PwO9uRKV7sCsR7maCBx/KrKwqDH
 v40wZKCOTqt6kiO6zLhW25UPY+KxbX4yLYZZ3FtY0HWN/At3bj5x9t0lGCS0MDGs
 1qHaMiJhYZ60K8pAm9RFQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792376224; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:hg55aUnGPJ+FyD4H87stK6xcWJJGwjRmoU+ONpgoBQGwPE7
 uPKNCyVW3yEIbp/Sn+CIn5FucSnqI/NhykgH0CqLvIOTERk5KKlruwZ1bSJL6lNH
 UOUtCp1UIGYmHULXLoCB5Q/C0jYu+prLkCbO2gCpB0ZvVbNMFoP6XCNniG+2PVuO
 OP0wyEQSc/QW5SawqbWT7JmUkdbqXLsReECg5334Ub/jtlVm8WtIIVgv6n9Dscas
 R+btHog5aYIK8IaEc4SqXNkC4jly5vG9n2fCm5LOf4IvrtOln9x2J9WQZHTtCB9/
 sLqqcuvbGFtJXBpItP+Sh7klw160zM58GCAmD4Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:lzNfvqXKvoYfiRteBDlClxjvJYsb89RTP9Bhw6+QVAI=:tKFJMMISpVFzMIhx/1zsF2ujdEw3CBi8YejptbD2rys=;
X-ME-Sender: <xms:oH3VapRem0fFphiog91DuHDIU1Lo8rIlx8IdkrjrivZlDTloVLf3Qg>
 <xme:oH3VattbwCtwKlzUNSRoGGhO5dGmFUxHn1wteo2rCpb-nYRw85f8IiUeJc7Cl5Y3U
 MbrMHqPKsaYShvEIrTc6RLTts-UGsz4RsS_id1tVA000rHMMAjRtDz0>
X-ME-Received: <xmr:oH3Vat1UWhlNqVrsUUcqaTfDCzVClrhxD9GmtOFQUSpAjHIkrMIVpNIPuQz-D5ObnucnPDiTxhCwDzGWsqBLy6d0ZVE>
X-ME-Proxy-Cause: dmFkZTFH76OiklhVB486NxgGhiAQqye1q1W8LFcwGsskRWIo5MXYDe0cuWeyDh+ETWofYk
 qsG3xMbCQVn3rjciC4HJ0yP17e8nWPSVT3Z3iDcKGLITZZCyThWKgfVx/S4bGT8hk3rtvm
 ohSTD5Ynw4a5oGO2FSj3cm4/2WunGauBF/1VqXd2lyi102XE18ImVdEuxh8b3iL16HLFk1
 s2jJQozuOiS+QP5zlLbZU/BFK4ARX/xTn+0vJMvNdgI1Z/wxee7SFlwwr+vuO5gt8zdDNj
 iklehGi4XyFTJAJ+BHf1FTKXhGFJ+mEEN+17zHkwywboX2tG8ku3RcyR8ilR587A1wkONJ
 qfXYtNpANhwdXY19h8mcF3L61+OqRbbsYrt3eOVFH/erw+onRbZ6Xj+yhc9HbDc9v0s5TY
 wySfdNEO09tQoYdUvaBx44iVEj1hiu9LQPY7XINIt33lA75iZcN4RlvNl+U4r8iyyOrFrO
 URLX/zBnHcw/Wk+02xRkE/tk1Suk3zkNrtokSqYS4nZ5sd+LeFmsZEdsX8YsrQcCchY+ir
 8knxpEbct6u0w73tXw9XZvlanV+7J3jRUF418SSdmhbAbeJWjAxIGvgmmBFRC54HhRRJ63
 nfXnlWhhy1iwOmDGthcLh6W7pMGxplg4o2h+j1qU7XD6CIFY+eRoZHHojDdg
X-ME-Proxy: <xmx:oH3VamW0PtQxXPxzu2xQ-U5-OWNZLkena9U_9IQ1KIHEp9HDpQcHfA>
 <xmx:oH3VagJpJYN1qTQ055_ItaXEvk8tkln4YdlVGacw_QukW2XMecgcuw>
 <xmx:oH3Vag3wzItFZxHehYGEh_YK7BgbNGCyeLO3UfFyt1Bdg9EQJMj1xA>
 <xmx:oH3Vau63nn9Y4R87MaIa_UHMS5bDrP5YxlCuq14vFmCK5_PWfXyPvg>
 <xmx:oH3Vasjgh0wbyHaDdkAaPOsSWCSN6oU2GkIaTaHLkcbGNqRfYXJgkdMV>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Oct 2026 22:17:01 -0400 (EDT)
Message-ID: <3b276f47ed90b227f9afc0bdea7cd54f4d624d00.camel@alistair23.me>
Subject: Re: [PATCH 29/63] hw/char/cadence_uart: fix post_load return value
 for invalid baud rate
From: Alistair <alistair@alistair23.me>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Cc: Pavee Hui <phui@google.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Date: Mon, 19 Oct 2026 12:17:00 +1000
In-Reply-To: <20261004-issue-4560-v1-29-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
 <20261004-issue-4560-v1-29-ccbef537cbeb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.144;
 envelope-from=alistair@alistair23.me; helo=fout-b1-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Sun, 2026-10-04 at 14:23 +0400, Marc-Andr=C3=A9 Lureau wrote:
> post_load must return a negative errno on failure, but the BRGR/BDIV
> validation was returning 1 (positive), which the caller treats as
> success. Return -EINVAL instead.
>=20
> Reported-by: Pavee Hui <phui@google.com>
> Fixes: 6e29651c5e3a ("char: cadence: check baud rate generator and
> divider values")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0hw/char/cadence_uart.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
> index 1a065e2429eb..263c28bb7197 100644
> --- a/hw/char/cadence_uart.c
> +++ b/hw/char/cadence_uart.c
> @@ -594,8 +594,7 @@ static int cadence_uart_post_load(void *opaque,
> int version_id)
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Ensure these two aren't invalid numbers */
> =C2=A0=C2=A0=C2=A0=C2=A0 if (s->r[R_BRGR] < 1 || s->r[R_BRGR] & ~0xFFFF |=
|
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->r[R_BDIV] <=3D 3 || s=
->r[R_BDIV] & ~0xFF) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Value is invalid, abort */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 uart_parameters_setup(s);

