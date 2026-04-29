Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42792FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIESy-0007tP-Ij; Wed, 29 Apr 2026 19:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIESx-0007t6-76
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:37:15 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIESv-0002FV-M8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:37:14 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ba7fd666666so32190066b.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 16:37:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777505832; cv=none;
 d=google.com; s=arc-20240605;
 b=kgCey0qpZo2FOmZZJMgTOcup5nDGtA1B14PIFTC53W+G2AEfDOk0OmJ9P6HS562b+X
 kt78l1zxA0xeWCF+iQaFtqvnL8vjYqKoJF6tsQnRO9Taaqwj9MRxY5K5Q/yNkNcueB5r
 LAbODo3GABJbDV8bu4gN5c+n2z2fJl8O4XNyaUtDQU1/gPXNYTFTvWbe14t86C4m0AGx
 hcqJTjZWFBQ5DEAdlpojmCPv8+aalKxLuaqY9P4AEtD/MK8fDR9bXODFptCrog0M5RN5
 /j361SiNVwUY2Qo50PnWUPC1c4Nwm3WYgFqa6itnGFKHp7GP8ay7F+q6o3HzH3FRYEQp
 fbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mub2+O1X3RtXfg8okUF+TG3fKvkIazSgjByjjW6HPXI=;
 fh=xjLeGFzvjgB+c7Q7tLS1x/soEu6/H4TVNyjwYykFdaY=;
 b=HF9d2ipw+pxoA+JMYIG/9I4JD94w2Cdj00htEk2RkyxxomBioORzvKW5tY5tSbuUwJ
 i/nZpZKqJg1uxY1ievlbCaD9hoZHZv04Uah8+us+AC1aSWHVTBMcxgErPEfRj/nItfxm
 mKL+v6U6x9c/q727ZE4D16NpKrcykXYvAfZchNOZ2qPeQJrO2nh2e+vMIv9Vxnu/cuw1
 wskuS7/5RkDgNQUc3mdOVp6Mxyrp8/Cs4FfvWrGCW3ODrveHyK5E1q+Q2WYpNFkGMwbm
 q4iXI7Xx25f8NHNui7zYbWqLzGUiwTpP66+C8znELmyLwVpkjdDS5EnvJKHASYCFH32j
 Nrcw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777505832; x=1778110632; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mub2+O1X3RtXfg8okUF+TG3fKvkIazSgjByjjW6HPXI=;
 b=IDNaF9FYlGf4S6YOxXfvLhpubVzg7cIuYJglI6ru8i/9nSuXAqsISugIUsqQwWH8OO
 Q7wS9wAiynILxQp3eIsZU/u1R5JkHlvQbxKCaGrIRhEX0dwY05hI/Own2FJMxCIFSAZn
 +osqzkP5nvj1kcn2CpYrG3aJfraGem0DDfr48XmPSHMeAvrZExFO062k59g5RpapAFcg
 3Af4/5Hav9tlwsBSLr8gE0R5n7qS1147IISDADBaBq/MHg9Eii9CxEOLFHSTVcgntoXZ
 ohzoqUy1Vyu+QbP+8bEQqbUfwED9n/EyOcKpVsO8VbyLA4RCd1GpeQRbf/yMhVeZe+iE
 LUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777505832; x=1778110632;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mub2+O1X3RtXfg8okUF+TG3fKvkIazSgjByjjW6HPXI=;
 b=KqG09DW8vGZkL+egYtNuyOy4XcEiHK5LbFUahYUbW2yaXVBAs/J2hBxRGHUehVNgb8
 XTf7IGfcldLsqI0DJ+B+997hW5F9iHFVrEcACnvCYb9xoEeDNZUvc1Dc5Pss2CB+j3uq
 oeq7g36sM4rJP75eHLkTxp2ZZCFOmw7zqVDnXNhPFAwfY/hHQzTAckJBSyxt9Vt70vBW
 Ja8wSZal/zTy3+FHkqj0Q7PLkAWL/9lWNr1kABbp+SREaY0gp3FLqQOrrX/vR83p6cml
 ZF1t2QiKl7OvAIaxGWftD10CSsPO3hEAcRESy21iF89+2M34Wgov4I2fjvWQPcrkhrTO
 1q2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JybzPIWKUpWtqkREfzzqcZx9bE9qDx0CKTQCbH+NpRRk92JFgSdJSRw3jgs/+D44QSCqVN8iJhVUW@nongnu.org
X-Gm-Message-State: AOJu0YwewZt8IN5GAaLXDocyYeTFaXl0EtEuvddqy+A5PcpMQ4uFM2G1
 1DDCkAxXVi1aJC3uTf0ZGwfGZU84lwamUmuUBFdxyyOjNyAI3x2Nk+5MtXcsBt20TNBPTKJqpa2
 ayyqtVWG68+aQL8kREr9613k0jHyFM2U=
X-Gm-Gg: AeBDiesx53kVNG4RrKEO/0pMjZtc0rS0K5yNVV64T5bKK1EsVOL7jW8op3fG15YvfXU
 2awdjs2IgF62jOsRS2HCSV46P8mpcTuZzRwktpdmK0JRdk/KcifVpik0vzCnSHfWy1CbNjbyzhg
 QlpVzb7CwaKa1xFXQtUl5vLXXDHQVwNW6RYVO/uGcWfS8xGJuO+F3q6sJmOxNHE2jFJ3A0IKv91
 fssWsjiKDsIJS//MDhqBzedzdrgPv/J2t79xIue2QmiEVCD+LhN8f8uTeTegmZihxrqCIW4emkT
 wICGDPTBC/1l1x46p3OiIdE4+bIaeYALV75NeJMilkqvmzu8KuJY4xkTC4o=
X-Received: by 2002:a17:906:c156:b0:bad:f5dd:6740 with SMTP id
 a640c23a62f3a-bbac4cd1ef3mr45056066b.3.1777505832058; Wed, 29 Apr 2026
 16:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-8-joel@jms.id.au>
In-Reply-To: <20260425131721.932250-8-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 30 Apr 2026 09:36:45 +1000
X-Gm-Features: AVHnY4I_1Tji0AMwucUrsAVcZfe7cT-G30lRLLKTquS48N5mgqk-cFlX9kkcEmA
Message-ID: <CAKmqyKPU100u6R2JoLH=nRkocXMCOekCt=-=FR-pnfbSmoY_9Q@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] target/riscv: tt-ascalon: Enable Zkr extension
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x630.google.com
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

On Sat, Apr 25, 2026 at 11:21=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrot=
e:
>
> From: Nicholas Piggin <npiggin@gmail.com>
>
> Ascalon supports Zkr and the SEED CSR.

A datasheet would be nice to verify this

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ce15a17c37de..69649462dd89 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3190,6 +3190,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.ext_zba =3D true,
>          .cfg.ext_zbb =3D true,
>          .cfg.ext_zbs =3D true,
> +        .cfg.ext_zkr =3D true,
>          .cfg.ext_zkt =3D true,
>          .cfg.ext_zvbb =3D true,
>          .cfg.ext_zvbc =3D true,
> --
> 2.47.3
>
>

