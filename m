Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DEE106ACEE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nkd-0003aa-L9; Thu, 12 Mar 2026 17:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w0nkY-0003aQ-J2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:39:23 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w0nkX-0005ky-5M
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:39:22 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so11633365ad.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 14:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773351559; cv=none;
 d=google.com; s=arc-20240605;
 b=cUz4NfU9BZuNG6sbuv9iJqd2utM+2bVW3xbeXlUaM0OZI7GjhZW13fvTwiqjUfvjS9
 NZcWtNQTijzQl3MxRjjJ8cDwGbMGe0LuxwQJOb5qcOtasDxOArK/HxPeAtGws27egt1Q
 IPXUU7yaxvFFPjZ7cBXn9cS5MwiQC1zT+Qev97j5E7dh2V4XO7H0JVQsLhSawuU93mp9
 jsup903Nz5I4O+Ukd0H9rbwvlU4sWFkrC8rJiVAtweVh/2UOhIEk1fhvK7PGNGj4ZFLO
 I7kRDyCXzw2fxW825GBu3ZPCPHdnA5/U32XDSsvGIEhhpJoTcXE1YOIQOSyIuk++ndub
 7frQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GedSKUpVtNencDot4GjrlceiSenhLpU1OkQH6exKSnQ=;
 fh=KRCCjFQNjYXxmVm5lhBeSL8Cxa/V2Ufkjle/+cdDqO0=;
 b=Qj3xc8bqpy5oWvPq4K3CnKxoPjQ3njnIFxDwvSD2Qm431VcLS2+NNrdLhejKcCHrSK
 6DmZBgUe8/cUEGWidnle9cg7h300WjoTg+Ce38/xvoUTzxikQ4wQPfuHjyW/qDJqZ02r
 gRPUA6eE2fzP+Y0Zy7q9SAhFgBwoSKVtAzrnmFkvo74JzBwIrTfsrnvmSeJDm9hCGXNb
 Kt4Au7s3Fq6iXVWT+gEx/aq4ER+mNssBVLXM3S09PHTWSFSbxd+djUTceoisWNXGYgjP
 DxMnGW4EH0VK4iIf06OFKnx9/gfV7bTLcKTIpzh8frdIjA7DIaxehwO8nIzW1JDUClnl
 yjDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773351559; x=1773956359; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GedSKUpVtNencDot4GjrlceiSenhLpU1OkQH6exKSnQ=;
 b=Td/2SemuXvJpxa1Z2+r99zjyx55CQc0hvK7TfWpuflOmxoidUx/tsdpFNSRIAvTTyl
 o+bvYw0oZcxvN2/B6KY1/uH3ovgAOO47NZtkWP40OBThhvcM6YaVcof/7D9t+QXJZ38T
 K1cKWQIwO5Sq9E8/HisZXuacJacKbyurL+tf9J+8whY7XN+hjibMioCNpQUmm/2Wf3JH
 BPd15FIZdDc8n0Y6ObXpgAbC3KwTic494OMjs9D3g64rC2wG0JDNORkVNAZvF58sJvBP
 pJoCmDEryuPPf+h0YfATFIpgpJeq1iOCEyFyWcNYXKBz9YBWGIVKBhh/0+mHjdzjQR2l
 jjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773351559; x=1773956359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GedSKUpVtNencDot4GjrlceiSenhLpU1OkQH6exKSnQ=;
 b=jnSEDqfdYfA8FbETX8Bk5Te+xepz9Z4KZcQ35Curj75u/elPQTCGSIyeG955VjZKkU
 CWKv/pRqpJQPSyyh+tSLBYh5BklZOZi9Rchca+uLYmbqKolRSX+EtVqTMwUTLQ5rUxXE
 kV/WmCI51BDmtLqvW8dblgKv8uADLh7EdKIl0Ayw6wkwRO06uTvMtpkJjK6t2LKQb36j
 /wi3b5FfbVvE1CRGrfha+YOiD1YhgHrvCtzEiorni4vDbJCEGQszE03kLgKkL7Kur/Y2
 +Jqg+yo/zXt+qyZ+gi5W1811kydUyyTTcCJMxp1Ht/elRPGQcAKL2RbfUzlnzm8gWstV
 LbHw==
X-Gm-Message-State: AOJu0YxemHMeKdGW76Y0Qai4UpjqAjXjvtN7YUidoiytwZAxmO3DiLbE
 xkk2TQKc4GbRuIh0R6bJBhRa4VhLOCU/2T0lRri9Td/4Dgh9K7MXHvfTFDiY59sSc34hb8M1e3P
 /HrIQO5M6jO5St7jB5uKZZcqPSH1/opA=
X-Gm-Gg: ATEYQzwSJHqenMFLGshkFuf6fwU8XeS/0A/jaoIN60nvvlnoq7TWJ/oOvd5ALXgTpC8
 7w9KuR1LrFJjn4Tr2Mw4jBIguQfrGL6Y1B1myS8By+iyRhHPnDFuQS1WoQ3mIlvpPQaa4LmDFvF
 2ZAmA1KEuo8Ifw1uQ9r5PlODBKgEbWAHUEoMCx3BpTnUOs5KkxNXkz2X9yPF7rLpLmB5FIFj4bQ
 UkkbWp8TdX20Ar9IKT9KZF8TsRbtDNZqDlzYhBvaa0h2+OBCmu69CdLvc0qFV8W3rlu8WUtvdL0
 JslQuoNMvicHc08evypBR9pA6VXw+59NLcu3GQ==
X-Received: by 2002:a17:903:2283:b0:2ae:c5b2:6a41 with SMTP id
 d9443c01a7336-2aecac84adamr7981045ad.52.1773351559148; Thu, 12 Mar 2026
 14:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-5-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Thu, 12 Mar 2026 15:39:07 -0600
X-Gm-Features: AaiRm51919AAlgdpz_kncChA3GcZ1aA87n3_FiCMjE4EHWJL5KIP26iTWSP9750
Message-ID: <CAATN3NocnCB3vNU9N2pQUUt-nX5aXxMvjM+gRrcd_6MgThN=YA@mail.gmail.com>
Subject: Re: [PATCH v3 04/32] target/hexagon: Implement modify SSR
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000beb8af064cda959d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000beb8af064cda959d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> The per-vCPU System Status Register controls many modal behaviors of the
> system architecture.  When the SSR is updated, we trigger the necessary
> effects for interrupts, privilege/MMU, and HVX context mapping.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000beb8af064cda959d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 10:08=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mai=
lto:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
The per-vCPU System Status Register controls many modal behaviors of the<br=
>
system architecture.=C2=A0 When the SSR is updated, we trigger the necessar=
y<br>
effects for interrupts, privilege/MMU, and HVX context mapping.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu_helper.c | 33 ++++++++++++++++++++++++++++++++-<br=
>
=C2=A01 file changed, 32 insertions(+), 1 deletion(-)<br></blockquote><div>=
<br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsim=
pson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;=C2=A0</div></div></div>

--000000000000beb8af064cda959d--

